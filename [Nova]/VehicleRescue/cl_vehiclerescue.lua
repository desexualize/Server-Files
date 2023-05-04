TriggerEvent('chat:addSuggestion', '/jack', 'Use an inflatable jack on the nearest vehicle', {
    { name="setup/remove", help="Setup or remove an inflatable jack" },
})

TriggerEvent('chat:addSuggestion', '/chock', 'Use a car chock on the nearest vehicle', {
    { name="setup/remove", help="Setup or remove a car chock" },
})

local carJacks = {}
local carChocks = {}
local usingCarJack = false

local modelHash = `prop_inflatable_jack`
local chockModelHash = `prop_air_chock_04`

RegisterNetEvent('Client:updateJackTable')
AddEventHandler('Client:updateJackTable', function(key, entry, remove)
    if remove then 
        carJacks[key] = nil
        return 
    end
    carJacks[key] = entry
end)

RegisterNetEvent('Client:updateChockTable')
AddEventHandler('Client:updateChockTable', function(key, entry, remove)
    if remove then
        carChocks[key] = nil
        return
    end
    carChocks[key] = entry
end)

RegisterNetEvent('Client:receiveChockTable')
AddEventHandler('Client:receiveChockTable', function(table)
    carChocks = table
end)

RegisterNetEvent('Client:receiveJackTable')
AddEventHandler('Client:receiveJackTable', function(table)
    carJacks = table
end)

AddEventHandler('playerSpawned', function()
    TriggerServerEvent('Server:receiveJackTable')
    TriggerServerEvent('Server:receiveChockTable')
end)

RegisterNetEvent('Client:jackNotification')
AddEventHandler('Client:jackNotification', function(message)
    showNotification(message)
end)

function raycast()
    local ped = PlayerPedId()
    local location = GetEntityCoords(ped)
    local offSet = GetOffsetFromEntityInWorldCoords(ped, 0.0, 10.0, 0.0)
    local shapeTest = StartShapeTestCapsule(location.x, location.y, location.z, offSet.x, offSet.y, offSet.z, 10.0, 2, ped, 0)
    local retval, hit, endCoords, surfaceNormal, entityHit =
    GetShapeTestResult(shapeTest)
    return entityHit
end

RegisterNetEvent('Client:toggleJack')
AddEventHandler('Client:toggleJack', function(setup)
    local vehicle = raycast()
    if vehicle ~= 0 and vehicle ~= nil then
        local netId = NetworkGetNetworkIdFromEntity(vehicle)
        local tableIncludes = tableHas(carJacks, netId)
        local inUse = false
        if tableIncludes then
            inUse = carJacks[netId][5]
        end
        if usingCarJack then
            showNotification("~r~Error~w~: You are currently using a jack. Press ENTER to stop.")
            return
        end
        if setup then
            if tableIncludes then
                if not inUse then
                    carJacks[netId][5] = true
                    TriggerServerEvent('Server:updateJackTable', netId, carJacks[netId], false)
                    local airbag1 = NetworkGetEntityFromNetworkId(carJacks[netId][2])
                    local airbag2 = NetworkGetEntityFromNetworkId(carJacks[netId][3])
                    requestControl(200, airbag1)
                    showNotification("~g~Success~w~: You're now controlling the inflatable jack")
                    handleLifting(vehicle, netId, airbag1)
                else
                    showNotification("~r~Error~w~: This inflatable jack is in use")
                end
            else
                local coords1 = GetOffsetFromEntityInWorldCoords(vehicle, -0.7, 0.0, 0.0)
                local coords2 = GetOffsetFromEntityInWorldCoords(vehicle, 0.7, 0.0, 0.0)
                RequestModel(modelHash)
                while not HasModelLoaded(modelHash) do Wait(0) end
                local airbag1 = CreateObject(modelHash, coords1.x, coords1.y, coords1.z, true, true, true)
                local airbag2 = CreateObject(modelHash, coords2.x, coords2.y, coords2.z, true, true, true)
                while not DoesEntityExist(airbag1) or not DoesEntityExist(airbag2) do Wait(0) end
                local heading = GetEntityHeading(vehicle)
                SetEntityHeading(airbag1, heading)
                SetEntityHeading(airbag2, heading + 180.0)
                SetEntityCollision(airbag1, false, true)
                SetEntityCollision(airbag2, false, true)
                PlaceObjectOnGroundProperly(airbag1)
                PlaceObjectOnGroundProperly(airbag2)
                FreezeEntityPosition(airbag1, true)
                FreezeEntityPosition(airbag2, true)
                local airbag1Net = NetworkGetNetworkIdFromEntity(airbag1)
                local airbag2Net = NetworkGetNetworkIdFromEntity(airbag2)
                carJacks[netId] = {netId, airbag1Net, airbag2Net, -0.3, true}
                TriggerServerEvent('Server:updateJackTable', netId, carJacks[netId], false)
                SetModelAsNoLongerNeeded(modelHash)
                showNotification("~g~Success~w~: Inflatable jack setup")
                handleLifting(vehicle, netId, airbag1)
            end
        else
            if tableIncludes then
                if inUse then
                    showNotification("~r~Error~w~: This inflatable jack is in use")
                else
                    local airbag1 = NetworkGetEntityFromNetworkId(carJacks[netId][2])
                    local airbag2 = NetworkGetEntityFromNetworkId(carJacks[netId][3])
                    TriggerServerEvent('Server:updateJackTable', netId, carJacks[netId], true)
                    if DoesEntityExist(airbag1) then
                        requestControl(50, airbag1)
                        DeleteEntity(airbag1)
                    end
                    if DoesEntityExist(airbag2) then
                        requestControl(50, airbag2)
                        DeleteEntity(airbag2)
                    end
                    NetworkRequestControlOfEntity(vehicle)
                    FreezeEntityPosition(vehicle, false)
                    DetachEntity(vehicle)
                    carJacks[netId] = nil
                    showNotification("~g~Success~w~: Inflatable jack removed")
                end
            else
                showNotification("~r~Error~w~: No inflatable jack found") 
            end
        end
    else
        showNotification("~r~Error~w~: No vehicle found")
    end
end)

