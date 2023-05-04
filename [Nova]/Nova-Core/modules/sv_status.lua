RegisterNetEvent('Server:Status:GetMaxPlayers')
AddEventHandler('Server:Status:GetMaxPlayers', function()
    TriggerClientEvent('Client:Status:GetMaxPlayers', source, GetConvarInt('sv_maxClients', 64))
end)