local Tunnel = module('AQUA', 'lib/Tunnel')
local Proxy = module('AQUA', 'lib/Proxy')
AQUA = Proxy.getInterface("AQUA")
AQUAclient = Tunnel.getInterface("AQUA", "AQUA_gunshop")
hasMoney = false

RegisterNetEvent("AQUA:checkParachuteMoney")
AddEventHandler("AQUA:checkParachuteMoney", function()
    local source = source
    user_id = AQUA.getUserId({source})
    local bankBalance = AQUA.getBankMoney({user_id})
    if bankBalance >= 15000 then
        newBalance = bankBalance - 15000
        AQUA.setBankMoney({user_id, newBalance})
        hasMoney = true
        AQUAclient.notify(user_id, {"~g~You have paid £15,000 to parachute."})
        TriggerClientEvent("AQUA:PlaySound", source, 1)
        TriggerClientEvent("AQUA:goParachuting", source, 1)
    else
        AQUAclient.notify(user_id, {"~d~You do not have enough money."})
    end
end)