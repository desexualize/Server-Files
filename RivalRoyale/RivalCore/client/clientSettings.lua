SETTINGS = {}
SETTINGS.queryString = 'rival_settings'
SETTINGS.nuiCallback = nil
SETTINGS.conversationRates = {
  ['RENDER DISTANCE'] = {
    [0] = 0.1,
    [1] = 0.2,
    [2] = 0.3,
    [3] = 0.5,
    [4] = 0.75,
    [5] = 1.0,
    [6] = 1.5,
    [7] = 2.5,
    [8] = 5.0,
    [9] = 10.0,
    [10] = 25.0,
  },
}

SETTINGS.savedSettings = {
  gamePlay = {
    -- nativeFunction = The function that will be called
    -- affectedArg = Index in nativeArgs of the changed value, 
    -- nativeArgs = List of all needed arguments
    -- threadTick = If the function is supposed to be called every frame
    -- type = The type of setting (Slider | Toggle)
    -- value = Value of the setting

    ['ENABLE SHADOWS'] = {
      nativeShit = {
        nativeFunction = 'SetPedAoBlobRendering',
        affectedArg = 2,
        nativeArgs = {PlayerPedId(), false},
        threadTick = false,
      },
      type = 'toggle',
      value = false,
    },
    ['DISABLE AUTO RELOAD'] = {
      nativeShit = {
        nativeFunction = 'SetWeaponsNoAutoreload',
        affectedArg = 1,
        nativeArgs = {false},
        threadTick = false,
      },
      type = 'toggle',
      value = false,
    },
    ['RENDER DISTANCE'] = {
      nativeShit = {
        nativeFunction = 'OverrideLodscaleThisFrame',
        affectedArg = 1,
        nativeArgs = {1.0},
        threadTick = true,
      },
      type = 'slider',
      value = 1.0,
      range = {min = 1, max = 10},
    },
  },

  keyBindings = {
    ['HOTBAR SLOT 1'] = '1',
    ['HOTBAR SLOT 2'] = '2',
    ['HOTBAR SLOT 3'] = '3',
    ['HOTBAR SLOT 4'] = '4',
    ['INVENTORY'] = 'TAB',
    ['MUTE PLAYERS'] = 'M',
    ['STORE ALL WEAPONS'] = 'NONE',
    ['STORE WEAPON '] = 'NONE',
    ['WARNING SYSTEM'] = 'F5',
  },
  audioVolumes = {['SOUND EFFECTS'] = 1.0},
}

SETTINGS.defaultSettings = SETTINGS.savedSettings
SETTINGS.threadHandler = {}

function SETTINGS:convertIfAllowed(key, value, reversed)
  if not reversed and SETTINGS.conversationRates[key] then
    return SETTINGS.conversationRates[key][value]
  end

  if reversed and SETTINGS.conversationRates[key] then
    for k, v in pairs(SETTINGS.conversationRates[key]) do
      if v == value then
        return k
      end
    end
  end

  return value
end

function SETTINGS:useSettings()
  self.threadHandler = {}

  for settingName, settingData in pairs(self.savedSettings.gamePlay) do
    if settingData.nativeShit.threadTick then
      if not SETTINGS.threadHandler[settingName] then
        SETTINGS.threadHandler[settingName] = settingData
      end
    else
      _G[settingData.nativeShit.nativeFunction](table.unpack(settingData.nativeShit.nativeArgs))
    end
  end

  SetResourceKvp(self.queryString, json.encode(self.savedSettings))
end

function SETTINGS:saveSettings()
  local storedSettings = json.decode(GetResourceKvpString(self.queryString))
  if storedSettings == self.savedSettings then
    return
  end

  self:useSettings()
end

