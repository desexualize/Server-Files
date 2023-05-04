Citizen.CreateThread( function()
	while true do 
		Citizen.Wait( 0 )   
		local ped = GetPlayerPed(-1)
		local vehicle = GetVehiclePedIsIn(ped, false)
		local speed = GetEntitySpeed(vehicle)
			if ( ped ) then
				if math.floor(speed*3.6) == 402 then
					cruise = GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false))
					SetEntityMaxSpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false), cruise)
				end
			end
		end
end)