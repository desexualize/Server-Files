ADMIN = {}
ADMIN.recordings = {}

RegisterServerCallback('RIVAL::getPlayerInfo', function(source, targetPlayer)
  local _source = RIVAL:getPlayerSource(targetPlayer)
  local query = ('SELECT `Last-Join` FROM rival_stats WHERE UID = 1'):format(targetPlayer)
  local lastLogin = DATABASE:queryResult(query)[1]['Last-Join']

  return {
    UID = targetPlayer,
    name = GetPlayerName(_source),
    status = _source and 'ONLINE' or 'OFFLINE',
    lastLogin = os.date('%Y-%m-%d', lastLogin) or 'Unknown',
  }
end)

RegisterServerCallback('RIVAL::getPlayers', function(source)
  local tempPlayerList = {}

  for k, v in pairs(GetPlayers()) do
    local _source = tonumber(v)
    local player = RIVAL:getPlayer(_source)

    if _source ~= source then
      tempPlayerList[#tempPlayerList + 1] = {UID = player, name = GetPlayerName(tonumber(v))}
    end
  end

  return tempPlayerList
end)

RegisterServerCallback('RIVAL::requestAccess', function(source)
  local player = RIVAL:getPlayer(source)
  local level = RIVAL:getAdminLevel(player)

  return level > 0
end)

function ADMIN:dropPlayer(adminSource, playerSource)
  if not targetPlayer then
    return
  end

  DropPlayer(playerSource, ('[Rival Warfare] You have been kicked by'):format(GetPlayerName(adminSource)))
end

function ADMIN:banClient(adminSource, playerSource)
  local banReason = TriggerClientCallback('RIVAL::handlePrompt', adminSource, 'ENTER REASON FOR BAN')[2]
  Wait(100)
  local banTime = tonumber(TriggerClientCallback('RIVAL::handlePrompt', adminSource, 'ENTER BAN TIME (HOURS)')[2])
  local player = RIVAL:getPlayer(playerSource)

  if not banReason or not banTime or type(banTime) ~= 'number' then
    return
  end

  RIVAL:banClient(player, adminSource, banReason, os.time() + (3600 * banTime))
end

function ADMIN:registerWarning(adminSource, playerSource)
  local clientData = TriggerClientCallback('RIVAL::handlePrompt', playerSource, 'ENTER WARN REASON:')
  local validResult, warningReason = table.unpack(clientData)
  local targetPlayer = RIVAL:getPlayer(playerSource)

  if validResult and warningReason then
    WARNING_SYSTEM:insertWarning(targetPlayer, 'Warning', GetPlayerName(playerSource), warningReason)
  end
end

function ADMIN:showWarnings(adminSource, playerSource)
  local player = RIVAL:getPlayer(playerSource)
  local warnings = WARNING_SYSTEM:getWarnings(player)

  if warnings then
    TriggerClientEvent('RIVAL::showWarnings', adminSource, warnings)
  end
end

function ADMIN:spectatePlayer(adminSource, playerSource)
  local player = RIVAL:getPlayer(playerSource)
  local playerGame = RIVAL:getPlayerGame(player)
  local playerSquad = RIVAL:getPlayerSquad(player)
  local entityCoords = GetEntityCoords(GetPlayerPed(playerSource))
  local routingBucket = playerGame and playerGame.bucketId or playerSquad.bucketId

  SetPlayerRoutingBucket(adminSource, routingBucket)
  TriggerClientEvent('RIVAL::spectatePlayer', adminSource, playerSource, entityCoords)
end

-- Action table
ADMIN.invokeAction = {
  ['BAN'] = {fn = ADMIN.banClient, level = 5},
  ['KICK'] = {fn = ADMIN.dropPlayer, level = 4},
  ['REGISTER WARNING'] = {fn = ADMIN.registerWarning, level = 2},
  ['SHOW WARNINGS'] = {fn = ADMIN.showWarnings, level = 1},
  ['SPECTATE'] = {fn = ADMIN.spectatePlayer, level = 3},
}

setmetatable(ADMIN.invokeAction, {
  __call = function(self, _, action, adminSource, playerSource)
    if ADMIN.invokeAction[action] then
      return ADMIN.invokeAction[action].fn(nil, adminSource, playerSource)
    end
  end,
})

RegisterServerEvent('RIVAL::performAction', function(targetPlayer, action)
  local source = source
  local player = RIVAL:getPlayer(source)

  -- Player can not perform actions on them selves
  if player == targetPlayer then
    return
  end

  local name = GetPlayerName(source)
  local admin = RIVAL:getAdminLevel(player)
  local playerSource = RIVAL:getPlayerSource(targetPlayer)

  -- Make sure admin has permission to perform action
  if admin >= ADMIN.invokeAction[action].level then
    -- Call the action
    ADMIN:invokeAction(action, source, playerSource)

    RIVAL.Hook('Admin', {
      title = 'RIVAL WARFARE | ADMIN LOGS',
      fields = {
        {name = 'Player Name:', value = name or 'Unknown', inline = true},
        {name = 'User ID:', value = player or 'Unknown', inline = true},
        {name = 'Admin Level', value = tostring(admin) or '0', inline = true},

        {name = 'Action', value = action or 'Invalid Action', inline = true},
        {name = 'Target ID', value = targetPlayer or 'Unknown', inline = true},
        {name = 'Target Source', value = playerSource or 'Unknown', inline = true},
      },
    })
  end
end)

