CONTROLS = {}
CONTROLS.protectionMode = false
CONTROLS.warningSystemOpen = false
CONTROLS.inventoryOpen = false
CONTROLS.keyActions = {}
CONTROLS.supportedKeys = CLIENT_CONFIG.supportedKeys

local function Kill()
  SetEntityHealth(RIVAL.getPlayerPed(), 0)
end

RegisterCommand('die', Kill)
RegisterCommand('suicide', Kill)
RegisterCommand('kill', Kill)

RegisterCommand('coords', function()
  print(RIVAL.getPlayerPosition())
end)

function CONTROLS:listenForKeys()
  local Controls = SETTINGS['savedSettings'].keyBindings

  for controlName, controlKey in pairs(Controls) do
    local keyIdx = self:getKeyIndex(controlKey)
    self.keyActions[string.gsub(controlName, '%s+', '')] = keyIdx
  end
end

function CONTROLS:getKeyIndex(keyName)
  return CONTROLS.supportedKeys[keyName]
end

function CONTROLS:toggleProtection(value)
  CONTROLS.protectionMode = value
end

CreateThread(function()
  while true do
    Wait(0)

    for controlName, controlKey in pairs(CONTROLS.keyActions) do
      if IsControlJustPressed(0, controlKey) or IsDisabledControlJustPressed(0, controlKey) and
        not CONTROLS.protectionMode then
        ExecuteCommand('+' .. controlName)
      end
    end
  end
end)
