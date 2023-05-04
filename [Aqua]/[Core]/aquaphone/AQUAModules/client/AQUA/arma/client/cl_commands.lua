Citizen.CreateThread(function()
    AddTextEntry('FE_THDR_GTAO','ARMA British RP - discord.gg/armarp')
    AddTextEntry("PM_PANE_CFX","ARMA")
end)
RegisterCommand("discord",function()
    TriggerEvent("chatMessage","^1[ARMA]^1  ",{ 128, 128, 128 },"^0Discord: discord.gg/armarp","ooc")
    tARMA.notify("~g~discord Copied to Clipboard.")
    tARMA.CopyToClipBoard("https://discord.gg/ARMA")
end)
RegisterCommand("ts",function()
    TriggerEvent("chatMessage","^1[ARMA]^1  ",{ 128, 128, 128 },"^0TS: ts.armaforums.net","ooc")
    tARMA.notify("~g~ts Copied to Clipboard.")
    tARMA.CopyToClipBoard("ts.armaforums.net")
end)
RegisterCommand("website",function()
    TriggerEvent("chatMessage","^1[ARMA]^1  ",{ 128, 128, 128 },"^0Forums: www.armaforums.net","ooc")
    tARMA.notify("~g~Website Copied to Clipboard.")
    tARMA.CopyToClipBoard("www.armaforums.net")
end)

RegisterCommand('getid', function(source, args)
    if args and args[1] then 
        if tARMA.clientGetUserIdFromSource(tonumber(args[1])) ~= nil then
            if tARMA.clientGetUserIdFromSource(tonumber(args[1])) ~= tARMA.getUserId() then
                TriggerEvent("chatMessage","^1[ARMA]^1  ",{ 128, 128, 128 }, "This Users Perm ID is: " .. tARMA.clientGetUserIdFromSource(tonumber(args[1])), "alert")
            else
                TriggerEvent("chatMessage","^1[ARMA]^1  ",{ 128, 128, 128 }, "This Users Perm ID is: " .. tARMA.getUserId(), "alert")
            end
        else
            TriggerEvent("chatMessage","^1[ARMA]^1  ",{ 128, 128, 128 }, "Invalid Temp ID", "alert")
        end
    else 
        TriggerEvent("chatMessage","^1[ARMA]^1  ",{ 128, 128, 128 }, "Please specify a user eg: /getid [tempid]", "alert")
    end
end)
