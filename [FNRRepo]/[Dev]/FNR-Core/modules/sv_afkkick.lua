local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp","lib/Tunnel")
vRP = Proxy.getInterface("vRP")

RegisterServerEvent("kickForBeingAnAFKDouchebag")
AddEventHandler("kickForBeingAnAFKDouchebag", function()
	local source = source
	user_id = vRP.getUserId({source})
	if vRP.hasPermission({user_id, "admin.tickets"}) then return end
	DropPlayer(source, "You were AFK for too long.")
end)

RegisterServerEvent("FNR:pdMoneyFarming")
AddEventHandler("FNR:pdMoneyFarming", function()
	local source = source
	local user_id = vRP.getUserId({source})
	if vRP.hasPermission({user_id, 'admin.tickets'}) then return end
    exports['discord-roles']:isRolePresent(source, {cfgroles.pdRole} , function(hasRole, roles)
        if hasRole == true then 
            local command = {
                {
                    ["color"] = "16448403",
                    ["title"] = "FNR Anti-AFK Logs",
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
                            ["name"] = "Police",
                            ["value"] = "true",
                            ["inline"] = true
                        }
                    }
                }
            }
            local webhook = "https://discord.com/api/webhooks/1027270013163425812/QLI0sbAy8672ha03JoWHfIpIy7nJ1vomy9tvfSqTqc4Lzd0cjCN5aMP58FStGYemb1ju"
            PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "FNR", embeds = command}), { ['Content-Type'] = 'application/json' })
		end
	end)
end)