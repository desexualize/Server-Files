RegisterCommand('redeem', function()
    TriggerServerEvent('Promoter:checkRewardsRole')
end)

RegisterNetEvent('Promoter:Client')
AddEventHandler('Promoter:Client', function()
    TriggerServerEvent('Promoter:RedeemRewards', true)
    ShowNotification('~g~You have received your free £500,000! Thank you for supporting the server <3')
    TriggerEvent("vrp:PlaySound", "apple")
end)

RegisterNetEvent("Promoter:NoGuild")
AddEventHandler("Promoter:NoGuild", function()
    notify("Discord doesnt seem to be installed/running.")
end)

function notify(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true, false)
end