local lookup = {
    ["GMTELS:changeStage"] = "GMTELS:1",
    ["GMTELS:toggleSiren"] = "GMTELS:2",
    ["GMTELS:toggleBullhorn"] = "GMTELS:3",
    ["GMTELS:patternChange"] = "GMTELS:4",
    ["GMTELS:vehicleRemoved"] = "GMTELS:5",
    ["GMTELS:indicatorChange"] = "GMTELS:6"
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
        exports["GMT"]:TriggerClientScopeEvent(lookup[name], target, ...)
    end
else
    local origTriggerServerEvent = TriggerServerEvent
    TriggerServerEvent = function(name, ...)
        origTriggerServerEvent(lookup[name], ...)
    end
end