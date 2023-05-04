GAME = {}
GAME.currentGeneratorId = 0

function GAME:iterateWaiting(gameMode, cb)
  local hasIterated = false

  for _, gameObj in pairs(RIVAL.Games) do
    if gameObj.status == 'waiting' and gameObj.gameMode == gameMode then
      hasIterated = true
      cb(_, gameObj)
    end
  end

  return hasIterated
end

function GAME:getRoute()
  return SERVER_CONFIG.gameRoutes[math.random(1, #SERVER_CONFIG.gameRoutes)]
end

function GAME:connectClient(source, Game, Squad, playerCount)
  local player = RIVAL:getPlayer(source)
  INVENTORY:setDefault(source)

  if Game and Squad then
    Game:addSquad(Squad)

    Squad:iteratePlayers(function(_player, data)
      data.ready = false
      TriggerClientEvent('RIVAL::enterWaitingStage', data.source, playerCount, Game.gameMode)
      SetEntityCoords(GetPlayerPed(data.source), SHARED_CONFIG.waitingStage)
      SetPlayerRoutingBucket(source, Game.bucketId)
    end)

    -- Start count down timer if the game player count goes over minimum player count.
    if playerCount >= SHARED_CONFIG.gameCount[Game.gameMode].min then
      GAME:startGame(Game)
    end
  end
end

function GAME:findAvaliableGame(player, gameMode)
  local source = RIVAL:getPlayerSource(player)
  local Squad = RIVAL:getPlayerSquad(player)
  local squadCount = Squad:getPlayerCount()
  local alreadyJoined = false

  Squad:resetElimiation()

  local iterate = GAME:iterateWaiting(gameMode, function(gameId, Game)
    Game:iteratePlayers(function(player, data)
      local gameCount = Game:getPlayerCount(gameId)
      local playerCount = gameCount + squadCount

      if playerCount <= SHARED_CONFIG.gameCount[gameMode].max then -- All players in squad can join the game
        GAME:connectClient(source, Game, Squad, playerCount)
        alreadyJoined = true
      end
    end)
  end)

  if not iterate and not alreadyJoined then -- No games are avaliable, so create a new one
    local Game = GameConstructor(gameMode)

    Game:addSquad(Squad)
    Squad:iteratePlayers(function(player, data)
      INVENTORY:setDefault(data.source)

      SetPlayerRoutingBucket(data.source, Game.bucketId)
      SetRoutingBucketPopulationEnabled(Game.bucketId, false)
      SetRoutingBucketEntityLockdownMode(Game.bucketId, 'strict')
      TriggerClientEvent('RIVAL::enterWaitingStage', data.source, squadCount, gameMode)
      SetEntityCoords(GetPlayerPed(data.source), SHARED_CONFIG.waitingStage)
    end)
  end
end

function GAME:startGame(Game)
  Game.status = 'started'

  -- Initialize game
  GM:placeVehicles(Game)
  CRATES:spawnCrates(Game)

  CreateThread(function()
    -- Game wont end before 100s so we can add a timer here to save performance
    Wait(100 * 1000)

    while true do
      Wait(3000)

      -- Check every 3 seconds if the game has ended
      if GM:checkForEnding(Game) then

        GAME:endGame(Game)
        break
      end
    end
  end)

  GM:startGame(Game)
end

-- Player jumped from plane
RegisterServerEvent('RIVAL::playerJumped', function()
  local source = source
  local player = RIVAL:getPlayer(source)
  local Game = RIVAL:getPlayerGame(player)

  SetPlayerRoutingBucket(source, Game.bucketId)
end)

-- Event handler to track damage, kills and deaths
AddEventHandler('weaponDamageEvent', function(sender, weaponData)
  local weaponDamage, finalKill = weaponData.weaponDamage, weaponData.willKill
  local player = RIVAL:getPlayer(tonumber(sender))
  local Squad = RIVAL:getPlayerSquad(player)

  if weaponDamage > 0 then -- Player was attacker
    local damage = Squad:getPlayerProperty(player, 'damage') or 0
    Squad:setPlayerProperty(player, {'damage', damage + weaponDamage})

    if finalKill then
      local kills = Squad:getPlayerProperty(player, 'kills') or 0
      Squad:setPlayerProperty(player, {'kills', kills + 1})

      CHALLENGES:registerKill(tonumber(sender))
    end
  end
end)

function GAME:giveRewards(Squad, player, data, wonGame, callback)
  INVENTORY:clearInventory(data.source)

  local kills, deaths, damage, xp = data.kills or 0, data.deaths or 0, data.damage or 0
  local xpGathered = kills * 3
  local query

  if wonGame then
    local packedData = table.pack(kills, xpGathered, deaths, damage, player)
    query =
      ('UPDATE rival_stats SET Kills = Kills + %s, XP = XP + %s, Deaths = Deaths + %s, Damage = Damage + %s, `Matches-Won` = `Matches-Won` + 1 WHERE UID = %s'):format(
        table.unpack(packedData))
  else
    local packedData = table.pack(kills, xpGathered, deaths, damage, player)
    query =
      ('UPDATE rival_stats SET Kills = Kills + %s, XP = XP + %s, Deaths = Deaths + %s, Damage = Damage + %s, `Matches-Lost` = `Matches-Lost` + 1  WHERE UID = %s'):format(
        table.unpack(packedData))
  end

  DATABASE:queryAsync(query)

  -- Resets player stats
  Squad:setPlayerProperty(player, {'kills', 0})
  Squad:setPlayerProperty(player, {'deaths', 0})
  Squad:setPlayerProperty(player, {'damage', 0})
  Squad:setPlayerProperty(player, {'cash', 0})
  Squad:setPlayerProperty(player, {'down', false})

  callback(xpGathered, damage, kills)
end

function GAME:endGame(Game)
  if Game:getSquadCount() ~= 1 then
    return
  end

  Game:iterateSquads(function(Squad)
    Squad:iteratePlayers(function(player, data)
      GAME:giveRewards(Squad, player, data, true, function(xpGathered)
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

        TriggerClientEvent('RIVAL::handleWinning', data.source, client)
      end)
    end)
  end)
end

RegisterNetEvent('baseevents:onPlayerKilled', function(killedBy, data)
  local source = source
  local victimName = GetPlayerName(source)
  local attackerName = GetPlayerName(killedBy)

  local player = RIVAL:getPlayer(source)
  local Squad = RIVAL:getPlayerSquad(player)
  local Game = RIVAL:getPlayerGame(player)
  local deathString = ('%s killed %s with an %s'):format(attackerName, victimName,
                                                         SHARED_CONFIG.weaponNames[data.weaponhash][1])
  local deathCoords = vec3(table.unpack(data.killerpos))

  local deaths = Squad:getPlayerProperty(player, 'deaths') or 0
  Squad:setPlayerProperty(player, {'deaths', deaths + 1})

  Game:iteratePlayers(function(player, data)
    local distance = #(deathCoords - GetEntityCoords(GetPlayerPed(data.source)))
    TriggerClientEvent('RIVAL::registerKill', data.source, deathString, math.ceil(distance))
  end)
end)

RegisterNetEvent('baseevents:onPlayerDied', function(killedBy, data)
  local victim = source
  local victimName = GetPlayerName(victim)
  local player = RIVAL:getPlayer(victim)
  local Squad = RIVAL:getPlayerSquad(player)
  local Game = RIVAL:getPlayerGame(player)
  local deathString = ('%s Mysterically died'):format(victimName)
  local deathCoords = vec3(table.unpack(data))

  if not Game then
    return Citizen.Trace(('Player %s somehow died but was not in a game'):format(player))
  end

  local deaths = Squad:getPlayerProperty(player, 'deaths') or 0
  Squad:setPlayerProperty(player, {'deaths', deaths + 1})

  Game:iteratePlayers(function(player, data)
    local distance = #(deathCoords - GetEntityCoords(GetPlayerPed(data.source)))
    TriggerClientEvent('RIVAL::registerKill', data.source, deathString, math.ceil(distance))
  end)
end)

function GAME:getPlayerInfo(player, Squad, Game)
  return {
    cash = Squad:getPlayerProperty(player, 'cash') or 0,
    players = Game:getPlayerCount() or 0,
    kills = Squad:getPlayerProperty(player, 'kills') or 0,
  }
end

RegisterServerCallback('RIVAL::fetchGameInfo', function(source)
  local player = RIVAL:getPlayer(source)
  local Squad = RIVAL:getPlayerSquad(player)
  local Game = RIVAL:getPlayerGame(player)

  if not Squad or not Game then
    return
  end

  return GAME:getPlayerInfo(player, Squad, Game)
end)

function GAME:updateCash(source)
  local player = RIVAL:getPlayer(source)
  local Squad = RIVAL:getPlayerSquad(player)
  local Game = RIVAL:getPlayerGame(player)

  TriggerClientEvent('RIVAL::forceSetInfo', source, GAME:getPlayerInfo(player, Squad, Game))
end
