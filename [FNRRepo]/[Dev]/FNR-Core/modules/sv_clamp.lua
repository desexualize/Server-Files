-- vRP TUNNEL/PROXY
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","FNR_Clamp")

-- RESOURCE TUNNEL/PROXY
FNRClampServer = {}
Tunnel.bindInterface("FNR_Clamp",FNRClampServer)
Proxy.addInterface("FNR_Clamp",FNRClampServer)
FNRClampClient = Tunnel.getInterface("FNR_Clamp","FNR_Clamp")


RegisterCommand("clamp", function(source, args, rawCommand)
  local user_id = vRP.getUserId({source})
  if vRP.hasPermission({user_id,"police.menu"}) then
    FNRClampClient.ClampVehicle(source)
  else
    vRPclient.notify(source,{"~r~You are not on duty."})
  end
end, false)

function FNRClampServer.ChangeVehState(veh, disable)
  print(veh, disable)
  FNRClampClient.ChangeVehState(-1, {veh, disable})
end


RegisterServerEvent("FNR:ClampVehicle")
AddEventHandler("FNR:ClampVehicle", function()
  local user_id = vRP.getUserId({source})
  if vRP.hasPermission({user_id,"police.menu"}) then
    FNRClampClient.ClampVehicle(source)
  else
    vRPclient.notify(source,{"~r~You are not on duty."})
  end
end, false)