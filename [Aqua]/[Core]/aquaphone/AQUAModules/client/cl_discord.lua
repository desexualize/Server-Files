

local UserID = 0
local PlayerCount = 0

RegisterNetEvent('discord:getpermid2')
AddEventHandler('discord:getpermid2', function(UserID)
    SetDiscordAppId(1074346762980032522)
    SetDiscordRichPresenceAsset('aqua')
    SetDiscordRichPresenceAssetText('AQUA')
    SetDiscordRichPresenceAssetSmallText('[EU|UK] AQUA Server #1')
    SetDiscordRichPresenceAction(0, "Join Discord", "https://discord.gg/aqua5m")
    SetDiscordRichPresenceAction(1, "Connect To AQUA", "fivem://connect/aquaroleplay.com")
    SetRichPresence("PermID: "..UserID.." - Updating")
end)

RegisterNetEvent('AQUA:StartGetPlayersLoopCL')
AddEventHandler('AQUA:StartGetPlayersLoopCL', function()
    StartLoop()
end)

RegisterNetEvent('AQUA:ReturnGetPlayersLoopCL')
AddEventHandler('AQUA:ReturnGetPlayersLoopCL', function(UserID, PlayerCount)
    UserID = UserID
    PlayerCount = PlayerCount
    SetRichPresence("PermID: "..UserID.." | Players: "..PlayerCount.." / 128")
end)

function StartLoop()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(5000)
            TriggerServerEvent("AQUA:StartGetPlayersLoopSV")
        end
    end)
end
