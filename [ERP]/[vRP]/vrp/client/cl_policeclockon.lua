RMenu.Add('PoliceDutyMenu', 'main', RageUI.CreateMenu("MET Police", "~b~MET Police Clockon Menu", 1250,100))

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('PoliceDutyMenu', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()

            RageUI.Button("~b~Commissioner" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('PoliceMenu:ClockOn', "Commissioner Clocked")
                end
            end)
            
            RageUI.Button("~b~Deputy Commissioner" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('PoliceMenu:ClockOn', "Deputy Commissioner Clocked")
                end
            end)

            RageUI.Button("~b~Assistant Commissioner" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('PoliceMenu:ClockOn', "Assistant Commissioner Clocked")
                end
            end)

            RageUI.Button("~b~Deputy Assistant Commissioner" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('PoliceMenu:ClockOn', "Deputy Assistant Commissioner Clocked")
                end
            end)

            RageUI.Button("~b~Commander" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('PoliceMenu:ClockOn', "Commander Clocked")
                end
            end)

            RageUI.Button("~b~Chief Superintendent" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('PoliceMenu:ClockOn', "Chief Superintendent Clocked")
                end
            end)

            RageUI.Button("~b~Superintendent" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('PoliceMenu:ClockOn', "Superintendent Clocked")
                end
            end)

            RageUI.Button("~b~Chief Inspector" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('PoliceMenu:ClockOn', "Chief Inspector Clocked")
                end
            end)

            RageUI.Button("~b~Inspector" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('PoliceMenu:ClockOn', "Inspector Clocked")
                end
            end)

            RageUI.Button("~b~Sergeant" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('PoliceMenu:ClockOn', "Sergeant Clocked")
                end
            end)

            RageUI.Button("~b~Special Police Constable" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('PoliceMenu:ClockOn', "Special Police Constable Clocked")
                end
            end)

            RageUI.Button("~b~Senior Police Constable" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('PoliceMenu:ClockOn', "Senior Police Constable Clocked")
                end
            end)

            RageUI.Button("~b~Police Constable" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('PoliceMenu:ClockOn', "Police Constable Clocked")
                end
            end)

            RageUI.Button("~b~Police Community Support Officer" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('PoliceMenu:ClockOn', "PCSO Clocked")
                end
            end)

            RageUI.Button("~r~Clock Off" , nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('PoliceMenu:ClockOff')
                    --[[ PD Armoury Weapons ]]--
                    RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_FLASHLIGHT"))
                    RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_GLOCK"))
                    RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_NIGHTSTICK"))
                    RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_REMINGTON870"))
                    RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_STUNGUN"))

                end
            end)

            
        end) 
    end
end)

isInPoliceDutyMenu = false
currentPoliceDutyMenu = nil
Citizen.CreateThread(function() 
    while true do
            local x,y,z = 440.53280639648,-980.49194335938,30.723756790161 
            local dutymenu = vector3(x,y,z)

            if isInArea(dutymenu, 100.0) then 
                DrawMarker(27, vector3(x,y,z-0.9), 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 0, 140, 255, 150, 0, 0, 0, 0, 0, 0, 0)
            end
 
            if isInPoliceDutyMenu == false then
            if isInArea(dutymenu, 1.4) then 
                alert('Press ~INPUT_VEH_HORN~ to open Police Clockon Menu')
                if IsControlJustPressed(0, 51) then 
                    currentPoliceDutyMenu = k
                    TriggerServerEvent('PoliceMenu:CheckPermissions')
                    isInPoliceDutyMenu = true
                    currentPoliceDutyMenu = k 
                end
            end
            end
            if isInArea(dutymenu, 1.4) == false and isInPoliceDutyMenu and k == currentPoliceDutyMenu then
                RageUI.ActuallyCloseAll()
                RageUI.Visible(RMenu:Get("PoliceDutyMenu", "main"), false)
                isInPoliceDutyMenu = false
                currentPoliceDutyMenu = nil
            end
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('PoliceDuty:Allowed')
AddEventHandler('PoliceDuty:Allowed', function(allowed)
    if allowed then
        RageUI.Visible(RMenu:Get("PoliceDutyMenu", "main"),true)
    elseif not allowed then
        RageUI.ActuallyCloseAll()
        RageUI.Visible(RMenu:Get("PoliceDutyMenu", "main"), false)
        notify("You are not a part of the MET Police")
    end
end)

function isInArea(v, dis) 
    
    if #(GetEntityCoords(PlayerPedId(-1)) - v) <= dis then  
        return true
    else 
        return false
    end
end

function alert(msg) 
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0,0,1,-1)
end