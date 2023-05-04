GameConstructor = {}
GameConstructor.__index = GameConstructor

setmetatable(GameConstructor, {
  __call = function(self, gameMode)
    return self:initialize(gameMode)
  end,
})

function GameConstructor:initialize(gameMode)
  GAME.currentGeneratorId = GAME.currentGeneratorId + 1
  local constructor = setmetatable({}, self)

  constructor.bucketId = GAME.currentGeneratorId
  constructor.gameMode = gameMode
  constructor.id = GAME.currentGeneratorId
  constructor.status = 'waiting'
  constructor.squads = {}
  constructor.allocatedCoords = {}
  constructor.graveStones = {}

  RIVAL.Games[constructor.id] = constructor

  return constructor
end

function GameConstructor:addSquad(Squad)
  if Squad and RIVAL.Squads[Squad.id] then
    RIVAL.Games[self.id].squads[Squad.id] = Squad
    self.squads[Squad.id] = Squad

    Squad:iteratePlayers(function(player, data)
      RIVAL.Players[player].gameId = self.id
    end)

    self:iteratePlayers(function(_, data)
      TriggerClientEvent('RIVAL::handleLocalEvent', data.source, 'onPlayerJoinGame', player, self:getPlayerCount())
    end)
  end
end

function GameConstructor:removeSquad(Squad)
  if Squad and RIVAL.Squads[Squad.id] then
    Squad:iteratePlayers(function(player, data)
      RIVAL.Players[player].gameId = nil
    end)

    self:iteratePlayers(function(player, data)
      TriggerClientEvent('RIVAL::handleLocalEvent', data.source, 'onPlayerLeftGame', player, self:getPlayerCount())
    end)
  end
end

function GameConstructor:iteratePlayers(cb)
  for squadId, squadObj in pairs(self.squads) do
    squadObj:iteratePlayers(function(player, data)
      cb(player, data)
    end)
  end
end

function GameConstructor:getPlayerCount()
  local count = 0

  for squadId, squadData in pairs(self.squads) do
    count = count + squadData:getPlayerCount()
  end

  return count
end

function GameConstructor:getSquadCount()
  return #self.squads
end

function GameConstructor:syncSquad(Squad)
  RIVAL.Games[self.id].squads[Squad.id] = Squad
end

function GameConstructor:iterateSquads(cb)
  for squadId, squadObj in pairs(self.squads) do
    cb(squadObj)
  end
end
