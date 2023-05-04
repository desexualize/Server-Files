function starter(_, arg)
    print("^3User Has Bought Package! ^7")
	user_id = tonumber(arg[1])
    usource = vRP.getUserSource(user_id)

    vRPclient.notify(usource, {"~g~You have purchased the Starter Package! ❤️"})
    vRP.giveBankMoney(user_id, 50)

    MySQL.query("vRP/get_vehicle", {user_id = user_id, vehicle ="sanchez"}, function(pvehicle, affected)
	

			
        vRP.getUserIdentity(user_id, function(identity)					
            MySQL.execute("vRP/add_vehicle", {user_id = user_id, vehicle = "sanchez", registration = "P "..identity.registration})
           
        end)   

    end)

    
end

function starter(_, arg)
    print("^3User Has Bought Package! ^7")
	user_id = tonumber(arg[1])
    usource = vRP.getUserSource(user_id)

    vRPclient.notify(usource, {"~g~You have purchased the Starter Rank! ❤️"})
    vRP.giveBankMoney(user_id, 1000000)
    vRP.addUserGroup(user_id,"VIP")


    
end

function recruit(_, arg)
    print("^3User Has Bought Package! ^7")
	user_id = tonumber(arg[1])
    usource = vRP.getUserSource(user_id)

    vRPclient.notify(usource, {"~g~You have purchased the Recruit Rank! ❤️"})
    vRP.giveBankMoney(user_id, 5000000)
    vRP.addUserGroup(user_id,"VIP")


    
end

function soldier(_, arg)
    print("^3User Has Bought Package! ^7")
	user_id = tonumber(arg[1])
    usource = vRP.getUserSource(user_id)

    vRPclient.notify(usource, {"~g~You have purchased the Soldier Rank! ❤️"})
    vRP.giveBankMoney(user_id, 10000000)
    vRP.addUserGroup(user_id,"VIP")


    
end

function warrior(_, arg)
    print("^3User Has Bought Package! ^7")
	user_id = tonumber(arg[1])
    usource = vRP.getUserSource(user_id)

    vRPclient.notify(usource, {"~g~You have purchased the Warrior Rank! ❤️"})
    vRP.giveBankMoney(user_id, 20000000)
    vRP.addUserGroup(user_id,"VIP")


    
end

function champion(_, arg)
    print("^3User Has Bought Package! ^7")
	user_id = tonumber(arg[1])
    usource = vRP.getUserSource(user_id)

    vRPclient.notify(usource, {"~g~You have purchased the Champion Rank! ❤️"})
    vRP.giveBankMoney(user_id, 50000000)
    vRP.addUserGroup(user_id,"VIP")


    
end

function moneybag(_, arg)
    print("^3User Has Bought Money Bag! ^7")
    user_id = tonumber(arg[1])
    usource = vRP.getUserSource(user_id)

    vRPclient.notify(usource, {"~g~You have purchased a £" .. tostring(arg[2]) .. " Money Bag! ❤️"})
    vRP.giveBankMoney(user_id, tonumber(arg[2]))
end

function amazon(_, arg)
    local user_id = tonumber(arg[1])
    player = vRP.getUserSource(user_id)
    vRP.addUserGroup(user_id,'Grind')
    MySQL.query("vRP/get_vehicle", {user_id = user_id, vehicle = '300kg'}, function(pvehicle, affected)
  


            vRP.getUserIdentity(user_id, function(identity)
                MySQL.execute("vRP/add_vehicle", {user_id = user_id, vehicle = '300kg', registration = "P "..identity.registration})
 
    
            end)

                vRPclient.notify(player,{"~g~The 200KG Amazon Van is in your garage."})
                
     
    end)
end

RegisterNetEvent('addSanchez')
AddEventHandler('addSanchez', function()
    local source = source
    local user_id = vRP.getUserId(source)
    
    MySQL.query("vRP/get_vehicle", {user_id = user_id, vehicle = 'Sanchez'}, function(pvehicle, affected)
  
            vRP.getUserIdentity(user_id, function(identity)
                MySQL.execute("vRP/add_vehicle", {user_id = user_id, vehicle = 'Sanchez', registration = "P "..identity.registration})
    
            end)            
     
    end)
end)


RegisterCommand("starter", starter, true)
RegisterCommand("recruit", recruit, true)
RegisterCommand("soldier", soldier, true)
RegisterCommand("warrior", warrior, true)
RegisterCommand("champion", champion, true)
RegisterCommand("givetokens", moneybag, true)
RegisterCommand("amazon", amazon, true)
