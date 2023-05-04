SQUAD = {}
SQUAD.qualifiedTickets = {}

function SQUAD:inviteClient(source, squadId, targetUID)
  local p = promise.new()
  local playerSrc = RIVAL:getPlayerSource(targetUID)
  local clientName = GetPlayerName(source)
  local ticket = generateTicket()

  SQUAD.qualifiedTickets[ticket] = RIVAL:getPlayer(source)

  try {
    function()
      local response = TriggerClientCallback('RIVAL::inviteClient', playerSrc, clientName, ticket)
      local accepted, clientTicket = table.unpack(response)

      if SQUAD.qualifiedTickets[clientTicket] then
        if ticket == clientTicket and accepted then
          p:resolve(true)
        else
          p:reject(false)
        end
      else
        p:reject(false)
      end
    end,
    function()
      p:reject(false)
    end,
  }

  return Citizen.Await(p)
end

RegisterServerEvent('RIVAL::clientInvitationProcess', function(targetPlayer)
  local source = source
  local player = RIVAL:getPlayer(source)
  local Squad = RIVAL:getPlayerSquad(player)
  local playerData, targetPlayerData = RIVAL:getPlayerData(player), RIVAL:getPlayerData(targetPlayer)

  if not Squad then
    return
  end

  try {
    function()
      local validated = SQUAD:inviteClient(source, Squad.Id, targetPlayer) -- Send a Notification to the client and wait for their response.

      if validated then
        if targetPlayer ~= player and playerData.squadId ~= targetPlayerData.squadId then -- Verify so both clients arent the same person or in the same SQUAD.
          SQUAD:changeSquadState(targetPlayer, player)
        end
      end
    end,
    function()
      -- This func will be run if the client rejects the invitation
    end,
  }
end)

function SQUAD:syncAllClients(Squad)
  Squad:iteratePlayers(function(player, data)
    TriggerClientEvent('RIVAL::setClientSquad', data.source, Squad)
  end)
end

RegisterServerEvent('RIVAL::setClientReady', function(value)
  local source = source
  local player = RIVAL:getPlayer(source)
  local Squad = RIVAL:getPlayerSquad(player)

  Squad:setPlayerProperty(player, {'ready', value})
  Squad:syncAllClients()
end)

function SQUAD:findPosition(Squad)
  local pos

  Squad:iteratePlayers(function(player, data)
    local position = data.position

    if position ~= middle then
      if position == 'left' then
        pos = 'right'
      elseif position == 'right' then
        pos = 'left'
      end
    end
    if pos == nil then
      pos = 'left'
    end
  end)

  return not pos and 'middle' or pos
end

function SQUAD:changeSquadState(player, targetPlayer)
  local source = RIVAL:getPlayerSource(player)
  local playerUID = RIVAL:getPlayer(source)
  local Squad, targetPlayerSquad = RIVAL:getPlayerSquad(player), RIVAL:getPlayerSquad(targetPlayer)

  if not Squad or not targetPlayerSquad then
    return
  end

  local position = SQUAD:findPosition(targetPlayerSquad) -- Find an avaliable position
  RIVAL.Players[playerUID].position = position
  RIVAL.Players[playerUID].ready = false

  if targetPlayerSquad:getPlayerCount() < 3 then
    Squad:removePlayer(playerUID)
    targetPlayerSquad:addPlayer(playerUID)

    targetPlayerSquad:syncAllClients()
    TriggerClientEvent('RIVAL::clientEnterSquad', source, targetPlayerSquad.id, position)

    if Squad:getPlayerCount() == 0 then -- Delete Squad if it's empty
      Squad:deleteSquad()
    end
  end
end

RegisterServerEvent('RIVAL::setRoutingBucket', function()
  local source = source
  local player = RIVAL:getPlayer(source)
  local Squad = RIVAL:getPlayerSquad(player)

  SetPlayerRoutingBucket(source, Squad.bucketId)
end)

RegisterServerEvent('RIVAL::setSquadWaiting', function(gameMode)
  local source = source
  local player = RIVAL:getPlayer(source)
  local Squad = RIVAL:getPlayerSquad(player)

  if Squad:isReady() and Squad:getPlayerCount() == SHARED_CONFIG.playerCount[gameMode] then
    GAME:findAvaliableGame(player, gameMode)
  end
end)

RegisterServerCallback('RIVAL::getPlayerSquad', function(source)
  local player = RIVAL:getPlayer(source)

  return RIVAL:getPlayerSquad(player)
end)

AddEventHandler('RIVAL::onLeaveSquad', function(player, squad)
  -- Removes all the current invites the client has sent.
  for ticketId, ticketAuthor in pairs(SQUAD.qualifiedTickets) do
    if ticketAuthor == player then
      SQUAD.qualifiedTickets[ticketId] = nil
    end
  end
end)

RegisterServerEvent('RIVAL::exitSquad', function()
  local source = source
  local player = RIVAL:getPlayer(source)
  local Squad = RIVAL:getPlayerSquad(player)
  local newSquad = SquadConstructor()

  Squad:removePlayer(player)

  newSquad:addPlayer(player)
  newSquad:setPlayerProperty(player, {'position', 'middle'})

  newSquad:syncAllClients()
  Squad:syncAllClients()

  TriggerClientEvent('RIVAL::clientEnterSquad', source, newSquad.id)
  TriggerClientEvent('RIVAL::setClientSquad', source, newSquad)
end)

RegisterServerCallback('RIVAL::fetchPlayerData', function(source)
  local data = {
    level = 0,
    minLevelXp = 0,
    currentXp = 0,
    nextLevelXp = 0,
    dailyChallenges = CHALLENGES:getChallenges(source),
  }

  local player = RIVAL:getPlayer(source)
  local currentXp = LEVEL_SYSTEM:getPlayerXP(player)

  if not currentXp then
    return
  end

  data.currentXp = currentXp
  data.level = LEVEL_SYSTEM:getLevel(currentXp)
  data.minLevelXp = LEVEL_SYSTEM:getXP(data.level)
  data.nextLevelXp = LEVEL_SYSTEM:getXpForNextLevel(data.level)

  return data
end)
