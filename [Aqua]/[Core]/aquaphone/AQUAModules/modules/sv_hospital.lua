local Tunnel = module('AQUA', 'lib/Tunnel')
local Proxy = module('AQUA', 'lib/Proxy')
AQUA = Proxy.getInterface("AQUA")
AQUAclient = Tunnel.getInterface("AQUA", "Hospital")

-- RegisterServerEvent("AQUA:HealPlayer")
-- AddEventHandler('AQUA:HealPlayer', function()
--     userid = AQUA.getUserId({source})
--     TriggerClientEvent("AQUA:SetHealth", source)
--     AQUAclient.notify(source,{"~g~You have been healed, free of charge."})
-- end)

RegisterNetEvent('AQUA:reviveRadial')
AddEventHandler('AQUA:reviveRadial', function()
    local player = source
    AQUAclient.getNearestPlayer(player,{4},function(nplayer)
        TriggerClientEvent('AQUA:cprAnim', player, nplayer)
    end)
end)

RegisterNetEvent("AQUA:SendFixClient")
AddEventHandler("AQUA:SendFixClient", function(player)
    TriggerClientEvent("AQUA:FixClient", player)
end)