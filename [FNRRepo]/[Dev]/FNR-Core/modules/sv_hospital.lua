local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "Hospital")

-- RegisterServerEvent("FNR:HealPlayer")
-- AddEventHandler('FNR:HealPlayer', function()
--     userid = vRP.getUserId({source})
--     TriggerClientEvent("FNR:SetHealth", source)
--     vRPclient.notify(source,{"~g~You have been healed, free of charge."})
-- end)

RegisterNetEvent('FNR:reviveRadial')
AddEventHandler('FNR:reviveRadial', function()
    local player = source
    vRPclient.getNearestPlayer(player,{4},function(nplayer)
        TriggerClientEvent('FNR:cprAnim', player, nplayer)
    end)
end)

RegisterNetEvent("FNR:SendFixClient")
AddEventHandler("FNR:SendFixClient", function(player)
    TriggerClientEvent("FNR:FixClient", player)
end)