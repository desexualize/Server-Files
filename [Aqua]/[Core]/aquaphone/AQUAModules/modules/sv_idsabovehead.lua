local Tunnel = module("AQUA", "lib/Tunnel")
local Proxy = module("AQUA", "lib/Proxy")
AQUA = Proxy.getInterface("AQUA")

RegisterNetEvent('AQUA:IDsAboveHead')
AddEventHandler('AQUA:IDsAboveHead', function(status)
    local status = status
    local user_id = AQUA.getUserId({source})
    if AQUA.hasPermission({user_id, 'admin.noclip'}) then
        TriggerClientEvent('AQUA:ChangeIDs', source, status)
    end
end)