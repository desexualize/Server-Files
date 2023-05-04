RMenu.Add('NHSDutyMenu', 'main', RageUI.CreateMenu("NHS", "~g~NHS Duty Menu", 1250,100))

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('NHSDutyMenu', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()

            RageUI.Button("~g~Head Chief Medical Officer" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    grp_server_callback('NHSMenu:ClockOn', "Head Chief Medical Officer Clocked")
                end
            end)
            
            RageUI.Button("~g~Assistant Chief Medical Officer" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    grp_server_callback('NHSMenu:ClockOn', "Assistant Chief Medical Officer Clocked")
                end
            end)

            RageUI.Button("~g~Deputy Chief Medical Officer" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    grp_server_callback('NHSMenu:ClockOn', "Deputy Chief Medical Officer Clocked")
                end
            end)

            RageUI.Button("~g~Captain" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    grp_server_callback('NHSMenu:ClockOn', "Captain Clocked")
                end
            end)

            RageUI.Button("~g~Consultant" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    grp_server_callback('NHSMenu:ClockOn', "Consultant Clocked")
                end
            end)

            RageUI.Button("~g~Specialist" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    grp_server_callback('NHSMenu:ClockOn', "Specialist Clocked")
                end
            end)

            RageUI.Button("~g~Senior Doctor" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    grp_server_callback('NHSMenu:ClockOn', "Senior Doctor Clocked")
                end
            end)

            RageUI.Button("~g~Junior Doctor" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    grp_server_callback('NHSMenu:ClockOn', "Junior Doctor Clocked")
                end
            end)

            RageUI.Button("~g~Critical Care Paramedic" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    grp_server_callback('NHSMenu:ClockOn', "Critical Care Paramedic Clocked")
                end
            end)

            RageUI.Button("~g~Paramedic" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    grp_server_callback('NHSMenu:ClockOn', "Paramedic Clocked")
                end
            end)

            RageUI.Button("~g~Trainee Paramedic" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    grp_server_callback('NHSMenu:ClockOn', "Trainee Paramedic Clocked")
                end
            end)
            
            RageUI.Button("~r~Clock Off" , nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    grp_server_callback('NHSMenu:ClockOff')
                end
            end)

            
        end) 
    end
end)

isInNHSDutyMenu = false
currentNHSDutyMenu = nil
Citizen.CreateThread(function() 
    while true do
            local x,y,z = 311.38034057617,-594.16644287109,43.284099578857
            local dutymenu = vector3(x,y,z)

            if isInArea(dutymenu, 100.0) then 
                DrawMarker(27, vector3(x,y,z-0.9), 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 0, 200, 0, 150, 0, 0, 0, 0, 0, 0, 0)
            end
 
            if isInNHSDutyMenu == false then
            if isInArea(dutymenu, 1.4) then 
                alert('Press ~INPUT_VEH_HORN~ to open NHS Duty Menu')
                if IsControlJustPressed(0, 51) then 
                    currentNHSDutyMenu = k
                    grp_server_callback('NHSMenu:CheckPermissions')
                    isInNHSDutyMenu = true
                    currentNHSDutyMenu = k 
                end
            end
            end
            if isInArea(dutymenu, 1.4) == false and isInNHSDutyMenu and k == currentNHSDutyMenu then
                RageUI.ActuallyCloseAll()
                RageUI.Visible(RMenu:Get("NHSDutyMenu", "main"), false)
                isInNHSDutyMenu = false
                currentNHSDutyMenu = nil
            end
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('NHSDuty:Allowed')
AddEventHandler('NHSDuty:Allowed', function(allowed)
    if allowed then
        RageUI.Visible(RMenu:Get("NHSDutyMenu", "main"),true)
    elseif not allowed then
        RageUI.ActuallyCloseAll()
        RageUI.Visible(RMenu:Get("NHSDutyMenu", "main"), false)
        notify("~r~You are not a part of the NHS")
    end
end)