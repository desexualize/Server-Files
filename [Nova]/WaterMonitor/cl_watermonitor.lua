local monitors = {}
local monitorParticles = {}
local supplyLine = {}

local first_spawn = false
local has_permission = main.defaultHasPermission
local dlc = false

TriggerEvent('chat:addSuggestion', '/'..main.commandName, translations.commandSuggestion, {
    { name=translations.setup.."/"..translations.remove, help=translations.commandHelp },
})

RegisterNetEvent('Client:monitorNotification')
AddEventHandler('Client:monitorNotification', function(message)
    showNotification(message)
end)

RegisterNetEvent('Client:ActivateDLC')
AddEventHandler('Client:ActivateDLC', function(enabled)
    dlc = enabled
end)

RegisterNetEvent('Client:updateSupplyLineTable')
AddEventHandler('Client:updateSupplyLineTable', function(key, entry, remove)
    if remove then 
        supplyLine[key] = nil
        return 
    end
    supplyLine[key] = entry
end)


RegisterNetEvent('Client:receiveSupplyLineTable')
AddEventHandler('Client:receiveSupplyLineTable', function(table)
    supplyLine = table
end)

TriggerServerEvent("Server:checkUsingDlc")

function showNotification(message)
    message = message.."."
    SetNotificationTextEntry("STRING")
    AddTextComponentString(message)
    DrawNotification(0,1)
end

RegisterNetEvent('Client:adjustPitch')
AddEventHandler('Client:adjustPitch', function(key, change)
    if monitorParticles[key] ~= nil and monitorParticles[key].handle ~= nil and DoesParticleFxLoopedExist(monitorParticles[key].handle) then
        local coords = monitors[key][2]
        StopParticleFxLooped(monitorParticles[key].handle, false)
        StopParticleFxLooped(monitorParticles[key].handle2, false)
        monitorParticles[key].pitch = monitorParticles[key].pitch + change
        RequestNamedPtfxAsset("core")
        while not HasNamedPtfxAssetLoaded("core") do Wait(0) end
        UseParticleFxAssetNextCall("core")
        SetParticleFxShootoutBoat(1)
        monitorParticles[key].handle = StartParticleFxLoopedAtCoord("water_cannon_jet", coords.x, coords.y, coords.z, monitorParticles[key].pitch, 0.0, monitors[key][3], 1.0, false, false, false, false)
        monitorParticles[key].handle2 = StartParticleFxLoopedAtCoord("water_cannon_spray", coords.x, coords.y, coords.z, monitorParticles[key].pitch, 0.0, monitors[key][3], 1.0, false, false, false, false)
    end
end)

RegisterNetEvent('Client:toggleWater')
AddEventHandler('Client:toggleWater', function(key)
    if monitors[key] ~= nil then
        monitors[key][4] = not monitors[key][4]
    end
    if monitorParticles[key] ~= nil and monitorParticles[key].handle ~= nil and DoesParticleFxLoopedExist(monitorParticles[key].handle) then
        StopParticleFxLooped(monitorParticles[key].handle, false)
        StopParticleFxLooped(monitorParticles[key].handle2, false)
        monitorParticles[key] = nil
    end
    if monitors[key][4] then
        RequestNamedPtfxAsset("core")
        while not HasNamedPtfxAssetLoaded("core") do Wait(0) end
        UseParticleFxAssetNextCall("core")
        SetParticleFxShootoutBoat(1)
        local coords = monitors[key][2]
        monitorParticles[key] = {}
        --StartParticleFxLoopedAtCoord(effectName, x, y, z, xRot, yRot, zRot, scale, xAxis, yAxis, zAxis, p11)
        monitorParticles[key].pitch = 50.0
        monitorParticles[key].handle = StartParticleFxLoopedAtCoord("water_cannon_jet", coords.x, coords.y, coords.z, 50.0, 0.0, monitors[key][3], 1.0, false, false, false, false)
        monitorParticles[key].handle2 = StartParticleFxLoopedAtCoord("water_cannon_spray", coords.x, coords.y, coords.z, 50.0, 0.0, monitors[key][3], 1.0, false, false, false, false)
    end
end)

