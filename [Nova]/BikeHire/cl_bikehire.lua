local configLoaded = false
local idRequested = 0

local cooldown = false

Citizen.CreateThread(function()
    RequestModel(model.dock)
    while not HasModelLoaded(model.dock) do Wait(0) end
    RequestModel(model.machine)
    while not HasModelLoaded(model.machine) do Wait(0) end
    for k, v in pairs(locations) do
        for y, u in pairs(v.docks) do
            locations[k].docks[y].prop = CreateObject(model.dock, u.coords.x, u.coords.y, u.coords.z, false, false, true)
            while not DoesEntityExist(locations[k].docks[y].prop) do Wait(0) end
            local coords = GetEntityCoords(locations[k].docks[y].prop)
            SetEntityCoords(locations[k].docks[y].prop, coords.x, coords.y, coords.z, true, true, true, true)
            FreezeEntityPosition(locations[k].docks[y].prop, true)
            SetEntityHeading(locations[k].docks[y].prop, u.heading)
            locations[k].docks[y].available = true
            locations[k].docks[y].offSet = GetOffsetFromEntityInWorldCoords(locations[k].docks[y].prop, 1.0, 0.0, 0.5)
        end
        locations[k].machine.prop = CreateObject(model.machine, v.machine.coords.x, v.machine.coords.y, v.machine.coords.z, false, false, true)
        while not DoesEntityExist(locations[k].machine.prop) do Wait(0) end
        if main.enableBlips then
            locations[k].blip = AddBlipForEntity(locations[k].machine.prop)
            local blip = locations[k].blip
            SetBlipSprite(blip, main.blip)
            SetBlipDisplay(main.blip, main.blipDisplay)
            SetBlipScale(blip, main.blipScale)
            SetBlipColour(blip, main.blipColour)
            SetBlipAsShortRange(blip, main.blipShortRange)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(main.blipName)
            EndTextCommandSetBlipName(blip)
        end
        local coords = GetEntityCoords(locations[k].machine.prop)
        SetEntityCoords(locations[k].machine.prop, coords.x, coords.y, coords.z, true, true, true, true)
        FreezeEntityPosition(locations[k].machine.prop, true)
        SetEntityHeading(locations[k].machine.prop, v.machine.heading)
    end
    SetModelAsNoLongerNeeded(model.dock)
    SetModelAsNoLongerNeeded(model.machine)
    configLoaded = true
    TriggerServerEvent("Server:receiveHiredBikes")
    Wait(5000)
    while true do
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        for k, v in pairs(locations) do
            local distance = #(coords - v.machine.coords)
            if distance < main.spawnBikeInDistance then
                if not v.spawnedIn then
                    spawnBikesIn(k)
                end
            else
                if v.spawnedIn then
                    removeBikes(k)
                end
            end
            local onBike = false
            if distance < 15.0 then
                local vehicle = GetVehiclePedIsIn(ped, false)
                if vehicle ~= 0 and GetEntityModel(vehicle) == model.bike then
                    onBike = true
                    local found = false
                    local returnDock = 0
                    local nativeVehicle = false
                    for y, u in pairs(v.docks) do
                        if u.vehicle == vehicle and v.available then
                            nativeVehicle = true
                        end
                    end

                    if not nativeVehicle then
                        for y, u in pairs(v.docks) do
                            local distance = #(coords - u.offSet)
                            if distance < main.returnDetectionDistance then
                                if not u.available and not IsEntityAttachedToEntity(vehicle, u.prop )then
                                    found = true
                                    returnDock = y
                                end
                            end
                        end
                        if found then
                            displayHelpText(translations.press.." ~"..translations.returnKey.."~ "..translations.toReturn)
                            local timeout = false
                            local pressed = false
                            Citizen.SetTimeout(5000, function()
                                timeout = true
                            end)
                            while not timeout do
                                DisableControlAction(main.returnKey[1], main.returnKey[2], true)
                                if IsDisabledControlJustPressed(main.returnKey[1], main.returnKey[2]) then
                                    locations[k].docks[returnDock].vehicle = vehicle
                                    TaskLeaveVehicle(ped, vehicle, 16)
                                    AttachEntityToEntity(locations[k].docks[returnDock].vehicle, locations[k].docks[returnDock].prop, -1, 1.0, 0.0, 0.5, 0.0, 0.0, 90.0, true, true, true, false, 1, true)
                                    ResetVehicleWheels(locations[k].docks[returnDock].vehicle, true)
                                    SetVehicleSteeringAngle(locations[k].docks[returnDock].vehicle, 0.0)
                                    PlaySoundFrontend(-1, "Beep_Green", "DLC_HEIST_HACKING_SNAKE_SOUNDS")
                                    TriggerServerEvent("Server:bikeHired", k, returnDock, true)
                                end
                                Wait(0)
                            end
                        end
                    end
                end
            end
            if not onBike then
                if v.spawnedIn and distance < main.machineUsageDistance then
                    local availableBike = false
                    for y, u in pairs(v.docks) do
                        if u.available then
                            availableBike = true 
                            break
                        end
                    end
                    if availableBike then
                        displayHelpText(translations.press.." ~"..translations.machineKey.."~ "..translations.toHire)
                        local timeout = false
                        local pressed = false
                        Citizen.SetTimeout(5000, function()
                            timeout = true
                        end)
                        while not timeout do
                            DisableControlAction(main.machineKey[1], main.machineKey[2], true)
                            if IsDisabledControlJustPressed(main.machineKey[1], main.machineKey[2]) then
                                if main.hireCooldown and cooldown then
                                    showNotification(translations.cooldown)
                                else
                                    if main.enableAnimation then
                                        RequestAnimDict(main.animDict)
                                        while not HasAnimDictLoaded(main.animDict) do Wait(0) end
                                        TaskPlayAnim(ped, main.animDict, main.animName, 8.0, -8.0, -1, 0, 0.0, 0, 0, 0)
                                        Wait(4000)
                                        PlaySoundFrontend(-1, "CONFIRM_BEEP", "HUD_MINI_GAME_SOUNDSET")
                                        ClearPedTasks(ped)
                                    end
                                    idRequested = k
                                    TriggerServerEvent("Server:hireBike")
                                end
                            end
                            Wait(0)
                        end
                    else
    
                    end
                end
            end
        end
        Wait(0)
    end
end)

