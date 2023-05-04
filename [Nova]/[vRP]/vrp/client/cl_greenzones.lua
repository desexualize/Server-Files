local blips = {
	['License Centre'] = {
		title = "Safe Zone",
		colour = 2,
		id = 1,
		pos = vector3(-538.44488525391, -218.1847076416, 40.40007400512),
		dist = 60.0,
		nonRP = false,
		setBit = false
	}, -- License Centre 1

	['License Centre 2'] = {
		title = "Safe Zone",
		colour = 2,
		id = 1,
		pos = vector3(1697.7370605469, 3765.6240234375, 34.755424499512),
		dist = 30.0,
		nonRP = false,
		setBit = false
	}, -- License Centre 2

	['Casino 1'] = {
		title = "Safe Zone",
		colour = 2,
		id = 1,
		pos = vector3(1134.6573486328, 251.09861755371, -51.035732269287),
		dist = 100.0,
		nonRP = false,
		setBit = false
	}, -- Casino 1

	['Casino 2'] = {
		title = "Safe Zone",
		colour = 2,
		id = 1,
		pos = vector3(919.62432861328,51.604522705078,80.898529052734),
		dist = 20.0,
		nonRP = false,
		setBit = false
	}, -- Casino 2

	['ST Thomas Hopsital'] = {
		title = "Safe Zone",
		colour = 2,
		id = 1,
		pos = vector3(333.91488647461, -597.16156005859, 29.292747497559),
		dist = 40.0,
		nonRP = false,
		setBit = false
	}, -- Pillbox
	
	['Sandy Medical'] = {
		title = "Safe Zone",
		colour = 2,
		id = 1,
		pos = vector3(1832.4654541016, 3678.6604003906, 42.009292602539),
		dist = 35.0,
		nonRP = false,
		setBit = false
	}, -- Sandy Medical

	['Paleto Medical'] = {
		title = "Safe Zone",
		colour = 2,
		id = 1,
		pos = vector3(-254.16650390625, 6324.3740234375, 39.203189849854),
		dist = 30.0,
		nonRP = false,
		setBit = false
	}, -- Paleto Medical

	['Vip Island'] = {
		title = "Safe Zone",
		colour = 2,
		id = 1,
		pos = vector3(-2170.4770507812, 5179.0668945312, 15.63862323761),
		dist = 100.0,
		nonRP = false,
		setBit = false
	}, -- VIP Island

	['Legion Square'] = {
		title = "Safe Zone",
		colour = 2,
		id = 1,
		pos = vector3(170.51364135742, -1021.3690795898, 28.816247940063),
		dist = 50.0,
		nonRP = false,
		setBit = false
	}, -- Legion Square

	['Admin Island'] = {
		title = "Safe Zone",
		colour = 2,
		id = 1,
		pos = vector3(3492.4116210938, 2579.2509765625, 13.129757881165),
		dist = 100.0,
		nonRP = true,
		setBit = false
	} -- Admin
}

Citizen.CreateThread(function()
	for name, info in pairs(blips) do
		local blip_radius = AddBlipForRadius(info.pos, info.dist)
		SetBlipColour(blip_radius, 2)
		SetBlipAlpha(blip_radius, 170)
	end
end)

InsideSafeZone = false
setDrawGreenZoneUI = false
setDrawNonRpZoneUI = false
Citizen.CreateThread(function()
	while true do
		for name, info in pairs(blips) do
			local client_ped = PlayerPedId()
			local plyCoords = GetEntityCoords(client_ped)
			safeZoneDist = #(plyCoords - info.pos)

			while safeZoneDist < info.dist do
				local plyCoords = GetEntityCoords(client_ped)
				safeZoneDist = #(plyCoords - info.pos)

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
				Citizen.Wait(1000)
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
			SetEntityInvincible(client_ped, false)
			SetPlayerInvincible(PlayerId(), false)
			--SetPedCanRagdoll(PlayerPedId(), true)
			ClearPedBloodDamage(client_ped)
			ResetPedVisibleDamage(client_ped)
			ClearPedLastWeaponDamage(client_ped)
			SetEntityProofs(client_ped, false, false, false, false, false, false, false, false)
			SetEntityCanBeDamaged(client_ped, true)
			NetworkSetFriendlyFireOption(true)
		end

		Wait(1000)
	end
end)

Citizen.CreateThread(function()
	while true do
		local plyCoords = GetEntityCoords(PlayerPedId())
		cityZoneDist = #(plyCoords - vector3(171.07974243164, -1024.8974609375, 29.3747520446784))
		if cityZoneDist < 500 then
			inCityZone = true
		else
			inCityZone = false
		end
		--print("inCityZone: " .. tostring(inCityZone))
		Citizen.Wait(1000)
	end
end)

