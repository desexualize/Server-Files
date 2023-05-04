local c = {}
RegisterCommand("djmenu", function(source, args, rawCommand)
    local source = source
    local userid = vRP.getUserId(source)
    if vRP.hasGroup(userid,"DJ") then
        TriggerClientEvent('FNR:toggleDjMenu', source)
    end
end)
RegisterCommand("djadmin", function(source, args, rawCommand)
    local source = source
    local userid = vRP.getUserId(source)
    if vRP.hasPermission(userid,"admin.menu") then
        TriggerClientEvent('FNR:toggleDjAdminMenu', source,c)
    end
end)
RegisterCommand("play",function(source,args,rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    local ped = GetPlayerPed(source)
    local coords = GetEntityCoords(ped)
    local name = GetPlayerName(source)
    if vRP.hasGroup(user_id,"DJ") then
        if #args > 0 then
            TriggerClientEvent('FNR:finaliseSong', source,args[1])
        end
    end
end)
RegisterServerEvent("FNR:adminStopSong")
AddEventHandler("FNR:adminStopSong", function(PARAM)
    local source = source
    for k,v in pairs(c) do
        if v[1] == PARAM then
            TriggerClientEvent('FNR:stopSong', -1,v[2])
            c[tostring(k)] = nil
            TriggerClientEvent('FNR:toggleDjAdminMenu', source,c)
        end
    end
end)
RegisterServerEvent("FNR:playDjSongServer")
AddEventHandler("FNR:playDjSongServer", function(PARAM,coords)
    local source = source
    local user_id = vRP.getUserId(source)
    local name = GetPlayerName(source)
    c[tostring(source)] = {PARAM,coords,user_id,name,"true"}
    TriggerClientEvent('FNR:playDjSong', -1,PARAM,coords,user_id,name)
end)
RegisterServerEvent("FNR:skipServer")
AddEventHandler("FNR:skipServer", function(coords,param)
    local source = source
    TriggerClientEvent('FNR:skipDj', -1,coords,param)
end)
RegisterServerEvent("FNR:stopSongServer")
AddEventHandler("FNR:stopSongServer", function(coords)
    local source = source
    TriggerClientEvent('FNR:stopSong', -1,coords)
end)
RegisterServerEvent("FNR:updateVolumeServer")
AddEventHandler("FNR:updateVolumeServer", function(coords,volume)
    local source = source
    TriggerClientEvent('FNR:updateDjVolume', -1,coords,volume)
end)