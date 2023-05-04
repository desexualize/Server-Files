local a = {
    deformationMultiplier = -1,
    deformationExponent = 0.7,
    collisionDamageExponent = 0.6,
    damageFactorEngine = 10.0,
    damageFactorBody = 10.0,
    damageFactorPetrolTank = 64.0,
    engineDamageExponent = 0.6,
    weaponsDamageMultiplier = 1.00,
    degradingHealthSpeedFactor = 10,
    cascadingFailureSpeedFactor = 15.0,
    degradingFailureThreshold = 0.0,
    cascadingFailureThreshold = 0.0,
    engineSafeGuard = 150.0,
    torqueMultiplierEnabled = true,
    limpMode = true,
    limpModeMultiplier = 0.005,
    preventVehicleFlip = true,
    sundayDriver = false,
    sundayDriverAcceleratorCurve = 7.5,
    sundayDriverBrakeCurve = 5.0,
    displayBlips = true,
    compatibilityMode = false,
    randomTireBurstInterval = 0,
    chargeForRepairs = true,
    price = 1000.0,
    DamageMultiplier = 2.5,
    classDamageMultiplier = {
        [0] = 1.0,
        1.0,
        1.0,
        1.0,
        1.0,
        1.0,
        1.3,
        1.3,
        0.25,
        0.7,
        0.5,
        1.0,
        1.0,
        1.0,
        1.0,
        1.0,
        1.0,
        1.0,
        0.75,
        0.75,
        1.0,
        1.0,
        2.0
    }
}
globalDisableVehicleFailure = false
repairLocationsCfg = {
    mechanics = {
        {
            name = "Mechanic",
            blip = 446,
            radius = 5.0,
            position = vector3(1774.0, 3333.0, 41.0),
            pedPosition = vector4(1776.9522705078, 3327.7587890625, 41.433326721191, 312.74)
        },
        {
            name = "Mechanic",
            blip = 446,
            radius = 5.0,
            position = vector3(1143.0, -776.0, 57.0),
            pedPosition = vector4(1151.2346191406, -778.63012695312, 57.598678588867, 58.28)
        },
        {
            name = "Mechanic",
            blip = 446,
            radius = 5.0,
            position = vector3(2508.0, 4103.0, 38.0),
            pedPosition = vector4(2506.7048339844, 4097.9829101562, 38.706733703613, 2.37)
        },
        {
            name = "Mechanic",
            blip = 446,
            radius = 5.0,
            position = vector3(2006.0, 3792.0, 32.0),
            pedPosition = vector4(2002.1617431641, 3796.1989746094, 32.180774688721, 282.57)
        },
        {
            name = "Mechanic",
            blip = 446,
            radius = 5.0,
            position = vector3(258.0, 2594.0, 44.0),
            pedPosition = vector4(259.55130004883, 2586.1047363281, 44.9541206359861, 11.14)
        },
        {
            name = "Mechanic",
            blip = 446,
            radius = 5.0,
            position = vector3(-32.0, -1090.0, 26.0),
            pedPosition = vector4(-36.834205627441, -1088.4458007812, 26.422451019287, 248.74)
        },
        {
            name = "Mechanic",
            blip = 446,
            radius = 5.0,
            position = vector3(903.0, 3563.0, 34.0),
            pedPosition = vector4(902.65588378906, 3566.1516113281, 33.794116973877, 110.31)
        }
    },
    fixMessages = {
        "Looks fixed... must be nice!",
        "Duct tape application complete...",
        "Zip tie application complete...",
        "I heard kicking your car fixes it...",
        "Super glue fixed everything..."
    },
    fixMessageCount = 5,
    noFixMessages = {"Harrison: Bring the car in!"},
    noFixMessageCount = 1
}
local b = false
local c
local d
local e
local f = 0.0
local g = 0.0
local h = 0.0
local i = 1.0
local j = false
local k = false
local l = 1000.0
local m = 1000.0
local n = 1000.0
local o = 0.0
local p = 0.0
local q = 1000.0
local r = 1000.0
local s = 1000.0
local t = 0.0
local u = 0.0
local v = 1000.0
local w = 1000.0
local x = 1000.0
local y = 0.0
local z = 0.0
local A
local B = 0
math.randomseed(GetGameTimer())
local C = a.randomTireBurstInterval * 1200
if a.randomTireBurstInterval ~= 0 then
    A = math.random(C)
