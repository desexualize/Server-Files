local Tunnel = module('AQUA', 'lib/Tunnel')
local Proxy = module('AQUA', 'lib/Proxy')
AQUA = Proxy.getInterface("AQUA")
AQUAclient = Tunnel.getInterface("AQUA", "vk")



RegisterServerEvent("AQUA:PDVK")
AddEventHandler('AQUA:PDVK', function()
    local source = source
    user_id = AQUA.getUserId({source})
    if AQUA.hasPermission({user_id, 'police.armoury'}) then 
    -- if AQUA.hasGroup(user_id, "ScorpianBlue")
        TriggerClientEvent('sendvkpdperms', source, true)
    else
        TriggerClientEvent('sendvkpdperms', source, false)
    end
end)