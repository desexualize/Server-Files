local weapons=module("cfg/weapons")
RegisterNetEvent('FNR:onPlayerKilled')
AddEventHandler('FNR:onPlayerKilled', function(killtype, killerid,weapon,suicide, distance)
    local source = source
    local user_id = vRP.getUserId(source)
    local killer_id = vRP.getUserId(killerid)
    local killergroup = 'none'
    local killedgroup = 'none'
    local weaponclass = 'suicide'
    -- Weapon class
    for r,s in pairs(weapons.weapons)do 
        if weapon == s.name then
        weaponclass = s.class
        end
    end
    if distance ~= nil then
        distance = math.floor(distance)
    end
    if vRP.hasPermission(user_id, "pd.armory") then
        victimGroup = "police"
    elseif vRP.hasPermission(user_id, "NHS") then
        victimGroup = "nhs"
    else
        victimGroup = "none"
    end
    if vRP.hasPermission(killer_id, "pd.armory") then
        killerGroup = "police"
    elseif vRP.hasPermission(killer_id, "NHS") then
        killerGroup = "nhs"
    else
        killerGroup = "none"
    end
    if killtype == 'killed' then
        if suicide == true then
            TriggerClientEvent('FNR:newKillFeed', -1, GetPlayerName(source), GetPlayerName(source), "suicide", true, distance, victimGroup, victimGroup)
        else
            TriggerClientEvent('FNR:newKillFeed', -1, GetPlayerName(killerid), GetPlayerName(source), weaponclass, false, distance, victimGroup, killerGroup)
        end
    elseif killtype == 'finished off' and killer ~= nil then -- if the killer is nil, it means the player killed themselves
        -- Kill log
        -- Killer ID & Weapon
        return
    end
end)