end
local D = math.random(repairLocationsCfg.fixMessageCount)
local E = math.random(repairLocationsCfg.noFixMessageCount)
local function F(G)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(G)
    EndTextCommandThefeedPostTicker(false, false)
end
local function H()
    local I = tARMA.getPlayerPed()
    c = GetVehiclePedIsIn(I, false)
    if IsPedInAnyVehicle(I, false) then
        if GetPedInVehicleSeat(c, -1) == I then
            local J = GetVehicleClass(c)
            if J ~= 15 and J ~= 16 and J ~= 21 and J ~= 13 then
                return true
            end
        end
    end
    return false
end
local function K(L, M, N, O, P, Q)
    local R = 0.0
    local S = 0.0
    local T = 0.0
    local U = 0.0
    local V = 0.0
    local W = 0
    if Q > 10.0 then
        Q = 10.0
    end
    if Q < -10.0 then
        Q = -10.0
    end
    Q = Q * -.1
    Q = 10.0 ^ Q
    if L < M then
        L = M
    end
    if L > N then
        L = N
    end
    R = N - M
    if P > O then
        S = P - O
    else
        S = O - P
        W = 1
    end
    T = L - M
    U = T / R
    if M > N then
        return 0
    end
    if W == 0 then
        V = U ^ Q * S + O
    else
        V = O - U ^ Q * S
    end
    return V
end
local function X()
    local Y = math.random(C)
    if Y == A then
        if GetVehicleTyresCanBurst(c) == false then
            return
        end
        local Z = GetVehicleNumberOfWheels(c)
        local _
        if Z == 2 then
            _ = (math.random(2) - 1) * 4
        elseif Z == 4 then
            _ = math.random(4) - 1
            if _ > 1 then
                _ = _ + 2
            end
        elseif Z == 6 then
            _ = math.random(6) - 1
        else
            _ = 0
        end
        SetVehicleTyreBurst(c, _, false, 1000.0)
        A = math.random(C)
    end
end
if a.torqueMultiplierEnabled or a.preventVehicleFlip or a.limpMode then
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            if a.torqueMultiplierEnabled or a.sundayDriver or a.limpMode then
                if b then
                    local a0 = 1.0
                    if a.torqueMultiplierEnabled and n < 900 then
                        a0 = (n + 200.0) / 1100
                    end
                    if a.sundayDriver and GetVehicleClass(c) ~= 14 then
                        local a1 = GetControlValue(2, 71)
                        local a2 = GetControlValue(2, 72)
                        local a3 = GetEntitySpeedVector(c, true)["y"]
                        local a4 = i
                        if a3 >= 1.0 then
                            if a1 > 127 then
                                local a5 =
                                    K(a1, 127.0, 254.0, 0.1, 1.0, 10.0 - a.sundayDriverAcceleratorCurve * 2.0)
                                a0 = a0 * a5
                            end
                            if a2 > 127 then
                                j = true
                                a4 = K(a2, 127.0, 254.0, 0.01, i, 10.0 - a.sundayDriverBrakeCurve * 2.0)
                            end
                        elseif a3 <= -1.0 then
                            if a2 > 127 then
                                local a6 =
                                    K(a2, 127.0, 254.0, 0.1, 1.0, 10.0 - a.sundayDriverAcceleratorCurve * 2.0)
                                a0 = a0 * a6
                            end
                            if a1 > 127 then
                                k = true
                                a4 = K(a1, 127.0, 254.0, 0.01, i, 10.0 - a.sundayDriverBrakeCurve * 2.0)
                            end
                        else
                            local a7 = GetEntitySpeed(c)
                            if a7 < 1 then
                                if j == true then
                                    DisableControlAction(2, 72, true)
                                    SetVehicleForwardSpeed(c, a3 * 0.98)
                                    SetVehicleBrakeLights(c, true)
                                end
                                if k == true then
                                    DisableControlAction(2, 71, true)
                                    SetVehicleForwardSpeed(c, a3 * 0.98)
                                    SetVehicleBrakeLights(c, true)
                                end
                                if j == true and GetDisabledControlNormal(2, 72) == 0 then
                                    j = false
                                end
                                if k == true and GetDisabledControlNormal(2, 71) == 0 then
                                    k = false
                                end
                            end
                        end
                        if a4 > i - 0.02 then
                            a4 = i
                        end
                        SetVehicleHandlingFloat(c, "CHandlingData", "fBrakeForce", a4)
                    end
                    if a.limpMode == true and n < a.engineSafeGuard + 5 then
                        a0 = a.limpModeMultiplier
                    end
                    SetVehicleCheatPowerIncrease(c, a0)
                end
            end
            if a.preventVehicleFlip then
                local a8 = GetEntityRoll(c)
                if (a8 > 75.0 or a8 < -75.0) and GetEntitySpeed(c) < 2 then
                    DisableControlAction(2, 59, true)
                    DisableControlAction(2, 60, true)
                end
            end
        end
    end)
