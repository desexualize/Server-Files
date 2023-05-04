-- 2018 Henric 'Kekke' Johansson
local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp","lib/Tunnel")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_tackle")


RegisterServerEvent('ERP:tryTackle')
AddEventHandler('ERP:tryTackle', function(target)
  local target = target
  local source = source
  local user_id = vRP.getUserId({source})
  print(user_id)
  print(tostring(vRP.hasPermission({user_id, "police.menu"})))
  if vRP.hasPermission({user_id, "police.menu"}) then
	  TriggerClientEvent('ERP:getTackled', target, source)
    TriggerClientEvent('ERP:playTackle', source)
  end
end)