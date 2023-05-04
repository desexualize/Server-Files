local a = false
local b = 0
local function c(d)
    TriggerEvent("chatMessage", "", {0, 0, 0}, d)
end
phones = {[0] = "Michael's", [1] = "Trevor's", [2] = "Franklin's", [4] = "Prologue"}
frontCam = false
function CellFrontCamActivate(e)
    return Citizen.InvokeNative(0x2491A93618B7D838, e)
end
TakePhoto = BeginTakeHighQualityPhoto
WasPhotoTaken = GetStatusOfTakeHighQualityPhoto
SavePhoto = SaveHighQualityPhoto
ClearPhoto = FreeMemoryForHighQualityPhoto
RegisterCommand("selfie",function()
    DisplayHelpText("Backspace to close camera, /selfie again to take a selfie")
    if a == true then
        frontCam = not frontCam
        CellFrontCamActivate(frontCam)
    else
        CreateMobilePhone(b)
        CellCamActivate(true, true)
        a = true
        while a do
            if IsControlJustPressed(0, 177) then
                DestroyMobilePhone()
                a = false
                CellCamActivate(false, false)
                if firstTime == true then
                    firstTime = false
                    Citizen.Wait(2500)
                    displayDoneMission = true
                end
            end
            if IsControlJustPressed(0, 176) then
                TakePhoto()
                if WasPhotoTaken() and SavePhoto(-1) then
                    ClearPhoto()
                end
            end
            HideHudComponentThisFrame(7)
            HideHudComponentThisFrame(8)
            HideHudComponentThisFrame(9)
            HideHudComponentThisFrame(6)
            HideHudComponentThisFrame(19)
            HideHudAndRadarThisFrame()
            Wait(0)
        end
    end
end)
function DisplayHelpText(f)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(f)
    EndTextCommandDisplayHelp(0, 0, 1, -1)
end

Citizen.CreateThread(function()
    DestroyMobilePhone()
end)
