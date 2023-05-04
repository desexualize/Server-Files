local a = false
local b = true
RegisterCommand("togglekillfeed",function()
        if not a then
            b = not b
            if b then
                tvRP.notify("~g~Killfeed is now enabled")
                SendNUIMessage({type = "killFeedEnable"})
            else
                tvRP.notify("~r~Killfeed is now disabled")
                SendNUIMessage({type = "killFeedDisable"})
            end
        end
    end)
RegisterNetEvent("FNR:showHUD",function(c)
        a = not c
        if b then
            if c then
                SendNUIMessage({type = "killFeedEnable"})
            else
                SendNUIMessage({type = "killFeedDisable"})
            end
        end
    end)
RegisterNetEvent("FNR:newKillFeed",function(killer, victim, weapon, suicide, range, victimGroup, killerGroup)
        if GetIsLoadingScreenActive() then
            return
        end
        local category = "other"
        local playername = GetPlayerName(tvRP.getPlayerId())
        if victim == playername or killer == playername then
            category = "self"
        end
        SendNUIMessage(
            {type = "addKill",
            victim = victim,
            killer = killer,
            weapon = weapon,
            suicide = suicide,
            victimGroup = victimGroup,
            killerGroup = killerGroup,
            range = range,
            uuid = tvRP.generateUUID("kill", 10, "alphabet"),
            category = category})
    end)