RegisterNetEvent('Client:updateMonitorsTable')
AddEventHandler('Client:updateMonitorsTable', function(key, entry, remove)
    if remove then 
        monitors[key] = nil
        return 
    end
    monitors[key] = entry
end)

RegisterNetEvent('Client:receiveMonitorsTable')
AddEventHandler('Client:receiveMonitorsTable', function(table)
    monitors = table
    for k, v in pairs(monitors) do
        if monitors[k][4] then
            RequestNamedPtfxAsset("core")
            while not HasNamedPtfxAssetLoaded("core") do Wait(0) end
            UseParticleFxAssetNextCall("core")
            SetParticleFxShootoutBoat(1)
            local coords = monitors[k][2]
            monitorParticles[k] = {}
            monitorParticles[k].handle = StartParticleFxLoopedAtCoord("water_cannon_jet", coords.x+0.0, coords.y+0.0, coords.z+0.7, 50.0, 0.0, monitors[k][3], 1.0, false, false, false, false)
            monitorParticles[k].handle2 = StartParticleFxLoopedAtCoord("water_cannon_spray", coords.x+0.0, coords.y+0.0, coords.z+0.7, 50.0, 0.0, monitors[key][3], 1.0, false, false, false, false)
            monitorParticles[k].pitch = 50.0
        end
    end
end)

RegisterNetEvent('Client:hasWaterMonitorPermission')
AddEventHandler('Client:hasWaterMonitorPermission', function()
    has_permission = true
end)

AddEventHandler('playerSpawned', function()
    if not first_spawn then
        TriggerServerEvent('Server:receiveMonitorsTable')
        Wait(5000)
        TriggerServerEvent('Server:receiveSupplyLineTable')
        first_spawn = true
    end
end)

function tableHas(table, key)
    for k in pairs(table) do
        if k == key then
            return true
        end
    end
    return false
end

function tableLength(t)
    local count = 0
    for _ in pairs(t) do count = count + 1 end
    return count
  end

function net(id)
    SetNetworkIdExistsOnAllMachines(id, true)
    SetNetworkIdCanMigrate(id, false)
end

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
            end
            Wait(0)
        end
    end
end

RegisterNetEvent('Client:toggleMonitor')
AddEventHandler('Client:toggleMonitor', function(setup)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    if vehicle ~= 0 then
        showNotification(translations.outsideVehicle)
        return
    end
    local coords = GetEntityCoords(ped)
    if setup then
        RequestModel(main.monitorModel)
        while not HasModelLoaded(main.monitorModel) do Wait(0) end
        local offSet = GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.5, 0.0)
        local prop = CreateObject(main.monitorModel, offSet.x, offSet.y, offSet.z, true, true, true)
        while not DoesEntityExist(prop) do Wait(0) end
        local propNet = NetworkGetNetworkIdFromEntity(prop)
        PlaceObjectOnGroundProperly(prop)
        FreezeEntityPosition(prop, true)
        SetEntityHeading(prop, GetEntityHeading(ped))
        net(propNet)
        offSet = GetOffsetFromEntityInWorldCoords(prop, 0.10, 0.22, 0.70)
        monitors[propNet] = {propNet, offSet, GetEntityHeading(prop), false, false} -- Spraying water, inUse
        TriggerServerEvent('Server:updateMonitorsTable', propNet, monitors[propNet], false)
        SetModelAsNoLongerNeeded(main.monitorModel)
        showNotification(translations.monitorSetup)
    else
        local found = false
        local foundKey = 0
        for k, v in pairs(monitors) do
            local distance = #(coords - v[2])
            if distance < 15.0 then
                foundKey = k
                found = true
                break
            end
        end
        if found then
            if monitors[foundKey][4] then
                showNotification(translations.monitorActive)
            else
                local prop = NetworkGetEntityFromNetworkId(monitors[foundKey][1])
                TriggerServerEvent('Server:updateMonitorsTable', foundKey, monitors[foundKey], true)
                if DoesEntityExist(prop) then
                    requestControl(2000, prop)
                    DeleteEntity(prop)
                end
                monitors[foundKey] = nil
                showNotification(translations.monitorRemoved)
            end
        else
            showNotification(translations.noMonitorFound)
        end
    end
