local DISCORD_WEBHOOK = "https://discord.com/api/webhooks/1059088753362210826/CiUl0TGVO1c9BPoGVW09IcA6BWdFeU54HNKH3UOcRQvpfj769RceImIHul3ZAHIjmh3-"
local DISCORD_NAME = "AQUA"
local DISCORD_IMAGE = ""

local cooldown = {}
local anoncooldown = {}

--Anon Message
RegisterCommand("anon", function(source, args, raw)
    if #args <= 0 then return end
    if anoncooldown[source] and not (os.time() > anoncooldown[source]) then
        TriggerClientEvent('chatMessage', source, "AQUA",  { 255, 255, 255 }, "You are being rate limited.", "alert")
        return
    else
        anoncooldown[source] = nil
    end

    anoncooldown[source] = os.time() + 60

	local playerName = GetPlayerName(source)
    local user_id = AQUA.getUserId(source)
    local message = table.concat(args, " ")
	TriggerClientEvent('chatMessage', -1, "^1Anonymous |", { 255, 0, 0 }, message)
    sendToDiscord("[Anon]", "**Name:** "..playerName.."\n**PermID:** "..user_id.."\n**Message:** "..message)
end)

--OOC Message
RegisterCommand("ooc", function(source, args, raw)
    ooc(source, args,raw)
end)

RegisterCommand("/", function(source, args, raw)
    ooc(source, args,raw)
end)

RegisterCommand("s", function(source,args, rawCommand)
    user_id2 = AQUA.getUserId(source)   
    if not AQUA.hasPermission(user_id2, "admin.tickets") then
        local playerName = "Server "
        local message = "Access denied."
        TriggerClientEvent('chatMessage', source, "^7Alert: " , { 128, 128, 128 }, message, "alert")
    end
    if AQUA.hasPermission(user_id2, "admin.tickets") then
        local message = rawCommand:sub(2)
        local playerName =  GetPlayerName(source)
        local players = GetPlayers()
        for i,v in pairs(players) do 
            name = GetPlayerName(v)
            user_id = AQUA.getUserId(v)   
            if AQUA.hasPermission(user_id, "admin.tickets") then
            TriggerClientEvent('chatMessage', v, "^7[Staff Chat] " .. GetPlayerName(source) .." : " , { 128, 128, 128 }, message, "staff")
            
            end
        end
        sendToDiscord("[Staff Chat]", "**Name:** "..playerName.."\n**PermID:** "..user_id.."\n**Message:** "..message)
     end
end)

RegisterCommand("p", function(source,args, rawCommand)
    user_id2 = AQUA.getUserId(source)   
    if not AQUA.hasPermission(user_id2, "police.armoury") then
        local playerName = "Server "
        local message = "Access denied."
        TriggerClientEvent('chatMessage', source, "^7Alert: " , { 128, 128, 128 }, message, "alert")
    end
    if AQUA.hasPermission(user_id2, "police.armoury") then
        local message = rawCommand:sub(2)
        local playerName =  GetPlayerName(source)
        local players = GetPlayers()
        for i,v in pairs(players) do 
            name = GetPlayerName(v)
            user_id = AQUA.getUserId(v)   
            if AQUA.hasPermission(user_id, "police.armoury") then
            TriggerClientEvent('chatMessage', v, "^7[PD Chat] " .. GetPlayerName(source) .." : " , { 128, 128, 128 }, message, "pd")
            
            end
        end
        sendToDiscord("[PD Chat]", "**Name:** "..playerName.."\n**PermID:** "..user_id.."\n**Message:** "..message)
  end
end)


RegisterCommand("a", function(source,args, rawCommand)
    local user_id = AQUA.getUserId(source)   
    if AQUA.hasPermission(user_id, "chat.announce") then
        local message = rawCommand:sub(2)
        local playerName =  GetPlayerName(source)
        TriggerClientEvent('chatMessage', -1, "^7[Announcement] "  .. GetPlayerName(source) .." : " , { 128, 128, 128 }, message, "alert")
        sendToDiscord("[Alert]", "**Name:** "..playerName.."\n**PermID:** "..user_id.."\n**Message:** "..message)
    else 
        TriggerClientEvent('chatMessage', source, "^7Alert: " , { 128, 128, 128 }, 'Access denied', "alert")
        return 
    end
end)

