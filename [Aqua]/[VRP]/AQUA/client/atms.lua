local cfg = module("cfg/atms")
local ATMActive = false;
RMenu.Add('AQUAATM', 'main', RageUI.CreateMenu("", "~g~ATM",GetRageUIMenuWidth(),GetRageUIMenuHeight(), "banners", "ATM"))
RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('AQUAATM', 'main')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            RageUI.ButtonWithStyle("Deposit", "", {}, true, function(Hovered, Active, Selected) 
                if Selected then 
                    local ped = GetPlayerPed(-1)
                    AddTextEntry('FMMC_MPM_NC', "Enter Amount to Deposit")
                    DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
                    while (UpdateOnscreenKeyboard() == 0) do
                        DisableAllControlActions(0);
                        Wait(0);
                    end
                    if (GetOnscreenKeyboardResult()) then
                        local result = GetOnscreenKeyboardResult()
                        if result then
                            ATMActive = true 
                            result = tonumber(result)
                            TriggerServerEvent('AQUA:Deposit', result)
                            Wait(3000)
                            ATMActive = false
                        end
                    end
                end
            end)
            RageUI.ButtonWithStyle("Withdraw", "", {}, true, function(Hovered, Active, Selected) 
                local ped = GetPlayerPed(-1)
                if Selected then 
                    AddTextEntry('FMMC_MPM_NC', "Enter Amount to Withdraw")
                    DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
                    while (UpdateOnscreenKeyboard() == 0) do
                        DisableAllControlActions(0);
                        Wait(0);
                    end
                    if (GetOnscreenKeyboardResult()) then
                        local result = GetOnscreenKeyboardResult()
                        if result then
                            ATMActive = true 
                            result = tonumber(result)
                            TriggerServerEvent('AQUA:Withdraw', result)
                            Wait(3000)
                            ATMActive = false
                        end
                    end
                end
            end)
            RageUI.ButtonWithStyle("Withdraw All", "", {}, true, function(Hovered, Active, Selected) 
                local ped = GetPlayerPed(-1)
                if Selected then
                    TriggerServerEvent('AQUA:WithdrawAll')
                end
            end)
            RageUI.ButtonWithStyle("Deposit All", "", {}, true, function(Hovered, Active, Selected) 
                local ped = GetPlayerPed(-1)
                if Selected then
                    TriggerServerEvent('AQUA:DepositALL')
                end
            end)
            
        end)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if ATMActive then
            DisableAllControlActions(0)
        end
    end
end)


Citizen.CreateThread(function()
    for i,v in pairs(cfg.atms) do 
        local x,y,z = v[1], v[2], v[3]
        local Blip = AddBlipForCoord(x, y, z)
        SetBlipSprite(Blip, 272)
        SetBlipDisplay(Blip, 4)
        SetBlipScale(Blip, 0.9)
        SetBlipColour(Blip, 2)
        SetBlipAsShortRange(Blip, true)
        AddTextEntry("MAPBLIP", 'ATMs')
        BeginTextCommandSetBlipName("MAPBLIP")
        EndTextCommandSetBlipName(Blip)
        SetBlipCategory(Blip, 1)
    end
end)


Citizen.CreateThread(function()
    while true do 
        Wait(0)
        for i,v in pairs(cfg.atms) do 
            local x,y,z = v[1], v[2], v[3]
            DrawMarker(29, x, y, z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.6, 0.6, 0.6, 00, 255, 00, 50, true, false, 2, true, nil, nil, false)
        end 
    end
end)

local MenuOpen = false;
local inMarker = false;
Citizen.CreateThread(function()
    while true do 
        Wait(250)
        inMarker = false
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        for i,v in pairs(cfg.atms) do 
            local x,y,z = v[1], v[2], v[3]
            if #(coords - vec3(x,y,z)) <= 1.0 then
                inMarker = true 
                break
            end    
        end
        if not MenuOpen and inMarker then 
            MenuOpen = true 
            RageUI.Visible(RMenu:Get('AQUAATM', 'main'), true) 
        end
        if MenuOpen and not inMarker then 
            MenuOpen = false 
            RageUI.Visible(RMenu:Get('AQUAATM', 'main'), false) 
        end
    end
end)