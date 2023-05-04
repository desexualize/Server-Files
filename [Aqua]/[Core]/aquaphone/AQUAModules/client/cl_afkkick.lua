-- AFK Kick Time Limit (in seconds)
secondsUntilKick = 1800

-- Warn players if 3/4 of the Time Limit ran up
kickWarning = true

Citizen.CreateThread(function()
	while true do
		Wait(1000)
		playerPed = GetPlayerPed(-1)
		if playerPed then
			currentPos = GetEntityCoords(playerPed, true)
			if currentPos == prevPos then
				if time > 0 then
					if kickWarning and time == math.ceil(secondsUntilKick / 4) then
						TriggerEvent("chatMessage", "WARNING", {255, 0, 0}, "^1You'll be kicked in " .. time .. " seconds for being AFK!")
						TriggerServerEvent("AQUA:pdMoneyFarming")
					end
					time = time - 1
				else
					TriggerServerEvent("kickForBeingAnAFKDouchebag")
				end
			else
				time = secondsUntilKick
			end
			prevPos = currentPos
		end
	end
end)

RegisterNetEvent('Health:Morphine')
AddEventHandler('Health:Morphine', function()
	local ped = PlayerPedId()
	while true do 
		SetEntityHealth(ped, GetEntityHealth(ped + 3))
		if GetEntityHealth(ped) == 200 then 
		notify('The Morphine effect has worn off')
		break;
		end
		Citizen.Wait(1000)
	end
end)

-- barnsy