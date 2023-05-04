-- 2018 Henric 'Kekke' Johansson
local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp", "lib/Tunnel")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP_tackle")

RegisterServerEvent("Nova:tryTackle")
AddEventHandler(
  "Nova:tryTackle",
  function(target)
    local target = target
    local source = source
    local user_id = vRP.getUserId({source})
    print(user_id)
    print(tostring(vRP.hasPermission({user_id, "police.menu", "admin.menu"})))
    if vRP.hasPermission({user_id, "police.menu", "admin.menu"}) then
      TriggerClientEvent("Nova:getTackled", target, source)
      TriggerClientEvent("Nova:playTackle", source)
    end
  end
)