end)

function displayHelpText(message)
    SetTextComponentFormat('STRING')
    AddTextComponentString(message)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

Citizen.CreateThread(function()
    while true do
        if not has_permission then
            TriggerServerEvent("Server:checkWaterMonitorPermissions")
            Wait(20000)
        else
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            for k, v in pairs(monitors) do
                if not v[5] then
                    local distance = #(coords - v[2])
                    if distance < main.usageDistance then
                        if distance < main.pitchDistance then
                            if v[4] then
                                DisableControlAction(main.upKey[1], main.upKey[2], true)
                                DisableControlAction(main.downKey[1], main.downKey[2], true)
                                local change = 0.0                         
                                if IsDisabledControlPressed(main.upKey[1], main.upKey[2]) then
                                    change = change + 15.0
                                end
                                if IsDisabledControlPressed(main.downKey[1], main.downKey[2]) then
                                    change = change - 15.0
                                end
                                if change ~= 0.0 then
                                    TriggerServerEvent("Server:adjustPitch", k, change)
                                    Wait(1000)
                                end
                                DisableControlAction(main.toggleKey[1],main.toggleKey[2], true)
                                if IsDisabledControlPressed(main.toggleKey[1], main.toggleKey[2]) then
                                    pressed = true
                                    TriggerServerEvent("Server:toggleWater", k)
                                    showNotification(translations.monitorToggled)
                                    Wait(main.cooldown * 1000)
                                end
                            else
                                if supplyLineNearby(ped, coords) then
                                    DisableControlAction(main.toggleKey[1],main.toggleKey[2], true)
                                    if IsDisabledControlPressed(main.toggleKey[1], main.toggleKey[2]) then
                                        TriggerServerEvent("Server:toggleWater", k)
                                        showNotification(translations.monitorToggled)
                                        Wait(main.cooldown * 1000)
                                    end
                                else
                                    showNotification(translations.noSupplyLineFound)
                                end
                            end
                        else
                            if supplyLineNearby(ped, coords) then
                                local timeout = false
                                local pressed = false
                                while not timeout do
                                    DisableControlAction(main.toggleKey[1],main.toggleKey[2], true)
                                    if IsDisabledControlPressed(main.toggleKey[1], main.toggleKey[2]) then
                                        pressed = true
                                        timeout = true
                                    end
                                    Wait(0)
                                end
                                if pressed then
                                    TriggerServerEvent("Server:toggleWater", k)
                                    showNotification(translations.monitorToggled)
                                    Wait(main.cooldown * 1000)
                                end
                            else
                                showNotification(translations.noSupplyLineFound)        
                                if v[4] then
                                    DisableControlAction(main.toggleKey[1],main.toggleKey[2], true)
                                    if IsDisabledControlPressed(main.toggleKey[1], main.toggleKey[2]) then
                                        pressed = true
                                        TriggerServerEvent("Server:toggleWater", k)
                                        showNotification(translations.monitorToggled)
                                        Wait(main.cooldown * 1000)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        Wait(0)
    end
end)

function supplyLineNearby(ped, coords)
    if dlc then
        for k, v in pairs(supplyLine) do
            local distance = #(coords - v[3])
            if distance < 25.0 then
                return true
            end
        end
    else
        return true
    end
    return false
end