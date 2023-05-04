FL = {}
FL.validRequests = {}
FL.cache = {}
FL.currentTicket = 0

-- Updates the user data in database
-- Call this as little as possible
function FL:refreshList(player, list)
  local query = ('UPDATE rival_userdata SET Friends=\' %s \' WHERE UID = %s'):format(json.encode(list), player)
  DATABASE:queryAsync(query)
end

function FL:getList(player)
  local query = ('SELECT Friends FROM rival_userdata WHERE UID = %s'):format(player)
  local rows = DATABASE:queryResult(query)

  return rows[1] and json.decode(rows[1].Friends) or rows[1]
end

-- Fetches friendlist
RegisterServerCallback('RIVAL::fetchFriends', function(source)
  local player = RIVAL:getPlayer(source)
  local friendList = FL:getList(player)

  if not friendList then
    return
  end

  -- Declare variables
  FL.cache[player] = friendList
  local refreshedList = {}
  local formatedList = {}
  local needsUpdating = false

  -- Updates the list and names of friends
  if friendList then
    for playerName, playerId in pairs(friendList) do
      local source = RIVAL:getPlayerSource(playerId)
      local updatedName = source and GetPlayerName(source) or playerName

      -- Format the player
      formatedList[updatedName] = {id = playerId, status = source == nil and 'OFFLINE' or 'ONLINE'}
      if playerName ~= updatedName then
        needsUpdating = true
      end

      refreshedList[updatedName] = playerId
    end
  end

  -- List needs updating
  if needsUpdating and refreshedList ~= friendList then
    FL:refreshList(player, refreshedList)
  end

  -- Return value to client
  return formatedList
end)

RegisterServerEvent('RIVAL::removeFriend', function(target)
  local source = source
  local player = RIVAL:getPlayer(source)
  local foundCache = FL.cache[player]
  local targetList = FL.cache[target]

  -- Could not found cache
  -- Player tried removing a friend without opening the friend menu or cache failed
  if not foundCache then
    return DropPlayer(source, json.encode(debug.getinfo(1, 'Sl')))
  end

  if not targetList then
    targetList = FL:getList(target)

    -- Failed to retreive cache
    if not targetList then
      return
    end
  end

  -- Removes the selected target
  for k, v in pairs(foundCache) do
    if v == target then
      foundCache[k] = nil
    end
  end

  -- Removes the selected target
  for k, v in pairs(targetList) do
    if v == player then
      targetList[k] = nil
    end
  end

  -- Updates cache for both players
  FL.cache[player] = foundCache
  FL.cache[target] = targetList

  FL:refreshList(player, foundCache)
  FL:refreshList(target, targetList)
end)

RegisterServerEvent('RIVAL::sendFriendReq', function(target)
  local source = source
  local targetSource = RIVAL:getPlayerSource(target)
  if not targetSource or source == targetSource then
    return
  end

  -- declare variables
  FL.currentTicket = FL.currentTicket + 1
  local name = GetPlayerName(source) or 'Unknown'
  local player = RIVAL:getPlayer(source)
  local foundCache = FL.cache[player] or {}
  local canContinue = true

  for k, v in pairs(FL.validRequests) do
    -- Has already sent a friend request
    if v == player then
      canContinue = false
    end
  end

  if not canContinue then
    return
  end

  local ticket = FL.currentTicket
  FL.validRequests[ticket] = player

  -- Send client req and wait for their response
  local response = TriggerClientCallback('RIVAL::friendReqReceieved', targetSource, name, ticket)
  local accepted, clientTicket = table.unpack(response)

  -- Target accepted and ticket got verified
  if accepted and clientTicket == ticket then

    -- Update the player's list
    foundCache[GetPlayerName(targetSource)] = target
    FL:refreshList(player, foundCache)

    -- Update the target's list
    local query = ('SELECT Friends FROM rival_userdata WHERE UID = %s'):format(target)
    local rows = DATABASE:queryResult(query)
    local friendList = json.decode(rows[1].Friends) or {}

    friendList[name] = player
    FL:refreshList(target, friendList)
  end

  -- Unvalidates the ticket
  FL.validRequests[ticket] = nil
end)

RegisterServerCallback('RIVAL::fetchOnlinePlayers', function(source)
  local tempList = {}
  for k, v in pairs(GetPlayers()) do
    local player = tonumber(v)

    if player ~= source then
      tempList[GetPlayerName(player)] = RIVAL:getPlayer(player)
    end
  end

  return tempList
end)
