local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local vRP = Proxy.getInterface("vRP")
local vRPclient = Tunnel.getInterface("vRP","vRP") -- server -> client tunnel
local Inventory = module("ERP-Veh", "cfg/cfg_inventory")
local Housing = module("ERP-Core", "cfg/cfg_homes")
local InventorySpamTrack = {} -- Stops inventory being spammed by users.
local LootBagEntities = {}
local InventoryCoolDown = {}
local houseName = ""


RegisterNetEvent('Inventory:FetchPersonalInventory')
AddEventHandler('Inventory:FetchPersonalInventory', function()
    local source = source
    if not InventorySpamTrack[source] then
        InventorySpamTrack[source] = true;
        local UserId = vRP.getUserId({source}) 
        local data = vRP.getUserDataTable({UserId})
        if data and data.inventory then
            local FormattedInventoryData = {}
            for i,v in pairs(data.inventory) do
                FormattedInventoryData[i] = {amount = v.amount, ItemName = vRP.getItemName({i}), Weight = vRP.getItemWeight({i})}
            end
            TriggerClientEvent('Inventory:FetchPersonalInventory', source, FormattedInventoryData, vRP.computeItemsWeight({data.inventory}), vRP.getInventoryMaxWeight({UserId}))
            InventorySpamTrack[source] = false;
        end
    end
end)


AddEventHandler('Inventory:RefreshInventory', function(source)
    local UserId = vRP.getUserId({source}) 
    local data = vRP.getUserDataTable({UserId})
    if data and data.inventory then
        local FormattedInventoryData = {}
        for i,v in pairs(data.inventory) do
            FormattedInventoryData[i] = {amount = v.amount, ItemName = vRP.getItemName({i}), Weight = vRP.getItemWeight({i})}
        end
        TriggerClientEvent('Inventory:FetchPersonalInventory', source, FormattedInventoryData, vRP.computeItemsWeight({data.inventory}), vRP.getInventoryMaxWeight({UserId}))
    end
end)

RegisterNetEvent('Inventory:GiveItem')
AddEventHandler('Inventory:GiveItem', function(itemId, itemLoc)
    local source = source
    if not itemId then  vRPclient.notify(source, {'~r~You need to select an item, first!'}) return end
    if itemLoc == "Plr" then
        vRP.RunGiveTask({source, itemId})
    else
        vRPclient.notify(source, {'~r~You need to have this item on you to give it.'})
    end
end)

RegisterNetEvent('Inventory:TrashItem')
AddEventHandler('Inventory:TrashItem', function(itemId, itemLoc)
    local source = source
    if not itemId then  vRPclient.notify(source, {'~r~You need to select an item, first!'}) return end
    if itemLoc == "Plr" then
        vRP.RunTrashTask({source, itemId})
    else
        vRPclient.notify(source, {'~r~You need to have this item on you to drop it.'})
    end
end)

RegisterServerEvent("ERP:flashLights")
AddEventHandler("ERP:flashLights", function(nearestVeh)
    local nearestVeh = nearestVeh
    TriggerClientEvent("ERP:flashCarLightsAlarm", -1, nearestVeh)

end) 

RegisterNetEvent('Inventory:FetchTrunkInventory')
AddEventHandler('Inventory:FetchTrunkInventory', function(spawnCode, vehid)
    local source = source
    local idz = NetworkGetEntityFromNetworkId(vehid)
    local user_id = vRP.getUserId({NetworkGetEntityOwner(idz)})
    if InventoryCoolDown[source] then vRPclient.notify(source, {'~r~The server is having trouble caching the boot linked with your ID. Please rejoin.'}) return end
    local carformat = "chest:u1veh_" .. spawnCode .. '|' .. user_id
    vRP.getSData({carformat, function(cdata)
        local processedChest = {};
        cdata = json.decode(cdata) or {}
        local FormattedInventoryData = {}
        for i, v in pairs(cdata) do
            FormattedInventoryData[i] = {amount = v.amount, ItemName = vRP.getItemName({i}), Weight = vRP.getItemWeight({i})}
        end
        local maxVehKg = Inventory.vehicle_chest_weights[spawnCode] or Inventory.default_vehicle_chest_weight
        TriggerClientEvent('Inventory:SendSecondaryInventoryData', source, FormattedInventoryData, vRP.computeItemsWeight({cdata}), maxVehKg)
    end})
end)

RegisterNetEvent('Jud:FetchHouseInventory')
AddEventHandler('Jud:FetchHouseInventory', function(nameHouse)
    local source = source
    houseName = nameHouse
    local user_id = vRP.getUserId({source})
    local homeformat = "chest:u" .. user_id .. "home" ..houseName
    vRP.getSData({homeformat, function(cdata)
        local processedChest = {};
        cdata = json.decode(cdata) or {}
        local FormattedInventoryData = {}
        for i, v in pairs(cdata) do
            FormattedInventoryData[i] = {amount = v.amount, ItemName = vRP.getItemName({i}), Weight = vRP.getItemWeight({i})}
        end
        local maxVehKg = Housing.chestsize[houseName] or 500
      
        TriggerClientEvent('Inventory:SendSecondaryInventoryData', source, FormattedInventoryData, vRP.computeItemsWeight({cdata}), maxVehKg)
    
    end})
end)



