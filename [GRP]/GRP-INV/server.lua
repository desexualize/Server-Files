-- A JamesUK Production. Licensed users only. Use without authorisation is illegal, and a criminal offence under UK Law.
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local vRP = Proxy.getInterface("vRP")
local vRPclient = Tunnel.getInterface("vRP","vRP") -- server -> client tunnel
local Inventory = module("vrp", "cfg/inventory")
local InventorySpamTrack = {} -- Stops inventory being spammed by users.
local LootBagEntities = {}
local InventoryCoolDown = {}


RegisterNetEvent('Galaxy:FetchPersonalInventory')
AddEventHandler('Galaxy:FetchPersonalInventory', function()
    local source = source
    if not InventorySpamTrack[source] then
        InventorySpamTrack[source] = true;
        local UserId = vRP.getUserId({source}) 
        local data = vRP.getUserDataTable({UserId})
        if data and data.inventory then
            local FormattedInventoryData = {}
            --print(json.encode(data.inventory))
            for i,v in pairs(data.inventory) do
                FormattedInventoryData[i] = {amount = v.amount, ItemName = vRP.getItemName({i}), Weight = vRP.getItemWeight({i})}
            end
            TriggerClientEvent('Galaxy:FetchPersonalInventory', source, FormattedInventoryData, vRP.computeItemsWeight({data.inventory}), vRP.getInventoryMaxWeight({UserId}))
            InventorySpamTrack[source] = false;
        else 
            print('[^7JamesUKInventory]^1: An error has occured while trying to fetch inventory data from: ' .. UserId .. ' This may be a saving / loading data error you will need to investigate this.')
        end
    end
end)


AddEventHandler('Galaxy:RefreshInventory', function(source)
    local UserId = vRP.getUserId({source}) 
    local data = vRP.getUserDataTable({UserId})
    if data and data.inventory then
        local FormattedInventoryData = {}
        for i,v in pairs(data.inventory) do
            FormattedInventoryData[i] = {amount = v.amount, ItemName = vRP.getItemName({i}), Weight = vRP.getItemWeight({i})}
        end
        TriggerClientEvent('Galaxy:FetchPersonalInventory', source, FormattedInventoryData, vRP.computeItemsWeight({data.inventory}), vRP.getInventoryMaxWeight({UserId}))
    else 
        print('[^7JamesUKInventory]^1: An error has occured while trying to fetch inventory data from: ' .. UserId .. ' This may be a saving / loading data error you will need to investigate this.')
    end
end)

RegisterNetEvent('Galaxy:GiveItem')
AddEventHandler('Galaxy:GiveItem', function(itemId, itemLoc)
    local source = source
    if not itemId then  vRPclient.notify(source, {'~r~You need to select an item, first!'}) return end
    if itemLoc == "Plr" then
        vRP.RunGiveTask({source, itemId})
    else
        vRPclient.notify(source, {'~r~You need to have this item on you to give it.'})
    end
end)

RegisterNetEvent('Galaxy:TrashItem')
AddEventHandler('Galaxy:TrashItem', function(itemId, itemLoc)
    local source = source
    if not itemId then  vRPclient.notify(source, {'~r~You need to select an item, first!'}) return end
    if itemLoc == "Plr" then
        vRP.RunTrashTask({source, itemId})
    else
        vRPclient.notify(source, {'~r~You need to have this item on you to drop it.'})
    end
end)

RegisterServerEvent("ORP:flashLights")
AddEventHandler("ORP:flashLights", function(nearestVeh)
    local nearestVeh = nearestVeh
    TriggerClientEvent("ORP:flashCarLightsAlarm", -1, nearestVeh)

end) 

