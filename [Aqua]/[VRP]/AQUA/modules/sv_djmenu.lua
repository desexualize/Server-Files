local c = {}
RegisterCommand("djmenu", function(source, args, rawCommand)
    local source = source
    local userid = AQUA.getUserId(source)
    if AQUA.hasGroup(userid,"DJ") then
        TriggerClientEvent('AQUA:toggleDjMenu', source)
    end
end)
RegisterCommand("djadmin", function(source, args, rawCommand)
    local source = source
    local userid = AQUA.getUserId(source)
    if AQUA.hasPermission(userid,"admin.menu") then
        TriggerClientEvent('AQUA:toggleDjAdminMenu', source,c)
    end
end)
RegisterCommand("play",function(source,args,rawCommand)
    local source = source
    local user_id = AQUA.getUserId(source)
    local ped = GetPlayerPed(source)
    local coords = GetEntityCoords(ped)
    local name = GetPlayerName(source)
    if AQUA.hasGroup(user_id,"DJ") then
        if #args > 0 then
            TriggerClientEvent('AQUA:finaliseSong', source,args[1])
        end
    end
end)
RegisterServerEvent("AQUA:adminStopSong")
AddEventHandler("AQUA:adminStopSong", function(PARAM)
    local source = source
    for k,v in pairs(c) do
        if v[1] == PARAM then
            TriggerClientEvent('AQUA:stopSong', -1,v[2])
            c[tostring(k)] = nil
            TriggerClientEvent('AQUA:toggleDjAdminMenu', source,c)
        end
    end
end)
RegisterServerEvent("AQUA:playDjSongServer")
AddEventHandler("AQUA:playDjSongServer", function(PARAM,coords)
    local source = source
    local user_id = AQUA.getUserId(source)
    local name = GetPlayerName(source)
    c[tostring(source)] = {PARAM,coords,user_id,name,"true"}
    TriggerClientEvent('AQUA:playDjSong', -1,PARAM,coords,user_id,name)
end)
RegisterServerEvent("AQUA:skipServer")
AddEventHandler("AQUA:skipServer", function(coords,param)
    local source = source
    TriggerClientEvent('AQUA:skipDj', -1,coords,param)
end)
RegisterServerEvent("AQUA:stopSongServer")
AddEventHandler("AQUA:stopSongServer", function(coords)
    local source = source
    TriggerClientEvent('AQUA:stopSong', -1,coords)
end)
RegisterServerEvent("AQUA:updateVolumeServer")
AddEventHandler("AQUA:updateVolumeServer", function(coords,volume)
    local source = source
    TriggerClientEvent('AQUA:updateDjVolume', -1,coords,volume)
end)
