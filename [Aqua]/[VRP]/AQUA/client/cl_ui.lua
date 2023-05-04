local function a()
    local b = GetSafeZoneSize()
    local c = 1.0 / 20.0
    local d = 1.0 / 20.0
    local e = GetAspectRatio(0)
    if e > 2 then
        e = 16 / 9
    end
    local f, g = GetActiveScreenResolution()
    local h = 1.0 / f
    local i = 1.0 / g
    local j = {}
    j.Width = h * f / (4 * e)
    j.height = i * g / 5.674
    j.Left_x = h * f * c * math.abs(b - 1.0) * 10
    if GetAspectRatio(0) > 2 then
        j.Left_x = j.Left_x + j.Width * 0.845
        j.Width = j.Width * 0.76
    elseif GetAspectRatio(0) > 1.8 then
        j.Left_x = j.Left_x + j.Width * 0.2225
        j.Width = j.Width * 0.995
    end
    j.Bottom_y = 1.0 - i * g * d * math.abs(b - 1.0) * 10
    j.right_x = j.Left_x + j.Width
    j.top_y = j.Bottom_y - j.height
    j.x = j.Left_x
    j.y = j.top_y
    j.xunit = h
    j.yunit = i
    return j
end
local k, l = GetActiveScreenResolution()
local m = a()
local globalHideUi = false
local n = 10.0
local function p(q, r, s, t, u, v, w, x)
    DrawRect(q + s / 2, r + t / 2, s, t, u, v, w, x)
end
Citizen.CreateThread(
    function()
        while true do
            if not globalHideUi then
                if not globalHideEmergencyCallUI then
                    local y = GetPlayerPed(-1)
                    local f, g = GetActiveScreenResolution()
                    if f ~= k or g ~= l then
                        k, l = GetActiveScreenResolution()
                        m = a()
                    end
                    local z = m
                    local A = (GetEntityHealth(y) - 100) / 100.0
                    if A < 0 then
                        A = 0.0
                    end
                    if A == 0.98 then
                        A = 1.0
                    end
                    local B = GetPedArmour(y) / 100.0
                    local C = GetPlayerUnderwaterTimeRemaining(PlayerId()) / n
                    if B > 1.0 then
                        B = 1.0
                    end
                    p(z.Left_x + 0.001, z.Bottom_y - 0.015, z.Width - 0.002, 0.009, 88, 88, 88, 200)
                    p(z.Left_x + 0.001, z.Bottom_y - 0.015, (z.Width - 0.002) * A, 0.009, 86, 215, 64, 200)
                    p(z.Left_x + 0.001, z.Bottom_y - 0.002, z.Width - 0.002, 0.009, 88, 88, 88, 200)
                    if IsPedSwimmingUnderWater(y) and C >= 0.0 then
                        p(z.Left_x + 0.001, z.Bottom_y - 0.002, (z.Width - 0.002) * C, 0.009, 243, 214, 102, 200)
                    elseif B > 0.0 then
                        p(z.Left_x + 0.001, z.Bottom_y - 0.002, (z.Width - 0.002) * B, 0.009, 60, 79, 255, 200)
                    end
                end
            end
            Wait(0)
        end
    end
)

RegisterCommand("hideui",function()
    globalHideUi = true
    TriggerEvent("AQUA:ToggleMoneyUI", false)
    ExecuteCommand("hideids")
end)

RegisterCommand("showui",function()
    globalHideUi = false
    TriggerEvent("AQUA:ToggleMoneyUI", true)
    ExecuteCommand("showids")
end)

Citizen.CreateThread(function()
    while true do
        if globalHideUi then
            HideHudAndRadarThisFrame()
            TriggerEvent("chat:clear")
        end
        Wait(0)
    end
end)