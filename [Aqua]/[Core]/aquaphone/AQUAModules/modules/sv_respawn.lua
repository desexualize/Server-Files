local Tunnel = module('AQUA', 'lib/Tunnel')
local Proxy = module('AQUA', 'lib/Proxy')
AQUA = Proxy.getInterface("AQUA")

RegisterNetEvent('AQUA:PoliceCheck')
AddEventHandler('AQUA:PoliceCheck', function()
    local source = source
    local user_id = AQUA.getUserId({source})
    if AQUA.hasPermission({user_id, 'police.armoury'}) then
        TriggerClientEvent('AQUA:PolicePerms', source, true)
    else
        TriggerClientEvent('AQUA:PolicePerms', source, false)
    end
end)

RegisterNetEvent('AQUA:RebelCheck')
AddEventHandler('AQUA:RebelCheck', function()
    local source = source
    local user_id = AQUA.getUserId({source})
    if AQUA.hasPermission({user_id, 'rebel.guns'}) then
        TriggerClientEvent('AQUA:RebelPerms', source, true)
    else
        TriggerClientEvent('AQUA:RebelPerms', source, false)
    end
end)


RegisterNetEvent('AQUA:VIPCheck')
AddEventHandler('AQUA:VIPCheck', function()
    local source = source
    local user_id = AQUA.getUserId({source})
    if AQUA.hasPermission({user_id, 'vip.guns'}) then
        TriggerClientEvent('AQUA:VIPPerms', source, true)
    else
        TriggerClientEvent('AQUA:VIPPerms', source, false)
    end
end)

