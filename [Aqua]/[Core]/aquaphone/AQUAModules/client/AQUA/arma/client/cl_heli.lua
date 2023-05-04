local a = 80.0
local b = 10.0
local c = 3.0
local d = 3.0
local e = 3.0
local f = 51
local g = 25
local h = 154
local i = 74
local j = 22
local k = false
local l = false
local m = false
local n = 0
local o = false
local p = 0
local q = {
    GetHashKey("nhs"),
    GetHashKey("annihilator"),
    GetHashKey("uh1forest"),
    GetHashKey("ka60"),
    GetHashKey("polisheli"),
    GetHashKey("mh60s"),
    GetHashKey("uh1mash"),
    GetHashKey("npas2"),
    GetHashKey("npas"),
    GetHashKey("polmav"),
    GetHashKey("polbird"),
    GetHashKey("knighthawk"),
    GetHashKey("nhsbigheli"),
    GetHashKey("npas4"),
}
function tARMA.isPlayerRappeling()
    return k
end
function tARMA.isPlayerInPoliceHeli()
    return l
end
local r = (a + b) * 0.5
local s = 0
local t = math.rad
local u = math.cos
local v = math.sin
local w = math.abs
local function x(y)
    local z = t(y.x)
    local A = t(y.z)
    return vector3(-v(A) * w(u(z)), u(A) * w(u(z)), v(z))
end
local function B(C)
    C = C + 2000
    C = math.floor(C / 40)
    return math.max(math.min(C, 99), 0)
