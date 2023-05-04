local blips = {
	{title="Safe Zone", colour=2, id=1, pos=vector3(-538.44488525391,-218.1847076416,40.40007400512),dist=60,nonRP=false,setBit=false}, -- LicenseCentre2
    {title="Safe Zone", colour=2, id=1, pos=vector3(1697.7370605469,3765.6240234375,34.755424499512),dist=30,nonRP=false,setBit=false}, -- LicenseCentre
    {title="Safe Zone", colour=2, id=1, pos=vector3(1134.6573486328,251.09861755371,-51.035732269287),dist=100,nonRP=false,setBit=false}, -- Casino
    --{title="Safe Zone", colour=2, id=1, pos=vector3(919.62432861328,51.604522705078,80.898529052734),dist=20,nonRP=false,setBit=false}, -- Casino2

    {title="Safe Zone", colour=2, id=1, pos=vector3(1832.4654541016,3678.6604003906,42.009292602539),dist=35,nonRP=false,setBit=false}, -- SandyMed
    {title="Safe Zone", colour=2, id=1, pos=vector3(333.91488647461,-597.16156005859,29.292747497559),dist=40,nonRP=false,setBit=false}, -- Pillbox
    {title="Safe Zone", colour=2, id=1, pos=vector3(-254.16650390625,6324.3740234375,39.203189849854),dist=30,nonRP=false,setBit=false}, -- PaletoMed

    {title="Safe Zone", colour=2, id=1, pos=vector3(-2170.4770507812,5179.0668945312,15.63862323761),dist=100,nonRP=false,setBit=false}, -- VIP Island
    {title="Safe Zone", colour=2, id=1, pos=vector3(170.51364135742,-1021.3690795898,28.816247940063),dist=50,nonRP=false,setBit=false}, -- VIP Island

	{title="Safe Zone", colour=2, id=1, pos=vector3(3492.4116210938,2579.2509765625,13.129757881165),dist=200,nonRP=false,setBit=false}, -- Admin
	

}
     

	 
local pos1 = AddBlipForRadius(-538.44488525391,-218.1847076416,40.40007400512, 60.0)
SetBlipColour(pos1, 2)
SetBlipAlpha(pos1, 170)

local pos2 = AddBlipForRadius(1697.7370605469,3765.6240234375,34.755424499512, 30.0)
SetBlipColour(pos2, 2)
SetBlipAlpha(pos2, 170)

--local pos3 = AddBlipForRadius(1134.6573486328,251.09861755371,-51.035732269287,100.0)
--SetBlipColour(pos3, 2)
--SetBlipAlpha(pos3, 170)

-- local pos4 = AddBlipForRadius(919.62432861328,51.604522705078,80.898529052734, 20.0)
-- SetBlipColour(pos4, 2)
-- SetBlipAlpha(pos4, 170)

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
						greenzoneTimer = 1
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
				greenzoneTimer = 1
				----print("greenzoneTimer = 10 #2 " .. tostring(greenzoneTimer))
				info.setBit = false
			end
			setDrawNonRpZoneUI = false
			setDrawGreenZoneUI = false
			showEnterGreenzone = false
			setDrawGreenInterior = false
			SetEntityInvincible(GetPlayerPed(-1), false)
			SetPlayerInvincible(PlayerId(), false)
			--SetPedCanRagdoll(GetPlayerPed(-1), true)
			ClearPedBloodDamage(GetPlayerPed(-1))
			ResetPedVisibleDamage(GetPlayerPed(-1))
			ClearPedLastWeaponDamage(GetPlayerPed(-1))
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
		--print("inCityZone: " .. tostring(inCityZone))
		Wait(1000)
	end
end)


Citizen.CreateThread(function()
	while true do
		if setDrawGreenZoneUI then
			DisableControlAction(2, 37, true) -- disable weapon wheel (Tab)
			DisablePlayerFiring(GetPlayerPed(-1),true) -- Disables firing all together if they somehow bypass inzone Mouse Disable
			DisableControlAction(0, 106, true) -- Disable in-game mouse controls
			DisableControlAction(0, 45, true)
			DisableControlAction(0, 24, true)
			DisableControlAction(0, 263, true)
			DisableControlAction(0, 170, true)
		end
		if setDrawNonRpZoneUI then
			bank_drawTxt(0.76, 1.44, 1.0,1.0,0.4, "You have entered a non-RP greenzone, you may talk out of character here", 0, 255, 0, 255)
			DisableControlAction(2, 37, true) -- disable weapon wheel (Tab)
			DisablePlayerFiring(GetPlayerPed(-1),true) -- Disables firing all together if they somehow bypass inzone Mouse Disable
			DisableControlAction(0, 45, true)
			DisableControlAction(0, 24, true)
			DisableControlAction(0, 263, true)
			DisableControlAction(0, 170, true)
		end
		if setDrawGreenInterior then 
			DisableControlAction(0, 106, true) -- Disable in-game mouse controls
			DisableControlAction(0, 45, true)
			DisableControlAction(0, 24, true)
			DisableControlAction(0, 263, true)
			DisableControlAction(0, 170, true)
			DisableControlAction(0, 22, true)
		end
		Wait(0)
	end
end)

