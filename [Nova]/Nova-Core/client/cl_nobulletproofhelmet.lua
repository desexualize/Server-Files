CreateThread(function()
    while true do
        Wait(0)
        SetPlayerLockon(PlayerId(), false)
        SetPedConfigFlag(PlayerPedId(), 149, true)
        SetPedConfigFlag(PlayerPedId(), 438, true)
    end
end)