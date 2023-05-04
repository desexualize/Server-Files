-- Command registered server side below:
RegisterCommand(main.commandName, function(source, args, rawCommand)
    if (source > 0) then
        if args[1] == nil or (tostring(args[1]) ~= translations.setup and tostring(args[1]) ~= translations.remove) then
            TriggerClientEvent("Client:monitorNotification", source, translations.commandError)
            return 
        end
        local setup = false
        if tostring(args[1]) == translations.setup then setup = true end
        if tostring(args[1]) == translations.remove then setup = false end

        -- Add your permission check here, send event if they have permission

        TriggerClientEvent("Client:toggleMonitor", source, setup)
    end
end, main.enableAcePermissions)

-- More permissions here:

RegisterServerEvent('Server:checkWaterMonitorPermissions')
AddEventHandler('Server:checkWaterMonitorPermissions', function()
    local source = source

    -- Add your permission check here, send event if they have permission
    -- This enables them to toggle on/off and rotate the water monitor
    -- This event is triggered to CHECK if they have permission
    -- This only needs to be sent once, send it again to take their permission away
    -- You can easily add ace permissions here, by checking their ace

    TriggerClientEvent("Client:hasWaterMonitorPermission", source)
end)

local monitors = {}

RegisterServerEvent('Server:updateMonitorsTable')
AddEventHandler('Server:updateMonitorsTable', function(key, entry, remove)
    if remove then 
        monitors[key] = nil
        TriggerClientEvent("Client:updateMonitorsTable", -1, key, entry, remove)
        return 
    end
    monitors[key] = entry
    TriggerClientEvent("Client:updateMonitorsTable", -1, key, entry, remove)
end)

RegisterServerEvent('Server:receiveMonitorsTable')
AddEventHandler('Server:receiveMonitorsTable', function()
    TriggerClientEvent("Client:receiveMonitorsTable", source, monitors)
end)

RegisterServerEvent('Server:toggleWater')
AddEventHandler('Server:toggleWater', function(key)
    TriggerClientEvent("Client:toggleWater", -1, key)
end)

RegisterServerEvent('Server:adjustPitch')
AddEventHandler('Server:adjustPitch', function(key, change)
    TriggerClientEvent('Client:adjustPitch', -1, key, change)
end)