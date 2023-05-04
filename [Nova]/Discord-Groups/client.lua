Citizen.CreateThread(function()
    Citizen.Wait(2000)
    TriggerServerEvent('Discord-Groups:Server:RequestUpdatedGroups')
end)