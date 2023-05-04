local a = {cols={[16]={r=55,g=55,b=55},[18]={r=55,g=55,b=135},[24]={r=55,g=95,b=135},[52]={r=95,g=55,b=55},[67]={r=95,g=135,b=175},[88]={r=135,g=55,b=55},[95]={r=135,g=95,b=95},[124]={r=175,g=55,b=55},[133]={r=175,g=95,b=175},[173]={r=215,g=135,b=95},[203]={r=255,g=95,b=95},[210]={r=255,g=135,b=135},[216]={r=255,g=175,b=135},[222]={r=255,g=215,b=135},[231]={r=255,g=255,b=255}},bits={{133,133,133,133,88,88,88,88,88,88,133,133,133,133,133,133,133,133,133,88,124,222,222,124,124,124,88,133,133,133,133,133,133,133,133,88,124,231,231,203,203,203,124,88,133,133,133,133,133,133,88,88,88,88,88,88,88,203,203,124,88,88,133,133,133,88,124,203,203,203,203,124,124,88,203,203,124,124,88,133,133,88,88,88,88,88,88,88,88,88,124,203,203,124,88,133,133,133,133,95,231,231,210,231,231,210,88,88,88,88,88,133,133,133,133,95,231,67,216,67,231,210,210,52,52,95,133,133,133,133,133,95,231,16,216,16,231,216,210,52,52,216,95,133,133,133,95,216,216,216,216,216,216,216,52,52,52,216,95,133,133,133,16,210,216,216,210,210,16,216,216,52,210,95,133,133,133,16,16,16,210,210,16,16,16,16,216,210,210,52,52,133,133,133,133,16,16,16,16,16,216,216,210,210,52,52,133,133,133,133,133,133,95,210,210,210,210,210,210,95,133,133,133,133,133,133,95,95,24,18,88,88,88,18,18,88,88,88,133,133,133,95,231,24,18,124,124,124,18,24,203,203,203,124,88,133,95,231,222,18,124,203,203,18,24,124,95,95,95,203,124,88,95,222,222,18,124,124,124,18,24,95,231,231,231,95,124,88,133,95,18,24,18,18,18,24,95,231,231,231,231,222,95,88,133,133,18,222,67,67,222,222,95,231,231,231,222,222,95,133,133,52,52,222,67,67,222,222,67,95,222,222,222,95,133,133,52,173,173,52,24,67,67,67,67,24,95,95,95,52,133,133,52,95,95,173,52,67,24,24,67,67,24,24,18,95,52,133,52,52,95,95,52,24,24,18,24,67,67,67,18,95,52,52,52,52,95,95,52,24,18,18,18,24,24,67,18,95,95,52,133,52,52,95,52,18,133,133,133,18,18,24,18,173,95,52,133,52,52,52,133,133,133,133,133,133,133,18,18,173,95,52,133,133,133,133,133,133,133,133,133,133,133,133,133,52,52,133},{133,133,133,133,88,88,88,88,88,88,133,133,133,133,133,133,133,133,133,88,124,222,222,124,124,124,88,133,133,133,133,133,133,133,133,88,124,231,231,203,203,203,124,88,133,133,133,133,133,133,88,88,88,88,88,88,88,203,203,124,88,88,133,133,133,88,124,203,203,203,203,124,124,88,203,203,124,124,88,133,133,88,88,88,88,88,88,88,88,88,124,203,203,124,88,133,133,133,133,95,231,231,210,231,231,210,88,88,88,88,88,133,133,133,133,95,231,67,216,67,231,210,210,52,52,95,133,133,133,133,133,95,231,16,216,16,231,216,210,52,52,216,95,133,133,133,95,216,216,216,216,216,216,216,52,52,52,216,95,133,133,133,16,210,216,216,210,210,16,216,216,52,210,95,133,133,133,16,16,16,210,210,16,16,16,16,216,210,210,52,52,133,133,133,133,16,16,16,16,16,216,216,210,210,52,52,133,133,133,133,133,133,95,210,210,210,210,210,210,95,133,133,133,133,133,133,133,133,18,88,88,88,18,18,88,88,88,133,133,133,133,133,95,18,124,124,124,18,95,95,95,203,203,88,133,133,133,95,231,18,124,203,203,95,231,231,231,95,203,203,88,133,133,95,222,18,124,124,95,231,231,231,231,222,95,124,88,133,133,95,18,24,18,18,95,231,231,231,222,222,95,124,88,133,133,133,18,222,67,67,222,95,222,222,222,95,88,88,133,133,133,133,18,222,67,67,222,222,95,95,95,24,24,18,133,133,133,18,24,24,67,67,24,24,67,67,24,24,18,133,133,133,133,52,52,24,24,24,24,18,24,67,67,24,18,52,133,133,52,173,173,52,24,24,24,18,24,24,24,24,52,95,52,133,52,95,95,173,52,24,18,133,18,24,24,24,52,95,52,133,133,52,95,95,95,52,133,133,133,52,52,52,173,95,52,133,133,133,52,95,95,52,133,133,52,173,173,95,95,52,133,133,133,133,133,52,52,52,133,133,52,52,52,52,52,133,133,133},{133,133,133,133,88,88,88,88,88,88,133,133,133,133,133,133,133,133,133,88,124,222,222,124,124,124,88,133,133,133,133,133,133,133,133,88,124,231,231,203,203,203,124,88,133,133,133,133,133,133,88,88,88,88,88,88,88,124,203,124,88,88,133,133,133,88,124,203,203,203,203,124,124,88,203,203,124,124,88,133,133,88,88,88,88,88,88,88,88,88,124,203,203,124,88,133,133,133,133,95,231,231,210,231,231,210,88,88,88,88,88,133,133,133,133,95,231,67,216,67,231,210,210,52,52,95,133,133,133,133,133,95,231,16,216,16,231,216,210,52,52,210,95,133,133,133,95,216,216,216,216,216,216,216,52,52,52,210,95,133,133,133,16,210,216,216,210,210,16,216,216,52,210,95,133,133,133,16,16,16,210,210,16,16,16,16,216,210,210,52,52,133,133,133,133,16,16,16,16,16,216,216,210,210,52,52,133,133,133,133,133,133,95,210,210,210,210,210,210,95,133,133,133,133,133,133,133,133,18,88,95,95,95,88,88,88,88,133,133,133,133,133,133,18,88,95,231,231,231,95,203,203,124,88,133,133,133,133,133,18,95,231,231,231,231,222,95,203,203,88,133,133,133,133,18,88,95,231,231,231,222,222,95,203,124,88,133,133,133,133,18,18,18,95,222,222,222,95,124,124,124,88,133,133,133,133,18,222,67,222,95,95,95,88,88,88,88,18,133,133,133,133,18,222,67,222,222,67,24,24,24,24,24,18,133,133,133,133,133,18,67,67,67,67,67,24,24,24,18,133,133,133,133,133,133,18,24,18,67,67,67,24,24,24,18,133,133,133,133,133,133,133,18,24,18,67,24,24,24,18,133,133,133,133,133,133,133,133,18,18,18,18,18,18,18,18,133,133,133,133,133,133,133,133,52,95,52,173,173,95,95,52,133,133,133,133,133,133,133,52,95,52,173,173,95,95,95,52,133,133,133,133,133,133,133,52,52,52,52,52,52,52,52,52,133,133,133,133}}}
local b = {}
local c = 0
local d
local e
local f
local g
local h = 1
local i = 0
local j = 15
local k = 0
local l = 1
local m = -20.0
local n = 0.01
RegisterNetEvent("ARMA:doAcid",function()
    local p = "mp_player_inteat@burger"
    local q = "mp_player_int_eat_burger"
    local r = tARMA.loadModel("a_c_hen")
    RequestAnimDict(p)
    while not HasAnimDictLoaded(p) do
        Wait(0)
    end
    TaskPlayAnim(tARMA.getPlayerPed(), p, q, 2.0, 2.0, -1, 51, 0, false, false, false)
    RemoveAnimDict(p)
    local s = tARMA.getPlayerPed()
    local t, u, v = table.unpack(GetEntityCoords(s))
    local w = CreatePed(5, r, t, u, v + 0.2, 0.0, false, true)
    AttachEntityToEntity(w,s,GetPedBoneIndex(s, 18905),0.13,0.05,0.02,00.0,0.0,0.0,true,true,false,true,1,true)
    SetModelAsNoLongerNeeded(r)
    SetTimeout(2000,function()
        DeletePed(w)
        ClearPedTasks(s)
    end)
    DoAcid(20000)
end)
DoAcid = function(x)
    local y = x and x >= 200000 and 2 or 1
    SendNUIMessage({type = "playMusic", song = y})
    InitCubes()
    local z = 0
    local A = GetGameTimer()
    local B = tARMA.getPlayerPed()
    local C = GetEntityCoords(B)
    while GetGameTimer() - A < x do
        local D = GetEntityCoords(tARMA.getPlayerPed())
        local E = GetVecDist(C, D)
        if E > 1.0 then
            z = z + 1
            if z == 5 then
                z = 0
                local F = C - D
                local G = GetEntityVelocity(tARMA.getPlayerPed())
                SetEntityCoordsNoOffset(tARMA.getPlayerPed(), D.x + F.x, D.y + F.y, D.z)
                ForcePedMotionState(tARMA.getPlayerPed(), -1115154469, 1, 1, 0)
                SetEntityVelocity(tARMA.getPlayerPed(), G.x, G.y, G.z)
            end
            C = GetEntityCoords(tARMA.getPlayerPed())
        end
        DrawToons()
        DrawCubes()
        if e and not f then
            f = true
            Citizen.CreateThread(InitPed)
        end
        Wait(0)
    end
    ClearTimecycleModifier()
    ShakeGameplayCam("DRUNK_SHAKE", 0.0)
    SetPedMotionBlur(tARMA.getPlayerPed(), false)
    SetEntityAsMissionEntity(g, true, true)
    DeleteEntity(g)
    SendNUIMessage({type = "stopMusic"})
    b = {}
    c = 0
    d = nil
    e = nil
    f = nil
    g = nil
    h = 1
    i = 0
    j = 15
    k = 0
    l = 1
    m = -20.0
    n = 0.01
