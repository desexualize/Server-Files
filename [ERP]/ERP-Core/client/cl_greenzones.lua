local a = {}
local blips = {
	{title="Safe Zone", colour=2, id=1, pos=vector3(-538.44488525391,-218.1847076416,40.40007400512),dist=60,nonRP=false,setBit=false}, -- LicenseCentre2
    {title="Safe Zone", colour=2, id=1, pos=vector3(1134.6573486328,251.09861755371,-51.035732269287),dist=100,nonRP=false,setBit=false}, -- Casino
    {title="Safe Zone", colour=2, id=1, pos=vector3(1832.4654541016,3678.6604003906,42.009292602539),dist=35,nonRP=false,setBit=false}, -- SandyMed
    {title="Safe Zone", colour=2, id=1, pos=vector3(333.91488647461,-597.16156005859,29.292747497559),dist=40,nonRP=false,setBit=false}, -- Pillbox
    {title="Safe Zone", colour=2, id=1, pos=vector3(-254.16650390625,6324.3740234375,39.203189849854),dist=30,nonRP=false,setBit=false}, -- PaletoMed
    {title="Safe Zone", colour=2, id=1, pos=vector3(-2170.4770507812,5179.0668945312,15.63862323761),dist=100,nonRP=false,setBit=false}, -- VIP Island
    {title="Safe Zone", colour=2, id=1, pos=vector3(170.51364135742,-1021.3690795898,28.816247940063),dist=50,nonRP=false,setBit=false}, -- VIP Island
	{title="Safe Zone", colour=2, id=1, pos=vector3(3492.4116210938,2579.2509765625,13.129757881165),dist=200,nonRP=false,setBit=false}, -- Admin
	{title="Safe Zone", colour=2, id=1, pos=vector3(1097.5955810547,-3100.2177734375,-38.999938964844),dist=10,nonRP=false,setBit=false}, -- Admin
	

}

local pos1 = AddBlipForRadius(-538.44488525391,-218.1847076416,40.40007400512, 60.0)
SetBlipColour(pos1, 2)
SetBlipAlpha(pos1, 170)

local pos5 = AddBlipForRadius(1832.4654541016,3678.6604003906,42.009292602539, 35.0)
SetBlipColour(pos5, 2)
SetBlipAlpha(pos5, 170)

local pos6 = AddBlipForRadius(333.91488647461,-597.16156005859,29.292747497559, 40.0)
SetBlipColour(pos6, 2)
SetBlipAlpha(pos6, 170)

local pos7= AddBlipForRadius(-254.16650390625,6324.3740234375,39.20318984985, 30.0)
SetBlipColour(pos7, 2)
SetBlipAlpha(pos7, 170)

local pos8= AddBlipForRadius(-2170.4770507812,5179.0668945312,15.63862323761, 100.0)
SetBlipColour(pos8, 2)
SetBlipAlpha(pos8, 170)

local pos9= AddBlipForRadius(170.51364135742,-1021.3690795898,28.816247940063, 50.0)
SetBlipColour(pos9, 2)
SetBlipAlpha(pos9, 170)


InsideSafeZone = false
setDrawGreenZoneUI = false
setDrawNonRpZoneUI = false
Citizen.CreateThread(function()
	while true do
		for index,info in pairs(blips) do
			local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
			safeZoneDist = #(plyCoords-info.pos) 
			while safeZoneDist < info.dist do
				local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
				safeZoneDist = #(plyCoords-info.pos)
				
				if info.nonRP then
					setDrawNonRpZoneUI = true
				else
					if not info.setBit then
						setDrawGreenZoneUI = true
						showEnterGreenzone = true
						showExitGreenzone = false
						greenzoneTimer = 5
						info.setBit = true
					end
					if info.interior then 
						setDrawGreenInterior = true
					end
				end
				Wait(1000)
			end
			if info.setBit then
				showEnterGreenzone = false
				showExitGreenzone = true
				greenzoneTimer = 5
				----print("greenzoneTimer = 10 #2 " .. tostring(greenzoneTimer))
				info.setBit = false
			end
			setDrawNonRpZoneUI = false
			setDrawGreenZoneUI = false
			showEnterGreenzone = false
			setDrawGreenInterior = false
			SetPedCanRagdoll(GetPlayerPed(-1), true)
			ClearPedBloodDamage(GetPlayerPed(-1))
			ResetPedVisibleDamage(GetPlayerPed(-1))
			ClearPedLastWeaponDamage(GetPlayerPed(-1))
			--SetEntityCollision(ped, true)
			SetEntityProofs(GetPlayerPed(-1), false, false, false, false, false, false, false, false)
			SetEntityCanBeDamaged(GetPlayerPed(-1), true)
			NetworkSetFriendlyFireOption(true)
		end
		Wait(1000)
	end
end)

