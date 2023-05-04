GM = {}
GM.playerCount = {['SOLO'] = 0, ['DUOS'] = 0, ['TRIOS'] = 0}

function GM:startGame(Game)
  if not Game then
    return
  end

  -- Gets a random route
  local route = GAME:getRoute()

  -- Creates a vehicle and gets netId
  local aircraftHandle = createVehicleFromServer('Miljet', route.start, 180.0)
  local planeNetId = NetworkGetNetworkIdFromEntity(aircraftHandle)

  -- Configure the vehicle
  SetEntityRoutingBucket(aircraftHandle, Game.bucketId)
  SetEntityDistanceCullingRadius(aircraftHandle, 1000000.0)

  Game:iteratePlayers(function(player, data)
    SetPlayerRoutingBucket(data.source, Game.bucketId)
    TriggerClientEvent('RIVAL::startGame', data.source, route, planeNetId)

    CreateThread(function()
      -- Clears inventory
      INVENTORY:clearInventory(data.source)
    end)
  end)

  Wait(75 * 1000) -- Wait for 75 seconds

  -- Creats a storm client sided
  Game:iteratePlayers(function(player, data)
    TriggerClientEvent('RIVAL::createStorm', data.source, route.zone)
  end)
end

function GM:placeVehicles(Game)
  if not Game then
    return
  end

  for i = 1, 2 do -- Water vehicles
    local vehList = SERVER_CONFIG.vehicleSpawns['Water']

    while true do
      Wait(10)

      spawnCoord = vehList[math.random(1, #vehList)] -- gets random position
      if not Game.allocatedCoords[spawnCoord] then
        break
      end
    end

    local vehicleHandle = createVehicleFromServer(GetHashKey('seashark2'), spawnCoord, 0.0)

    Game.allocatedCoords[spawnCoord] = true

    SetEntityRoutingBucket(vehicleHandle, Game.bucketId)
    SetEntityDistanceCullingRadius(vehicleHandle, 1000000.0)

    -- Sends the netId to client
    Game:iteratePlayers(function(player, data)
      TriggerClientEvent('RIVAL::vehiclePlaced', data.source, NetworkGetNetworkIdFromEntity(vehicleHandle), 'water')
    end)
  end

  for i = 1, 2 do -- Land vehicles
    local vehList = SERVER_CONFIG.vehicleSpawns['Land']
    local spawnCoord = vehList[math.random(1, #vehList)] -- gets a random position

    while true do
      Wait(10)

      spawnCoord = vehList[math.random(1, #vehList)] -- gets random position
      if not Game.allocatedCoords[spawnCoord] then
        break
      end
    end

    local vehicleHandle = createVehicleFromServer(GetHashKey('blazer3'), spawnCoord, 0.0)

    SetEntityRoutingBucket(vehicleHandle, Game.bucketId)
    SetEntityDistanceCullingRadius(vehicleHandle, 1000000.0)

    -- Sends the netId to client
    Game:iteratePlayers(function(player, data)
      TriggerClientEvent('RIVAL::vehiclePlaced', data.source, NetworkGetNetworkIdFromEntity(vehicleHandle), 'land')
    end)
  end
end

function GM:checkForEnding(Game)
  return Game and Game:getSquadCount() == 1
end

RegisterServerCallback('RIVAL::getPlayerCount', function(source, gameMode)
  return GM.playerCount[gameMode]
end)

function GM:getPlayerCount(gm)
  local count = 0
  for _, Game in pairs(RIVAL.Games) do
    if Game.gameMode == gm then
      count = count + Game:getPlayerCount()
    end
  end

  return count
end

CreateThread(function()
  while true do
    -- Updates the player count
    GM.playerCount['SOLO'] = GM:getPlayerCount('SOLO')
    GM.playerCount['DUOS'] = GM:getPlayerCount('DUOS')
    GM.playerCount['TRIOS'] = GM:getPlayerCount('TRIOS')

    Wait(10 * 1000)
  end
end)
