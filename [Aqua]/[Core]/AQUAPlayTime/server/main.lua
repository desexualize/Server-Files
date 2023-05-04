local connected = {}

RegisterNetEvent("scptr:connection")
AddEventHandler("scptr:connection", function() 
    local _source = source
    local license = GetLicense(GetPlayerIdentifiers(_source))

    if connected[_source] then
        print("[^6"..GetCurrentResourceName().."^7]: ^1[".._source.."] is trying to exploit.^7")
    else
        connected[_source] = os.time(os.date("!*t"))
        TriggerEvent("scptr:jsCheck", _source, license)
        TriggerClientEvent("ccptr:ok", _source)
    end
end)

RegisterNetEvent("scptr:claimReward")
AddEventHandler("scptr:claimReward", function(UID) 
    local _source = source
    local license = GetLicense(GetPlayerIdentifiers(_source))

    TriggerEvent("scptr:jsClaimReward", _source, license, UID, sKey)
end)

RegisterNetEvent("scptr:rewards")
AddEventHandler("scptr:rewards", function() 
    local _source = source
    TriggerEvent("scptr:jsFullData", _source, GetLicense(GetPlayerIdentifiers(_source)))
end)

CreateThread(function() 
    TriggerEvent("scptr:setRewards", Rewards)
    while true do
        Wait(10000)
        for _, id in pairs(GetPlayers()) do
            if connected[tonumber(id)] then 
                TriggerEvent("scptr:jsSetPlaytime", GetLicense(GetPlayerIdentifiers(tonumber(id))), id, os.time(os.date("!*t")), connected[tonumber(id)])
            end
        end
    end
end)

CreateThread(function() 
    while true do
        TriggerClientEvent("ccptr:newPlayTime", -1)
        Wait(1000)
    end
end)