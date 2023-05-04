local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface("vRP")

RegisterNetEvent('FNR:PoliceCheck')
AddEventHandler('FNR:PoliceCheck', function()
    local source = source
    local user_id = vRP.getUserId({source})
    if vRP.hasPermission({user_id, 'police.armoury'}) then
        TriggerClientEvent('FNR:PolicePerms', source, true)
    else
        TriggerClientEvent('FNR:PolicePerms', source, false)
    end
end)

RegisterNetEvent('FNR:RebelCheck')
AddEventHandler('FNR:RebelCheck', function()
    local source = source
    local user_id = vRP.getUserId({source})
    if vRP.hasPermission({user_id, 'rebel.guns'}) then
        TriggerClientEvent('FNR:RebelPerms', source, true)
    else
        TriggerClientEvent('FNR:RebelPerms', source, false)
    end
end)


RegisterNetEvent('FNR:VIPCheck')
AddEventHandler('FNR:VIPCheck', function()
    local source = source
    local user_id = vRP.getUserId({source})
    if vRP.hasPermission({user_id, 'vip.guns'}) then
        TriggerClientEvent('FNR:VIPPerms', source, true)
    else
        TriggerClientEvent('FNR:VIPPerms', source, false)
    end
end)

