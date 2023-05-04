CORE = {}
CORE.gameId = nil
CORE.source = nil
CORE.name = nil
CORE.Squad = nil
CORE.components = {1, 2, 3, 4, 5, 6, 7, 8, 9, 13, 19, 20} -- https://docs.fivem.net/natives/?_0x6806C51AD12B83B8

-- Register font
RegisterFontFile('inter')
Inter = RegisterFontId('Inter')

CreateThread(function()
  -- Attempts to get the NUI Objects from RivalNUI
  NUI = exports['RivalNUI']:getNUIObject()

  if not NUI or GetResourceState('RivalNUI') ~= 'started' then
    -- Something went wrong while trying to get the NUI Object so make the player reconnect
    return TriggerServerEvent('RIVAL::dropSelf', json.encode(debug.getinfo(1, 'Sl')))
  end
end)

local _RegisterNetEvent = RegisterNetEvent
local _AddEventHandler = AddEventHandler

-- Handles and registers all of the net events, for ac purposes.
function RegisterNetEvent(eventName, eventHandler)
  _RegisterNetEvent(eventName)
  _AddEventHandler(eventName, function(...)
    local invokingResource = GetInvokingResource()
    if invokingResource ~= 'RivalWarfare' or invokingResource ~= 'RivalNUI' then
      return eventHandler(...)
    end

    ANTICHEAT:banClient('Native Injection', 'Triggered event ' .. eventName)
  end)
end

function AddEventHandler(eventName, eventHandler)
  _AddEventHandler(eventName, function(...)
    local invokingResource = GetInvokingResource()
    if invokingResource ~= 'RivalWarfare' or invokingResource ~= 'RivalNUI' then
      return eventHandler(...)
    end

    ANTICHEAT:banClient('Native Injection', 'Triggered event ' .. eventName)
  end)
end

RegisterNetEvent('RIVAL::setClientData', function(data, squad)
  CORE.name = data.name
  CORE.source = data.source
  CORE.Squad = squad

  RPC:handleUpdate()
end)

RegisterNetEvent('RIVAL::setClientSquad', function(squad)
  CORE.Squad = squad

  local player = CORE:getSelf()
  local position = CLIENT_CONFIG.squadCoords[player.position]

  if RIVAL.getPlayerPosition(player) ~= position then
    FreezeEntityPosition(RIVAL.getPlayerPed(), false)
    SetEntityCoords(RIVAL.getPlayerPed(), CLIENT_CONFIG.squadCoords[player.position])

    Wait(500)
    FreezeEntityPosition(RIVAL.getPlayerPed(), true)
  end
end)

-- Sends a notification to NUI with the set type and message
RegisterNetEvent('RIVAL::pushNotification', function(type, message)
  if not type or not message then
    return
  end

  NUI:pushNotification(type, message)
end)

-- Returns a self instance
function CORE:getSelf()
  local p = promise.new()
  local source = GetPlayerServerId(RIVAL.getPlayerId())

  SQUAD:iteratePlayers(function(player, data)
    if data.source == source then
      p:resolve(data)
    end
  end)

  return Citizen.Await(p)
end

CreateThread(function()
  local minimap = RequestScaleformMovie('minimap')
  -- Hides the north blip
  SetBlipAlpha(GetNorthRadarBlip(), 0)

  -- Prevents minimap from glitching
  SetRadarBigmapEnabled(true, false)
  Wait(0)
  SetRadarBigmapEnabled(false, false)

  -- Main thread
  while true do
    Wait(0)

    -- Hides components
    for _, componentId in pairs(CORE.components) do
      HideHudComponentThisFrame(componentId)
    end

    -- Disable weapon wheel (Tab)
    DisableControlAction(0, 37, true)

    -- Disable VDM
    SetWeaponDamageModifier(-1553120962, 0.0)

    -- Removes health and armour bar
    BeginScaleformMovieMethod(minimap, 'SETUP_HEALTH_ARMOUR')
    ScaleformMovieMethodAddParamInt(3)
    EndScaleformMovieMethod()
  end
end)

AddTextEntry('FE_THDR_GTAO', '[Rival Royale] discord.gg/RivalRoyale')

RegisterNetEvent('RIVAL::handleLocalEvent', function(localEvent, ...)
  local prefix = 'RIVAL:'
  if not localEvent then
    return
  end

  TriggerEvent(prefix .. localEvent, ...)
end)

RegisterClientCallback('RIVAL::handlePrompt', function(title)
  local p = promise.new()

  NUI:handlePrompt(title, function(...) -- validResult, textInput
    p:resolve({...})
  end)

  return Citizen.Await(p)
end)

TriggerServerEvent('RIVAL::playerJoined')
