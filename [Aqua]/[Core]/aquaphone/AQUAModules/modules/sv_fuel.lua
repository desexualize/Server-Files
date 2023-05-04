local Tunnel = module("AQUA", "lib/Tunnel")
local Proxy = module("AQUA", "lib/Proxy")
AQUA = Proxy.getInterface("AQUA")
AQUAclient = Tunnel.getInterface("AQUA", "AQUA_fuel")

if cfgfuel.UseAQUA then
	RegisterServerEvent('fuel:pay')
	AddEventHandler('fuel:pay', function(price)
		local user_id = AQUA.getUserId({source})
		local fuelAmount = math.floor(price)
		if price >= 99999999999 then 
			print(user_id.. "is cheating")
		if AQUA.tryFullPayment({user_id ,fuelAmount})then
			end
		end
	end)
end
