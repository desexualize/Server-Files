local bIsOpen = false
local bIsNewPlayer = false

local function drawNativeNotification(text)
    BeginTextCommandDisplayHelp('STRING')
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayHelp(0, 0, 1, -1)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if IsControlJustPressed(1, 288) then
            if IsUsingKeyboard(2) then
                SetNuiFocus(true, true)
                SendNUIMessage({type = 'openGuideHud'})
                bIsOpen = true
            end
        end

        if bIsOpen and bIsNewPlayer then
            drawNativeNotification("Press ~INPUT_REPLAY_START_STOP_RECORDING~ to toggle the Help Menu.")
        end
    end
end)

RegisterNUICallback('closeGuideHud', function(data, cb)
	SetNuiFocus(false, false)
    bIsOpen = false
end)

RegisterNetEvent("ARMA:setIsNewPlayer", function()
	bIsNewPlayer = true
end)

exports("isOpen", function()
    return bIsOpen
end)