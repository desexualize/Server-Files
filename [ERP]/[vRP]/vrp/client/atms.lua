local cfg = module("cfg/atms")
RMenu.Add('vRPATM', 'main', RageUI.CreateMenu("", "~g~ ATM Menu",1300, 100, "atm", "atm"))
RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('vRPATM', 'main')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            RageUI.Button("Deposit", nil, {}, true, function(Hovered, Active, Selected) 
                if Selected then 
                    AddTextEntry('FMMC_MPM_NC', "Enter Amount to Deposit")
                    DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
                    while (UpdateOnscreenKeyboard() == 0) do
                        DisableAllControlActions(0);
                        Wait(0);
                    end
                    if (GetOnscreenKeyboardResult()) then
                        local result = GetOnscreenKeyboardResult()
                        if result then 
                            result = tonumber(result)
                            TriggerServerEvent('VRP:Deposit', result)
                            PlaySoundFrontend(-1, "Bomb_Disarmed", "GTAO_Speed_Convoy_Soundset", 0)
                        end
                    end
                end
            end)
            RageUI.Button("Withdraw", nil, {}, true, function(Hovered, Active, Selected) 
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
                            result = tonumber(result)
                            TriggerServerEvent('VRP:Withdraw', result)
                            PlaySoundFrontend(-1, "Bomb_Disarmed", "GTAO_Speed_Convoy_Soundset", 0)
                        end
                    end
                end
            end)
            RageUI.Button("Deposit All", nil, {}, true, function(Hovered, Active, Selected) 
                if Selected then 
                    TriggerServerEvent("VRP:DepositAll")
                    PlaySoundFrontend(-1, "Bomb_Disarmed", "GTAO_Speed_Convoy_Soundset", 0)
                end
            end)
            RageUI.Button("Withdraw All", nil, {}, true, function(Hovered, Active, Selected) 
                if Selected then 
                    TriggerServerEvent("VRP:WithdrawAll")
                    PlaySoundFrontend(-1, "Bomb_Disarmed", "GTAO_Speed_Convoy_Soundset", 0)
                end
            end)
        end)
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
            DrawMarker(29, x, y, z, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 0, 255, 17, 150, true, true, 0, 0, 0, 0, 0)
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
            RageUI.Visible(RMenu:Get('vRPATM', 'main'), true) 
        end
        if MenuOpen and not inMarker then 
            MenuOpen = false 
            RageUI.Visible(RMenu:Get('vRPATM', 'main'), false) 
        end
    end
end)
