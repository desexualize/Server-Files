radiusBlip = nil
local a = {}
local b
local c = {"p_cargo_chute_s", "xs_prop_arena_crate_01a", "cuban800", "s_m_m_pilot_02"}
local d
RegisterNetEvent("ARMA:crateDrop",function(e, f, g)
    -- e = vector3
    -- f = crate id
    -- g (if it's rig)
    for h, i in pairs(c) do
        tARMA.loadModel(i)
    end
    RequestWeaponAsset("weapon_flare")
    while not HasWeaponAssetLoaded("weapon_flare") do
        Wait(0)
    end
    local j
    if not g then
        local k = math.random(0, 360) + 0.0
        local l = 1500.0
        local m = k / 180.0 * 3.14
        local n = vector3(e.x, e.y, e.z) - vector3(math.cos(m) * l, math.sin(m) * l, -500.0)
        local o = e.x - n.x
        local p = e.y - n.y
        local q = GetHeadingFromVector_2d(o, p)
        j = CreateVehicle("cuban800", n.x, n.y, n.z, q, false, true)
        DecorSetInt(j, "ARMAACVeh", 955)
        SetEntityHeading(j, q)
        SetVehicleDoorsLocked(j, 2)
        SetEntityDynamic(j, true)
        ActivatePhysics(j)
        SetVehicleForwardSpeed(j, 60.0)
        SetHeliBladesFullSpeed(j)
        SetVehicleEngineOn(j, true, true, false)
        ControlLandingGear(j, 3)
        OpenBombBayDoors(j)
        SetEntityProofs(j, true, false, true, false, false, false, false, false)
        local r = CreatePedInsideVehicle(j, 1, "s_m_m_pilot_02", -1, false, true)
        SetBlockingOfNonTemporaryEvents(r, true)
        SetPedRandomComponentVariation(r, false)
        SetPedKeepTask(r, true)
        SetTaskVehicleGotoPlaneMinHeightAboveTerrain(j, 50)
        TaskVehicleDriveToCoord(r,j,vector3(e.x, e.y, e.z) + vector3(0.0, 0.0, 500.0),60.0,0,"cuban800",262144,15.0,-1.0)
        local s = AddBlipForEntity(j)
        SetBlipSprite(s, 307)
        SetBlipColour(s, 3)
        local t = vector2(e.x, e.y)
        local u = vector2(GetEntityCoords(j).x, GetEntityCoords(j).y)
        while #(u - t) > 5.0 do
            Wait(100)
            u = vector2(GetEntityCoords(j).x, GetEntityCoords(j).y)
        end
        TaskVehicleDriveToCoord(r, j, 0.0, 0.0, 500.0, 60.0, 0, "cuban800", 262144, -1.0, -1.0)
        SetTimeout(30000,function()
            SetEntityAsNoLongerNeeded(r)
            SetEntityAsNoLongerNeeded(j)
        end)
    end
    local v = vector3(e.x, e.y, GetEntityCoords(j).z - 5.0)
    a[f] = {}
    a[f].crate = CreateObject("xs_prop_arena_crate_01a", v, false, true, true)
    DecorSetInt(a[f].crate, "lootid", f)
    DecorSetInt(a[f].crate, "ARMAACVeh", 955)
    SetEntityLodDist(a[f].crate, 10000)
    ActivatePhysics(a[f].crate)
    SetDamping(a[f].crate, 2, 0.1)
    SetEntityVelocity(a[f].crate, 0.0, 0.0, -0.1)
    FreezeEntityPosition(a[f].crate, true)
    Wait(500)
    FreezeEntityPosition(a[f].crate, false)
    local w = AddBlipForEntity(a[f].crate)
    if g then
        SetBlipSprite(w, 306)
    else
        SetBlipSprite(w, 501)
    end
    SetBlipColour(w, 2)
    a[f].parachute = CreateObject("p_cargo_chute_s", v, false, true, true)
    DecorSetInt(a[f].parachute, "ARMAACVeh", 955)
    SetEntityLodDist(a[f].parachute, 10000)
    SetEntityVelocity(a[f].parachute, 0.0, 0.0, -0.1)
    ActivatePhysics(a[f].crate)
    AttachEntityToEntity(a[f].parachute,a[f].crate,0,0.0,0.0,0.1,0.0,0.0,0.0,false,false,false,false,2,true)
    radiusBlip = AddBlipForRadius(e.x, e.y, e.z, g and 50.0 or 200.0)
    SetBlipColour(radiusBlip, 1)
    SetBlipAlpha(radiusBlip, 180)
    local x = GetGameTimer()
    while GetEntityHeightAboveGround(a[f].crate) > 2 and GetGameTimer() - x < 60000 do
        Wait(100)
    end
    SetEntityCoords(a[f].crate, e + vector3(0.0, 0.0, -1.0))
    d = GetSoundId()
    PlaySoundFromEntity(d, "Crate_Beeps", a[f].crate, "MP_CRATE_DROP_SOUNDS", true, 0)
    ShootSingleBulletBetweenCoords(GetEntityCoords(a[f].crate),GetEntityCoords(a[f].crate) - vector3(0.0001, 0.0001, 0.0001),0,false,"weapon_flare",0,true,false,-1.0)
    DetachEntity(a[f].parachute, true, true)
    DeleteEntity(a[f].parachute)
    if DoesBlipExist(b) then
        RemoveBlip(b)
    end
    local y = GetEntityCoords(a[f].crate)
    --AddOwnedExplosion(tARMA.getPlayerPed(), y.x, y.y, y.z, 1, 0.0, true, false, 3.0)
    FreezeEntityPosition(a[f].crate, true)
    for h, i in pairs(c) do
        SetModelAsNoLongerNeeded(GetHashKey(i))
    end
end)

RegisterNetEvent("ARMA:removeLootcrate",function(f)
    if a[f] then
        if DoesEntityExist(a[f].crate) then
            DeleteEntity(a[f].crate)
        end
        if DoesEntityExist(a[f].parachute) then
            DeleteEntity(a[f].parachute)
        end
        SetTimeout(300000,function()
            RemoveBlip(radiusBlip)
        end)
        StopSound(d)
        ReleaseSoundId(d)
    end
end)
RegisterNetEvent("ARMA:addCrateDropRedzone",function(f, e)
    tARMA.loadModel("xs_prop_arena_crate_01a")
    a[f] = {}
    a[f].crate = CreateObject("xs_prop_arena_crate_01a", e + vector3(0.0, 0.0, -1.0), false, true, true)
    DecorSetInt(a[f].crate, "lootid", f)
    DecorSetInt(a[f].crate, "ARMAACVeh", 955)
    FreezeEntityPosition(a[f].crate, true)
    SetModelAsNoLongerNeeded("xs_prop_arena_crate_01a")
    local w = AddBlipForEntity(a[f].crate)
    SetBlipSprite(w, 501)
    SetBlipColour(w, 2)
    d = GetSoundId()
    PlaySoundFromEntity(d, "Crate_Beeps", a[f].crate, "MP_CRATE_DROP_SOUNDS", true, 0)
    radiusBlip = AddBlipForRadius(e.x, e.y, e.z, 200.0)
    SetBlipColour(radiusBlip, 1)
    SetBlipAlpha(radiusBlip, 180)
end)
RegisterNetEvent("ARMA:removeCrateRedzone",function()
    SetTimeout(300000,function()
        RemoveBlip(radiusBlip)
    end)
end)
