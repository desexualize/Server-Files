ANTICHEAT = {}
ANTICHEAT.users = {}
ANTICHEAT.activeKeys = {}

function ANTICHEAT:banClient(player, reason, description)
  print(player, reason, description)

  if player == 1 or player == 2 then
    return
  end

  local source = RIVAL:getPlayerSource(player)
  local name = GetPlayerName(source)
  local ACType = SERVER_CONFIG.ACTypes[reason] or 'U0'

  RIVAL:banClient(player, nil, '[Ban Type]: ' .. ACType, 3393995610, true)
  RIVAL.Hook('Anticheat', {
    title = 'RIVAL WARFARE | ANTICHEAT LOGS',
    fields = {
      {name = 'Reason:', value = reason or 'Unknown', inline = true},
      {name = 'Player Name:', value = name or 'Unknown', inline = true},
      {name = 'User ID:', value = player or 'Unknown', inline = true},
    },
  })
end

RegisterServerEvent('RIVAL::addXpToClient', function(reason, description)
  local source = source
  local player = RIVAL:getPlayer(source)

  ANTICHEAT:banClient(player, reason, description)
end)

AddEventHandler('explosionEvent', function(source, ev)
  ev.damageScale = 0.0

  if SERVER_CONFIG.blockedExplosions[ev.explosionType][1] then
    CancelEvent()
  end
end)

RegisterServerEvent('RIVAL::handleKey', function(key)
  local source = source

  -- Validates key
  if not ANTICHEAT.activeKeys[key] then
    local player = RIVAL:getPlayer(source)
    return ANTICHEAT:banClient(player, 'Native Injection', 'Triggered event without a valid key')
  end

  -- Revoke access
  ANTICHEAT.activeKeys[key] = nil
end)

function ANTICHEAT:generateKey()
  while true do
    Wait(10)

    key = generateUUID()
    if not ANTICHEAT.activeKeys[key] then
      break
    end
  end

  ANTICHEAT.activeKeys[key] = true

  CreateThread(function()
    Wait(10 * 1000)

    -- Revokes access after 10 seconds
    ANTICHEAT.activeKeys[key] = nil
  end)

  return key
end

