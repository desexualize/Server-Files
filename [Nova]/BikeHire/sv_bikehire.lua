ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("Server:hireBike")
AddEventHandler("Server:hireBike", function()
    local source = source
    hasMoney = true
    if hasMoney then
        TriggerClientEvent("Client:hireBike", source)
    else
        TriggerClientEvent("Client:bikeNotification", source, "~y~Alert~w~: You have insufficient funds")  
    end
end)

local bikesHired = {}

Citizen.CreateThread(function()
    for k, v in pairs(locations) do
        local count = 0
        for y, u in pairs(locations[k].docks) do
            count = count + 1
        end
        local enable = round2(count * (main.bikesAvailable / 100), 0)
        enable = count - enable
        for i=1,enable do
            table.insert(bikesHired, {k, i, false})
        end
    end
end)

function round2(num, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

RegisterServerEvent("Server:bikeHired")
AddEventHandler("Server:bikeHired", function(id1, id2, available)
    TriggerClientEvent("Client:bikeHired", -1, id1, id2, available)
    local found = false
    for k, v in pairs(bikesHired) do
        if v[1] == id1 then
            bikesHired[k][3] = available
            found = true
            break
        end
    end
    if not found then
        table.insert(bikesHired, {id1, id2, available})
    end
    if not available and main.enableResetBike then
        Citizen.SetTimeout(main.time * 10000, function()
            local found = false
            local av = false
            for k, v in pairs(bikesHired) do
                if v[1] == id1 then
                    av = bikesHired[k][3]
                    found = true
                    break
                end
            end
            if found and not av then
                TriggerClientEvent("Client:bikeHired", -1, id1, id2, true) 
            end
        end)
    end
end)

RegisterServerEvent("Server:receiveHiredBikes")
AddEventHandler("Server:receiveHiredBikes", function()
    local source = source
    TriggerClientEvent("Client:receiveHiredBikes", source, bikesHired)
end)