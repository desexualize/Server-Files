local lookup = {
    ["ARMAELS:changeStage"] = "ARMAELS:1",
    ["ARMAELS:toggleSiren"] = "ARMAELS:2",
    ["ARMAELS:toggleBullhorn"] = "ARMAELS:3",
    ["ARMAELS:patternChange"] = "ARMAELS:4",
    ["ARMAELS:vehicleRemoved"] = "ARMAELS:5",
    ["ARMAELS:indicatorChange"] = "ARMAELS:6"
}

local origRegisterNetEvent = RegisterNetEvent
RegisterNetEvent = function(name, callback)
    origRegisterNetEvent(lookup[name], callback)
end

if IsDuplicityVersion() then
    local origTriggerClientEvent = TriggerClientEvent
    TriggerClientEvent = function(name, target, ...)
        origTriggerClientEvent(lookup[name], target, ...)
    end

    TriggerClientScopeEvent = function(name, target, ...)
        exports["arma"]:TriggerClientScopeEvent(lookup[name], target, ...)
    end
else
    local origTriggerServerEvent = TriggerServerEvent
    TriggerServerEvent = function(name, ...)
        origTriggerServerEvent(lookup[name], ...)
    end
end