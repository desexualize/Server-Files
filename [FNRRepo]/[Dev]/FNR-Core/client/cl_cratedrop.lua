local models = {"p_cargo_chute_s", "prop_drop_crate_01_set2", "titan", "s_m_m_pilot_02"} --What models the first one is the parachute and the second one is the brief case
local activeCrate = nil
local activeParachute = nil
local crateBlip, radiusBlip = nil
local soundID

local function LoadModel(modelName)
    local modelHash
    if type(modelName) ~= "string" then
        modelHash = modelName
    else
        modelHash = GetHashKey(modelName)
    end
    if IsModelInCdimage(modelHash) then
        if not HasModelLoaded(modelHash) then
            RequestModel(modelHash)
            while not HasModelLoaded(modelHash) do
                Wait(0)
            end
        end
        return modelHash
    else
        return nil
    end
end

RegisterNetEvent("crateDrop")
AddEventHandler("crateDrop", function(c)
    TriggerEvent("removeCrate")
    for k,v in pairs(models) do
        LoadModel(v)
    end
    RequestWeaponAsset("weapon_flare")
    while not HasWeaponAssetLoaded("weapon_flare") do
        Wait(0)
    end

    local z = math.random(150.0, 350.0)
    local Coords = vector3(c.x, c.y, c.z)

    local j = math.random(0, 360) + 0.0
    local k = 1500.0
    local l = j / 180.0 * 3.14
    local m = vector3(c.x, c.y, c.z) - vector3(math.cos(l) * k, math.sin(l) * k, -500.0)
    local n = c.x - m.x
    local o = c.y - m.y
    local p = GetHeadingFromVector_2d(n, o)
    local aircraft = CreateVehicle("titan", m.x, m.y, m.z, p, false, true)
    SetEntityHeading(aircraft, p)
    SetVehicleDoorsLocked(aircraft, 2)
    SetEntityDynamic(aircraft, true)
    ActivatePhysics(aircraft)
    SetVehicleForwardSpeed(aircraft, 60.0)
    SetHeliBladesFullSpeed(aircraft)
    SetVehicleEngineOn(aircraft, true, true, false)
    ControlLandingGear(aircraft, 3)
    OpenBombBayDoors(aircraft)
    SetEntityProofs(aircraft, true, false, true, false, false, false, false, false)
    local q = CreatePedInsideVehicle(aircraft, 1, "s_m_m_pilot_02", -1, false, true)
    SetBlockingOfNonTemporaryEvents(q, true)
    SetPedRandomComponentVariation(q, false)
    SetPedKeepTask(q, true)
    SetTaskVehicleGotoPlaneMinHeightAboveTerrain(aircraft, 50)
    TaskVehicleDriveToCoord(q,aircraft,vector3(c.x, c.y, c.z) + vector3(0.0, 0.0, 500.0),60.0,0,"titan",262144,15.0,-1.0)
    local r = AddBlipForEntity(aircraft)
    SetBlipSprite(r, 307)
    SetBlipColour(r, 3)
    local s = vector2(c.x, c.y)
    local t = vector2(GetEntityCoords(aircraft).x, GetEntityCoords(aircraft).y)
    while #(t - s) > 5.0 do
        Wait(100)
        t = vector2(GetEntityCoords(aircraft).x, GetEntityCoords(aircraft).y)
    end
    TaskVehicleDriveToCoord(q, aircraft, 0.0, 0.0, 500.0, 60.0, 0, "titan", 262144, -1.0, -1.0)
    SetTimeout(30000,function()
        DeleteEntity(aircraft)
        DeleteEntity(q)
        RemoveBlip(r)
    end)

    activeCrate = CreateObject(GetHashKey(models[2]), Coords, false, true, true)

    SetEntityLodDist(activeCrate, 10000)
    ActivatePhysics(activeCrate)
    SetDamping(activeCrate, 2, 0.1)
    SetEntityVelocity(activeCrate, 0.0, 0.0, -0.3)

    activeParachute = CreateObject(GetHashKey(models[1]), Coords, false, true, true)
    SetEntityLodDist(activeParachute, 10000)
    SetEntityVelocity(activeParachute, 0.0, 0.0, -0.3)
    ActivatePhysics(activeCrate)
    AttachEntityToEntity(activeParachute, activeCrate, 0, 0.0, 0.0, 0.1, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
    radiusBlip = AddBlipForRadius(Coords, 200.0)
    SetBlipColour(radiusBlip, 1)
    SetBlipAlpha(radiusBlip, 180)

    crateBlip = AddBlipForEntity(activeCrate)
    SetBlipSprite(crateBlip, 501)
    SetBlipColour(crateBlip, 2)
    

    while GetEntityHeightAboveGround(activeCrate) > 2 do
        Wait(100)
    end

    soundID = GetSoundId()
    PlaySoundFromEntity(soundID, "Crate_Beeps", activeCrate, "MP_CRATE_DROP_SOUNDS", true, 0) --When the crate is nearby it beeps remove if you want
    DetachEntity(activeParachute, true, true)
    DeleteEntity(activeParachute)
    ShootSingleBulletBetweenCoords(GetEntityCoords(activeCrate),GetEntityCoords(activeCrate) - vector3(0.0001, 0.0001, 0.0001),0,false,"weapon_flare",0,true,false,-1.0)

    Citizen.CreateThread(function()
        while (true) do
            Citizen.Wait(0)

            local boxCoords = GetEntityCoords(activeCrate)
            local playerCoords = GetEntityCoords(PlayerPedId())

            if #(boxCoords - playerCoords) < 2.0 then
                if (IsControlJustPressed(1, 51)) then
                    if IsPedInAnyVehicle(GetPlayerPed(-1), false) == false then
                        LoadAnimDict('amb@medic@standing@kneel@base')
                        LoadAnimDict('anim@gangops@facility@servers@bodysearch@')
                        TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
                        TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )
                        notify("~g~Looting Crate Drop...")
                        exports.rprogress:Start("", 10000)
                        ClearPedTasksImmediately(PlayerPedId())
                        if IsPedInAnyVehicle(GetPlayerPed(-1), false) == false then
                            if IsPedDeadOrDying(PlayerPedId(), true) == false then
                                TriggerServerEvent('openLootCrate', boxCoords, playerCoords)
                                StopSound(soundID)
                                ReleaseSoundId(soundID)
                            else
                                notify("~r~You are Dead!")
                            end
                        else

                        notify("~r~You cannot loot while in a Vehicle!")
                        end
                    else

                        notify("~r~You cannot loot while in a Vehicle!")
                    end

                end
            end
        end
    end)
end)

function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
      RequestAnimDict(dict)
      Citizen.Wait(5)
    end
end

function notify(string)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(string)
    DrawNotification(true, false)
end



RegisterNetEvent("removeCrate")
AddEventHandler("removeCrate", function()
    if activeCrate then
        if DoesEntityExist(activeCrate) then
            DeleteEntity(activeCrate)
        end
        if DoesEntityExist(activeParachute) then
            DeleteEntity(activeParachute)
        end
        SetTimeout(300000,function()
            RemoveBlip(radiusBlip)
            RemoveBlip(crateBlip)
        end)
        StopSound(soundID)
        ReleaseSoundId(soundID)
    end
end)
