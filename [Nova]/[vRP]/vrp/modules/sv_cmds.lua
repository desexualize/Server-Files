local ChatCooldown = 0
local lstmsg = nil

local Chat_Logs_Webhook = 'https://discord.com/api/webhooks/1012508981652111361/NM9eOpYlNUm8Ex6tF9MI4QGf0Ar-Fn74u3YpTGS7X_rxT8UUvTRwvklQoNAqat0GeA9u'


RegisterCommand("a", function(source, args, rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)   
    if vRP.hasPermission(user_id, 'admin.menu') then
        local msg = rawCommand:sub(2)
        local playerName =  " ^7Staff Chat | " .. GetPlayerName(source)..": "

        local server_players = GetPlayers()
        for i, temp_id in pairs(server_players) do 
            local player_user_id = vRP.getUserId(temp_id)   
            if vRP.hasPermission(player_user_id, "admin.menu") then
                TriggerClientEvent('chatMessage',
                    temp_id, 
                    playerName,
                    {255, 255, 255},
                    msg,
                    'staff'
                )
            end
        end
    else
        vRPclient.notify(source, {'You are not part of the staff team'})
    end
end)

local Faction_Permissions = {'police.menu', 'nhs.menu', 'lfb.menu', 'hmp.menu'}
local function Has_Faction_Permission(user_id)
    for table_id, permission_name in ipairs(Faction_Permissions) do
		if vRP.hasPermission(user_id, permission_name) then
			return true
		end
	end
	return false
end

RegisterCommand("f", function(source, args, rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)   
    if Has_Faction_Permission(user_id) then
        local msg = rawCommand:sub(2)
        local playerName =  " ^7[Faction Chat] | " .. GetPlayerName(source)..": "

        local server_players = GetPlayers()
        for i, temp_id in pairs(server_players) do 
            local player_user_id = vRP.getUserId(temp_id)   
            if Has_Faction_Permission(player_user_id) then
                TriggerClientEvent('chatMessage',
                    temp_id, 
                    playerName,
                    {255, 255, 255},
                    msg,
                    'faction'
                )
            end
        end
    else
        vRPclient.notify(source, {'You are not apart of any whitelisted factions!'})

    end
end)

RegisterCommand("p", function(source, args, rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)   
    if vRP.hasPermission(user_id, 'police.menu') then
        local msg = rawCommand:sub(2)
        local playerName =  " ^7[Police Chat] | " .. GetPlayerName(source)..": "

        local server_players = GetPlayers()
        for i, temp_id in pairs(server_players) do 
            local player_user_id = vRP.getUserId(temp_id)   
            if vRP.hasPermission(player_user_id, 'police.menu') then
                TriggerClientEvent('chatMessage',
                    temp_id, 
                    playerName,
                    {255, 255, 255},
                    msg,
                    'police'
                )
            end
        end
    else
        vRPclient.notify(source, {'You are not apart of the police!'})

    end
end)

--Dispatch Message
RegisterCommand("anon", function(source, args, raw)
	if #args <= 0 then
		return
	end
	local source = source
	local name = GetPlayerName(source)
	local message = table.concat(args, " ")
	local user_id = vRP.getUserId(source)
	local command = {
		{
			["color"] = "16448403",
			["title"] = "Nova Chat Logs",
			["description"] = "```" .. message .. "```",
			["text"] = "Nova Server #1",
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
					["name"] = "Player Hours",
					["value"] = "0 hours",
					["inline"] = true
				},
				{
					["name"] = "Chat Type",
					["value"] = "Anon",
					["inline"] = true
				}
			}
		}
	}

	PerformHttpRequest(
		Chat_Logs_Webhook,
		function(err, text, headers)
		end,
		"POST",
		json.encode({username = "Nova", embeds = command}),
		{["Content-Type"] = "application/json"}
	)
	Wait(100)
	if ChatCooldown == 0 then
		TriggerClientEvent("chatMessage", -1, "^4Twitter @^1Anonymous: ", {255, 0, 0}, message, "ooc")
		ChatCooldown = 3
	end
end)

