TriggerEvent('chat:addSuggestion', '/'..main.commandName, translations.commandSuggestion, {
    { name=translations.setup.."/"..translations.remove, help=translations.help },
})

local supplyLine = {}

local connected = false
local connectedSupply = 0
local hoseActivated = false
local timer = 0

local hoseEnabled = false

local usedUp = {}

RegisterNetEvent('Client:HoseCommandEnabled')
AddEventHandler('Client:HoseCommandEnabled', function(enabled)
    hoseEnabled = true
    if timer > 0 or connected then
        TriggerEvent("Client:SupplyLeft", true)  
    end
end)

RegisterNetEvent('Client:HoseCommandDisabled')
AddEventHandler('Client:HoseCommandDisabled', function(enabled)
    hoseEnabled = false
end)

function displayHelpText(message)
    SetTextComponentFormat('STRING')
    AddTextComponentString(message)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

Citizen.CreateThread(function()
    while true do
        if hoseEnabled then
            if hoseActivated then
                if not connected then
                    if timer < 1 then
                        timer = 0
                        TriggerEvent("Client:SupplyLeft", false)
                        showNotification(translations.noSupply)
                    end
                    timer = timer - 1
                end
                Wait(1000)
            end
            local percentage = (timer / main.defaultSeconds) * 100
            percentage = math.floor(percentage+0.5)
            if percentage == -1 then
                percentage = 0
            end
            drawSubtitle(translations.supplyLine..tostring(percentage).."/"..translations.oneHundred.." %")
            if not connected then
                local ped = PlayerPedId()
                local coords = GetEntityCoords(ped)
                if not IsPedInAnyVehicle(ped, true) then
                    local vehicle = raycast()
                    local found = false
                    for k, v in pairs(supplyLine) do
                        local distance = #(coords - v[3])
                        if distance < main.supplyLineDistance then
                            local finished = false
                            Citizen.SetTimeout(5000, function()
                                finished = true
                            end)
                            displayHelpText(translations.press.."~"..main.helpKey.."~ "..translations.toConnect)
                            while not finished do
                                DisableControlAction(main.connectToSupplyLineKey[1], main.connectToSupplyLineKey[2], true)
                                if IsDisabledControlJustPressed(main.connectToSupplyLineKey[1], main.connectToSupplyLineKey[2]) then
                                    connected = true
                                    connectedSupply = k
                                    showNotification(translations.supplyLineConnected)
                                    finished = true
                                    timer = main.defaultSeconds
                                    break
                                end
                                Wait(0)
                            end
                        end
                    end
                    if not connected then
                        if vehicle ~= 0 and vehicle ~= nil then
                            local model = GetEntityModel(vehicle)
                            local found1 = false
                            for k, v in pairs(vehicles) do
                                if v.model == model then
                                    found1 = true
                                    break
                                end
                            end
                            if found1 then
                                local netId = NetworkGetNetworkIdFromEntity(vehicle)
                                local found2 = false
                                for k in pairs(usedUp) do
                                    if netId == usedUp[k] then
                                        found2 = true
                                    end
                                end
                                if not found2 then
                                    if timer < 1 then
                                        timer = main.defaultSeconds
                                        table.insert(usedUp, netId)
                                        showNotification(translations.limitedSupply)
                                        TriggerEvent("Client:SupplyLeft", true)
                                    end
                                else
                                    if timer < 1 then
                                        showNotification(translations.alreadySupplied)
                                        Wait(5000)  
                                    end
                                    
                                end
                            end
                        end
                    end
                end
            else
                if connectedSupply ~= 0 then
                    if supplyLine[connectedSupply] == nil then
                        showNotification(translations.supplyLineDisconnected)
                        connected = false
                    end
                end
                if connected then
                    local ped = PlayerPedId()
                    local coords = GetEntityCoords(ped)
                    local distance = #(coords - supplyLine[connectedSupply][3])
                    if distance > main.maximumDistance then
                        connected = false
                        connectedSupply = 0
                        showNotification(translations.supplyLineDisconnected)
                    end
                end
            end
        end
        Wait(1000)
    end
end)

function drawSubtitle(message)
    SetTextEntry_2("STRING")
    AddTextComponentString(message)
    EndTextCommandPrint(3000, 1)
end

RegisterNetEvent('Client:HoseActivated')
AddEventHandler('Client:HoseActivated', function()
    hoseActivated = true
    if connected then
        if supplyLine[connectedSupply] == nil then
            showNotification(translations.supplyLineDisconnected)
            connected = false
        end
    end
    if not connected then
        local vehicle = raycast()
        if timer < 1 then
            TriggerEvent("Client:SupplyLeft", false)
            showNotification(translations.noSupply)
        else
            continueHose() 
        end
    end
end)

function continueHose()
    if timer == 0 then
        TriggerEvent("Client:SupplyLeft", false)
        showNotification(translations.noSupply)
    end
end

RegisterNetEvent('Client:HoseDeactivated')
AddEventHandler('Client:HoseDeactivated', function()
    hoseActivated = false
end)

