local a=module("arma-vehicles","cfg_vehiclemaxspeeds")
isInGreenzone = false
local cityCap = true
local b = false
local c = false
local d = false
local e = false
local f = 0
local g = false
local h = false
local i = false
local j = vector3(0.0, 0.0, 0.0)
local k = 0.0
local l = {
    {
        colour = 2,
        id = 1,
        pos = vector3(333.91488647461, -597.16156005859, 29.292747497559),
        dist = 40,
        nonRP = false,
        setBit = false,
        maxHeight = 105.0
    },
    {
        colour = 2,
        id = 1,
        pos = vector3(148.066, -1050.763, 29.34099),
        dist = 40,
        nonRP = false,
        setBit = false,
        maxHeight = 87.0
    },
    {
        colour = 2,
        id = 1,
        pos = vector3(-110.09871673584, 6464.6030273438, 31.62672996521),
        dist = 20,
        nonRP = false,
        setBit = false,
        maxHeight = 50.0
    },
    {
        colour = 2,
        id = 1,
        pos = vector3(-1079.5734863281, -843.14739990234, 4.8841333389282),
        dist = 45,
        nonRP = false,
        setBit = false,
        maxHeight = 59.0
    },
    {
        colour = 2,
        id = 1,
        pos = vector3(-2181.7966308594, 5189.8286132813, 17.64377784729),
        dist = 150,
        nonRP = true,
        setBit = false,
        maxHeight = 77.0
    },
    {
        colour = 2,
        id = 1,
        pos = vector3(-540.54748535156, -216.42681884766, 37.64966583252),
        dist = 50,
        nonRP = false,
        setBit = false,
        maxHeight = 102.0
    },
    {
        colour = 2,
        id = 1,
        pos = vector3(246.30143737793, -782.50170898438, 30.573167800903),
        dist = 40,
        nonRP = false,
        setBit = false,
        maxHeight = 100.0
    },
    {
        colour = 2,
        id = 1,
        pos = vector3(3463.3479003906, 2589.4458007813, 17.442699432373),
        dist = 40,
        nonRP = true,
        setBit = false,
        maxHeight = 150.0
    },
    {
        colour = 2,
        id = 1,
        pos = vector3(1133.0970458984, 250.78565979004, -51.035778045654),
        dist = 100,
        nonRP = false,
        setBit = false,
        interior = true,
        maxHeight = 0.0
    },
    {
        colour = 2,
        id = 1,
        pos = vector3(13.929432868958, 6711.216796875, -105.85443878174),
        dist = 100,
        nonRP = false,
        setBit = false,
        interior = true,
        maxHeight = 0.0
    },
    {
        colour = 2,
        id = 1,
        pos = vector3(-335.19680786133, -699.10406494141, 33.036075592041),
        dist = 30,
        nonRP = false,
        setBit = false,
        maxHeight = 86.0
    },
    {
        colour = 2,
        id = 1,
        pos = vector3(-1671.5692138672, -912.63940429688, 8.2297477722168),
        dist = 50,
        nonRP = false,
        setBit = false,
        maxHeight = 60.0
    },
    {
        colour = 2,
        id = 1,
        pos = vector3(337.64172363281, -1393.6368408203, 32.509204864502),
        dist = 50,
        nonRP = false,
        setBit = false,
        maxHeight = 100.0
    },
    {
        colour = 2,
        id = 1,
        pos = vector3(-1437.4920654297, -2961.6879882812, 14.313854217529),
        dist = 700,
        nonRP = true,
        setBit = false,
        maxHeight = 210.0,
        isPurge = true
    },
    {
        colour = 2,
        id = 1,
        pos = vector3(-2335.1215820313, 266.88153076172, 169.60194396973),
        dist = 50,
        nonRP = false,
        setBit = false,
        maxHeight = 210.0
    }
}
local m = {
    {vector3(333.91488647461, -597.16156005859, 29.292747497559), 40.0, 2, 180},
    {vector3(148.066, -1050.763, 29.34099), 40.0, 2, 180},
    {vector3(-110.09871673584, 6464.6030273438, 31.62672996521), 20.0, 2, 180},
    {vector3(-1079.5734863281, -843.14739990234, 4.8841333389282), 45.0, 2, 180},
    {vector3(-2181.7966308594, 5189.8286132813, 17.64377784729), 150.0, 2, 180},
    {vector3(-540.54748535156, -216.42681884766, 37.64966583252), 50.0, 2, 180},
    {vector3(246.30143737793, -782.50170898438, 30.573167800903), 40.0, 2, 180},
    {vector3(-335.19680786133, -699.10406494141, 33.036075592041), 30.0, 2, 180},
    {vector3(-1671.5692138672, -912.63940429688, 8.2297477722168), 50.0, 2, 180},
    {vector3(1468.5318603516, 6328.529296875, 18.894895553589), 100.0, 1, 180},
    {vector3(4982.5634765625, -5175.1079101562, 2.4887988567352), 120.0, 1, 180},
    {vector3(5115.7465820312, -4623.2915039062, 2.642692565918), 85.0, 1, 180},
    {vector3(337.64172363281, -1393.6368408203, 32.509204864502), 50.0, 2, 180},
    {vector3(-1437.4920654297, -2961.6879882812, 14.31385421759), 700.0, 2, 255, true},
    {vector3(-2335.1215820313, 266.88153076172, 169.60194396973), 50.0, 2, 180} 
}
local n = Citizen.CreateThread
local o = Citizen.Wait
local SetEntityInvincible = SetEntityInvincible
local SetPlayerInvincible = SetPlayerInvincible
local ClearPedBloodDamage = ClearPedBloodDamage
local ResetPedVisibleDamage = ResetPedVisibleDamage
local ClearPedLastWeaponDamage = ClearPedLastWeaponDamage
local SetEntityProofs = SetEntityProofs
local SetEntityCanBeDamaged = SetEntityCanBeDamaged
local NetworkSetFriendlyFireOption = NetworkSetFriendlyFireOption
local GetEntityCoords = GetEntityCoords
local SetEntityNoCollisionEntity = SetEntityNoCollisionEntity
local SetPedCanRagdoll = SetPedCanRagdoll
local SetPedCanRagdollFromPlayerImpact = SetPedCanRagdollFromPlayerImpact
local SetEntityMaxSpeed = SetEntityMaxSpeed
local GetEntityModel = GetEntityModel
local SetEntityCollision = SetEntityCollision
local DisableControlAction = DisableControlAction
local GetVehiclePedIsIn = GetVehiclePedIsIn
function tARMA.areGreenzonesDisabled()
    return i
