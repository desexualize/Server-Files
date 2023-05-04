AddEventHandler('txAdmin:events:scheduledRestart', function(eventData)
    if eventData.secondsRemaining == 60 then
        TriggerClientEvent('FNR:announceRestart', -1, 60, true)
    end
end)

RegisterNetEvent('FNR:RestartServer')
AddEventHandler('FNR:RestartServer', function()
    local source = source 
    local userid = vRP.getUserId(source)
    if vRP.hasPermission(userid, 'dev.menu') then
        TriggerClientEvent('FNR:announceRestart', -1, 60, false)
        Wait(60000)
        restartServer()
    end
end)

function restartServer()
    for i,v in pairs(GetPlayers()) do 
        DropPlayer(v, 'Server Restarting')
    end
    Citizen.Wait(2000)
    os.exit()
end