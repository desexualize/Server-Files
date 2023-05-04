local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_fuel")

if cfgfuel.UseVRP then
	RegisterServerEvent('fuel:pay')
	AddEventHandler('fuel:pay', function(price)
		local user_id = vRP.getUserId({source})
		local fuelAmount = math.floor(price)
		if price >= 99999999999 then 
			print(user_id.. "is cheating")
		if vRP.tryFullPayment({user_id ,fuelAmount})then
			end
		end
	end)
end
