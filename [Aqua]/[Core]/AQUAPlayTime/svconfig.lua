-- Need help? Join my discord: https://discord.gg/raMXGs9t9C

sKey = "" local characterSet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ" .. "abcdefghijklmnopqrstuvwxyz" .. "___" for i = 1, 64 do local rand = math.random(#characterSet) sKey = sKey .. string.sub(characterSet, rand, rand) end
-- Do not edit the sKey, it's a security key generated automatically at each start to avoid exploits

Rewards = {
    {
        Label = "2 Hours",
        Description = "Play the server for 2 Hour to recieve, £500,000",
        PlaytimeInSecondsNeeded = 7200, -- How many seconds of play time are needed to earn this reward
        UsingTotalPlaytime = true, -- If true, player need to have the total play time of PlaytimeInSecondsNeeded. If false, only play a session of the PlaytimeInSecondsNeeded to be able to claim the reward.
        UniqueID = "2hours", -- Unique id (used to check if the user already received this reward)
        ClaimableMultipleTimes = false, -- Set it to true if you want players to be able to claim it whenever they get that play time (I advise you to set it to true only if you set UsingTotalPlaytime to false because otherwise the user will be able to recover it directly after a reconnection)
        Function = sKey..[[
            NotificationText("Received ~y~2 hours~w~ playtime reward, £~g~500,000.")
            TriggerServerEvent("PlayerTime", false, "2hours", "xyAs8")
        ]]
    },
    {
        Label = "10 Hours",
        Description = "Play the server for 2 Hour to recieve, £1,000,000",
        PlaytimeInSecondsNeeded = 36000, -- How many seconds of play time are needed to earn this reward
        UsingTotalPlaytime = true, -- If true, player need to have the total play time of PlaytimeInSecondsNeeded. If false, only play a session of the PlaytimeInSecondsNeeded to be able to claim the reward.
        UniqueID = "10hours", -- Unique id (used to check if the user already received this reward)
        ClaimableMultipleTimes = false, -- Set it to true if you want players to be able to claim it whenever they get that play time (I advise you to set it to true only if you set UsingTotalPlaytime to false because otherwise the user will be able to recover it directly after a reconnection)
        Function = sKey..[[
            NotificationText("Received ~y~10 hours~w~ playtime reward, £~g~1,000,000.")
            TriggerServerEvent("PlayerTime", false, "10hours", "xyAs8")
        ]]
    },
    {
        Label = "1 Day",
        Description = "Play the server for One Day to recieve, £1,500,000",
        PlaytimeInSecondsNeeded = 86400, -- How many seconds of play time are needed to earn this reward
        UsingTotalPlaytime = true, -- If true, player need to have the total play time of PlaytimeInSecondsNeeded. If false, only play a session of the PlaytimeInSecondsNeeded to be able to claim the reward.
        UniqueID = "24Hours", -- Unique id (used to check if the user already received this reward)
        ClaimableMultipleTimes = false, -- Set it to true if you want players to be able to claim it whenever they get that play time (I advise you to set it to true only if you set UsingTotalPlaytime to false because otherwise the user will be able to recover it directly after a reconnection)
        Function = sKey..[[
            NotificationText("Received ~y~1 Day~w~ playtime reward, £~g~1,500,000.")
            TriggerServerEvent("PlayerTime", false, "24Hours", "xyAs8")
        ]]
    },
    {
        Label = "3 Days",
        Description = "Play the server for 3 Days to recieve, £2,500,000",
        PlaytimeInSecondsNeeded = 259200, -- How many seconds of play time are needed to earn this reward
        UsingTotalPlaytime = true, -- If true, player need to have the total play time of PlaytimeInSecondsNeeded. If false, only play a session of the PlaytimeInSecondsNeeded to be able to claim the reward.
        UniqueID = "72Hours", -- Unique id (used to check if the user already received this reward)
        ClaimableMultipleTimes = false, -- Set it to true if you want players to be able to claim it whenever they get that play time (I advise you to set it to true only if you set UsingTotalPlaytime to false because otherwise the user will be able to recover it directly after a reconnection)
        Function = sKey..[[
            NotificationText("Received ~y~3 Days~w~ playtime reward, £~g~£2,500,000.")
            TriggerServerEvent("PlayerTime", false, "72Hours", "xyAs8")
        ]]
    },
    {
        Label = "1 Week",
        Description = "Play the server for 1 Week to recieve, £3,250,000",
        PlaytimeInSecondsNeeded = 604800, -- How many seconds of play time are needed to earn this reward
        UsingTotalPlaytime = true, -- If true, player need to have the total play time of PlaytimeInSecondsNeeded. If false, only play a session of the PlaytimeInSecondsNeeded to be able to claim the reward.
        UniqueID = "1week", -- Unique id (used to check if the user already received this reward)
        ClaimableMultipleTimes = false, -- Set it to true if you want players to be able to claim it whenever they get that play time (I advise you to set it to true only if you set UsingTotalPlaytime to false because otherwise the user will be able to recover it directly after a reconnection)
        Function = sKey..[[
            NotificationText("Received ~y~1 Week~w~ playtime reward, £~g~£3,250,000.")
            TriggerServerEvent("PlayerTime", false, "1week", "xyAs8")
        ]]
    },
}
