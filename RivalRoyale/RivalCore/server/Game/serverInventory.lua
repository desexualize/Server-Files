INVENTORY = {}
INVENTORY.holdingWeapons = {}
INVENTORY.openedInventory = {}
INVENTORY.primaryItems = {}
INVENTORY.secondaryItems = {}
INVENTORY.hotbarItems = {}

function INVENTORY.verifyItem(inventory, item, ignoreAmount)
  for k, v in pairs(inventory) do
    if v.type ~= 'empty' then
      if ignoreAmount then
        if v.label == item then
          return k
        end
      else
        if v.label == item.label and v.amount == item.amount then
          return k
        end
      end
    end
  end

  return false
end

function INVENTORY:getEmptyItem()
  return {label = '', type = 'empty', amount = 0}
end

function INVENTORY:setDefault(source)
  INVENTORY.primaryItems[source] = INVENTORY:getEmptyItems(12)
  INVENTORY.secondaryItems[source] = INVENTORY:getEmptyItems(12)
  INVENTORY.hotbarItems[source] = INVENTORY:getEmptyItems(4)
end

function INVENTORY:useWeapon(source, playerPed, label, hotbar)
  local selectedWeapon = GetSelectedPedWeapon(playerPed)
  local weaponHash = self:getWeaponHash(label)

  -- Checks if hash is valid and ped doesnt have a weapon
  if weaponHash and selectedWeapon == -1569615261 then
    if not hotbar then
      if not INVENTORY.holdingWeapons[source] then
        INVENTORY.holdingWeapons[source] = {}
      end

      INVENTORY.holdingWeapons[source][weaponHash] = true
    end

    return GiveWeaponToPed(playerPed, weaponHash, 0, true, true)
  end

  if hotbar then
    if weaponHash == selectedWeapon then
      return
    end

    local equippingAmount = TriggerClientCallback('RIVAL::fetchAmmoCount', source, weaponHash) or 0
    return GiveWeaponToPed(playerPed, weaponHash, 0, true, true)
  end
end

function INVENTORY:useThrowable(playerPed, label, hotbar)
  local selectedWeapon = GetSelectedPedWeapon(playerPed)
  local weaponHash = self:getWeaponHash(label)

  if weaponHash and selectedWeapon == -1569615261 then
    return GiveWeaponToPed(playerPed, weaponHash, 1, true, true)
  end

  if hotbar then
    GiveWeaponToPed(playerPed, weaponHash, 1, true, true)
  end
end

function INVENTORY:useAmmo(playerPed, label, amount)
  local weaponHash, currentAmmo = table.unpack(TriggerClientCallback('RIVAL::fetchAmmoInfo', source))
  if weaponHash then
    local weaponType = INVENTORY:getWeaponGroup(weaponHash)

    -- Correct ammo type
    if ('%s Ammo'):format(weaponType) == label then
      SetPedAmmo(playerPed, weaponHash, amount)
    end
  end
end

function INVENTORY:useItem(source, item, hotbar)
  local label, type, amount = item.label, item.type, item.amount
  local playerPed = GetPlayerPed(source)

  -- Weapon
  if type == 'weapon' then
    return INVENTORY:useWeapon(source, playerPed, label, hotbar)
  end

  -- Throwable
  if type == 'throwable' then
    return INVENTORY:useThrowable(playerPed, label, hotbar)
  end

  -- Ammo
  if type == 'ammo' then
    return INVENTORY:useAmmo(playerPed, label, amount)
  end
end

function INVENTORY:isInventoryFull(source, inventoryType)
  local items = INVENTORY:getRelativeInventory(source, inventoryType)
  for k, v in pairs(items) do
    if v.type == 'empty' then
      return k
    end
  end
end

function INVENTORY:getEmptyCount(source, inventoryType)
  local inventory = INVENTORY:getRelativeInventory(source, inventoryType)
  local count = 0

  if not inventory then
    return count
  end

  for _, item in pairs(inventory) do
    if item.label == '' then
      count = count + 1
    end
  end

  return count
