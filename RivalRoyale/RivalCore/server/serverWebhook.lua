local Hooks = SERVER_CONFIG.hooks

function RIVAL.Hook(hookType, data)
  if not Hooks[hookType] then
    return
  end

  local payload = {
    username = '[Rival Royale]',
    color = 16646021,
    embeds = {
      {
        title = '**' .. data.title .. '**',
        color = 16646021,
        fields = data.fields,
        footer = {text = 'Made by the Rival Development Team | Time: ' .. os.date('%X')},
      },
    },
    avatar_url = 'https://cdn.discordapp.com/attachments/708610221970554950/909543560192327730/small-logo.jpg',
  }

  PerformHttpRequest(Hooks[hookType], function(err, text, headers)
    if tonumber(err) ~= 204 then
      local errorText = ('ERROR [%s] WHILE SENDING WEBHOOK'):format(err)
      print(errorText)
    end
  end, 'POST', json.encode(payload), {['Content-Type'] = 'application/json'})
end