end
InitPed = function()
    local H = tARMA.getPlayerPed()
    local I = GetEntityCoords(H)
    local J = math.random(0, 359)
    local K = math.random(50, 80)
    local L = I + PointOnSphere(0.0, J, K)
    while GetScreenCoordFromWorldCoord(L.x, L.y, L.z) and not IsPointOnRoad(L.x, L.y, L.z) do
        J = math.random(0, 359)
        K = math.random(50, 80)
        L = GetEntityCoords(tARMA.getPlayerPed()) + PointOnSphere(0.0, J)
        Citizen.Wait(0)
    end
    g = ClonePed(H, GetEntityHeading(H), false, false)
    Wait(10)
    SetEntityCoordsNoOffset(g, L.x, L.y, L.z + 1.0)
    SetPedComponentVariation(g, 1, 60, 0, 0)
    SetEntityInvincible(g, true)
    SetBlockingOfNonTemporaryEvents(g, true)
    TrackEnt()
end
TrackEnt = function()
    while true do
        local E = GetVecDist(GetEntityCoords(tARMA.getPlayerPed()), GetEntityCoords(g))
        if E > 5.0 then
            TaskGoToEntity(g, tARMA.getPlayerPed(), -1, 4.0, 100.0, 1073741824, 0)
            Wait(1000)
        else
            if not IsTaskMoveNetworkActive(g) then
                RequestAnimDict("anim@mp_point")
                while not HasAnimDictLoaded("anim@mp_point") do
                    Wait(0)
                end
                TaskMoveNetworkByName(g, "task_mp_pointing", 0.5, 0, "anim@mp_point", 24)
                SetPedCurrentWeaponVisible(g, 0, 1, 1, 1)
                SetPedConfigFlag(g, 36, 1)
            end
            RemoveAnimDict("anim@mp_point")
            if not d or GetGameTimer() - d > 1000 then
                d = GetGameTimer()
                TaskTurnPedToFaceEntity(g, tARMA.getPlayerPed(), -1)
            end
            SetTaskMoveNetworkSignalFloat(g, "Pitch", 0.4)
            SetTaskMoveNetworkSignalFloat(g, "Heading", 0.5)
            SetTaskMoveNetworkSignalBool(g, "isBlocked", false)
            SetTaskMoveNetworkSignalBool(g, "isFirstPerson", false)
            if IsPedRagdoll(g) then
                while IsPedRagdoll(g) do
                    Wait(0)
                end
                ClearPedTasksImmediately(g)
                Wait(10)
            end
            Wait(0)
        end
    end
