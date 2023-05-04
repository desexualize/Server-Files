local acePermissionsEnabled = false

-- Command registered server side below:
RegisterCommand("jack", function(source, args, rawCommand)
    if (source > 0) then
        if args[1] == nil or (tostring(args[1]) ~= "setup" and tostring(args[1]) ~= "remove") then
            TriggerClientEvent("Client:jackNotification", source, "~r~Error~w~: Use /jack setup or /jack remove")
            return 
        end
        local setup = false
        if tostring(args[1]) == "setup" then setup = true end
        if tostring(args[1]) == "remove" then setup = false end
        -- Add your permission check here, send event if they have permission
        TriggerClientEvent("Client:toggleJack", source, setup)
    end
end, acePermissionsEnabled)

RegisterCommand("chock", function(source, args, rawCommand)
    if (source > 0) then
        if args[1] == nil or (tostring(args[1]) ~= "setup" and tostring(args[1]) ~= "remove") then
            TriggerClientEvent("Client:jackNotification", source, "~r~Error~w~: Use /chock setup or /chock remove")
            return 
        end
        local setup = false
        if tostring(args[1]) == "setup" then setup = true end
        if tostring(args[1]) == "remove" then setup = false end
        -- Add your permission check here, send event if they have permission
        TriggerClientEvent("Client:toggleChock", source, setup)
    end
end, acePermissionsEnabled)

local acePermissionsEnabled = false
local carJacks = {}
local carChocks = {}

RegisterServerEvent('Server:updateJackTable')
AddEventHandler('Server:updateJackTable', function(key, entry, remove)
    if remove then 
        carJacks[key] = nil
        TriggerClientEvent("Client:updateJackTable", -1, key, entry, remove)
        return 
    end
    carJacks[key] = entry
    TriggerClientEvent("Client:updateJackTable", -1, key, entry, remove)
end)

RegisterServerEvent('Server:updateChockTable')
AddEventHandler('Server:updateChockTable', function(key, entry, remove)
    if remove then 
        carChocks[key] = nil
        TriggerClientEvent("Client:updateChockTable", -1, key, entry, remove)
        return 
    end
    carChocks[key] = entry
    TriggerClientEvent("Client:updateChockTable", -1, key, entry, remove)
end)

RegisterServerEvent('Server:receiveJackTable')
AddEventHandler('Server:receiveJackTable', function()
    TriggerClientEvent("Client:receiveJackTable", source, carJacks)
end)

RegisterServerEvent('Server:toggleChockWheels')
AddEventHandler('Server:toggleChockWheels', function(netId)
    TriggerClientEvent("Client:toggleChockWheels", -1, netId)
end)

RegisterServerEvent('Server:receiveChockTable')
AddEventHandler('Server:receiveChockTable', function()
    TriggerClientEvent("Client:receiveChockTable", source, carChocks)
end)