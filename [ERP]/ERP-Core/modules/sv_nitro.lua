

RegisterServerEvent("CheckNitro")
AddEventHandler("CheckNitro", function()
    local source = source
    exports['ERP-Roles']:isRolePresent(source, {'999412407325696030'} --[[ can be a table or just a string. ]], function(hasRole, roles)
        if (not roles) then 
            TriggerClientEvent("NoGuild", source)
        end
        if hasRole == true then
            TriggerClientEvent("SpawningNitro", source)
        else
            TriggerClientEvent("NotBoosing", source)
        end
    end)
end)