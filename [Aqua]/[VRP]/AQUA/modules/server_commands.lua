RegisterCommand('addgroup', function(source, args)
    if source ~= 0 then return end; -- Stops anyone other than the console running it.
    if tonumber(args[1]) and args[2] then
        local userid = tonumber(args[1])
        local group = args[2]
        AQUA.addUserGroup(userid,group)
        print('Added Group: ' .. group .. ' to UserID: ' .. userid)
    else 
        print('Incorrect usage: addgroup [permid] [group]')
    end
end)

RegisterCommand('removegroup', function(source, args)
    if source ~= 0 then return end; -- Stops anyone other than the console running it.
    if tonumber(args[1]) and args[2] then
        local userid = tonumber(args[1])
        local group = args[2]
        AQUA.removeUserGroup(userid,group)
        print('Removed Group: ' .. group .. ' from UserID: ' .. userid)
    else 
        print('Incorrect usage: removegroup [permid] [group]')
    end
end)

RegisterCommand('ban', function(source, args)
    if source ~= 0 then return end; -- Stops anyone other than the console running it.
    if tonumber(args[1]) and args[2] then
        local userid = tonumber(args[1])
        local reason = table.concat(args," ", 2)
        if reason then 
            AQUA.banConsole(userid,reason)
        else 
            print('Incorrect usage: ban [permid][reason]')
        end 
    else 
        print('Incorrect usage: ban [permid][reason]')
    end
end)

RegisterCommand('kick', function(source, args)
    if source ~= 0 then return end; -- Stops anyone other than the console running it.
    if tonumber(args[1]) and args[2] then
        local userid = tonumber(args[1])
        local reason = table.concat(args," ", 2)
        local kickedplayer = AQUA.getUserSource(tonumber(userid))
        if reason then 
            AQUA.kick(kickedplayer, reason) 
        else 
            print('Incorrect usage: kick [permid] [reason]')
        end 
    else 
        print('Incorrect usage: kick [permid] [reason]')
    end
end)



RegisterCommand('unban', function(source, args)
    if source ~= 0 then return end; -- Stops anyone other than the console running it.
    if tonumber(args[1])  then
        local userid = tonumber(args[1])
        AQUA.setBanned(userid,false)
        print('Unbanned user: ' .. userid )
    else 
        print('Incorrect usage: unban [permid]')
    end
end)

