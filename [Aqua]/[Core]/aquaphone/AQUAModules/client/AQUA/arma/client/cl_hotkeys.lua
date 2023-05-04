function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		if IsControlPressed(1, 19) and IsControlJustPressed(1, 90) then
			local b = GetClosestPlayer(3)
			if b then
				targetSrc = GetPlayerServerId(b)
				if targetSrc > 0 then
					TriggerServerEvent("ARMA:dragPlayer", targetSrc)
				end
			end
			Wait(1000)
		end
	    if IsControlPressed(1, 19) and IsDisabledControlJustPressed(1,185) then -- LEFTALT + F
			TriggerServerEvent('ARMA:ejectFromVehicle')
            Wait(1000)
		end
		if IsControlPressed(1, 19) and IsControlJustPressed(1, 58) and IsPedArmed(tARMA.getPlayerPed(), 7) and not tARMA.isPurge() then
			local c = GetSelectedPedWeapon(tARMA.getPlayerPed())
			if c ~= GetHashKey("WEAPON_UNARMED") then
				local d = GetWeapontypeGroup(c)
				if d ~= GetHashKey("GROUP_UNARMED") and d ~= GetHashKey("GROUP_MELEE") and d ~= GetHashKey("GROUP_THROWN") then
					if not inOrganHeist then
						TriggerServerEvent("ARMA:Knockout")
					end
				end
			end
			Wait(1000)
		end
		if IsControlPressed(1, 19) and IsControlJustPressed(1,74) and (tARMA.isDev()) then -- LEFTALT + H
			Wait(1000)
			local e = "melee@unarmed@streamed_variations"
			local f = "plyr_takedown_front_headbutt"
			local g = tARMA.getPlayerPed()
			if DoesEntityExist(g) and not IsEntityDead(g) then
				loadAnimDict(e)
				if IsEntityPlayingAnim(g, e, f, 3) then
					TaskPlayAnim(g, e, "exit", 3.0, 1.0, -1, 0, 0, 0, 0, 0)
					ClearPedSecondaryTask(g)
				else
					TaskPlayAnim(g, e, f, 3.0, 1.0, -1, 0, 0, 0, 0, 0)
				end
				RemoveAnimDict(e)
			end
			TriggerServerEvent("ARMA:KnockoutNoAnim")
			Wait(1000)
		end
		if IsControlPressed(1, 19) and IsControlJustPressed(1,32) then 
			if not IsPauseMenuActive() and not IsPedInAnyVehicle(tARMA.getPlayerPed(), true) and not IsPedSwimming(tARMA.getPlayerPed()) and not IsPedSwimmingUnderWater(tARMA.getPlayerPed()) and not IsPedShooting(tARMA.getPlayerPed()) and not IsPedDiving(tARMA.getPlayerPed()) and not IsPedFalling(tARMA.getPlayerPed()) and GetEntityHealth(tARMA.getPlayerPed()) > 105 and not tARMA.isHandcuffed() and not tARMA.isInRadioChannel() then
				tARMA.playAnim(true,{{"rcmnigel1c","hailing_whistle_waive_a"}},false)
			end 
		end
		if IsControlPressed(1, 19) and IsControlJustPressed(1,29) then -- LEFTALT + B
			if not IsPedInAnyVehicle(tARMA.getPlayerPed(),false) then
				local closestPlayer = tARMA.GetClosestPlayer(4)
				local doesTargetHaveHandsUp = IsEntityPlayingAnim(GetPlayerPed(closestPlayer), 'missminuteman_1ig_2', 'handsup_enter', 3)
				if doesTargetHaveHandsUp then
					TriggerServerEvent("ARMA:requestPlaceBagOnHead") -- need to do inventory checks and shit
				else
					drawNativeNotification("Player must have his hands up!")
				end
			end
		end
	end
end)