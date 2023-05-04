RegisterCommand('report', function(source, args, rawCommand)
  -- local suspect = tonumber(args[1])
  -- args[1] = ''
  -- local reason = table.concat(args, ' ')
  -- if not suspect or not reason then
  --   return NUI:pushNotification('message', 'Invalid player or reason')
  -- end
  -- TriggerServerEvent('RIVAL::cheatingCase', suspect, reason)
end)

RegisterNetEvent('RIVAL::captureStream', function(data)
  NUI:sendCommand('START_CLIENT_RECORD', data)
end)

RegisterNUICallback('RIVAL::fetchCases', function(_, cb)
  local cases = TriggerServerCallback('RIVAL::fetchCases')
  cb(cases or {})
end)

RegisterSafeNUICallback('RIVAL::registerAdminOpinion', function(data)
  local id, cheating = data.id, data.cheating
  TriggerServerEvent('RIVAL::verifyOpinion', id, cheating)
end)

RegisterNetEvent('RIVAL::refreshVideoList', function(reports)
  NUI:sendCommand('FORCE_NEW_CASES', reports)
end)
