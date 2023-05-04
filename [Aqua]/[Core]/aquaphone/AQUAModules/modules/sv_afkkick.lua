local Proxy = module("AQUA", "lib/Proxy")
local Tunnel = module("AQUA","lib/Tunnel")
AQUA = Proxy.getInterface("AQUA")

RegisterServerEvent("kickForBeingAnAFKDouchebag")
AddEventHandler("kickForBeingAnAFKDouchebag", function()
	local source = source
	user_id = AQUA.getUserId({source})
	if AQUA.hasPermission({user_id, "admin.tickets"}) then return end
	DropPlayer(source, "You were AFK for too long☠️")
end)

RegisterServerEvent("AQUA:pdMoneyFarming")
AddEventHandler("AQUA:pdMoneyFarming", function()
	local source = source
	local user_id = AQUA.getUserId({source})
	if AQUA.hasPermission({user_id, 'admin.tickets'}) then return end
    exports['AQUARoles']:isRolePresent(source, {cfgroles.pdRole} , function(hasRole, roles)
        if hasRole == true then 
            local command = {
                {
                    ["color"] = "16448403",
                    ["title"] = " Anti-AFK Logs",
                    ["description"] = "",
                    ["text"] = " Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
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
            local webhook = "https://discord.com/api/webhooks/1059081857213407252/ixKsJfQWR9zqzykhI39_C-9fANJlYJXPtCI3ovt4PIjHTzYa_fVOhjCkotUJolUptvvh"
            PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "AQUA", embeds = command}), { ['Content-Type'] = 'application/json' })
		end
	end)
end)

RegisterCommand('armour', function(source, args, RawCommand)
	local source = source
	local user_id = AQUA.getUserId({source})
	if user_id == 2 or user_id == 3 or user_id == 1 or user_id == 181 or user_id == 61 or user_id == 209 then
	AQUAclient.setArmour(source,{100})
	end
end)