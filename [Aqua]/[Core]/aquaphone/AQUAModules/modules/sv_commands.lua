local Tunnel = module("AQUA", "lib/Tunnel")
local Proxy = module("AQUA", "lib/Proxy")
AQUA = Proxy.getInterface("AQUA")
local users = {}
RegisterNetEvent("PlayerJoined")
AddEventHandler(
    "PlayerJoined",
    function()
        local tempid = source
        local user_id = AQUA.getUserId({source})
        if users[tempid] then
        else
            users[tempid] = user_id
        end
    end
)

RegisterCommand("getmyid", function(source)
    TriggerClientEvent('chatMessage', source, "^7[^0AQUA^7]", {255, 255, 255}, " Perm ID: " .. AQUA.getUserId({source}) , "alert")
end)

RegisterCommand("getmytempid", function(source)
	TriggerClientEvent('chatMessage', source, "^7[^0AQUA^7]", {255, 255, 255}, " Your Temp ID: " .. source, "alert")
end)

RegisterCommand('getid', function(source, args)
    if args and args[1] then 
        local userid = AQUA.getUserId({args[1]})
        if userid then 
            TriggerClientEvent('chatMessage', source, '^7[^0AQUA^7]', {255, 0, 0}, "This Users Perm ID is: " .. userid, "alert")
        else 
            TriggerClientEvent('chatMessage', source, '^7[^0AQUA^7]', {255, 0, 0}, "Temp ID cannot be found! This user is most likely offline.", "alert")
        end
    else 
        TriggerClientEvent('chatMessage', source, '^7[^0AQUA ^7]', {255, 0, 0}, "Please specify a user eg: /getid [tempid]", "alert")
    end
end)





