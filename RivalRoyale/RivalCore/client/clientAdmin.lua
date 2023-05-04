ADMIN = {}

RegisterNUICallback('RIVAL::fetchPlayerInfo', function(targetPlayer, cb)
  local playerInfo = TriggerServerCallback('RIVAL::getPlayerInfo', targetPlayer)
  cb(playerInfo)
end)

RegisterNUICallback('RIVAL::fetchPlayers', function(data, cb)
  local players = TriggerServerCallback('RIVAL::getPlayers')
  cb(players)
end)

RegisterNUICallback('RIVAL::requestAccess', function(data, cb)
  local access = TriggerServerCallback('RIVAL::requestAccess')
  cb(access)
end)

RegisterSafeNUICallback('RIVAL::performAction', function(data)
  local player, action = data.playerUID, data.action
  TriggerServerEvent('RIVAL::performAction', player, action)
end)

RegisterNUICallback('RIVAL::getNumPlayers', function(_, cb)
  local playerCount = NetworkGetTotalNumPlayers()
  cb(playerCount)
end)

RegisterNetEvent('RIVAL::spectatePlayer', function(player, playerCoords)
  -- Exits squad
  SQUAD:exitSquad()
  TriggerServerEvent('RIVAL::exitSquad')

  local playerPed = GetPlayerFromServerId(player)
  SetEntityCollision(RIVAL.getPlayerPed(), false, false)
  SetEntityVisible(RIVAL.getPlayerPed(), false)
  FreezeEntityPosition(RIVAL.getPlayerPed(), true)
  RequestCollisionAtCoord(playerCoords)
  SetEntityCoords(RIVAL.getPlayerPed(), playerCoords)
  NetworkSetInSpectatorMode(RIVAL.getPlayerPed(), true)

  if not ADMIN.spectatorCam then
    ADMIN.spectatorCam = CreateCameraWithParams('DEFAULT_SCRIPTED_CAMERA', playerCoords, 0.0, 0.0, 0.0, 65.0, 0, 2)
    CONTROLS:toggleProtection(true)

    RenderScriptCams(true, true, 0, 1, 0, 0)
    SetCamActive(ADMIN.spectatorCam, true)
    SetCamActiveWithInterp(ADMIN.spectatorCam, SQUAD.cam, 1000, true, true)
  end
end)

function ADMIN:handleSpecate()
  local polarAngleDeg = 0
  local azimuthAngleDeg = 90
  local radius = -3.5
  local cam = nil
  local PlayerDate = {}
  local ShowInfos = false
  local group

  while ADMIN.spectatingPlayer do
    Wait(0)

    DrawHelpMsg('Press ~INPUT_CONTEXT~ to stop Spectating')

    -- Stops spectating
    if IsControlJustPressed(1, 51) then
      ADMIN:stopSpectating()
    end

    if IsControlPressed(2, 241) then
      radius = radius + 2.0;
    end

    if IsControlPressed(2, 242) then
      radius = radius - 2.0
    end

    if radius > -1 then
      radius = -1
    end

    local xMagnitude = GetDisabledControlNormal(0, 1);
    local yMagnitude = GetDisabledControlNormal(0, 2);

    polarAngleDeg = polarAngleDeg + xMagnitude * 10

    if polarAngleDeg >= 360 then
      polarAngleDeg = 0
    end

    azimuthAngleDeg = azimuthAngleDeg + yMagnitude * 10

    if azimuthAngleDeg >= 360 then
      azimuthAngleDeg = 0
    end

    local nextCamLocation = polar3DToWorld3D(coords, radius, polarAngleDeg, azimuthAngleDeg)

    SetCamCoord(ADMIN.spectatorCam, nextCamLocation.x, nextCamLocation.y, nextCamLocation.z)
    PointCamAtEntity(ADMIN.spectatorCam, targetPed)
    SetEntityCoords(RIVAL.getPlayerPed(), coords.x, coords.y, coords.z + 10)
  end
end

function ADMIN:stopSpectating()
  ADMIN.spectatingPlayer = 0
  NetworkSetInSpectatorMode(RIVAL.getPlayerPed(), false)
  TriggerServerEvent('RIVAL::exitSquad')

end
