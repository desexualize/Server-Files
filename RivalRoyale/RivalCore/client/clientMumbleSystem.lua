MUMBLE = {}
MUMBLE.paused = false
MUMBLE.muted = false
MUMBLE.proximityRange = 3.0

-- Mumble events
AddEventHandler('mumbleConnected', function(address, reconnecting)
  print('^2Mumble Connected')
end)

AddEventHandler('mumbleDisconnected', function(address)
  print('^1Mumble Disconnected')
end)

-- Conncets to mumble
function MUMBLE:connectClient()
  NetworkSetTalkerProximity(self.proximityRange)
  NetworkClearVoiceChannel()
  NetworkSetVoiceActive(true)

  -- Set the default intent (enable noise suppression and high pass filter)
  MumbleSetAudioInputIntent(GetHashKey('speech'))
end

-- Disconnects from mumble
function MUMBLE:disconnectClient()
  NetworkSetTalkerProximity(0.0)
  NetworkClearVoiceChannel()
  NetworkSetVoiceActive(false)
end

-- Disables voice activity through a keybind
RegisterCommand('+MUTEPLAYERS', function()
  MUMBLE.muted = not MUMBLE.muted

  if not MUMBLE.paused then
    if MUMBLE.muted then
      NUI:pushNotification('message', 'DISABLED VOICE ACIVITY')
      return MUMBLE:disconnectClient()
    end

    MUMBLE.paused = true
    MUMBLE:connectClient()
    while not MumbleIsConnected() do
      Wait(50)
    end

    MUMBLE.paused = false
    NUI:pushNotification('message', 'ENABLED VOICE ACIVITY')
  end
end)
