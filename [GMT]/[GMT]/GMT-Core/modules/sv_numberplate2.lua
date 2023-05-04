local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_Numberplate")
MySQL = module("vrp_mysql", "MySQL")

local forbiddenNames = {
	"%^1",
	"%^2",
	"%^3",
	"%^4",
	"%^5",
	"%^6",
	"%^7",
	"%^8",
	"%^9",
	"%^%*",
	"%^_",
	"%^=",
	"%^%~",
	"admin",
	"nigger",
	"cunt",
	"faggot",
	"fuck",
	"fucker",
	"fucking",
	"anal",
	"stupid",
	"damn",
	"cock",
	"cum",
	"dick",
	"dipshit",
	"dildo",
	"douchbag",
	"douch",
	"kys",
	"jerk",
	"jerkoff",
	"gay",
	"homosexual",
	"lesbian",
	"suicide",
	"mothafucka",
	"negro",
	"pussy",
	"queef",
	"queer",
	"weeb",
	"retard",
	"masterbate",
	"suck",
	"tard",
	"allahu akbar",
	"terrorist",
	"twat",
	"vagina",
	"wank",
	"whore",
	"wanker",
	"n1gger",
	"f4ggot",
	"n0nce",
	"d1ck",
	"h0m0",
	"n1gg3r",
	"h0m0s3xual",
	"free up mandem",
	"nazi",
	"hitler",
	"cheater",
	"cheating",
}

MySQL.createCommand("vRP/update_numplate","UPDATE vrp_user_identities SET registration = @registration WHERE user_id = @user_id")
MySQL.createCommand("vRP/update_numplate2","UPDATE vrp_user_vehicles SET vehicle_plate = @registration WHERE user_id = @user_id AND vehicle = @vehicle")

RegisterNetEvent('GMT:getCars')
AddEventHandler('GMT:getCars', function()
    local cars = {}
    local source = source
    local user_id = vRP.getUserId({source})
    exports['ghmattimysql']:execute("SELECT * FROM `vrp_user_vehicles` WHERE user_id = @user_id", {user_id = user_id}, function(result)
        if result ~= nil then 
            for k,v in pairs(result) do
                if v.user_id == user_id then
                    cars[v.vehicle] = {v.vehicle, v.vehicle_plate}
                end
            end
            TriggerClientEvent('GMT:carsTable', source, cars)
        end
    end)
end)

RegisterNetEvent("GMT:ChangeNumberPlate")
AddEventHandler("GMT:ChangeNumberPlate", function(vehicle)
    local user_id = vRP.getUserId({source})

	vRP.prompt({source,"Plate Name:","",function(source, plateName)
		if plateName == '' then return end
		for name in pairs(forbiddenNames) do
			if plateName == forbiddenNames[name] then
				vRPclient.notify(source,{"~r~You cannot have this plate."})
				return
			end
		end
		if vRP.tryFullPayment({user_id,50000}) then
			vRPclient.notify(source,{"~g~Changed Number plate of "..vehicle.." to "..plateName})
			MySQL.execute("vRP/update_numplate2", {user_id = user_id, registration = plateName, vehicle = vehicle})
			MySQL.execute("vRP/update_numplate2", {user_id = user_id, registration = plateName})
			TriggerClientEvent("GMT:RecieveNumberPlate", source, plateName)
			TriggerClientEvent("GMT:PlaySound", source, 1)
			TriggerEvent('GMT:getCars')
		else
			vRPclient.notify(source,{"~r~You don't have enough money!"})
			TriggerClientEvent("GMT:PlaySound", source, 2)
		end
	end})
end)
