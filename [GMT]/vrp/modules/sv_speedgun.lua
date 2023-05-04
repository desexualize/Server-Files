RegisterNetEvent("GMT:speedGunFinePlayer")
AddEventHandler("GMT:speedGunFinePlayer",function(playerfined,fineamount)
    local source = source
    local officer_id = vRP.getUserId(source)
    local user_id = vRP.getUserId(playerfined)
    local player_id = vRP.getUserSource(playerfined)
    if vRP.hasPermission(user_id,"police.armoury") then
        vRPclient.notify(source,{'~r~You cannot fine another officer'})
        return
    end
    if not vRP.hasPermission(user_id, "police.armoury") and vRP.hasPermission(officer_id, "police.armoury") then
        if tonumber(vRP.getBankMoney(user_id)) > tonumber(fineamount*100) then
            vRP.setBankMoney(user_id,tonumber(vRP.getBankMoney(user_id))-tonumber(fineamount*100))
            vRP.setBankMoney(officer_id,tonumber(vRP.getBankMoney(officer_id))+tonumber(fineamount*100))
            vRPclient.notify(playerfined,{'~r~You have been issued a speeding fine of £'..(fineamount*100)..' for going '..fineamount.."MPH over the speed limit."})
            vRPclient.notify(source,{'~r~You issused a speeding fine '..GetPlayerName(playerfined)..' £'..(fineamount*100)..' for going '..fineamount.."MPH over the speed limit."})
            TriggerClientEvent('GMT:speedGunPlayerFined', playerfined)
        else
            vRPclient.notify(playerfined,{"~r~You have been issued a fine for speeding"})
            vRPclient.notify(source,{"~r~This player doesn't have enough money"}) 
        end
    end
end)
