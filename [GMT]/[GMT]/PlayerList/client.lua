local firstLogin = false
AddEventHandler('playerSpawned', function()
    if firstLogin == false then
        TriggerServerEvent('playerlist:playerJoined')
    end
    firstLogin = true
end)

RegisterNetEvent('playerlist:updatePlayers', function(players, maxPlayers, runTime, value)
    SendNUIMessage({
        action = 'updatePlayers',
        players = players,
        maxPlayers = maxPlayers,
        runTime = runTime,
    })
    if value then 
        SendNUIMessage({action = 'openScoreboard'})
        SetNuiFocus(true, true)
    end
end)


RegisterCommand("playerlist", function()
    TriggerServerEvent('playerlist:getUpdatedPlayers', true)
end)

RegisterKeyMapping("playerlist", "View Online Players", "keyboard", "HOME")

RegisterNUICallback("exit",function()
    SendNUIMessage({action = 'close'})
    SetNuiFocus(false, false)
end)