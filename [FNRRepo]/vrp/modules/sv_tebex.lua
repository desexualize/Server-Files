function recruit(_, arg)
    print("^3User Has Bought Package! ^7")
	user_id = tonumber(arg[1])
    usource = vRP.getUserSource(user_id)

    print(GetPlayerName(usource)..'['..user_id..'] has bought Recruit')

    vRPclient.notify(usource, {"~g~You have purchased the Recruit Rank! ❤️"})
    vRP.giveBankMoney(user_id, 200)
    vRP.addUserGroup(user_id,"VIP")


    
end

function soldier(_, arg)
	user_id = tonumber(arg[1])
    usource = vRP.getUserSource(user_id)

    print(GetPlayerName(usource)..'['..user_id..'] has bought Soldier')

    vRPclient.notify(usource, {"~g~You have purchased the Soldier Rank! ❤️"})
    vRP.giveBankMoney(user_id, 400)
    vRP.addUserGroup(user_id,"VIP")


    
end

function warrior(_, arg)
	user_id = tonumber(arg[1])
    usource = vRP.getUserSource(user_id)

    print(GetPlayerName(usource)..'['..user_id..'] has bought Warrior')

    vRPclient.notify(usource, {"~g~You have purchased the Warrior Rank! ❤️"})
    vRP.giveBankMoney(user_id, 400)
    vRP.addUserGroup(user_id,"VIP")


    
end

function diamond(_, arg)
	user_id = tonumber(arg[1])
    usource = vRP.getUserSource(user_id)

    print(GetPlayerName(usource)..'['..user_id..'] has bought Diamond')

    vRPclient.notify(usource, {"~g~You have purchased the Diamond Rank! ❤️"})
    vRP.giveBankMoney(user_id, 2000)
    vRP.addUserGroup(user_id,"VIP")


    
end

function tokens(_, arg)
    user_id = tonumber(arg[1])
    usource = vRP.getUserSource(user_id)

    print(GetPlayerName(usource)..'['..user_id..'] has bought a '..tostring(arg[2])..' Money Bag')

    vRPclient.notify(usource, {"~g~You have purchased " .. tostring(arg[2]) .. " Money! ❤️"})
    vRP.giveBankMoney(user_id, tonumber(arg[2]))
end


-- RegisterCommand("recruit", recruit, true)
-- RegisterCommand("soldier", soldier, true)
-- RegisterCommand("warrior", warrior, true)
-- RegisterCommand("diamond", champion, true)
-- RegisterCommand("givemoney", tokens, true)

-- RegisterCommand('commandName', function(source, args, RawCommand)
    
-- end)