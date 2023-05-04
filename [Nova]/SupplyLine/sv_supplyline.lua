RegisterCommand(main.commandName, function(source, args, rawCommand)
    if (source > 0) then
        if args[1] == nil or (tostring(args[1]) ~= translations.setup and tostring(args[1]) ~= translations.remove) then
            TriggerClientEvent("Client:supplyLineNotification", source, translations.supplyLineError)
            return 
        end
        local setup = false
        if tostring(args[1]) == translations.setup then setup = true end
        if tostring(args[1]) == translations.remove then setup = false end

        -- Add your permission check here, send event if they have permission

        TriggerClientEvent("Client:toggleSupplyLine", source, setup)
    end
end, main.enableAcePermissions)

local supplyLine = {}

RegisterServerEvent('Server:checkUsingDlc')
AddEventHandler('Server:checkUsingDlc', function()
    local source = source
    TriggerClientEvent('Client:ActivateDLC', source, true)
end)

RegisterServerEvent('Server:updateSupplyLineTable')
AddEventHandler('Server:updateSupplyLineTable', function(key, entry, remove)
    if remove then 
        supplyLine[key] = nil
        TriggerClientEvent("Client:updateSupplyLineTable", -1, key, entry, remove)
        return 
    end
    supplyLine[key] = entry
    TriggerClientEvent("Client:updateSupplyLineTable", -1, key, entry, remove)
end)

RegisterServerEvent('Server:receiveSupplyLineTable')
AddEventHandler('Server:receiveSupplyLineTable', function()
    TriggerClientEvent("Client:receiveSupplyLineTable", source, supplyLine)
end)