RegisterNetEvent('Client:updateSupplyLineTable')
AddEventHandler('Client:updateSupplyLineTable', function(key, entry, remove)
    if remove then 
        supplyLine[key] = nil
        return 
    end
    supplyLine[key] = entry
    if usedUp[key] ~= nil then
        table.remove(usedUp, key)
    end
end)

RegisterNetEvent('Client:receiveSupplyLineTable')
AddEventHandler('Client:receiveSupplyLineTable', function(table)
    supplyLine = table
end)

AddEventHandler('playerSpawned', function()
    if not firstSpawn then
        TriggerServerEvent('Server:receiveSupplyLineTable')
        first_spawn = true
    end
end)

RegisterNetEvent('Client:toggleSupplyLine')
AddEventHandler('Client:toggleSupplyLine', function(setup)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    if vehicle ~= 0 then
        showNotification(translations.outsideVehicle)
        return
    end
    local vehicle = raycast()
    if vehicle ~= 0 and vehicle ~= nil then
        local netId = NetworkGetNetworkIdFromEntity(vehicle)
        local tableIncludes = tableHas(supplyLine, netId)
        if setup then
            if tableIncludes then
                showNotification(translations.supplyLineSetupAlready)
            else
                local model = GetEntityModel(vehicle)
                local key = 0
                local found = false
                for k, v in pairs(vehicles) do
                    if v.model == model then
                        key = k
                        found = true
                        break
                    end
                end
                if found then
                    FreezeEntityPosition(vehicle, true)
                    RequestModel(main.supplyProp)
                    while not HasModelLoaded(main.supplyProp) do Wait(0) end
                    local coords = GetEntityCoords(vehicle)
                    local prop = CreateObject(main.supplyProp, coords.x, coords.y, coords.z, true, true, true)
                    while not DoesEntityExist(prop) do Wait(0) end
                    local bone = GetEntityBoneIndexByName(vehicle, vehicles[key].bone)
                    FreezeEntityPosition(prop, true)
                    AttachEntityToEntity(prop, vehicle, bone, vehicles[key].offSet[1], vehicles[key].offSet[2], vehicles[key].offSet[3], vehicles[key].rotation[1], vehicles[key].rotation[2], vehicles[key].rotation[3], true, false, true, false, 1, true)
                    Wait(1000)
                    local propNet = NetworkGetNetworkIdFromEntity(prop)
                    net(propNet)
                    supplyLine[netId] = {netId, propNet, coords}
                    TriggerServerEvent('Server:updateSupplyLineTable', netId, supplyLine[netId], false)
                    SetModelAsNoLongerNeeded(main.supplyProp)
                    showNotification(translations.supplyLineSetup)
                else
                    showNotification(translations.invalidVehicle)
                end
                
            end
        else  
            if tableIncludes then
                local prop = NetworkGetEntityFromNetworkId(supplyLine[netId][2])
                local finished = false
                Citizen.SetTimeout(5000, function()
                    finished = true
                end)
                while not finished do
                    if not NetworkHasControlOfEntity(prop) then
                        NetworkRequestControlOfEntity(prop)
                        Wait(0)
                    else
                        finished = true
                        break
                    end
                    Wait(0)
                end
                TriggerServerEvent('Server:updateSupplyLineTable', netId, supplyLine[netId], true)
                if DoesEntityExist(prop) then
                    requestControl(5000, prop)
                    DeleteEntity(prop)
                end
                NetworkRequestControlOfEntity(vehicle)
                FreezeEntityPosition(vehicle, false)
                DetachEntity(vehicle)
                supplyLine[netId] = nil
                showNotification(translations.supplyLineRemoved)
            else
                showNotification(translations.noSupplyLineFound) 
            end
        end
    else
        showNotification(translations.noVehicleFound)
    end
end)

function requestControl(milliseconds, entity)
    local timeout = false
    Citizen.SetTimeout(milliseconds, function()
        timeout = true
    end)
    if not NetworkHasControlOfEntity(entity) then
        NetworkRequestControlOfEntity(entity)
        while not timeout do
            if NetworkHasControlOfEntity(entity) then
                timeout = true
            else
                NetworkRequestControlOfEntity(entity)
            end
            Wait(0)
        end
    end
end

function net(id)
    SetNetworkIdExistsOnAllMachines(id, true)
    SetNetworkIdCanMigrate(id, false)
end

function tableHas(table, key)
    for k, v in pairs(table) do
        if k == key and v ~= nil then
            return true
        end
    end
    return false
end

function showNotification(message)
    message = message.."."
    SetNotificationTextEntry("STRING")
    AddTextComponentString(message)
    DrawNotification(0,1)
end

function raycast()
    local ped = PlayerPedId()
    local location = GetEntityCoords(ped)
    local offSet = GetOffsetFromEntityInWorldCoords(ped, 0.0, 10.0, 0.0)
    local shapeTest = StartShapeTestCapsule(location.x, location.y, location.z, offSet.x, offSet.y, offSet.z, 10.0, 2, ped, 0)
    local retval, hit, endCoords, surfaceNormal, entityHit =
    GetShapeTestResult(shapeTest)
    return entityHit
end

RegisterNetEvent('Client:supplyLineNotification')
AddEventHandler('Client:supplyLineNotification', function(message)
    showNotification(message)
end)