RegisterNetEvent('Galaxy:FetchTrunkInventory')
AddEventHandler('Galaxy:FetchTrunkInventory', function(spawnCode, vehid)
    local source = source
    local idz = NetworkGetEntityFromNetworkId(vehid)
    local user_id = vRP.getUserId({NetworkGetEntityOwner(idz)})
   print(user_id)
    if InventoryCoolDown[source] then vRPclient.notify(source, {'~r~The server is still processing your request.'}) return end
    local carformat = "chest:u1veh_" .. spawnCode .. '|' .. user_id
    print(carformat)
    vRP.getSData({carformat, function(cdata)
        local processedChest = {};
        cdata = json.decode(cdata) or {}
        local FormattedInventoryData = {}
        for i, v in pairs(cdata) do
            FormattedInventoryData[i] = {amount = v.amount, ItemName = vRP.getItemName({i}), Weight = vRP.getItemWeight({i})}
        end
        local maxVehKg = Inventory.vehicle_chest_weights[spawnCode] or Inventory.default_vehicle_chest_weight
        TriggerClientEvent('Galaxy:SendSecondaryInventoryData', source, FormattedInventoryData, vRP.computeItemsWeight({cdata}), maxVehKg)
    end})
end)

RegisterNetEvent('GRP:LockPick')
AddEventHandler('GRP:LockPick', function()
    user_id = vRP.getUserId({source})
           
           if vRP.tryGetInventoryItem({user_id, "lockpick", 1, true}) then
                 TriggerClientEvent('GRP:whatIsThis', source)
   
           end
       

end)





RegisterNetEvent('Galaxy:UseItem')
AddEventHandler('Galaxy:UseItem', function(itemId, itemLoc)
    local source = source
    if not itemId then    vRPclient.notify(source, {'~r~You need to select an item, first!'}) return end
    if itemLoc == "Plr" then
        vRP.RunInventoryTask({source, itemId})
        
    else
        vRPclient.notify(source, {'~r~You need to have this item on you to use it.'})
    end
end)


RegisterNetEvent('Galaxy:MoveItem')
AddEventHandler('Galaxy:MoveItem', function(inventoryType, itemId, inventoryInfo, Lootbag)
    local source = source
    local UserId = vRP.getUserId({source}) 
    local data = vRP.getUserDataTable({UserId})
    if InventoryCoolDown[source] then vRPclient.notify(source, {'~r~The server is still processing your request.'}) return end
    if not itemId then  vRPclient.notify(source, {'~r~You need to select an item, first!'}) return end
    if data and data.inventory then
        if inventoryInfo == nil then return end
        if inventoryType == "CarBoot" then
            InventoryCoolDown[source] = true;
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
                            TriggerClientEvent('Galaxy:SendSecondaryInventoryData', source, FormattedInventoryData, vRP.computeItemsWeight({cdata}), maxVehKg)
                            TriggerEvent('Galaxy:RefreshInventory', source)
                            InventoryCoolDown[source] = false;
                            vRP.setSData({carformat, json.encode(cdata)})
                        else 
                            InventoryCoolDown[source] = false;
                            vRPclient.notify(source, {'~r~You do not have enough inventory space.'})
                        end
                    else 
                        InventoryCoolDown[source] = false;
                        print('[^7JamesUKInventory]^1: An error has occured while trying to move an item. Inventory data from: ' .. UserId .. ' This is usually caused by cheating as the item does not exist in the car boot.')
                    end
                end})
            end
        elseif inventoryType == "LootBag" then    
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
                    TriggerClientEvent('Galaxy:SendSecondaryInventoryData', source, FormattedInventoryData, vRP.computeItemsWeight({LootBagEntities[inventoryInfo].Items}), maxVehKg)                
                    TriggerEvent('Galaxy:RefreshInventory', source)
                else 
                    vRPclient.notify(source, {'~r~You do not have enough inventory space.'})
                end
            end
        elseif inventoryType == "Housing" then
            -- Housing integration..
        elseif inventoryType == "Plr" then
            if not Lootbag then
                if data.inventory[itemId] then
                    InventoryCoolDown[source] = true;
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
                                TriggerClientEvent('Galaxy:SendSecondaryInventoryData', source, FormattedInventoryData, vRP.computeItemsWeight({cdata}), maxVehKg)
                                TriggerEvent('Galaxy:RefreshInventory', source)
                                InventoryCoolDown[source] = nil;
                                vRP.setSData({carformat, json.encode(cdata)})
                            else 
                                InventoryCoolDown[source] = nil;
                                vRPclient.notify(source, {'~r~You do not have enough inventory space.'})
                            end
                        else 
                            InventoryCoolDown[source] = nil;
                            print('[^7JamesUKInventory]^1: An error has occured while trying to move an item. Inventory data from: ' .. UserId .. ' This is usually caused by cheating as the item does not exist in the car boot.')
                        end
                    end})
                else
                    InventoryCoolDown[source] = nil;
                    print('[^7JamesUKInventory]^1: An error has occured while trying to move an item. Inventory data from: ' .. UserId .. ' This is usually caused by cheating as the item does not exist in the car boot.')
                end
            end
        end
    else 
        InventoryCoolDown[source] = nil;
        print('[^7JamesUKInventory]^1: An error has occured while trying to move an item. Inventory data from: ' .. UserId .. ' This may be a saving / loading data error you will need to investigate this.')
    end
