local ind = {l = false, r = false}

Citizen.CreateThread(function()
	while true do
		local Ped = PlayerPedId()
		if(IsPedInAnyVehicle(Ped)) then
			local PedCar = GetVehiclePedIsIn(Ped, false)
			if PedCar and GetPedInVehicleSeat(PedCar, -1) == Ped then

				-- Speed
				carSpeed = math.ceil(GetEntitySpeed(PedCar) * 2.236936)
				SendNUIMessage({
					showhud = true,
					speed = carSpeed
				})


			else
				SendNUIMessage({
					showhud = false
				})
			end
		else
			SendNUIMessage({
				showhud = false
			})
		end

		Citizen.Wait(1)
	end
end)

-- Consume fuel factor
Citizen.CreateThread(function()
	while true do
		local Ped = PlayerPedId()
		if(IsPedInAnyVehicle(Ped)) then
			local PedCar = GetVehiclePedIsIn(Ped, false)
			if PedCar and GetPedInVehicleSeat(PedCar, -1) == Ped then
				carSpeed = math.ceil(GetEntitySpeed(PedCar) * 3.6)
				fuel = GetVehicleFuelLevel(PedCar)


				SendNUIMessage({
					showfuel = true,
					fuel = exports['AQUAModules']:GetFuel(PedCar)
				})
			end
		end

		Citizen.Wait(1)
	end
end)