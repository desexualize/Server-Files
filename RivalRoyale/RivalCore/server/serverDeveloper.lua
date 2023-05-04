local verifiedDevelopers = {[1] = true, [2] = true}

RegisterServerCallback('RIVAL::getServerMode', function()
  return RIVAL.developerServer
end)

if RIVAL.developerServer then
  RegisterServerEvent('RIVAL::developerMode', function()
    local source = source
    local player = RIVAL:getPlayer(source)

    if verifiedDevelopers[player] then
      SetPlayerRoutingBucket(source, 1)
      SetEntityCoords(GetPlayerPed(source), vector3(4475.21, -4469.69, 4.23))
    end
  end)

  RegisterServerEvent('RIVAL::giveWeapon', function(weapon)
    local source = source
    local player = RIVAL:getPlayer(source)

    if verifiedDevelopers[player] then
      GiveWeaponToPed(GetPlayerPed(source), GetHashKey(weapon), 9999, true, true)
    end
  end)
end
