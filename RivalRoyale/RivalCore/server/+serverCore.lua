RIVAL = {}
RIVAL.Squads = {}
RIVAL.Games = {}
RIVAL.rateLimitedEvents = SERVER_CONFIG.rateLimitedEvents
RIVAL.developerServer = GetConvarInt('dev_server', 0) == 1

RIVAL.Players = {
  -- UID is the key / index
  -- [1] = {
  --   name = 'Katos',
  --   source = 1,
  --   squadId = nil,
  --   gameId = nil,
  --   ready = false,
  --   leader = true,
  --   joinTime = 0,
  --   position = 'middle',
  --   avatar = '',
  -- },
  -- [2] = {
  --   name = 'Katos2',
  --   source = 2,
  --   squadId = nil,
  --   gameId = nil,
  --   ready = false,
  --   leader = true,
  --   position = 'middle',
  --   avatar = '',
  -- },
}

-- Player methods

function RIVAL:getPlayer(source)
  for player, data in pairs(RIVAL.Players) do
    if data.source == source then
      return player
    end
  end

  -- Could not verify id
  return DropPlayer(source, json.encode(debug.getinfo(1, 'Sl')))
end

function RIVAL:getPlayerSquad(player)
  local playerData = RIVAL:getPlayerData(player)
  return RIVAL.Squads[playerData.squadId]
end

function RIVAL:getPlayerGame(player)
  local playerData = RIVAL:getPlayerData(player)
  return RIVAL.Games[playerData.gameId]
end

function RIVAL:getPlayerData(player)
  return RIVAL.Players[player]
end

function RIVAL:getPlayerSource(player)
  return RIVAL.Players[player] and RIVAL.Players[player].source
end

function RIVAL:getAdminLevel(player)
  return DATABASE:queryResult(('SELECT Admin FROM rival_userdata WHERE UID = %s'):format(player))[1].Admin or 0
end

function RIVAL:banClient(player, adminSource, reason, time, anticheatBan)
  if not player or not reason or not time then
    return
  end

  local source = RIVAL:getPlayerSource(player)
  if not source then
    return
  end

  local adminName = anticheatBan and 'ANTICHEAT' or GetPlayerName(adminSource) or 'Unknown'
  local banDate = os.time()

  local query =
    ('UPDATE rival_userdata SET BanTime = %s, BanDate = %s, BanReason = "%s", BannedBy = "%s" WHERE UID = %s'):format(
      time, banDate, reason, adminName, player)

  DATABASE:queryAsync(query)
  DropPlayer(source, '[Banned] You were banned by ' .. adminName)
end

function RIVAL:getPlayerBan(player)
  local query = ('SELECT BanTime, BanDate, BanReason, BannedBy FROM rival_userdata WHERE UID = %s'):format(player)
  local rows = DATABASE:queryResult(query)

  return rows[1]
end

function RIVAL:banExpired(player)
  local query =
    ('UPDATE rival_userdata SET BanTime = 0, BanDate = NULL, BanReason = NULL, BannedBy = NULL WHERE UID = %s'):format(
      player)
  DATABASE:queryAsync(query)
end

function RIVAL:getBanCard(player, reason, timeLeft, bannedBy)
  local presentedCard = {
    ['type'] = 'AdaptiveCard',
    ['body'] = {
      {
        ['type'] = 'TextBlock',
        ['size'] = 'Large',
        ['weight'] = 'Bolder',
        ['text'] = 'YOU HAVE BEEN BANNED!',
        ['separator'] = true,
      },
      {['type'] = 'TextBlock', ['text'] = 'UID = ' .. player, ['weight'] = 'Bolder', ['spacing'] = 'Medium'},
      {['type'] = 'TextBlock', ['text'] = reason, ['weight'] = 'Bolder'},
      {['type'] = 'TextBlock', ['text'] = 'You have ' .. timeLeft .. ' left', ['weight'] = 'Bolder'},
      {['type'] = 'TextBlock', ['text'] = 'Banned by ' .. bannedBy, ['weight'] = 'Bolder'},
      {
        ['type'] = 'ColumnSet',
        ['spacing'] = 'Medium',
        ['columns'] = {
          {
            ['type'] = 'Column',
            ['items'] = {
              {
                ['type'] = 'Image',
                ['url'] = 'https://cdn.discordapp.com/attachments/708610221970554950/909548490701570078/Logo-01.png',
                ['size'] = 'Medium',

              },
            },
            ['width'] = 'auto',
          },
          {
            ['type'] = 'Column',
            ['items'] = {
              {['type'] = 'TextBlock', ['weight'] = 'Bolder', ['text'] = 'Rival Royale', ['wrap'] = true},
              {
                ['type'] = 'TextBlock',
                ['spacing'] = 'None',
                ['text'] = 'discord.gg/Rival',
                ['isSubtle'] = true,
                ['wrap'] = true,
              },
            },
            ['width'] = 'stretch',
          },
        },
      },
    },
    ['$schema'] = 'https://adaptivecards.io/schemas/adaptive-card.json',
    ['version'] = '1.0',
  }

  return presentedCard
