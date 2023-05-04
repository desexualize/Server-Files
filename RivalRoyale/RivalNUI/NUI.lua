NUI = {}
NUI.soundVolume = 0

function NUI:toggleFocus(bool)
  SetNuiFocus(bool, bool)
end

function NUI:keepInput(bool)
  SetNuiFocusKeepInput(bool)
end

function NUI:playSound(fileName)
  self:sendCommand('PLAY_SOUND', {fileName = fileName, volume = self.soundVolume})
end

function NUI:play3DAudio(fileName, coords)
  local coords = coords or GetEntityCoords(PlayerPedId())
  local camRot = rotationToDirection(GetGameplayCamRot(0))

  self:sendCommand('PLAY_3D_AUDIO', {
    audioFile = fileName,
    coords = coords,
    rotation = {x = camRot.x, y = camRot.y, z = camRot.z},
    volume = self.soundVolume,
  })
end

function NUI:extraModule(module, display)
  self:sendCommand('HANDLE_MODULE', {label = module, display = display})
end

function NUI:redirect(url)
  self:sendCommand('REDIRECT_TO_URL', url)
end

local currNotificationIdx = 0

function NUI:pushNotification(type, message, id, callbackUrl)
  if not id then
    currNotificationIdx = currNotificationIdx + 1
    id = currNotificationIdx
  end

  self:sendCommand('PUSH_NEW_NOTIFICATION', {type = type, message = message, id = id, callbackUrl = callbackUrl})
end

local capturedCallback

RegisterNUICallback('RIVAL::handlePromptCb', function(data)
  local info = debug.getinfo(1, 'Sl')
  local txtColor = data == 'ERROR' and '^1' or '^3'
  Citizen.Trace(('Prompt Callback %s%s ^2%s\n'):format(txtColor, data, json.encode(info)))

  if data == 'ERROR' then
    return capturedCallback(false, nil)
  end

  capturedCallback(true, data)
end)

function NUI:handlePrompt(reason, cb)
  local display = type(reason) == 'string'
  capturedCallback = cb

  self:sendCommand('HANDLE_TEXT_MODAL', {display = display, reason = reason, idx = cbIdx})
end

function NUI:sendCommand(eventName, data)
  SendNUIMessage({command = eventName, data = data})
end

function getNUIObject()
  return NUI
end

TriggerEvent('RIVAL::getVolume', function(volume)
  NUI.soundVolume = volume
end)

