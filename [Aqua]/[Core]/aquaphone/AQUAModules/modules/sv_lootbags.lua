local lang = AQUA.lang
local LootBagEntities = {}

function AQUA.Coma()
    local source = source
        Wait(500) -- wait delay for death.
        local user_id = AQUA.getUserId(source)
        local model = GetHashKey('prop_arena_bag_01')
        local name1 = GetPlayerName(source)
        local lootbag = CreateObjectNoOffset(model, GetEntityCoords(GetPlayerPed(source)) + 0.4, true, true, false)
        local lootbagnetid = NetworkGetNetworkIdFromEntity(lootbag)
        LootBagEntities[lootbagnetid] = {lootbag, lootbag, false, source}
        LootBagEntities[lootbagnetid].Items = {}
        LootBagEntities[lootbagnetid].Money = {}
        LootBagEntities[lootbagnetid].name = name1
        local ndata = AQUA.getUserDataTable(user_id)
        local money = AQUA.getMoney(user_id)
        local stored_inventory = nil;
        if AQUA.tryPayment(user_id,money) then
            LootBagEntities[lootbagnetid].Money = money
        end
        if ndata ~= nil then
            if ndata.inventory ~= nil then
                stored_inventory = ndata.inventory
                AQUA.clearInventory(user_id)
                for k, v in pairs(stored_inventory) do
                    LootBagEntities[lootbagnetid].Items[k] = {}
                    LootBagEntities[lootbagnetid].Items[k].amount = v.amount
                end
            end
        end
end

    RegisterNetEvent('AQUA:LootBag')
    AddEventHandler('AQUA:LootBag', function(netid)
        local source = source
        if LootBagEntities[netid] and not LootBagEntities[netid][3] and #(GetEntityCoords(LootBagEntities[netid][1]) - GetEntityCoords(GetPlayerPed(source))) < 2.0 then
            LootBagEntities[netid][3] = true;
            local user_id = AQUA.getUserId(source)
            if user_id ~= nil then
                LootBagEntities[netid][5] = source
                OpenInv(source, netid, LootBagEntities[netid].Items)
                AQUAclient.notify(source,{"~g~You have opened " .. LootBagEntities[netid].name .. "'s lootbag"})
            else
                AQUAclient.notify(source,{"~d~The loot bag is already being taken"})
            end
        end
    end)

    RegisterNetEvent('AQUA:LootBagTakeItem')
    AddEventHandler('AQUA:LootBagTakeItem', function(netid, amount, idname)
        local source = source
        local user_id = AQUA.getUserId(source)
        local lootbag = LootBagEntities[netid] 
        if lootbag and lootbag[3] and #(GetEntityCoords(LootBagEntities[netid][1]) - GetEntityCoords(GetPlayerPed(source))) < 2.0 and lootbag[5] == source then
            local citem = LootBagEntities[netid].Items[idname]
            if not citem or citem.amount <= 0 then
                LootBagEntities[netid].Items[idname] = nil 
                return;
            end
            amount = parseInt(amount)
            if amount >= 0 and amount <= citem.amount then
                local new_weight = AQUA.getInventoryWeight(user_id) + AQUA.getItemWeight(idname) * amount
                if new_weight <= AQUA.getInventoryMaxWeight(user_id) then
                    AQUA.giveInventoryItem(user_id, idname, amount, true)
                    citem.amount = citem.amount - amount
                    if citem.amount <= 0 then
                        LootBagEntities[netid].Items[idname] = nil 
                    end
                    local ProcessedItems = {}
                    for i,v in pairs(LootBagEntities[netid].Items) do
                        local name, description, weight = AQUA.getItemDefinition(i)
                        ProcessedItems[name] = {(weight * v.amount), v.amount, i}
                    end
                    TriggerClientEvent('AQUA:UpdateLootBag', source, ProcessedItems)
                else
                    AQUAclient.notify(source, {lang.inventory.full()})
                end
            else
                AQUAclient.notify(source, {lang.common.invalid_value()})
            end
        else 
            print('cheating ez ban on: userid:' .. user_id .. ' tried to hijack the lootbag!')
            AQUA.AnticheatBanAQUA(user_id, 'Type: [4](Injecting Code)')
        end
    end)

    function OpenInv(source, netid, items)
        local ProcessedItems = {}
        for i,v in pairs(items) do
            local name, description, weight = AQUA.getItemDefinition(i)
            if weight then
                ProcessedItems[name] = {(weight * v.amount), v.amount, i}
            end
        end
        TriggerClientEvent('AQUA:OpenLootBag', source, ProcessedItems)
    end

    Citizen.CreateThread(function()
        while true do 
            Wait(700)
            for i,v in pairs(LootBagEntities) do 
                if v[5] then 
                    local coords = GetEntityCoords(GetPlayerPed(v[5]))
                    local objectcoords = GetEntityCoords(v[1])
                    if #(objectcoords - coords) > 2.0 then
                        TriggerClientEvent('AQUA:CloseLootBag', v[5])
                        Wait(3000)
                        v[3] = false; 
                        v[5] = nil;
                    end
                end
            end
        end
    end)

    -- Get rid of looted lootbags
    Citizen.CreateThread(function()
        while true do 
            Wait(100)
            for i,v in pairs(LootBagEntities) do 
                local itemCount = 0;
                for i,v in pairs(v.Items) do
                    itemCount = itemCount + 1
                end
                if itemCount == 0 then
                    if DoesEntityExist(v[1]) then 
                        DeleteEntity(v[1])
                        if v[5] then
                            TriggerClientEvent('AQUA:CloseLootBag', v[5])
                        end
                        print('Deleted Lootbag')
                        LootBagEntities[i] = nil;
                    end
                end
            end
        end
    end)

    Citizen.CreateThread(function()
        while true do 
            Wait(600000)
            if DoesEntityExist("prop_arena_bag_01") then 
                DeleteEntity("prop_arena_bag_01")
            end
        end
    end)