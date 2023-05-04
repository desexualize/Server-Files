local a = false
local function b(c, d, e, f, g, h, i, j)
    DrawRect(c + e / 2, d + f / 2, e, f, g, h, i, j, 0)
end
local function k()
    local l = GetSafeZoneSize()
    local m = 1.0 / 20.0
    local n = 1.0 / 20.0
    local o = GetAspectRatio(0)
    local p, q = GetActiveScreenResolution()
    local r = 1.0 / p
    local s = 1.0 / q
    local t = {}
    t.Width = r * p / (4 * o)
    t.height = s * q / 5.674
    t.Left_x = r * p * m * math.abs(l - 1.0) * 10
    t.Bottom_y = 1.0 - s * q * n * math.abs(l - 1.0) * 10
    t.right_x = t.Left_x + t.Width
    t.top_y = t.Bottom_y - t.height
    t.x = t.Left_x
    t.y = t.top_y
    t.xunit = r
    t.yunit = s
    return t
end

Citizen.CreateThread(
    function()
        while true do
            if not a then
                local v = k()
                local w = (GetEntityHealth(PlayerPedId()) - 100) / 100.0
                if w < 0 then
                    w = 0.0
                end
                if w == 0.98 then
                    w = 1.0
                end
                local x = GetPedArmour(PlayerPedId()) / 100.0
                if GetPedArmour(PlayerPedId()) == 98 then
                    x = 100.0 / 100.0
                end
                local y = GetPlayerUnderwaterTimeRemaining(PlayerId()) / 10.0
                if x > 1.0 then
                    x = 1.0
                end
                b(v.Left_x + 0.001, v.Bottom_y - 0.015, v.Width - 0.002, 0.009, 88, 88, 88, 200)
                if GetEntityHealth(PlayerPedId()) - 100 > 50 then
                    b(v.Left_x + 0.001, v.Bottom_y - 0.015, (v.Width - 0.002) * w, 0.009, 0, 255, 107, 200)
                elseif GetEntityHealth(PlayerPedId()) - 100 <= 50 and GetEntityHealth(PlayerPedId()) - 100 > 25 then
                    b(v.Left_x + 0.001, v.Bottom_y - 0.015, (v.Width - 0.002) * w, 0.009, 255, 254, 0, 200)
                elseif GetEntityHealth(PlayerPedId()) - 100 <= 25 then
                    b(v.Left_x + 0.001, v.Bottom_y - 0.015, (v.Width - 0.002) * w, 0.009, 244, 11, 27, 200)
                end
                b(v.Left_x + 0.001, v.Bottom_y - 0.002, v.Width - 0.002, 0.009, 88, 88, 88, 200)
                if IsPedSwimmingUnderWater(PlayerPedId()) and y >= 0.0 then
                    b(v.Left_x + 0.001, v.Bottom_y - 0.002, (v.Width - 0.002) * y, 0.009, 243, 214, 102, 200)
                elseif x > 0.0 then
                    b(v.Left_x + 0.001, v.Bottom_y - 0.002, (v.Width - 0.002) * x, 0.009, 60, 79, 255, 200)
                end
            end
            Wait(0)
        end
    end
)
Citizen.CreateThread(
    function()
        SetPedConfigFlag(PlayerPedId(), 149, true)
        SetPedConfigFlag(PlayerPedId(), 438, true)
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
        TriggerEvent("GMT-Client:UI:Toggle", false)
    end
)
RegisterCommand(
    "showui",
    function()
        a = false
        TriggerEvent("GMT-Client:UI:Toggle", true)
    end
)
RegisterNetEvent("GMT:ToggleHud")
AddEventHandler(
    "GMT:ToggleHud",
    function()
        a = not a
        if not a then
            TriggerEvent("GMT-Client:UI:Toggle", true)
        else
            TriggerEvent("GMT-Client:UI:Toggle", false)
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

