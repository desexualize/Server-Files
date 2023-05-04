local models = {"p_cargo_chute_s", "prop_drop_crate_01_set2"} --What models the first one is the parachute and the second one is the brief case
local Active_Crate = nil
local Active_Parachute = nil

local Crate_Landed_Message = 'The airdrop has landed on the ground!'

local Crate_Blip = nil
local Radius_Blip = nil
local Sound_ID = nil

local function Load_Model(modelName)
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

local function Load_Anim_Dict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

local function notify(string)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(string)
    EndTextCommandThefeedPostTicker(true, false)
end

RegisterNetEvent("Nova:Client:NewCrateDrop")
AddEventHandler("Nova:Client:NewCrateDrop", function(Coords)
    if Active_Crate ~= nil then
        TriggerEvent("Nova:Client:RemoveCrate")
    end

    for k, v in pairs(models) do
        Load_Model(v)
    end

    Active_Crate = CreateObject(GetHashKey(models[2]), Coords, false, true, true)

    SetEntityLodDist(Active_Crate, 10000)
    ActivatePhysics(Active_Crate)
    SetDamping(Active_Crate, 2, 0.1)
    SetEntityVelocity(Active_Crate, 0.0, 0.0, -0.3)

    Active_Parachute = CreateObject(GetHashKey(models[1]), Coords, false, true, true)
    SetEntityLodDist(Active_Parachute, 10000)
    SetEntityVelocity(Active_Parachute, 0.0, 0.0, -0.3)
    ActivatePhysics(Active_Crate)
    AttachEntityToEntity(Active_Parachute, Active_Crate, 0, 0.0, 0.0, 0.1, 0.0, 0.0, 0.0, false, false, false, false, 2, true)

    Crate_Blip = AddBlipForEntity(Active_Crate)
    SetBlipSprite(Crate_Blip, 478)
    SetBlipColour(Crate_Blip, 1)

    Radius_Blip = AddBlipForRadius(Coords, 200.0)
    SetBlipColour(Radius_Blip, 1)
    SetBlipAlpha(Radius_Blip, 180)

    while GetEntityHeightAboveGround(Active_Crate) > 2 do
        Citizen.Wait(500)
    end
    TriggerEvent('chatMessage', '[Nova]:', {255, 255, 255}, Crate_Landed_Message, 'alert')

    Sound_ID = GetSoundId()
    PlaySoundFromEntity(Sound_ID, "Crate_Beeps", Active_Crate, "MP_CRATE_DROP_SOUNDS", true, 0) --When the crate is nearby it beeps remove if you want
    DetachEntity(Active_Parachute, true, true)
    DeleteEntity(Active_Parachute)

    while Active_Crate ~= nil do
        local client_ped = PlayerPedId()
        local client_coords = GetEntityCoords(client_ped)
        local crate_coords = GetEntityCoords(Active_Crate)

        if #(crate_coords - client_coords) < 2.0 then
            if IsControlJustPressed(0, 51) or IsDisabledControlJustPressed(0, 51) then
                if GetVehiclePedIsIn(client_ped, false) == 0 then
                    if not IsPedDeadOrDying(client_ped, true) then
                        Load_Anim_Dict('amb@medic@standing@kneel@base')
                        Load_Anim_Dict('anim@gangops@facility@servers@bodysearch@')

                        TaskPlayAnim(client_ped, "amb@medic@standing@kneel@base", "base", 8.0, -8.0, -1, 1, 0, false, false, false)
                        TaskPlayAnim(client_ped, "anim@gangops@facility@servers@bodysearch@", "player_search", 8.0, -8.0, -1, 48, 0, false, false, false)

                        notify("~g~Looting Crate Drop...")
                        TriggerServerEvent('Nova:Server:CrateBeingLooted')

                        exports.rprogress:Start("", 15000)
                        ClearPedTasksImmediately(client_ped)
            
                        TriggerServerEvent('Nova:Server:OpenLootCrate', client_coords, crate_coords)
                    else
                        notify("~r~You are Dead!")
                    end
                else
                    notify("~r~You cannot loot while in a Vehicle!")
                end
            end
        end

        Citizen.Wait(0)
    end
end)

RegisterNetEvent("Nova:Client:RemoveCrate")
AddEventHandler("Nova:Client:RemoveCrate", function()
    if Active_Crate then
        if DoesEntityExist(Active_Crate) then
            DeleteEntity(Active_Crate)
        end
        Active_Crate = nil

        if DoesEntityExist(Active_Parachute) then
            DeleteEntity(Active_Parachute)
        end

        RemoveBlip(Radius_Blip)
        RemoveBlip(Crate_Blip)
        
        StopSound(Sound_ID)
        ReleaseSoundId(Sound_ID)
    end
end)