local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local vRP = Proxy.getInterface("vRP")
local vRPclient = Tunnel.getInterface("vRP","vRP")


-- Sync Deaths/Kills
RegisterNetEvent('KillFeed:Killed')
AddEventHandler('KillFeed:Killed', function(killer, weapon, killedCoords, killerCoords, weapon_hash)
    local distance = math.floor(#(killedCoords - killerCoords))

    local user_id = vRP.getUserId({source})
    local killer_id = vRP.getUserId({killer})

    if vRP.hasPermission({user_id, "pd.armory"}) then
        killedGroup = "pd"
    elseif vRP.hasPermission({user_id, "NHS"}) then -- not in yet
        killedGroup = "nhs"
    else
        killedGroup = "killed"
    end

    if vRP.hasPermission({killer_id, "pd.armory"}) then
        killerGroup = "pd"
    elseif vRP.hasPermission({killer_id, "NHS"}) then -- not in yet
        killerGroup = "nhs"
    else
        killerGroup = "killer"
    end

    TriggerClientEvent('KillFeed:AnnounceKill', -1, GetPlayerName(source), GetPlayerName(killer), weapon, distance, killedCoords, killerGroup, killedGroup)
    TriggerEvent("GBRP:KillLogsKilledBy", source, killer, weapon)
end)

RegisterNetEvent('KillFeed:Died')
AddEventHandler('KillFeed:Died', function(coords)
    local user_id = vRP.getUserId({source})

    if vRP.hasPermission({user_id, "pd.armory"}) then
        killedGroup = "pd"
    elseif vRP.hasPermission({user_id, "NHS"}) then -- not in yet
        killedGroup = "nhs"
    else
        killedGroup = "killed"
    end

    TriggerClientEvent('KillFeed:AnnounceDeath', -1, GetPlayerName(source), coords, killedGroup)
    TriggerEvent("GBRP:KillLogsCommitedSuicide", source)
end)