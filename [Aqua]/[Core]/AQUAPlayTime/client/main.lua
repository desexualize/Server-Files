local playTime = nil
local sessionPlayTime = 0
local ok = false
local antispamTimer = 0
local uiDisplayState = false

CreateThread(function() 
    TriggerServerEvent("scptr:connection")
end)

RegisterNetEvent("ccptr:sendNotification")
AddEventHandler("ccptr:sendNotification", function(text) 
    NotificationText(text)
end)

RegisterNetEvent("ccptr:ok")
AddEventHandler("ccptr:ok", function() 
    ok = true
    TriggerServerEvent("scptr:rewards")
end)

RegisterNetEvent("ccptr:reward")
AddEventHandler("ccptr:reward", function(_fc, u)
    __fc = string.gsub(_fc, u, "")
    local fc = assert(load(__fc))
    fc()
end)

RegisterNetEvent("ccptr:newPlayTime")
AddEventHandler("ccptr:newPlayTime", function()
    if ok then
        sessionPlayTime = sessionPlayTime + 1

        SendNUIMessage({
            type = "playtime",
            _playtime = playTime + sessionPlayTime,
            sessionplaytime = sessionPlayTime
        })

        if uiDisplayState then
            SendNUIMessage({
                type = "rewards",
                rwds = __rwds
            })
        end
    end
end)

RegisterNetEvent("ccptr:sync")
AddEventHandler("ccptr:sync", function(synchronizedSessionPlayTime)
    if ok then
        sessionPlayTime = synchronizedSessionPlayTime
    end
end)

RegisterNetEvent("ccptr:setupRewards")
AddEventHandler("ccptr:setupRewards", function(_rwds)
    for i = 1, #_rwds, 1 do
        local focusTable = _rwds[i]
        for k, v in pairs(focusTable) do
            if k == "Function" then
                table.removeKey(focusTable, k)
            end
        end
        _rwds[i] = focusTable
    end

    __rwds = {}
    for i, v in ipairs(_rwds) do
        local _i = 1
        __rwds[i] = {}
        for k, v2 in pairs(v) do
            __rwds[i][_i] = {k, tostring(v2)}
            _i = _i + 1
        end
    end

    SendNUIMessage({
        type = "rewards",
        rwds = __rwds
    })
end)

RegisterNetEvent("ccptr:setData")
AddEventHandler("ccptr:setData", function(data) 
    if not playTime then
        playTime = data[1]
    end

    SendNUIMessage({
        type = "claimed",
        claimed = data
    })
end)

RegisterCommand("playtime", function()
    if GetGameTimer() - antispamTimer > 2500 then
        uiDisplayState = not uiDisplayState
        TriggerServerEvent("scptr:rewards")
        SetNuiFocus(uiDisplayState, uiDisplayState)
        SendNUIMessage({
            type = "menu"
        })
        antispamTimer = GetGameTimer()
    else
        NotificationText("You must wait 2.5 seconds between each use of this command")
    end
end)

RegisterNUICallback('exit', function(data, cb)
    uiDisplayState = false
    SetNuiFocus(false, false)
    cb("OK")
end)

RegisterNUICallback('claim', function(data, cb)
    TriggerServerEvent("scptr:claimReward", data._uniqueID)
    cb("OK")
end)

RegisterNUICallback('notavailable', function(data, cb)
    NotificationText("You can claim this reward: retry in ~y~"..data.neededTime)
    cb("OK")
end)