RegisterNetEvent('Inventory:UseItem')
AddEventHandler('Inventory:UseItem', function(itemId, itemLoc)
    local source = source
    if not itemId then    vRPclient.notify(source, {'~r~You need to select an item, first!'}) return end
    if itemLoc == "Plr" then
        vRP.RunInventoryTask({source, itemId})
        TriggerEvent('Inventory:RefreshInventory', source)
    else
        vRPclient.notify(source, {'~r~You need to have this item on you to use it.'})
    end
end)


RegisterNetEvent('Inventory:MoveItem')
AddEventHandler('Inventory:MoveItem', function(inventoryType, itemId, inventoryInfo, Lootbag)
    local source = source
    local UserId = vRP.getUserId({source}) 
    local data = vRP.getUserDataTable({UserId})
    if InventoryCoolDown[source] then vRPclient.notify(source, {'~r~Inventory Cooldown.'}) return end
    if not itemId then  vRPclient.notify(source, {'~r~You need to select an item, first!'}) return end
    if data and data.inventory then
        if inventoryInfo == nil then return end
        if inventoryType == "CarBoot" then
            local Quantity = parseInt(1)
            if Quantity then
                local carformat = "chest:u1veh_" .. inventoryInfo .. '|' .. UserId
                vRP.getSData({carformat, function(cdata)
                    cdata = json.decode(cdata) or {}
                    if cdata[itemId] and cdata[itemId].amount >= 1 then
                        local weightCalculation = vRP.getInventoryWeight({UserId})+vRP.getItemWeight({itemId})
                        if weightCalculation <= vRP.getInventoryMaxWeight({UserId}) then
                            if cdata[itemId].amount > 1 then
                                cdata[itemId].amount = cdata[itemId].amount - 1; 
                                vRP.giveInventoryItem({UserId, itemId, 1, true})
                            else 
                                cdata[itemId] = nil;
                                vRP.giveInventoryItem({UserId, itemId, 1, true})
                            end 
                            local FormattedInventoryData = {}
                            for i, v in pairs(cdata) do
                                FormattedInventoryData[i] = {amount = v.amount, ItemName = vRP.getItemName({i}), Weight = vRP.getItemWeight({i})}
                            end
                            local maxVehKg = Inventory.vehicle_chest_weights[inventoryInfo] or Inventory.default_vehicle_chest_weight
                            TriggerClientEvent('Inventory:SendSecondaryInventoryData', source, FormattedInventoryData, vRP.computeItemsWeight({cdata}), maxVehKg)
                            TriggerEvent('Inventory:RefreshInventory', source)
                            vRP.setSData({carformat, json.encode(cdata)})
                        else 
                            vRPclient.notify(source, {'~r~You do not have enough inventory space.'})
                        end
                    end
                end})
            end
        elseif inventoryType == "LootBag" then  
            if LootBagEntities[inventoryInfo] ~= nil then  
                if LootBagEntities[inventoryInfo].Items[itemId] then 
                    local weightCalculation = vRP.getInventoryWeight({UserId})+vRP.getItemWeight({itemId})
                    if weightCalculation <= vRP.getInventoryMaxWeight({UserId}) then
                        if LootBagEntities[inventoryInfo].Items[itemId] and LootBagEntities[inventoryInfo].Items[itemId].amount > 1 then
                            LootBagEntities[inventoryInfo].Items[itemId].amount = LootBagEntities[inventoryInfo].Items[itemId].amount - 1 
                            vRP.giveInventoryItem({UserId, itemId, 1, true})
                        else 
                            LootBagEntities[inventoryInfo].Items[itemId] = nil;
                            vRP.giveInventoryItem({UserId, itemId, 1, true})
                        end
                        local FormattedInventoryData = {}
                        for i, v in pairs(LootBagEntities[inventoryInfo].Items) do
                            FormattedInventoryData[i] = {amount = v.amount, ItemName = vRP.getItemName({i}), Weight = vRP.getItemWeight({i})}
                        end
                        local maxVehKg = 200
                        TriggerClientEvent('Inventory:SendSecondaryInventoryData', source, FormattedInventoryData, vRP.computeItemsWeight({LootBagEntities[inventoryInfo].Items}), maxVehKg)                
                        TriggerEvent('Inventory:RefreshInventory', source)
                    else 
                        vRPclient.notify(source, {'~r~You do not have enough inventory space.'})
                    end
                end
            else
                vRPclient.notify(source,{"~r~This item isn't available!"})
            end
        elseif inventoryType == "Housing" then
            local Quantity = parseInt(1)
            if Quantity then
                local homeformat = "chest:u" .. UserId .. "home" ..houseName
                vRP.getSData({homeformat, function(cdata)
                    cdata = json.decode(cdata) or {}
                    if cdata[itemId] and cdata[itemId].amount >= 1 then
                        local weightCalculation = vRP.getInventoryWeight({UserId})+vRP.getItemWeight({itemId})
                        if weightCalculation <= vRP.getInventoryMaxWeight({UserId}) then
                            if cdata[itemId].amount > 1 then
                                cdata[itemId].amount = cdata[itemId].amount - 1; 
                                vRP.giveInventoryItem({UserId, itemId, 1, true})
                            else 
                                cdata[itemId] = nil;
                                vRP.giveInventoryItem({UserId, itemId, 1, true})
                            end 
                            local FormattedInventoryData = {}
                            for i, v in pairs(cdata) do
                                FormattedInventoryData[i] = {amount = v.amount, ItemName = vRP.getItemName({i}), Weight = vRP.getItemWeight({i})}
                            end
                            local maxVehKg = Housing.chestsize[houseName] or 500
                            print(Housing.chestsize[houseName])
                            TriggerClientEvent('Inventory:SendSecondaryInventoryData', source, FormattedInventoryData, vRP.computeItemsWeight({cdata}), maxVehKg)
                            TriggerEvent('Inventory:RefreshInventory', source)
                            vRP.setSData({homeformat, json.encode(cdata)})
                        else 
                            vRPclient.notify(source, {'~r~You do not have enough inventory space.'})
                        end
                    end
                end})
            end
        elseif inventoryType == "Plr" then
            if not Lootbag then
                if data.inventory[itemId] then
                    if inventoryInfo == "home" then 
                        local homeFormat = "chest:u" .. UserId .. "home" ..houseName
                        vRP.getSData({homeFormat, function(cdata)
                            cdata = json.decode(cdata) or {}
                            if data.inventory[itemId] and data.inventory[itemId].amount >= 1 then
                                local weightCalculation = vRP.computeItemsWeight({cdata})+vRP.getItemWeight({itemId})
                                local maxVehKg = Housing.chestsize[houseName] or 500
                                if weightCalculation <= maxVehKg then
                                    if vRP.tryGetInventoryItem({UserId, itemId, 1, true}) then
                                        if cdata[itemId] then
                                        cdata[itemId].amount = cdata[itemId].amount + 1
                                        else 
                                            cdata[itemId] = {}
                                            cdata[itemId].amount = 1
                                        end
                                    end 
                                    local FormattedInventoryData = {}
                                    for i, v in pairs(cdata) do
                                        FormattedInventoryData[i] = {amount = v.amount, ItemName = vRP.getItemName({i}), Weight = vRP.getItemWeight({i})}
                                    end
                                    local maxVehKg = Housing.chestsize[houseName] or 500
                                    TriggerClientEvent('Inventory:SendSecondaryInventoryData', source, FormattedInventoryData, vRP.computeItemsWeight({cdata}), maxVehKg)
                                    TriggerEvent('Inventory:RefreshInventory', source)
                                    vRP.setSData({"chest:u" .. UserId .. "home" ..houseName, json.encode(cdata)})
                                else 
                                    vRPclient.notify(source, {'~r~You do not have enough inventory space.'})
                                end
                            end
                        end}) --end of housing intergration (moveitem)
                    else
                        local carformat = "chest:u1veh_" .. inventoryInfo .. '|' .. UserId
                        vRP.getSData({carformat, function(cdata)
                            cdata = json.decode(cdata) or {}
                            if data.inventory[itemId] and data.inventory[itemId].amount >= 1 then
                                local weightCalculation = vRP.computeItemsWeight({cdata})+vRP.getItemWeight({itemId})
                                local maxVehKg = Inventory.vehicle_chest_weights[inventoryInfo] or Inventory.default_vehicle_chest_weight
                                if weightCalculation <= maxVehKg then
                                    if vRP.tryGetInventoryItem({UserId, itemId, 1, true}) then
                                        if cdata[itemId] then
                                        cdata[itemId].amount = cdata[itemId].amount + 1
                                        else 
                                            cdata[itemId] = {}
                                            cdata[itemId].amount = 1
                                        end
                                    end 
                                    local FormattedInventoryData = {}
                                    for i, v in pairs(cdata) do
                                        FormattedInventoryData[i] = {amount = v.amount, ItemName = vRP.getItemName({i}), Weight = vRP.getItemWeight({i})}
                                    end
                                    local maxVehKg = Inventory.vehicle_chest_weights[inventoryInfo] or Inventory.default_vehicle_chest_weight
                                    TriggerClientEvent('Inventory:SendSecondaryInventoryData', source, FormattedInventoryData, vRP.computeItemsWeight({cdata}), maxVehKg)
                                    TriggerEvent('Inventory:RefreshInventory', source)
                                    vRP.setSData({carformat, json.encode(cdata)})
                                else 
                                    vRPclient.notify(source, {'~r~You do not have enough inventory space.'})
                                end
                            end
                        end})
                    end
                end
            end
        end
    end
end)