function ooc(source,args,raw)
    if #args <= 0 then return end
    if cooldown[source] and not (os.time() > cooldown[source]) then
        TriggerClientEvent('chatMessage', source, "AQUA",  { 255, 255, 255 }, "You are being rate limited.", "alert")
        return
    else
        cooldown[source] = nil
    end

    cooldown[source] = os.time() + 5

    local playerName = GetPlayerName(source)
    local user_id = AQUA.getUserId(source)
    local message = table.concat(args, " ")
    if AQUA.hasGroup(user_id, 'founder') then
        TriggerClientEvent('chatMessage', -1, "^7^*OOC ^7^r | ^1Founder ^0" .. GetPlayerName(source) .." : " , { 128, 128, 128 }, message, "ooc")
    elseif AQUA.hasGroup(user_id, 'director') then 
        TriggerClientEvent('chatMessage', -1, "^7^*OOC ^7^r | ^1Director ^0" .. GetPlayerName(source) .." : " , { 128, 128, 128 }, message, "ooc")
    elseif AQUA.hasGroup(user_id, 'Director') then 
        TriggerClientEvent('chatMessage', -1, "^7^*OOC ^7^r | ^1Director ^0" .. GetPlayerName(source) .." : " , { 128, 128, 128 }, message, "ooc")
    elseif AQUA.hasGroup(user_id, 'dev') then
        TriggerClientEvent('chatMessage', -1, "^7^*OOC ^7^r | ^1Developer ^0" .. GetPlayerName(source) .." : " , { 128, 128, 128 }, message, "ooc")
    elseif AQUA.hasGroup(user_id, 'operationsmanager') then
        TriggerClientEvent('chatMessage', -1, "^7^*OOC ^7^r | ^1Operations Manager ^0" .. GetPlayerName(source) .." : " , { 128, 128, 128 }, message, "ooc")
    elseif AQUA.hasGroup(user_id, 'staffmanager') then
        TriggerClientEvent('chatMessage', -1, "^7^*OOC ^7^r | ^6Staff Manager ^0" .. GetPlayerName(source) .." : " , { 128, 128, 128 }, message, "ooc")
    elseif AQUA.hasGroup(user_id, 'commanager') then
        TriggerClientEvent('chatMessage', -1, "^7^*OOC ^7^r | ^6Community Manager ^0" .. GetPlayerName(source) .." : " , { 128, 128, 128 }, message, "ooc")
    elseif AQUA.hasGroup(user_id, 'headadmin') then
        TriggerClientEvent('chatMessage', -1, "^7^*OOC ^7^r | ^6Head Administrator ^0" .. GetPlayerName(source) .." : " , { 128, 128, 128 }, message, "ooc")
    elseif AQUA.hasGroup(user_id, 'senioradmin') then
        TriggerClientEvent('chatMessage', -1, "^7^*OOC ^7^r | ^6Senior Administrator ^0" .. GetPlayerName(source) .." : " , { 128, 128, 128 }, message, "ooc")
    elseif AQUA.hasGroup(user_id, 'administrator') then
        TriggerClientEvent('chatMessage', -1, "^7^*OOC ^7^r | ^6Administrator ^0" .. GetPlayerName(source) .." : " , { 128, 128, 128 }, message, "ooc")
    elseif AQUA.hasGroup(user_id, 'srmoderator') then
        TriggerClientEvent('chatMessage', -1, "^7^*OOC ^7^r | ^6Senior Moderator ^0" .. GetPlayerName(source) .." : " , { 128, 128, 128 }, message, "ooc")
    elseif AQUA.hasGroup(user_id, 'moderator') then
        TriggerClientEvent('chatMessage', -1, "^7^*OOC ^7^r | ^6Moderator ^0" .. GetPlayerName(source) .." : " , { 128, 128, 128 }, message, "ooc")
    elseif AQUA.hasGroup(user_id, 'supportteam') then
        TriggerClientEvent('chatMessage', -1, "^7^*OOC ^7^r | ^6Support Team ^0" .. GetPlayerName(source) .." : " , { 128, 128, 128 }, message, "ooc")
    elseif AQUA.hasGroup(user_id, 'trialstaff') then
        TriggerClientEvent('chatMessage', -1, "^7^*OOC ^7^r | ^6Trial Staff ^0" .. GetPlayerName(source) .." : " , { 128, 128, 128 }, message, "ooc")
    elseif AQUA.hasGroup(user_id, 'elite') then
        TriggerClientEvent('chatMessage', -1, "^7^*OOC ^7^r | ^8" .. GetPlayerName(source) .." : " , { 128, 128, 128 }, message, "ooc")
    elseif AQUA.hasGroup(user_id, 'soldier') then
        TriggerClientEvent('chatMessage', -1, "^7^*OOC ^7^r | ^9" .. GetPlayerName(source) .." : " , { 128, 128, 128 }, message, "ooc")
    elseif AQUA.hasGroup(user_id, 'warrior') then
        TriggerClientEvent('chatMessage', -1, "^7^*OOC ^7^r | ^3" .. GetPlayerName(source) .." : " , { 128, 128, 128 }, message, "ooc")
    elseif AQUA.hasGroup(user_id, 'diamond') then
        TriggerClientEvent('chatMessage', -1, "^7^*OOC ^7^r | ^5" .. GetPlayerName(source) .." : " , { 128, 128, 128 }, message, "ooc")
    else
        TriggerClientEvent('chatMessage', -1, "^7^*OOC ^7^r | " .. GetPlayerName(source) .." : " , { 128, 128, 128 }, message, "ooc")
    end
    sendToDiscord("[OOC]", "**Name:** "..playerName.."\n**PermID:** "..user_id.."\n**Message:** "..message)
