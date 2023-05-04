CHAT_TIPS = {}
CHAT_TIPS.validSections = {'GLOBAL', 'SQUAD', 'EU', 'US'}
CHAT_TIPS.list = {
  'Join our discord discord.gg/RivalRoyale',
  'Have more fun playing with friends with duos and squads',
  'You can change your keybinds within the settings menu',
  'Check the store to get access to exclusive skins',
  'Open chests for special loot',
  'You can trade skins with other players with the trading system',
  'You can invite your friends through the friends list',
}

function CHAT_TIPS:getTip()
  return CHAT_TIPS.list[math.random(1, #CHAT_TIPS.list)]
end

CreateThread(function()
  while true do
    -- Wait 5 minutes
    Wait(60 * 1000 * 5)

    for i = 1, 4 do
      local chatMessage = {}

      chatMessage.author = ''
      chatMessage.chatTag = {label = 'SERVER', color = '#fdff85'}
      chatMessage.section = CHAT_TIPS.validSections[i]
      chatMessage.chatMessage = CHAT_TIPS:getTip()

      TriggerClientEvent('RIVAL::pushMessage', -1, chatMessage)
    end
  end
end)
