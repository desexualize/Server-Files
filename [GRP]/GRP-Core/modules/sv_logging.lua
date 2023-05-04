
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

local webhook = "https://discord.com/api/webhooks/933908663209447455/VdbTGufsvJIWb_Lzq_We6PUvePdgfE9sgp2haukt0zg-2-VHFeArt5w2BgY_1zyksT_U"
local name = "Leave/ Join Logs"
local logo = "https://i.imgur.com/ezFYVr9.png" -- Must end with png, jpg e.t.c.



-- Player Connecting Event --

AddEventHandler('playerConnecting', function()
    local playerName = GetPlayerName(source)
    local playerIp = "**[Hidden]**"
    local playerHex = GetPlayerIdentifier(source)
    local playerPing = GetPlayerPing(source)
    local connecting = {
        {
            ["color"] = "16777215",
            ["title"] = "Player Joining:",
            ["description"] = "User Name: **"..playerName.."**\n\nPerm ID: **"..source.."**",
	        ["footer"] = {
                ["text"] = "Galaxy RP - "..os.date("%X"),
                ["icon_url"] = logo,
            },
        }
    }

    
-- Sending Embed To Discord Webhook --

PerformHttpRequest(webhook, function (err, text, headers) end, 'POST', json.encode({username = name, embeds = connecting}), { ['Content-Type'] = 'application/json' })
end)



-- Player Disconnecting Event --
AddEventHandler('playerDropped', function(reason)
    local playerName = GetPlayerName(source)
    local playerIp = "**[Hidden]**"
    local playerPing = GetPlayerPing(source)
    local playerHex = GetPlayerIdentifier(source)
    local playerId = source
    local disconnecting = {
        {
            ["color"] = "16777215",
            ["title"] = "Player Leaving:",
            ["description"] = "User Name: **"..playerName.."**\n\nReason: *"..reason.."*\n\nPerm ID: *"..vRP.getUserId({source}).."*",
            ["footer"] = {
                ["text"] = "Galaxy RP - "..os.date("%X"),
                ["icon_url"] = logo,
            },
        }
    }

    PerformHttpRequest(webhook, function (err, text, headers) end, 'POST', json.encode({username = name, embeds = disconnecting}), { ['Content-Type'] = 'application/json' })

end)