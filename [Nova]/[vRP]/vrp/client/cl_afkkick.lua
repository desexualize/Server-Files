local Minutes_Until_Kick = 15 -- Minutes that player has to be afk to get kicked
local Seconds_Until_Kick = Minutes_Until_Kick * 60
local Kick_Warning = true -- Will warn player that he will be kicked

local AFK_Detections_Log_Time_Minutes = {15, 10, 5}
local Time_Spent_AFK = 0
local Previous_Position = nil -- Will be set to later in code

local function Send_Faction_AFK_Log(afk_seconds, still_afk)
	local faction_name
	if tvRP.IsLFB() then
		faction_name = 'LFB'

	elseif tvRP.IsNHS() then
		faction_name = 'NHS'

	elseif tvRP.IsHMP() then
		faction_name = 'HMP'
	
	elseif tvRP.IsMPD() then
		faction_name = 'MPD'
	end

	if faction_name then
		local afk_minutes = afk_seconds / 60
		for table_index, minutes_amount in ipairs(AFK_Detections_Log_Time_Minutes) do
			if still_afk then
				if afk_minutes == minutes_amount then
					local afk_text 
					if minutes_amount == Minutes_Until_Kick then
						afk_text = ('Player Kicked - %s Minutes AFK'):format(minutes_amount)
					else
						afk_text = ('%s Minutes AFK'):format(minutes_amount)
					end
					TriggerServerEvent('Nova:Server:SendAFKLog', faction_name, afk_text)
					break
				end
			else
				if afk_minutes >= minutes_amount then
					TriggerServerEvent('Nova:Server:SendAFKLog', faction_name, 'Player Moved - No Longer AFK')
					break
				end
			end
		end
	end
end

local AFK_Thread_Running = false
local function AFK_Detection_Thread()
	if AFK_Thread_Running then
		return
	end
	AFK_Thread_Running = true
	
	Citizen.CreateThread(function()
		while AFK_Thread_Running do
			local client_ped = PlayerPedId()
			local current_position = GetEntityCoords(client_ped)

			if Previous_Position then
				local distance_between_positions = #(current_position - Previous_Position)
				if distance_between_positions <= 0.5 then -- Sometimes the ped makes slight movements so this will counteract that
					Send_Faction_AFK_Log(Time_Spent_AFK, true)

					if Time_Spent_AFK >= Seconds_Until_Kick then
						TriggerServerEvent("Nova:AFKKick")
					else
						if Kick_Warning and Time_Spent_AFK == math.ceil(Seconds_Until_Kick / 4) then
							TriggerEvent("chatMessage", "[Nova]:", {255, 255, 255}, "You will be kicked in " .. Seconds_Until_Kick - Time_Spent_AFK .. " seconds for being AFK!", 'alert')
						end
						Time_Spent_AFK = Time_Spent_AFK + 1
					end
				else
					Send_Faction_AFK_Log(Time_Spent_AFK, false)
					Time_Spent_AFK = 0
				end
			end

			Previous_Position = current_position
			Citizen.Wait(1000)
		end
	end)
end

RegisterNetEvent('Nova:Client:FounderSet')
AddEventHandler('Nova:Client:FounderSet', function(bool_value)
	if bool_value then
		AFK_Thread_Running = false -- If founder don't run afk thread
	else
		AFK_Detection_Thread()
	end
end)