end
function tARMA.setGreenzonesDisabled(p)
    i = p
end
n(
    function()
        for q, r in pairs(m) do
            if not r[5] and not tARMA.isPurge() or r[5] and tARMA.isPurge() then
                local s = AddBlipForRadius(r[1].x, r[1].y, r[1].z, r[2])
                SetBlipColour(s, r[3])
                SetBlipAlpha(s, r[4])
            end
        end
    end
)
n(
    function()
        local purgeActive = tARMA.isPurge()
        while true do
            local t = tARMA.getPlayerPed()
            local u = tARMA.getPlayerCoords()
            for v, w in pairs(l) do
                if not w.isPurge and not purgeActive or w.isPurge and purgeActive then
                    local x = #(u.xy - w.pos.xy)
                    while x < w.dist and u.z < w.maxHeight do
                        u = tARMA.getPlayerCoords()
                        x = #(u.xy - w.pos.xy)
                        if w.nonRP then
                            c = true
                        else
                            if not w.setBit then
                                b = true
                                d = true
                                e = false
                                f = 5
                                j = w.pos
                                k = w.dist
                                w.setBit = true
                            end
                            if w.interior then
                                setDrawGreenInterior = true
                            end
                        end
                        o(100)
                    end
                    if w.setBit then
                        d = false
                        e = true
                        f = 5
                        j = vector3(0.0, 0.0, 0.0)
                        k = 0.0
                        w.setBit = false
                    end
                    c = false
                    b = false
                    d = false
                    setDrawGreenInterior = false
                    SetEntityInvincible(t, false)
                    SetPlayerInvincible(tARMA.getPlayerId(), false)
                    ClearPedBloodDamage(t)
                    ResetPedVisibleDamage(t)
                    ClearPedLastWeaponDamage(t)
                    SetEntityProofs(t, false, false, false, false, false, false, false, false)
                    SetEntityCanBeDamaged(t, true)
                    SetLocalPlayerAsGhost(false)
                    SetNetworkVehicleAsGhost(tARMA.getPlayerVehicle(), false)
                end
            end
            o(250)
        end
    end
)
AddEventHandler("ARMA:onClientSpawn",function(y, z)
    if z then
        local A = function(B)
            inCityZone = true
        end
        local C = function(B)
            inCityZone = false
        end
        local D = function(B)
        end
        tARMA.createArea("cityzone",vector3(-225.30703735352, -916.74755859375, 31.216938018799),750.0,100,A,C,D,{})
    end
end)
local function E()
    local F = tARMA.getPlayerCoords()
    local G = nil
    for H = 1, 25 do
        local I, J = GetNthClosestVehicleNode(F.x, F.y, F.z, H)
        if I and #(j - J) > k then
            G = J
            break
        end
    end
    if G then
        local K, L = tARMA.getPlayerVehicle()
        if K ~= 0 then
            if L and GetScriptTaskStatus(PlayerPedId(), "SCRIPT_TASK_VEHICLE_DRIVE_TO_COORD") == 7 then
                TaskVehicleDriveToCoord(PlayerPedId(), K, G.x, G.y, G.z, 30.0, 1.0, GetEntityModel(K), 16777216, 1.0, 1)
            end
        else
            if GetScriptTaskStatus(PlayerPedId(), "SCRIPT_TASK_FOLLOW_NAVMESH_TO_COORD_ADVANCED") == 7 then
                TaskFollowNavMeshToCoordAdvanced(PlayerPedId(), G.x, G.y, G.z, 8.0, -1, 2.5, 0, 0, 0.0, 100.0, 4000.0)
            end
        end
    end
