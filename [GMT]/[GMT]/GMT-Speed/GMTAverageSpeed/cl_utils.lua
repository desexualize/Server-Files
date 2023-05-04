local modelHash = `prop_speed_camera`
detecting = false
time = 0
cameraId = 0
mph = true
if main.useKmh ~= nil then
    if main.useKmh then
        mph = false
    end
end

function tableHas(tableSubmit, value)
    for k in pairs(tableSubmit) do
        if tableSubmit[k] == value then
            return true
        end
    end
    return false
end

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(ped, false)
        if vehicle ~= 0 then
            if GetPedInVehicleSeat(vehicle, -1) == ped then
                local class = GetVehicleClass(vehicle)
                local model = GetEntityModel(vehicle)
                if (main.exemptVehicleClasses == nil or class == nil or not tableHas(main.exemptVehicleClasses, class)) and not tableHas(main.exemptVehicleNames, model) then
                    local coords = GetEntityCoords(ped)
                    if not detecting then
                        for k, v in pairs(config) do
                            local distance = #(coords - v.cameraOne.coords)
                            if distance < main.detectionRadius then
                                TriggerEvent("handleDetection", k)
                                break
                            end
                        end
                    else
                        time = time + 0.05
                        local distance = #(coords - config[cameraId].cameraTwo.coords)
                        if distance < main.detectionRadius then
                            local speed = 0.0
                            if mph then
                                speed = ((config[cameraId].distance / time) * 2.236936) * main.reduceBy
                            else
                                speed = ((config[cameraId].distance / time) * 3.6) * main.reduceBy
                            end
                            if speed > (config[cameraId].limit + (config[cameraId].limit / main.addPercentage) + main.addLimit) then
                                local roadName = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
                                local roadNameString = GetStreetNameFromHashKey(roadName)
                                local numberplate = tostring(GetVehicleNumberPlateText(vehicle))
                                TriggerServerEvent("Server:AverageSpeedDetection", cameraId, speed, roadNameString, numberplate)
                                if main.flashScreen ~= nil and main.flashScreen then
                                    TriggerEvent("flashScreen")
                                end
                            end
                            detecting = false
                            time = 0
                            cameraId = 0
                        end
                    end      
                end    
            end
        end
        Wait(50)
    end
end)