local cfg = module("FNRCars", "cfg/cfg_speedcap")
vRP = Proxy.getInterface("vRP")
tvRP = Proxy.getInterface("vRP")
inGreenzone = false
instaffmode = false
stThomas = {x = 333.91488647461, y = -597.16156005859, z = 29.292747497559}
legionJD = {x = 154.30529785156, y = -1049.1298828125, z = 29.243709564209}
cityHall = {x = -538.44488525391, y = -218.1847076416, z = 40.40007400512}
legionGarage = {x = 246.30143737793, y = -782.50170898438, z = 30.573167800903}
adminIsland = {x = 3511.8503417969, y = 2567.5361328125, z = 9.545202255249}
vipIsland = {x = -2167.8471679688, y = 5196.4565429688, z = 16.880462646484}
casino = {x = 1112.1011962891, y = 227.21548461914, z = -49.624801635742}
beachCinema = {x = -1670.4360351563, y = -902.43530273438, z = 8.4033660888672}
groveStreet = {x = 108.45377349854, y = -1943.3997802734, z = 20.803728103638}
missionRow = {x = 448.98864746094, y = -984.71618652344, z = 30.68931388855}
londonHospital = {x = 341.17095947266, y = -1396.7863769531, z = 32.509269714355}
viptp = {x = -2341.7902832031, y = 284.36248779297, z = 169.4672088623}

local blips = {
	{title="Safe Zone", colour=2, id=1, pos=vector3(stThomas.x, stThomas.y, stThomas.z),dist=55,nonRP=false,setBit=false},
	{title="Safe Zone", colour=2, id=1, pos=vector3(londonHospital.x, londonHospital.y, londonHospital.z),dist=40,nonRP=false,setBit=false},
	{title="Safe Zone", colour=2, id=1, pos=vector3(legionJD.x, legionJD.y, legionJD.z),dist=55,nonRP=false,setBit=false},
	{title="Safe Zone", colour=2, id=1, pos=vector3(viptp.x, viptp.y, viptp.z),dist=40,nonRP=false,setBit=false},
	{title="Safe Zone", colour=2, id=1, pos=vector3(cityHall.x, cityHall.y, cityHall.z),dist=60,nonRP=false,setBit=false},
	{title="Safe Zone", colour=2, id=1, pos=vector3(legionGarage.x, legionGarage.y, legionGarage.z),dist=40,nonRP=false,setBit=false},
	{title="Safe Zone", colour=2, id=1, pos=vector3(adminIsland.x, adminIsland.y, adminIsland.z),dist=105,adminzone=true,setBit=true},
	{title="Safe Zone", colour=2, id=1, pos=vector3(vipIsland.x, vipIsland.y, vipIsland.z),dist=130,nonRP=true,setBit=false},
	{title="Safe Zone", colour=2, id=1, pos=vector3(casino.x, casino.y, casino.z),dist=70,nonRP=false,setBit=false,interior=true},
}


if not purge then
	local pos = AddBlipForRadius(-1670.4360351563,-902.43530273438,8.4033660888672, 30.0) -- big screen
	SetBlipColour(pos, 2)
	SetBlipAlpha(pos, 170)
	local pos = AddBlipForRadius(333.91488647461,-597.16156005859,29.292747497559, 55.0) -- st thomas
	SetBlipColour(pos, 2)
	SetBlipAlpha(pos, 170)
	local pos = AddBlipForRadius(154.30529785156,-1049.1298828125,29.243709564209, 55.0) -- jd green 
	SetBlipColour(pos, 2)
	SetBlipAlpha(pos, 170)
	local pos = AddBlipForRadius(108.45377349854,-1943.3997802734,20.803728103638, 35.0) -- Green circle at weed
	SetBlipColour(pos, 2)
	SetBlipAlpha(pos, 70)
	local pos = AddBlipForRadius(246.30143737793,-782.50170898438,30.573167800903, 40.0) -- legion garage
	SetBlipColour(pos, 2)
	SetBlipAlpha(pos, 170)
	local pos = AddBlipForRadius(-2341.7902832031,284.36248779297,169.4672088623, 40.0) -- viptp
	SetBlipColour(pos, 2)
	SetBlipAlpha(pos, 170)
	local pos = AddBlipForRadius(-538.44488525391,-218.1847076416,40.400074005127, 60.0) -- town hall
	SetBlipColour(pos, 2)
	SetBlipAlpha(pos, 170)
	--local pos = AddBlipForRadius(1543.2639160156,6332.7084960938,24.076063156128, 60.0) -- town hall
	--SetBlipColour(pos, 2)
	--SetBlipAlpha(pos, 170)
	-- local pos = AddBlipForRadius(448.98864746094,-984.71618652344,30.68931388855, 45.0) -- mission row
	-- SetBlipColour(pos, 2)
	-- SetBlipAlpha(pos, 170)