end
local function D(E, F)
    local G = math.floor(GetEntityHeading(F))
    local H = GetEntityCoords(F, true)
    local I = math.floor(H.z * 3.28084)
    local J = GetEntityCoords(E, true)
    local K = math.floor(#(H - J))
    BeginScaleformMovieMethod(n, "SET_TARGET_INFORMATION")
    ScaleformMovieMethodAddParamInt(B(H.x))
    ScaleformMovieMethodAddParamInt(B(H.y))
    ScaleformMovieMethodAddParamInt(G)
    ScaleformMovieMethodAddParamInt(I)
    ScaleformMovieMethodAddParamInt(K)
    EndScaleformMovieMethod()
end
local function L(M)
    local N = GetCamCoord(M)
    local O = N + x(GetCamRot(M, 2)) * 500.0
    local P = StartExpensiveSynchronousShapeTestLosProbe(N.x, N.y, N.z, O.x, O.y, O.z, -1, heli, 4)
    local Q, R, S = GetShapeTestResult(P)
    if R then
        BeginScaleformMovieMethod(n, "SET_TARGET_INFORMATION")
        ScaleformMovieMethodAddParamInt(B(S.x))
        ScaleformMovieMethodAddParamInt(B(S.y))
        ScaleformMovieMethodAddParamInt(360 - math.floor(GetHeadingFromVector_2d(S.x - N.x, S.y - N.y)))
        ScaleformMovieMethodAddParamInt(math.floor(S.z * 3.28084))
        ScaleformMovieMethodAddParamInt(math.floor(#(N - S)))
        EndScaleformMovieMethod()
    end
end
local function T(E)
    local G = math.floor(GetEntityHeading(E))
    local U = GetEntityCoords(E, true)
    local I = math.floor(U.z * 3.28084)
    BeginScaleformMovieMethod(n, "SET_AIRCRAFT_INFORMATION")
    ScaleformMovieMethodAddParamInt(B(U.x))
    ScaleformMovieMethodAddParamInt(B(U.y))
    ScaleformMovieMethodAddParamInt(G)
    ScaleformMovieMethodAddParamInt(I)
    EndScaleformMovieMethod()
end
local function V(M)
    local W = GetCamRot(M, 2)
    BeginScaleformMovieMethod(n, "SET_CAMERA_PITCH")
    ScaleformMovieMethodAddParamFloat(W.x)
    EndScaleformMovieMethod()
    BeginScaleformMovieMethod(n, "SET_CAMERA_HEADING")
    ScaleformMovieMethodAddParamFloat(W.z)
    EndScaleformMovieMethod()
end
local function X(Y)
    local Z = GetEntityModel(Y)
    local _ = GetLabelText(GetDisplayNameFromVehicleModel(Z))
    local a0 = GetVehicleNumberPlateText(Y)
    tARMA.DrawText(0.45, 0.9, "Model: " .. _ .. "\nPlate: " .. a0, 0.55)
end
local function a1()
    while true do
        if l then
            local a2 = tARMA.getPlayerPed()
            local heli = tARMA.getPlayerVehicle()
            if IsHeliHighEnough(heli) then
                if IsControlJustPressed(0, f) then
                    if globalOnPoliceDuty or GetPedInVehicleSeat(heli, 0) == a2 then
                        PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                        m = true
                    end
                end
                if IsControlJustPressed(0, h) and not (GetPedInVehicleSeat(heli, -1) == a2 or GetPedInVehicleSeat(heli, 0) == a2) then
                    k = true
                    PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                    TaskRappelFromHeli(a2, 1)
                    Wait(1000)
                    local a3 = GetSoundId()
                    PlaySoundFrontend(a3, "Rappel_Loop", "GTAO_Rappel_Sounds", true)
                    while GetIsTaskActive(PlayerPedId(), 49) or GetIsTaskActive(PlayerPedId(), 67) do
                        Wait(0)
                    end
                    StopSound(a3)
                    ReleaseSoundId(a3)
                    local a4 = GetSoundId()
                    PlaySoundFrontend(a4, "Rappel_Land", "GTAO_Rappel_Sounds", true)
                    Wait(1000)
                    ReleaseSoundId(a4)
                    ClearPedTasks(PlayerPedId())
                    ClearPedTasksImmediately(PlayerPedId())
                end
            end
        end
        if m then
            SetTimecycleModifier("heliGunCam")
            SetTimecycleModifierStrength(0.3)
            n = RequestScaleformMovie("HELI_CAM") --RequestScaleformMovie("WESCAM_INTERFACE")
            while not HasScaleformMovieLoaded(n) do
                Citizen.Wait(0)
            end
            local a5, a6, a7, a8, a9, aa = GetLocalTime()
            BeginScaleformMovieMethod(n, "SET_DATE")
            ScaleformMovieMethodAddParamInt(a7)
            ScaleformMovieMethodAddParamInt(a6)
            ScaleformMovieMethodAddParamInt(a5)
            EndScaleformMovieMethod()
            local a2 = tARMA.getPlayerPed()
            local heli = tARMA.getPlayerVehicle()
            local ab = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", true)
            tARMA.hideUI()
            AttachCamToEntity(ab, heli, 0.0, 0.0, -1.5, true)
            SetCamRot(ab, 0.0, 0.0, GetEntityHeading(heli))
            SetCamFov(ab, r)
            RenderScriptCams(true, false, 0, 1, 0)
            local ac = nil
            local ad = 0
            while m and not IsEntityDead(a2) and GetVehiclePedIsIn(a2) == heli and IsHeliHighEnough(heli) do
                if IsDisabledControlJustPressed(0, f) then
                    PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                    m = false
                end
                if IsDisabledControlJustPressed(0, g) then
                    PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                    ChangeVision()
                end
                local ae = 0.0
                if ac then
                    if DoesEntityExist(ac) then
                        PointCamAtEntity(ab, ac, 0.0, 0.0, 0.0, true)
                        X(ac)
                        if IsControlJustPressed(0, j) then
                            PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                            ac = nil
                            local af = GetCamRot(ab, 2)
                            local r = GetCamFov(ab)
                            local ag = ab
                            DestroyCam(ag, false)
                            ab = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", true)
                            AttachCamToEntity(ab, heli, 0.0, 0.0, -1.5, true)
                            SetCamRot(ab, af, 2)
                            SetCamFov(ab, r)
                            RenderScriptCams(true, false, 0, 1, 0)
                        end
                        D(heli, ac)
                    else
                        ac = nil
                    end
                else
                    ae = 1.0 / (a - b) * (r - b)
                    CheckInputRotation(ab, ae)
                    local ah = GetVehicleInView(ab)
                    if DoesEntityExist(ah) then
                        X(ah)
                        if IsControlJustPressed(0, j) then
                            PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                            ac = ah
                        end
                    end
                    L(ab)
                end
                if IsControlJustPressed(0, i) then
                    o = not o
                end
                if o then
                    local ai = GetGameTimer()
                    local aj = x(GetCamRot(ab, 2))
                    if ai - p >= 500 then
                        local ak = GetEntityCoords(heli, true) + aj * 500.0
                        TriggerServerEvent("ARMA:updateSpotlight", ak)
                        p = ai
                    end
                    local al = GetEntityCoords(heli, true)
                    DrawSpotLight(al.x, al.y, al.z, aj.x, aj.y, aj.z, 255, 255, 255, 500.0, 20.0, 5.0, 15.0, 50.0)
                end
                HandleZoom(ab)
                HideHUDThisFrame()
                a5, a6, a7, a8, a9, aa = GetLocalTime()
                if aa ~= ad then
                    BeginScaleformMovieMethod(n, "SET_TIME")
                    ScaleformMovieMethodAddParamInt(a8)
                    ScaleformMovieMethodAddParamInt(a9)
                    ScaleformMovieMethodAddParamInt(aa)
                    EndScaleformMovieMethod()
                    ad = aa
                end
                T(heli)
                V(ab)
                DrawScaleformMovieFullscreen(n, 255, 255, 255, 255, 0)
                Citizen.Wait(0)
            end
            m = false
            ClearTimecycleModifier()
            r = (a + b) * 0.5
            RenderScriptCams(false, false, 0, 1, 0)
            SetScaleformMovieAsNoLongerNeeded(n)
            DestroyCam(ab, false)
            SetNightvision(false)
            SetSeethrough(false)
            tARMA.showUI()
        end
        Wait(0)
    end
end
Citizen.CreateThread(a1)
Citizen.CreateThread(function()
    while true do
        local a2 = tARMA.getPlayerPed()
        local Y = GetVehiclePedIsIn(a2)
        local am = GetEntityModel(Y)
        if table.has(q, am) then
            l = true
        else
            l = false
        end
        Wait(1000)
    end
end)
function IsHeliHighEnough(heli)
    return GetEntityHeightAboveGround(heli) > 1.5
end
function ChangeVision()
    BeginScaleformMovieMethod(n, "SET_CAMERA_TYPE")
    if s == 0 then
        SetNightvision(true)
        s = 1
        ScaleformMovieMethodAddParamInt(3)
    elseif s == 1 then
        SetNightvision(false)
        SetSeethrough(true)
        s = 2
        ScaleformMovieMethodAddParamInt(2)
    else
        SetSeethrough(false)
        s = 0
        ScaleformMovieMethodAddParamInt(1)
    end
    EndScaleformMovieMethod()
end
function HideHUDThisFrame()
    HideHelpTextThisFrame()
    HideHudAndRadarThisFrame()
    HideHudComponentThisFrame(19)
    HideHudComponentThisFrame(1)
    HideHudComponentThisFrame(2)
    HideHudComponentThisFrame(3)
    HideHudComponentThisFrame(4)
    HideHudComponentThisFrame(13)
    HideHudComponentThisFrame(11)
    HideHudComponentThisFrame(12)
    HideHudComponentThisFrame(15)
    HideHudComponentThisFrame(18)
end
function CheckInputRotation(ab, ae)
    local an = GetDisabledControlNormal(0, 220)
    local ao = GetDisabledControlNormal(0, 221)
    local y = GetCamRot(ab, 2)
    if an ~= 0.0 or ao ~= 0.0 then
        new_z = y.z + an * -1.0 * e * (ae + 0.1)
        new_x = math.max(math.min(20.0, y.x + ao * -1.0 * d * (ae + 0.1)), -89.5)
        SetCamRot(ab, new_x, 0.0, new_z, 2)
    end
end
function HandleZoom(ab)
    if IsControlJustPressed(0, 241) then
        r = math.max(r - c, b)
    end
    if IsControlJustPressed(0, 242) then
        r = math.min(r + c, a)
    end
    local ap = GetCamFov(ab)
    if math.abs(r - ap) < 0.1 then
        r = ap
    end
    SetCamFov(ab, ap + (r - ap) * 0.05)
end
function GetVehicleInView(ab)
    local aq = GetCamCoord(ab)
    local ar = RotAnglesToVec(GetCamRot(ab, 2))
    local as = StartExpensiveSynchronousShapeTestLosProbe(aq, aq + ar * 200.0, 10, GetVehiclePedIsIn(PlayerPedId()), 0)
    local Q, Q, Q, Q, at = GetShapeTestResult(as)
    if at > 0 and IsEntityAVehicle(at) then
        return at
    else
        return nil
    end
end
function RotAnglesToVec(af)
    local A = math.rad(af.z)
    local z = math.rad(af.x)
    local au = math.abs(math.cos(z))
    return vector3(-math.sin(A) * au, math.cos(A) * au, math.sin(z))
end
local av = {}
RegisterNetEvent("ARMA:updateSpotlight",function(aw, ax)
    local ay = GetPlayerFromServerId(aw)
    if ay == -1 then
        return
    end
    local az = GetPlayerPed(ay)
    if az == 0 or az == tARMA.getPlayerPed() then
        return
    end
    local Y = GetVehiclePedIsUsing(az)
    if Y == 0 then
        return
    end
    local aA = av[aw]
    if not aA then
        aA = {vehicle = Y, currentPosition = ax, currentTime = GetGameTimer()}
        av[aw] = aA
    end
    aA.previousPosition = aA.currentPosition
    aA.previousTime = aA.currentTime
    aA.currentPosition = ax
    aA.currentTime = GetGameTimer()
    aA.heliPosition = GetEntityCoords(Y, true)
end)
local function aB()
    local ai = GetGameTimer()
    for aw, aA in pairs(av) do
        local aC = aA.currentTime - aA.previousTime
        local aD = (ai - aA.currentTime) / aC
        local aE = aA.currentPosition + GetEntityCoords(aA.vehicle, true) - aA.heliPosition
        local aF = aE - aA.previousPosition
        local aG = aA.previousPosition + aF * aD
        local aH = norm(aG - aA.heliPosition)
        DrawSpotLight(aA.heliPosition.x,aA.heliPosition.y,aA.heliPosition.z,aH.x,aH.y,aH.z,255,255,255,500.0,20.0,5.0,15.0,50.0)
        if ai - aA.currentTime > 1250 then
            av[aw] = nil
        end
    end
end
tARMA.createThreadOnTick(aB)
