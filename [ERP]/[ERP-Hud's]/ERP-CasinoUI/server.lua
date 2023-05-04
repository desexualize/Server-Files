local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_fuel")


RegisterServerEvent('update:chips')
AddEventHandler('update:chips', function()
    local user_id = vRP.getUserId({source})
    local wallet = vRP.getMoney({user_id})
    TriggerClientEvent('chips:setDisplayMoney', source, wallet)
end)