local playerPed
local playerId
local playerCoords
local playerHealth

function savePlayerInfo()
  while true do
    Wait(0)

    playerPed = PlayerPedId()
    playerId = PlayerId()
    playerCoords = GetEntityCoords(playerPed)
    playerHealth = GetEntityHealth(playerPed)
  end
end

function RIVAL.getPlayerPed()
  return playerPed
end

function RIVAL.getPlayerId()
  return playerId
end

function RIVAL.getPlayerPosition()
  return playerCoords
end

function RIVAL.getPlayerHealth()
  return playerHealth
end

CreateThread(savePlayerInfo)