end
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(50)
        local I = tARMA.getPlayerPed()
        if H() and not globalDisableVehicleFailure then
            c = GetVehiclePedIsIn(I, false)
            e = GetVehicleClass(c)
            m = GetVehicleEngineHealth(c)
            if m == 1000 then
                l = 1000.0
            end
            n = m
            o = l - m
            p = o * a.damageFactorEngine * a.classDamageMultiplier[e]
            r = GetVehicleBodyHealth(c)
            if r == 1000 then
                q = 1000.0
            end
            s = r
            t = q - r
            u = t * a.damageFactorBody * a.classDamageMultiplier[e]
            w = GetVehiclePetrolTankHealth(c)
            if a.compatibilityMode and w < 1 then
                v = w
            end
            if w == 1000 then
                v = 1000.0
            end
            x = w
            y = v - w
            z = y * a.damageFactorPetrolTank * a.classDamageMultiplier[e]
            if m > a.engineSafeGuard + 1 then
                SetVehicleUndriveable(c, false)
            end
            if m <= a.engineSafeGuard + 1 and a.limpMode == false then
                SetVehicleUndriveable(c, true)
            end
            if c ~= d then
                b = false
            end
            if b == true then
                if m ~= 1000.0 or r ~= 1000.0 or w ~= 1000.0 then
                    local a9 = math.max(p, u, z)
                    if a9 > m - a.engineSafeGuard then
                        a9 = a9 * 0.7
                    end
                    if a9 > m then
                        a9 = m - a.cascadingFailureThreshold / 5
                    end
                    n = l - a9
                    if n > a.cascadingFailureThreshold + 5 and n < a.degradingFailureThreshold then
                        n = n - 0.038 * a.degradingHealthSpeedFactor
                    end
                    if n < a.cascadingFailureThreshold then
                        n = n - 0.1 * a.cascadingFailureSpeedFactor
                    end
                    if n < a.engineSafeGuard then
                        n = a.engineSafeGuard
                    end
                    if a.compatibilityMode == false and w < 750 then
                        x = 750.0
                    end
                    if s < 0 then
                        s = 0.0
                    end
                end
            else
                g = GetVehicleHandlingFloat(c, "CHandlingData", "fDeformationDamageMult")
                i = GetVehicleHandlingFloat(c, "CHandlingData", "fBrakeForce")
                local aa = g ^ a.deformationExponent
                if a.deformationMultiplier ~= -1 then
                    SetVehicleHandlingFloat(c,"CHandlingData","fDeformationDamageMult",aa * a.deformationMultiplier)
                end
                if a.weaponsDamageMultiplier ~= -1 then
                    SetVehicleHandlingFloat(c,"CHandlingData","fWeaponDamageMult",a.weaponsDamageMultiplier / a.damageFactorBody)
                end
                f = GetVehicleHandlingFloat(c, "CHandlingData", "fCollisionDamageMult")
                local ab = f ^ a.collisionDamageExponent
                SetVehicleHandlingFloat(c, "CHandlingData", "fCollisionDamageMult", ab)
                h = GetVehicleHandlingFloat(c, "CHandlingData", "fEngineDamageMult")
                local ac = h ^ a.engineDamageExponent
                SetVehicleHandlingFloat(c, "CHandlingData", "fEngineDamageMult", ac)
                if r < a.cascadingFailureThreshold then
                    s = a.cascadingFailureThreshold
                end
                b = true
            end
            if n ~= m then
                SetVehicleEngineHealth(c, n)
            end
            if s ~= r then
                SetVehicleBodyHealth(c, s)
            end
            if x ~= w then
                SetVehiclePetrolTankHealth(c, x)
            end
            l = n
            q = s
            v = x
            d = c
            if a.randomTireBurstInterval ~= 0 and GetEntitySpeed(c) > 10 then
                X()
            end
        else
            if b == true then
                d = GetVehiclePedIsIn(I, true)
                if d ~= 0 then
                    if a.deformationMultiplier ~= -1 then
                        SetVehicleHandlingFloat(d, "CHandlingData", "fDeformationDamageMult", g)
                    end
                    SetVehicleHandlingFloat(d, "CHandlingData", "fBrakeForce", i)
                    if a.weaponsDamageMultiplier ~= -1 then
                        SetVehicleHandlingFloat(d, "CHandlingData", "fWeaponDamageMult", a.weaponsDamageMultiplier)
                    end
                    SetVehicleHandlingFloat(d, "CHandlingData", "fCollisionDamageMult", f)
                    SetVehicleHandlingFloat(d, "CHandlingData", "fEngineDamageMult", h)
                end
            end
            b = false
        end
    end
