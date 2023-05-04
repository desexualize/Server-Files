RPC = {}

function RPC:handleUpdate(playerCount, InGame)
  if InGame then
    return SetRichPresence(('Playing %s | %s / 32'):format(GM.type, playerCount or 1))
  end

  SetRichPresence(('Waiting in Squad | %s / 3'):format(playerCount))
end

-- Initializes Discord RPC
function RPC:init()
  SetDiscordAppId(906291988414996491)
  SetDiscordRichPresenceAsset('logo')
  SetDiscordRichPresenceAction(0, 'Discord', 'https://www.discord.com')
  SetDiscordRichPresenceAction(1, 'Connect', 'https://www.google.com')

  RPC:handleUpdate()
end

-- Squad
AddEventHandler('RIVAL:onJoinSquad', function()
  local numPlayers = 1
  if CORE.Squad then
    numPlayers = #CORE.Squad.players
  end

  RPC:handleUpdate(numPlayers)
end)

AddEventHandler('RIVAL:onPlayerJoinSquad', function()
  local numPlayers = 1
  if CORE.Squad then
    numPlayers = #CORE.Squad.players
  end

  RPC:handleUpdate(numPlayers)
end)

-- Game
AddEventHandler('RIVAL:onPlayerJoinGame', function(playerCount)
  RPC:handleUpdate(playerCount, true)
end)

CreateThread(RPC.init)
