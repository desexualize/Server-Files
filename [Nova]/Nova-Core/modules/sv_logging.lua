----------------------------------------------
----------------------------------------------
---------- Blanky's Logging System -----------
----------------------------------------------
----------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP_gunshop")

-- Collecting Values --
local webhook_urls = {
    'https://discord.com/api/webhooks/1012748649475870730/MWu1edTedzkZCi-53HhmhmcG8RTTwcrA8uPDGZm8-elQ21sgZOX_kpV2QeqN1fwsA2F9', -- Logs Server Join / Leave
    "https://discord.com/api/webhooks/1012348890223218781/sdrLF18b9zGPLu8ZnxCBNOj-GR5tjeWLY84i99Oq3UItyryXG0CKteGLEPu4drAk2AnE", -- Main Server Join / Leave
}
local name = "Leave & Join Logs"
local logo = "https://imgur.com/a/wbOuAKi" -- Must end with png, jpg e.t.c.

-- Player Connecting Event --
--RegisterNetEvent('vRP:playerJoin')
AddEventHandler('vRP:playerJoin', function(user_id, player_source, playerName)
    --[[
    local player_id = player_source
    local playerName = GetPlayerName(player_id)
    local playerIp = "**[Hidden]**"
    local playerHex = GetPlayerIdentifier(player_id)
    local playerPing = GetPlayerPing(player_id)
    ]]
    local connecting_embeds = {
        {
            ["color"] = "16777215",
            ["title"] = "Player Joining:",
            ["description"] = string.format('User Name: **%s**\n\nPerm ID: **%s**', playerName, user_id),
            ["footer"] = {
                ["text"] = "Nova - " .. os.date("%X"),
                ["icon_url"] = logo
            }
        }
    }

    -- Sending Embed To Discord Webhook --
    for i, webhook in pairs(webhook_urls) do
        PerformHttpRequest(webhook, function(err, text, headers)
            end, "POST", json.encode({username = name, embeds = connecting_embeds}), {["Content-Type"] = "application/json"}
        )
    end
end)

-- Player Disconnecting Event --
---RegisterNetEvent('vRP:playerLeave')
AddEventHandler('vRP:playerLeave', function(user_id, player_source, reason)
    --[[
    local player_id = player_source
    local playerName = GetPlayerName(player_id)
    local playerIp = "**[Hidden]**"
    local playerPing = GetPlayerPing(player_id)
    local playerHex = GetPlayerIdentifier(player_id)
    ]]
    local playerName = GetPlayerName(player_source)

    local disconnecting = {
        {
            ["color"] = "16777215",
            ["title"] = "Player Leaving:",
            ["description"] = string.format('User Name: **%s**\n\nReason: *%s*\n\nPerm ID: *%s*', playerName, reason, user_id),
            ["footer"] = {
                ["text"] = "Nova - " .. os.date("%X"),
                ["icon_url"] = logo
            }
        }
    }

    for i, webhook in pairs(webhook_urls) do
        PerformHttpRequest(webhook, function(err, text, headers)
            end, "POST", json.encode({username = name, embeds = disconnecting}), {["Content-Type"] = "application/json"}
        )
    end
end)
