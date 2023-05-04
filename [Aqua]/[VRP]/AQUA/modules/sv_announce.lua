local Tunnel = module('AQUA', 'lib/Tunnel')
local Proxy = module('AQUA', 'lib/Proxy')
AQUA = Proxy.getInterface("AQUA")
AQUAclient = Tunnel.getInterface("AQUA", "AQUA_Announce")


RegisterServerEvent("AQUA:announceRestart")
AddEventHandler("AQUA:announceRestart", function(a, b)
    local c = math.floor(tonumber(a))
    if a ~= nil then
        while c ~= -1 do
            TriggerClientEvent("AQUA:displayRestart", -1, c, b)
            c = c - 1
            Wait(1000)
        end
    end
end)

RegisterServerEvent("AQUA:Announce")
AddEventHandler("AQUA:Announce", function(d)
    if d ~= nil then
        TriggerClientEvent("AQUA:displayAnnouncement", -1, d)
    end
end)

RegisterServerEvent("AQUA:announceRestart")
AddEventHandler("AQUA:announceRestart", function(time, isScheduled)
    if time ~= nil then
        TriggerClientEvent("AQUA:displayRestartAnnouncement", -1, time, isScheduled)
    end
end)