local function OOC_Message(source, args, raw)
	if #args <= 0 then
		return
	end
	local source = source
	local name = GetPlayerName(source)
	local message = table.concat(args, " ")
	local user_id = vRP.getUserId(source)
	lastmsg = message
	local command = {
		{
			["color"] = "16448403",
			["title"] = "Nova Chat Logs",
			["description"] = "```" .. lastmsg .. "```",
			["text"] = "Nova Server #1",
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
					["name"] = "Player Hours",
					["value"] = "0 hours",
					["inline"] = true
				},
				{
					["name"] = "Chat Type",
					["value"] = "OOC",
					["inline"] = true
				}
			}
		}
	}

	PerformHttpRequest(
		Chat_Logs_Webhook,
		function(err, text, headers)
		end,
		"POST",
		json.encode({username = "Nova", embeds = command}),
		{["Content-Type"] = "application/json"}
	)
	Wait(100)
	if lastmsg ~= nil then
		if ChatCooldown == 0 then
			if vRP.hasGroup(user_id, "founder") then
				TriggerClientEvent(
					"chatMessage",
					-1,
					"^7^*OOC ^7^r |^8 Founder ^7^r" .. GetPlayerName(source) .. "^7 : ",
					{128, 128, 128},
					message,
					"ooc"
				)
				ChatCooldown = 0
			elseif vRP.hasGroup(user_id, "cofounder") then
				TriggerClientEvent(
					"chatMessage",
					-1,
					"^7^*OOC ^7^r |^8 Co-Founder ^7^r" .. GetPlayerName(source) .. "^7 : ",
					{128, 128, 128},
					message,
					"ooc"
				)
				ChatCooldown = 0
			elseif vRP.hasGroup(user_id, "dev") then
				TriggerClientEvent(
					"chatMessage",
					-1,
					"^7^*OOC ^7^r |^1 Developer ^7^r" .. GetPlayerName(source) .. "^7 : ",
					{128, 128, 128},
					message,
					"ooc"
				)
				ChatCooldown = 0
			elseif vRP.hasGroup(user_id, "commanager") then
				TriggerClientEvent(
					"chatMessage",
					-1,
					"^7^*OOC ^7^r |^6 Community Manager ^7^r" .. GetPlayerName(source) .. "^7 : ",
					{128, 128, 128},
					message,
					"ooc"
				)
				ChatCooldown = 3
			elseif vRP.hasGroup(user_id, "staffmanager") then
				TriggerClientEvent(
					"chatMessage",
					-1,
					"^7^*OOC ^7^r |^9 Staff Manager ^7^r" .. GetPlayerName(source) .. "^7 : ",
					{128, 128, 128},
					message,
					"ooc"
				)
				ChatCooldown = 3
			elseif vRP.hasGroup(user_id, "headadmin") then
				TriggerClientEvent(
					"chatMessage",
					-1,
					"^7^*OOC ^7^r |^3 Head Admin ^7^r" .. GetPlayerName(source) .. "^7 : ",
					{128, 128, 128},
					message,
					"ooc"
				)
				ChatCooldown = 3
			elseif vRP.hasGroup(user_id, "senioradmin") then
				TriggerClientEvent(
					"chatMessage",
					-1,
					"^7^*OOC ^7^r |^3 Senior Admin ^7^r" .. GetPlayerName(source) .. "^7 : ",
					{128, 128, 128},
					message,
					"ooc"
				)
				ChatCooldown = 3
			elseif vRP.hasGroup(user_id, "administrator") then
				TriggerClientEvent(
					"chatMessage",
					-1,
					"^7^*OOC ^7^r |^4 Administrator ^7^r" .. GetPlayerName(source) .. "^7 : ",
					{128, 128, 128},
					message,
					"ooc"
				)
				ChatCooldown = 3
			elseif vRP.hasGroup(user_id, "moderator") then
				TriggerClientEvent(
					"chatMessage",
					-1,
					"^7^*OOC ^7^r |^2 Moderator ^7^r" .. GetPlayerName(source) .. "^7 : ",
					{128, 128, 128},
					message,
					"ooc"
				)
				ChatCooldown = 3
			elseif vRP.hasGroup(user_id, "support") then
				TriggerClientEvent(
					"chatMessage",
					-1,
					"^7^*OOC ^7^r |^2 Support Team ^7^r" .. GetPlayerName(source) .. "^7 : ",
					{128, 128, 128},
					message,
					"ooc"
				)
				ChatCooldown = 3
			elseif vRP.hasGroup(user_id, "trialstaff") then
				TriggerClientEvent(
					"chatMessage",
					-1,
					"^7^*OOC ^7^r |^5 Trial Staff ^7^r" .. GetPlayerName(source) .. "^7 : ",
					{128, 128, 128},
					message,
					"ooc"
				)
				ChatCooldown = 3
			elseif vRP.hasGroup(user_id, "VIP") then
				TriggerClientEvent(
					"chatMessage",
					-1,
					"^7^*OOC ^7^r |^1 " .. GetPlayerName(source) .. "^7 : ",
					{128, 128, 128},
					message,
					"ooc"
				)
				ChatCooldown = 3
			elseif vRP.hasGroup(user_id, "Recruit") then
				TriggerClientEvent(
					"chatMessage",
					-1,
					"^7^*OOC ^7^ |^9 " .. GetPlayerName(source) .. "^7 : ",
					{128, 128, 128},
					message,
					"ooc"
				)
				ChatCooldown = 3
			elseif vRP.hasGroup(user_id, "Soldier") then
				TriggerClientEvent(
					"chatMessage",
					-1,
					"^7^*OOC ^7^r |^3 " .. GetPlayerName(source) .. "^7 : ",
					{128, 128, 128},
					message,
					"ooc"
				)
				ChatCooldown = 3
			elseif vRP.hasGroup(user_id, "Warrior") then
				TriggerClientEvent(
					"chatMessage",
					-1,
					"^7^*OOC ^7^r |^6 " .. GetPlayerName(source) .. "^7 : ",
					{128, 128, 128},
					message,
					"ooc"
				)
				ChatCooldown = 3
			elseif vRP.hasGroup(user_id, "Champion") then
				TriggerClientEvent(
					"chatMessage",
					-1,
					"^7^*OOC ^7^r |^5 " .. GetPlayerName(source) .. "^7 : ",
					{128, 128, 128},
					message,
					"ooc"
				)
				ChatCooldown = 3
			else
				TriggerClientEvent(
					"chatMessage",
					-1,
					"^7^*OOC ^7^r | " .. GetPlayerName(source) .. "^7 : ",
					{128, 128, 128},
					message,
					"ooc"
				)
				ChatCooldown = 3
			end
		else
			TriggerClientEvent(
				"chatMessage",
				source,
				"^1^[Nova]",
				{128, 128, 128},
				" Chat Spam | Retry in 3 Seconds",
				"alert"
			)
			ChatCooldown = 3
		end
	end