RegisterNetEvent('Inventory:MoveItemX')
AddEventHandler('Inventory:MoveItemX', function(inventoryType, itemId, inventoryInfo, Lootbag)
    local source = source
    local UserId = vRP.getUserId({source}) 
    local data = vRP.getUserDataTable({UserId})
    if InventoryCoolDown[source] then vRPclient.notify(source, {'~r~Inventory Cooldown.'}) return end
    if not itemId then  vRPclient.notify(source, {'~r~You need to select an item, first!'}) return end
    if data and data.inventory then
        if inventoryInfo == nil then return end
        if inventoryType == "CarBoot" then
            TriggerClientEvent('Inventory:ToggleNUIFocus', source, false)
            vRP.prompt({source, 'How many ' .. vRP.getItemName({itemId}) .. 's. Do you want to move?', "", function(player, Quantity)
                Quantity = parseInt(Quantity)
                TriggerClientEvent('Inventory:ToggleNUIFocus', source, true)
                if Quantity >= 1 then
                    local carformat = "chest:u1veh_" .. inventoryInfo .. '|' .. UserId
                    vRP.getSData({carformat, function(cdata)
                        cdata = json.decode(cdata) or {}
                        if cdata[itemId] and Quantity <= cdata[itemId].amount  then
                            local weightCalculation = vRP.getInventoryWeight({UserId})+(vRP.getItemWeight({itemId}) * Quantity)
                            if weightCalculation <= vRP.getInventoryMaxWeight({UserId}) then
                                if cdata[itemId].amount > Quantity then
                                    cdata[itemId].amount = cdata[itemId].amount - Quantity; 
                                    vRP.giveInventoryItem({UserId, itemId, Quantity, true})
                                else 
                                    cdata[itemId] = nil;
                                    vRP.giveInventoryItem({UserId, itemId, Quantity, true})
                                end 
                                local FormattedInventoryData = {}
                                for i, v in pairs(cdata) do
                                    FormattedInventoryData[i] = {amount = v.amount, ItemName = vRP.getItemName({i}), Weight = vRP.getItemWeight({i})}
                                end
                                local maxVehKg = Inventory.vehicle_chest_weights[inventoryInfo] or Inventory.default_vehicle_chest_weight
                                TriggerClientEvent('Inventory:SendSecondaryInventoryData', source, FormattedInventoryData, vRP.computeItemsWeight({cdata}), maxVehKg)
                                TriggerEvent('Inventory:RefreshInventory', source)
                                vRP.setSData({carformat, json.encode(cdata)})
                            else 
                                vRPclient.notify(source, {'~r~You do not have enough inventory space.'})
                            end
                        else 
                            vRPclient.notify(source, {'~r~You are trying to move more then there actually is!'})
                        end
                    end})
                else
                    vRPclient.notify(source, {'~r~Invalid Amount!'})
                end
            end})
        elseif inventoryType == "LootBag" then 
            if LootBagEntities[inventoryInfo] ~= nil then  
                if LootBagEntities[inventoryInfo].Items[itemId] then 
                    TriggerClientEvent('Inventory:ToggleNUIFocus', source, false)
                    vRP.prompt({source, 'How many ' .. vRP.getItemName({itemId}) .. 's. Do you want to move?', "", function(player, Quantity)
                        Quantity = parseInt(Quantity)
                        TriggerClientEvent('Inventory:ToggleNUIFocus', source, true)
                        if Quantity then
                            local weightCalculation = vRP.getInventoryWeight({UserId})+(vRP.getItemWeight({itemId}) * Quantity)
                            if weightCalculation <= vRP.getInventoryMaxWeight({UserId}) then
                                if Quantity <= LootBagEntities[inventoryInfo].Items[itemId].amount then 
                                    if LootBagEntities[inventoryInfo].Items[itemId] and LootBagEntities[inventoryInfo].Items[itemId].amount > Quantity then
                                        LootBagEntities[inventoryInfo].Items[itemId].amount = LootBagEntities[inventoryInfo].Items[itemId].amount - Quantity
                                        vRP.giveInventoryItem({UserId, itemId, Quantity, true})
                                    else 
                                        LootBagEntities[inventoryInfo].Items[itemId] = nil;
                                        vRP.giveInventoryItem({UserId, itemId, Quantity, true})
                                    end
                                    local FormattedInventoryData = {}
                                    for i, v in pairs(LootBagEntities[inventoryInfo].Items) do
                                        FormattedInventoryData[i] = {amount = v.amount, ItemName = vRP.getItemName({i}), Weight = vRP.getItemWeight({i})}
                                    end
                                    local maxVehKg = 200
                                    TriggerClientEvent('Inventory:SendSecondaryInventoryData', source, FormattedInventoryData, vRP.computeItemsWeight({LootBagEntities[inventoryInfo].Items}), maxVehKg)                
                                    TriggerEvent('Inventory:RefreshInventory', source)
                                else 
                                    vRPclient.notify(source, {'~r~You are trying to move more then there actually is!'})
                                end 
                            else 
                                vRPclient.notify(source, {'~r~You do not have enough inventory space.'})
                            end
                        else 
                            vRPclient.notify(source, {'~r~Invalid input!'})
                        end
                    end})
                else
                    vRPclient.notify(source,{"~r~This item isn't available!"})
                end
            end
        elseif inventoryType == "Housing" then
            TriggerClientEvent('Inventory:ToggleNUIFocus', source, false)
            vRP.prompt({source, 'How many ' .. vRP.getItemName({itemId}) .. 's. Do you want to move?', "", function(player, Quantity)
                Quantity = parseInt(Quantity)
                TriggerClientEvent('Inventory:ToggleNUIFocus', source, true)
                if Quantity then
                    local homeformat = "chest:u" .. UserId .. "home" ..houseName
                    vRP.getSData({homeformat, function(cdata)
                        cdata = json.decode(cdata) or {}
                        if cdata[itemId] and Quantity <= cdata[itemId].amount  then
                            local weightCalculation = vRP.getInventoryWeight({UserId})+(vRP.getItemWeight({itemId}) * Quantity)
                            if weightCalculation <= vRP.getInventoryMaxWeight({UserId}) then
                                if cdata[itemId].amount > Quantity then
                                    cdata[itemId].amount = cdata[itemId].amount - Quantity; 
                                    vRP.giveInventoryItem({UserId, itemId, Quantity, true})
                                else 
                                    cdata[itemId] = nil;
                                    vRP.giveInventoryItem({UserId, itemId, Quantity, true})
                                end 
                                local FormattedInventoryData = {}
                                for i, v in pairs(cdata) do
                                    FormattedInventoryData[i] = {amount = v.amount, ItemName = vRP.getItemName({i}), Weight = vRP.getItemWeight({i})}
                                end
                                local maxVehKg = Housing.chestsize[houseName] or 500
                                TriggerClientEvent('Inventory:SendSecondaryInventoryData', source, FormattedInventoryData, vRP.computeItemsWeight({cdata}), maxVehKg)
                                TriggerEvent('Inventory:RefreshInventory', source)
                                vRP.setSData({"chest:u" .. UserId .. "home" ..houseName, json.encode(cdata)})
                            else 
                                vRPclient.notify(source, {'~r~You do not have enough inventory space.'})
                            end
                        else 
                            vRPclient.notify(source, {'~r~You are trying to move more then there actually is!'})
                        end
                    end})
                else 
                    vRPclient.notify(source, {'~r~Invalid input!'})
                end
            end})
        elseif inventoryType == "Plr" then
            if not Lootbag then
                if data.inventory[itemId] then
                    TriggerClientEvent('Inventory:ToggleNUIFocus', source, false)
                    if inventoryInfo == "home" then --start of housing intergration (moveitemx)
                        TriggerClientEvent('Inventory:ToggleNUIFocus', source, false)
                        vRP.prompt({source, 'How many ' .. vRP.getItemName({itemId}) .. 's. Do you want to move?', "", function(player, Quantity)
                            Quantity = parseInt(Quantity)
                            TriggerClientEvent('Inventory:ToggleNUIFocus', source, true)
                            if Quantity then
                                local homeFormat = "chest:u" .. UserId .. "home" ..houseName
                                vRP.getSData({homeFormat, function(cdata)
                                    cdata = json.decode(cdata) or {}
                                    if data.inventory[itemId] and Quantity <= data.inventory[itemId].amount  then
                                        local weightCalculation = vRP.computeItemsWeight({cdata})+(vRP.getItemWeight({itemId}) * Quantity)
                                        local maxVehKg = Housing.chestsize[houseName] or 500
                                        if weightCalculation <= maxVehKg then
                                            if vRP.tryGetInventoryItem({UserId, itemId, Quantity, true}) then
                                                if cdata[itemId] then
                                                    cdata[itemId].amount = cdata[itemId].amount + Quantity
                                                else 
                                                    cdata[itemId] = {}
                                                    cdata[itemId].amount = Quantity
                                                end
                                            end 
                                            local FormattedInventoryData = {}
                                            for i, v in pairs(cdata) do
                                                FormattedInventoryData[i] = {amount = v.amount, ItemName = vRP.getItemName({i}), Weight = vRP.getItemWeight({i})}
                                            end
                                            local maxVehKg = Housing.chestsize[houseName] or 500
                                            TriggerClientEvent('Inventory:SendSecondaryInventoryData', source, FormattedInventoryData, vRP.computeItemsWeight({cdata}), maxVehKg)
                                            TriggerEvent('Inventory:RefreshInventory', source)
                                            vRP.setSData({"chest:u" .. UserId .. "home" ..houseName, json.encode(cdata)})
                                        else 
                                            vRPclient.notify(source, {'~r~You do not have enough inventory space.'})
                                        end
                                    else 
                                        vRPclient.notify(source, {'~r~You are trying to move more then there actually is!'})
                                    end
                                end})
                            else 
                                vRPclient.notify(source, {'~r~Invalid input!'})
                            end
                        end}) --end of housing intergration (moveitemx)
                    else
                        vRP.prompt({source, 'How many ' .. vRP.getItemName({itemId}) .. 's. Do you want to move?', "", function(player, Quantity)
                            Quantity = parseInt(Quantity)
                            TriggerClientEvent('Inventory:ToggleNUIFocus', source, true)
                            if Quantity then
                                local carformat = "chest:u1veh_" .. inventoryInfo .. '|' .. UserId
                                vRP.getSData({carformat, function(cdata)
                                    cdata = json.decode(cdata) or {}
                                    if data.inventory[itemId] and Quantity <= data.inventory[itemId].amount  then
                                        local weightCalculation = vRP.computeItemsWeight({cdata})+(vRP.getItemWeight({itemId}) * Quantity)
                                        local maxVehKg = Inventory.vehicle_chest_weights[inventoryInfo] or Inventory.default_vehicle_chest_weight
                                        if weightCalculation <= maxVehKg then
                                            if vRP.tryGetInventoryItem({UserId, itemId, Quantity, true}) then
                                                if cdata[itemId] then
                                                    cdata[itemId].amount = cdata[itemId].amount + Quantity
                                                else 
                                                    cdata[itemId] = {}
                                                    cdata[itemId].amount = Quantity
                                                end
                                            end 
                                            local FormattedInventoryData = {}
                                            for i, v in pairs(cdata) do
                                                FormattedInventoryData[i] = {amount = v.amount, ItemName = vRP.getItemName({i}), Weight = vRP.getItemWeight({i})}
                                            end
                                            local maxVehKg = Inventory.vehicle_chest_weights[inventoryInfo] or Inventory.default_vehicle_chest_weight
                                            TriggerClientEvent('Inventory:SendSecondaryInventoryData', source, FormattedInventoryData, vRP.computeItemsWeight({cdata}), maxVehKg)
                                            TriggerEvent('Inventory:RefreshInventory', source)
                                            --InventoryCoolDown[source] = nil;
                                            vRP.setSData({carformat, json.encode(cdata)})
                                        else 
                                            --InventoryCoolDown[source] = nil;
                                            vRPclient.notify(source, {'~r~You do not have enough inventory space.'})
                                        end
                                    else 
                                        --InventoryCoolDown[source] = nil;
                                        vRPclient.notify(source, {'~r~You are trying to move more then there actually is!'})
                                    end
                                end})
                            else 
                                vRPclient.notify(source, {'~r~Invalid input!'})
                            end
                        end})
                    end
                end
            end
        end 
    end
end)


