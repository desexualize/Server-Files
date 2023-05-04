CHAT = {}
CHAT.cache = {}

function RIVAL:getChatTag(player)
  if not player then
    return 'MEMBER'
  end

  if CHAT.cache[player] then
    return CHAT.cache[player]
  end

  local query = ('SELECT ChatTag FROM rival_userdata WHERE UID = %s'):format(player)
  local chatTag = DATABASE:queryResult(query)[1].ChatTag or 'MEMBER'
  CHAT.cache[player] = chatTag

  return chatTag
end

RegisterServerEvent('RIVAL::broadCastMessage', function(chatMessage)
  if not chatMessage then
    return
  end

  local source = source
  local player = RIVAL:getPlayer(source)
  local chatTag = RIVAL:getChatTag(player)

  chatMessage.chatTag = {label = chatTag, color = SERVER_CONFIG.chatTags[chatTag]}
  chatMessage.author = GetPlayerName(source)

  -- RIVAL.Hook('Chat', {
  --   title = 'RIVAL WARFARE | CHAT LOGS',
  --   fields = {
  --     {name = 'User ID:', value = player or 'Unknown', inline = true},
  --     {name = 'Chat Tag', value = chatMessage.chatTag.label or 'MEMBER', inline = true},
  --     {name = 'Section', value = chatMessage.section or 'None', inline = true},
  --     {name = 'Message', value = chatMessage.chatMessage or 'None', inline = false},
  --   },
  -- })

  if chatMessage.author and chatMessage.chatTag then
    if chatMessage.section == 'SQUAD' then
      local Squad = RIVAL:getPlayerSquad(player)

      return Squad:iteratePlayers(function(player, data)
        TriggerClientEvent('RIVAL::pushMessage', data.source, chatMessage)
      end)
    end

    TriggerClientEvent('RIVAL::pushMessage', -1, chatMessage)
  end
end)

function RIVAL:reloadChatTag(player)
  local query = ('SELECT ChatTag FROM rival_userdata WHERE UID = %s'):format(player)
  local chatTag = DATABASE:queryResult(query)[1].ChatTag or 'MEMBER'

  CHAT.cache[player] = chatTag
end
