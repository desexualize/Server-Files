-- Sync 3d audio with nearby players
RegisterNetEvent('RIVAL::syncDeathSound', function(deathCoords, playerPed)
  if not deathCoords or not playerPed then
    return
  end

  TriggerClientEvent('RIVAL::syncDeathSound', -1, deathCoords, playerPed)
end)