Citizen.CreateThread(function()
	while true do
		local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
		cityZoneDist = #(plyCoords-vector3(171.07974243164,-1024.8974609375,29.3747520446784))
		if cityZoneDist < 500 then
			inCityZone = true 
		else 
			inCityZone = false 
		end
		Wait(1000)
	end
end)


Citizen.CreateThread(function()
	while true do
		if setDrawGreenZoneUI then
			DisablePlayerFiring(GetPlayerPed(-1),true) -- Disables firing all together if they somehow bypass inzone Mouse Disable
			DisableControlAction(0, 106, true) -- Disable in-game mouse controls
			DisableControlAction(0, 45, true)
			DisableControlAction(2, 37, true)
			DisableControlAction(0, 24, true)
			DisableControlAction(0, 263, true)
			DisableControlAction(0, 140, true)
		end
		if setDrawNonRpZoneUI then
			bank_drawTxt(0.86, 1.44, 1.0,1.0,0.4, "Your in a greenzone, you cannot be damaged.", 0, 255, 0, 255)
			DisablePlayerFiring(GetPlayerPed(-1),true)
			DisableControlAction(0, 45, true)
			DisableControlAction(0, 37, true)
			DisableControlAction(0, 24, true)
			DisableControlAction(0, 263, true)
			DisableControlAction(0, 140, true)
		end
		if setDrawGreenInterior then 
			DisableControlAction(0, 106, true)
			DisableControlAction(0, 45, true)
			DisableControlAction(0, 24, true)
			DisableControlAction(0, 263, true)
			DisableControlAction(0, 140, true)
			DisableControlAction(0, 22, true)
		end
		Wait(0)
	end
end)

Citizen.CreateThread(function()
	local model = GetEntityModel()
	local urusmansory = "urusmansory"
	while true do
		if setDrawGreenZoneUI or setDrawNonRpZoneUI then
			SetEntityMaxSpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false),66.9)
			ClearPedBloodDamage(GetPlayerPed(-1))
			ResetPedVisibleDamage(GetPlayerPed(-1))
			ClearPedLastWeaponDamage(GetPlayerPed(-1))
			SetEntityProofs(GetPlayerPed(-1), true, true, true, true, true, true, true, true)
			SetEntityCanBeDamaged(GetPlayerPed(-1), false)
		else
			if GetVehiclePedIsIn(PlayerPedId(), false) ~= 0 then
				local C=GetVehiclePedIsIn(GetPlayerPed(-1),false)
				local I=GetEntityModel(C)
				if not inCityZone then
					if a.vehicleMaxSpeeds[I]~=nil then 
						SetEntityMaxSpeed(C,a.maxSpeeds[a.vehicleMaxSpeeds[I]])
					else 
						SetEntityMaxSpeed(C,a.maxSpeeds["250"])
					end
				else
					if a.vehicleMaxSpeeds[I]~=nil then 
						SetEntityMaxSpeed(C,a.maxSpeeds[a.vehicleMaxSpeeds[I]])
					else 
						SetEntityMaxSpeed(C,a.maxSpeeds["250"])
					end
				end
			end
		end
		Wait(0)
	end
end)

showEnterGreenzone = false
showExitGreenzone = false
greenzoneTimer = 0

Citizen.CreateThread(function()
	while true do
		if showEnterGreenzone and greenzoneTimer > 0 then
		end
		if showExitGreenzone and greenzoneTimer > 0 then
		end
		Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		greenzoneTimer = greenzoneTimer - 1
		Wait(1000)
	end
end)

function bank_drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
	    SetTextOutline()
	end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

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

a.maxSpeeds = {
    ["30"] = 13.0,
    ["50"] = 22.3,
	["100"] = 44.6,
    ["150"] = 66.9,
    ["175"] = 78.05,
	["200"] = 89.5,
	["230"] = 102.5,
	["240"] = 53.5 * 2,
    ["250"] = 111.5,
    ["300"] = 44.6 * 3,
	["320"] = 35.7 * 4,
	["350"] = 78.05 * 2,
	["375"] = 167.25,
	["500"] = 111.5 * 2,
	["1000"] = 11001.5
}

a.vehicleMaxSpeeds = {

-- Founder & Dev
	[`octane`] = "1000", -- Ethzn
	[`wattskill`] = "500", -- WattSkill
	[`slyx5`] = "500", -- sly
	[`uzibentayga`] = "1000", -- Dessy
	[`ben`] = "1000", -- BP
	[`lloydzurus`] = "500", -- Donk
-- Managment Locks
	[`bbcorsa`] = "350", -- snwy
	[`uziurus`] = "350", -- nigger
	[`animem2`] = "350", -- Foxzaay
	[`m2prior`] = "350", -- Sutty
	[`hycadeevo`] = "300", -- Leighton
-- Offroaders 
[`stogger`] = "230", -- Ethzn

-- Mini Cars
[`minicyberbuggy`] = "200", -- Ethzn

}
