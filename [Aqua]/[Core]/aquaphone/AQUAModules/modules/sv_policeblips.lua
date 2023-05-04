local Tunnel = module("AQUA", "lib/Tunnel")
local Proxy = module("AQUA", "lib/Proxy")
AQUA = Proxy.getInterface("AQUA")
cop = {}
nhs = {}

RegisterServerEvent("AQUA:ENABLEBLIPS")
AddEventHandler("AQUA:ENABLEBLIPS", function()
  local user_id = AQUA.getUserId({source})
  if AQUA.hasPermission({user_id, "police.menu"}) or AQUA.hasPermission({user_id, "emergency.vehicle"}) then
    TriggerClientEvent("AQUA:BLIPS",source,cop,nhs)
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
      local  user_id = AQUA.getUserId({v})
      if user_id ~= nil then
        local coords = GetPlayerPed(v)

        if AQUA.hasPermission({user_id, "police.menu"}) then
          cop[user_id] = {coords,v}
        end

        if AQUA.hasPermission({user_id, "emergency.vehicle"}) then
          nhs[user_id] = {coords,v}
        end
      end
    end
  end
end)