function resetSpawnedBikes()
    for k, v in pairs(locations) do
        local count = 0
        for y, u in pairs(locations[k].docks) do
            if u.available then
                count = count + 1
                if DoesEntityExist(u.vehicle) then
                    DetachEntity(u.vehicle)
                    DeleteEntity(u.vehicle)
                end
            else
                if DoesEntityExist(u.vehicle) then
                    local ped = GetPedInVehicleSeat(u.vehicle, -1)
                    if ped == nil or ped == 0 or ped == -1 then
                        DetachEntity(u.vehicle)
                        DeleteEntity(u.vehicle)
                    end
                end
            end
        end
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(main.blipName..tostring(count))
        EndTextCommandSetBlipName(locations[k].blip)
        locations[k].spawnedIn = false
    end
end

RegisterNetEvent("Client:bikeHired")
AddEventHandler("Client:bikeHired", function(id1, id2, available)
    if locations[id1].spawnedIn then
        if DoesEntityExist(locations[id1].docks[id2].vehicle) then
            DetachEntity(locations[id1].docks[id2].vehicle)
            DeleteEntity(locations[id1].docks[id2].vehicle)
        end
    end
    locations[id1].docks[id2].available = available
    resetSpawnedBikes()
end)

local first_spawn = false
AddEventHandler('playerSpawned', function()
    if not first_spawn then
        TriggerServerEvent('Server:receiveHiredBikes')
        first_spawn = true
    end
end)

RegisterNetEvent("Client:receiveHiredBikes")
AddEventHandler("Client:receiveHiredBikes", function(bikesHired)
    for k, v in pairs(bikesHired) do
        if v[3] ~= nil and not v[3] then
            locations[v[1]].docks[v[2]].available = false
        end
    end
end)

