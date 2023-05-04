-- vRP TUNNEL/PROXY
Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","GRP_Drugs")

-- RESOURCE TUNNEL/PROXY
GRPDrugsServer = {}
Tunnel.bindInterface("GRP_Drugs",GRPDrugsServer)
Proxy.addInterface("GRP_Drugs",GRPDrugsServer)
GRPDrugsClient = Tunnel.getInterface("GRP_Drugs","GRP_Drugs")

function GRPDrugsServer.IsPlayerNearCoords(source, coords, radius)
  local distance = #(GetEntityCoords(GetPlayerPed(source)) - coords)
  if distance < (radius + 0.00001) then
    return true
  end
  return false
end