end



InsideSafeZone = false
setDrawGreenZoneUI = false
setDrawNonRpZoneUI = false
setDrawAdminIsland = false
Citizen.CreateThread(function()
	while true do
		for index,info in pairs(blips) do
			local plyCoords = GetEntityCoords(PlayerPedId(), false)
			safeZoneDist = #(plyCoords-info.pos) 
			while safeZoneDist < info.dist do
				local plyCoords = GetEntityCoords(PlayerPedId(), false)
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
						show = true
						Wait(2)
						show = false
					end
					if info.interior then 
						setDrawGreenInterior = true
					end
					if info.adminzone then 
						setDrawAdminIsland = true
					end
				end
				Wait(0)
			end
			if info.setBit then
				showEnterGreenzone = false
				showExitGreenzone = true
				greenzoneTimer = 5
				info.setBit = false
				show2 = true
				Wait(2)
				show2 = false
			end
			setDrawNonRpZoneUI = false
			setDrawGreenZoneUI = false
			setDrawAdminIsland = false
			showEnterGreenzone = false
			setDrawGreenInterior = false
			Citizen.InvokeNative(0x5FFE9B4144F9712F, false)
            if not instaffmode then
                SetEntityInvincible(GetPlayerPed(-1), false)
                SetPlayerInvincible(PlayerId(), false)
                ClearPedBloodDamage(GetPlayerPed(-1))
                ResetPedVisibleDamage(GetPlayerPed(-1))
                ClearPedLastWeaponDamage(GetPlayerPed(-1))
                SetEntityProofs(GetPlayerPed(-1), false, false, false, false, false, false, false, false)
                SetEntityCanBeDamaged(GetPlayerPed(-1), true)
                NetworkSetFriendlyFireOption(true)
            end
			inGreenzone = false
			SetEntityAlpha(PlayerPedId(), 255)
		end
		Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
		cityZoneDist = #(plyCoords-vector3(171.07974243164,-1024.8974609375,29.3747520446784))
		if cityZoneDist < 700 then
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
			DisableControlAction(2, 37, true) -- disable weapon wheel (Tab)
			DisablePlayerFiring(GetPlayerPed(-1),true) -- Disables firing all together if they somehow bypass inzone Mouse Disable
			DisableControlAction(0, 106, true) -- Disable in-game mouse controls
			DisableControlAction(0, 45, true)
			DisableControlAction(0, 24, true)
			DisableControlAction(0, 263, true)
			DisableControlAction(0, 170, true)
            Citizen.InvokeNative(0x5FFE9B4144F9712F, true)
			SetEntityAlpha(PlayerPedId(), 255)
		end
		if setDrawNonRpZoneUI then
			bank_drawTxt(0.83, 1.40, 1.0, 1.0, 0.43, "You have entered a non-RP greenzone, you may talk OOC here", 0, 255, 0, 255)
			DisableControlAction(2, 37, true) -- disable weapon wheel (Tab)
			DisablePlayerFiring(GetPlayerPed(-1),true) -- Disables firing all together if they somehow bypass inzone Mouse Disable
			DisableControlAction(0, 45, true)
			DisableControlAction(0, 24, true)
			DisableControlAction(0, 263, true)
			DisableControlAction(0, 170, true)
            Citizen.InvokeNative(0x5FFE9B4144F9712F, true)
			SetEntityAlpha(PlayerPedId(), 255)
		end
		if setDrawAdminIsland then
			inRedZone = false
			bank_drawTxt(0.83, 1.40, 1.0, 1.0, 0.43, "You have entered Admin Island, You may talk OOC here", 0, 255, 0, 255)
			DisableControlAction(2, 37, true) -- disable weapon wheel (Tab)
			DisablePlayerFiring(GetPlayerPed(-1),true) -- Disables firing all together if they somehow bypass inzone Mouse Disable
			DisableControlAction(0, 45, true)
			DisableControlAction(0, 24, true)
			DisableControlAction(0, 263, true)
			DisableControlAction(0, 170, true)
            Citizen.InvokeNative(0x5FFE9B4144F9712F, true)
			SetEntityAlpha(PlayerPedId(), 255)
		end
		if setDrawGreenInterior then 
			DisableControlAction(0, 106, true) -- Disable in-game mouse controls
			DisableControlAction(0, 45, true)
			DisableControlAction(0, 24, true)
			DisableControlAction(0, 263, true)
			DisableControlAction(0, 170, true)
			DisableControlAction(0, 22, true)
            Citizen.InvokeNative(0x5FFE9B4144F9712F, true)
			SetEntityAlpha(PlayerPedId(), 255)
		end
		Wait(0)
	end
end)


