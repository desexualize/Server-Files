local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP_gunshop")

RegisterNetEvent('sendPD')
AddEventHandler('sendPD', function()
    user_id = vRP.getUserId({source})
    if vRP.hasPermission({user_id, 'police.menu'}) then 
        TriggerClientEvent('returnPd2', source, true)
    else
        TriggerClientEvent('returnPd2', source, false)
    end
end)

RegisterNetEvent('sendVIP')
AddEventHandler('sendVIP', function()
    user_id = vRP.getUserId({source})
    if vRP.hasPermission({user_id, 'vip.perm'}) then 
        TriggerClientEvent('returnvip2', source, true)
    else
        TriggerClientEvent('returnvip2', source, false)
    end
end)