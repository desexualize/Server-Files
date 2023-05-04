local aJ = false
RegisterNetEvent("FNR:adminTicketFeedback",function(aK)
        local aL, aM = tvRP.getPlayerVehicle()
        print("Triggered")
        if aL ~= 0 and aM and GetEntitySpeed(aL) > 25.0 then
            return
        end
        if aJ then
            return
        end
        aJ = true
        RequestStreamedTextureDict("ticket_response", false)
        while not HasStreamedTextureDictLoaded("ticket_response") do
            Citizen.Wait(0)
        end
        setCursor(1)
        TriggerScreenblurFadeIn(500.0)
        ExecuteCommand("hideui")
        local aN = nil
        while not aN do
            DisableControlAction(0, 202, true)
            drawNativeNotification("Press ~INPUT_FRONTEND_CANCEL~ to stop providing feedback")
            for a2 = 0, 6 do
                DisableControlAction(0, a2, true)
            end
            DrawSprite("ticket_response", "faces", 0.5, 0.575, 0.39, 0.28275, 0.0, 255, 255, 255, 255)
            DrawAdvancedText(
                0.58,
                0.4,
                0.01,
                0.01,
                0.65,
                "How would you rate your experience with the admin?",
                255,
                255,
                255,
                255,
                0,
                0
            )
            if CursorInArea(0.304, 0.411, 0.483, 0.669) and IsControlJustPressed(0, 237) then
                aN = "good"
            end
            if CursorInArea(0.446, 0.552, 0.483, 0.669) and IsControlJustPressed(0, 237) then
                aN = "neutral"
            end
            if CursorInArea(0.588, 0.693, 0.483, 0.669) and IsControlJustPressed(0, 237) then
                aN = "bad"
            end
            if IsDisabledControlJustPressed(0, 202) then
                break
            end
            Citizen.Wait(0)
        end
        setCursor(0)
        SetStreamedTextureDictAsNoLongerNeeded("ticket_response")
        if aN then
            local aO = false
            tvRP.clientPrompt(
                "Attached Message",
                "",
                function(aP)
                    TriggerServerEvent("FNR:adminTicketFeedback", aK, aN, aP)
                    aO = true
                end
            )
            while not aO do
                for a2 = 0, 6 do
                    DisableControlAction(0, a2, true)
                end
                drawNativeNotification("Press ~INPUT_FRONTEND_RUP~ to submit the " .. aN .. " feedback")
                DrawAdvancedText(
                    0.58,
                    0.4,
                    0.01,
                    0.01,
                    0.65,
                    "Would you like to provide any additional feedback?",
                    255,
                    255,
                    255,
                    255,
                    0,
                    0
                )
                Citizen.Wait(0)
            end
        else
            TriggerServerEvent("FNR:adminTicketNoFeedback", aK)
        end
        ExecuteCommand("showui")
        TriggerScreenblurFadeOut(500.0)
        aJ = false
    end
)