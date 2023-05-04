local ind = {l = false, r = false}
local showNUIHud = false
local hideHud = false

RegisterNetEvent("ARMA:showHUD")
AddEventHandler("ARMA:showHUD",function(flag)
    hideHud = not flag
end)

Citizen.CreateThread(function()
	SendNUIMessage({
		showhud = false
	})
	while true do
		local Ped = GetPlayerPed(-1)
		local PedCar = GetVehiclePedIsIn(Ped, false)
		if PedCar ~= 0 and not hideHud then
			if PedCar and (GetPedInVehicleSeat(PedCar, -1) == Ped or GetPedInVehicleSeat(PedCar, 0) == Ped) and GetVehicleClass(PedCar) ~= 14 then
				carSpeed = math.ceil(GetEntitySpeed(PedCar)*2.2369)
				
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

function GetFuel(vehicle)
	return DecorGetFloat(vehicle, "_FUEL_LEVEL")
end

-- Consume fuel factor
Citizen.CreateThread(function()
	while true do
		local Ped = GetPlayerPed(-1)
		if(IsPedInAnyVehicle(Ped)) then
			local PedCar = GetVehiclePedIsIn(Ped, false)
			if PedCar and GetPedInVehicleSeat(PedCar, -1) == Ped then


				SendNUIMessage({
					showfuel = true,
					fuel = GetFuel(PedCar)
				})
			end
		end

		Citizen.Wait(1000)
	end
end)