end

function RIVAL:formatBanTime(banTime)
  local timeLeft = math.floor((banTime - os.time()) / 3600)
  if timeLeft == 0 then
    return math.floor((banTime - os.time()) / 60) .. ' minutes'
  end

  return timeLeft .. ' hours'
end

-- Game methods

function RIVAL:getGame(gameId)
  return RIVAL.Games[gameId]
end

-- Squad methods
function RIVAL:getSquad(squadId)
  return RIVAL.Squads[squadId]
end

function RIVAL:restoreTokens(UID, source)
  local numTokens = GetNumPlayerTokens(source) - 1

  for indexToken = 1, numTokens do
    local currentToken = GetPlayerToken(source, indexToken)

    if currentToken then
      local query = ('SELECT Token FROM rival_ids WHERE Token = "%s"'):format(currentToken)
      local rows = DATABASE:queryResult(query)

      if #rows == 0 then
        local insertQuery = ('INSERT INTO rival_ids (UID, Token) VALUES (%s, "%s")'):format(UID, currentToken)
        DATABASE:queryAsync(insertQuery)
      end
    end
  end
end

function RIVAL:createUser(source, numTokens)
  if not numTokens or numTokens == 0 then
    return
  end

  local query = 'INSERT INTO rival_userdata () VALUES (); SELECT LAST_INSERT_ID() AS UID'
  local rows = DATABASE:queryResult(query)
  local player = rows[1] and rows[1].UID

  if #rows > 0 and player then
    -- Inserts all tokens in the database
    for k = 1, numTokens do
      local Token = GetPlayerToken(source, k)

      if Token then
        local query = ('INSERT INTO rival_ids (UID, Token) VALUES(%s, "%s")'):format(player, Token)
        DATABASE:queryAsync(query)
      end
    end

    -- Inserts a new row in rival_stats
    local data = table.pack(player, tostring(os.time()), tostring(os.time()))
    local query = ('INSERT INTO rival_stats (UID, `First-Join`, `Last-Join`) VALUES(%s,%s,%s)'):format(
                    table.unpack(data))

    DATABASE:queryAsync(query)
  end
end

function RIVAL:handleTokens(source)
  local numTokens = GetNumPlayerTokens(source) - 1
  local indexToken = 0

  local function searchTokens()
    indexToken = indexToken + 1

    if indexToken <= numTokens then
      local foundToken = GetPlayerToken(source, indexToken)

      if foundToken then
        local query = ('SELECT UID FROM rival_ids WHERE Token = "%s"'):format(foundToken)
        local rows = DATABASE:queryResult(query)

        if #rows > 0 then
          local foundId = rows[1].UID

          RIVAL.Players[foundId] = {
            name = GetPlayerName(source),
            source = source,
            squadId = nil,
            gameId = nil,
            ready = false,
            leader = true,
            joinTime = os.time(),
            position = 'middle',
            avatar = '',
          }

          local query = ('UPDATE rival_stats SET `Last-Join` = %s WHERE UID = %s'):format(tostring(os.time()), foundId)
          DATABASE:queryAsync(query)
          RIVAL:restoreTokens(foundId, source)
        else
          searchTokens()
        end
      end
    else
      RIVAL:createUser(source, numTokens)
    end
  end

  searchTokens()
end

AddEventHandler('playerConnecting', function(name, setKickReason, deferrals)
  local source = source
  deferrals.defer()

  if #name >= SERVER_CONFIG.maxNameLength then
    return deferrals.done('Your name is to long, max characters = ' .. SERVER_CONFIG.maxNameLength)
  end

  RIVAL:handleTokens(source)

  local player = RIVAL:getPlayer(source)
  local name = GetPlayerName(source)
  local banData = RIVAL:getPlayerBan(player)

  if player ~= 0 or player ~= nil then
    -- Player was or is still banned

    if banData then
      local banReason, banTime = banData.BanReason, tonumber(banData.BanTime)
      local banDate, bannedBy = tonumber(banData.BanDate), banData.BannedBy

      if banTime == 0 then
        return deferrals.done()
      end

      if banTime <= os.time() then
        -- Ban finished
        RIVAL:banExpired(player)
      else
        -- Player is still banned
        local timeLeft = RIVAL:formatBanTime(banTime)
        local banCard = RIVAL:getBanCard(player, banReason, timeLeft, bannedBy)

        return deferrals.presentCard(banCard)
      end
    end

    RIVAL.Hook('Connection', {
      title = 'RIVAL WARFARE | CONNECTION LOGS',
      fields = {
        {name = 'Connected', value = os.date('%X')},
        {name = 'Player Name =', value = name or 'Unknown', inline = true},
        {name = 'User ID =', value = player or 'Unknown', inline = true},
      },
    })
  end
end)