end
InitCubes = function()
    for M = 1, 50, 1 do
        local N = math.random(5, 255)
        local O = math.random(5, 255)
        local P = math.random(5, 255)
        local Q = math.random(50, 100)
        local t = math.random(1, 180)
        local u = math.random(1, 359)
        local v = math.random(15, 35)
        b[M] = {pos = PointOnSphere(t, u, v), points = {x = t, y = u, z = v}, col = {r = N, g = O, b = P, a = Q}}
    end
    ShakeGameplayCam("DRUNK_SHAKE", 0.0)
    SetTimecycleModifierStrength(0.0)
    SetTimecycleModifier("BikerFilter")
    SetPedMotionBlur(tARMA.getPlayerPed(), true)
    local R = 4000
    local S = 0
    while S < R do
        S = S + 1
        local D = GetEntityCoords(tARMA.getPlayerPed())
        local T = 0.1 * S / 40
        SetTimecycleModifierStrength(math.min(0.1 * S / (R / 40), 1.5))
        ShakeGameplayCam("DRUNK_SHAKE", math.min(0.1 * S / (R / 40), 1.5))
        for U, V in pairs(b) do
            local I = D + V.pos
            DrawBox(I.x + T, I.y + T, I.z + T, I.x - T, I.y - T, I.z - T, V.col.r, V.col.g, V.col.g, V.col.a)
            local W = {x = V.points.x + 0.1, y = V.points.y + 0.1, z = V.points.z}
            b[U].points = W
            b[U].pos = PointOnSphere(W.x, W.y, W.z)
        end
        Wait(0)
    end
