function tokens(_, arg)
    print("^3User Has Bought Money Bag! ^7")
    user_id = tonumber(arg[1])
    usource = vRP.getUserSource({user_id})

    vRPclient.notify(usource, {"~g~You have purchased " .. tostring(arg[2]) .. " Tokens! ❤️"})
    vRP.giveBankMoney({user_id, tonumber(arg[2])})
end