end

function INVENTORY:pushItem(source, inventoryType, label, amount)
  local inventory = INVENTORY:getRelativeInventory(source, inventoryType)
  if not inventory or not label then
    return
  end

  local nextIndex = INVENTORY:isInventoryFull(source, inventoryType)
  if not nextIndex then
    -- Inventory is full
    return
  end

  INVENTORY[inventoryType .. 'Items'][source][nextIndex] = {
    label = label,
    type = SHARED_CONFIG.inventoryItems[label].group or 'empty',
    amount = amount or 0,
  }
end

function INVENTORY:clearInventory(source)
  local source = source
  local emptyItem = INVENTORY:getEmptyItem()

  for k, _ in pairs(INVENTORY.primaryItems[source]) do
    INVENTORY.primaryItems[source][k] = emptyItem
  end

  for k, _ in pairs(INVENTORY.secondaryItems[source]) do
    INVENTORY.secondaryItems[source][k] = emptyItem
  end

  for k, _ in pairs(INVENTORY.hotbarItems[source]) do
    INVENTORY.hotbarItems[source][k] = emptyItem
  end

  INVENTORY.holdingWeapons[source] = {}
end

function INVENTORY:storeItem(source, weaponHash, ammo)
  if INVENTORY.holdingWeapons[source] and INVENTORY.holdingWeapons[source][weaponHash] then
    local nextIndex = INVENTORY:isInventoryFull(source, 'primary')

    -- Returns if inventory is full
    if not nextIndex then
      return
    end

    -- Store item
    local weaponName = SHARED_CONFIG.weaponNames[weaponHash][1]

    if weaponName and weaponGroup then
      INVENTORY.holdingWeapons[source][weaponHash] = nil
      INVENTORY.primaryItems[source][nextIndex] = {label = weaponName, type = 'weapon', amount = 1}

      RemoveWeaponFromPed(GetPlayerPed(source), weaponHash)

      if ammo and ammo > 0 then
        local weaponGroup = INVENTORY:getWeaponGroup(weaponHash)
        local nextIndex = INVENTORY:isInventoryFull(source, 'primary')
        if not nextIndex then
          return
        end

        local itemName = ('%s Ammo'):format(weaponGroup)
        INVENTORY.primaryItems[source][nextIndex] = {label = itemName, type = 'ammo', amount = ammo}
      end
    end
  end
end

function INVENTORY:getWeaponHash(_weaponName)
  for weaponHash, weaponName in pairs(SHARED_CONFIG.weaponNames) do
    if weaponName[1] == _weaponName then
      return weaponHash
    end
  end
end

function INVENTORY:getWeaponGroup(weaponHash)
  return SHARED_CONFIG.weaponNames[weaponHash][2]
end

function INVENTORY:getItemType(label)
  return SHARED_CONFIG.inventoryItems[label].group
end

function INVENTORY:getRelativeInventory(source, inventoryType)
  if inventoryType == 'primary' then
    return INVENTORY.primaryItems[source]
  elseif inventoryType == 'secondary' then
    return INVENTORY.secondaryItems[source]
  end

  return INVENTORY.hotbarItems[source]
end

