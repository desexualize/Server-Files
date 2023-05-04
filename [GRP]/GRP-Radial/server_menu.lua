local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "GRP_RadialMenu")

--RegisterServerEvent("GRP:PoliceCheck")
--AddEventHandler("GRP:PoliceCheck", function()
--    local source = source
--    local user_id = vRP.getUserId({source})
--    if vRP.hasPermission({user_id, "cop.keycard"}) then
--        MetPD = true
--    else
--        MetPD = false
--    end
--    TriggerClientEvent("GRP:PoliceClockedOn", source, MetPD)
--end)

RegisterServerEvent("serverBoot")
AddEventHandler("serverBoot", function()
    TriggerClientEvent('openBoot', source)
end)
