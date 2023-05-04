local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
cop = {}
nhs = {}

RegisterServerEvent("ERP:ENABLEBLIPS")
AddEventHandler("ERP:ENABLEBLIPS", function()
  local user_id = vRP.getUserId({source})
  if vRP.hasPermission({user_id, "police.menu"}) or vRP.hasPermission({user_id, "emergency.vehicle"}) then
    print("works")
    TriggerClientEvent("ERP:BLIPS",source,cop,nhs)
  end
end)

Citizen.CreateThread(function()
  while true do
    Wait(10000)
    cop = {}
    nhs = {}
    local players = GetPlayers()
    for i,v in pairs(players) do
      name = GetPlayerName(v)
      local  user_id = vRP.getUserId({v})
      if user_id ~= nil then
        local coords = GetPlayerPed(v)

        if vRP.hasPermission({user_id, "police.menu"}) then
          cop[user_id] = {coords,v}
        end

        if vRP.hasPermission({user_id, "emergency.vehicle"}) then
          nhs[user_id] = {coords,v}
        end
      end
    end
  end
end)