--RegisterCommand("godmode",function()
	--print("showEnterGreenzone: " .. tostring(showEnterGreenzone))
	--print("showExitGreenzone: " .. tostring(showExitGreenzone))
	--print("setDrawGreenZoneUI: " .. tostring(setDrawGreenZoneUI))
	--print("setDrawNonRpZoneUI: " .. tostring(setDrawNonRpZoneUI))
	--print("greenzoneTimer: " .. tostring(greenzoneTimer))
	--print("max health: " .. tostring(GetEntityMaxHealth(GetPlayerPed(-1))))
--end)



Citizen.CreateThread(function()
	while true do
		if setDrawGreenZoneUI or setDrawNonRpZoneUI then
			SetEntityMaxSpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false),13.0)
			SetEntityInvincible(GetPlayerPed(-1), true)
			SetPlayerInvincible(PlayerId(), true)
			-- SetPedCanRagdoll(GetPlayerPed(-1), false)
			ClearPedBloodDamage(GetPlayerPed(-1))
			SetCurrentPedWeapon(GetPlayerPed(-1),GetHashKey("WEAPON_UNARMED"),true)
			ResetPedVisibleDamage(GetPlayerPed(-1))
			ClearPedLastWeaponDamage(GetPlayerPed(-1))
			SetEntityProofs(GetPlayerPed(-1), true, true, true, true, true, true, true, true)
			SetEntityCanBeDamaged(GetPlayerPed(-1), false)
		else
			if GetVehiclePedIsIn(PlayerPedId(), false) ~= 0 then
				if not inCityZone then
					if GetVehicleClass(GetVehiclePedIsIn(GetPlayerPed(-1),true)) ~= 13 then
						SetEntityMaxSpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false),111.5)
					else
						SetEntityMaxSpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false),11001.5)
					end
				else 
					if GetVehicleClass(GetVehiclePedIsIn(GetPlayerPed(-1),true)) ~= 13 then
						SetEntityMaxSpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false),44.6)
					else
						SetEntityMaxSpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false),11001.5)
					end
				end
			end
		end
		Wait(0)
	end
end)

-- Citizen.CreateThread(function()
-- 	while true do
-- 		if setDrawGreenZoneUI or setDrawNonRpZoneUI then
-- 			if IsEntityDead(GetPlayerPed(-1)) or GetEntityHealth(GetPlayerPed(-1)) <= 102 then 
-- 				TriggerEvent("GRP:Revive")
-- 			end
-- 			----print("Is this entity ass hole dead?: " .. tostring(IsEntityDead(GetPlayerPed(-1))))
-- 			----print("Is this entity ass hole health?: " .. tostring(GetEntityHealth(GetPlayerPed(-1))))
-- 		end
-- 		Wait(10000)
-- 	end
-- end)

showEnterGreenzone = false
showExitGreenzone = false
greenzoneTimer = 0

Citizen.CreateThread(function()
	while true do
		if showEnterGreenzone and greenzoneTimer > 0 then
			-- bank_drawTxt(0.92, 1.44, 1.0,1.0,0.4, "You have entered a greenzone, OOC is allowed!", 0, 255, 0, 255)
			TriggerEvent("swt_notifications:Success",nil,"You have entered a Greenzone!","top-right",nil,true)
			for _, i in ipairs(GetActivePlayers()) do
			
				--if i ~= PlayerId() then
				--  local closestPlayerPed = GetPlayerPed(i)
				--  local vehh = GetVehiclePedIsIn(closestPlayerPedd, false)
				--  SetEntityAlpha(closestPlayerPed, 50, false)
				--  SetEntityAlpha(vehh, 50, false)
				--
				--end
			
				
			  end
		end
		if showExitGreenzone and greenzoneTimer > 0 then
			-- bank_drawTxt(0.92, 1.44, 1.0,1.0,0.4, "You have left a greenzone, Please follow city rules!", 255, 17, 0, 255)
			TriggerEvent("swt_notifications:Negative",nil,"You have exited a Greenzone!","top-right",nil,true)
		end
		Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		greenzoneTimer = greenzoneTimer - 1
		Wait(0)
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



















