local cfg = module("cfg/survival")
local lang = AQUA.lang

-- api

function tAQUA.respawnPlayer()
    exports.spawnmanager:forceRespawn()
    exports.spawnmanager:spawnPlayer()
    playerCanRespawn = false 
    DeathString = ""
    secondsTilBleedout = 60
    TriggerEvent("AQUA:FixClient")
    local ped = GetPlayerPed(-1)
    tAQUA.reviveComa()
end



-- tunnel api (expose some functions to clients)


-- tasks


-- handlers

-- init values
AddEventHandler("AQUA:playerJoin", function(user_id, source, name, last_login)
    local data = AQUA.getUserDataTable(user_id)
end)

-- add survival progress bars on spawn
AddEventHandler("AQUA:playerSpawn", function(user_id, source, first_spawn)
    local data = AQUA.getUserDataTable(user_id)
    AQUAclient.setPolice(source, {cfg.police})
    AQUAclient.setFriendlyFire(source, {cfg.pvp})
end)

-- EMERGENCY

RegisterServerCallback("AQUA:FetchKillerID", function(source, killer)
    local ReturnID = AQUA.getUserId(killer)
    if ReturnID ~= nil then
        return ReturnID;
    else
        return false;
    end
end)

---- revive
local revive_seq = {{"amb@medic@standing@kneel@enter", "enter", 1}, {"amb@medic@standing@kneel@idle_a", "idle_a", 1},
                    {"amb@medic@standing@kneel@exit", "exit", 1}}

local choice_revive = {function(player, choice)
    local user_id = AQUA.getUserId(player)
    if user_id ~= nil then
        AQUAclient.getNearestPlayer(player, {10}, function(nplayer)
            local nuser_id = AQUA.getUserId(nplayer)
            if nuser_id ~= nil then
                AQUAclient.isInComa(nplayer, {}, function(in_coma)
                    if in_coma then
                        if AQUA.tryGetInventoryItem(user_id, "medkit", 1, true) then
                            AQUAclient.playAnim(player, {false, revive_seq, false}) -- anim
                            SetTimeout(15000, function()
                                AQUAclient.varyHealth(nplayer, {50}) -- heal 50
                            end)
                        end
                    else
                        AQUAclient.notify(player, {lang.emergency.menu.revive.not_in_coma()})
                    end
                end)
            else
                AQUAclient.notify(player, {lang.common.no_player_near()})
            end
        end)
    end
end, lang.emergency.menu.revive.description()}

-- add choices to the main menu (emergency)
AQUA.registerMenuBuilder("main", function(add, data)
    local user_id = AQUA.getUserId(data.player)
    if user_id ~= nil then
        local choices = {}
        if AQUA.hasPermission(user_id, "emergency.revive") then
            choices[lang.emergency.menu.revive.title()] = choice_revive
        end

        add(choices)
    end
end)

RegisterNetEvent("AQUA:KillLogsCommitedSuicide")
AddEventHandler('AQUA:KillLogsCommitedSuicide', function(killed)
    local source = source
    local name = GetPlayerName(killed)
    local user_id = AQUA.getUserId(killed)
    local KillEmbed = {
        {
            ["color"] = "16777215",
            ["title"] = "**Player Name: **"..name.."\n**Player Perm ID:** "..user_id.."\n**Death Reason: ** Committed Suicide",
            ["description"] = "",
            ["footer"] = {
                ["text"] = os.date("%x %X %p"),
    
            }
        }
    }
    PerformHttpRequest("https://discord.com/api/webhooks/1059088594725244968/WZvIm74qp3JkJRD6NEBPQ_N9D3p5g622Jx9yUp41RTldAL1gJmv6apIZLWpzLFmFVBqs", function(err, text, headers) end, "POST", json.encode({username = "Kill Logs", embeds = KillEmbed}), { ["Content-Type"] = "application/json" })
end)


RegisterNetEvent("AQUA:KillLogsKilledBy")
AddEventHandler('AQUA:KillLogsKilledBy', function(killed,killer, weapon)
    local source = source
    local name = GetPlayerName(killed)
    local user_id = AQUA.getUserId(killed)
    local killername = GetPlayerName(killer)
    local killerpermid = AQUA.getUserId(killer)
 
    local KillEmbed = {
        {
            ["color"] = "16777215",
            ["title"] = "**Player Name: **"..name.."\n**Player Perm ID:** "..user_id.."\n**Killer Name: **"..killername.."\n**Killer Perm ID: **"..killerpermid.."**\nWeapon** "..weapon,
            ["description"] = "",
            ["footer"] = {
                ["text"] = os.date("%x %X %p"),
    
            }
        }
    }
    PerformHttpRequest("https://discord.com/api/webhooks/1059088594725244968/WZvIm74qp3JkJRD6NEBPQ_N9D3p5g622Jx9yUp41RTldAL1gJmv6apIZLWpzLFmFVBqs", function(err, text, headers) end, "POST", json.encode({username = "Kill Logs", embeds = KillEmbed}), { ["Content-Type"] = "application/json" })
end)



