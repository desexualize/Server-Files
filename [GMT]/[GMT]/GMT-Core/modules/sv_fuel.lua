local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP")

RegisterServerEvent('Jud:pay')
AddEventHandler('Jud:pay', function(price)
	local user_id = vRP.getUserId({source})
	local fuelAmount = math.floor(price)

    if user_id ~= nil then
        if vRP.tryFullPayment({user_id, fuelAmount})then
            vRPclient.notify(source,{"~g~Paid £"..fuelAmount})
        else
            vRPclient.notify(source,{"~r~Its fine... Tax payers will pay your fuel instead."})
        end
    end
end)