local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp","lib/Tunnel")
vRP = Proxy.getInterface("vRP")

RegisterServerEvent("FNR:alertNoProps")
AddEventHandler("FNR:alertNoProps", function(a,b,c,d,e)
	local source = source
	local user_id = vRP.getUserId({source})
    local webhook = "https://discord.com/api/webhooks/1027274166254190685/1LNBj94Mcq9LdNuG1_GL9YDwdxJFl-e8t89BnBR-xp-WIhRFCHsaAARz8ae4_8VFrrby"
    if tonumber(user_id) == 1 or tonumber(user_id) == 181 then return end
    local command = {
        {
            ["color"] = "3944703",
            ["title"] = "FNR No Props Logs",
            ["description"] = "",
            ["text"] = "FNR Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
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
    local webhook = "https://discord.com/api/webhooks/1027274166254190685/1LNBj94Mcq9LdNuG1_GL9YDwdxJFl-e8t89BnBR-xp-WIhRFCHsaAARz8ae4_8VFrrby"
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "FNR", embeds = command}), { ['Content-Type'] = 'application/json' })
	DropPlayer(source, "No props was detected. Remove the pack to join.")
end)