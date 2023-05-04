SetDiscordAppId(1012499210207244408)

local Max_Players = 0
local Discord_Presence_Thread_Started = false

local function Create_Discord_Presence_Thread()
	Discord_Presence_Thread_Started = true
	Citizen.CreateThread(function()
		while true do
			SetDiscordRichPresenceAsset("nova-main")
			SetDiscordRichPresenceAssetText("nova-main")
			SetDiscordRichPresenceAssetSmall("nova-main") -- Name of the smaller image asset.
			SetDiscordRichPresenceAssetSmallText("discord.gg/YxCcxY6bYF")
			SetRichPresence("" .. #GetActivePlayers() .. "/" .. Max_Players .. " Players")
			SetDiscordRichPresenceAction(0, "Discord", "discord.gg/YxCcxY6bYF")
	
			Citizen.Wait(10000) -- Wait 10 seconds
		end
	end)
end

RegisterNetEvent('Client:Status:GetMaxPlayers')
AddEventHandler('Client:Status:GetMaxPlayers', function(maximum_players)
	Max_Players = maximum_players
	if not Discord_Presence_Thread_Started then
		Create_Discord_Presence_Thread()
	end
end)
TriggerServerEvent('Server:Status:GetMaxPlayers')