Citizen.CreateThread(function()
        while true do
			local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
            if setDrawGreenZoneUI or setDrawNonRpZoneUI or setDrawAdminIsland then
				inGreenzone = true
                SetEntityMaxSpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false), 22.3)
                SetEntityInvincible(GetPlayerPed(-1), true)
                SetPlayerInvincible(PlayerId(), true)
                -- SetPedCanRagdoll(GetPlayerPed(-1), false)
                ClearPedBloodDamage(GetPlayerPed(-1))
                SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_UNARMED"), true)
                ResetPedVisibleDamage(GetPlayerPed(-1))
                ClearPedLastWeaponDamage(GetPlayerPed(-1))
                SetEntityProofs(GetPlayerPed(-1), true, true, true, true, true, true, true, true)
                SetEntityCanBeDamaged(GetPlayerPed(-1), false)
				if not tvRP.isInComa() then
					SetEntityHealth(GetPlayerPed(-1), 200)
				end
            else
                if GetVehiclePedIsIn(PlayerPedId(), false) ~= 0 then
                    if not inCityZone then
                        if GetVehicleClass(GetVehiclePedIsIn(GetPlayerPed(-1), true)) ~= 13 or not IsThisModelAPlane(GetVehiclePedIsIn(GetPlayerPed(-1), true))
					then
                            SetEntityMaxSpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false), cfg.maxSpeeds["250"])
                        else
                            SetEntityMaxSpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false), cfg.maxSpeeds["1000"])
                        end
                    else
                        if GetVehicleClass(GetVehiclePedIsIn(GetPlayerPed(-1), true)) ~= 13 then
                            SetEntityMaxSpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false), cfg.maxSpeeds["150"])
                        end
                    end
                end
            end
			Wait(0)
        end
    end
)

	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)
			local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
			if not inCityZone then		
			if vehicle ~= false then
				local model = GetEntityModel(vehicle)
				if cfg.vehicleMaxSpeeds[model] ~= nil then
					SetEntityMaxSpeed(vehicle, cfg.maxSpeeds[cfg.vehicleMaxSpeeds[model]])
				else
					SetEntityMaxSpeed(vehicle, cfg.maxSpeeds["250"])
					end
				end
			end
		end
	end)
	

showEnterGreenzone = false
showExitGreenzone = false
greenzoneTimer = 0

Citizen.CreateThread(function()
	while true do
		if showEnterGreenzone and greenzoneTimer > 0 then
			local textColour = '#ffffff'
			if show then
				TriggerEvent("swt_notifications:Success",nil,"You have entered a Greenzone!","top-right",nil,true)
			end
		end
		if showExitGreenzone and greenzoneTimer > 0 then
			if show2 then
				TriggerEvent("swt_notifications:Negative",nil,"You have exited a Greenzone!","top-right",nil,true)
			end
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

function bank_drawTxt2(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(7)
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

function DoHudText(type, text, style)
	SendNUIMessage({
		type = type,
		text = text,
		length = 2500,
		style = style
	})
end

Citizen.CreateThread(function()
    blip = AddBlipForCoord(1779.1336669922,2583.392578125,45.797832489014)
    SetBlipSprite(blip, 285)
    SetBlipScale(blip, 0.5)
    SetBlipDisplay(blip, 2)
    SetBlipColour(blip, 1)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Prison")
    EndTextCommandSetBlipName(blip)
  end)

  RegisterNetEvent('greenzoneStaffMode')
  AddEventHandler('greenzoneStaffMode',function(staffmode)
	  instaffmode = staffmode
  end)