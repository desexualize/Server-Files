local a = false
Citizen.CreateThread(
    function()
        SetPedConfigFlag(PlayerPedId(), 149, true)
        SetPedConfigFlag(PlayerPedId(), 438, true)
        SetPedResetFlag(PlayerPedId(), 337, true)
        local z = RequestScaleformMovie("minimap")
        SetRadarBigmapEnabled(true, false)
        Wait(0)
        SetRadarBigmapEnabled(false, false)
        while true do
            Citizen.Wait(0)
            HideHudComponentThisFrame(3)
            HideHudComponentThisFrame(4)
            HideHudComponentThisFrame(2)
            HideHudComponentThisFrame(9)
            HideHudComponentThisFrame(7)
            HideHudComponentThisFrame(8)
            HideHudComponentThisFrame(6)
            BeginScaleformMovieMethod(z, "SETUP_HEALTH_ARMOUR")
            ScaleformMovieMethodAddParamInt(3)
            EndScaleformMovieMethod()
        end
    end
)
R = false
Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1)
            if IsControlJustReleased(0, 20) then
                R = not R
                SetRadarBigmapEnabled(R, false)
            end
        end
    end
)

RegisterCommand(
    "hideui",
    function()
        a = true
        TriggerEvent("FNR-Client:UI:Toggle", false)
    end
)
RegisterCommand(
    "showui",
    function()
        a = false
        TriggerEvent("FNR-Client:UI:Toggle", true)
    end
)
RegisterNetEvent("FNR:ToggleHud")
AddEventHandler(
    "FNR:ToggleHud",
    function()
        a = not a
        if not a then
            TriggerEvent("FNR-Client:UI:Toggle", true)
        else
            TriggerEvent("FNR-Client:UI:Toggle", false)
        end
    end
)
Citizen.CreateThread(
    function()
        while true do
            if a then
                HideHudAndRadarThisFrame()
                TriggerEvent("chat:clear")
            end
            Wait(0)
        end
    end
)

function GetMinimapAnchor()
    local a = {}
    local b, c = GetActiveScreenResolution()
    local d = GetAspectRatio()
    local e = 1 / b
    local f = 1 / c
    local g, h
    SetScriptGfxAlign(string.byte("L"), string.byte("B"))
    if IsBigmapActive() then
        g, h = GetScriptGfxPosition(-0.003975, 0.022 + -0.460416666)
        a.width = e * b / (2.52 * d)
        a.height = f * c / 2.3374
    else
        g, h = GetScriptGfxPosition(-0.0045, 0.002 + -0.188888)
        a.width = e * b / (4 * d)
        a.height = f * c / 5.674
    end
    ResetScriptGfxAlign()
    a.resX = b
    a.resY = c
    a.leftX = g
    a.rightX = g + a.width
    a.topY = h
    a.bottomY = h + a.height
    a.X = g + a.width / 2
    a.Y = h + a.height / 2
    a.Width = a.rightX - a.leftX
    return a
end
local i, j = GetActiveScreenResolution()
local k = GetMinimapAnchor()
local l = 10.0
local m = {0, 0, 0, 255}
function tvRP.setMaxUnderWaterUITimenewTime(n)
    l = n
end
local function o(p, q, r, s, t, u, v, w)
    DrawRect(p + r / 2, q + s / 2, r, s, t, u, v, w)
end
function tvRP.getCachedMinimapAnchor()
    return k
end
function tvRP.getCachedResolution()
    return {w = k.resX, h = k.resY}
end
Citizen.CreateThread(
    function()
        while true do
            if not a then
                    local x = tvRP.getPlayerPed()
                    local y, z = GetActiveScreenResolution()
                    if y ~= i or z ~= j then
                        i, j = GetActiveScreenResolution()
                        k = GetMinimapAnchor()
                    end
                    local A = k
                    local B = (GetEntityHealth(x) - 100) / 100.0
                    if B < 0 then
                        B = 0.0
                    end
                    if B == 0.98 then
                        B = 1.0
                    end
                    local C = GetPedArmour(x) / 100.0
                    local D = GetPlayerUnderwaterTimeRemaining(PlayerId()) / l
                    local E = tvRP.getShowHealthPercentageFlag()
                    if C > 1.0 then
                        C = 1.0
                    end
                    o(A.leftX + 0.0045, A.bottomY - 0.004, A.Width, 0.009, 88, 88, 88, 200)
                    o(A.leftX + 0.0045, A.bottomY - 0.004, A.Width * B, 0.009, 86, 215, 64, 200)
                    o(A.leftX + 0.0045, A.bottomY + 0.009, A.Width, 0.009, 88, 88, 88, 200)
                    if IsPedSwimmingUnderWater(x) and D >= 0.0 then
                        o(A.leftX + 0.0045, A.bottomY + 0.009, A.Width * D, 0.009, 243, 214, 102, 200)
                    elseif C > 0.0 then
                        o(A.leftX + 0.0045, A.bottomY + 0.009, A.Width * C, 0.009, 60, 79, 255, 200)
                    end
            end
            Wait(0)
        end
    end
)
