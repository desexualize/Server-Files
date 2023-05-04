SquadConstructor = {}
SquadConstructor.currentIndex = 1
SquadConstructor.__index = SquadConstructor

setmetatable(SquadConstructor, {
  __call = function(self)
    return self:initialize()
  end,
})

function SquadConstructor:initialize()
  local constructor = setmetatable({}, self)
  constructor.id = SquadConstructor.currentIndex
  constructor.bucketId = SquadConstructor.currentIndex
  constructor.players = {}
  constructor.eliminated = false

  SquadConstructor.currentIndex = SquadConstructor.currentIndex + 1
  RIVAL.Squads[constructor.id] = constructor

  SetRoutingBucketEntityLockdownMode(constructor.bucketId, 'inactive')
  SetRoutingBucketPopulationEnabled(constructor.bucketId, false)

  return constructor
end

function SquadConstructor:iteratePlayers(cb)
  for player, data in pairs(self.players) do
    cb(player, data)
  end
end

function SquadConstructor:addPlayer(player)
  if player and RIVAL.Players[player] then
    RIVAL.Players[player].squadId = self.id
    self.players[player] = RIVAL.Players[player]

    self:iteratePlayers(function(_, data)
      TriggerClientEvent('RIVAL::handleLocalEvent', data.source, 'onPlayerJoinSquad', player)
    end)
  end
end

function SquadConstructor:removePlayer(player)
  if player then
    self.players[player] = nil

    -- Squad wil be empty so delete it
    if self:getPlayerCount() == 0 then
      self = nil
    else
      self:iteratePlayers(function(_, data)
        TriggerClientEvent('RIVAL::handleLocalEvent', data.source, 'onPlayerLeftSquad', player)
      end)

      self:adjustPositions()
    end

    TriggerEvent('RIVAL::onLeaveSquad', player, self)
  end
end

function SquadConstructor:getPlayerCount()
  local tempCount = 0
  for _ in pairs(self.players) do
    tempCount = tempCount + 1
  end

  return tempCount
end

function SquadConstructor:deleteSquad()
  RIVAL.Squads[self.id] = nil
  local constructor = setmetatable({}, self)

  return constructor
end

function SquadConstructor:adjustPositions()
  local midPos = false
  local leftPos = false
  local rightPos = false

  self:iteratePlayers(function(player, data)
    midPos = data.position == 'middle' and player or false
    leftPos = data.position == 'left' and player or false
    rightPos = data.position == 'right' and player or false
  end)

  if not midPos then
    if leftPos then
      self:setPlayerProperty(leftPos, {'position', 'middle'})
    elseif rightPos then
      self:setPlayerProperty(rightPos, {'position', 'middle'})
    end
  end

  self:syncAllClients()
end

function SquadConstructor:syncAllClients()
  self:iteratePlayers(function(player, data)
    TriggerClientEvent('RIVAL::setClientSquad', data.source, self)
  end)
end

function SquadConstructor:setPlayerProperty(player, data)
  local key, value = table.unpack(data)
  self.players[player][key] = value
end

function SquadConstructor:getPlayerProperty(player, key)
  return self.players[player][key]
end

function SquadConstructor:gotEliminated()
  self.eliminated = true
end

function SquadConstructor:resetElimiation()
  self.eliminated = false
end

function SquadConstructor:isReady()
  local ready = true

  self:iteratePlayers(function(player, data)
    if not data.ready then
      ready = false
    end
  end)

  return ready
end
