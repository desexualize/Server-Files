SetDiscordAppId(1061288251110985808)

local UserID = 0
local PlayerCount = 0





RegisterNetEvent('AQUA:StartGetPlayersLoopCL')
AddEventHandler('AQUA:StartGetPlayersLoopCL', function()
    StartLoop()
end)

RegisterNetEvent('AQUA:ReturnGetPlayersLoopCL')
AddEventHandler('AQUA:ReturnGetPlayersLoopCL', function(UserID, PlayerCount)
    UserID = UserID
    PlayerCount = PlayerCount
    SetRichPresence("[ID: "..UserID.."] | "..PlayerCount.." / 64")
end)

function StartLoop()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(5000)
            TriggerServerEvent("AQUA:StartGetPlayersLoopSV")
        end
    end)
end