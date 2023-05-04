local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface("vRP")

RegisterNetEvent('VRP:pdRadioPerms')
AddEventHandler('VRP:pdRadioPerms', function(status, b)
    local source = source
    local user_id = vRP.getUserId({source})
    if vRP.hasPermission({user_id, 'police.armoury'}) then
        TriggerClientEvent('VRP:pdRadioAnim', source, status, b)
    end
end)
