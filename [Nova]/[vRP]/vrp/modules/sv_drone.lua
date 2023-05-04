RegisterCommand("drone", function(source, args, rawCommand)
    local source = source
    if (source > 0) then
        TriggerClientEvent("toggleDrone", source)
    end
end, false)