RegisterNetEvent("AQUA:speedGunFinePlayer")
AddEventHandler("AQUA:speedGunFinePlayer",function(playerfined,fineamount)
    local source = source
    local officer_id = AQUA.getUserId(source)
    local user_id = AQUA.getUserId(playerfined)
    local player_id = AQUA.getUserSource(playerfined)
    if AQUA.hasPermission(user_id,"police.armoury") then
        AQUAclient.notify(source,{'~d~You cannot fine another officer'})
        return
    end
    if not AQUA.hasPermission(user_id, "police.armoury") and AQUA.hasPermission(officer_id, "police.armoury") then
        if tonumber(AQUA.getBankMoney(user_id)) > tonumber(fineamount*100) then
            AQUA.setBankMoney(user_id,tonumber(AQUA.getBankMoney(user_id))-tonumber(fineamount*100))
            AQUA.setBankMoney(officer_id,tonumber(AQUA.getBankMoney(officer_id))+tonumber(fineamount*100))
            AQUAclient.notify(playerfined,{'~d~You have been issued a speeding fine of £'..(fineamount*100)..' for going '..fineamount.."MPH over the speed limit."})
            AQUAclient.notify(source,{'~d~You issused a speeding fine '..GetPlayerName(playerfined)..' £'..(fineamount*100)..' for going '..fineamount.."MPH over the speed limit."})
            TriggerClientEvent('AQUA:speedGunPlayerFined', playerfined)
        else
            AQUAclient.notify(playerfined,{"~d~You have been issued a fine for speeding"})
            AQUAclient.notify(source,{"~d~This player dosnt have enough money"}) 
        end
    end
end)

