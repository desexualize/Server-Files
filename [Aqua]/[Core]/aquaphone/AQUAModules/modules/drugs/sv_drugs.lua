-- AQUA TUNNEL/PROXY
Tunnel = module("AQUA", "lib/Tunnel")
Proxy = module("AQUA", "lib/Proxy")
AQUA = Proxy.getInterface("AQUA")
AQUAclient = Tunnel.getInterface("AQUA","AQUA_cfgdrugs")

-- RESOURCE TUNNEL/PROXY
AQUAcfgdrugsServer = {}
Tunnel.bindInterface("AQUA_cfgdrugs",AQUAcfgdrugsServer)
Proxy.addInterface("AQUA_cfgdrugs",AQUAcfgdrugsServer)
AQUAcfgdrugsClient = Tunnel.getInterface("AQUA_cfgdrugs","AQUA_cfgdrugs")

function AQUAcfgdrugsServer.IsPlayerNearCoords(source, coords, radius)
  local distance = #(GetEntityCoords(GetPlayerPed(source)) - coords)
  if distance < (radius + 0.00001) then
    return true
  end
  return false
end
