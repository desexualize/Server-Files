local locales = dstatus.Locales[dstatus.Locale]

Citizen.CreateThread(function()
    while true do
	if dstatus.MessageId ~= nil and dstatus.MessageId ~= '' then
		UpdateStatusMessage()
	else
		DeployStatusMessage()
		break
	end

	Citizen.Wait(dstatus.UpdateTime)
    end
end)


function DeployStatusMessage()
	local footer = nil

	if dstatus.Use24hClock then
		footer = os.date(locales['date']..': %d/%m/%Y  |  '..locales['time']..': %H:%M')
	else
		footer = os.date(locales['date']..': %d/%m/%Y  |  '..locales['time']..': %I:%M %p')
	end

	if dstatus.Debug then
		print('Deplying Status Message ['..footer..']')
	end

	local embed = {
		{
			["color"] = dstatus.EmbedColor,
			["title"] = "** Deploying Status Message!**",
			["description"] = 'Copy this message id and put it into dstatus and restart script!',
			["footer"] = {
				["text"] = footer,
			},
		}
	}

	PerformHttpRequest(dstatus.Webhook, function(err, text, headers) end, 'POST', json.encode({
		embeds = embed, 
	}), { ['Content-Type'] = 'application/json' })
end


function UpdateStatusMessage()
	local players = #GetPlayers()
	local maxplayers = GetConvarInt('sv_maxclients', 0)
	local footer = nil

	if dstatus.Use24hClock then
		footer = os.date(locales['date']..': %d/%m/%Y  |  '..locales['time']..': %H:%M')
	else
		footer = os.date(locales['date']..': %d/%m/%Y  |  '..locales['time']..': %I:%M %p')
	end

	if dstatus.Debug then
		print('Updating Status Message ['..footer..']')
	end


	local message = json.encode({
		embeds = {
			{

				["color"] = dstatus.EmbedColor,
				["title"] = '**'..dstatus.ServerName..'**',
				["description"] = ':busts_in_silhouette: '..locales['players']..': `'..players..' / '..maxplayers..'`',
				["footer"] = {
					["text"] = footer,
				},
			}
		},

		components = {
			{
				["type"] = 1,
				["components"] = {
					{
						["type"] = 2,
						["label"] = locales['connect'],
						["style"] = 5,
						["url"] = dstatus.JoinLink,
					}
				},
			}
		}
	})

	PerformHttpRequest(dstatus.Webhook..'/messages/'..dstatus.MessageId, function(err, text, headers) 
		if dstatus.Debug then
			print('[DEBUG] err=', err)
			print('[DEBUG] text=', text)
		end
	end, 'PATCH', message, { ['Content-Type'] = 'application/json' })
end



