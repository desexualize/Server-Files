local function isConsole(s)
  return s == 0
end

RegisterCommand('force_start', function(source, args, rawCommand)
  local gameId = tonumber(args[1])
  local Game = RIVAL:getGame(gameId)

  if isConsole(source) and Game then
    if Game.status == 'waiting' then
      GAME:startGame(Game)
    end
  end
end, true)

RegisterCommand('reload_locker', function(source, args, rawCommand)
  local player = RIVAL:getPlayer(source)
  local locker = LOCKER:handleCache(source, player)

  if locker then
    return TriggerClientEvent('RIVAL::pushNotification', source, 'message', 'reloaded locker')
  end

  TriggerClientEvent('RIVAL::pushNotification', source, 'warning', 'Failed to reload locker')
end)

RegisterCommand('reload_tag', function(source, args, rawCommand)
  local player = RIVAL:getPlayer(source)
  RIVAL:reloadChatTag(player)
end)
