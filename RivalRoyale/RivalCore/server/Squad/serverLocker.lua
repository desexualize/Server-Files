LOCKER = {}
LOCKER.cache = {}

function LOCKER:getPlayerClothing(player)
  local source = RIVAL:getPlayerSource(player)
  if LOCKER.cache[source] then
    return LOCKER.cache[source]
  end

  local newCache = LOCKER:handleCache(source, player)
  if newCache then
    return newCache
  end

  return {}
end

function LOCKER:ownsItem(source, componentName, componentId)
  for _, cloth in pairs(LOCKER.cache[source][componentName]) do
    if cloth == componentId then
      return true
    end
  end

  return false
end

function LOCKER:handleCache(source, player)
  local query = ('SELECT OwnedClothing FROM rival_userdata WHERE UID = %s'):format(player)
  local rows = DATABASE:queryResult(query)

  if #rows > 0 then
    LOCKER.cache[source] = json.decode(rows[1].OwnedClothing)
    return LOCKER.cache[source]
  end
end

function LOCKER:convertToIndex(label)
  return SHARED_CONFIG.clothes[label]
end

RegisterServerCallback('RIVAL::fetchClothing', function(source)
  local player = RIVAL:getPlayer(source)
  return LOCKER:getPlayerClothing(player)
end)

function LOCKER:equipClothing(ped, cName, vIndex, textureId)
  local validComponent = LOCKER:convertToIndex(cName)
  SetPedComponentVariation(ped, validComponent, vIndex, textureId, 0)
end

RegisterServerEvent('RIVAL::swapClothingComponent', function(data)
  local source = source
  local player = RIVAL:getPlayer(source)
  local componentName, componentId, textureId = data.component, tonumber(data.componentId.id), tonumber(data.textureId)

  if not LOCKER.cache[source] then
    return DropPlayer(source, json.encode(debug.getinfo(1, 'Sl')))
  end

  local Locker = LOCKER.cache[source][componentName]

  for k, v in pairs(Locker) do
    if v == componentId then
      if componentName == 'Parachute' then
        TriggerClientEvent('RIVAL::setParachuteColor', source, componentId, ANTICHEAT:generateKey())
      else
        LOCKER:equipClothing(GetPlayerPed(source), componentName, componentId, textureId)
      end
    end
  end
end)

RegisterServerEvent('RIVAL::baseClothing', function(data)
  local source = source
  local player = RIVAL:getPlayer(source)
  local query = ('SELECT OwnedClothing FROM rival_userdata WHERE UID = %s'):format(player)
  local rows = DATABASE:queryResult(query)

  if #rows > 0 then
    LOCKER.cache[source] = json.decode(rows[1].OwnedClothing)
    local locker = LOCKER.cache[source]

    for _, clothingData in pairs(data) do
      local componentName = clothingData.component
      local componentId, textureId = tonumber(clothingData.componentId), tonumber(clothingData.textureId)
      componentId = locker[componentName][tonumber(componentId + 1)]

      if componentName == 'Parachute' then
        TriggerClientEvent('RIVAL::setParachuteColor', source, componentId, ANTICHEAT:generateKey())
      else
        if LOCKER:ownsItem(source, componentName, componentId) then
          LOCKER:equipClothing(GetPlayerPed(source), componentName, componentId, textureId)
        end
      end
    end
  else
    DropPlayer(source, json.encode(debug.getinfo(1, 'Sl')))
  end
end)