end
n(function()
    while true do
        local t = PlayerPedId()
        local M = GetVehiclePedIsIn(t, false)
        SetVehicleAutoRepairDisabled(M, true)
        if not tARMA.areGreenzonesDisabled() then
            isInGreenzone = b or c
            local N = GetActivePlayers()
            local O = tARMA.getPlayerId()
            if b or c then
                SetEntityMaxSpeed(M, a.maxSpeeds["50"])
                SetLocalPlayerAsGhost(true)
                SetNetworkVehicleAsGhost(M, true)
                SetEntityAlpha(tARMA.getPlayerVehicle(), 255)
                SetEntityAlpha(t, 255)
                for P, Q in pairs(N) do
                    local R = GetPlayerPed(Q)
                    local S = GetVehiclePedIsIn(R, true)
                    SetEntityAlpha(R, 255)
                    SetEntityAlpha(S, 255)
                end
                SetEntityInvincible(t, true)
                SetPlayerInvincible(O, true)
                ClearPedBloodDamage(t)
                if usingDelgun then
                    tARMA.setWeapon(t, "WEAPON_STAFFGUN", true)
                else
                    tARMA.setWeapon(t, "WEAPON_UNARMED", true)
                end
                ResetPedVisibleDamage(t)
                ClearPedLastWeaponDamage(t)
                SetEntityProofs(t, true, true, true, true, true, true, true, true)
                SetEntityCanBeDamaged(t, false)
                SetPedCanRagdoll(t, false)
                SetPedCanRagdollFromPlayerImpact(t, false)
            else
                SetPedCanRagdoll(t, true)
                SetPedCanRagdollFromPlayerImpact(t, true)
                if M ~= 0 then
                    SetEntityCollision(M, true, true)
                    local T = GetEntityModel(M)
                    if not inCityZone or not cityCap then 
                        if a.vehicleMaxSpeeds[T] ~= nil then
                            SetEntityMaxSpeed(M, a.maxSpeeds[a.vehicleMaxSpeeds[T]])
                        else
                            SetEntityMaxSpeed(M, a.maxSpeeds["250"])
                        end
                    else
                        SetEntityMaxSpeed(M, a.maxSpeeds["100"])
                    end
                end
            end
            if d and g == false then
                TriggerEvent(
                    "ARMA:showNotification",
                    {
                        text = "You have entered the greenzone",
                        height = "200px",
                        width = "auto",
                        colour = "#FFF",
                        background = "#32CD32",
                        pos = "bottom-right",
                        icon = "success"
                    },
                    5000
                )
                g = true
                h = false
            end
            if e and h == false then
                TriggerEvent(
                    "ARMA:showNotification",
                    {
                        text = "You have left the greenzone",
                        height = "60px",
                        width = "auto",
                        colour = "#FFF",
                        background = "#ff0000",
                        pos = "bottom-right",
                        icon = "bad"
                    },
                    5000
                )
                h = true
                g = false
            end
            if b then
                DisableControlAction(2, 37, true)
                DisablePlayerFiring(O, true)
                DisableControlAction(0, 106, true)
                DisableControlAction(0, 45, true)
                DisableControlAction(0, 24, true)
                DisableControlAction(0, 263, true)
                DisableControlAction(0, 140, true)
                local U, V = tARMA.getPlayerCombatTimer()
                if U > 0 and V then
                    E()
                end
            end
            if c then
                drawNativeText("You have entered a non-RP greenzone, you may talk out of character here")
                DisableControlAction(2, 37, true)
                DisablePlayerFiring(O, true)
                DisableControlAction(0, 45, true)
                DisableControlAction(0, 24, true)
                DisableControlAction(0, 263, true)
                DisableControlAction(0, 140, true)
            end
            if setDrawGreenInterior then
                DisableControlAction(0, 106, true)
                DisableControlAction(0, 45, true)
                DisableControlAction(0, 24, true)
                DisableControlAction(0, 263, true)
                DisableControlAction(0, 140, true)
                DisableControlAction(0, 22, true)
            end
        end
        o(0)
    end
end)
            
RegisterCommand('togglecitycap', function()
    if tARMA.getUserId() == 1 then
        cityCap = not cityCap
        tARMA.notify('City Cap: '..(cityCap and "~g~Enabled" or "~r~Disabled"))
    end
end)