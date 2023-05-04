CreateThread(function()
  if TriggerServerCallback('RIVAL::getServerMode') then
    RegisterCommand('devmode', function()
      SQUAD:exitSquad()
      TriggerServerEvent('RIVAL::developerMode')
    end)

    RegisterCommand('devweapon', function(source, args, rawCommand)
      TriggerServerEvent('RIVAL::giveWeapon', args[1])
    end)
  end
end)
