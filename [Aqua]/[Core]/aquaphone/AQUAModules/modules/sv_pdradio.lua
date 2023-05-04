local Tunnel = module('AQUA', 'lib/Tunnel')
local Proxy = module('AQUA', 'lib/Proxy')
AQUA = Proxy.getInterface("AQUA")

RegisterNetEvent('AQUA:pdRadioPerms')
AddEventHandler('AQUA:pdRadioPerms', function(status, b)
    local source = source
    local user_id = AQUA.getUserId({source})
    if AQUA.hasPermission({user_id, 'police.armoury'}) then
        TriggerClientEvent('AQUA:pdRadioAnim', source, status, b)
    end
end)
