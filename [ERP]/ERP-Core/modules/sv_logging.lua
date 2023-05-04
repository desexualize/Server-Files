
----------------------------------------------
----------------------------------------------
---------- Blanky's Logging System -----------
----------------------------------------------
----------------------------------------------

local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP_gunshop")



-- Collecting Values --

local webhook = "https://discord.com/api/webhooks/1001565160349122571/AS0DVIakIpKT8JQtPaZkeVpdqI0IEXwW5BvgZiHL7kCeO8o9LNc2Dp3Nplt3pui9HlyN"
local name = "Leave/ Join Logs"
local logo = "" -- Must end with png, jpg e.t.c.

-- Player Connecting Event --
AddEventHandler('playerConnecting', function()
    local playerName = GetPlayerName(source)
    local user_id = "**Not Working**"
    local playerHex = GetPlayerIdentifier(source)
    local playerPing = GetPlayerPing(source)
    local identifiers = ExtractIdentifiers(source)
    local license = identifiers.license
    local discord ="<@" ..identifiers.discord:gsub("discord:", "")..">" 
    local connecting = {
        {
            ["color"] = "16777215",
            ["title"] = "Player Joining:",
            ["description"] = "User Name: **"..playerName.."**\nPerm ID: **"..user_id.."\nDiscord Tag: **" .. discord .. "**",
	        ["footer"] = {
                ["text"] = "Element RP - "..os.date("%X"),
                ["icon_url"] = logo,
            },
        }}

PerformHttpRequest(webhook, function (err, text, headers) end, 'POST', json.encode({username = name, embeds = connecting}), { ['Content-Type'] = 'application/json' })
end)

AddEventHandler('playerDropped', function(reason)
    local identifiers = ExtractIdentifiers(source)
    local playerName = GetPlayerName(source)
    local playerHex = GetPlayerIdentifier(source)
    local playerId = source
    local identifiers = ExtractIdentifiers(source)
    local license = identifiers.license
    local discord ="<@" ..identifiers.discord:gsub("discord:", "")..">" 
    local disconnecting = {
        {
            ["color"] = "16777215",
            ["title"] = "Player Leaving:",
            ["description"] = "User Name: **"..playerName.."**\nPerm ID: **"..vRP.getUserId({source}).."\nDiscord Tag: **" .. discord .. "**",
            ["footer"] = {
                ["text"] = "Element RP - "..os.date("%X"),
                ["icon_url"] = logo,
            },
        }
    }

    PerformHttpRequest(webhook, function (err, text, headers) end, 'POST', json.encode({username = name, embeds = disconnecting}), { ['Content-Type'] = 'application/json' })
end)




-- FUNCTIONS TO GET EXTRA IDENTIFIERS
function ExtractIdentifiers(src)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = ""
    }

    for i = 0, GetNumPlayerIdentifiers(source) - 1 do
        local id = GetPlayerIdentifier(source, i)

        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "ip") then
            identifiers.ip = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "license") then
            identifiers.license = id
        elseif string.find(id, "xbl") then
            identifiers.xbl = id
        elseif string.find(id, "live") then
            identifiers.live = id
        end
    end

    return identifiers
end