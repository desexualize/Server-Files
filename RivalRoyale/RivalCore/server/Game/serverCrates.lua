CRATES = {}
CRATES.cratesPerGame = math.random(3, 5)
CRATES.spawnedCrates = {}
CRATES.lootDrops = {}
CRATES.spawnCoords = SERVER_CONFIG.crateCoords

function CRATES:getRandomCoords()
  return CRATES.spawnCoords[math.random(1, #CRATES.spawnCoords)]
end

function CRATES:getLoot()
  local loot = {}

  for i = 1, math.random(3, 6) do
    local randItem = CRATES.lootDrops[math.random(1, #CRATES.lootDrops)]

    if loot[randItem] then
      loot[randItem] = loot[randItem] + 1
    else
      loot[randItem] = 1
    end
  end

  return loot
end

function CRATES:convertItems(_loot)
  if not _loot then
    return
  end

  local loot = {}
  for item, amount in pairs(_loot) do
    local itemType = ''
    if string.find(item, 'Ammo') then
      itemType = 'ammo'
    else
      itemType = INVENTORY:getItemType(item)
    end

    loot[#loot + 1] = {label = item, type = itemType, amount = amount}
  end

  local fixedInv = INVENTORY:getEmptyItems(12 - #loot)
  loot = tableMerge(loot, fixedInv)

  return loot
end

-- Checks so no other players are viewing the crate
function CRATES:getViewingPlayers(source, crate)
  for _, _crate in pairs(INVENTORY.openedInventory) do
    if _ ~= source and _crate[2] == crate then
      return true
    end
  end

  return false
end

function CRATES:spawnCrates(Game)
  for i = 1, CRATES.cratesPerGame do
    while true do
      Wait(10)

      coords = self:getRandomCoords()

      if not Game.allocatedCoords[coords] then
        break
      end
    end

    local crateObject = CreateObjectNoOffset(GetHashKey('ex_prop_crate_ammo_sc'), coords)
    local _loot = CRATES:getLoot()
    local loot = CRATES:convertItems(_loot)

    SetEntityDistanceCullingRadius(crateObject, 15000.0)
    SetEntityRoutingBucket(crateObject, Game.bucketId)

    CRATES.spawnedCrates[crateObject] = loot
    Game.allocatedCoords[coords] = crateObject

    Game:iteratePlayers(function(player, data)
      TriggerClientEvent('RIVAL::placeEntityOnGround', data.source, NetworkGetNetworkIdFromEntity(crateObject))
    end)

    Wait(500)
  end
end

RegisterServerEvent('RIVAL::clientOpenedCrate', function()
  local source = source
  local playerCoords = GetEntityCoords(GetPlayerPed(source))
  local player = RIVAL:getPlayer(source)
  local Game = RIVAL:getPlayerGame(player)
  local selectedCrate = nil

  for coords, _ in pairs(Game.allocatedCoords) do
    if #(playerCoords - coords) < 3.0 and type(_) == 'number' then
      selectedCrate = _
    end
  end

  if not CRATES:getViewingPlayers(source, selectedCrate) then
    if CRATES.spawnedCrates[selectedCrate] then
      INVENTORY.secondaryItems[source] = CRATES.spawnedCrates[selectedCrate]
      INVENTORY.openedInventory[source] = {'CRATE', selectedCrate}

      return TriggerClientEvent('RIVAL::openSecondaryInv', source)
    end
  else
    return TriggerClientEvent('RIVAL::pushNotification', source, 'message', 'Someone is viewing the crate')
  end

  INVENTORY.openedInventory[source] = {nil, nil}
end)

-- Initialize loot drops
CreateThread(function()
  for item, chance in pairs(SERVER_CONFIG.crateDrops) do
    for i = 1, chance do
      CRATES.lootDrops[#CRATES.lootDrops + 1] = item
    end
  end
end)

-- Removes objects if they current resource gets stopped
-- Not used in prod
AddEventHandler('onResourceStop', function(resourceName)
  if GetCurrentResourceName() ~= resourceName then
    return
  end

  for crate, _ in pairs(CRATES.spawnedCrates) do
    DeleteEntity(crate)
  end
end)
