LOOTING = {}

function LOOTING:placeGrave(source, Game)
  local playerPed = GetPlayerPed(source)
  local deathCoords = GetEntityCoords(playerPed)
  local graveObject = CreateObjectNoOffset(GetHashKey('prop_gravestones_09a'), deathCoords)

  Game.graveStones[graveObject] = INVENTORY.primaryItems[source]
  INVENTORY:setDefault(source)

  SetEntityDistanceCullingRadius(graveObject, 15000.0)
  SetEntityRoutingBucket(graveObject, Game.bucketId)

  Game:iteratePlayers(function(player, data)
    TriggerClientEvent('RIVAL::placeGrave', data.source, NetworkGetNetworkIdFromEntity(graveObject))
  end)
end

-- Checks so no other players are viewing the grave
function LOOTING:getViewingPlayers(source, graveStone)
  for _, grave in pairs(INVENTORY.openedInventory) do
    if _ ~= source and grave[2] == graveStone then
      return true
    end
  end

  return false
end

RegisterNetEvent('RIVAL::lootPlayer', function()
  local source = source
  local playerCoords = GetEntityCoords(GetPlayerPed(source))
  local player = RIVAL:getPlayer(source)
  local Game = RIVAL:getPlayerGame(player)
  local selectedGrave = nil

  if Game then
    for graveObject, graveCoords in pairs(Game.graveStones) do
      if #(playerCoords - GetEntityCoords(graveObject)) < 3.0 then
        selectedGrave = graveObject
      end
    end
  end

  if not LOOTING:getViewingPlayers(source, selectedGrave) then
    if selectedGrave then
      INVENTORY.secondaryItems[source] = Game.graveStones[selectedGrave]
      INVENTORY.openedInventory[source] = {'GRAVE', selectedGrave}

      return TriggerClientEvent('RIVAL::openSecondaryInv', source)
    end
  else
    return TriggerClientEvent('RIVAL::pushNotification', source, 'message', 'Someone is viewing the crate')
  end

  INVENTORY.openedInventory[source] = {nil, nil}
end)
