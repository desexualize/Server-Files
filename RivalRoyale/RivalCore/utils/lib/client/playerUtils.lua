function DrawHelpMsg(msg)
  SetTextComponentFormat('STRING')
  AddTextComponentString(msg)
  DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

local savedHash = GetHashKey('GET_INVOKING_RESOURCE') & 0xFFFFFFFF
function GetInvokingResource()
  return Citizen.InvokeNative(savedHash, Citizen.ResultAsString())
end

function RegisterSafeNUICallback(eventName, safeCb)
  if not eventName then
    return
  end

  RegisterNUICallback(eventName, function(data, cb)
    safeCb(data)
    cb('ok')
  end)
end

function RIVAL:getNearbyPlayers(radius)
  return GetActivePlayers()
end

function RIVAL:getNearestPlayer(radius)
  local dist = -1
  local nearestPlayer = -1

  for _, player in pairs(self:getNearbyPlayers()) do
    local playerPed = GetPlayerPed(player)

    if playerPed ~= RIVAL.getPlayerPed() then
      local playerCoords = GetEntityCoords(playerPed)
      local distance = #(playerCoords - RIVAL.getPlayerPosition())
      if dist == -1 or dist > distance then
        nearestPlayer = player
        dist = distance
      end
    end
  end

  if dist ~= -1 and dist <= radius then
    return nearestPlayer
  end

  return
end
