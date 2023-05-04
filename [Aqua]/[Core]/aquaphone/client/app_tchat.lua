RegisterNetEvent("AQUA:tchat_receive")
AddEventHandler("AQUA:tchat_receive", function(message)
  SendNUIMessage({event = 'tchat_receive', message = message})
end)

RegisterNetEvent("AQUA:tchat_channel")
AddEventHandler("AQUA:tchat_channel", function(channel, messages)
  SendNUIMessage({event = 'tchat_channel', messages = messages})
end)

RegisterNUICallback('tchat_addMessage', function(data, cb)
  TriggerServerEvent('AQUA:tchat_addMessage', data.channel, data.message)
end)

RegisterNUICallback('tchat_getChannel', function(data, cb)
  TriggerServerEvent('AQUA:tchat_channel', data.channel)
end)
