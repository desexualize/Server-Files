RegisterNUICallback('RIVAL::fetchFriends', function(_, cb)
  local gotFriends = TriggerServerCallback('RIVAL::fetchFriends')
  cb(gotFriends)
end)

RegisterSafeNUICallback('RIVAL::removeFriend', function(player)
  if not player then
    return
  end

  TriggerServerEvent('RIVAL::removeFriend', player)
end)

RegisterSafeNUICallback('RIVAL::sendFriendReq', function(player)
  if not player then
    return
  end

  TriggerServerEvent('RIVAL::sendFriendReq', player)
end)

RegisterClientCallback('RIVAL::friendReqReceieved', function(name, ticket)
  if not SQUAD.inSquad then
    return
  end

  local p = promise.new()
  NUI:pushNotification('invite', ('%s wants to add you as a friend'):format(name), ticket, 'RIVAL::handleFriendReq')

  SetTimeout(30000, function()
    p:reject({false, nil}) -- Client took to long over 30s so reject the invite request
  end)

  function handleRequest(data)
    p:resolve(data)
  end

  return Citizen.Await(p)
end)

RegisterSafeNUICallback('RIVAL::handleFriendReq', handleRequest)
RegisterNUICallback('RIVAL::fetchOnlinePlayers', function(_, cb)
  local players = TriggerServerCallback('RIVAL::fetchOnlinePlayers')
  cb(players)
end)
