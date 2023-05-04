RegisterNUICallback('closeGuideHud', function(data, cb)
	SetNuiFocus(false, false)
end)

RegisterKeyMapping('togglerules', 'Toggle game rules', 'keyboard', 'f1')
RegisterCommand('togglerules', function()
    if IsUsingKeyboard(2) then
        SetNuiFocus(true, true)
        SendNUIMessage({type = 'openGuideHud'})
    end
end)