end
DrawCubes = function()
    local X = GetEntityCoords(tARMA.getPlayerPed())
    local T = 10
    for U, V in pairs(b) do
        local Y = 0.1
        local Z = 0.1
        if U % 4 == 0 then
            Z = -0.1
        elseif U % 3 == 0 then
            Y = -0.1
        elseif U % 2 == 0 then
            Y = -0.1
            Z = -0.1
        end
        local I = X + V.pos
        DrawBox(I.x + T, I.y + T, I.z + T, I.x - T, I.y - T, I.z - T, V.col.r, V.col.g, V.col.g, V.col.a)
        local W = {x = V.points.x + Y, y = V.points.y + Z, z = V.points.z}
        b[U].points = W
        b[U].pos = PointOnSphere(W.x, W.y, W.z)
    end
end
DrawToons = function()
    local H = tARMA.getPlayerPed()
    local D = GetEntityCoords(H)
    local _ = vector3(D.x + 35.0, D.y - 8.0, D.z)
    local a0 = vector3(D.x - 35.0, D.y - 8.0, D.z)
    if GetGameTimer() - i > 1000 then
        i = GetGameTimer()
        h = h + l
        if h > #a.bits then
            l = -1
            h = 2
        elseif h <= 0 then
            h = 2
            l = 1
        end
    end
    DrawMario(_)
    DrawMario(a0)