RegisterNetEvent('Inventory:MoveItemAll')
AddEventHandler('Inventory:MoveItemAll', function(inventoryType, itemId, inventoryInfo, vehid)
    local source = source
    local UserId = vRP.getUserId({source}) 
    local data = vRP.getUserDataTable({UserId})
    if not itemId then  vRPclient.notify(source, {'~r~You need to select an item, first!'}) return end
    if InventoryCoolDown[source] then vRPclient.notify(source, {'~r~Inventory Cooldown.'}) return end
    if data and data.inventory then
        if inventoryInfo == nil then return end
        if inventoryType == "CarBoot" then
            local idz = NetworkGetEntityFromNetworkId(vehid)
            local user_id = vRP.getUserId({NetworkGetEntityOwner(idz)})
            local carformat = "chest:u1veh_" .. inventoryInfo .. '|' .. user_id
            vRP.getSData({carformat, function(cdata)
                cdata = json.decode(cdata) or {}
                if cdata[itemId] and cdata[itemId].amount <= cdata[itemId].amount  then
                    local weightCalculation = vRP.getInventoryWeight({user_id})+(vRP.getItemWeight({itemId}) * cdata[itemId].amount)
                    if weightCalculation <= vRP.getInventoryMaxWeight({user_id}) then
                        vRP.giveInventoryItem({user_id, itemId, cdata[itemId].amount, true})
                        cdata[itemId] = nil;
                        local FormattedInventoryData = {}
                        for i, v in pairs(cdata) do
                            FormattedInventoryData[i] = {amount = v.amount, ItemName = vRP.getItemName({i}), Weight = vRP.getItemWeight({i})}
                        end
                        local maxVehKg = Inventory.vehicle_chest_weights[inventoryInfo] or Inventory.default_vehicle_chest_weight
                        TriggerClientEvent('Inventory:SendSecondaryInventoryData', source, FormattedInventoryData, vRP.computeItemsWeight({cdata}), maxVehKg)
                        TriggerEvent('Inventory:RefreshInventory', source)
                        vRP.setSData({carformat, json.encode(cdata)})
                    else 
                        vRPclient.notify(source, {'~r~You do not have enough inventory space.'})
                    end
                else 
                    vRPclient.notify(source, {'~r~You are trying to move more then there actually is!'})
                end
            end})
        elseif inventoryType == "LootBag" then 
            if LootBagEntities[inventoryInfo] ~= nil then  
                if LootBagEntities[inventoryInfo].Items[itemId] then 
                    local weightCalculation = vRP.getInventoryWeight({UserId})+(vRP.getItemWeight({itemId}) *  LootBagEntities[inventoryInfo].Items[itemId].amount)
                    if weightCalculation <= vRP.getInventoryMaxWeight({UserId}) then
                        if  LootBagEntities[inventoryInfo].Items[itemId].amount <= LootBagEntities[inventoryInfo].Items[itemId].amount then 
                            vRP.giveInventoryItem({UserId, itemId, LootBagEntities[inventoryInfo].Items[itemId].amount, true})
                            LootBagEntities[inventoryInfo].Items[itemId] = nil;
                            local FormattedInventoryData = {}
                            for i, v in pairs(LootBagEntities[inventoryInfo].Items) do
                                FormattedInventoryData[i] = {amount = v.amount, ItemName = vRP.getItemName({i}), Weight = vRP.getItemWeight({i})}
                            end
                            local maxVehKg = 200
                            TriggerClientEvent('Inventory:SendSecondaryInventoryData', source, FormattedInventoryData, vRP.computeItemsWeight({LootBagEntities[inventoryInfo].Items}), maxVehKg)                
                            TriggerEvent('Inventory:RefreshInventory', source)
                        else 
                            vRPclient.notify(source, {'~r~You are trying to move more then there actually is!'})
                        end 
                    else 
                        vRPclient.notify(source, {'~r~You do not have enough inventory space.'})
                    end
                end
            else
                vRPclient.notify(source,{"~r~This item isn't available!"})
            end
        elseif inventoryType == "Housing" then
            local homeformat = "chest:u" .. UserId .. "home" ..houseName
            vRP.getSData({homeformat, function(cdata)
                cdata = json.decode(cdata) or {}
                if cdata[itemId] and cdata[itemId].amount <= cdata[itemId].amount  then
                    local weightCalculation = vRP.getInventoryWeight({UserId})+(vRP.getItemWeight({itemId}) * cdata[itemId].amount)
                    if weightCalculation <= vRP.getInventoryMaxWeight({UserId}) then
                        vRP.giveInventoryItem({UserId, itemId, cdata[itemId].amount, true})
                        cdata[itemId] = nil;
                        local FormattedInventoryData = {}
                        for i, v in pairs(cdata) do
                            FormattedInventoryData[i] = {amount = v.amount, ItemName = vRP.getItemName({i}), Weight = vRP.getItemWeight({i})}
                        end
                        local maxVehKg = Housing.chestsize[houseName] or 500
                        TriggerClientEvent('Inventory:SendSecondaryInventoryData', source, FormattedInventoryData, vRP.computeItemsWeight({cdata}), maxVehKg)
                        TriggerEvent('Inventory:RefreshInventory', source)
                        vRP.setSData({"chest:u" .. UserId .. "home" ..houseName, json.encode(cdata)})
                    else 
                        vRPclient.notify(source, {'~r~You do not have enough inventory space.'})
                    end
                else 
                    vRPclient.notify(source, {'~r~You are trying to move more then there actually is!'})
                end
            end})
        elseif inventoryType == "Plr" then
            if not Lootbag then
                if data.inventory[itemId] then
                    if inventoryInfo == "home" then --start of housing intergration (moveitemall)
                        local homeFormat = "chest:u" .. UserId .. "home" ..houseName
                        vRP.getSData({homeFormat, function(cdata)
                            cdata = json.decode(cdata) or {}
                            if data.inventory[itemId] and data.inventory[itemId].amount <= data.inventory[itemId].amount  then
                                local weightCalculation = vRP.computeItemsWeight({cdata})+(vRP.getItemWeight({itemId}) * data.inventory[itemId].amount)
                                local maxVehKg = Housing.chestsize[houseName] or 500
                                if weightCalculation <= maxVehKg then
                                    if vRP.tryGetInventoryItem({UserId, itemId, data.inventory[itemId].amount, true}) then
                                        if cdata[itemId] then
                                            cdata[itemId].amount = cdata[itemId].amount + data.inventory[itemId].amount
                                        else 
                                            cdata[itemId] = {}
                                            cdata[itemId].amount = data.inventory[itemId].amount
                                        end
                                    end 
                                    local FormattedInventoryData = {}
                                    for i, v in pairs(cdata) do
                                        FormattedInventoryData[i] = {amount = v.amount, ItemName = vRP.getItemName({i}), Weight = vRP.getItemWeight({i})}
                                    end
                                    local maxVehKg = Housing.chestsize[houseName] or 500
                                    TriggerClientEvent('Inventory:SendSecondaryInventoryData', source, FormattedInventoryData, vRP.computeItemsWeight({cdata}), maxVehKg)
                                    TriggerEvent('Inventory:RefreshInventory', source)
                                    vRP.setSData({"chest:u" .. UserId .. "home" ..houseName, json.encode(cdata)})
                                else 
                                    vRPclient.notify(source, {'~r~You do not have enough inventory space.'})
                                end
                            else 
                                vRPclient.notify(source, {'~r~You are trying to move more then there actually is!'})
                            end
                        end}) --end of housing intergration (moveitemall)
                    else 
                        local carformat = "chest:u1veh_" .. inventoryInfo .. '|' .. UserId
                        vRP.getSData({carformat, function(cdata)
                            cdata = json.decode(cdata) or {}
                            if data.inventory[itemId] and data.inventory[itemId].amount <= data.inventory[itemId].amount  then
                                local weightCalculation = vRP.computeItemsWeight({cdata})+(vRP.getItemWeight({itemId}) * data.inventory[itemId].amount)
                                local maxVehKg = Inventory.vehicle_chest_weights[inventoryInfo] or Inventory.default_vehicle_chest_weight
                                if weightCalculation <= maxVehKg then
                                    if vRP.tryGetInventoryItem({UserId, itemId, data.inventory[itemId].amount, true}) then
                                        if cdata[itemId] then
                                            cdata[itemId].amount = cdata[itemId].amount + data.inventory[itemId].amount
                                        else 
                                            cdata[itemId] = {}
                                            cdata[itemId].amount = data.inventory[itemId].amount
                                        end
                                    end 
                                    local FormattedInventoryData = {}
                                    for i, v in pairs(cdata) do
                                        FormattedInventoryData[i] = {amount = v.amount, ItemName = vRP.getItemName({i}), Weight = vRP.getItemWeight({i})}
                                    end
                                    local maxVehKg = Inventory.vehicle_chest_weights[inventoryInfo] or Inventory.default_vehicle_chest_weight
                                    TriggerClientEvent('Inventory:SendSecondaryInventoryData', source, FormattedInventoryData, vRP.computeItemsWeight({cdata}), maxVehKg)
                                    TriggerEvent('Inventory:RefreshInventory', source)
                                    --InventoryCoolDown[source] = nil;
                                    vRP.setSData({carformat, json.encode(cdata)})
                                else 
                                    vRPclient.notify(source, {'~r~You do not have enough inventory space.'})
                                end
                            else 
                                vRPclient.notify(source, {'~r~You are trying to move more then there actually is!'})
                            end
                        end})
                    end
                end
            end
        end
    end
end)


