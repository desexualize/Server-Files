RegisterNetEvent('DiscordPresence')
AddEventHandler('DiscordPresence', function(user_id, name)
	if user_id ~= nil then
		SetDiscordAppId(868129537467224064)
		SetDiscordRichPresenceAsset('erp') 
		SetDiscordRichPresenceAssetText("ERP UK") 
		SetDiscordRichPresenceAssetSmall('erp') -- Name of the smaller image asset.
		SetDiscordRichPresenceAssetSmallText('discord.gg/ERPUK')
        SetRichPresence("ID: ".. user_id .." | "..#GetActivePlayers().. "/64")
		SetDiscordRichPresenceAction(0, "Join Discord", "https://discord.gg/mubehmbQew")
	end
end)

Citizen.CreateThread(function()
	while true do
		TriggerServerEvent('GetUserID')
		Citizen.Wait(5000)
	end
end)