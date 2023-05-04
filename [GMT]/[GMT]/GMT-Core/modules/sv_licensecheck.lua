local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')
vRP = Proxy.getInterface('vRP')

--settings-
local DISCORD_URL = "" --your own webhook--
local discordbotname = "Helper" --The username of the bot who sends the message to your discord
local permission = "police.drag" -- the permission you want to be able to access this command
local license = "driver" -- this is the license it wants to check for/ must be set up in groups.lua



RegisterCommand("checklicense", function(source)
    local player = source
    local userid = vRP.getUserId({source})
    if vRP.hasPermission({userid, permission}) then
        vRPclient.getNearestPlayer(player,{10},function(nplayer)
            local target = vRP.getUserId({nplayer})
            if target == nil then 
                vRPclient.notify(source,{"~r~No Player Nearby"})
            elseif vRP.hasGroup({target, license}) then
                vRPclient.notify(target,{"Officer is checking your driving license."})
                vRPclient.notify(source,{"~g~Driver has license."})
            else
                vRPclient.notify(source,{"~r~Driver does not a driving license."})
            end
        end)
    end
end)


 RegisterCommand("removelicense", function(source)
    local player = source 
    local userid = vRP.getUserId({source})
    local name = GetPlayerName(source)
    if vRP.hasPermission({userid, permission}) then 
        vRPclient.getNearestPlayer(player,{10},function(nplayer)
            local target = vRP.getUserId({nplayer})
            if target == nil then
                vRPclient.notify(source,{"~r~No Player Nearby"})
            elseif vRP.hasGroup({target, license}) then 
                vRP.removeUserGroup({target,license})
                vRP.removeUserGroup({target,"driver"})
                vRPclient.notify(source,{"~g~Removed Driving License from ID: " ..target})
                vRPclient.notify(target,{"~r~Officer " ..name.. " Has removed your driving license."})
                local command = {
                    {
                        ["color"] = "3944703",
                        ["title"] = "GMT Police Logs",
                        ["description"] = "",
                        ["text"] = "GMT Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
                        ["fields"] = {
                            {
                                ["name"] = "Officer Name",
                                ["value"] = GetPlayerName(source),
                                ["inline"] = true
                            },
                            {
                                ["name"] = "Officer TempID",
                                ["value"] = source,
                                ["inline"] = true
                            },
                            {
                                ["name"] = "Officer PermID",
                                ["value"] = user_id,
                                ["inline"] = true
                            },
                            {
                                ["name"] = "Player Name",
                                ["value"] = GetPlayerName(target),
                                ["inline"] = true
                            },
                            {
                                ["name"] = "Player TempID",
                                ["value"] = target,
                                ["inline"] = true
                            },
                            {
                                ["name"] = "Player PermID",
                                ["value"] = vRP.getUserId({target}),
                                ["inline"] = true
                            },
                            {
                                ["name"] = "License",
                                ["value"] = license,
                                ["inline"] = true
                            }
                        }
                    }
                }
                local webhook = "https://discord.com/api/webhooks/997206608889262261/nCUWHvQB2aIrgUHEURW-oNkk0ydtNglEuXrhk2pZD3pHVjIV53PYxu3NnojntnE1x4Sg"
                PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "GMT", embeds = command}), { ['Content-Type'] = 'application/json' })           
            else
                vRPclient.notify(source,{"~r~Driver does not have a driving license."})
            end
        end)
    end
end)

