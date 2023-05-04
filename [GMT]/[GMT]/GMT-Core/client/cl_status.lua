local UserID = 0
local PlayerCount = 0
local frames = 0

RegisterNetEvent('discord:getpermid2')
AddEventHandler('discord:getpermid2', function(UserID)
    SetDiscordAppId(994958477216710776)
    SetDiscordRichPresenceAsset('gmt')
    SetDiscordRichPresenceAssetText('GMT UK')
    SetDiscordRichPresenceAssetSmallText('GMT Server #1')
    SetDiscordRichPresenceAction(0, "Join Discord", "https://discord.io/gmtuk")
    SetDiscordRichPresenceAction(1, "Connect To GMT", "fivem://connect/gmt.city")
   -- SetRichPresence("[ID: " .. tostring(UserID) .. "] |" .. #GetActivePlayers() " /128")
end)






RegisterNetEvent('GMT:StartGetPlayersLoopCL')
AddEventHandler('GMT:StartGetPlayersLoopCL', function()
    StartLoop()
end)

RegisterNetEvent('GMT:ReturnGetPlayersLoopCL')
AddEventHandler('GMT:ReturnGetPlayersLoopCL', function(UserID, PlayerCount)
    UserID = UserID
    PlayerCount = PlayerCount
    SetRichPresence("[ID: "..UserID.."] | "..PlayerCount.." / 128")
end)

function StartLoop()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(5000)
            TriggerServerEvent("GMT:StartGetPlayersLoopSV")
        end
    end)    
end
