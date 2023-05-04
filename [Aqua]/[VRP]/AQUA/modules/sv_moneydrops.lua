local lang = AQUA.lang
local MoneydropEntities = {}

function tAQUA.MoneyDrop()
    local source = source
    Wait(100) -- wait delay for death.
    local user_id = AQUA.getUserId(source)
    local model = GetHashKey('prop_poly_bag_money')
    local name1 = GetPlayerName(source)
    local moneydrop = CreateObjectNoOffset(model, GetEntityCoords(GetPlayerPed(source)) + 0.4, true, true, false)
    local moneydropnetid = NetworkGetNetworkIdFromEntity(moneydrop)
    MoneydropEntities[moneydropnetid] = {moneydrop, moneydrop, false, source}
    MoneydropEntities[moneydropnetid].Money = {}
    local ndata = AQUA.getUserDataTable(user_id)
    local money = AQUA.getMoney(user_id)
    local stored_inventory = nil;
    if AQUA.tryPayment(user_id,money) then
        MoneydropEntities[moneydropnetid].Money = money
    end
end

    RegisterNetEvent('AQUA:Moneydrop')
    AddEventHandler('AQUA:Moneydrop', function(netid)
        local source = source
        if MoneydropEntities[netid] and not MoneydropEntities[netid][3] and #(GetEntityCoords(MoneydropEntities[netid][1]) - GetEntityCoords(GetPlayerPed(source))) < 10.0 then
            MoneydropEntities[netid][3] = true;
            local user_id = AQUA.getUserId(source)
            if user_id ~= nil then
        
                TriggerClientEvent("Infinite:MoneyNotInBag",source)
                if MoneydropEntities[netid].Money ~= 0 then
                    --print("YES")
                    AQUA.giveMoney(user_id,MoneydropEntities[netid].Money)
                    AQUAclient.notify(source,{"~g~You have taken £"..tonumber(MoneydropEntities[netid].Money)})
                    MoneydropEntities[netid].Money = 0
                else
                    --print("NO")
                end
            else
                AQUAclient.notify(source,{"~d~The money drop is already being taken"})

            end
        end
    end)

    -- Get rid of looted moneydrops
    Citizen.CreateThread(function()
        while true do 
            Wait(100)
            for i,v in pairs(MoneydropEntities) do 
                if v.Money == 0 then
                    if DoesEntityExist(v[1]) then 
                        DeleteEntity(v[1])
                        print('Deleted MoneyDrop')
                        MoneydropEntities[i] = nil;
                    end
                end
            end
        end
    end)