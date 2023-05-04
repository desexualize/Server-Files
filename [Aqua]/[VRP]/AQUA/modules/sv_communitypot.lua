RegisterNetEvent("AQUA:tryDepositCommunityPot")
AddEventHandler(
    "AQUA:tryDepositCommunityPot",
    function(amount)
        local source = source
        amount = parseInt(amount)
        if onesync ~= "off" then
            --Onesync allows extra security behind events should enable it if it's not already.
            local ped = GetPlayerPed(source)
            local playerCoords = GetEntityCoords(ped)
            for i, v in pairs(cfg.atms) do
                local coords = vec3(v[1], v[2], v[3])
                if #(playerCoords - coords) <= 2.50 then
                    if amount > 0 then
                        local user_id = AQUA.getUserId(source)
                        if user_id ~= nil then
                            if AQUA.tryDeposit(user_id, amount) then
                                AQUAclient.notify(source, {lang.atm.deposit.deposited({amount})})
                                
                            else
                                AQUAclient.notify(source, {lang.money.not_enough()})
                            end
                        end
                    else
                        AQUAclient.notify(source, {lang.common.invalid_value()})
                    end
                end
            end
        else
            if amount > 0 then
                local user_id = AQUA.getUserId(source)
                if user_id ~= nil then
                    if AQUA.tryDeposit(user_id, amount) then
                        AQUAclient.notify(source, {lang.atm.deposit.deposited({amount})})
                    else
                        AQUAclient.notify(source, {lang.money.not_enough()})
                    end
                end
            else
                AQUAclient.notify(source, {lang.common.invalid_value()})
            end
        end
    end)

    RegisterNetEvent("AQUA:tryWithdrawCommunityPot")
AddEventHandler(
    "AQUA:tryWithdrawCommunityPot",
    function(amount)
        local source = source
        amount = parseInt(amount)
        if amount < 0 then
            return
        end
        if onesync ~= "off" then
            --Onesync allows extra security behind events should enable it if it's not already.
            local ped = GetPlayerPed(source)
            local playerCoords = GetEntityCoords(ped)
            for i, v in pairs(cfg.atms) do
                local coords = vec3(v[1], v[2], v[3])
                if #(playerCoords - coords) <= 2.50 then
                    if amount > 0 then
                        local user_id = AQUA.getUserId(source)
                        if user_id ~= nil then
                            if AQUA.tryWithdraw(user_id, amount) then
                                AQUAclient.notify(source, {lang.atm.withdraw.withdrawn({amount})})
                            else
                                AQUAclient.notify(source, {lang.atm.withdraw.not_enough()})
                            end
                        end
                    else
                        AQUAclient.notify(source, {lang.common.invalid_value()})
                    end
                end
            end
        else
            if amount > 0 then
                local user_id = AQUA.getUserId(source)
                if user_id ~= nil then
                    if AQUA.tryWithdraw(user_id, amount) then
                        AQUAclient.notify(source, {lang.atm.withdraw.withdrawn({amount})})
                    else
                        AQUAclient.notify(source, {lang.atm.withdraw.not_enough()})
                    end
                end
            else
                AQUAclient.notify(source, {lang.common.invalid_value()})
            end
        end
    end
)