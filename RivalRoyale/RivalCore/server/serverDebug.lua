DEBUG = {}

-- Todo send to webhook
RegisterNetEvent('RIVAL::errorCaught', function(errorText)
  local source = source
  local coords = GetEntityCoords(GetPlayerPed(source))

  RIVAL.Hook('Error', {
    title = 'RIVAL WARFARE | ERROR LOGS',
    fields = {
      {name = 'Player Source: ', value = source or 'Unknown', inline = true},
      {name = 'Player Position: ', value = tostring(coords) or 'vec3(0, 0, 0)', inline = true},
      {name = 'Detected client error', value = errorText or 'Unknown'},
    },
  })
end)

function DEBUG:hookCrash(source, crashString)
  local coords = GetEntityCoords(GetPlayerPed(source))

  RIVAL.Hook('Crash', {
    title = 'RIVAL WARFARE | CRASH LOGS',
    fields = {
      {name = 'Player Source: ', value = source or 'Unknown', inline = true},
      {name = 'Player Position: ', value = tostring(coords) or 'vec3(0, 0, 0)', inline = true},
      {name = 'Detected user crash', value = errorText or 'Unknown'},
    },
  })
end
