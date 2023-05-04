local waitingStageVisible = false

function GAME:leaveWaitingStage()
  self.waiting = false
  waitingStageVisible = false
  DoScreenFadeOut(1000)
  GAME:GMode(false)
  NUI:redirect('/hidden')
  Wait(2500)
  GM:playCutscene()
  DoScreenFadeIn(500)
end

function GAME:fadeEffect()
  DoScreenFadeOut(0)
  Wait(2000)
  GAME:GMode(true)
  GAME:waitingStage()
  DoScreenFadeIn(4000)
end

function GAME:waitingStage()
  self.waiting = true
  RemoveAllPedWeapons(RIVAL.getPlayerPed(), true)
  TriggerEvent('RIVAL::clearVehicles')

  CreateThread(function()
    local playerId = RIVAL.getPlayerId()
    local playerPed = RIVAL.getPlayerPed()
    local baseCoords = SHARED_CONFIG.waitingStage

    while self.waiting do
      Wait(500)

      local distance = #(RIVAL.getPlayerPosition() - baseCoords)
      if distance > 75.0 then
        SetEntityCoords(playerPed, baseCoords)
      end
    end
  end)

  CreateThread(function()
    while self.waiting do

      for _, player in pairs(GetActivePlayers()) do
        local playerPed = GetPlayerPed(player)

        if RIVAL.getPlayerPed() ~= playerPed and GetBlipFromEntity(playerPed) == 0 then
          local blip = AddBlipForEntity(GetPlayerPed(player))
          RIVAL.createBlip(blip, 1, 0, GetPlayerName(player))
          SetBlipAsShortRange(blip, false)
        end
      end
      Wait(4000)
    end

    -- Delets all the blips
    for _, player in pairs(GetActivePlayers()) do
      local playerPed = GetPlayerPed(player)
      local blip = GetBlipFromEntity(playerPed)

      if blip ~= 0 then
        RemoveBlip(blip)
      end
    end
  end)
end

RegisterNetEvent('RIVAL::enterWaitingStage', function(squadCount, gameMode)
  GM.type = gameMode
  SQUAD:exitSquad()
  GAME:fadeEffect()
  RPC:handleUpdate(squadCount, true)
  GAME:setupUI()
  MAP:toggleIsland(false)
  NUI:sendCommand('WAITING_STAGE', true)
  waitingStageVisible = true
  SetEntityHeading(RIVAL.getPlayerPed(), 0.0)
  CreateThread(GAME.handleHealth)
  TriggerEvent('RIVAL::syncHotbar', TriggerServerCallback('RIVAL::fetchInventoryItems', 'hotbar'))
end)

AddEventHandler('RIVAL:onPlayerJoinGame', function(player, playerCount)
  while not waitingStageVisible do
    Wait(50)
  end

  NUI:sendCommand('SET_PLAYER_COUNT', playerCount)
end)
