local lang = vRP.lang
local MoneydropEntities = {}

function tvRP.MoneyDrop()
    local source = source
    Wait(100) -- wait delay for death.
    local user_id = vRP.getUserId(source)
    local model = GetHashKey('prop_poly_bag_money')
    local name1 = GetPlayerName(source)
    local moneydrop = CreateObjectNoOffset(model, GetEntityCoords(GetPlayerPed(source)) + 0.4, true, true, false)
    local moneydropnetid = NetworkGetNetworkIdFromEntity(moneydrop)
    MoneydropEntities[moneydropnetid] = {moneydrop, moneydrop, false, source}
    MoneydropEntities[moneydropnetid].Money = {}
    local ndata = vRP.getUserDataTable(user_id)
    local money = vRP.getMoney(user_id)
    local stored_inventory = nil;
    if vRP.tryPayment(user_id,money) then
        MoneydropEntities[moneydropnetid].Money = money
    end
end

    RegisterNetEvent('vRP:Moneydrop')
    AddEventHandler('vRP:Moneydrop', function(netid)
        local source = source
        if MoneydropEntities[netid] and not MoneydropEntities[netid][3] and #(GetEntityCoords(MoneydropEntities[netid][1]) - GetEntityCoords(GetPlayerPed(source))) < 10.0 then
            MoneydropEntities[netid][3] = true;
            local user_id = vRP.getUserId(source)
            if user_id ~= nil then
        
                TriggerClientEvent("ERP:MoneyNotInBag",source)
                if MoneydropEntities[netid].Money ~= 0 then

                    vRP.giveMoney(user_id,MoneydropEntities[netid].Money)
                    vRPclient.notify(source,{"~g~You have taken £"..tonumber(MoneydropEntities[netid].Money)})
                    MoneydropEntities[netid].Money = 0
                else

                end
            else
                vRPclient.notify(source,{"~r~The money drop is already being taken"})

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
                        MoneydropEntities[i] = nil;
                    end
                end
            end
        end
    end)