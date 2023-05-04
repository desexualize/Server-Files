KNOCK_DOWN = {}

function KNOCK_DOWN:checkSquad(Squad, Game)
  local fullSquadDown = true
  if not Squad or not Game then
    return
  end

  Squad:iteratePlayers(function(player, data)
    if not Squad:getPlayerProperty(player, 'down') then
      fullSquadDown = false
    end
  end)

  if not fullSquadDown then
    return
  end

  -- Full squad is down and they are now eliminated
  Squad:gotEliminated()

  Wait(250)
  Squad:iteratePlayers(function(player, data)
    GAME:giveRewards(Squad, player, data, false, function(xpGathered, damage, kills)
      local client = {}
      local currentXp = LEVEL_SYSTEM:getPlayerXP(player)

      client.level = LEVEL_SYSTEM:getLevel(currentXp)
      client.currentXp = currentXp
      client.nextLevelXp = LEVEL_SYSTEM:getXpForNextLevel(client.level)
      client.victoryXp = 0
      client.elimiationXp = 0
      client.placementXp = 0
      client.lootXp = 0
      client.totalXp = xpGathered

      LOOTING:placeGrave(data.source, Game)
      TriggerClientEvent('RIVAL::eliminatedSquad', data.source, client, damage, xpGathered, kills)
    end)
  end)

  Game:removeSquad(Squad)
end

RegisterNetEvent('RIVAL::syncKnockedDown', function(value)
  local source = source
  local player = RIVAL:getPlayer(source)
  local Squad = RIVAL:getPlayerSquad(player)
  local Game = RIVAL:getPlayerGame(player)

  if Squad then
    Squad:setPlayerProperty(player, {'down', value})
    Squad:iteratePlayers(function(_player, data)

      if player ~= _player then
        TriggerClientEvent('RIVAL::syncKnockedDown', data.source, source, value)
      end
    end)

    if Game then
      KNOCK_DOWN:checkSquad(Squad, Game)
    end
  end
end)

RegisterNetEvent('RIVAL::handleCPRAttempt', function(target)
  if math.random(1, 10) <= 5 then
    TriggerClientEvent('RIVAL::handleCPRAttempt', target)
  end
end)