function INVENTORY:getEmptyItems(num)
  local t = {}
  for i = 1, num do
    t[#t + 1] = INVENTORY:getEmptyItem()
  end

  return t
end

function INVENTORY:removeItem(source, item, inventoryType)
  local inventory = INVENTORY:getRelativeInventory(source, inventoryType)
  for k, v in pairs(inventory) do
    if v.label == item then
      INVENTORY[inventoryType .. 'Items'][source][k] = INVENTORY:getEmptyItem()
    end
  end
end

RegisterServerCallback('RIVAL::fetchInventoryItems', function(source, inventoryType)
  local items = INVENTORY:getRelativeInventory(source, inventoryType)

  -- Merges two items if they are the same
  for index, item in pairs(items) do
    if item and item.type ~= 'empty' then
      for _index, _item in pairs(items) do
        if index ~= _index and item.label == _item.label then
          items[index].amount = item.amount + _item.amount
          items[_index] = INVENTORY:getEmptyItem()
        end
      end
    end
  end

  return items
end)

RegisterNetEvent('RIVAL::syncInventory', function(data)
  local source = source
  local inventoryIsSafe = true
  local primaryItems, secondaryItems, hotbarItems = table.unpack(data)
  -- Merges all items owned by the player
  local mixedItems = tableMerge(INVENTORY.primaryItems[source], INVENTORY.secondaryItems[source],
                                INVENTORY.hotbarItems[source])

  Wait(50)

  -- Validates primary inventory
  for k, v in pairs(primaryItems) do
    if v.type ~= 'empty' then
      if not INVENTORY.verifyItem(mixedItems, v, false) then
        inventoryIsSafe = false
      end
    end
  end

  -- Validates secondary inventory
  for k, v in pairs(secondaryItems) do
    if v.type ~= 'empty' then
      if not INVENTORY.verifyItem(mixedItems, v, false) then
        inventoryIsSafe = false
      end
    end
  end

  -- Validates hotbar
  for k, v in pairs(hotbarItems) do
    if v.type ~= 'empty' then
      if not INVENTORY.verifyItem(mixedItems, v, false) then
        inventoryIsSafe = false
      end
    end
  end

  if not inventoryIsSafe then
    return
  end

  if #primaryItems ~= 0 and primaryItems ~= INVENTORY.primaryItems[source] then
    INVENTORY.primaryItems[source] = primaryItems
  end

  if #secondaryItems ~= 0 and secondaryItems ~= INVENTORY.secondaryItems[source] then
    local openedInventory = INVENTORY.openedInventory[source]

    if openedInventory then
      if openedInventory[1] == 'CRATE' then
        CRATES.spawnedCrates[openedInventory[2]] = secondaryItems
        INVENTORY.secondaryItems[source] = secondaryItems
      elseif openedInventory[1] == 'GRAVE' then
        local player = RIVAL:getPlayer(source)
        local Game = RIVAL:getPlayerGame(player)

        if Game and Game.graveStones then
          Game.graveStones[openedInventory[2]] = secondaryItems
          INVENTORY.secondaryItems[source] = secondaryItems
        end
      end
    end
  end

  if #hotbarItems ~= 0 and hotbarItems ~= INVENTORY.hotbarItems[source] then
    INVENTORY.hotbarItems[source] = hotbarItems
  end
end)

RegisterNetEvent('RIVAL::useInventoryItem', function(item, inventory)
  local source = source
  if not item or item.type == 'empty' then
    return
  end

  local items = INVENTORY:getRelativeInventory(source, inventory)

  if inventory == 'primary' then
    local index = INVENTORY.verifyItem(items, item, false)

    if index then
      if item.type == 'weapon' or item.type == 'throwable' then
        local selectedWeapon = GetSelectedPedWeapon(GetPlayerPed(source))

        if selectedWeapon == -1569615261 then
          if item.amount > 1 then
            INVENTORY.primaryItems[source][index].amount = INVENTORY.primaryItems[source][index].amount - 1
          else
            INVENTORY.primaryItems[source][index] = INVENTORY:getEmptyItem()
          end

          INVENTORY:useItem(source, item)
        end

        return
      end

      INVENTORY:useItem(source, item)
    end

    if item.type == 'ammo' then
      local equippingAmount, inventoryAmount = INVENTORY:formatAmmo(source, item.amount)
      INVENTORY.primaryItems[source][index].amount = inventoryAmount

      if inventoryAmount <= 1 then
        -- Remove item from inventory
        INVENTORY.primaryItems[source][index] = INVENTORY:getEmptyItem()
      else
        -- Removes the used amount from the inventory
        INVENTORY.primaryItems[source][index].amount = inventoryAmount
      end

      return
    end

    if item.amount == 1 then
      -- Remove item from inventory
      INVENTORY.primaryItems[source][index] = INVENTORY:getEmptyItem()
    else
      -- Removes the used amount from the inventory
      INVENTORY.primaryItems[source][index].amount = item.amount - 1
    end
  end
end)

function INVENTORY:formatAmmo(source, baseAmount)
  local leftAmount = TriggerClientCallback('RIVAL::fetchAmmo', source)
  local currentAmount = 250 - leftAmount
  local equippingAmount = 0
  local inventoryAmount = 0

  if leftAmount == 0 then
    return
  end

  -- Ammo logic
  -- If player has more then 250 ammo in inventory, he will equip 250 and leave the rest of the ammo in inventory
  -- Else if the player has less then 250 ammo, he will only equip the amount he has and will leave nothing in inventory
  if baseAmount >= 250 then
    equippingAmount = 250
    inventoryAmount = baseAmount - equippingAmount
  else
    equippingAmount = currentAmount + baseAmount

    if equippingAmount >= 250 then
      equippingAmount = equippingAmount - baseAmount + leftAmount
      inventoryAmount = baseAmount - leftAmount
    end
  end

  return equippingAmount, inventoryAmount
end

RegisterNetEvent('RIVAL::useHotbarItem', function(slot)
  local source = source
  local hotbarInv = INVENTORY:getRelativeInventory(source, 'hotbar')
  local item = hotbarInv[slot]
  local index = INVENTORY.verifyItem(hotbarInv, item, false)

  if item.type == 'empty' then
    return SetCurrentPedWeapon(GetPlayerPed(source), -1569615261, true)
  end

  -- Verify item and if it exists and correct inventory then we can use it
  if not index then
    return
  end

  if item.type == 'ammo' then
    local selectedWeapon = GetSelectedPedWeapon(GetPlayerPed(source))
    local weaponType = INVENTORY:getWeaponGroup(selectedWeapon)

    -- Correct ammo type
    if ('%s Ammo'):format(weaponType) ~= item.label then
      return
    end

    local equippingAmount, inventoryAmount = INVENTORY:formatAmmo(source, item.amount)
    item.amount = equippingAmount

    CreateThread(function()
      if inventoryAmount == 0 then
        -- Removes item from inventory
        INVENTORY.hotbarItems[source][index] = INVENTORY:getEmptyItem()
      else
        -- Removes the used amount from the inventory
        INVENTORY.hotbarItems[source][index].amount = inventoryAmount
      end
    end)
  end

  INVENTORY:useItem(source, item, true)
  TriggerClientEvent('RIVAL::syncHotbar', source, INVENTORY.hotbarItems[source])
end)

RegisterServerEvent('RIVAL::storeAllWeapons', function(weapons)
  local source = source

  for weaponHash, weaponAmmo in pairs(weapons) do
    INVENTORY:storeItem(source, weaponHash, weaponAmmo)
  end
end)

RegisterServerEvent('RIVAL::closeInventory', function()
  local source = source

  if INVENTORY.openedInventory[source] then
    INVENTORY.openedInventory[source] = nil
    TriggerClientEvent('RIVAL::syncHotbar', source, INVENTORY.hotbarItems[source])
  end
end)

RegisterServerEvent('RIVAL::sellItems', function(items)
  local source = source
  local player = RIVAL:getPlayer(source)
  local Squad = RIVAL:getPlayerSquad(player)
  local safeSell = true
  local totalCash = 0

  for _, item in pairs(items) do
    if not INVENTORY.verifyItem(INVENTORY.primaryItems[source], item, true) then
      safeSell = false
    else
      totalCash = totalCash + SHARED_CONFIG.inventoryItems[item].price
    end
  end

  if not safeSell then
    return
  end

  local currentCash = Squad:getPlayerProperty(player, 'cash') or 0
  Squad:setPlayerProperty(player, {'cash', currentCash + totalCash})

  for _, item in pairs(items) do
    INVENTORY:removeItem(source, item, 'primary')
  end

  GAME:updateCash(source)
  TriggerClientEvent('RIVAL::forceFetch', source)
end)

