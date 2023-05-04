CRATES = {}
CRATES.clientCrates = {}
CRATES.threadTick = 750
CRATES.displayed = false

RegisterNetEvent('RIVAL::placeEntityOnGround', function(crateNetId)
  while not NetworkDoesNetworkIdExist(crateNetId) do
    Wait(25)
  end

  local crateObject = NetToObj(crateNetId)
  -- PlaceObjectOnGroundProperly(crateObject)
  -- PlaceObjectOnGroundProperly_2(crateObject)

  CRATES.clientCrates[crateObject] = GetEntityCoords(crateObject)
end)

function CRATES:openMenu()
  TriggerServerEvent('RIVAL::clientOpenedCrate')
end

RegisterNetEvent('RIVAL::openSecondaryInv', function()
  -- Add a small delay
  Wait(100)

  CRATES.displayed = true
  NUI:extraModule('Inventory', true)
  NUI:toggleFocus(true)

  Wait(15)
  NUI:sendCommand('SET_PRIMARY_INV', false)
end)

RegisterSafeNUICallback('RIVAL::exitCrate', function()
  CRATES.displayed = false
  NUI:extraModule('Inventory', false)
  NUI:toggleFocus(false)
  TriggerServerEvent('RIVAL::closeInventory')
end)

function CRATES:getClosest()
  for crateObject, crateCoords in pairs(CRATES.clientCrates) do
    local dist = #(RIVAL.getPlayerPosition() - crateCoords)

    if dist < 10.0 then
      return crateCoords, dist
    end
  end
end

function CRATES:handleInteraction()
  while GAME.playing do
    Wait(CRATES.threadTick)

    local crateCoords, dist = CRATES:getClosest()

    if crateCoords then
      CRATES.threadTick = 0

      if dist < 2.0 then
        if not CRATES.displayed then
          DrawHelpMsg('Press ~INPUT_CONTEXT~ to interact with ~y~Vendor.')

          if IsControlJustPressed(0, 51) then
            CRATES:openMenu()
          end
        end
      end
    else
      CRATES.threadTick = 1000
    end
  end
end