-- Loot bags 

RegisterNetEvent('vRP:InComa')
AddEventHandler('vRP:InComa', function()
    local source = source
    local user_id = vRP.getUserId({source})
    vRPclient.isInComa(source, {}, function(in_coma) 
        if in_coma then
            Wait(3000)
           
            local weight = vRP.getInventoryWeight({user_id})

            if vRP.hasPermission({user_id, "pd.armory"}) or weight == 0 then 
                return 
            end

            local model = GetHashKey('xs_prop_arena_bag_01')
            local name1 = GetPlayerName(source)
            local lootbag = CreateObjectNoOffset(model, GetEntityCoords(GetPlayerPed(source)) + 0.4, true, true, false)
            local lootbagnetid = NetworkGetNetworkIdFromEntity(lootbag)
            local ndata = vRP.getUserDataTable({user_id})
            local stored_inventory = nil;

            LootBagEntities[lootbagnetid] = {lootbag, lootbag, false, source}
            LootBagEntities[lootbagnetid].Items = {}
            LootBagEntities[lootbagnetid].name = name1 
         
            if ndata ~= nil then
                if ndata.inventory ~= nil then
                    stored_inventory = ndata.inventory
                    vRP.clearInventory({user_id})
                    for k, v in pairs(stored_inventory) do
                        LootBagEntities[lootbagnetid].Items[k] = {}
                        LootBagEntities[lootbagnetid].Items[k].amount = v.amount
                    end
                end
            end
        end
    end)
end)