end)



RegisterNetEvent('Galaxy:MoveItemX')
AddEventHandler('Galaxy:MoveItemX', function(inventoryType, itemId, inventoryInfo, Lootbag)
    local source = source
    local UserId = vRP.getUserId({source}) 
    local data = vRP.getUserDataTable({UserId})
    if InventoryCoolDown[source] then vRPclient.notify(source, {'~r~The server is still processing your request.'}) return end
    if not itemId then  vRPclient.notify(source, {'~r~You need to select an item, first!'}) return end
    if data and data.inventory then
        if inventoryInfo == nil then return end
        if inventoryType == "CarBoot" then
            InventoryCoolDown[source] = true;
            TriggerClientEvent('Galaxy:ToggleNUIFocus', source, false)
            vRP.prompt({source, 'How many ' .. vRP.getItemName({itemId}) .. 's. Do you want to move?', "", function(player, Quantity)
                Quantity = parseInt(Quantity)
        
                
                    TriggerClientEvent('Galaxy:ToggleNUIFocus', source, true)
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
                                    TriggerClientEvent('Galaxy:SendSecondaryInventoryData', source, FormattedInventoryData, vRP.computeItemsWeight({cdata}), maxVehKg)
                                    TriggerEvent('Galaxy:RefreshInventory', source)
                                    InventoryCoolDown[source] = nil;
                                    vRP.setSData({carformat, json.encode(cdata)})
                                else 
                                    InventoryCoolDown[source] = nil;
                                    vRPclient.notify(source, {'~r~You do not have enough inventory space.'})
                                end
                            else 
                                InventoryCoolDown[source] = nil;
                                vRPclient.notify(source, {'~r~You are trying to move more then there actually is!'})
                            end
                        end})
                    else
                        InventoryCoolDown[source] = nil;
                        vRPclient.notify(source, {'~r~Invalid Amount!'})
                    end
  
             
    
            end})
        elseif inventoryType == "LootBag" then    
            if LootBagEntities[inventoryInfo].Items[itemId] then 
                TriggerClientEvent('Galaxy:ToggleNUIFocus', source, false)
                vRP.prompt({source, 'How many ' .. vRP.getItemName({itemId}) .. 's. Do you want to move?', "", function(player, Quantity)
                    Quantity = parseInt(Quantity)
                    TriggerClientEvent('Galaxy:ToggleNUIFocus', source, true)
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
                                TriggerClientEvent('Galaxy:SendSecondaryInventoryData', source, FormattedInventoryData, vRP.computeItemsWeight({LootBagEntities[inventoryInfo].Items}), maxVehKg)                
                                TriggerEvent('Galaxy:RefreshInventory', source)
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
            end
        elseif inventoryType == "Housing" then
            -- Housing integration..
        elseif inventoryType == "Plr" then
            if not Lootbag then
                if data.inventory[itemId] then
                    InventoryCoolDown[source] = true;
                    TriggerClientEvent('Galaxy:ToggleNUIFocus', source, false)
                    vRP.prompt({source, 'How many ' .. vRP.getItemName({itemId}) .. 's. Do you want to move?', "", function(player, Quantity)
                        Quantity = parseInt(Quantity)
                        TriggerClientEvent('Galaxy:ToggleNUIFocus', source, true)
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
                                        TriggerClientEvent('Galaxy:SendSecondaryInventoryData', source, FormattedInventoryData, vRP.computeItemsWeight({cdata}), maxVehKg)
                                        TriggerEvent('Galaxy:RefreshInventory', source)
                                        InventoryCoolDown[source] = nil;
                                        vRP.setSData({carformat, json.encode(cdata)})
                                    else 
                                        InventoryCoolDown[source] = nil;
                                        vRPclient.notify(source, {'~r~You do not have enough inventory space.'})
                                    end
                                else 
                                    InventoryCoolDown[source] = nil;
                                    vRPclient.notify(source, {'~r~You are trying to move more then there actually is!'})
                                end
                            end})
                        else 
                            vRPclient.notify(source, {'~r~Invalid input!'})
                        end
                    end})
                else
                    print('[^7JamesUKInventory]^1: An error has occured while trying to move an item. Inventory data from: ' .. UserId .. ' This is usually caused by cheating as the item does not exist in the car boot.')
                end
            end
        end
    else 
        print('[^7JamesUKInventory]^1: An error has occured while trying to move an item. Inventory data from: ' .. UserId .. ' This may be a saving / loading data error you will need to investigate this.')
    end
