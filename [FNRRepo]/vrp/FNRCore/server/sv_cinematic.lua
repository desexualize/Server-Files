RegisterServerEvent("FNR:RequestCinematic")
AddEventHandler("FNR:RequestCinematic", function()
    local source = source
    local user_id = vRP.getUserId(source)
    exports["FNR-Roles"]:isRolePresent(source, {'1070768476861509692'}, function(hasRole, roles)
        if hasRole then
            vRPclient.hasCinematicPermission(source, {})
        end
    end)
end)