RegisterNetEvent('vRP:LootBag')
AddEventHandler('vRP:LootBag', function(netid)
    local source = source
    vRPclient.isInComa(source, {}, function(in_coma) 
        if not in_coma then
            if LootBagEntities[netid] then
                LootBagEntities[netid][3] = true;
                local user_id = vRP.getUserId({source})
                if user_id ~= nil then
                    TriggerClientEvent("vrp:PlaySound", source, "zipper")
                    LootBagEntities[netid][5] = source

                    if vRP.hasPermission({user_id, "police.armoury"}) then
                        LootBagEntities[netid].Items = {}
                        vRPclient.notify(source,{"~r~You have seized " .. LootBagEntities[netid].name .. "'s items"})
                        OpenInv(source, netid, LootBagEntities[netid].Items)
                    else
                        OpenInv(source, netid, LootBagEntities[netid].Items)
                    end  
                end
            else
                vRPclient.notify(source, {'~r~This loot bag is unavailable.'})
            end
        else
            vRPclient.notify(source, {'~r~You cannot open this while dead silly.'})
        end
    end)
end)

Citizen.CreateThread(function()
    while true do 
        Wait(250)
        for i,v in pairs(LootBagEntities) do 
            if v[5] then 
                local coords = GetEntityCoords(GetPlayerPed(v[5]))
                local objectcoords = GetEntityCoords(v[1])
                if #(objectcoords - coords) > 5.0 then
                    CloseInv(v[5])
                    Wait(3000)
                    v[3] = false; 
                    v[5] = nil;
                end
            end
        end
    end
end)

