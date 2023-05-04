RMenu.Add('LiveryMenu', 'main', RageUI.CreateMenu("Livery Menu", "Livery Menu", 1300, 50))

RageUI.CreateWhile(1.0, RMenu:Get("LiveryMenu", "main"), nil, function()
    RageUI.IsVisible(RMenu:Get("LiveryMenu", "main"), true, false, true, function()
        for LiveryCount = 1, GetVehicleLiveryCount(GetVehiclePedIsIn(GetPlayerPed(-1), false)) do
            RageUI.Button("Livery " .. tostring(LiveryCount) , nil, {RightLabel = "→→→",}, true, function(Hovered, Active, Selected)
                if Selected then
                    SetVehicleLivery(GetVehiclePedIsIn(GetPlayerPed(-1), false), LiveryCount)   
                end
            end)
        end
        end, function()
    end)
end)

RegisterCommand("livery", function()
    if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
        RageUI.Visible(RMenu:Get("LiveryMenu", "main"), true)
    end
end)

RegisterKeyMapping("livery", "Opens Livery Menu", "keyboard", "insert")