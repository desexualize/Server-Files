--------------------------------------
------Created By Whit3Xlightning------
--https://github.com/Whit3XLightning--
--------------------------------------

RegisterCommand(
  Config.commandName,
  function(source, args, rawCommand)
    TriggerClientEvent("Nova:delallveh", -1)
  end,
  Config.restricCommand
)
Citizen.CreateThread(
  function()
    while true do
      Wait(600 * 1000) -- Waits 600 seconds (10 minutes)
      TriggerClientEvent("chatMessage", -1, "^7[Nova]: ", {128, 128, 128}, "60 Seconds until Vehicle Cleanup.", "alert")

      Wait(30 * 1000) -- Waits 30 seconds
      TriggerClientEvent("chatMessage", -1, "^7[Nova]: ", {128, 128, 128}, "30 Seconds until Vehicle Cleanup.", "alert")

      Wait(20 * 1000) -- Waits 20 seconds
      TriggerClientEvent("chatMessage", -1, "^7[Nova]: ", {128, 128, 128}, "10 Seconds until Vehicle Cleanup.", "alert")
      Wait(10 * 1000) -- Waits 10 seconds
      TriggerClientEvent("Nova:delallveh", -1)
      TriggerClientEvent("chatMessage", -1, "^7[Nova]: ", {128, 128, 128}, "Vehicle Cleanup completed.", "alert")
    end
  end
)