RegisterNetEvent('Inventory:CloseLootbag')
AddEventHandler('Inventory:CloseLootbag', function()
    local source = source
    for i,v in pairs(LootBagEntities) do 
        if v[5] and v[5] == source then 
            CloseInv(v[5])
            Wait(3000)
            v[3] = false; 
            v[5] = nil;
        end
    end
end)

function CloseInv(source)
    TriggerClientEvent('Inventory:InventoryOpen', source, false, false)
end

function OpenInv(source, netid, LootBagItems)
    local UserId = vRP.getUserId({source})
    local data = vRP.getUserDataTable({UserId})
    if data and data.inventory then
        local FormattedInventoryData = {}
        for i,v in pairs(data.inventory) do
            FormattedInventoryData[i] = {amount = v.amount, ItemName = vRP.getItemName({i}), Weight = vRP.getItemWeight({i})}
        end
        TriggerClientEvent('Inventory:FetchPersonalInventory', source, FormattedInventoryData, vRP.computeItemsWeight({data.inventory}), vRP.getInventoryMaxWeight({UserId}))
        InventorySpamTrack[source] = false;
    end
    TriggerClientEvent('Inventory:InventoryOpen', source, true, true)
    local FormattedInventoryData = {}

    if vRP.hasPermission({UserId, "pd.armory"}) then
        for i,v in pairs(LootBagEntities) do 
            if DoesEntityExist(v[1]) then 
                DeleteEntity(v[1])
                LootBagEntities[i] = nil;
            end
        end
    else
        for i, v in pairs(LootBagItems) do
            FormattedInventoryData[i] = {amount = v.amount, ItemName = vRP.getItemName({i}), Weight = vRP.getItemWeight({i})}
        end
        local maxVehKg = 200
        TriggerClientEvent('Inventory:SendSecondaryInventoryData', source, FormattedInventoryData, vRP.computeItemsWeight({LootBagItems}), maxVehKg)

        vRPclient.notify(source,{"~g~You have opened " .. LootBagEntities[netid].name .. "'s lootbag"})
    end
end


-- Remove loot bags after they have been looted
Citizen.CreateThread(function()
    while true do 
        Wait(500)
        for i,v in pairs(LootBagEntities) do 
            local itemCount = 0;
            for i,v in pairs(v.Items) do
                itemCount = itemCount + 1
            end
            if itemCount == 0 then
                if DoesEntityExist(v[1]) then 
                    DeleteEntity(v[1])
                    LootBagEntities[i] = nil;
                end
            end
        end
    end
end)