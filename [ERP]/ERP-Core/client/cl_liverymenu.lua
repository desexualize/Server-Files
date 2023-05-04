RMenu.Add('LiveryMenu', 'main', RageUI.CreateMenu("", "~w~ERP Livery Menu", 1300, 100, "livery", "livery"))
RMenu.Add('LiveryMenu', 'submain', RageUI.CreateSubMenu(RMenu:Get('LiveryMenu', 'main'), "", "~w~ERP Livery Menu", 1300, 100, "livery", "livery"))

RageUI.CreateWhile(1.0, RMenu:Get('LiveryMenu', 'main'), nil, function()
    RageUI.IsVisible(RMenu:Get('LiveryMenu', 'main'), true, false, true, function()

        RageUI.Button("Livery Options" , nil, {RightLabel = "→→→",}, true, function(Hovered, Active, Selected)
        end, RMenu:Get('LiveryMenu', 'submain'))
       end, function()
    end)
    LiveryOptions() 

end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if IsControlPressed(0, 121, true) and IsPedInAnyVehicle(GetPlayerPed(-1), false) then

            RageUI.Visible(RMenu:Get("LiveryMenu", "main"), true)

        end
    end
end)

function LiveryOptions() 
    RageUI.IsVisible(RMenu:Get('LiveryMenu', 'submain'), true, false, true, function()

        print(tostring(GetVehicleLiveryCount(Vehicle)))
        local Vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)

        for LiveryCount = 1, GetVehicleLiveryCount(Vehicle) do
  
            RageUI.Button("Livery #" .. tostring(LiveryCount) , nil, {RightLabel = "→→→",}, true, function(Hovered, Active, Selected)
                if Selected then
                    SetVehicleLivery(Vehicle, LiveryCount)        
                end
            end)
        end
        end, function()
    end)
end

function notify(string)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(string)
    DrawNotification(true, false)
end
