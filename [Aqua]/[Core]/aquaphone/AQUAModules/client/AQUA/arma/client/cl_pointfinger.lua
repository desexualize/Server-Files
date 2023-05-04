local a = false
local function b()
    local c = tARMA.getPlayerPed()
    tARMA.setWeapon(c, "WEAPON_UNARMED", true)
    tARMA.loadAnimDict("anim@mp_point")
    SetPedCurrentWeaponVisible(c, 0, 1, 1, 1)
    SetPedConfigFlag(c, 36, 1)
    TaskMoveNetworkByName(c, "task_mp_pointing", 0.5, 0, "anim@mp_point", 24)
    RemoveAnimDict("anim@mp_point")
end
local function d()
    local c = tARMA.getPlayerPed()
    RequestTaskMoveNetworkStateTransition(c, "Stop")
    if not IsPedInjured(c) then
        ClearPedSecondaryTask(c)
    end
    if not IsPedInAnyVehicle(c, 1) then
        SetPedCurrentWeaponVisible(c, 1, 1, 1, 1)
    end
    SetPedConfigFlag(c, 36, 0)
    ClearPedSecondaryTask(c)
end
local function e(f)
    if IsControlJustPressed(0, 29) then
        local g, h = GetCurrentPedWeapon(f.playerPed, true)
        if IsPedOnFoot(f.playerPed) and not g and h == GetHashKey("WEAPON_UNARMED") then
            if a then
                a = false
                d()
            else
                a = true
                b()
            end
        end
    end
    if a then
        local c = f.playerPed
        local i = GetGameplayCamRelativePitch()
        if i < -70.0 then
            i = -70.0
        elseif i > 42.0 then
            i = 42.0
        end
        i = (i + 70.0) / 112.0
        local j = GetGameplayCamRelativeHeading()
        local k = Cos(j)
        local l = Sin(j)
        if j < -180.0 then
            j = -180.0
        elseif j > 180.0 then
            j = 180.0
        end
        j = (j + 180.0) / 360.0
        local m = 0
        local n =
            GetOffsetFromEntityInWorldCoords(c, k * -0.2 - l * (0.4 * j + 0.3), l * -0.2 + k * (0.4 * j + 0.3), 0.6)
        local o = StartShapeTestCapsule(n.x, n.y, n.z - 0.2, n.x, n.y, n.z + 0.2, 0.4, 95, c, 7)
        nn, m, n, n = GetShapeTestResult(o)
        SetTaskMoveNetworkSignalFloat(c, "Pitch", i)
        SetTaskMoveNetworkSignalFloat(c, "Heading", j * -1.0 + 1.0)
        SetTaskMoveNetworkSignalBool(c, "isBlocked", m)
        SetTaskMoveNetworkSignalBool(c, "isFirstPerson", GetCamViewModeForContext(GetCamActiveViewModeContext()) == 4)
    end
end
tARMA.createThreadOnTick(e)
