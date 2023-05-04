-- vRP TUNNEL/PROXY
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","GMT_Clamp")

-- RESOURCE TUNNEL/PROXY
GMTClampServer = {}
Tunnel.bindInterface("GMT_Clamp",GMTClampServer)
Proxy.addInterface("GMT_Clamp",GMTClampServer)
GMTClampClient = Tunnel.getInterface("GMT_Clamp","GMT_Clamp")


RegisterCommand("clamp", function(source, args, rawCommand)
  local user_id = vRP.getUserId({source})
  if vRP.hasPermission({user_id,"police.menu"}) then
    GMTClampClient.ClampVehicle(source)
  else
    vRPclient.notify(source,{"~r~You are not on duty."})
  end
end, false)

function GMTClampServer.ChangeVehState(veh, disable)
  print(veh, disable)
  GMTClampClient.ChangeVehState(-1, {veh, disable})
end


RegisterServerEvent("GMT:ClampVehicle")
AddEventHandler("GMT:ClampVehicle", function()
  local user_id = vRP.getUserId({source})
  if vRP.hasPermission({user_id,"police.menu"}) then
    GMTClampClient.ClampVehicle(source)
  else
    vRPclient.notify(source,{"~r~You are not on duty."})
  end
end, false)