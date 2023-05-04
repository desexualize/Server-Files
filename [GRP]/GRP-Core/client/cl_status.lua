

SetDiscordAppId(934914569648869417)

Citizen.CreateThread(function()
	while true do
		SetDiscordRichPresenceAsset('grpmain') 
		SetDiscordRichPresenceAssetText("Galaxy") 
		SetDiscordRichPresenceAssetSmall('grpsmall') -- Name of the smaller image asset.
		SetDiscordRichPresenceAssetSmallText('discord.gg/grpuk')
		SetRichPresence("" ..#GetActivePlayers().. "/" .. "64" .. " Players") 
		SetDiscordRichPresenceAction(0, 'Discord', 'discord.gg/grpuk')

		Wait(5000)
	end
end)


-- SetDiscordAppId(934914569648869417)
-- 
-- Citizen.CreateThread(function()
-- 	while true do
-- 		SetDiscordRichPresenceAsset('GalaxyRPlogo') 
-- 		SetDiscordRichPresenceAssetText('Galaxy RP') 
-- 		SetDiscordRichPresenceAssetSmall('Galaxy') -- Name of the smaller image asset.
-- 		SetDiscordRichPresenceAssetSmallText('discord.gg/grpuk')
-- 		SetRichPresence("" ..#GetActivePlayers().. "/" .. "128" .. " Players") 
-- 		SetDiscordRichPresenceAction(0, 'Discord', 'discord.gg/grpuk')
-- 		SetDiscordRichPresenceAction(1, 'Forums', 'https://galaxyrp.co.uk')
-- 		Wait(5000)
-- 	end
-- end)


