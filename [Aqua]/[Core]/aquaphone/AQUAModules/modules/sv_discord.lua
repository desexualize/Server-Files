RegisterServerEvent('GetActivePlayers')
AddEventHandler('GetActivePlayers', function()
    local count = GetNumPlayerIndices()
    -- Callback to client
    TriggerClientEvent('GetActivePlayers:CB', source, count)
end)