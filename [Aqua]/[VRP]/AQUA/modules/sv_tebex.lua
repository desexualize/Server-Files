--[[function elite(_, arg)
    print("^3User Has Bought Package! ^7")
	user_id = tonumber(arg[1])
    usource = AQUA.getUserSource(user_id)

    print(GetPlayerName(usource)..'['..user_id..'] has bought elite')

    AQUAclient.notify(usource, {"~g~You have purchased the elite Rank! ❤️"})
    AQUA.giveBankMoney(user_id, 200)
    AQUA.addUserGroup(user_id,"VIP")


    
end

function soldier(_, arg)
	user_id = tonumber(arg[1])
    usource = AQUA.getUserSource(user_id)

    print(GetPlayerName(usource)..'['..user_id..'] has bought Soldier')

    AQUAclient.notify(usource, {"~g~You have purchased the Soldier Rank! ❤️"})
    AQUA.giveBankMoney(user_id, 400)
    AQUA.addUserGroup(user_id,"VIP")


    
end

function warrior(_, arg)
	user_id = tonumber(arg[1])
    usource = AQUA.getUserSource(user_id)

    print(GetPlayerName(usource)..'['..user_id..'] has bought Warrior')

    AQUAclient.notify(usource, {"~g~You have purchased the Warrior Rank! ❤️"})
    AQUA.giveBankMoney(user_id, 400)
    AQUA.addUserGroup(user_id,"VIP")


    
end

function diamond(_, arg)
	user_id = tonumber(arg[1])
    usource = AQUA.getUserSource(user_id)

    print(GetPlayerName(usource)..'['..user_id..'] has bought Diamond')

    AQUAclient.notify(usource, {"~g~You have purchased the Diamond Rank! ❤️"})
    AQUA.giveBankMoney(user_id, 2000)
    AQUA.addUserGroup(user_id,"VIP")


    
end

function tokens(_, arg)
    user_id = tonumber(arg[1])
    usource = AQUA.getUserSource(user_id)

    print(GetPlayerName(usource)..'['..user_id..'] has bought a '..tostring(arg[2])..' Money Bag')

    AQUAclient.notify(usource, {"~g~You have purchased " .. tostring(arg[2]) .. " Money! ❤️"})
    AQUA.giveBankMoney(user_id, tonumber(arg[2]))
end


 RegisterCommand("elite", elite, true)
 RegisterCommand("soldier", soldier, true)
 RegisterCommand("warrior", warrior, true)
 RegisterCommand("diamond", champion, true)
 RegisterCommand("givemoney", tokens, true)
]] 