RegisterNetEvent("Client:hireBike")
AddEventHandler("Client:hireBike", function(perms)
    if locations[idRequested].spawnedIn then
        local found = false
        local coords = nil
        local vehicleTarget = 0
        local targetId = 0
        for k, v in pairs(locations[idRequested].docks) do
            if v.available then
                found = true
                coords = v.coords
                vehicleTarget = v.vehicle
                targetId = k
                TriggerServerEvent("Server:bikeHired", idRequested, k, false)
                break
            end
        end
        if found then
            cooldown = true
            if main.hireCooldown then
                Citizen.SetTimeout(main.hireCooldownTime * 10000, function()
                    cooldown = false
                end)
            end
            showNotification(translations.bikeHired)
            local timeout = false
            Citizen.SetTimeout(10000, function()
                timeout = true
            end)
            local ped = PlayerPedId()
            if DoesEntityExist(locations[idRequested].docks[targetId].vehicle) then
                DetachEntity(locations[idRequested].docks[targetId].vehicle)
                DeleteEntity(locations[idRequested].docks[targetId].vehicle)
            end
            Wait(2000)
            locations[idRequested].docks[targetId].vehicle = CreateVehicle(model.bike, locations[idRequested].docks[targetId].coords, locations[idRequested].docks[targetId].heading, true, true)
            while not DoesEntityExist(locations[idRequested].docks[targetId].vehicle) do Wait(0) end
            AttachEntityToEntity(locations[idRequested].docks[targetId].vehicle, locations[idRequested].docks[targetId].prop, -1, 1.0, 0.0, 0.5, 0.0, 0.0, 90.0, true, true, true, false, 1, true)
            ResetVehicleWheels(locations[idRequested].docks[targetId].vehicle, true)
            SetVehicleSteeringAngle(locations[idRequested].docks[targetId].vehicle, 0.0)
            SetVehicleColours(locations[idRequested].docks[targetId].vehicle, 18, 1)
            vehicleTarget = locations[idRequested].docks[targetId].vehicle
            while not timeout do
                DrawMarker(1, coords.x, coords.y, coords.z, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 1.5, 38, 255, 0, 150, 0, 0, 0, 0)
                local vehicle = GetVehiclePedIsIn(ped, false)
                if vehicle == vehicleTarget then
                    PlaySoundFrontend(-1, "Beep_Green", "DLC_HEIST_HACKING_SNAKE_SOUNDS")
                    DetachEntity(vehicleTarget) 
                    timeout = true
                end
                Wait(0)
            end
            DetachEntity(vehicleTarget) 
        else
            showNotification(translations.noneLeft)
        end
    end
end)

function spawnBikesIn(id)
    RequestModel(model.bike)
    while not HasModelLoaded(model.bike) do Wait(0) end
    for k, v in pairs(locations[id].docks) do
        if v.available then 
            locations[id].docks[k].vehicle = CreateVehicle(model.bike, locations[id].docks[k].coords, locations[id].docks[k].heading, false, false)
            while not DoesEntityExist(locations[id].docks[k].vehicle) do Wait(0) end
            AttachEntityToEntity(locations[id].docks[k].vehicle, locations[id].docks[k].prop, -1, 1.0, 0.0, 0.5, 0.0, 0.0, 90.0, true, true, true, false, 1, true)
            ResetVehicleWheels(locations[id].docks[k].vehicle, true)
            SetVehicleSteeringAngle(locations[id].docks[k].vehicle, 0.0)
            locations[id].spawnedIn = true
            SetVehicleColours(locations[id].docks[k].vehicle, 18, 1)
        end
    end
end

function displayHelpText(message)
    SetTextComponentFormat('STRING')
    AddTextComponentString(message)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function removeBikes(id)
    for k, v in pairs(locations[id].docks) do
        if v.available then
            if DoesEntityExist(v.vehicle) then
                DetachEntity(v.vehicle)
                DeleteEntity(v.vehicle)
            end
        else
            if DoesEntityExist(v.vehicle) then
                if IsEntityAttachedToEntity(v.vehicle, v.prop) then
                    DetachEntity(v.vehicle)
                    DeleteEntity(v.vehicle)
                end
            end
        end
    end
    locations[id].spawnedIn = false
end

RegisterNetEvent("Client:bikeNotification")
AddEventHandler("Client:bikeNotification", function(message)
    showNotification(message)
end)

function showNotification(message)
    message = message.."."
    SetNotificationTextEntry("STRING")
    AddTextComponentString(message)
    DrawNotification(0,1)
end