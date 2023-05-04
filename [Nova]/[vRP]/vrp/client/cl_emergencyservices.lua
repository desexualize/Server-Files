RMenu.Add("EMS_Menu", "main", RageUI.CreateMenu("Emergency Services", "Call an Emergency Service", 1250, 100))

RegisterCommand('111', function()
    RageUI.Visible(RMenu:Get('EMS_Menu', 'main'), not RageUI.Visible(RMenu:Get('EMS_Menu', 'main')))
end)

RegisterCommand('999', function()
    RageUI.Visible(RMenu:Get('EMS_Menu', 'main'), not RageUI.Visible(RMenu:Get('EMS_Menu', 'main')))
end)

TriggerEvent('chat:addSuggestion', '/111', 'Call an Emergency Service')
TriggerEvent('chat:addSuggestion', '/999', 'Call an Emergency Service')

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('EMS_Menu', 'main')) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
            RageUI.Button('London Fire Brigade', nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('Nova:Server:CreateCall', 'lfb')
                    RageUI.Visible(RMenu:Get('EMS_Menu', 'main'), false)
                end
            end)

            RageUI.Button('National Health Service', nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('Nova:Server:CreateCall', 'nhs')
                    RageUI.Visible(RMenu:Get('EMS_Menu', 'main'), false)
                end
            end)

            RageUI.Button('Metropolitan Police', nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('Nova:Server:CreateCall', 'mpd')
                    RageUI.Visible(RMenu:Get('EMS_Menu', 'main'), false)
                end
            end)
        end)
    end
end)