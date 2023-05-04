local cfg = module("ERP-Core", "cfg/cfg_identitystore")
local inMenu = false

RMenu.Add("ERP:Identity", "main", RageUI.CreateMenu("Identity Shop", "~b~Identity Shop", 1350, 50))

RageUI.CreateWhile(1.0, RMenu:Get("ERP:Identity", "main"), nil, function()
    RageUI.IsVisible(RMenu:Get("ERP:Identity", "main"), true, false, true, function()

        RageUI.Button("Change Identity", nil, {RightLabel = "£"..cfg.price}, true, function(Hovered, Active, Selected)
            if Selected then
                AddTextEntry('FMMC_MPM_NC', "Enter First Name")
                DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
                while (UpdateOnscreenKeyboard() == 0) do
                    DisableAllControlActions(0);
                    Wait(0);
                end
                if (GetOnscreenKeyboardResult()) then
                    local firstName = GetOnscreenKeyboardResult()
                    if firstName ~= "" then 
                        AddTextEntry('FMMC_MPM_NC', "Enter Last Name")
                        DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
                        while (UpdateOnscreenKeyboard() == 0) do
                            DisableAllControlActions(0);
                            Wait(0);
                        end
                        if (GetOnscreenKeyboardResult()) then
                            local secondName = GetOnscreenKeyboardResult()
                            if secondName ~= "" then  
                                AddTextEntry('FMMC_MPM_NC', "Enter Age")
                                DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
                                while (UpdateOnscreenKeyboard() == 0) do
                                    DisableAllControlActions(0);
                                    Wait(0);
                                end
                                if (GetOnscreenKeyboardResult()) then
                                    local age = GetOnscreenKeyboardResult()
                                    if tonumber(age) and tonumber(age) < 100 then 
                                        TriggerServerEvent("ERP:ChangeIdentity", firstName, secondName, tonumber(age))
                                    else
                                        notify("~r~Invalid age!")
                                    end
                                end
                            else
                                notify("~r~Invalid second name!")
                            end
                        end
                    else
                        notify("~r~Invalid first name!")
                    end
                end
            end
        end)

    end, function() 
    end)
end)

Citizen.CreateThread(function()

    local blip = AddBlipForCoord(cfg.location)
    SetBlipSprite(blip, 498)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.6)
    SetBlipColour(blip, 0)
    SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Identity Store")
    EndTextCommandSetBlipName(blip)
    
    while true do
        Citizen.Wait(0)
        if isInArea(cfg.location, 100.0) then
            DrawMarker(20, cfg.location+1 - 0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 255, 0, 60, false, true, 2, true)
        end

        if isInArea(cfg.location, 1.0) and inMenu == false then
            alert('Press ~INPUT_VEH_HORN~ to Change your Identity.')
            if IsControlJustPressed(0, 51) then 
            RageUI.Visible(RMenu:Get("ERP:Identity", "main"), true)
            inMenu = true
            end
        end

        if isInArea(cfg.location, 1.0) == false and inMenu then
            inMenu = false
            RageUI.Visible(RMenu:Get("ERP:Identity", "main"), false)
        end
    end
end)

function isInArea(v, dis) 
    if #(GetEntityCoords(PlayerPedId()) - v) <= dis then  
        return true
    else 
        return false
    end
end

function notify(string)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(string)
    DrawNotification(true, false)
end