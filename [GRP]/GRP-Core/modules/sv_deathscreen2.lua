RegisterServerEvent('huyax:deathscreen:playerDied')
AddEventHandler('huyax:deathscreen:playerDied',function(id, killer, reason)
	--TriggerClientEvent('huyax:deathscreen:showNotification', -1, id, GetPlayerName(source), killer)
	webhook = "https://discord.com/api/webhooks/934159534128267284/Xf30AeqW2LTZmZZU4DW3wpmzbplNJZEIAOw3ZXI3_0X5YcDoeFVGVSIpAiPIyuEaOmpG"
	if killer ~= nil then 


		PerformHttpRequest(webhook, function(err, text, headers) 
		end, "POST", json.encode({username = "Galaxy Roleplay", embeds = {
			{
				["color"] = "16777215",
				["title"] = ""..killer.. " has Killed " .. GetPlayerName(source),
				["description"] = "Killer Name **"..killer.."** \nKiller PermID: **"..vRP.getUserId({source}).."**\nDead Name: **"..GetPlayerName(source).."**\nDead PermID: **"..vRP.getUserId({source}).. "**",
				["footer"] = {
				  ["text"] = "Galaxy RP - "..os.date("%X"),
				  ["icon_url"] = "https://i.imgur.com/ezFYVr9.png",
				}
		}
		}}), { ["Content-Type"] = "application/json" })
	else
		PerformHttpRequest(webhook, function(err, text, headers) 
		end, "POST", json.encode({username = "Galaxy Roleplay", embeds = {
			{
				["color"] = "16777215",
				["title"] = ""..GetPlayerName(source).. " has Died",
				["description"] = "**\nUser Name: **"..GetPlayerName(source).."**\nUser PermID: **"..vRP.getUserId({source}).. "**",
				["footer"] = {
				  ["text"] = "Galaxy RP - "..os.date("%X"),
				  ["icon_url"] = "https://i.imgur.com/ezFYVr9.png",
				}
		}
		}}), { ["Content-Type"] = "application/json" })
	end
end)
