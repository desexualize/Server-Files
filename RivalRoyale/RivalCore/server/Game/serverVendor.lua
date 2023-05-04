VENDOR = {}
VENDOR.vendorItems = {}

function VENDOR:matchItems(shoppingCart)
  for _, item in pairs(shoppingCart) do
    if VENDOR.vendorItems[item.label] ~= item.price then
      return false
    end
  end

  return true
end

function VENDOR:getCartTotal(shoppingCart)
  local total = 0
  for _, item in pairs(shoppingCart) do
    total = total + item.price
  end

  return total
end

-- Returns avaliable cash player has
RegisterServerCallback('RIVAL::fetchCash', function(source)
  local player = RIVAL:getPlayer(source)
  local Squad = RIVAL:getPlayerSquad(player)

  return Squad:getPlayerProperty(player, 'cash') or 0
end)

RegisterServerCallback('RIVAL::tryPurchase', function(source, shoppingCart)
  local player = RIVAL:getPlayer(source)
  local Squad = RIVAL:getPlayerSquad(player)

  -- Player has modified price, client does not match server cfg
  if not VENDOR:matchItems(shoppingCart) then
    return false
  end

  local cartTotal = VENDOR:getCartTotal(shoppingCart)
  local cashAvaliable = Squad:getPlayerProperty(player, 'cash') or 0

  -- Player can afford purchase and has avaliable slots
  if cashAvaliable >= cartTotal and INVENTORY:getEmptyCount(source) >= #shoppingCart then

    -- Removes the charged amount
    Squad:setPlayerProperty(player, {'cash', cashAvaliable - cartTotal})
    GAME:updateCash(source)

    -- Stores item to inventory
    for _, item in pairs(shoppingCart) do
      INVENTORY:pushItem(source, 'primary', item.label, item.amount)
    end

    return true
  end
end)

CreateThread(function()
  for itemName, itemData in pairs(SHARED_CONFIG.inventoryItems) do
    VENDOR.vendorItems[itemName] = itemData.price * 2
  end
end)
