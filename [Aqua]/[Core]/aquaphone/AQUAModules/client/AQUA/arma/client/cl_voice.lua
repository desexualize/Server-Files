RegisterNetEvent("ARMA:mutePlayers",function(a)
    for b, c in pairs(a) do
        exports["pma-voice"]:mutePlayer(b, true)
    end
end)
RegisterNetEvent("ARMA:mutePlayer",function(b)
    exports["pma-voice"]:mutePlayer(b, true)
end)
RegisterNetEvent("ARMA:unmutePlayer",function(b)
    exports["pma-voice"]:mutePlayer(b, false)
end)
