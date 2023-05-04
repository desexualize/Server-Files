local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface("vRP")

RegisterNetEvent('GMT:PoliceCheck')
AddEventHandler('GMT:PoliceCheck', function()
    local source = source
    local user_id = vRP.getUserId({source})
    if vRP.hasPermission({user_id, 'police.armoury'}) then
        TriggerClientEvent('GMT:PolicePerms', source, true)
    else
        TriggerClientEvent('GMT:PolicePerms', source, false)
    end
end)

RegisterNetEvent('GMT:RebelCheck')
AddEventHandler('GMT:RebelCheck', function()
    local source = source
    local user_id = vRP.getUserId({source})
    if vRP.hasPermission({user_id, 'rebel.guns'}) then
        TriggerClientEvent('GMT:RebelPerms', source, true)
    else
        TriggerClientEvent('GMT:RebelPerms', source, false)
    end
end)


RegisterNetEvent('GMT:VIPCheck')
AddEventHandler('GMT:VIPCheck', function()
    local source = source
    local user_id = vRP.getUserId({source})
    if vRP.hasPermission({user_id, 'vip.guns'}) then
        TriggerClientEvent('GMT:VIPPerms', source, true)
    else
        TriggerClientEvent('GMT:VIPPerms', source, false)
    end
end)

