local a = true
local b = false
local c = false
local d = false
local e = false
local f = nil
local g = 0
local h = false
local i = {
    GetHashKey("WEAPON_PDGLOCK"),
    GetHashKey("WEAPON_STUNGUN"),
    GetHashKey("WEAPON_NIGHTSTICK"),
}
function notify(j)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(j)
    EndTextCommandThefeedPostTicker(true, false)
end
function timeout(k, l)
    if not d then
        Citizen.CreateThread(function()
			d = true
			g = k
			while g > 0 do
				Wait(1000)
				notify(l)
				g = g - 1000
				b = true
				a = true
				f = nil
			end
			notify("~g~Your timeout has finished, do not try to do that again")
			b = false
			d = false
		end)
    end
end
Citizen.CreateThread(function()
	while true do
		local m = tARMA.getPlayerPed()
		if GetVehiclePedIsTryingToEnter(m) ~= 0 or d then
			tARMA.setWeapon(m, "WEAPON_UNARMED", true)
		end
		if b then
			DisablePlayerFiring(m, true)
		end
		if c then
			if IsControlJustPressed(0, 73) then
				local k = 3500
				c = false
				if not (g > k) then
					g = k
				end
				timeout(k,string.format("~r~Do not press X to cancel the animation! Your weapons have been holstered for %ss",k / 1000))
			end
		end
		if GetIsTaskActive(m, 2) then
			tARMA.setWeapon(m, "WEAPON_UNARMED", true)
			HudWeaponWheelIgnoreSelection()
			HudWeaponWheelIgnoreControlInput(true)
		else
			HudWeaponWheelIgnoreControlInput(false)
		end
		Wait(0)
	end
end)
Citizen.CreateThread(function()
	while true do
		local n = tARMA.getPlayerPed()
		if not globalIsInModShop then
			if not IsPedInAnyVehicle(n, true) then
				if GetIsTaskActive(n, 50) then
					while GetIsTaskActive(n, 50) do
						Wait(0)
					end
					Wait(500)
				end
				if GetIsTaskActive(n, 1) then
					while GetIsTaskActive(n, 1) do
						Wait(0)
					end
					Wait(500)
				end
				if GetIsTaskActive(n, 56) or IsPedInCover(n, 1) and IsControlJustPressed(0, 37) then
					local o = GetSelectedPedWeapon(n)
					if o ~= GetHashKey("WEAPON_UNARMED") then
						if table.has(i, o) then
							h = true
							loadAnimDict("rcmjosh4")
							loadAnimDict("reaction@intimidation@cop@unarmed")
							c = true
							SetPedCurrentWeaponVisible(n, 0, 1, 1, 1)
							TaskPlayAnim(n,"reaction@intimidation@cop@unarmed","intro",8.0,2.0,-1,50,2.0,0,0,0)
							RemoveAnimDict("reaction@intimidation@cop@unarmed")
							SetPedCurrentWeaponVisible(n, 1, 1, 1, 1)
							Citizen.Wait(250)
							TaskPlayAnim(n, "rcmjosh4", "josh_leadout_cop2", 8.0, 2.0, -1, 48, 10, 0, 0, 0)
							RemoveAnimDict("rcmjosh4")
							Citizen.Wait(400)
							ClearPedTasks(n)
							local p = GetSelectedPedWeapon(n)
							if p ~= GetHashKey("WEAPON_UNARMED") and not table.has(i, p) then
								timeout(3500,"~r~Do not change weapons to equip quicker! Your weapons have been holstered for 3.5s")
							else
								a = false
								if o == "WEAPON_PDGLOCK" and GetPedDrawableVariation(n, 7) == 187 then
									tARMA.loadCustomisationPreset("TaserInHolster")
								end
								if not d then
									a = false
									b = false
									c = false
									f = o
								end
							end
						else
							c = true
							loadAnimDict("reaction@intimidation@1h")
							TaskPlayAnim(n, "reaction@intimidation@1h", "intro", 8.0, 2.0, 1700, 48, 10, 0, 0, 0)
							RemoveAnimDict("reaction@intimidation@1h")
							SetPedCurrentWeaponVisible(n, 0, 1, 1, 1)
							b = true
							Citizen.Wait(1300)
							SetPedCurrentWeaponVisible(n, 1, 1, 1, 1)
							Citizen.Wait(700)
							ClearPedTasks(n)
							EnableControlAction(0, 25, true)
							if not d then
								a = false
								b = false
								c = false
								f = GetSelectedPedWeapon(n)
							end
						end
					else
						if table.has(i, f) then
							loadAnimDict("rcmjosh4")
							loadAnimDict("reaction@intimidation@cop@unarmed")
							TaskPlayAnim(n, "rcmjosh4", "josh_leadout_cop2", 8.0, 2.0, -1, 48, 10, 0, 0, 0)
							RemoveAnimDict("rcmjosh4")
							Citizen.Wait(500)
							TaskPlayAnim(n,"reaction@intimidation@cop@unarmed","outro",8.0,2.0,-1,50,2.0,0,0,0)
							RemoveAnimDict("reaction@intimidation@cop@unarmed")
							Citizen.Wait(60)
							ClearPedTasks(n)
							local p = GetSelectedPedWeapon(n)
							if p ~= GetHashKey("WEAPON_UNARMED") and not table.has(i, p) then
								timeout(3500,"~r~Do not change weapons to equip quicker! Your weapons have been holstered for 3.5s")
							else
								a = true
								if h and GetPedDrawableVariation(n, 7) == 161 then
									tARMA.loadCustomisationPreset("TaserOutHolster")
								end
							end
						else
							loadAnimDict("reaction@intimidation@1h")
							TaskPlayAnim(n, "reaction@intimidation@1h", "outro", 8.0, 2.0, 1700, 48, 10, 0, 0, 0)
							RemoveAnimDict("reaction@intimidation@1h")
							b = true
							tARMA.setWeapon(n, GetHashKey(f), true)
							Citizen.Wait(1300)
							tARMA.setWeapon(n, "WEAPON_UNARMED", true)
							Citizen.Wait(700)
							ClearPedTasks(n)
							a = true
							b = false
							f = nil
						end
						h = false
					end
				end
			end
		end
		Wait(0)
	end
end)
function loadAnimDict(q)
    while not HasAnimDictLoaded(q) do
        RequestAnimDict(q)
        Wait(0)
    end
end
function tARMA.setWeapon(m, s, t)
    SetCurrentPedWeapon(m, s, t)
end
