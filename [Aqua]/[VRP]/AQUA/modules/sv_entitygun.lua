RegisterCommand("Delgun", function(source, args)
    local source = source 
    local user_id = AQUA.getUserId(source)
    if AQUA.hasPermission(user_id, "admin.tickets") then 
        TriggerClientEvent('AQUA:EntityCleanupGun', source)
    end
end)