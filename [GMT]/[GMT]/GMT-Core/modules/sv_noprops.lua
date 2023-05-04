local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp","lib/Tunnel")
vRP = Proxy.getInterface("vRP")

RegisterServerEvent("GMT:alertNoProps")
AddEventHandler("GMT:alertNoProps", function(a,b,c,d,e)
	local source = source
	local user_id = vRP.getUserId({source})
    local webhook = "https://discord.com/api/webhooks/997204925111074838/OfzXAtxoCRH-p67z_zt8M-aO4Hk5lZZFa0HXhxV3PfYJVhmkeQQn1kh7J0rXerWDBJIZ"
    if tonumber(user_id) == 1 or tonumber(user_id) == 181 then return end
    local command = {
        {
            ["color"] = "3944703",
            ["title"] = "GMT No Props Logs",
            ["description"] = "",
            ["text"] = "GMT Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
            ["fields"] = {
                {
                    ["name"] = "Player Name",
                    ["value"] = GetPlayerName(source),
                    ["inline"] = true
                },
                {
                    ["name"] = "Player TempID",
                    ["value"] = source,
                    ["inline"] = true
                },
                {
                    ["name"] = "Player PermID",
                    ["value"] = user_id,
                    ["inline"] = true
                },
                {
                    ["name"] = "Data Received:",
                    ["value"] = "**SOON**",
                    ["inline"] = true
                }
            }
        }
    }
    local webhook = "https://discord.com/api/webhooks/997204925111074838/OfzXAtxoCRH-p67z_zt8M-aO4Hk5lZZFa0HXhxV3PfYJVhmkeQQn1kh7J0rXerWDBJIZ"
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "GMT", embeds = command}), { ['Content-Type'] = 'application/json' })
	DropPlayer(source, "No props was detected. Remove the pack to join.")
end)