RegisterNetEvent('Client:toggleChockWheels')
AddEventHandler('Client:toggleChockWheels', function(netId)
    local vehicle = NetworkGetEntityFromNetworkId(netId)
    if DoesEntityExist(vehicle) then
        ResetVehicleWheels(vehicle, true)
    end
end)

RegisterNetEvent('Client:toggleChock')
AddEventHandler('Client:toggleChock', function(setup)
    local vehicle = raycast()
    if vehicle ~= 0 and vehicle ~= nil then
        local netId = NetworkGetNetworkIdFromEntity(vehicle)
        local tableIncludes = tableHas(carChocks, netId)
        if setup then
            if tableIncludes then
                showNotification("~r~Error~w~: This vehicle already has chocks setup")
            else
                local coords1 = GetEntityCoords(vehicle)
                ResetVehicleWheels(vehicle, true)
                RequestModel(chockModelHash)
                while not HasModelLoaded(chockModelHash) do Wait(0) end
                TriggerServerEvent('Server:toggleChockWheels', netId)
                local chock1 = CreateObject(chockModelHash, coords1.x, coords1.y, coords1.z, true, true, true)
                local chock2 = CreateObject(chockModelHash, coords1.x, coords1.y, coords1.z, true, true, true)
                local chock3 = CreateObject(chockModelHash, coords1.x, coords1.y, coords1.z, true, true, true)
                local chock4 = CreateObject(chockModelHash, coords1.x, coords1.y, coords1.z, true, true, true)
                while not DoesEntityExist(chock1) or not DoesEntityExist(chock2) or not DoesEntityExist(chock3) or not DoesEntityExist(chock4) do Wait(0) end
                local heading = GetEntityHeading(vehicle)
                local frontLeft = GetEntityBoneIndexByName(vehicle, "wheel_lf")
                local backLeft = GetEntityBoneIndexByName(vehicle, "wheel_lr")
                local frontRight = GetEntityBoneIndexByName(vehicle, "wheel_rf")
                local backRight = GetEntityBoneIndexByName(vehicle, "wheel_rr")
                FreezeEntityPosition(chock1, true)
                FreezeEntityPosition(chock2, true)
                FreezeEntityPosition(chock3, true)
                FreezeEntityPosition(chock4, true)
                AttachEntityToEntity(chock1, vehicle, frontLeft, -0.05, 0.25, -0.29, 0.0, 0.0, 90.0, true, false, true, false, 1, true)
                AttachEntityToEntity(chock3, vehicle, frontRight, -0.05, 0.25, 0.29, 180.0, 0.0, -270.0, true, false, true, false, 1, true)
                AttachEntityToEntity(chock2, vehicle, backLeft, -0.05, -0.25, -0.29, 0.0, 0.0, -90.0, true, false, true, false, 1, true)
                AttachEntityToEntity(chock4, vehicle, backRight, -0.05, -0.25, 0.29, 180.0, 0.0, -90.0, true, false, true, false, 1, true)
                SetEntityCollision(chock1, false, true)
                SetEntityCollision(chock2, false, true)
                SetEntityCollision(chock3, false, true)
                SetEntityCollision(chock4, false, true)
                local chock1Net = NetworkGetNetworkIdFromEntity(chock1)
                net(chock1Net)
                local chock2Net = NetworkGetNetworkIdFromEntity(chock2)
                net(chock2Net)
                local chock3Net = NetworkGetNetworkIdFromEntity(chock3)
                net(chock3Net)
                local chock4Net = NetworkGetNetworkIdFromEntity(chock4)
                net(chock4Net)
                carChocks[netId] = {netId, chock1Net, chock2Net, chock3Net, chock4Net}
                TriggerServerEvent('Server:updateChockTable', netId, carChocks[netId], false)
                SetModelAsNoLongerNeeded(chockModelHash)
                TaskGoStraightToCoord(PlayerPedId(), coords1.x, coords1.y, coords1.z, 30.0, 0.5, 0.0, 10.0)
                Wait(2000)
                FreezeEntityPosition(vehicle, true)
                showNotification("~g~Success~w~: Car chocks setup")
            end
        else
            if tableIncludes then
                NetworkRequestControlOfEntity(vehicle)
                Wait(2000)
                local chock1 = NetworkGetEntityFromNetworkId(carChocks[netId][2])
                local chock2 = NetworkGetEntityFromNetworkId(carChocks[netId][3])
                local chock3 = NetworkGetEntityFromNetworkId(carChocks[netId][4])
                local chock4 = NetworkGetEntityFromNetworkId(carChocks[netId][5])
                Wait(1000)
                if DoesEntityExist(chock1) then DeleteEntity(chock1) end
                if DoesEntityExist(chock2) then DeleteEntity(chock2) end
                if DoesEntityExist(chock3) then DeleteEntity(chock3) end
                if DoesEntityExist(chock4) then DeleteEntity(chock4) end
                TriggerServerEvent('Server:updateChockTable', netId, carChocks[netId], true)
                FreezeEntityPosition(vehicle, false)
                showNotification("~g~Success~w~: Car chocks removed")
            else
                showNotification("~r~Error~w~: No car chocks found") 
            end
        end
    else
        showNotification("~r~Error~w~: No vehicle found")
    end
end)