end)
local function ad(ae)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(ae)
    EndTextCommandDisplayHelp(0, false, false, 0)
end
local function af(I, ag)
    local ah = GetGameTimer()
    while GetGameTimer() - ah < 8000 do
        if #(GetEntityCoords(I, true) - ag) < 1.0 then
            break
        end
        Citizen.Wait(0)
    end
end
local function ai(aj, ak)
    Citizen.CreateThread(function()
        local al = ak / 4
        Citizen.Wait(al)
        TaskStartScenarioInPlace(aj.ped, "WORLD_HUMAN_HAMMERING", 0, true)
        Citizen.Wait(al)
        TaskStartScenarioInPlace(aj.ped, "WORLD_HUMAN_WELDING", 0, true)
        Citizen.Wait(al)
        TaskStartScenarioInPlace(aj.ped, "CODE_HUMAN_MEDIC_TIME_OF_DEATH", 0, true)
    end)
end
local function am(aj)
    local an = math.random(1, 3)
    if an == 1 then
        ai(aj, 11000)
        F("~g~Rhys the mechanic is looking at your car.")
        Citizen.Wait(11000)
        F("~g~Rhys is working on your car.")
    elseif an == 2 then
        ai(aj, 11000 * 5)
        F("~g~Connor the mechanic is looking at your car.")
        Citizen.Wait(11000)
        F("~g~Connor looks confused.")
        Citizen.Wait(11000)
        F("~g~Connor starts hitting things with a hammer.")
        Citizen.Wait(11000)
        F("~g~Connor goes to look for help.")
        Citizen.Wait(11000)
        F("~g~Connor's Manager comes back and starts working on your car.")
        Citizen.Wait(11000)
        F("~g~The Manager is also hitting things with a hammer.")
    elseif an == 3 then
        ai(aj, 11000 * 3)
        F("~g~Ollie the mechanic is looking at your car.")
        Citizen.Wait(11000)
        F("~g~Ollie yells for Rhys to come look at it.")
        Citizen.Wait(11000)
        F("~g~Just look at it.")
        Citizen.Wait(11000)
        F("~g~Rhys is working on your car.")
    end
