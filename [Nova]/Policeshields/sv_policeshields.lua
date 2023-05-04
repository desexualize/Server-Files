RegisterCommand(main.commandName, function(source, args, rawCommand)
    if (source > 0) then
        local shieldType = ""
        if args[1] == nil then
            shieldType = nil
        else
            shieldType = args[1]
        end
        TriggerClientEvent("Client:toggleShield", source, shieldType)
    end
end, main.acePermissionsEnabled)