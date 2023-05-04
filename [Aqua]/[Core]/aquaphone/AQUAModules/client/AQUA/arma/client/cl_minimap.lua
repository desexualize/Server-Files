Citizen.CreateThread(function()
    local z = RequestScaleformMovie("minimap")
    SetRadarBigmapEnabled(true, false)
    Wait(0)
    SetRadarBigmapEnabled(false, false)
    BeginScaleformMovieMethod(z, "SETUP_HEALTH_ARMOUR")
    ScaleformMovieMethodAddParamInt(3)
    EndScaleformMovieMethod()
end)
local a = false
local b = 0
local function c()
    BeginScaleformMovieMethod(b, "SETUP_HEALTH_ARMOUR")
    ScaleformMovieMethodAddParamInt(3)
    EndScaleformMovieMethod()
    if IsDisabledControlJustReleased(0, 20) and IsUsingKeyboard(2) then
        if not a then
            SetBigmapActive(true, false)
            LastGameTimer = GetGameTimer()
            a = true
        elseif a then
            SetBigmapActive(false, false)
            LastGameTimer = 0
            a = false
        end
    end
end
tARMA.createThreadOnTick(c)
Citizen.CreateThread(function()
    b = RequestScaleformMovie("minimap")
end)