end)


RegisterNetEvent('Galaxy:MoveItemAll')
AddEventHandler('Galaxy:MoveItemAll', function(inventoryType, itemId, inventoryInfo, vehid)
    local source = source
    local UserId = vRP.getUserId({source}) 
    local data = vRP.getUserDataTable({UserId})
    if not itemId then  vRPclient.notify(source, {'~r~You need to select an item, first!'}) return end
    if InventoryCoolDown[source] then vRPclient.notify(source, {'~r~The server is still processing your request.'}) return end
    if data and data.inventory then
        if inventoryInfo == nil then return end
        if inventoryType == "CarBoot" then
            InventoryCoolDown[source] = true;
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
                        TriggerClientEvent('Galaxy:SendSecondaryInventoryData', source, FormattedInventoryData, vRP.computeItemsWeight({cdata}), maxVehKg)
                        TriggerEvent('Galaxy:RefreshInventory', source)
                        InventoryCoolDown[source] = nil;
                        vRP.setSData({carformat, json.encode(cdata)})
                    else 
                        InventoryCoolDown[source] = nil;
                        vRPclient.notify(source, {'~r~You do not have enough inventory space.'})
                    end
                else 
                    InventoryCoolDown[source] = nil;
                    vRPclient.notify(source, {'~r~You are trying to move more then there actually is!'})
                end
            end})
        elseif inventoryType == "LootBag" then    
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
                        TriggerClientEvent('Galaxy:SendSecondaryInventoryData', source, FormattedInventoryData, vRP.computeItemsWeight({LootBagEntities[inventoryInfo].Items}), maxVehKg)                
                        TriggerEvent('Galaxy:RefreshInventory', source)
                    else 
                        vRPclient.notify(source, {'~r~You are trying to move more then there actually is!'})
                    end 
                else 
                    vRPclient.notify(source, {'~r~You do not have enough inventory space.'})
                end
            end
        elseif inventoryType == "Housing" then
            -- Housing integration..
        elseif inventoryType == "Plr" then
            if not Lootbag then
                if data.inventory[itemId] then
                    InventoryCoolDown[source] = true;
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
                                TriggerClientEvent('Galaxy:SendSecondaryInventoryData', source, FormattedInventoryData, vRP.computeItemsWeight({cdata}), maxVehKg)
                                TriggerEvent('Galaxy:RefreshInventory', source)
                                InventoryCoolDown[source] = nil;
                                vRP.setSData({carformat, json.encode(cdata)})
                            else 
                                InventoryCoolDown[source] = nil;
                                vRPclient.notify(source, {'~r~You do not have enough inventory space.'})
                            end
                        else 
                            InventoryCoolDown[source] = nil;
                            vRPclient.notify(source, {'~r~You are trying to move more then there actually is!'})
                        end
                    end})
                else
                    InventoryCoolDown[source] = nil;
                    print('[^7JamesUKInventory]^1: An error has occured while trying to move an item. Inventory data from: ' .. UserId .. ' This is usually caused by cheating as the item does not exist in the car boot.')
                end
            end
        end
    else 
        InventoryCoolDown[source] = nil;
        print('[^7JamesUKInventory]^1: An error has occured while trying to move an item. Inventory data from: ' .. UserId .. ' This may be a saving / loading data error you will need to investigate this.')
    end
