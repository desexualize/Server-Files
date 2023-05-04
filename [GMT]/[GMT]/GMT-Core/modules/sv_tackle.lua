-- 2018 Henric 'Kekke' Johansson
local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp","lib/Tunnel")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_tackle")


RegisterServerEvent('GMT:tryTackle')
AddEventHandler('GMT:tryTackle', function(target)
  local target = target
  local source = source
  local user_id = vRP.getUserId({source})
  if vRP.hasPermission({user_id, "police.armoury"}) or vRP.hasGroup({user_id, 'dev'}) then
	  TriggerClientEvent('GMT:getTackled', target, source)
    TriggerClientEvent('GMT:playTackle', source)
  end
end)