end


--Remove Commands From Chat

AddEventHandler('chatMessage', function(Source, Name, Msg)
    args = stringsplit(Msg, " ")
    CancelEvent()
    if string.find(args[1], "/") then
        local cmd = args[1]
        table.remove(args, 1)
	else
		TriggerClientEvent('chatMessage', -1, Name, { 255, 255, 255 }, Msg)
	end
end)


--Functions 

function GetIDFromSource(Type, ID)
    local IDs = GetPlayerIdentifiers(ID)
    for k, CurrentID in pairs(IDs) do
        local ID = stringsplit(CurrentID, ':')
        if (ID[1]:lower() == string.lower(Type)) then
            return ID[2]:lower()
        end
    end
    return nil
end

RegisterCommand('clear', function(source, args, rawCommand)
    local user_id = AQUA.getUserId(source)
    if AQUA.hasPermission(user_id, 'admin.ban') then
        local players = GetPlayers()
        for i,v in pairs(players) do 
            local source = v
            TriggerClientEvent('chat:clear',source)               
        end
    else
        AQUAclient.notify(source,{"~d~You do not have permission to use this command."})
    end
end, false)

function stringsplit(input, seperator)
	if seperator == nil then
		seperator = '%s'
	end
	
	local t={} ; i=1
	
	for str in string.gmatch(input, '([^'..seperator..']+)') do
		t[i] = str
		i = i + 1
	end
	
	return t
end

--Discord Logs

RegisterNetEvent("chat:TwitterLogs")
AddEventHandler("chat:TwitterLogs", function(message, name, source)
    user_id = AQUA.getUserId(source)
    sendToDiscord("[Twitter]", "**Name:** "..name.."\n**Perm ID:** "..user_id.."\n**Message:** "..message)
end)

function sendToDiscord(name, message, color)
    local connect = {
        {
            ["color"] = color,
            ["title"] = "**Chat Logs**",
            ["description"] = message.."\n**Type:** "..name,
            ["footer"] = {
                ["text"] = "Time - "..os.date("%x %X %p"),
            },
        }
    }
  	PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
end
