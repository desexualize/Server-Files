-- AQUA TUNNEL/PROXY
local Tunnel = module("AQUA", "lib/Tunnel")
local Proxy = module("AQUA", "lib/Proxy")
AQUA = Proxy.getInterface("AQUA")
AQUAclient = Tunnel.getInterface("AQUA","AQUA_Clamp")

-- RESOURCE TUNNEL/PROXY
AQUAClampServer = {}
Tunnel.bindInterface("AQUA_Clamp",AQUAClampServer)
Proxy.addInterface("AQUA_Clamp",AQUAClampServer)
AQUAClampClient = Tunnel.getInterface("AQUA_Clamp","AQUA_Clamp")


RegisterCommand("clamp", function(source, args, rawCommand)
  local user_id = AQUA.getUserId({source})
  if AQUA.hasPermission({user_id,"police.menu"}) then
    AQUAClampClient.ClampVehicle(source)
  else
    AQUAclient.notify(source,{"~d~You are not on duty."})
  end
end, false)

function AQUAClampServer.ChangeVehState(veh, disable)
  print(veh, disable)
  AQUAClampClient.ChangeVehState(-1, {veh, disable})
end


RegisterServerEvent("AQUA:ClampVehicle")
AddEventHandler("AQUA:ClampVehicle", function()
  local user_id = AQUA.getUserId({source})
  if AQUA.hasPermission({user_id,"police.menu"}) then
    AQUAClampClient.ClampVehicle(source)
  else
    AQUAclient.notify(source,{"~d~You are not on duty."})
  end
end, false)