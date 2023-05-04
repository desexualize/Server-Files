RegisterNetEvent("FNR:getNumOfNHSOnline")
AddEventHandler("FNR:getNumOfNHSOnline", function()
    local source = source
    TriggerClientEvent('FNR:getNumberOfDocsOnline', source, vRP.getUsersByPermission('nhs.revive'))
end)