end
local function ao(aj, ap)
    local aq = GetEntityBoneIndexByName(ap, "bonnet")
    local ar = GetWorldPositionOfEntityBone(ap, aq)
    local as = GetEntityForwardVector(ap) * 1.5 + ar
    local at = GetEntityCoords(aj.ped, true)
    TaskGoStraightToCoord(aj.ped, as.x, as.y, as.z, 1.0, -1, 0.0, 0.5)
    af(aj.ped, as)
    TaskLookAtEntity(aj.ped, ap, -1, 2048, 3)
    Citizen.Wait(2500)
    tARMA.loadAnimDict("missexile3")
    TaskPlayAnim(aj.ped, "missexile3", "ex03_dingy_search_case_base_michael", 1.0, 8.0, -1, 1, 1.0, false, false, false)
    RemoveAnimDict("missexile3")
    Citizen.Wait(1000)
    SetVehicleDoorOpen(ap, 4, false, false)
    am(aj)
    ClearPedTasksImmediately(aj.ped)
    SetVehicleDoorShut(ap, 4, false)
    Citizen.Wait(1000)
    SetVehicleEngineHealth(ap, 9999)
    SetVehiclePetrolTankHealth(ap, 9999)
    SetVehicleFixed(ap)
    TaskGoStraightToCoord(aj.ped, at.x, at.y, at.z, 1.0, -1, 0.0, 0.5)
    af(aj.ped, at)
    TaskLookAtEntity(aj.ped, PlayerPedId(), -1, 2048, 3)
    aj.inUse = false
    SetVehicleEngineOn(ap, true, false, false)
end
local function au(aj)
    tARMA.loadModel("s_m_y_xmech_01")
    aj.ped = CreatePed(0, "s_m_y_xmech_01", aj.pedPosition.x, aj.pedPosition.y, aj.pedPosition.z, 0.0, false, false)
    SetModelAsNoLongerNeeded("s_m_y_xmech_01")
    SetEntityCanBeDamaged(aj.ped, false)
    SetEntityCanBeDamagedByRelationshipGroup(aj.ped, false, "PLAYER")
    SetEntityInvincible(aj.ped, true)
    SetPedCanRagdoll(aj.ped, false)
    SetPedCanRagdollFromPlayerImpact(aj.ped, false)
    SetBlockingOfNonTemporaryEvents(aj.ped, true)
    SetEntityInvincible(aj.ped, true)
end
local function av(aj)
    DeleteEntity(aj.ped)
    aj.ped = nil
end
local function aw(aj)
    if not aj.inUse and not tARMA.isInsideLsCustoms() then
        if tARMA.getPlayerVehicle() ~= 0 then
            DrawMarker(1,aj.position.x,aj.position.y,aj.position.z - 2.0,0.0,0.0,0.0,0.0,0.0,0.0,aj.radius,aj.radius,2.0,62,255,143,140,false,false,2,false,nil,nil,false)
            DrawMarker(36,aj.position.x,aj.position.y,aj.position.z + 1.0,0.0,0.0,0.0,0.0,0.0,0.0,aj.radius / 2.0,aj.radius / 2.0,aj.radius / 2.0,62,255,143,140,false,false,2,false,nil,nil,false)
        end
        if aj.ped and GetScriptTaskStatus(aj.ped, "SCRIPT_TASK_TURN_PED_TO_FACE_ENTITY") == 7 then
            TaskTurnPedToFaceEntity(aj.ped, PlayerPedId(), -1)
        end
    end
end
local function ax(aj)
    PlayPedAmbientSpeechNative(aj.ped, "GENERIC_HI_MALE", "SPEECH_PARAMS_FORCE")
end
local function ay(aj)
    aj.inUse = nil
end
local function az(aj)
    local ap, aA = tARMA.getPlayerVehicle()
    if ap == 0 or not aA or tARMA.isInsideLsCustoms() then
        return
    end
    if aj.inUse then
        SetVehicleEngineOn(ap, false, true, true)
    else
        ad("Press ~INPUT_PICKUP~ to have your vehicle repaired.")
        if IsControlJustPressed(0, 38) then
            aj.inUse = true
            Citizen.CreateThreadNow(function()
                ao(aj, ap)
            end)
        end
    end
end
Citizen.CreateThread(function()
    for aB, aj in pairs(repairLocationsCfg.mechanics) do
        if aj.showBlip then
            tARMA.addBlip(aj.position.x, aj.position.y, aj.position.z, aj.blip, 4, aj.name, 0.4)
        end
        tARMA.createArea("mechanic_ped_" .. aB, aj.position, 25.0, 25.0, au, av, aw, aj)
        tARMA.createArea("mechanic_vehicle_" .. aB, aj.position, aj.radius, 5.0, ax, ay, az, aj)
    end
end)
