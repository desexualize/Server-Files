KNOCK_DOWN = {}
KNOCK_DOWN.lastKill = {}
KNOCK_DOWN.squadData = {}
KNOCK_DOWN.savedHealth = 0
KNOCK_DOWN.isDown = false

function KNOCK_DOWN:setKnocked(value)
  TriggerServerEvent('RIVAL::syncKnockedDown', value)

  if value then
    local loadedAnimSet = RIVAL:loadAnimationSet('move_ped_crouched')
    KNOCK_DOWN.isDown = true

    return SetTimecycleModifier('glasses_red')
  end

  KNOCK_DOWN.isDown = false
  SetTimecycleModifierStrength(0.0)
end

function KNOCK_DOWN:revivePlayer(playerPed, src)
  -- Todo
  -- Sync animations
  if DoesEntityExist(playerPed) then
    local offset = GetOffsetFromEntityInWorldCoords(playerPed, 0.8, 0.8, 0.0)
    local animDict = RIVAL:loadAnimDict('mini@cpr@char_a@cpr_str')
    local animDict2 = RIVAL:loadAnimDict('mini@cpr@char_a@cpr_def')

    SetEntityCoords(RIVAL.getPlayerPed(), offset.xy, offset.z)

    TaskPlayAnim(PlayerPedId(), animDict2, 'cpr_intro', 8.0, 1.0, -1, 2, 0, 0, 0, 0)
    Wait(2000)
    TaskPlayAnim(PlayerPedId(), animDict, 'cpr_pumpchest', 8.0, 1.0, -1, 9, 0, 0, 0, 0)
    Wait(7000)
    TaskPlayAnim(PlayerPedId(), animDict2, 'cpr_success', 8.0, 1.0, -1, 2, 0, 0, 0, 0)

    TriggerServerEvent('RIVAL::handleCPRAttempt', src)
  end
end

function KNOCK_DOWN:initialize()
  exports['spawnmanager']:setAutoSpawn(false)

  while GAME.playing do
    Wait(0)

    if RIVAL.getPlayerHealth() == 0 and not KNOCK_DOWN.isDown then
      local killer = GetPedSourceOfDeath(RIVAL.getPlayerPed())
      KNOCK_DOWN.lastKill = {
        killerName = GetPlayerName(killer) or 'Unknown',
        killerHealth = GetEntityHealth(killer) or 0,
        killerArmour = GetPedArmour(killer) or 0,
      }

      DEATH_SCREEN:playDeathEffect()
      KNOCK_DOWN:setKnocked(true)
    end

    if KNOCK_DOWN.isDown then
      AnimpostfxPlay('RaceTurbo', 0, true)
      RegisterNoirScreenEffectThisFrame()
      SetAudioSpecialEffectMode(2)
      SetTimecycleModifierStrength(1.5)
    end

    SQUAD:iteratePlayers(function(player, data)
      if KNOCK_DOWN.squadData[data.source] then
        local playerPed = GetPlayerPed(GetPlayerFromServerId(data.source))

        if #(RIVAL.getPlayerPosition() - GetEntityCoords(playerPed)) < 2.0 then
          DrawHelpMsg('Press ~INPUT_CONTEXT~ to Revive Player.')

          if IsControlJustPressed(1, 51) then
            KNOCK_DOWN:revivePlayer(playerPed, data.source)
          end
        end
      end
    end)
  end
end

-- Received synced data
RegisterNetEvent('RIVAL::syncKnockedDown', function(source, value)
  KNOCK_DOWN.squadData[source] = value
end)

RegisterNetEvent('RIVAL::handleCPRAttempt', function()
  if KNOCK_DOWN.isDown then
    KNOCK_DOWN.isDown = false
    NetworkResurrectLocalPlayer(RIVAL.getPlayerPosition())
    SetEntityHealth(RIVAL.getPlayerPed(), 125)
    AnimpostfxStop('RaceTurbo')
    ClearTimecycleModifier()
    SetTimeScale(1.0)
  end
end)

RegisterNetEvent('RIVAL::eliminatedSquad', function(data, damageGiven, xpGathered, killedPlayers)
  NUI:toggleFocus(true)
  NUI:redirect('/DeathPage')
  GAME.playing = false

  local killerName, killerHealth, killerArmour = KNOCK_DOWN.lastKill.killerName, KNOCK_DOWN.lastKill.killerHealth,
                                                 KNOCK_DOWN.lastKill.killerArmour
  local _data = {
    killerName = killerName,
    killerHealth = killerHealth,
    killerArmour = killerArmour,
    damageGiven = damageGiven,
    xpEarnt = xpGathered,
    playersKilled = killedPlayers,
  }

  NUI:sendCommand('SET_DEATH_PAGE_XP', data)
  NUI:sendCommand('SET_DEATH_CONTENT', _data)
end)
