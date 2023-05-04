
-- AQUA TUNNEL/PROXY
Tunnel = module("AQUA", "lib/Tunnel")
Proxy = module("AQUA", "lib/Proxy")
AQUA = Proxy.getInterface("AQUA")
AQUAclient = Tunnel.getInterface("AQUA","AQUA_Killfeed")


-- Sync Deaths/Kills
RegisterNetEvent('KillFeed:Killed')
AddEventHandler('KillFeed:Killed', function(killer, weapon, coords)
    local killed_id = AQUA.getUserId({source})
    local killer_id = AQUA.getUserId({killer})
    local killer_group = "citizen"
    local killed_group = "citizen"
<<<<<<< HEAD

    if AQUA.hasPermission({killer_id, "pd.armory"}) then
        killer_group = "mpd"
    elseif AQUA.hasPermission({killer_id, "emscheck.revive"}) then
        killer_group = "nhs"
    else
        killer_group = "citizen"
    end
        
    if AQUA.hasPermission({user_id, "pd.armory"}) then
        killed_group = "mpd"
    elseif AQUA.hasPermission({killed_id, "emscheck.revive"}) then
        killed_group = "nhs"
    else
        killed_group = "citizen"
    end

    local distance = #(GetEntityCoords(GetPlayerPed(killer)) - coords)
    --print(GetEntityCoords(GetPlayerPed(killer)))
    --print(coords)
    -- AQUAclient.EnableComa(source)
    local communityname = "AQUA Kill logs"
    local communtiylogo = "" --Must end with .png or .jpg 
    local logs = "https://discord.com/api/webhooks/910627414189686785/58ZF_85wEbud4UK5P_z-RUl1hZcZE_XuvhDAJzHeyQVPDG5mjN2J46AliVtlseKGe6h-"
    local command = {
        {
            ["fields"] = {
                {
                    ["name"] = "**Killer Name**",
                    ["value"] = "" ..GetPlayerName(killer),
                    ["inline"] = true
                },
                {
                    ["name"] = "**Killer TempID**",
                    ["value"] = "" ..killer,
                    ["inline"] = true
                },
                {
                    ["name"] = "**Killer PermID**",
                    ["value"] = "" ..AQUA.getUserId({killer}),
                    ["inline"] = true
                },
                {
                    ["name"] = "**Killer Group**",
                    ["value"] = "" .. killer_group,
                    ["inline"] = true
                },

=======

    if AQUA.hasPermission({killer_id, "police.menu"}) then
        killer_group = "mpd"
    elseif AQUA.hasPermission({killer_id, "emscheck.revive"}) then
        killer_group = "nhs"
    else
        killer_group = "citizen"
    end
        
    if AQUA.hasPermission({user_id, "pd.armory"}) then
        killed_group = "mpd"
    elseif AQUA.hasPermission({killed_id, "emscheck.revive"}) then
        killed_group = "nhs"
    else
        killed_group = "citizen"
    end

    local distance = #(GetEntityCoords(GetPlayerPed(killer)) - coords)
    --print(GetEntityCoords(GetPlayerPed(killer)))
    --print(coords)
    -- AQUAclient.EnableComa(source)
    local communityname = "AQUA Kill logs"
    local communtiylogo = "" --Must end with .png or .jpg 
    local logs = "https://discord.com/api/webhooks/910627414189686785/58ZF_85wEbud4UK5P_z-RUl1hZcZE_XuvhDAJzHeyQVPDG5mjN2J46AliVtlseKGe6h-"
    local command = {
        {
            ["fields"] = {
                {
                    ["name"] = "**Killer Name**",
                    ["value"] = "" ..GetPlayerName(killer),
                    ["inline"] = true
                },
                {
                    ["name"] = "**Killer TempID**",
                    ["value"] = "" ..killer,
                    ["inline"] = true
                },
                {
                    ["name"] = "**Killer PermID**",
                    ["value"] = "" ..AQUA.getUserId({killer}),
                    ["inline"] = true
                },
                {
                    ["name"] = "**Killer Group**",
                    ["value"] = "" .. killer_group,
                    ["inline"] = true
                },

>>>>>>> parent of 1db9c75 (...)
                {
                    ["name"] = "**Killed Name**",
                    ["value"] = "" ..GetPlayerName(source),
                    ["inline"] = true
                },
                {
                    ["name"] = "**Killed TempID**",
                    ["value"] = "" ..source,
                    ["inline"] = true
                },
                {
                    ["name"] = "**Killed PermID**",
                    ["value"] = "" ..AQUA.getUserId({source}),
                    ["inline"] = true
                },
                {
                    ["name"] = "**Killed Group**",
                    ["value"] = "" .. killed_group,
                    ["inline"] = true
                },
                {
                    ["name"] = "**Kill Distance**",
                    ["value"] = "" .. round(distance).."m",
                    ["inline"] = true
                },

            },
            ["color"] = "9837571",
            ["title"] = "AQUA Damage Logs",
            ["description"] = "",
            ["footer"] = {
            ["text"] = communityname,
            ["icon_url"] = communtiylogo,
            },
        }
    }
    

    PerformHttpRequest(logs, function(err, text, headers) end, 'POST', json.encode({username = "AQUA Kill Logs", embeds = command}), { ['Content-Type'] = 'application/json' })

    TriggerClientEvent('KillFeed:AnnounceKill', -1, GetPlayerName(source), GetPlayerName(killer), weapon, coords, killer_group, killed_group, distance)
end)

function round(number)
    local _, decimals = math.modf(number)
    if decimals < 0.5 then return math.floor(number) end
    return math.ceil(number)
end

RegisterNetEvent('KillFeed:Died')
AddEventHandler('KillFeed:Died', function(coords)

    local killed_id = AQUA.getUserId({source})
    local killed_group = "citizen"

    -- AQUAclient.EnableComa(source)
    if AQUA.hasPermission({user_id, "pd.armory"}) then
        killed_group = "mpd"
    elseif AQUA.hasPermission({user_id, "emscheck.revive"}) then
        killed_group = "nhs"
    else
        killed_group = "citizen"
    end

    TriggerClientEvent('KillFeed:AnnounceDeath', -1, GetPlayerName(source), coords, killed_group)
end)



AddEventHandler('weaponDamageEvent', function(sender, ev)
	damage = ev.weaponDamage
	if damage ~= 0 then
        local communityname = "AQUA Damage logs"
        local communtiylogo = "" --Must end with .png or .jpg 
        local logs = "https://discord.com/api/webhooks/910625315364159518/lvh3HTWxfIrE-wh3DdScZb6s2AUmXRzqKXEscVZa9Uy3G5IDg_QLtvL6J4--C7j8y3MK"
        local command = {
            {
                ["fields"] = {
                    {
                        ["name"] = "**Player Name**",
                        ["value"] = "" ..GetPlayerName(sender),
                        ["inline"] = true
                    },
                    {
                        ["name"] = "**Player TempID**",
                        ["value"] = "" ..sender,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "**Player PermID**",
                        ["value"] = "" ..AQUA.getUserId({sender}),
                        ["inline"] = true
                    },
                    {
                        ["name"] = "**Damage**",
                        ["value"] = "" .. damage,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "**Weapon Hash**",
                        ["value"] = "" .. ev.weaponType,
                        ["inline"] = true
                    },
                },
                ["color"] = "9837571",
                ["title"] = "AQUA Damage Logs",
                ["description"] = "",
                ["footer"] = {
                ["text"] = communityname,
                ["icon_url"] = communtiylogo,
                },
            }
        }
        
    
        PerformHttpRequest(logs, function(err, text, headers) end, 'POST', json.encode({username = "AQUA Staff Logs", embeds = command}), { ['Content-Type'] = 'application/json' })
	end
end)