function net(id)
    SetNetworkIdExistsOnAllMachines(id, true)
    SetNetworkIdCanMigrate(id, false)
end

function handleLifting(vehicle, netId, airbag1)
    usingCarJack = true
    showHelpNotification("Use ~INPUT_CELLPHONE_UP~ and ~INPUT_CELLPHONE_DOWN~ to adjust the height")
    showNotification("~g~Success~w~: Use ARROW UP and ARROW DOWN to adjust the height. Press ENTER when done")
    local zAxis = carJacks[netId][4]
    carJacks[netId][5] = true
    DetachEntity(vehicle)
    NetworkRequestControlOfEntity(vehicle)
    while usingCarJack do
        DisableControlAction(0, 172, true)
        DisableControlAction(0, 173, true)
        if IsDisabledControlJustPressed(0, 172) then
            zAxis = zAxis + 0.007
            if zAxis > 0.8 then
                zAxis = 0.8
            end
            DetachEntity(vehicle)
            AttachEntityToEntity(vehicle, airbag1, -1, 0.7, 0.0, zAxis, 0.0, 0.0, 0.0, true, false, true, false, 1, true)
        end
        if IsDisabledControlJustPressed(0, 173) then
            zAxis = zAxis - 0.007
            if zAxis < -0.7 then
                zAxis = -0.7
            end
            DetachEntity(vehicle)
            AttachEntityToEntity(vehicle, airbag1, -1, 0.7, 0.0, zAxis, 0.0, 0.0, 0.0, true, false, true, false, 1, true)
        end
        if IsDisabledControlJustPressed(0, 215) then
            FreezeEntityPosition(vehicle, true)
            carJacks[netId][5] = false
            carJacks[netId][4] = zAxis
            TriggerServerEvent('Server:updateJackTable', netId, carJacks[netId], false)
            showNotification("~g~Success~w~: You've stopped controlling the inflatable jack")
            usingCarJack = false
        end
        Wait(0)
    end
end

function requestControl(totalTicks, entity)
    if not NetworkHasControlOfEntity(entity) then
        NetworkRequestControlOfEntity(entity)
        local ticks = 0
        while ticks < totalTicks do
            if NetworkHasControlOfEntity(entity) then 
                ticks = totalTicks
            end
            ticks = ticks + 1
            Wait(0)
        end
    end
end

function getNearestVehicle(radius)
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local vehicle = GetVehiclePedIsIn(ped, false)
    if vehicle ~= 0 then return vehicle end
    local veh = GetClosestVehicle(coords.x+0.0001,coords.y+0.0001,coords.z+0.0001, radius+5.0001, 0, 8192+4096+4+2+1)
    if not IsEntityAVehicle(veh) then veh = GetClosestVehicle(coords.x+0.0001,coords.y+0.0001,coords.z+0.0001, radius+5.0001, 0, 4+2+1) end
    return veh
end

function showNotification(message)
    message = message.."."
    SetNotificationTextEntry("STRING")
    AddTextComponentString(message)
    DrawNotification(0,1)
end

function showHelpNotification(message)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(msg)
    DrawNotification(1, 0)
end

function tableHas(table, key)
    for k, v in pairs(table) do
        if k == key and v ~= nil then
            return true
        end
    end
    return false
end