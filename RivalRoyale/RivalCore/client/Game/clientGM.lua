GM = {}
GM.type = nil
GM.waitingForJump = false

function GM:playCutscene()
  RIVAL:loadCutscene('hs4_lsa_take_nimb2')
  StartCutscene(0)
end

function GM:playerJumped(heading)
  local playerPed = RIVAL.getPlayerPed()
  local playerId = RIVAL.getPlayerId()

  NUI:extraModule('Space', false)
  GAME:setupUI()
  -- NetworkSetEntityInvisibleToNetwork(RIVAL.getPlayerPed(), false)
  SetEntityHeading(playerPed, heading)
  NetworkSetEntityInvisibleToNetwork(playerPed, false)
  ResetEntityAlpha(playerPed)
  SetEntityVisible(playerPed, true, true)
  SetLocalPlayerVisibleLocally(false)
  -- ResetEntityAlpha(playerPed)
  DisplayRadar(true)
  GiveWeaponToPed(playerPed, GetHashKey('gadget_parachute'), 1, false, true)
  SetPlayerHasReserveParachute(playerId)
  SetPlayerCanLeaveParachuteSmokeTrail(playerId, true)
  SetPlayerParachuteSmokeTrailColor(playerId, 255, 255, 255)
  CreateThread(GAME.handleHealth)
  SetPlayerReserveParachuteTintIndex(playerPed, -1)

  SQUAD:iteratePlayers(function(player, data)
    if data.source ~= GetPlayerServerId(RIVAL.getPlayerId()) then
      local blip = AddBlipForEntity(GetPlayerPed(GetPlayerFromServerId(data.source)))

      RIVAL.createBlip(blip, 1, 0, GetPlayerName(player))
      SetBlipAsShortRange(blip, false)
    end
  end)
end

function GM:handleFly(aircraft, route)
  self.waitingForJump = true
  -- SetEntityAlpha(RIVAL.getPlayerPed(), 0)
  NUI:extraModule('Space', true)
  DisplayRadar(false)

  while self.waitingForJump do
    Wait(0)

    SetEntityCoords(RIVAL.getPlayerPed(), GetEntityCoords(aircraft) + vector3(0.0, 0.0, 40.0))

    if IsControlJustPressed(1, 22) then
      self.waitingForJump = false
    end
  end

  GM:playerJumped(route.heading)
end

RegisterNetEvent('RIVAL::startGame', function(route, planeNetId)
  while not NetworkDoesNetworkIdExist(planeNetId) do
    Wait(25)
  end

  local clientAircraft = NetToVeh(planeNetId)
  local clientPilot = CreatePedInsideVehicle(clientAircraft, 1, RIVAL:loadModel('s_m_m_pilot_01'), -1, false, true)

  TaskVehicleDriveToCoord(clientPilot, clientAircraft, route.stop, 80.0, 1, GetHashKey('Miljet'), 1, 0, 0)

  GAME:leaveWaitingStage()
  GAME.playing = true
  CONTROLS:toggleProtection(true)
  MAP:toggleIsland(true)
  DisplayRadar(true)
  CreateThread(KNOCK_DOWN.initialize)
  CreateThread(RECOIL.initialize)
  CreateThread(VENDOR.handleInteraction)
  CreateThread(CRATES.handleInteraction)
  CreateThread(LOOTING.handleInteraction)

  SetWeatherTypePersist('CLEAR')
  SetWeatherTypeNowPersist('CLEAR')
  SetWeatherTypeNow('CLEAR')
  SetOverrideWeather('CLEAR')
  SetClockTime(12, 00, 00)

  NetworkSetEntityInvisibleToNetwork(RIVAL.getPlayerPed(), true)
  SetEntityVisible(RIVAL.getPlayerPed(), false, false)
  SetEntityAlpha(RIVAL.getPlayerPed(), 100, false)
  SetLocalPlayerVisibleLocally(true)

  repeat
    Wait(30)
  until not IsCutscenePlaying() -- Wait for the cutscene to finish

  SetEntityCoords(RIVAL.getPlayerPed(), route.start)
  CONTROLS:toggleProtection(false)
  GM:handleFly(clientAircraft, route)
end)

function GM:playerKilled()
  exports['spawnmanager']:setAutoSpawn(false)
end

RegisterNetEvent('RIVAL::vehiclePlaced', function(vehicleNetId, vehicleType)
  while not NetworkDoesNetworkIdExist(vehicleNetId) do
    Wait(25)
  end

  local clientVehicle = NetToVeh(vehicleNetId)
  local blip = AddBlipForEntity(clientVehicle)

  if vehicleType == 'land' then
    return RIVAL.createBlip(blip, 749, 0, 'Jetski')
  end

  RIVAL.createBlip(blip, 754, 0, 'Quad')
end)

RegisterNetEvent('RIVAL::clearVehicles', function()
  ANTICHEAT:iterateVehicles(function(vehicle)
    if GetEntityModel(vehicle) ~= GetHashKey('miljet') then
      DeleteEntity(vehicle)
    end
  end)

  return true
end)

RegisterNetEvent('RIVAL::handleConceal', function(source, value)
  local playerId = GetPlayerFromServerId(source)
  if not playerId or not value then
    return
  end

  NetworkConcealPlayer(playerId, value)
end)

RegisterNUICallback('RIVAL::getPlayerCount', function(gameMode, cb)
  local playerCount = TriggerServerCallback('RIVAL::getPlayerCount', gameMode)
  cb(playerCount or 0)
end)
