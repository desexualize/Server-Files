-- Start Up
SetConvar("emerg_killfeed_owner", "tbx-95312621a55817-07d987")


-- Sync Deaths/Kills
RegisterNetEvent('KillFeed:Killed')
AddEventHandler('KillFeed:Killed', function(killer, weapon, coords)
    TriggerClientEvent('KillFeed:AnnounceKill', -1, GetPlayerName(source), GetPlayerName(killer), weapon, coords)
end)

RegisterNetEvent('KillFeed:Died')
AddEventHandler('KillFeed:Died', function(coords)
    TriggerClientEvent('KillFeed:AnnounceDeath', -1, GetPlayerName(source), coords)
end)