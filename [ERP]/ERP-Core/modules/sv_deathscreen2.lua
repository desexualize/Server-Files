RegisterServerEvent('huyax:deathscreen:playerDied')
AddEventHandler('huyax:deathscreen:playerDied',function(id, killer, reason)
	--TriggerClientEvent('huyax:deathscreen:showNotification', -1, id, GetPlayerName(source), killer)
	webhook = "https://discord.com/api/webhooks/1001564589231710368/bojdlBuXN1xFmWZuC3eqyzhcex2hfwtTVRDD-pJqH78LJSRvArd9YTGAsXMyNr92BH6F"
	if killer ~= nil then 


		PerformHttpRequest(webhook, function(err, text, headers) 
		end, "POST", json.encode({username = "Element RP", embeds = {
			{
				["color"] = "16777215",
				["title"] = ""..killer.. " has Killed " .. GetPlayerName(source),
				["description"] = "Killer Name **"..killer.."** \nKiller PermID: **"..vRP.getUserId({source}).."**\nDead Name: **"..GetPlayerName(source).."**\nDead PermID: **"..vRP.getUserId({source}).. "**",
				["footer"] = {
				  ["text"] = "Element RP - "..os.date("%X"),
				}
		}
		}}), { ["Content-Type"] = "application/json" })
	else
		PerformHttpRequest(webhook, function(err, text, headers) 
		end, "POST", json.encode({username = "Element RP", embeds = {
			{
				["color"] = "16777215",
				["title"] = ""..GetPlayerName(source).. " has Died",
				["description"] = "**\nUser Name: **"..GetPlayerName(source).."**\nUser PermID: **"..vRP.getUserId({source}).. "**",
				["footer"] = {
				  ["text"] = "Element RP - "..os.date("%X"),
				}
		}
		}}), { ["Content-Type"] = "application/json" })
	end
end)