Citizen.CreateThread(function()
	while true do
		if setDrawGreenZoneUI then
			DisableControlAction(2, 37, true) -- disable weapon wheel (Tab)
			DisablePlayerFiring(PlayerPedId(), true) -- Disables firing all together if they somehow bypass inzone Mouse Disable
			DisableControlAction(0, 106, true) -- Disable in-game mouse controls
			DisableControlAction(0, 45, true)
			DisableControlAction(0, 24, true)
			DisableControlAction(0, 263, true)
			DisableControlAction(0, 170, true)
		end
		if setDrawNonRpZoneUI then
			bank_drawTxt(
				0.76,
				1.44,
				1.0,
				1.0,
				0.4,
				"You have entered a non-RP greenzone, you may talk out of character here",
				0,
				255,
				0,
				255
			)
			DisableControlAction(2, 37, true) -- disable weapon wheel (Tab)
			DisablePlayerFiring(PlayerPedId(), true) -- Disables firing all together if they somehow bypass inzone Mouse Disable
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
		Citizen.Wait(0)
	end
end)

--RegisterCommand("godmode",function()
--print("showEnterGreenzone: " .. tostring(showEnterGreenzone))
--print("showExitGreenzone: " .. tostring(showExitGreenzone))
--print("setDrawGreenZoneUI: " .. tostring(setDrawGreenZoneUI))
--print("setDrawNonRpZoneUI: " .. tostring(setDrawNonRpZoneUI))
--print("greenzoneTimer: " .. tostring(greenzoneTimer))
--print("max health: " .. tostring(GetEntityMaxHealth(PlayerPedId())))
--end)

local Client_Founder = false -- Is client a founder?
Citizen.CreateThread(function()
	while true do
		local client_ped = PlayerPedId()

		if setDrawGreenZoneUI or setDrawNonRpZoneUI then
			SetEntityMaxSpeed(GetVehiclePedIsIn(client_ped, false), 13.0)
			SetEntityInvincible(client_ped, true)
			SetPlayerInvincible(PlayerId(), true)
			-- SetPedCanRagdoll(client_ped, false)
			ClearPedBloodDamage(client_ped)
			SetCurrentPedWeapon(client_ped, GetHashKey("WEAPON_UNARMED"), true)
			ResetPedVisibleDamage(client_ped)
			ClearPedLastWeaponDamage(client_ped)
			SetEntityProofs(client_ped, true, true, true, true, true, true, true, true)
			SetEntityCanBeDamaged(client_ped, false)
		else
			local client_vehicle = GetVehiclePedIsIn(client_ped, false)
			if client_vehicle ~= 0 then
				if Client_Founder then
					if not tvRP.Is_In_Speed_Zone() then
						SetEntityMaxSpeed(client_vehicle, 447.04) -- 1,000 MPH
					end
				else
					if inCityZone then
						SetEntityMaxSpeed(client_vehicle, 44.6) -- 99.76 MPH
					else
						SetEntityMaxSpeed(client_vehicle, 111.5) -- 249.41 MPH
					end
				end
			end
		end
		
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('Nova:Client:FounderSet')
AddEventHandler('Nova:Client:FounderSet', function(bool_value)
	Client_Founder = bool_value
end)

-- Citizen.CreateThread(function()
-- 	while true do
-- 		if setDrawGreenZoneUI or setDrawNonRpZoneUI then
-- 			if IsEntityDead(PlayerPedId()) or GetEntityHealth(PlayerPedId()) <= 102 then
-- 				TriggerEvent("Nova:Revive")
-- 			end
-- 			----print("Is this entity ass hole dead?: " .. tostring(IsEntityDead(PlayerPedId())))
-- 			----print("Is this entity ass hole health?: " .. tostring(GetEntityHealth(PlayerPedId())))
-- 		end
-- 		Wait(10000)
-- 	end
-- end)

showEnterGreenzone = true
showExitGreenzone = true
greenzoneTimer = 0

Citizen.CreateThread(function()
	while true do
		if showEnterGreenzone and greenzoneTimer > 0 then
			--bank_drawTxt(0.92, 1.44, 1.0,1.0,0.4, "You have entered a greenzone, OOC is allowed!", 0, 255, 0, 255)
			TriggerEvent("swt_notifications:Success", nil, "You have entered a Greenzone!", "top-right", nil, true)
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
			--bank_drawTxt(0.92, 1.44, 1.0,1.0,0.4, "You have left a greenzone, Please follow city rules!", 255, 17, 0, 255)
			TriggerEvent("swt_notifications:Negative", nil, "You have exited a Greenzone!", "top-right", nil, true)
		end
		
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		greenzoneTimer = greenzoneTimer - 1
		Citizen.Wait(0)
	end
end)

function bank_drawTxt(x, y, width, height, scale, text, r, g, b, a, outline)
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

function DrawAdvancedText(x, y, w, h, sc, text, r, g, b, a, font, jus)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(sc, sc)
	SetTextJustification(jus)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	BeginTextCommandDisplayText("STRING")
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(x - 0.1 + w, y - 0.02 + h)
end