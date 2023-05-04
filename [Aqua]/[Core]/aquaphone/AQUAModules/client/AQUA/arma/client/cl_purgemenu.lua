local a = false
local b = {[12] = {"test", 0}}
local c = 0.033
local d = 0
local e = 0.306
local function f(g, h, i)
    local j = 0.17
    local k = -0.01
    local l = 0.038
    local m = 0.008
    local n = 0.005
    local o = 0.32
    local p = -0.04
    local q = 0.014
    local r = GetSafeZoneSize()
    local s = q + r - j + j / 2
    local t = p + r - l + l / 2 - (i - 1) * (l + n)
    DrawSprite("timerbars", "all_black_bg", s, t, j, 0.038, 0, 0, 0, 0, 128)
    DrawGTAText(g, r - j + 0.04, t - m, o)
    DrawGTAText(string.upper(h), r - k, t - 0.0175, 0.5, true, j / 2)
end
local function u()
    if IsControlJustPressed(0, 167) then
        if a then
            a = false
        else
            a = true
            TriggerServerEvent("ARMA:getTopFraggers")
        end
    end
    if a then
        DrawRect(0.50, 0.222, 0.223, 0.075, 255, 0, 0, 255)
        DrawAdvancedText(0.595, 0.213, 0.005, 0.0028, 1.0, "ARMA PURGE", 255, 255, 255, 255, 1, 0)
        DrawAdvancedText(0.595, 0.275, 0.005, 0.0028, 0.4, "TOP 10", 0, 255, 50, 255, 6, 0)
        DrawRect(0.50, 0.272, 0.223, 0.026, 0, 0, 0, 222)
        for v, w in pairs(b) do
            licenseName = w[1] .. "  -  " .. w[2]
            DrawAdvancedText(0.595, e + d * c, 0.005, 0.0028, 0.4, tostring(licenseName), 255, 255, 255, 255, 6, 0)
            DrawRect(0.50, 0.301 + c * d, 0.223, 0.033, 0, 0, 0, 120)
            d = d + 1
        end
        d = 0
    end
    if b[12] and b[12][2] then
        f("~r~KILLS", b[12][2], 1)
    else
        f("~r~KILLS", "0", 1)
    end
    f("~r~F6 TO OPEN LEADERBOARD", "", 0)
end
if tARMA.isPurge() then
    tARMA.createThreadOnTick(u)
end
Citizen.CreateThread(function()
    Wait(5000)
    if tARMA.isPurge() then
        TriggerServerEvent("ARMA:getTopFraggers")
    end
end)
RegisterNetEvent("ARMA:gotTopFraggers")
AddEventHandler("ARMA:gotTopFraggers",function(x)
    b = x
end)
RegisterNetEvent("ARMA:incrementPurgeKills")
AddEventHandler("ARMA:incrementPurgeKills",function()
    if b[12] and b[12][2] then
        b[12][2] = b[12][2] + 1
    else
        b[12] = {[1] = "test", 1}
    end
end)
