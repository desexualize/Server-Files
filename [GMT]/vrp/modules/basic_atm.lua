-- a basic ATM implementation
local lang = vRP.lang
local cfg = module("cfg/atms")
local atms = cfg.atms
local onesync = GetConvar("onesync", nil)

RegisterNetEvent("VRP:Withdraw")
AddEventHandler(
    "VRP:Withdraw",
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
                        local user_id = vRP.getUserId(source)
                        if user_id ~= nil then
                            if vRP.tryWithdraw(user_id, amount) then
                                vRPclient.notify(source, {lang.atm.withdraw.withdrawn({amount})})
                                vRPclient.playAnim(source, {false, {{"amb@prop_human_atm@male@exit", "exit"}}, false})
                            else
                                vRPclient.notify(source, {lang.atm.withdraw.not_enough()})
                            end
                        end
                    else
                        vRPclient.notify(source, {lang.common.invalid_value()})
                    end
                end
            end
        else
            if amount > 0 then
                local user_id = vRP.getUserId(source)
                if user_id ~= nil then
                    if vRP.tryWithdraw(user_id, amount) then
                        vRPclient.notify(source, {lang.atm.withdraw.withdrawn({amount})})
                        vRPclient.playAnim(source, {false, {{"amb@prop_human_atm@male@exit", "exit"}}, false})
                    else
                        vRPclient.notify(source, {lang.atm.withdraw.not_enough()})
                    end
                end
            else
                vRPclient.notify(source, {lang.common.invalid_value()})
            end
        end
    end
)

RegisterNetEvent("VRP:Deposit")
AddEventHandler(
    "VRP:Deposit",
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
                        local user_id = vRP.getUserId(source)
                        if user_id ~= nil then
                            if vRP.tryDeposit(user_id, amount) then
                                vRPclient.notify(source, {lang.atm.deposit.deposited({amount})})
                                vRPclient.playAnim(
                                    source,
                                    {
                                        false,
                                        {
                                            {"amb@prop_human_atm@male@enter", "enter"},
                                            {"amb@prop_human_atm@male@idle_a", "idle_a"}
                                        },
                                        false
                                    }
                                )
                            else
                                vRPclient.notify(source, {lang.money.not_enough()})
                            end
                        end
                    else
                        vRPclient.notify(source, {lang.common.invalid_value()})
                    end
                end
            end
        else
            if amount > 0 then
                local user_id = vRP.getUserId(source)
                if user_id ~= nil then
                    if vRP.tryDeposit(user_id, amount) then
                        vRPclient.notify(source, {lang.atm.deposit.deposited({amount})})
                        vRPclient.playAnim(
                            source,
                            {
                                false,
                                {
                                    {"amb@prop_human_atm@male@enter", "enter"},
                                    {"amb@prop_human_atm@male@idle_a", "idle_a"}
                                },
                                false
                            }
                        )
                    else
                        vRPclient.notify(source, {lang.money.not_enough()})
                    end
                end
            else
                vRPclient.notify(source, {lang.common.invalid_value()})
            end
        end
    end
)

RegisterNetEvent("VRP:DepositALL")
AddEventHandler(
    "VRP:DepositALL",
    function()
        local source = source
        local userid = vRP.getUserId(source)
        local amount = vRP.getMoney(userid)
        local ped = GetPlayerPed(source)
        local playerCoords = GetEntityCoords(ped)
        if onesync ~= "off" then
        if userid ~= nil then
            for a, b in pairs(cfg.atms) do
                local coords = vec3(b[1], b[2], b[3])
                if #(playerCoords - coords) <= 2.50 then
                    if amount > 0 then
                        if vRP.tryDeposit(userid, amount) then
                            vRPclient.notify(source, {lang.atm.deposit.deposited({roundnumber(amount, 1)})})
                            vRPclient.playAnim(
                                source,
                                {
                                    false,
                                    {
                                        {"amb@prop_human_atm@male@enter", "enter"},
                                        {"amb@prop_human_atm@male@idle_a", "idle_a"}
                                    },
                                    false
                                }
                            )
                        else
                            vRPclient.notify(source, {lang.money.not_enough()})
                        end
                    end
                end
            end
        end
    end
end
)

RegisterNetEvent('VRP:WithdrawAll')
AddEventHandler('VRP:WithdrawAll', function()
    local source = source
    userid = vRP.getUserId(source)
    amount = vRP.getBankMoney(userid)
    print(amount)
    if onesync ~= "off" then    
        --Onesync allows extra security behind events should enable it if it's not already.
        local ped = GetPlayerPed(source)
        local playerCoords = GetEntityCoords(ped)
        for i, v in pairs(cfg.atms) do
            local coords = vec3(v[1], v[2], v[3])
            if #(playerCoords - coords) <= 5.0 then
            
                    local user_id = vRP.getUserId(source)
                    if user_id ~= nil then
                        if vRP.tryWithdraw(user_id, amount) then
                            vRPclient.notify(source, {lang.atm.withdraw.withdrawn({roundnumber(amount, 1)})})
                            vRPclient.playAnim(
                                source,
                                {
                                    false,
                                    {
                                        {"amb@prop_human_atm@male@enter", "enter"},
                                        {"amb@prop_human_atm@male@idle_a", "idle_a"}
                                    },
                                    false
                                }
                            )
                        else
                            vRPclient.notify(source, {lang.atm.withdraw.not_enough()})
                        end
                    end
                end
        end
    end
end)


function roundnumber(P, Q)
    local R = 10 ^ (Q or 0)
    return math.floor(P * R + 0.5) / R
end