end
DrawMario = function(a1)
    local a2 = 0
    local a3 = 0
    if m < 0.0 then
        m = m + n
    end
    for U = #a.bits[h], 1, -1 do
        local V = a.bits[h][U]
        local I = vector3(a1.x, a1.y + a3, a1.z + a2)
        local a4 = a.cols[V]
        if k < 255 then
            if not e then
                e = true
            end
            k = k + 0.001
        end
        if V ~= 133 then
            DrawBox(I.x + 0.5,I.y + 0.5,I.z + 0.5 + m,I.x - 0.5,I.y - 0.5,I.z - 0.5 + m,a4.r,a4.g,a4.b,math.floor(k))
        end
        a3 = a3 + 1
        if a3 > j then
            a3 = 0
            a2 = a2 + 1
        end
    end
end
GetVecDist = function(a5, a6)
    if not a5 or not a6 or not a5.x or not a6.x then
        return 0
    end
    return math.sqrt(((a5.x or 0) - (a6.x or 0)) * ((a5.x or 0) - (a6.x or 0)) +((a5.y or 0) - (a6.y or 0)) * ((a5.y or 0) - (a6.y or 0)) +((a5.z or 0) - (a6.z or 0)) * ((a5.z or 0) - (a6.z or 0)))
end
PointOnSphere = function(a7, a8, a9, aa, ab, ac)
    local ad = 0.017453292384744
    a7, a8, a9, aa, ab, ac = (tonumber(a7 or 0) or 0) * ad,(tonumber(a8 or 0) or 0) * ad,tonumber(a9 or 0) or 0,tonumber(aa or 0) or 0,tonumber(ab or 0) or 0,tonumber(ac or 0) or 0
    if vector3 then
        return vector3(aa + a9 * math.sin(a8) * math.cos(a7),ab + a9 * math.cos(a8) * math.cos(a7),ac + a9 * math.sin(a7))
    end
end
local ae = false
local af = false
RegisterNetEvent("ARMA:cocaineEffect",function()
    if ae then
        af = true
        local t = 0
        while t < 10 do
            tARMA.varyHealth(-10)
            tARMA.notify("~r~I don't feel too good..")
            Wait(5000)
            t = t + 1
        end
        SetRunSprintMultiplierForPlayer(PlayerId(), 1.00)
        af = false
        ClearTimecycleModifier()
    else
        PrepareMusicEvent("EXL3_FIGHT_OS")
        TriggerMusicEvent("EXL3_FIGHT_OS")
        SetTimecycleModifier("Barry1_Stoned")
        SetRunSprintMultiplierForPlayer(PlayerId(), 1.40)
        ae = true
        Wait(30000)
        SetRunSprintMultiplierForPlayer(PlayerId(), 1.00)
        ae = false
        if not af then
            ClearTimecycleModifier()
        end
    end
end)
RegisterNetEvent("ARMA:heroinEffect",function()
    PrepareMusicEvent("HALLOWEEN_START_MUSIC")
    TriggerMusicEvent("HALLOWEEN_START_MUSIC")
    RequestAnimSet("anim_group_move_ballistic")
    while not HasAnimSetLoaded("anim_group_move_ballistic") do
        Wait(0)
    end
    SetPedMovementClipset(PlayerPedId(), "anim_group_move_ballistic", 0.2)
    RemoveAnimSet("anim_group_move_ballistic")
    SetTimecycleModifier("DRUG_gas_huffin")
    tARMA.enablePunching(true)
    Wait(30000)
    ClearTimecycleModifier()
    tARMA.enablePunching(false)
    TriggerMusicEvent("BST_STOP")
    ResetPedMovementClipset(PlayerPedId())
end)
