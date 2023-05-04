RMenu.Add("LiveryMenu", "main", RageUI.CreateMenu("", "~b~Livery Menu", tARMA.getRageUIMenuWidth(), tARMA.getRageUIMenuHeight(), "banners", "livery")) 

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('LiveryMenu', 'main')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            for LiveryCount = 1, GetVehicleLiveryCount(GetVehiclePedIsIn(GetPlayerPed(-1), false)) do
                RageUI.Button("Livery " .. tostring(LiveryCount) , nil, {RightLabel = "→→→",}, true, function(Hovered, Active, Selected)
                    if Selected then
                        SetVehicleLivery(GetVehiclePedIsIn(GetPlayerPed(-1), false), LiveryCount)   
                    end
                end)
            end
        end) 
    end
end)

RegisterCommand("liverymenu", function()
    if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
        RageUI.Visible(RMenu:Get("LiveryMenu", "main"), true)
    end
end)

RegisterKeyMapping("liverymenu", "Opens Livery Menu", "keyboard", "insert")