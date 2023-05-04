SQUAD = {}
SQUAD.textThreadTick = 0
SQUAD.ready = false
SQUAD.cam = nil
SQUAD.hideText = false
SQUAD.inSquad = false

function SQUAD:refreshCharacter()
  local model = RIVAL:loadModel(GetHashKey(CLIENT_CONFIG.playerModel))

  SetPlayerModel(PlayerId(), model)
  SetModelAsNoLongerNeeded(model)

  Wait(100)
  NUI:sendCommand('REQUEST_CLOTHING')
end

function SQUAD:exitSquad()
  self.inSquad = false
  self.ready = false

  NetworkSetFriendlyFireOption(true)
  SetCanAttackFriendly(RIVAL.getPlayerPed(), true, true)
  RenderScriptCams(false, true, 500, true, true)
  DestroyCam(self.cam, true)
  FreezeEntityPosition(RIVAL.getPlayerPed(), false)
  NUI:redirect('/hidden')
  NUI:toggleFocus(false)
  NUI:keepInput(false)
end

function SQUAD:setReadyState(value)
  self.ready = value
  TriggerServerEvent('RIVAL::setClientReady', value)
end

function SQUAD:iteratePlayers(callback)
  if not CORE.Squad then
    return
  end

  for player, data in pairs(CORE.Squad.players) do
    callback(player, data)
  end
end

function SQUAD:togglePlayerText(state)
  SQUAD.hideText = state
end

function SQUAD:setCamPos(pos)
  SetCamCoord(self.cam, pos)
end

local animList = CLIENT_CONFIG.animList
local loadedCount = tableCount(animList)

-- Loads random animation from the anim list
function SQUAD:getRandomMovement()
  local randomNum = math.random(1, loadedCount)
  local num = 0

  for animName, animDict in pairs(animList) do
    num = num + 1

    if num == randomNum then
      local loadedDict = RIVAL:loadAnimDict(animDict)
      return loadedDict, animName
    end
  end
end

function SQUAD:randomMovement()
  ClearPedTasksImmediately(RIVAL.getPlayerPed())

  while SQUAD.inSquad do
    Wait(45 * 1000)

    if not SQUAD.inSquad then
      break
    end

    local animDict, animName = SQUAD:getRandomMovement()
    if animDict and animName then
      TaskPlayAnim(RIVAL.getPlayerPed(), animDict, animName, 1.0, 1.0, 5000, 9, 1)
    end
  end
end

function SQUAD:resetPlayer()
  local playerPed = RIVAL.getPlayerPed()

  AnimpostfxStop('RaceTurbo')
  ClearTimecycleModifier()
  SetTimeScale(1.0)
  SetPedPopulationBudget(0)
  SetVehiclePopulationBudget(0)
  SetEntityHeading(playerPed, 60.0)
  SetEntityHealth(playerPed, 200)
  ResetEntityAlpha(playerPed)
  ClearPedBloodDamage(playerPed)
  ResetPedVisibleDamage(playerPed)
  ClearPedLastWeaponDamage(playerPed)
  NetworkSetFriendlyFireOption(false)
  SetCanAttackFriendly(playerPed, false, false)
  SetWeaponsNoAutoswap(true)
  RefillAmmoInstantly(true)
  DisplayRadar(false)
  FreezeEntityPosition(playerPed, true)
  RemoveAllPedWeapons(playerPed, true)
  NetworkSetEntityInvisibleToNetwork(playerPed, false)
  ResetEntityAlpha(playerPed)
  SetEntityVisible(playerPed, true, true)
  SetLocalPlayerVisibleLocally(false)
end

function SQUAD:enterSquad(position)
  local SquadCoords = position and CLIENT_CONFIG.squadCoords[position] or CLIENT_CONFIG.squadCoords['middle']

  self.ready = false
  self.inSquad = true
  self.cam = CreateCam('DEFAULT_SCRIPTED_CAMERA')

  NUI:redirect('/')
  MAP:toggleIsland(true)
  SQUAD:handleText()
  SQUAD:resetPlayer()
  SetCamActive(self.cam, true)
  SetCamCoord(self.cam, CLIENT_CONFIG.camCoords)
  PointCamAtCoord(self.cam, CLIENT_CONFIG.squadCoords['middle'])
  RenderScriptCams(true, false, 0, true, true)
  SetEntityCoords(RIVAL.getPlayerPed(), SquadCoords - vector3(0.0, 0.0, 1.0))
  TriggerEvent('RIVAL:onJoinSquad', CORE.Squad)

  CreateThread(function()
    -- Add a delay
    Wait(100)

    NUI:toggleFocus(true)
    NUI:keepInput(true)
    NUI:sendCommand('CLEAR_SQUAD_CHAT')
    NUI:sendCommand('SET_SQUAD_INFO', TriggerServerCallback('RIVAL::fetchPlayerData'))

    TriggerServerEvent('RIVAL::setRoutingBucket')
    CreateThread(SQUAD.randomMovement)

    while SQUAD.inSquad do
      Wait(0)

      -- Disable controls while in Squad
      DisableAllControlActions()
    end
  end)
