function supporter(_, arg)
    print("^3User Has Bought Package! ^7")
	user_id = tonumber(arg[1])
    usource = vRP.getUserSource(user_id)

    print(GetPlayerName(usource)..'['..user_id..'] has bought Supporter')

    vRPclient.notify(usource, {"~g~You have purchased the Supporter Rank! 🌟"})
    vRP.giveBankMoney(user_id, 500000)
    vRP.addUserGroup(user_id,"VIP")


    
end

function premium(_, arg)
	user_id = tonumber(arg[1])
    usource = vRP.getUserSource(user_id)

    print(GetPlayerName(usource)..'['..user_id..'] has bought Premium')

    vRPclient.notify(usource, {"~g~You have purchased the Premium Rank! 🌟"})
    vRP.giveBankMoney(user_id, 1500000)
    vRP.addUserGroup(user_id,"VIP")


    
end

function elite(_, arg)
	user_id = tonumber(arg[1])
    usource = vRP.getUserSource(user_id)

    print(GetPlayerName(usource)..'['..user_id..'] has bought Elite')

    vRPclient.notify(usource, {"~g~You have purchased the Elite Rank! 🌟"})
    vRP.giveBankMoney(user_id, 2500000)
    vRP.addUserGroup(user_id,"VIP")


    
end

function king(_, arg)
	user_id = tonumber(arg[1])
    usource = vRP.getUserSource(user_id)

    print(GetPlayerName(usource)..'['..user_id..'] has bought King')

    vRPclient.notify(usource, {"~g~You have purchased the King Rank! 🌟"})
    vRP.giveBankMoney(user_id, 5000000)
    vRP.addUserGroup(user_id,"VIP")


    
end

function hawk(_, arg)
	user_id = tonumber(arg[1])
    usource = vRP.getUserSource(user_id)

    print(GetPlayerName(usource)..'['..user_id..'] has bought Hawk')

    vRPclient.notify(usource, {"~g~You have purchased the Hawk Rank! 🌟"})
    vRP.giveBankMoney(user_id, 10000000 )
    vRP.addUserGroup(user_id,"VIP")


    
end



function champion(_, arg)
	user_id = tonumber(arg[1])
    usource = vRP.getUserSource(user_id)
    vRPclient.notify(usource, {"~g~You have purchased the Champion Rank! 🌟"})
    vRP.giveBankMoney(user_id, 25000000)
    vRP.addUserGroup(user_id,"VIP")


    
end

function tokens(_, arg)
    user_id = tonumber(arg[1])
    usource = vRP.getUserSource(user_id)

    print(GetPlayerName(usource)..'['..user_id..'] has bought a '..tostring(arg[2])..' Money Bag')

    vRPclient.notify(usource, {"~g~You have purchased " .. tostring(arg[2]) .. " Money! 🌟"})
    vRP.giveBankMoney(user_id, tonumber(arg[2]))
end


RegisterCommand("supporter", supporter, true)
RegisterCommand("premium", premium, true)
RegisterCommand("elite", elite, true)
RegisterCommand("king", king, true)
RegisterCommand("hawk", hawk, true)
RegisterCommand("champion", champion, true)
RegisterCommand("givemoney", tokens, true)

-- RegisterCommand('commandName', function(source, args, RawCommand)
    
--end)