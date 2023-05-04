-- vRP TUNNEL/PROXY
Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","Nova_Drugs")

-- RESOURCE TUNNEL/PROXY
NovaDrugsServer = {}
Tunnel.bindInterface("Nova_Drugs",NovaDrugsServer)
Proxy.addInterface("Nova_Drugs",NovaDrugsServer)
NovaDrugsClient = Tunnel.getInterface("Nova_Drugs","Nova_Drugs")

function NovaDrugsServer.IsPlayerNearCoords(source, coords, radius)
  local distance = #(GetEntityCoords(GetPlayerPed(source)) - coords)
  if distance < (radius + 0.00001) then
    return true
  end
  return false
end
