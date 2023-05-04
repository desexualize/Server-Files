local b = module("vrp", "lib/Tunnel")
local c = module("vrp", "lib/Proxy")
vRP = c.getInterface("vRP")
vRPclient = b.getInterface("vRP", "vRP")


RegisterNetEvent('GMT:pdRadioPerms')
AddEventHandler('GMT:pdRadioPerms', function(status, b)
    local source = source
    local user_id = vRP.getUserId({source})
    if vRP.hasPermission({user_id, 'police.armoury'}) then
        TriggerClientEvent('GMT:pdRadioAnim', source, status, b)
    end
end)
