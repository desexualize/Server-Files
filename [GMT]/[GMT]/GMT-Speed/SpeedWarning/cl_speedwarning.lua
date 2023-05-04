local detecting = false
local detectingId = 0
local detections = {

}
local networkWarnings = false
local debug = false

RegisterCommand("marcusdebug", function()
    debug = not debug
end, false)

Citizen.CreateThread(function()
    RequestModel(mainProp)
    while not HasModelLoaded(mainProp) do Wait(0) end
    for k, v in pairs(locations) do
        locations[k].prop = CreateObject(mainProp, v.coords.x, v.coords.y, v.coords.z - 1.0, false, false, true)
        while not DoesEntityExist(locations[k].prop) do Wait(0) end
        PlaceObjectOnGroundProperly(locations[k].prop)
        local coords = GetEntityCoords(locations[k].prop)
        SetEntityCoords(locations[k].prop, coords.x, coords.y, coords.z - 0.4, true, true, true, false)
        FreezeEntityPosition(locations[k].prop, true)
        SetEntityHeading(locations[k].prop, v.heading)
        locations[k].active = false
        locations[k].timeout = false
    end
    SetModelAsNoLongerNeeded(mainProp)

    while true do
        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(ped, false)
        if vehicle ~= 0 then
            local speed = GetEntitySpeed(vehicle)
            if main.useKmh then
                speed = speed * 3.6
            else
                speed = speed * 2.236936
            end
                if debug then print("Speed: "..tostring(speed).." Using KMH: "..tostring(main.useKmh)) end
                local coords = GetEntityCoords(ped)
                for k, v in pairs(locations) do
                    local distance = #(coords - v.coords)
                    if v.active then
                        if speed < v.limit + main.leeWay and locations[k].timeout then
                            disableDetection(k)
                        else
                            flashOrange(k)
                            Wait(1000)
                        end
                    else
                        if debug then print("Limit: "..tostring(v.limit + main.leeWay)) end
                        if speed > v.limit + main.leeWay then
                            if distance < main.detectionRadius then
                                if debug then print("Handle Detection") end
                                handleDetection(k)
                                break
                            end
                        end
                    end
                end
        else
            for k, v in pairs(locations) do
                if v.active then
                    disableDetection(k)
                end
            end  
        end
        Wait(0)
    end
end)

function getPropModel(speed)
    for k, v in pairs(props) do
        if v.speed == speed then
            return v.modelName
        end
    end
    return nil
end

function flashOrange(id)
    if locations[id].orangeActive == 1 then
        if DoesEntityExist(locations[id].orange1) then SetEntityVisible(locations[id].orange1, false, 0) end
        if DoesEntityExist(locations[id].orange2) then SetEntityVisible(locations[id].orange2, true, 0) end      
        locations[id].orangeActive = 2
    else
        if DoesEntityExist(locations[id].orange1) then SetEntityVisible(locations[id].orange1, true, 0) end
        if DoesEntityExist(locations[id].orange2) then SetEntityVisible(locations[id].orange2, false, 0) end      
        locations[id].orangeActive = 1
    end
end

function disableDetection(id)
    locations[id].active = false
    locations[id].timeout = false
    if DoesEntityExist(locations[id].warning) then DeleteEntity(locations[id].warning) end
    if DoesEntityExist(locations[id].orange1) then DeleteEntity(locations[id].orange1) end
    if DoesEntityExist(locations[id].orange2) then DeleteEntity(locations[id].orange2) end
end

function handleDetection(id)
    locations[id].active = true
    local model = getPropModel(locations[id].limit)
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(0) end
    locations[id].warning = CreateObject(model, locations[id].coords.x, locations[id].coords.y, locations[id].coords.z, networkWarnings, true, true)
    while not DoesEntityExist(locations[id].warning) do Wait(0) end
    AttachEntityToEntity(locations[id].warning, locations[id].prop, -1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, false, true, false, 1, true)
    RequestModel(circleProp)
    while not HasModelLoaded(circleProp) do Wait(0) end
    locations[id].orange1 = CreateObject(circleProp, locations[id].coords.x, locations[id].coords.y, locations[id].coords.z, networkWarnings, true, true)
    while not DoesEntityExist(locations[id].orange1) do Wait(0) end
    locations[id].orange2 = CreateObject(circleProp, locations[id].coords.x, locations[id].coords.y, locations[id].coords.z, networkWarnings, true, true)
    while not DoesEntityExist(locations[id].orange2) do Wait(0) end
    AttachEntityToEntity(locations[id].orange1, locations[id].prop, -1, 0.0, -0.006, 0.0, 0.0, 0.0, 0.0, true, false, true, false, 1, true) -- set up orange 1
    AttachEntityToEntity(locations[id].orange2, locations[id].prop, -1, 0.0, -0.006, -0.72, 0.0, 0.0, 0.0, true, false, true, false, 1, true) -- set up orange 2
    locations[id].orangeActive = 1
    SetModelAsNoLongerNeeded(model)
    SetModelAsNoLongerNeeded(circleProp)
    Citizen.SetTimeout(7000, function()
        locations[id].timeout = true
    end)
end