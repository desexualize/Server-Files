ANTICHEAT = {}

function ANTICHEAT:banClient(xpAmount, m)
  TriggerServerEvent('RIVAL::addXpToClient', xpAmount, m)
end

AddEventHandler('gameEventTriggered', function(name, data)
  print('[Game Event] ' .. name, json.encode(data))
end)
