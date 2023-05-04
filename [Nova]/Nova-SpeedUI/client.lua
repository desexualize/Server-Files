local ind = {l = false, r = false}
local showNUIHud = false
local hideHud = false

local Client_Player = PlayerId() -- Client Player always constant
local Client_Ped = PlayerPedId() -- Client Ped (Looped in thread)
local Client_Vehicle = GetVehiclePedIsIn(Client_Ped, false) -- Client current vehicle (Looped in thread)
local Client_Driving = GetPedInVehicleSeat(Client_Vehicle, -1) == Client_Ped -- Boolean value to check if client is driving (Looped in thread)

RegisterNetEvent("ORP:showHUD")
AddEventHandler("ORP:showHUD", function(flag)
    hideHud = not flag
end)


function GetFuel(vehicle)
	return DecorGetFloat(vehicle, "_FUEL_LEVEL")
end

local thread_active = false
local function Display_Updated_Vehicle_Info()
	-- Updates SpeedUI
	Citizen.CreateThread(function()
		while true do
			if not thread_active then
				if showNUIHud then
					SendNUIMessage({
						showhud = false
					})
					showNUIHud = false
				end
				break
			end

			if Client_Vehicle ~= 0 and not hideHud then
				if Client_Driving then
					-- Speed
					carSpeed = math.ceil(GetEntitySpeed(Client_Vehicle) * 2.2369)
					
					SendNUIMessage({
						showhud = true,
						speed = carSpeed
					})
					showNUIHud = true
				else
					if showNUIHud then
						SendNUIMessage({
							showhud = false
						})
						showNUIHud = false
					end
				end
			else
				if showNUIHud then
					SendNUIMessage({
						showhud = false
					})
					showNUIHud = false
				end
			end
	
			Citizen.Wait(50)
		end
	end)

	-- Consume fuel factor
	Citizen.CreateThread(function()
		while thread_active do
			Client_Ped = PlayerPedId()
			Client_Vehicle = GetVehiclePedIsIn(Client_Ped, false)

			if Client_Vehicle ~= 0 then
				Client_Driving = GetPedInVehicleSeat(Client_Vehicle, -1) == Client_Ped
				if Client_Driving then
					local vehicle_fuel = GetFuel(Client_Vehicle)
					SendNUIMessage({
						showfuel = true,
						fuel = vehicle_fuel
					})
				end
			else
				thread_active = false
			end
			
			Citizen.Wait(1000)
		end
	end)
end

AddEventHandler('gameEventTriggered', function(eventName, data)
    if eventName ~= 'CEventNetworkPlayerEnteredVehicle' then
		return
	end

	if data[1] ~= Client_Player then
		return
	end

	if thread_active then
		return
	end

	Client_Ped = PlayerPedId()
	Client_Vehicle = GetVehiclePedIsIn(Client_Ped)

	if data[2] == Client_Vehicle then
		thread_active = true
		Display_Updated_Vehicle_Info() -- Calls the function to update the fuel & speed thread
	end
end)

Citizen.CreateThread(function()
	SendNUIMessage({
		showhud = false
	})

	if Client_Vehicle ~= 0 and not thread_active then -- On Script start checks if ped in vehicle to active the 2 threads
		thread_active = true
		Display_Updated_Vehicle_Info()
	end
end)