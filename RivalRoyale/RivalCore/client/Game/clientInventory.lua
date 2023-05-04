INVENTORY = {}

RegisterCommand('+INVENTORY', function()
  -- Inventory can only be accessed in a game
  if SQUAD.inSquad then
    return
  end

  CONTROLS.inventoryOpen = not CONTROLS.inventoryOpen
  if CONTROLS.inventoryOpen then
    NUI:extraModule('Inventory', true)
    NUI:toggleFocus(true)

    return
  end

  NUI:extraModule('Inventory', false)
  NUI:toggleFocus(false)
end)

RegisterSafeNUICallback('RIVAL::closeInventory', function(data, cb)
  CONTROLS.inventoryOpen = false
  NUI:toggleFocus(false)
  NUI:extraModule('Inventory', false)
  TriggerServerEvent('RIVAL::closeInventory')
end)

RegisterSafeNUICallback('RIVAL::useInventoryAction', function(data)
  local action = data.action

  if action == 'USE' then
    TriggerServerEvent('RIVAL::useInventoryItem', data.item, data.inventory)
  end
end)

RegisterNUICallback('RIVAL::fetchInventoryItems', function(inventoryType, cb)
  if inventoryType == 'hotbar' then
    -- Add delay
    Wait(30)
  end

  if inventoryType == 'secondary' then
    Wait(65)
  end

  local items = TriggerServerCallback('RIVAL::fetchInventoryItems', inventoryType)
  cb(items or {})
end)

RegisterSafeNUICallback('RIVAL::syncInventoryClient', function(data)
  TriggerServerEvent('RIVAL::syncInventory', data)
end)

RegisterCommand('+HOTBARSLOT1', function()
  if not SQUAD.inSquad then
    TriggerServerEvent('RIVAL::useHotbarItem', 1)
  end
end)

RegisterCommand('+HOTBARSLOT2', function()
  if not SQUAD.inSquad then
    TriggerServerEvent('RIVAL::useHotbarItem', 2)
  end
end)

RegisterCommand('+HOTBARSLOT3', function()
  if not SQUAD.inSquad then
    TriggerServerEvent('RIVAL::useHotbarItem', 3)
  end
end)

RegisterCommand('+HOTBARSLOT4', function()
  if not SQUAD.inSquad then
    TriggerServerEvent('RIVAL::useHotbarItem', 4)
  end
end)

RegisterClientCallback('RIVAL::fetchAmmoInfo', function()
  local weaponHash = GetSelectedPedWeapon(RIVAL.getPlayerPed())
  local ammo = GetAmmoInPedWeapon(RIVAL.getPlayerPed(), weaponHash)

  -- Player is holding nothing
  if weaponHash == -1569615261 then
    weaponHash = nil
  end

  return {weaponHash, ammo}
end)

RegisterNetEvent('RIVAL::syncHotbar', function(items)
  local selectedWeapon = GetSelectedPedWeapon(RIVAL.getPlayerPed())
  NUI:sendCommand('FORCE_FETCH_HOTBAR', items)
end)

RegisterClientCallback('RIVAL::fetchAmmo', function()
  local weaponHash = GetSelectedPedWeapon(RIVAL.getPlayerPed())
  local ammo = GetAmmoInPedWeapon(RIVAL.getPlayerPed(), weaponHash)
  local _, maxAmmo = GetMaxAmmo(RIVAL.getPlayerPed(), weaponHash)

  if not weaponHash or not _ then
    return 0
  end

  return maxAmmo - ammo
end)

RegisterClientCallback('RIVAL::fetchAmmoCount', function(weaponHash)
  local ammo = GetAmmoInPedWeapon(RIVAL.getPlayerPed(), weaponHash)

  return ammo or 0
end)

-- Store items
RegisterCommand('+STOREALLWEAPONS', function()
  local weapons = {}
  local playerPed = RIVAL.getPlayerPed()

  for weaponHash, weaponData in pairs(SHARED_CONFIG.weaponNames) do
    if HasPedGotWeapon(playerPed, weaponHash) then
      weapons[weaponHash] = GetAmmoInPedWeapon(RIVAL.getPlayerPed(), weaponHash)
    end
  end

  if #weapons > 0 then
    TriggerServerEvent('RIVAL::storeAllWeapons', weapons)
  end
end)

RegisterCommand('+STOREHOLDINGWEAPON', function()
  local weapons = {}

  local _, weaponHash = GetCurrentPedWeapon(RIVAL.getPlayerPed())
  weapons[weaponHash] = GetAmmoInPedWeapon(RIVAL.getPlayerPed(), weaponHash)

  if #weapons > 0 then
    TriggerServerEvent('RIVAL::storeAllWeapons', weapons)
  end
end)

RegisterSafeNUICallback('RIVAL::sellItems', function(items)
  if not items then
    return
  end

  TriggerServerEvent('RIVAL::sellItems', items)
end)

RegisterNetEvent('RIVAL::forceFetch', function()
  NUI:sendCommand('FETCH_INV_ITEMS')
end)
