local Tunnel = module('AQUA', 'lib/Tunnel')
local Proxy = module('AQUA', 'lib/Proxy')
AQUA = Proxy.getInterface("AQUA")
AQUAclient = Tunnel.getInterface("AQUA", "AQUA_gunshop")

RegisterNetEvent('sendPD')
AddEventHandler('sendPD', function()
    user_id = AQUA.getUserId({source})
    if AQUA.hasPermission({user_id, 'police.menu'}) then 
        TriggerClientEvent('returnPd2', source, true)
    else
        TriggerClientEvent('returnPd2', source, false)
    end
end)


RegisterNetEvent('sendRebl')
AddEventHandler('sendRebl', function()
    user_id = AQUA.getUserId({source})
    if AQUA.hasGroup({user_id, 'Rebel'}) then 
        TriggerClientEvent('returnrebel', source, true)
    else
        TriggerClientEvent('returnrebel', source, false)
    end
end)