function SETTINGS:loadSettings()
  local loadedSettings = GetResourceKvpString(self.queryString)
  if not loadedSettings then
    return
  end

  local decodedSettings = json.decode(loadedSettings)

  if tableCount(decodedSettings.keyBindings) == tableCount(SETTINGS.savedSettings.keyBindings) and
    tableCount(decodedSettings.gamePlay) == tableCount(SETTINGS.savedSettings.gamePlay) and
    tableCount(decodedSettings.audioVolumes) == tableCount(SETTINGS.savedSettings.audioVolumes) then
    self.savedSettings = decodedSettings
  end

  Wait(500)
  SETTINGS:useSettings()
end

CreateThread(function()
  SETTINGS:loadSettings()
  CONTROLS:listenForKeys()

  while true do
    Wait(0)

    for settingName, settingData in pairs(SETTINGS.threadHandler) do
      _G[settingData.nativeShit.nativeFunction](table.unpack(settingData.nativeShit.nativeArgs))
    end
  end
end)

RegisterNUICallback('RIVAL::fetchSettings', function(data, cb)
  local filteredSettings = {
    GamePlay = {},
    KeyBinds = SETTINGS.savedSettings.keyBindings,
    Audio = SETTINGS.savedSettings.audioVolumes,
  }

  for k, v in pairs(SETTINGS.savedSettings.gamePlay) do
    local convertedValue = SETTINGS:convertIfAllowed(k, v.value, true)

    if v.type == 'slider' then
      filteredSettings.GamePlay[k] = {type = v.type, value = convertedValue, range = v.range}
    else
      filteredSettings.GamePlay[k] = {type = v.type, value = convertedValue}
    end
  end

  cb(filteredSettings)
end)

RegisterSafeNUICallback('RIVAL::applySettings', function(newSettings)
  if not newSettings then
    return
  end

  for k, v in pairs(newSettings) do
    local savedConfig = SETTINGS.savedSettings.gamePlay[k]

    savedConfig.value = v.value

    if v.type == 'slider' then
      local convertedValue = SETTINGS:convertIfAllowed(k, v.value)
      savedConfig.nativeShit.nativeArgs[savedConfig.nativeShit.affectedArg] = convertedValue
      savedConfig.value = convertedValue
    else
      savedConfig.nativeShit.nativeArgs[savedConfig.nativeShit.affectedArg] = v.value
      savedConfig.value = v.value
    end

    SETTINGS.savedSettings.gamePlay[k] = savedConfig
  end

  SETTINGS:saveSettings()
  NUI:pushNotification('message', 'You have saved settings')
end)

RegisterSafeNUICallback('RIVAL::applyKeys', function(newKeysData)
  if not newKeysData then
    return
  end

  SETTINGS.savedSettings.keyBindings = newKeysData
  SETTINGS:saveSettings()
  CONTROLS:listenForKeys()
  NUI:pushNotification('message', 'You have saved settings')
end)

RegisterNUICallback('RIVAL::IsKeySafe', function(controlKey, cb)
  local keyIdx = CONTROLS:getKeyIndex(controlKey)
  cb(keyIdx ~= nil)
end)

-- Todo
-- Actually make the sounds work
RegisterSafeNUICallback('RIVAL::applyVolume', function(newVolumes)
  if not newVolumes then
    return
  end

  SETTINGS.savedSettings.audioVolumes = newVolumes
  SETTINGS:saveSettings()
  SETTINGS.nuiCallback(SETTINGS.savedSettings.audioVolumes['SOUND EFFECTS'])
  NUI:pushNotification('message', 'You have saved settings')
end)

RegisterSafeNUICallback('RIVAL::resetSettings', function()
  SETTINGS.savedSettings = SETTINGS.defaultSettings
  SETTINGS:saveSettings()
  CONTROLS:listenForKeys()
  NUI:pushNotification('message', 'You have reseted settings')
end)

-- Event is not networked so callbacks can be used
AddEventHandler('RIVAL::getVolume', function(callback)

  -- Saves the callback so it can be called once settings change.
  SETTINGS.nuiCallback = callback
  callback(SETTINGS.savedSettings.audioVolumes['SOUND EFFECTS'])
end)
