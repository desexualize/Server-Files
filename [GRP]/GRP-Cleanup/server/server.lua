--------------------------------------
------Created By Whit3Xlightning------
--https://github.com/Whit3XLightning--
--------------------------------------

RegisterCommand(Config.commandName, function(source, args, rawCommand) TriggerClientEvent("wld:delallveh", -1) end, Config.restricCommand)


Citizen.CreateThread(function()

    while true do
        Wait(600 * 1000)
        TriggerClientEvent('chat:addMessage', -1, {
            template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(255, 0, 0, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> Vehicle Cleanup^7: ' .. '60 Seconds until Vehicle Cleanup.' .. '</div>',
            args = { playerName, msg }
          })
        Wait(30 * 1000)
        TriggerClientEvent('chat:addMessage', -1, {
            template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(255, 0, 0, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> Vehicle Cleanup^7: ' .. '30 Seconds until Vehicle Cleanup.' .. '</div>',
            args = { playerName, msg }
          })
        Wait(20* 1000)
        TriggerClientEvent('chat:addMessage', -1, {
            template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(255, 0, 0, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> Vehicle Cleanup^7: ' .. '10 Seconds until Vehicle Cleanup. All Unoccupied Vehicles will be deleted.' .. '</div>',
            args = { playerName, msg }
          })
        Wait(10 * 1000)
        TriggerClientEvent("wld:delallveh", -1)
        TriggerClientEvent('chat:addMessage', -1, {
            template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(255, 0, 0, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> Vehicle Cleanup^7: ' .. 'A Vehicle cleanup has happened!' .. '</div>',
            args = { playerName, msg }
          })
    end
end)

