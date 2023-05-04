local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vk")



RegisterServerEvent("GMT:PDVK")
AddEventHandler('GMT:PDVK', function()
    local source = source
    user_id = vRP.getUserId({source})
    if vRP.hasPermission({user_id, 'police.armoury'}) then 
    -- if vRP.hasGroup(user_id, "ScorpianBlue")
        TriggerClientEvent('sendvkpdperms', source, true)
    else
        TriggerClientEvent('sendvkpdperms', source, false)
    end
end)