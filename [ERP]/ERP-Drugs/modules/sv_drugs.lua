-- vRP TUNNEL/PROXY
Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","ERP_Drugs")

-- RESOURCE TUNNEL/PROXY
ElementDrugsSV = {}
Tunnel.bindInterface("ERP_Drugs",ElementDrugsSV)
Proxy.addInterface("ERP_Drugs",ElementDrugsSV)
ERPDrugsClient = Tunnel.getInterface("ERP_Drugs","ERP_Drugs")

function ElementDrugsSV.IsPlayerNearCoords(source, coords, radius)
  local distance = #(GetEntityCoords(GetPlayerPed(source)) - coords)
  if distance < (radius + 0.00001) then
    return true
  end
  return false
end
