Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if IsControlJustPressed(1, 288) then
            if IsUsingKeyboard(2) then
                SetNuiFocus(true, true)
                SendNUIMessage({type = 'openGuideHud'})
            end
        end
    end
end)

RegisterNUICallback('closeGuideHud', function(data, cb)
	SetNuiFocus(false, false)
end)