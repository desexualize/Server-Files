local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_fuel")

RegisterServerEvent('update:bank')
AddEventHandler('update:bank', function()
    local user_id = vRP.getUserId({source})
    local bank = vRP.getBankMoney({user_id})
    TriggerClientEvent('bank:setDisplayBankMoney', source, bank)
end)

RegisterServerEvent('update:cash')
AddEventHandler('update:cash', function()
    local user_id = vRP.getUserId({source})
    local wallet = vRP.getMoney({user_id})
    TriggerClientEvent('cash:setDisplayMoney', source, wallet)
end)