AddEventHandler('playerJoining', function(tempId)
  local source = source
  local player = RIVAL:getPlayer(tonumber(tempId))

  -- Updates the player source
  RIVAL.Players[player].source = source
  CHALLENGES:initPlayer(source)

  -- Updates the player banner
  local steamId = GetPlayerIdentifier(source, 'steam') or 76561198850860877

  local endpoint =
    'https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=170F57711FDAC84CCDCE1B160AF664E7&steamids=' ..
      steamId

  PerformHttpRequest(endpoint, function(statusCode, resultData, resultHeaders)
    if statusCode == 200 then
      local result = json.decode(resultData).response
      local avatar = result.players[1].avatarfull

      RIVAL.Players[player].avatar = avatar
    end
  end, 'GET', json.encode({}), {['Content-Type'] = 'application/json'})
end)

AddEventHandler('playerDropped', function(reason)
  local source = source
  local name = GetPlayerName(source)
  local player = RIVAL:getPlayer(source)
  local Squad = RIVAL:getPlayerSquad(player)
  local Game = RIVAL:getPlayerGame(player)

  if Squad then
    Squad:removePlayer(player)

    if Game then
      Game:syncSquad(Squad)
    end

    if Squad:getPlayerCount() == 0 then
      -- Delete squad if its empty
      Squad:deleteSquad()
    else
      Squad:adjustPositions()
    end
  end

  -- Update playtime
  local playerData = RIVAL:getPlayerData(player)
  if playerData then
    if playerData.joinTime > 0 then
      local minutesPlayed = math.floor((os.time() - tonumber(joinTime)) / 60)

      local query = ('UPDATE rival_stats SET Playtime = %s WHERE UID = %s'):format(minutesPlayed, player)
      DATABASE:queryAsync(query)
    end
  end

  -- Delete player from record
  RIVAL.Players[player] = nil

  if string.find(reason, 'Game crashed') then
    return DEBUG:hookCrash(source, reason)
  end

  RIVAL.Hook('Connection', {
    title = 'RIVAL WARFARE | CONNECTION LOGS',
    fields = {
      {name = 'Disconnected', value = 'Reason: ' .. reason},
      {name = 'Player Name:', value = name or 'Unknown', inline = true},
      {name = 'User ID:', value = player or 'Unknown', inline = true},
    },
  })
end)

-- Rate limits certain events.
function RegisterServerEvent(eventName, eventFunc)
  if eventName and eventFunc then
    if RIVAL.rateLimitedEvents[eventName] then
      RegisterNetEvent(eventName, function(...)
        local source = source
        local currentRate = RIVAL.rateLimitedEvents[eventName][source]

        if not currentRate then
          RIVAL.rateLimitedEvents[eventName][source] = 1
          return eventFunc(...)
        end

        if currentRate >= 4 then
          TriggerClientEvent('RIVAL::pushNotification', source, 'message', 'You are being rate limited, try again soon.')
        else
          RIVAL.rateLimitedEvents[eventName][source] = currentRate + 1
          return eventFunc(...)
        end
      end)
    else
      RegisterNetEvent(eventName, eventFunc)
    end
  end
end

CreateThread(function()
  while true do
    Wait(45 * 1000) -- Iterate every 45 seconds

    -- Resets the rate limit for every player
    for eventName, players in pairs(RIVAL.rateLimitedEvents) do
      RIVAL.rateLimitedEvents[eventName] = {}
    end
  end
end)

RegisterServerEvent('RIVAL::dropSelf', function(text)
  local source = source
  DropPlayer(source, text)
end)

RegisterServerEvent('RIVAL::playerJoined', function()
  local source = source
  local player = RIVAL:getPlayer(source)

  if not RIVAL:getPlayerSquad(player) then
    local squad = SquadConstructor()
    squad:addPlayer(player)

    TriggerClientEvent('RIVAL::setClientData', source, RIVAL.Players[player], squad)
  end
end)

if RIVAL.developerServer then
  print '[^1Dev Server^7] server is started as dev_server'
else
  print '[^Production Server^7] server is started as prod_server'
end
