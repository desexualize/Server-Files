local Tunnel = module("AQUA", "lib/Tunnel")
local Proxy = module("AQUA", "lib/Proxy")
AQUA = Proxy.getInterface("AQUA")
AQUAclient = Tunnel.getInterface("AQUA", "AQUARP_RadialMenu")

RegisterServerEvent("AQUARP:PoliceCheckRadial")
AddEventHandler("AQUARP:PoliceCheckRadial", function()
    local source = source
    local user_id = AQUA.getUserId({source})
    if AQUA.hasPermission({user_id, "police.armoury"}) then
        MetPD = true
    else
        MetPD = false
    end
    TriggerClientEvent("AQUARP:PoliceClockedOn", source, MetPD)
end)

RegisterServerEvent("serverBoot")
AddEventHandler("serverBoot", function()
    TriggerClientEvent('openBoot', source)
end)
