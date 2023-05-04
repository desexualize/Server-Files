local usingspeedgun = false
local MinimumSpeed = 100
local globalisonpoliceduty = true
local vehicleplate = "N/A"
local VehicleModel = "N/A"
local lastentityvehicle = "N/A"
local entityspeed = 0.0

Citizen.CreateThread(function()
    while true do

        if usingspeedgun and not GetSelectedPedWeapon(PlayerPedId()) ~= GetHashKey("WEAPON_PISTOL50") then

            DisablePlayerFiring(PlayerId(), true)
            DrawRect(0.5, 0.91, 0.13, 0.125, 0, 0, 0, 128)
            DrawAdvancedText(0.5, 0.68, 0.1, 0.2, 0.55,"Vehicle Plate: " .. vehicleplate, 255, 255, 255, 255, 4, 0)
            DrawAdvancedText(0.5, 0.735, 0.1, 0.2, 0.55, "Vehicle Speed: " .. entityspeed .. " MPH", 255, 255, 255, 255, 4, 0)

        end
        Wait(1)

    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(1)
        if globalisonpoliceduty then
            if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey("WEAPON_SPEEDGUN") then
                usingspeedgun = true
            else
                usingspeedgun = false
            end

            if usingspeedgun then
                if IsPlayerFreeAiming(PlayerId()) then
                    
                    local q, aimeentity = GetEntityPlayerIsFreeAimingAt(PlayerId(-1))
                    local getaimeentity = GetVehiclePedIsIn(aimeentity, false)
                    if getaimeentity ~= 0 then
                        vehicleplate = GetVehicleNumberPlateText(getaimeentity) or "N/A"
                        VehicleModel = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(getaimeentity))) or "N/A"
                        entityspeed = math.round(GetEntitySpeed(getaimeentity)* 2.236936, 1) - 5

                        if entityspeed > 100 and lastentityvehicle ~= vehicleplate then

                            TriggerServerEvent("AQUA:speedGunFinePlayer", GetPlayerServerId(NetworkGetPlayerIndexFromPed(aimeentity)), entityspeed)
                            PlaySoundFrontend(-1, "ScreenFlash", "MissionFailedSounds", 1)
                            StartScreenEffect("FocusOut", 0, false)
                            Wait(2000)
                            StopScreenEffect("FocusOut")

                            lastentityvehicle = vehicleplate

                        else 
                            if lastentityvehicle == vehicleplate then

                                Notify("~d~This player was fined to recently!")

                            end
                        end

                    end


                end
            end

        end

    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(1)
        if lastentityvehicle == vehicleplate then
            Wait(300000)
            lastentityvehicle = "N/A"
        end
    end
end)

function DrawAdvancedText(i,j,k,l,m,n,o,p,q,r,s,t)
    SetTextFont(s)
    SetTextProportional(0)
    SetTextScale(m,m)
    N_0x4e096588b13ffeca(t)
    SetTextColour(o,p,q,r)
    SetTextDropShadow(0,0,0,0,255)
    SetTextEdge(1,0,0,0,255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(n)
    DrawText(i-0.1+k,j-0.02+l)
end

RegisterNetEvent('AQUA:speedGunPlayerFined')
AddEventHandler('AQUA:speedGunPlayerFined', function()
    PlaySoundFrontend(-1, "ScreenFlash", "MissionFailedSounds", 1)
    StartScreenEffect("FocusOut", 0, false)
    Wait(2000)
    StopScreenEffect("FocusOut")
end)


Citizen.CreateThread(function()
    while true do
        Wait(1)
        if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey("WEAPON_PISTOL50") then

            DisablePlayerFiring(PlayerId(), true)

        end
    end
end)
