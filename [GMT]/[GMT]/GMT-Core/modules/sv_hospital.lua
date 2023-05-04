local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "Hospital")

-- RegisterServerEvent("GMT:HealPlayer")
-- AddEventHandler('GMT:HealPlayer', function()
--     userid = vRP.getUserId({source})
--     TriggerClientEvent("GMT:SetHealth", source)
--     vRPclient.notify(source,{"~g~You have been healed, free of charge."})
-- end)

RegisterNetEvent('GMT:reviveRadial')
AddEventHandler('GMT:reviveRadial', function()
    local player = source
    vRPclient.getNearestPlayer(player,{4},function(nplayer)
        TriggerClientEvent('GMT:cprAnim', player, nplayer)
    end)
end)

RegisterNetEvent("GMT:SendFixClient")
AddEventHandler("GMT:SendFixClient", function(player)
    TriggerClientEvent("GMT:FixClient", player)
end)