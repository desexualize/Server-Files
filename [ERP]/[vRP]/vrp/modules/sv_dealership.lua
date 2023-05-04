--- {spawn, title, desc, price}
MySQL.createCommand("vRP/add_vehicle","INSERT IGNORE INTO vrp_user_vehicles(user_id,vehicle,vehicle_plate) VALUES(@user_id,@vehicle,@registration,@type)")
MySQL.createCommand("vRP/get_vehicle","SELECT vehicle FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle")

local SimeonsCars = {
    {spawncode = "r820", vehname = "Starter Car", vehdesc = "", price = 1},
    {spawncode = "m977hl", vehname = "M977", vehdesc = "", price = 500000},
    {spawncode = "a45", vehname = "Mercedes-Benz A45", vehdesc = "", price = 30000},
    {spawncode = "ast", vehname = "Aston Martan", vehdesc = "Sport", price = 100000},
    {spawncode = "R6", vehname = "R6", vehdesc = "Motorcycles", price = 20000},
    {spawncode = "x6m", vehname = "BMW X6M", vehdesc = "SUV", price = 40000},
    {spawncode = "pm19", vehname = "Porsche Macan", vehdesc = "SUV", price = 25000},
    {spawncode = "F4090", vehname = "Ferrari F40", vehdesc = "Super", price = 120000},
    {spawncode = "rs6", vehname = "Audi RS6", vehdesc = "Sport", price = 75000},
    {spawncode = "rs5", vehname = "Audi RS5", vehdesc = "Sport", price = 90000},
    {spawncode = "pturismo", vehname = "Porsche Panamera", vehdesc = "Sport", price = 100000},
    {spawncode = "m3e46", vehname = "BMW M3", vehdesc = "", price = 60000},
    {spawncode = "bmwe65", vehname = "BMW E65", vehdesc = "", price = 40000},
    {spawncode = "boxster", vehname = "Porsche Boxster", vehdesc = "", price = 130000},
    {spawncode = "apex3", vehname = "VW APEX 3", vehdesc = "", price = 1},
    {spawncode = "audia4marked", vehname = "Audi A4 Marked", vehdesc = "", price = 1},
    {spawncode = "audia4unmarked", vehname = "Audi A4 Unmarked", vehdesc = "", price = 1},
    {spawncode = "polf150", vehname = "Offroad F150", vehdesc = "", price = 1},
    {spawncode = "pddirtbike", vehname = "PD Dirtbike", vehdesc = "", price = 1},
    {spawncode = "pbmw540i", vehname = "BMW 540i", vehdesc = "", price = 1},
    {spawncode = "pdbmwm5", vehname = "BMW M5", vehdesc = "", price = 1},
    {spawncode = "pdjagsuv", vehname = "Jaguar SUV", vehdesc = "", price = 1},
    {spawncode = "pdjagxfr", vehname = "Jaguar XFR", vehdesc = "", price = 1},
    {spawncode = "pdmarkedfocus", vehname = "Ford Focus", vehdesc = "", price = 1},
    {spawncode = "pdnissangtr", vehname = "Nissan GTR Unmarked", vehdesc = "", price = 1},
    {spawncode = "pdprior", vehname = "Audi Prior Unmarked", vehdesc = "", price = 1},
    {spawncode = "wf20", vehname = "Armed Van", vehdesc = "", price = 1}
}



