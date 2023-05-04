-- 2018 Henric 'Kekke' Johansson
local Proxy = module("AQUA", "lib/Proxy")
local Tunnel = module("AQUA","lib/Tunnel")
AQUA = Proxy.getInterface("AQUA")
AQUAclient = Tunnel.getInterface("AQUA","AQUA_tackle")


RegisterServerEvent('AQUA:tryTackle')
AddEventHandler('AQUA:tryTackle', function(target)
  local target = target
  local source = source
  local user_id = AQUA.getUserId({source})
  if AQUA.hasPermission({user_id, "police.armoury"}) or AQUA.hasGroup({user_id, 'dev'}) then
	  TriggerClientEvent('AQUA:getTackled', target, source)
    TriggerClientEvent('AQUA:playTackle', source)
  end
end)