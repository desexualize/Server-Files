local Tunnel = module("AQUA", "lib/Tunnel")
local Proxy = module("AQUA", "lib/Proxy")

AQUA = Proxy.getInterface("AQUA")
AQUAclient = Tunnel.getInterface("AQUA","AQUA_fuel")

RegisterServerEvent('update:bank')
AddEventHandler('update:bank', function()
    local user_id = AQUA.getUserId({source})
    local bank = AQUA.getBankMoney({user_id})
    TriggerClientEvent('bank:setDisplayBankMoney', source, bank)
end)

RegisterServerEvent('update:cash')
AddEventHandler('update:cash', function()
    local user_id = AQUA.getUserId({source})
    local wallet = AQUA.getMoney({user_id})
    TriggerClientEvent('cash:setDisplayMoney', source, wallet)
end)