RegisterServerEvent('ERP:DealerShipBuy')
AddEventHandler('ERP:DealerShipBuy', function(vehicle, price)
    local correctcar = false 
    local wrongprice = false 
    local player = source
    local user_id = vRP.getUserId(source)
    for i,v in pairs(SimeonsCars) do 
        if v.spawncode == vehicle then 
            correctcar = true 
            if v.price ~= price then 
            wrongprice = true
            end
        end
    end    
    if wrongprice == true then 
    print("Tried hacking showroom with price: " .. price .. " Item spawncode: " .. vehicle )
    
    end

    if correctcar == false then 
    print("Tried hacking showroom with price: " .. price .. " Item spawncode: " .. vehicle )
    end


    MySQL.query("vRP/get_vehicle", {user_id = user_id, vehicle = vehicle}, function(pvehicle, affected)
		if #pvehicle > 0 then
			vRPclient.notify(player,{"~r~Vehicle already owned."})
		else
            if vRP.tryFullPayment(user_id,price) then 
                --vRPclient.notify(source,{'~g~You have purchased: ' .. vehicle .. ' for: $' .. price})
                vRP.getUserIdentity(user_id, function(identity)					
                    MySQL.execute("vRP/add_vehicle", {user_id = user_id, vehicle = vehicle, registration = "P "..identity.registration, type = "simeon"})
                end)

				vRPclient.notify(player,{"You paid ~r~£"..price})
                vRPclient.notify(player,{"To pickup your vehicle please visit any garage."})
                
			else
                vRPclient.notify(player,{"~r~Not enough money."})
            end
		end
	end)
end)

RegisterServerEvent('ERP:VIPDealerShipBuy')
AddEventHandler('ERP:VIPDealerShipBuy', function(vehicle, price)
    local correctcar = false 
    local wrongprice = false 
    local player = source
    local user_id = vRP.getUserId(source)
    for i,v in pairs(SimeonsCars) do 
        if v.spawncode == vehicle then 
            correctcar = true 
            if v.price ~= price then 
            wrongprice = true
            end
        end
    end    
    if wrongprice == true then 
    print("Tried hacking showroom with price: " .. price .. " Item spawncode: " .. vehicle )
    
    end

    if correctcar == false then 
    print("Tried hacking showroom with price: " .. price .. " Item spawncode: " .. vehicle )
    end


    MySQL.query("vRP/get_vehicle", {user_id = user_id, vehicle = vehicle}, function(pvehicle, affected)
		if #pvehicle > 0 then
			vRPclient.notify(player,{"~r~Vehicle already owned."})
		else
            if vRP.tryFullPayment(user_id,price) then 
                vRP.getUserIdentity(user_id, function(identity)					
                    MySQL.execute("vRP/add_vehicle", {user_id = user_id, vehicle = vehicle, registration = "P "..identity.registration, type = "vip"})
                end)

				vRPclient.notify(player,{"You paid ~r~£"..price})
                vRPclient.notify(player,{"To pickup your vehicle please visit any garage."})
                
			else
                vRPclient.notify(player,{"~r~Not enough money."})
            end
		end
	end)
end)

RegisterServerEvent('ERP:PoliceDealerShipBuy')
AddEventHandler('ERP:PoliceDealerShipBuy', function(vehicle, price)
    local correctcar = false 
    local wrongprice = false 
    local player = source
    local user_id = vRP.getUserId(source)
    for i,v in pairs(SimeonsCars) do 
        if v.spawncode == vehicle then 
            correctcar = true 
            if v.price ~= price then 
            wrongprice = true
            end
        end
    end    
    if wrongprice == true then 
    print("Tried hacking showroom with price: " .. price .. " Item spawncode: " .. vehicle )
    
    end

    if correctcar == false then 
    print("Tried hacking showroom with price: " .. price .. " Item spawncode: " .. vehicle )
    end


    MySQL.query("vRP/get_vehicle", {user_id = user_id, vehicle = vehicle}, function(pvehicle, affected)
		if #pvehicle > 0 then
			vRPclient.notify(player,{"~r~Vehicle already owned."})
		else
            if vRP.tryFullPayment(user_id,price) then 
                vRP.getUserIdentity(user_id, function(identity)					
                    MySQL.execute("vRP/add_vehicle", {user_id = user_id, vehicle = vehicle, registration = "P "..identity.registration, type = "police"})
                end)

				vRPclient.notify(player,{"You paid ~r~£"..price})
                vRPclient.notify(player,{"To pickup your vehicle please visit any garage."})
                
			else
                vRPclient.notify(player,{"~r~Not enough money."})
            end
		end
	end)
end)