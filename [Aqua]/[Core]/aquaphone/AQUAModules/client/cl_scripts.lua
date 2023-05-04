--------------------------------- Hands Up --------------------------------

handsup = false

CreateThread(function()		
	RequestAnimDict('mp_arresting')
	RequestAnimDict('random@arrests')
	RequestAnimDict('missminuteman_1ig_2')

	while true do
		if IsControlPressed(1, 323) then
			DisablePlayerFiring(PlayerPedId(), true)
			DisableControlAction(0, 22, true)
			DisableControlAction(0, 25, true)
			if GetEntityHealth(PlayerPedId()) == 102 then
			else
				if not IsEntityDead(PlayerPedId()) then
					if not IsPedReloading(PlayerPedId()) then
						if not handsup then
							handsup = true

							TaskPlayAnim(PlayerPedId(), 'missminuteman_1ig_2', 'handsup_enter', 7.0, 1.0, -1, 50, 0, false, false, false)
						end
					end
				end
			end
		end


		if IsControlReleased(1, 323) and handsup then
			handsup = false

			CreateThread(function()
				local enableFiring = false

				CreateThread(function()
					Wait(1000)

					enableFiring = true
				end)
				
				while not enableFiring do
					DisablePlayerFiring(PlayerPedId(), true)

					Wait(1)
				end
			end)

			DisableControlAction(0, 21, true)
			DisableControlAction(0, 137, true)

			ClearPedTasks(PlayerPedId())
		end

		Wait(1)
	end
end)

Citizen.CreateThread(function()
	while true do
		if handsup then
			DisableControlAction(2, 37, true)
			DisableControlAction(0,24,true) -- disable attack
			DisableControlAction(0,25,true) -- disable aim
			DisableControlAction(0,47,true) -- disable weapon
			DisableControlAction(0,58,true) -- disable weapon
			DisablePlayerFiring(PlayerPedId(),true)
		end
		Wait(0)
	end
end)

--------------------------------- Anti pistol whip --------------------------------

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		local ped = PlayerPedId()
            	if IsPedArmed(ped, 6) then
	    	DisableControlAction(1, 140, true)
            	DisableControlAction(1, 141, true)
            	DisableControlAction(1, 142, true)
        end
    end
end)

--------------------------------- No wanted --------------------------------

Citizen.CreateThread(function()
	while true do
		Wait(0)
		for i = 1, 12 do
			EnableDispatchService(i, false)
		end
		SetPlayerWantedLevel(PlayerId(), 0, false)
		SetPlayerWantedLevelNow(PlayerId(), false)
		SetPlayerWantedLevelNoDrop(PlayerId(), 0, false)
	end
end)

--------------------------------- No punch --------------------------------

Citizen.CreateThread(function()
	while true do
			if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey("WEAPON_UNARMED") then
				DisableControlAction(0,263,true)
				DisableControlAction(0,264,true)
				DisableControlAction(0,257,true)
				DisableControlAction(0,140,true) 
				DisableControlAction(0,141,true) 
				DisableControlAction(0,142,true)
				DisableControlAction(0,143,true) 
				DisableControlAction(0,24,true)
				DisableControlAction(0,25,true) 
			end
		SetPedCanBeDraggedOut(PlayerPedId(),false)
		Wait(0)
	end
end)

--------------------------------- Unlimited stamina --------------------------------

Citizen.CreateThread( function()
    while true do
       Citizen.Wait(1)
	   RestorePlayerStamina(PlayerId(), 1.0)
	   SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
	   SetPedDropsWeaponsWhenDead(PlayerPedId(), 0)
    end
end)

--------------------------------- No wanted --------------------------------

Citizen.CreateThread(function()
	SetMaxWantedLevel(0)
end)

--------------------------------- No car rewards --------------------------------

Citizen.CreateThread(function()
	while true do
		DisablePlayerVehicleRewards(PlayerId())
		Wait(0)
	end
end)

--------------------------------- Headshot/helmet --------------------------------

CreateThread(function()
    while true do
        Wait(0)
        SetPedConfigFlag(PlayerPedId(), 149, true)
        SetPedConfigFlag(PlayerPedId(), 438, true)
    end
end)

--------------------------------- Nohud --------------------------------

Citizen.CreateThread(function()
    local minimap = RequestScaleformMovie("minimap")
    SetRadarBigmapEnabled(true, false)
    Wait(0)
    SetRadarBigmapEnabled(false, false)
    while true do
        Wait(0)
        BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
        ScaleformMovieMethodAddParamInt(3)
        EndScaleformMovieMethod()
    end
end)

--------------------------------- Hide GTA Hud --------------------------------

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		HideHudComponentThisFrame(3) -- CASH
		HideHudComponentThisFrame(4) -- MP CASH
		HideHudComponentThisFrame(9) -- STREET NAME
		HideHudComponentThisFrame(7) -- Area NAME
		
	end
end)

--------------------------------- Pause Menu --------------------------------

function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

Citizen.CreateThread(function()
	AddTextEntry('FE_THDR_GTAO', 'AQUA - https://dsc.gg/AQUA')
	AddTextEntry("PM_PANE_CFX", "AQUA")
end)

--------------------------------- British Plates --------------------------------

Citizen.CreateThread(function()


    RequestStreamedTextureDict("regplates")
    while not HasStreamedTextureDictLoaded("regplates") do
        Citizen.Wait(1)
    end

    AddReplaceTexture("vehshare", "plate01", "regplates", "plate01")
    AddReplaceTexture("vehshare", "plate01_n", "regplates", "plate01_n")
    AddReplaceTexture("vehshare", "plate02", "regplates", "plate02")
    AddReplaceTexture("vehshare", "plate02_n", "regplates", "plate02_n")
    AddReplaceTexture("vehshare", "plate03", "regplates", "plate03")
    AddReplaceTexture("vehshare", "plate03_n", "regplates", "plate03_n")
    AddReplaceTexture("vehshare", "plate04", "regplates", "plate04")
    AddReplaceTexture("vehshare", "plate04_n","regplates", "plate04_n")
    AddReplaceTexture("vehshare", "plate05", "regplates", "plate05")
    AddReplaceTexture("vehshare", "plate05_n", "regplates", "plate05_n")
end)

--------------------------------- Tazer Effect --------------------------------

local civped = nil
Citizen.CreateThread(function()
	while true do
        if IsPedBeingStunned(GetPlayerPed(-1)) then
            civped = PlayerPedId()
            stunGun()
        end
        Wait(100)
    end
end)

function stunGun()
    local playerPed = GetPlayerPed(-1)
    RequestAnimSet("move_m@drunk@verydrunk")
    while not HasAnimSetLoaded("move_m@drunk@verydrunk") do
      Citizen.Wait(0)
    end
    SetPedMinGroundTimeForStungun(GetPlayerPed(-1), 15000)
    SetPedMovementClipset(playerPed, "move_m@drunk@verydrunk", true)
    SetTimecycleModifier("spectator5")
    SetPedIsDrunk(playerPed, true)
    Wait(15000)
    SetPedMotionBlur(playerPed, true)
    Wait(20000)
    ClearTimecycleModifier()
    ResetScenarioTypesEnabled()
    ResetPedMovementClipset(playerPed, 0)
    SetPedIsDrunk(playerPed, false)
    SetPedMotionBlur(playerPed, false)
end

