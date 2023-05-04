TriggerEvent('chat:addSuggestion', '/airbag', 'Activate the vehicle airbags')

-- This command allows you to create permanent airbags on a vehicle - for use in RP
-- If you do not want this, delete the command-
-- You must be the driver to use this command
RegisterCommand('airbag', function(source, args, rawCommand)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    if vehicle ~= 0 and GetPedInVehicleSeat(vehicle, -1) == ped then
        if vehicle ~= 0 then TriggerEvent("createAirbags", vehicle, true) end
    end
end)

local vehicleAirbags = {}
Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(ped, false)
        if vehicle ~= 0 and GetPedInVehicleSeat(vehicle, -1) == ped and GetVehicleEngineHealth(vehicle) <= main.damageLevel and vehicleAirbags[vehicle] == nil then
            local class = GetVehicleClass(vehicle)
            local model = GetEntityModel(vehicle)
            local allowed = true
            for k, v in pairs(main.exemptVehicleClasses) do
                if class == main.exemptVehicleClasses[k] then
                    allowed = false
                end
            end
            for k, v in pairs(main.exemptVehicleModels) do
                if model == main.exemptVehicleModels[k] then
                    allowed = false
                end
            end
            if allowed then
                vehicleAirbags[vehicle] = vehicle
                TriggerEvent("createAirbags", vehicle, true)
            end
        end
        Wait(1000)
    end
end)