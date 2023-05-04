RegisterServerEvent("AQUA:returnSafe:server")
AddEventHandler("AQUA:returnSafe:server", function(deliveryType, safeReturn)
    local source = source
    local user_id = AQUA.getUserId(source)
    if safeReturn then
        local SafeMoney = 4000
        for k, v in pairs(dpdcfg.Safe) do
            if k == deliveryType then
                SafeMoney = v
                break
            end
        end
    else
    end
end)

RegisterServerEvent("AQUA:finishDelivery:server")
AddEventHandler("AQUA:finishDelivery:server", function(deliveryType)
    local source = source
    local user_id = AQUA.getUserId(source)
    local delieryMoney = 50000
    for k, v in pairs(dpdcfg.Rewards) do
        if k == deliveryType then
            deliveryMoney = v
            break
        end
    end
    AQUA.giveBankMoney(user_id,delieryMoney)
    AQUAclient.notify(source,{"Package Delivered, you received £"..tostring(deliveryMoney)})
end)

RegisterServerEvent("AQUA:removeSafeMoney:server")
AddEventHandler("AQUA:removeSafeMoney:server", function(deliveryType)
        local user_id = AQUA.getUserId({source})
        local SafeMoney = 4000
            for k, v in pairs(dpdcfg.Safe) do
                if k == deliveryType then
                    SafeMoney = v
                break
            end
        end
    TriggerClientEvent("AQUA:startJob:client", source, deliveryType)
end)
