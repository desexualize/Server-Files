local inTurf = false
local secondsRemaining = 0
local sucess = false

local doneIt = false

RegisterNetEvent("NovaTurf:TakenTurf")
AddEventHandler("NovaTurf:TakenTurf",function(isnTurf)
	inTurf = true
	turf = isnTurf
	secondsRemaining = 120
	doneIt = false
	takeComis()
end)

RegisterNetEvent("NovaTurf:OutOfZone")
AddEventHandler("NovaTurf:OutOfZone",function(isnTurf)
	inTurf = false
	notify("~r~The The turf cap was cancelled, you will receive nothing.")
	doneIt = false
	sucess = true
	inZone = false
end)

RegisterNetEvent("NovaTurf:PlayerDied")
AddEventHandler("NovaTurf:PlayerDied",function(isnTurf)
	inTurf = false
	notify("~r~The turf cap was cancelled, you died!")
	doneIt = false
	inTurfName = ""
	secondsRemaining = 0
	sucess = true
	inZone = false
end)

RegisterNetEvent("NovaTurf:TurfComplete")
AddEventHandler("NovaTurf:TurfComplete",function(reward, name)inTurf = false
	sucess = true
	secondsRemaining = 0
	if name == "Large Arms" then
		doneIt = true
		notify("~g~Turf Capture Sucessful! ~w~You received ~w~ Access to change Commision.")
	end
	inZone = false
end)

isInTurf = false
function takeComis()
	Citizen.CreateThread(function()
		while true do
			if doneIt then
				local v1 = vector3(-1102.7158, 4936.5854, 218.3814)
				if isInTurf == false then
					if isInArea(v1, 1.4) then
						alert("Press ~INPUT_VEH_HORN~ to Change Commision")
						if IsControlJustPressed(0, 51) then
							changeComision()
						end
					end
				end
			end
			Citizen.Wait(0)
		end
	end)
end

RegisterNetEvent("doneIt")
AddEventHandler("doneIt",function(bool)
	doneIt = bool
end)

function changeComision()
	AddTextEntry("FMMC_KEY_TIP8", "Enter the Commision to change.")
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "Enter Amount (Blank to Cancel)", "", "", "", "", 30)
	while (UpdateOnscreenKeyboard() == 0) do
		DisableAllControlActions(0)
		Wait(0)
	end
	if (GetOnscreenKeyboardResult()) then
		local resultID = GetOnscreenKeyboardResult()
		if resultID then
			TriggerServerEvent("changeCom", tonumber(resultID))
		end
	end
	return false
end

Citizen.CreateThread(function()
	while true do
		if inTurf then
			Citizen.Wait(1000)
			if (secondsRemaining > 0) then
				secondsRemaining = secondsRemaining - 1
			end
		end
		Citizen.Wait(0)
	end
end)

inZone = false
Citizen.CreateThread(function()
	while true do
		local pos = GetEntityCoords(PlayerPedId(), true)
		for k, v in pairs(turfs) do
			local pos2 = v.position
			local pos3 = v.capturf
			if (Vdist(pos.x, pos.y, pos.z, pos3.x, pos3.y, pos3.z) < 1.4) then
				if not inTurf then
					if (Vdist(pos.x, pos.y, pos.z, pos3.x, pos3.y, pos3.z) < 1.4) then
						if (inZone == false) then
							alert("Press ~INPUT_CONTEXT~ to capture ~r~" .. v.nameofturf)
						end
						inZone = true
						if (IsControlJustReleased(1, 51)) then
							TriggerServerEvent("NovaTurf:rob", k)
							istakingturf = v.nameofturf
						end
					elseif (Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 1.4) then
						inZone = false
					end
				end
			end
		end
		if inTurf then
			drawTxt(0.92,1.44,1.0,1.0,0.5,"Capping Turf: ~r~" .. secondsRemaining .. "~w~ seconds remaining",255,255,255,255)
			local pos2 = turfs[turf].position
			local ped = PlayerPedId()
			if IsEntityDead(ped) then
				TriggerServerEvent("NovaTurf:PlayerDied", turf)
			elseif (Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > turfs[turf].radius) then
				TriggerServerEvent("NovaTurf:TooFar", turf)
			end
		end
		Citizen.Wait(0)
	end
end)

RegisterNetEvent("HeroinZone")
AddEventHandler("HeroinZone",function(isnTurf)
	while true do
		if isInTurfTing then
			DrawMarker(1,3565.6037,3662.1218,33.9517 - 10,0,0,0,0,0,0,60.001,60.0001,150.5001,0,255,68,30,0,0,0,0)
		end
		Citizen.Wait(1)
	end
end)

RegisterNetEvent("turfTrue")
AddEventHandler("turfTrue",function(isit)
	if isit then
		isInTurfTing = true
	else
		isInTurfTing = false
	end
end)

RegisterNetEvent("LSDZone")
AddEventHandler("LSDZone",function(isnTurf)
	while true do
		if isInTurfTing then
			DrawMarker(1,2483.0139,-417.5256,93.7352 - 10,0,0,0,0,0,0,80.001,80.0001,150.5001,0,255,68,30,0,0,0,0)
		end
		Citizen.Wait(1)
	end
end)

RegisterNetEvent("LargeArmsZone")
AddEventHandler("LargeArmsZone",function(isnTurf)
	while true do
		if isInTurfTing then
			DrawMarker(1,-1119.6816,4924.2880,218.3512 - 10,0,0,0,0,0,0,60.001,60.0001,150.5001,0,255,68,30,0,0,0,0)
		end
		Citizen.Wait(1)
	end
end)

RegisterNetEvent("WeedZone")
AddEventHandler("WeedZone",function(isnTurf)
	while true do
		if isInTurfTing then
			DrawMarker(1, -1092.7376,-1640.4052,4.3984 - 10,0,0,0,0,0,0,100.001,100.0001,150.5001,0,255,68,30,0,0,0,0)
		end
		Citizen.Wait(1)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		DrawMarker(24, 3572.0119,3649.6362,33.8895 + 1 - 0.98,0,0,0,0,0,0,0.8,0.8,0.8,255,34,0,200,0,0,0,0,0,0,0)
		DrawMarker(24, 2477.9226,-420.8518,93.7351 + 1 - 0.98,0.8,0.8,0,0,0,0,1.0,1.0,0.8,255,34,0,200,0,0,0,0,0,0,0)
		DrawMarker(24, -1101.0473,4940.7080,218.3538 + 1 - 0.98,0.8,0.8,0,0,0,0,1.0,1.0,0.8,255,34,0,200,0,true,0,0,0,0,0)
		DrawMarker(24,-1067.1387,-1667.9991,4.5140 + 1 - 0.98,0.9,0.0,0,0,0,0,1.0,1.0,0.8,255,34,0,200,false,true,0,0,0,0,0)
		if doneIt then
			DrawMarker(30,-1102.7158,4936.5854,218.3814 + 1 - 0.98,0.8,0.8,0,0,0,0,0.5,0.5,0.5,255,34,0,200,true,true,0,0,0,0,0)
		end
	end
end)

function alert(str)
	SetTextComponentFormat("STRING")
	AddTextComponentSubstringPlayerName(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function drawTxt(x, y, width, height, scale, text, r, g, b, a, outline)
	SetTextFont(0)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	if (outline) then
		SetTextOutline()
	end
	BeginTextCommandDisplayText("STRING")
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(x - width / 2, y - height / 2 + 0.005)
end