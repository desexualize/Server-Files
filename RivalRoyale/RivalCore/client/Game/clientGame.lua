GAME = {}
GAME.waiting = false
GAME.playing = false
GAME.members = {}

local cachedMembers = nil

function GAME:setupUI()
  local anchor = RIVAL:getMinimapAnchor()
  local w, h = GetActiveScreenResolution()
  local data = TriggerServerCallback('RIVAL::fetchGameInfo')

  NUI:redirect('/InGame')
  NUI:sendCommand('CLEAR_VENDOR_CART')
  COMPASS:handleDirection()

  CreateThread(function()
    SQUAD:iteratePlayers(function(player, data)
      self.members[data.source] = {name = data.name, talking = false, avatar = data.avatar}
    end)

    cachedMembers = self.members
    NUI:sendCommand('SET_SQUAD_MEMBERS', self.members)
    NUI:sendCommand('SET_GAME_INFO_ANCHOR', {width = anchor.width * w, x = anchor.x * w, y = anchor.y * h - (h / 30)})
    NUI:sendCommand('SET_GAME_INFO', {cash = data.cash, players = data.players, kills = data.kills})
    CreateThread(self.handleGameInfo)

    while self.playing or self.waiting do
      Wait(75)

      self:handleVoiceInput()
      self:handleWeaponChange()
    end
  end)
end

local cachedAmmo = nil
local cachedClipAmmo = nil
local cachedWeapon = nil

function GAME:handleWeaponChange()
  local hasWeapon, weaponHash = GetCurrentPedWeapon(RIVAL.getPlayerPed())

  if hasWeapon then
    local weaponName = SHARED_CONFIG.weaponNames[weaponHash] and SHARED_CONFIG.weaponNames[weaponHash][1]

    -- Invalid hash
    if not weaponName and weaponHash ~= 0 then
      return
    end

    -- Cache of weapon holder
    if cachedWeapon ~= weaponName then
      cachedWeapon = weaponName

      NUI:sendCommand('EQUIP_WEAPON', weaponName)
    end

    local _, clipAmmo = GetAmmoInClip(RIVAL.getPlayerPed(), weaponHash)
    local ammo = GetAmmoInPedWeapon(RIVAL.getPlayerPed(), weaponHash) - clipAmmo

    -- Cacho of ammo
    if cachedAmmo == ammo and cachedClipAmmo == clipAmmo then
      return
    end

    cachedAmmo = ammo
    cachedClipAmmo = clipAmmo

    NUI:sendCommand('FORCE_AMMO_DATA', {ammo = ammo, clip = clipAmmo})
  else
    -- Resets cache
    cachedWeapon = nil

    -- Hides the weapon holder
    NUI:sendCommand('EQUIP_WEAPON', '')
  end
end

function GAME:handleGameInfo()
  while GAME.playing do
    Wait(5000)

    if not GAME.playing then
      break
    end

    local data = TriggerServerCallback('RIVAL::fetchGameInfo')
    if data then
      NUI:sendCommand('SET_GAME_INFO', {cash = data.cash, players = data.players, kills = data.kills})
    end
  end
end

RegisterNetEvent('RIVAL::forceSetInfo', function(data)
  NUI:sendCommand('SET_GAME_INFO', {cash = data.cash, players = data.players, kills = data.kills})
end)

function GAME:handleVoiceInput()
  local hasChanged = false

  SQUAD:iteratePlayers(function(player, data)
    local player = GetPlayerFromServerId(data.source)
    if NetworkIsPlayerTalking(player) then
      if not cachedMembers[data.source].talking then
        hasChanged = true
      end

      self.members[data.source].talking = true
    else
      if cachedMembers[data.source].talking then
        hasChanged = true
      end

      self.members[data.source].talking = false
    end
  end)

  if not hasChanged then
    return
  end

  NUI:sendCommand('SET_SQUAD_MEMBERS', self.members)
end

function GAME:GMode(toggle)
  local playerPed = RIVAL.getPlayerPed()
  GAME.GModeToggled = toggle

  SetEntityInvincible(playerPed, toggle)
  SetPlayerInvincible(playerPed, toggle)
  ClearPedBloodDamage(playerPed)
  ResetPedVisibleDamage(playerPed)
  ClearPedLastWeaponDamage(playerPed)
  SetEntityProofs(playerPed, toggle, toggle, toggle, toggle, toggle, toggle, toggle, toggle)
  SetEntityCanBeDamaged(playerPed, not toggle)
  NetworkSetFriendlyFireOption(not toggle)
end

-- Player won the game GG
RegisterNetEvent('RIVAL::handleWinning', function(data)
  NUI:toggleFocus(true)
  NUI:redirect('/Winner')
  DisplayRadar(false)
  GAME.playing = false

  NUI:sendCommand('SET_WINNER_DATA', data)
end)

RegisterNUICallback('RIVAL::getWinningPlayers', function(_, cb)
  local players = {}
  SQUAD:iteratePlayers(function(player, data)
    players[#players + 1] = {uid = player, name = data.name}
  end)

  cb(players)
end)

-- Kill feed
RegisterNetEvent('RIVAL::registerKill', function(deathString, deathDistance)
  NUI:sendCommand('REGISTER_KILL', {message = deathString, distance = deathDistance})
end)

-- Fixes a parachute bug
local function playerKilled()
  RemoveWeaponFromPed(RIVAL.getPlayerPed(), GetHashKey('gadget_parachute'))
  GM:playerKilled()
end

AddEventHandler('baseevents:onPlayerDied', playerKilled)
AddEventHandler('baseevents:onPlayerKilled', playerKilled)