end)


-- LOOTBAGS CODE BELOW HERE 

RegisterNetEvent('vRP:InComa')
AddEventHandler('vRP:InComa', function()
    local source = source
    vRPclient.isInComa(source, {}, function(in_coma) 
        if in_coma then
            Wait(1500)
            local user_id = vRP.getUserId({source})
            local model = GetHashKey('prop_cs_heist_bag_01')
            local name1 = GetPlayerName(source)
            local lootbag = CreateObjectNoOffset(model, GetEntityCoords(GetPlayerPed(source)) + 0.4, true, true, false)
            local lootbagnetid = NetworkGetNetworkIdFromEntity(lootbag)
            LootBagEntities[lootbagnetid] = {lootbag, lootbag, false, source}
            LootBagEntities[lootbagnetid].Items = {}
            LootBagEntities[lootbagnetid].name = name1 
            local ndata = vRP.getUserDataTable({user_id})
            local stored_inventory = nil;
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
            if LootBagEntities[netid] and not LootBagEntities[netid][3] and #(GetEntityCoords(LootBagEntities[netid][1]) - GetEntityCoords(GetPlayerPed(source))) < 5.0 then
                LootBagEntities[netid][3] = true;
                local user_id = vRP.getUserId({source})
                if user_id ~= nil then
                    LootBagEntities[netid][5] = source
                    OpenInv(source, netid, LootBagEntities[netid].Items)
                    vRPclient.notify(source,{"~g~You have opened " .. LootBagEntities[netid].name .. "'s lootbag"})
                end
            else
                --vRPclient.notify(source, {'~r~This loot bag is already being looted.'})
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

RegisterNetEvent('Galaxy:CloseLootbag')
AddEventHandler('Galaxy:CloseLootbag', function()
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
    TriggerClientEvent('Galaxy:InventoryOpen', source, false, false)
end

function OpenInv(source, netid, LootBagItems)
    local UserId = vRP.getUserId({source})
    local data = vRP.getUserDataTable({UserId})
    if data and data.inventory then
        local FormattedInventoryData = {}
        for i,v in pairs(data.inventory) do
            FormattedInventoryData[i] = {amount = v.amount, ItemName = vRP.getItemName({i}), Weight = vRP.getItemWeight({i})}
        end
        TriggerClientEvent('Galaxy:FetchPersonalInventory', source, FormattedInventoryData, vRP.computeItemsWeight({data.inventory}), vRP.getInventoryMaxWeight({UserId}))
        InventorySpamTrack[source] = false;
    else 
        print('[^7JamesUKInventory]^1: An error has occured while trying to fetch inventory data from: ' .. UserId .. ' This may be a saving / loading data error you will need to investigate this.')
    end
    TriggerClientEvent('Galaxy:InventoryOpen', source, true, true)
    local FormattedInventoryData = {}
    for i, v in pairs(LootBagItems) do
        FormattedInventoryData[i] = {amount = v.amount, ItemName = vRP.getItemName({i}), Weight = vRP.getItemWeight({i})}
    end
    local maxVehKg = 200
    TriggerClientEvent('Galaxy:SendSecondaryInventoryData', source, FormattedInventoryData, vRP.computeItemsWeight({LootBagItems}), maxVehKg)
    print(json.encode(FormattedInventoryData))
end


-- Garabge collector for empty lootbags.
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
                    --print('Deleted Lootbag')
                    LootBagEntities[i] = nil;
                end
            end
        end
        --print('All Lootbag garbage collected.')
    end
end)