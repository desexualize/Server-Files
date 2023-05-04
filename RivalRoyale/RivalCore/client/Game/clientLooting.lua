LOOTING = {}
LOOTING.clientGraves = {}
LOOTING.threadTick = 350
LOOTING.displayed = false

RegisterNetEvent('RIVAL::placeGrave', function(graveNetId)
  while not NetworkDoesNetworkIdExist(graveNetId) do
    Wait(25)
  end

  local graveObject = NetToObj(graveNetId)
  local x, y = table.unpack(GetEntityCoords(graveObject))
  local z = RIVAL:getGroundCoords(x, y)
  LOOTING.clientGraves[graveObject] = vec3(x, y, z)

  SetEntityCoords(graveObject, x, y, z)
  SetEntityRotation(graveObject, 0.0, 0.0, 0.0, 0.0)
  FreezeEntityPosition(graveObject, true)
end)

function LOOTING:openMenu()
  TriggerServerEvent('RIVAL::lootPlayer')
end

function LOOTING:getClosest()
  for _, coords in pairs(LOOTING.clientGraves) do
    local dist = #(RIVAL.getPlayerPosition() - coords)

    if dist < 4.0 then
      return _, dist
    end
  end
end

function LOOTING:handleInteraction()
  while GAME.playing do
    Wait(LOOTING.threadTick)

    local clientGrave, dist = LOOTING:getClosest()

    if clientGrave then
      LOOTING.threadTick = 0

      if not LOOTING.displayed then
        DrawHelpMsg('Press ~INPUT_CONTEXT~ to loot this ~y~Grave')

        if IsControlJustPressed(1, 51) then
          LOOTING:openMenu()
        end
      end
    else
      LOOTING.threadTick = 350
    end
  end
end

AddEventHandler('onResourceStop', function(resourceName)
  if GetCurrentResourceName() == resourceName then
    for graveObject, graveCoords in pairs(LOOTING.clientGraves) do
      DeleteEntity(graveObject)
    end
  end
end)
