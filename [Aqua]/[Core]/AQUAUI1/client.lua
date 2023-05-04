local ind = {l = false, r = false}
local showNUIHud = false
local hideHud = false

RegisterNetEvent("CMG:showHUD")
AddEventHandler("CMG:showHUD",function(flag)
    hideHud = not flag
end)

Citizen.CreateThread(function()
	SendNUIMessage({
		showhud = false
	})
	while true do
		local Ped = GetPlayerPed(-1)
		if GetVehiclePedIsIn(Ped, false) ~= 0 and not hideHud then
			local PedCar = GetVehiclePedIsIn(Ped, false)
			if PedCar and GetPedInVehicleSeat(PedCar, -1) == Ped then

				-- Speed
				carSpeed = math.ceil(GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false))*2.2369)
				
				SendNUIMessage({
					showhud = true,
					speed = carSpeed
				})
				showNUIHud = true
				-- Lights
				-- _,feuPosition,feuRoute = GetVehicleLightsState(PedCar)
				-- if(feuPosition == 1 and feuRoute == 0) then
				-- 	SendNUIMessage({
				-- 		feuPosition = true
				-- 	})
				-- else
				-- 	SendNUIMessage({
				-- 		feuPosition = false
				-- 	})
				-- end
				-- if(feuPosition == 1 and feuRoute == 1) then
				-- 	SendNUIMessage({
				-- 		feuRoute = true
				-- 	})
				-- else
				-- 	SendNUIMessage({
				-- 		feuRoute = false
				-- 	})
				-- end

				-- Turn signal
				-- SetVehicleIndicatorLights (1 left -- 0 right)
				-- local VehIndicatorLight = GetVehicleIndicatorLights(GetVehiclePedIsUsing(PlayerPedId()))
				-- if IsControlJustPressed(1, 57) then -- F9 is pressed
				-- 	ind.l = not ind.l
				-- 	SetVehicleIndicatorLights(GetVehiclePedIsUsing(GetPlayerPed(-1)), 0, ind.l)
				-- end
				-- if IsControlJustPressed(1, 56) then -- F10 is pressed
				-- 	ind.r = not ind.r
				-- 	SetVehicleIndicatorLights(GetVehiclePedIsUsing(GetPlayerPed(-1)), 1, ind.r)
				-- end

				-- if(VehIndicatorLight == 0) then
				-- 	SendNUIMessage({
				-- 		clignotantGauche = false,
				-- 		clignotantDroite = false,
				-- 	})
				-- elseif(VehIndicatorLight == 1) then
				-- 	SendNUIMessage({
				-- 		clignotantGauche = true,
				-- 		clignotantDroite = false,
				-- 	})
				-- elseif(VehIndicatorLight == 2) then
				-- 	SendNUIMessage({
				-- 		clignotantGauche = false,
				-- 		clignotantDroite = true,
				-- 	})
				-- elseif(VehIndicatorLight == 3) then
				-- 	SendNUIMessage({
				-- 		clignotantGauche = true,
				-- 		clignotantDroite = true,
				-- 	})
				-- end

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