end

--OOC Message
RegisterCommand("ooc", function(source, args, raw)
	OOC_Message(source, args, raw)
end)

RegisterCommand("/", function(source, args, raw)
	OOC_Message(source, args, raw)
end)

RegisterCommand("announce", function(source, args, raw)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, "chat.announce") then
		if #args <= 0 then
			return
		end
		local message = table.concat(args, " ")

		local source = source
		local name = GetPlayerName(source)
		local user_id = vRP.getUserId(source)
		local command = {
			{
				["color"] = "16448403",
				["title"] = "Nova Chat Logs",
				["description"] = "```" .. message .. "```",
				["text"] = "Nova Server #1",
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
						["name"] = "Player Hours",
						["value"] = "0 hours",
						["inline"] = true
					},
					{
						["name"] = "Chat Type",
						["value"] = "Announce",
						["inline"] = true
					}
				}
			}
		}

		PerformHttpRequest(
			Chat_Logs_Webhook,
			function(err, text, headers)
			end,
			"POST",
			json.encode({username = "Nova", embeds = command}),
			{["Content-Type"] = "application/json"}
		)
		TriggerClientEvent("chatMessage", -1, "^7Announce: ", {128, 128, 128}, message, "alert")
	end
end)

RegisterCommand("clearchat", function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, "chat.clear") then
		local players = GetPlayers()
		for i, v in pairs(players) do
			local source = v
			TriggerClientEvent("chat:clear", source)
		end
	else
		vRPclient.notify(source, {"~r~You do not have permission to use this command."})
	end
end)

--Function
function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t = {}
	i = 1
	for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end

Citizen.CreateThread(function()
	while true do
		if ChatCooldown > 0 then
			ChatCooldown = ChatCooldown - 1
			lastmsg = nil
		end
		
		Citizen.Wait(1000)
	end
end)