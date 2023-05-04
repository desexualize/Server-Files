Citizen.CreateThread(function()
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
                local coords = GetEntityCoords(ped)
                for k, v in pairs(locations) do
                    local distance = #(coords - v.coords)
                    if v.active then
                        if speed < v.limit + main.leeWay and locations[k].timeout then
                            TriggerEvent("disableDetection", k)
                        else
                            TriggerEvent("flashOrange", k)
                            Wait(1000)
                        end
                    else
                        if speed > v.limit + main.leeWay then
                            if distance < main.detectionRadius then
                                TriggerEvent("handleDetection", k)
                                break
                            end
                        end
                    end
                end
        else
            for k, v in pairs(locations) do
                if v.active then
                    TriggerEvent("disableDetection", k)
                end
            end  
        end
        Wait(0)
    end
end)