-- vRP TUNNEL/PROXY
Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","GBRP_cfgdrugs")

-- RESOURCE TUNNEL/PROXY
GBRPcfgdrugsServer = {}
Tunnel.bindInterface("GBRP_cfgdrugs",GBRPcfgdrugsServer)
Proxy.addInterface("GBRP_cfgdrugs",GBRPcfgdrugsServer)
GBRPcfgdrugsClient = Tunnel.getInterface("GBRP_cfgdrugs","GBRP_cfgdrugs")

function GBRPcfgdrugsServer.IsPlayerNearCoords(source, coords, radius)
  local distance = #(GetEntityCoords(GetPlayerPed(source)) - coords)
  if distance < (radius + 0.00001) then
    return true
  end
  return false
end
