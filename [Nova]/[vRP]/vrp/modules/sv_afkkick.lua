local Webhooks = {
	['LFB'] = 'https://discord.com/api/webhooks/1019590346717532281/NZkJfzbX2eTr4VlgrOrLAFBzwfgzszR583JqC13nGANN060R6BJ7cjB2Efuy6qlVeyR9',
	['NHS'] = 'https://discord.com/api/webhooks/1019596630376333393/vzWr2h3Fpcl4KZg2xRYxig3wXzrEFjxtauFuG8TP_i4C9OQgkxdnzKArt3prY7PxgLE9',
	['HMP'] = 'https://discord.com/api/webhooks/1019596832713748482/4z27HBbSkEnrY9-KBQSjgWRv_BHKXhFYob7TJG_ovk67WyvSGEEW8fBNVWuzRWbhDIkh',
	['MPD'] = 'https://discord.com/api/webhooks/1019597003942014976/l4dpX30Xn4qrURZUtAprE1rw-YVeYklTPRGIfAwyoCQzgb_deK8C3hn5BCUI8toFNppN',
}

RegisterNetEvent('Nova:Server:SendAFKLog')
AddEventHandler('Nova:Server:SendAFKLog', function(faction_name, afk_text)
	local source = source
	local user_id = vRP.getUserId(source)

	local user_discord = exports['Discord-Groups']:Get_Client_Discord_ID(source)
	if user_discord then
        user_discord = ('<@%s>'):format(user_discord)
    else
        user_discord = 'Not Available'
    end

	local afk_embed = {
		['title'] = 'Nova AFK Logs',
		['color'] = exports['vrp']:Get_Faction_Embed_Colour(faction_name),
		['fields'] = {
			{
				['name'] = 'User ID',
				['value'] = user_id,
				['inline'] = false,
			},
			{
				['name'] = 'User Name',
				['value'] = GetPlayerName(source),
				['inline'] = false,
			},
			{
				['name'] = 'Discord',
				['value'] = user_discord,
				['inline'] = false,
			},
			{
				['name'] = 'AFK Status',
				['value'] = afk_text,
				['inline'] = false,
			},
		},
		['footer'] = {
			['text'] = os.date('%d/%m/%Y - %H:%M:%S')
		},
	}

	local afk_webhook = Webhooks[faction_name]
    PerformHttpRequest(afk_webhook, function(err, text, headers)
    end, "POST", json.encode({embeds = {afk_embed}}), {["Content-Type"] = "application/json"})
end)

RegisterNetEvent("Nova:AFKKick")
AddEventHandler("Nova:AFKKick", function()
	DropPlayer(source, "You were AFK for too long!")
end)