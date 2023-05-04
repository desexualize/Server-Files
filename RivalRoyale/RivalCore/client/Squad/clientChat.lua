local selectedSection = 'GLOBAL'

-- Attempt to broadcast a chat message
RegisterSafeNUICallback('RIVAL::registerChatMessage', function(messageData)
  local messageStr = messageData.chatMessage

  -- Check if message starts with a / and execute it as a command if so
  if string.sub(messageStr, 1, 1) == '/' then
    return ExecuteCommand(messageStr:sub(2))
  end

  TriggerServerEvent('RIVAL::broadCastMessage', messageData)
end)

-- Broadcasts message to the client
RegisterNetEvent('RIVAL::pushMessage', function(message)
  if message.section == selectedSection then
    NUI:sendCommand('PUSH_CHAT_MESSAGE', message)
  end
end)

-- Updates chat section and gets cached server sided
RegisterSafeNUICallback('RIVAL::setChatSection', function(section)
  selectedSection = section
end)

-- Disables keybinds to pressed while typing in chat
RegisterSafeNUICallback('RIVAL::toggleKeys', function(toggle)
  CONTROLS:toggleProtection(toggle)
end)

CreateThread(function()
  -- Sets the default chat section
  TriggerServerEvent('RIVAL::setChatSection', 'GLOBAL')
end)

