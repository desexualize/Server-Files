RegisterCommand("Delgun", function(source, args)
    local source = source 
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "admin.tickets") then 
        TriggerClientEvent('ERP:EntityCleanupGun', source)
    end
end)