RegisterServerEvent('GetUserID')
AddEventHandler('GetUserID', function()
    local source = source
    local user_id = vRP.getUserId(source)
    local name = GetPlayerName(source)
    TriggerClientEvent('DiscordPresence', source, user_id, name)
end)