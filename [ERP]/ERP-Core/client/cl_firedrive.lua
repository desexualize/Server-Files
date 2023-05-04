Citizen.CreateThread(function()
    while true do
        SetPlayerCanDoDriveBy(PlayerPedId(), false)
        Citizen.Wait(10000)
    end
end)