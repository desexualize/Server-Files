carrying = {}
--carrying[source] = targetSource, source is carrying targetSource
carried = {}
--carried[targetSource] = source, targetSource is being carried by source

RegisterServerEvent("CarryPeople:sync")
AddEventHandler("CarryPeople:sync", function(targetSrc)
    local targetSrc = targetSrc
    local sourcePed = GetPlayerPed(source)
    local sourceCoords = GetEntityCoords(sourcePed)
    local targetPed = GetPlayerPed(targetSrc)
    local targetCoords = GetEntityCoords(targetPed)
    if #(sourceCoords - targetCoords) <= 3.0 then 
        TriggerClientEvent("CarryPeople:syncTarget", targetSrc, source)
        carrying[source] = targetSrc
        carried[targetSrc] = source
    end
end)

RegisterServerEvent("CarryPeople:stop")
AddEventHandler("CarryPeople:stop", function(targetSrc)
    local source = source

    if carrying[source] then
        TriggerClientEvent("CarryPeople:cl_stop", targetSrc)
        carrying[source] = nil
        carried[targetSrc] = nil
    elseif carried[source] then
        TriggerClientEvent("CarryPeople:cl_stop", carried[source])            
        carrying[carried[source]] = nil
        carried[source] = nil
    end
end)

AddEventHandler('playerDropped', function(reason)
    local source = source
    
    if carrying[source] then
        TriggerClientEvent("CarryPeople:cl_stop", carrying[source])
        carried[carrying[source]] = nil
        carrying[source] = nil
    end

    if carried[source] then
        TriggerClientEvent("CarryPeople:cl_stop", carried[source])
        carrying[carried[source]] = nil
        carried[source] = nil
    end
end)

RegisterServerEvent("AQUAEXTRAS:CarryAccepted")
AddEventHandler("AQUAEXTRAS:CarryAccepted", function(senderSrc)
    local senderSrc = senderSrc
    local targetSrc = source
    local targetSrcName = GetPlayerName(targetSrc)
    AQUAclient.notify(targetSrc,{"~g~Carry request accepted."})
    AQUAclient.notify(senderSrc,{"~g~Your carry request to "..targetSrcName.." has been accepted."})
    TriggerClientEvent("AQUAEXTRAS:StartCarry", senderSrc, targetSrc)
end)

RegisterServerEvent("AQUAEXTRAS:CarryDeclined")
AddEventHandler("AQUAEXTRAS:CarryDeclined", function(senderSrc)
    local senderSrc = senderSrc
    local targetSrc = source
    local targetSrcName = GetPlayerName(targetSrc)
    AQUAclient.notify(senderSrc,{"~d~Your carry request to "..targetSrcName.." has been declined."})
    AQUAclient.notify(targetSrc,{"~d~Carry request denied."})
end)

RegisterServerEvent("AQUA:CarryRequest")
AddEventHandler("AQUA:CarryRequest", function(targetSrc, OMioDioMode)
    local targetSrc = targetSrc
    local senderSrc = source
    user_id = AQUA.getUserId(senderSrc)
    local senderSrcName = GetPlayerName(senderSrc)
    if OMioDioMode and AQUA.hasPermission(user_id, "admin.tickets") then
        TriggerClientEvent("AQUAEXTRAS:StartCarry", senderSrc, targetSrc)
    else
        AQUAclient.notify(targetSrc,{"Player: ~d~"..senderSrcName.."~w~ is trying to carry you, press ~g~=~w~ to accept or ~d~-~w~ to refuse"})
        AQUAclient.notify(senderSrc,{"Sent carry request to Temp ID: "..targetSrc})
        TriggerClientEvent('AQUAEXTRAS:CarryTargetAsk', targetSrc, senderSrc)
    end
end)