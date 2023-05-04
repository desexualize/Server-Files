RegisterNetEvent("ARMA:tchat_receive")
AddEventHandler("ARMA:tchat_receive", function(message)
  SendNUIMessage({event = 'tchat_receive', message = message})
end)

RegisterNetEvent("ARMA:tchat_channel")
AddEventHandler("ARMA:tchat_channel", function(channel, messages)
  SendNUIMessage({event = 'tchat_channel', messages = messages})
end)

RegisterNUICallback('tchat_addMessage', function(data, cb)
  TriggerServerEvent('ARMA:tchat_addMessage', data.channel, data.message)
end)

RegisterNUICallback('tchat_getChannel', function(data, cb)
  TriggerServerEvent('ARMA:tchat_channel', data.channel)
end)
