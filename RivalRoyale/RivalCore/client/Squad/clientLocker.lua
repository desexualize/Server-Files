LOCKER = {}
LOCKER.inLocker = false

-- Returns the componentId from componentName
function LOCKER:convertToIndex(label)
  return SHARED_CONFIG.clothes[label]
end

-- When the player has entered the locker
RegisterNUICallback('RIVAL::enterLocker', function(data, cb)
  -- Get offsets for camera
  local camPos = GetOffsetFromEntityInWorldCoords(RIVAL.getPlayerPed(), vector3(1.0, 2.3, 0.0))
  local camPoint = GetOffsetFromEntityInWorldCoords(RIVAL.getPlayerPed(), vector3(1.2, 0.0, 0.0))

  -- Prevents a bug
  if not lockerCam then
    lockerCam = CreateCameraWithParams('DEFAULT_SCRIPTED_CAMERA', camPos, 0.0, 0.0, 0.0, 65.0, 0, 2)
  end

  SQUAD.hideText = true
  LOCKER.inLocker = true
  CONTROLS:toggleProtection(true)
  RenderScriptCams(true, true, 0, 1, 0, 0)
  PointCamAtCoord(lockerCam, camPoint)
  SetCamActive(lockerCam, true)
  SetCamActiveWithInterp(lockerCam, SQUAD.cam, 1000, true, true)

  local playerClothing = TriggerServerCallback('RIVAL::fetchClothing')

  -- Corrects and fixes info so it can easily be displayed with the right values
  for componentName, componentData in pairs(playerClothing) do
    local validComponent = LOCKER:convertToIndex(componentName)

    for k, v in pairs(componentData) do
      local maxTextureId = GetNumberOfPedTextureVariations(RIVAL.getPlayerPed(), validComponent, v)
      playerClothing[componentName][k] = {id = v, textureId = maxTextureId}
    end
  end

  -- Temporarily hides squad players from being seen
  SQUAD:iteratePlayers(function(player, data)
    local playerPed = GetPlayerPed(GetPlayerFromServerId(data.source))
    if playerPed ~= RIVAL.getPlayerPed() then
      SetEntityAlpha(playerPed, 0)
    end
  end)

  -- Sends a callback to the NUI with playerClothing
  cb(playerClothing)
end)

-- Exits the locker
RegisterSafeNUICallback('RIVAL::exitLocker', function(data, cb)
  if not LOCKER.inLocker then
    return
  end

  LOCKER.inLocker = false
  SQUAD:setCamPos(CLIENT_CONFIG.camCoords)
  CONTROLS:toggleProtection(false)
  SetCamActiveWithInterp(SQUAD.cam, lockerCam, 1000, true, true)

  -- Wait for the fadeout effect
  SetTimeout(1000, function()
    SQUAD.hideText = false

    -- Makes the squad players visible
    SQUAD:iteratePlayers(function(player, data)
      local playerPed = GetPlayerPed(GetPlayerFromServerId(data.source))
      if playerPed ~= RIVAL.getPlayerPed() then
        ResetEntityAlpha(playerPed)
      end
    end)
  end)
end)

-- When the player changes a clothing piece in locker
RegisterSafeNUICallback('RIVAL::swapClothingComponent', function(data)
  if not data then
    return
  end

  TriggerServerEvent('RIVAL::swapClothingComponent', data)
end)

-- Initializes the base clothing, will only get triggered once when joined
RegisterSafeNUICallback('RIVAL::baseClothing', function(data)
  if not data then
    return
  end

  -- Reset clothing
  for i = 0, 19 do
    SetPedComponentVariation(RIVAL.getPlayerPed(), i, 0, 0, 0)
  end

  -- Fixes holes in torso
  SetPedComponentVariation(RIVAL.getPlayerPed(), 3, 1, 0, 0)

  TriggerServerEvent('RIVAL::baseClothing', data)
end)

RegisterNetEvent('RIVAL::setParachuteColor', function(tintIndex, key)
  SetPedParachuteTintIndex(RIVAL.getPlayerPed(), tintIndex)

  Wait(350)
  TriggerServerEvent('RIVAL::handleKey', key)
end)
