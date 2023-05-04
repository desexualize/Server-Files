Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		      local ped = PlayerPedId()
          SetMaxWantedLevel(0)
          DisablePlayerVehicleRewards(PlayerId())
          SetPedDropsWeaponsWhenDead(GetPlayerPed(-1), 0)
          RemoveAllPickupsOfType(0xDF711959) -- carbine rifle
          RemoveAllPickupsOfType(0xF9AFB48F) -- pistol
          RemoveAllPickupsOfType(0xA9355DCD) -- pumpshotgun
          for i = 1, 12 do
            EnableDispatchService(i, false)
          end
          SetPlayerWantedLevel(PlayerId(), 0, false)
          SetPlayerWantedLevelNow(PlayerId(), false)
          SetPlayerWantedLevelNoDrop(PlayerId(), 0, false)
          if IsPedArmed(ped, 6) then
	    	    DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
        end
		if handsup then
			DisableControlAction(2, 37, true)
			DisableControlAction(0,24,true) -- disable attack
			DisableControlAction(0,25,true) -- disable aim
			DisableControlAction(0,47,true) -- disable weapon
			DisableControlAction(0,58,true) -- disable weapon
			DisablePlayerFiring(GetPlayerPed(-1),true)
		end
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
    end
end)

Citizen.CreateThread( function()
	while true do
	   Citizen.Wait(0)
	   RestorePlayerStamina(PlayerId(), 1.0)
	   end
   end)