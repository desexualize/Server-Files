local a = true
local b = false
function func_snowballs()
    while true do
        Wait(0)
        if IsNextWeatherType("XMAS") then
            WaterOverrideSetStrength(3.0)
            SetForceVehicleTrails(true)
            SetForcePedFootstepsTracks(true)
            if not b then
                RequestNamedPtfxAsset("core_snow")
                while not HasNamedPtfxAssetLoaded("core_snow") do
                    Citizen.Wait(0)
                end
                UseParticleFxAsset("core_snow")
                b = true
            end
            if IsControlJustReleased(0, 119) and not IsPedInAnyVehicle(GetPlayerPed(-1), true) and not IsPlayerFreeAiming(PlayerId()) and not IsPedSwimming(PlayerPedId()) and not IsPedSwimmingUnderWater(PlayerPedId()) and not IsPedRagdoll(PlayerPedId()) and not IsPedFalling(PlayerPedId()) and not IsPedRunning(PlayerPedId()) and not IsPedSprinting(PlayerPedId()) and GetInteriorFromEntity(PlayerPedId()) == 0 and not IsPedShooting(PlayerPedId()) and not IsPedUsingAnyScenario(PlayerPedId()) and not IsPedInCover(PlayerPedId(), 0) then
                tARMA.loadAnimDict("anim@mp_snowball")
                TaskPlayAnim(PlayerPedId(), "anim@mp_snowball", "pickup_snowball", 8.0, -1, -1, 0, 1, 0, 0, 0)
                RemoveAnimDict("anim@mp_snowball")
                Citizen.Wait(1950)
		        tARMA.allowWeapon("WEAPON_SNOWBALL")
                GiveWeaponToPed(PlayerPedId(), "WEAPON_SNOWBALL", 2)
            end
            if not IsPedInAnyVehicle(GetPlayerPed(-1), true) then
                if a then
                    showHelpNotification()
                end
                a = false
            else
                a = true
            end
        elseif b then
            WaterOverrideSetStrength(0.0)
            b = false
            RemoveNamedPtfxAsset("core_snow")
            SetForceVehicleTrails(false)
            SetForcePedFootstepsTracks(false)
        end
    end
end
Citizen.CreateThread(func_snowballs)
function showHelpNotification()
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName("Press ~INPUT_VEH_FLY_VERTICAL_FLIGHT_MODE~ while on foot, to pickup 2 snowballs!")
    EndTextCommandDisplayHelp(0, 0, 1, -1)
end
RegisterCommand("snowballs",function()
    showHelpNotification()
end)