end

RegisterCommand('ready', function()
  SQUAD.ready = not SQUAD.ready
  SQUAD:setReadyState(SQUAD.ready)
end)

RegisterCommand('invite', function(source, args, rawCommand)
  TriggerServerEvent('RIVAL::clientInvitationProcess', tonumber(args[1]))
end)

RegisterSafeNUICallback('RIVAL::invitePlayer', function(player)
  if not player then
    return
  end

  TriggerServerEvent('RIVAL::clientInvitationProcess', player)
end)

RegisterClientCallback('RIVAL::inviteClient', function(name, ticket)
  -- Client has to be in squad
  if not SQUAD.inSquad then
    return
  end

  local p = promise.new()

  -- Format the notification
  NUI:pushNotification('invite', ('You have been invited by %s'):format(name), ticket, 'RIVAL::handleInvite')

  SetTimeout(30000, function()
    p:reject({false, nil}) -- Client took to long over 30s so reject the invite request
  end)

  function handleInvite(data)
    p:resolve(data)
  end

  -- Wait for the promise to resolve
  return Citizen.Await(p)
end)

RegisterSafeNUICallback('RIVAL::handleInvite', function(data)
  handleInvite(data)
end)

RegisterNetEvent('RIVAL::clientEnterSquad', function(squadId, position)
  SQUAD.inSquad = false
  CORE.SquadId = squadId
  Wait(250)
  SQUAD:enterSquad(position)
end)

RegisterSafeNUICallback('RIVAL::launchSquad', function(selectedGame, cb)
  local canContinue = true
  if not CORE.Squad then
    return error('Invalid Squad')
  end

  -- All players have to be ready
  SQUAD:iteratePlayers(function(player, data)
    if not data.ready then
      NUI:pushNotification('message', 'All players in Squad need to be ready')
      canContinue = false
    end
  end)

  if not selectedGame or #selectedGame == 0 then
    -- No selected gamemode was found
    if canContinue then
      return NUI:pushNotification('message', 'Select a Game Mode')
    end
  end

  if canContinue then
    TriggerServerEvent('RIVAL::setSquadWaiting', selectedGame)
  end
end)

RegisterSafeNUICallback('RIVAL::leaveSquad', function(data, cb)
  if not SQUAD.inSquad then
    local cachedSquad = CORE.Squad

    GAME.waiting = false
    GAME.playing = false

    NUI:redirect('/hidden')
    DoScreenFadeOut(250)
    Wait(250)
    TriggerServerEvent('RIVAL::exitSquad')

    repeat
      Wait(15)
    until cachedSquad ~= CORE.Squad

    Wait(250)
    DoScreenFadeIn(250)

    return
  end

  TriggerServerEvent('RIVAL::exitSquad')
end)

AddEventHandler('playerSpawned', function()
  SQUAD:refreshCharacter()
  SQUAD:enterSquad()
  MUMBLE:connectClient()
end)

CreateThread(function()
  SQUAD:refreshCharacter()
  SQUAD:enterSquad()
  MUMBLE:connectClient()
end)

function SQUAD:handleText()
  CreateThread(function()
    while SQUAD.inSquad do
      Wait(SQUAD.textThreadTick or 0)

      if not SQUAD.hideText then
        SQUAD.textThreadTick = 0

        SQUAD:iteratePlayers(function(player, data)
          local pos = CLIENT_CONFIG.squadCoords[data.position]
          local readyState = data.ready and 'READY' or 'NOT READY'
          local z = pos.z + 0.985

          DrawSquadText(pos.x, pos.y, z + 0.12, data.name)
          DrawReadyText(pos.x, pos.y, z, readyState, data.ready)
        end)
      else
        SQUAD.textThreadTick = 150
      end
    end
  end)
end

