stuckCooldown = false

RegisterCommand('stuck', function(source, args, rawCommand)
    TriggerEvent('FNR:stuckTeleport')
end)

RegisterNetEvent('FNR:stuckTeleport')
AddEventHandler('FNR:stuckTeleport', function()
    --if not inRedZone then
        if stuckCooldown == false then
            notify("~g~You will be teleported to Legion in 3 minutes.")
            stuckCooldown = true
            Wait(60000*3)
            TriggerServerEvent("FNR:Teleport", source, vector3(151.61740112305,-1035.05078125,29.339416503906))
            stuckCooldown = false
        end
        if stuckCooldown == true then
            notify("~r~You must wait to use this command again.") 
        end
    --end
end)

function Notify( text )
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
    DrawNotification( false, false )
end