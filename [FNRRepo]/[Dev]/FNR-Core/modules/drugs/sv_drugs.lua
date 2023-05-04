-- vRP TUNNEL/PROXY
Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","FNR_cfgdrugs")

-- RESOURCE TUNNEL/PROXY
FNRcfgdrugsServer = {}
Tunnel.bindInterface("FNR_cfgdrugs",FNRcfgdrugsServer)
Proxy.addInterface("FNR_cfgdrugs",FNRcfgdrugsServer)
FNRcfgdrugsClient = Tunnel.getInterface("FNR_cfgdrugs","FNR_cfgdrugs")

function FNRcfgdrugsServer.IsPlayerNearCoords(source, coords, radius)
  local distance = #(GetEntityCoords(GetPlayerPed(source)) - coords)
  if distance < (radius + 0.00001) then
    return true
  end
  return false
end
