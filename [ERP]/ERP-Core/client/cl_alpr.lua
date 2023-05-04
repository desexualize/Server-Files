--[[------------------------------------------------------------------------

	Radar/ALPR 
	Created by Brock =]
	Uses Numpad5 to turn on
    Uses Numpad8 to freeze	

------------------------------------------------------------------------]]--

local radar =
{
	shown = false,
	freeze = false,
	info = "~y~Initializing ALPR...~w~321...~y~Loaded! ",
	info2 = "~y~Initializing ALPR...~w~321...~y~Loaded! ",
	minSpeed = 5.0,
	maxSpeed = 75.0,
}
--local distanceToCheckFront = 50

function DrawAdvancedText(x,y ,w,h,sc, text, r,g,b,a,font,jus)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(sc, sc)
	N_0x4e096588b13ffeca(jus)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
	DrawText(x - 0.1+w, y - 0.02+h)
end

Citizen.CreateThread( function()
	
	while true do
		Wait(0)
		if IsControlJustPressed(1, 39) and IsPedInAnyPoliceVehicle(GetPlayerPed(-1)) then
			
			if radar.shown then 
				radar.shown = false 
				radar.plate = string.format("~y~Initializing ALPR...")
				radar.model = string.format("~y~Initializing ALPR...")
				radar.speed = string.format("~y~Initializing ALPR...")
			else 
				radar.shown = true 
			end		
                Wait(75)
			
		end
		if IsControlJustPressed(1, 40) and IsPedInAnyPoliceVehicle(GetPlayerPed(-1)) then
		
			if radar.freeze then radar.freeze = false else radar.freeze = true end
	
		end
		if radar.shown  then
			if radar.freeze == false then
					local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
					local coordA = GetOffsetFromEntityInWorldCoords(veh, 0.0, 1.0, 1.0)
					local coordB = GetOffsetFromEntityInWorldCoords(veh, 0.0, 105.0, 0.0)
					local frontcar = StartShapeTestCapsule(coordA, coordB, 3.0, 10, veh, 7)
					local a, b, c, d, e = GetShapeTestResult(frontcar)
					
					if IsEntityAVehicle(e) then
						
						local fmodel = GetDisplayNameFromVehicleModel(GetEntityModel(e))
						local fvspeed = GetEntitySpeed(e)*2.236936
						local fplate = GetVehicleNumberPlateText(e)
						radar.plate = string.format("Plate: %s",fplate)
						radar.model = string.format("Model: %s",fmodel)
						radar.speed = string.format("Speed: %s",math.ceil(fvspeed).." MPH")
					end
					
					local bcoordB = GetOffsetFromEntityInWorldCoords(veh, 0.0, -105.0, 0.0)
					local rearcar = StartShapeTestCapsule(coordA, bcoordB, 3.0, 10, veh, 7)
					local f, g, h, i, j = GetShapeTestResult(rearcar)
					
					if IsEntityAVehicle(j) then
					
						local bmodel = GetDisplayNameFromVehicleModel(GetEntityModel(j))
						local bvspeed = GetEntitySpeed(j)*2.236936
						local bplate = GetVehicleNumberPlateText(j)
						radar.plate2 = string.format("Plate: %s",bplate)
						radar.model2 = string.format("Model: %s",bmodel)
						radar.speed2 = string.format("Speed: %s",math.ceil(bvspeed).." MPH")
					
					end
					
			end
			
			DrawRect(0.452, 0.9, 0.07, 0.126, 0, 0, 0, 150)
			DrawAdvancedText(0.546, 0.855, 0.005, 0.0028, 0.5, "Front", 255, 255, 255, 255, 6, 0)
			DrawAdvancedText(0.546, 0.885, 0.005, 0.0028, 0.4, radar.plate, 255, 255, 255, 255, 6, 0)
			DrawAdvancedText(0.546, 0.915, 0.005, 0.0028, 0.4, radar.model, 255, 255, 255, 255, 6, 0)
			DrawAdvancedText(0.546, 0.944, 0.005, 0.0028, 0.4, radar.speed, 255, 255, 255, 255, 6, 0)

			DrawRect(0.54, 0.9, 0.07, 0.126, 0, 0, 0, 150)
			DrawAdvancedText(0.635, 0.855, 0.005, 0.0028, 0.5, "Rear", 255, 255, 255, 255, 6, 0)
			DrawAdvancedText(0.635, 0.885, 0.005, 0.0028, 0.4, radar.plate2, 255, 255, 255, 255, 6, 0)
			DrawAdvancedText(0.635, 0.915, 0.005, 0.0028, 0.4, radar.model2, 255, 255, 255, 255, 6, 0)
			DrawAdvancedText(0.635, 0.944, 0.005, 0.0028, 0.4, radar.speed2, 255, 255, 255, 255, 6, 0)
			
		end
		
		if(not IsPedInAnyVehicle(GetPlayerPed(-1))) then
			radar.shown = false
			radar.info = string.format("~y~Initializing ALPR...")
			radar.info2 = string.format("~y~Initializing ALPR...")
		end
					
	end
	
	
end)