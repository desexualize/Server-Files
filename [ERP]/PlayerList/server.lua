Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP")

local playerlist = {}
local playersId = 0
local staffOnline = 0
local pdOnline = 0
local nhsOnline = 0
local job = ''

RegisterServerEvent("playerlist:playerJoined")
AddEventHandler("playerlist:playerJoined",function()
    local source = source
    if vRP.getUserId({source}) ~= nil then
        name = GetPlayerName(source)
        user_id = vRP.getUserId({source})
        data = vRP.getUserDataTable({user_id})
        playtime = data.PlayerTime or 0
        PlayerTimeInHours = playtime/60
        if PlayerTimeInHours < 1 then
            PlayerTimeInHours = 0
        end
        playersId = playersId + 1
        job = 'Unemployed'
        if vRP.hasPermission({user_id, 'admin.tickets'}) then
            staffOnline = staffOnline+1
            job = 'Staff'
        end
        if vRP.hasPermission({user_id, 'police.armoury'}) then
            pdOnline = pdOnline+1
            job = 'Police'
        end
        if vRP.hasPermission({user_id, 'nhs.emergency'}) then
            nhsOnline = nhsOnline+1
            job = 'NHS'
        end
        table.insert(playerlist, {UserID = user_id, playersTime = math.ceil(PlayerTimeInHours), playersId = playersId, playersName = name, playersJob = job})
    end
    TriggerClientEvent("playerlist:updatePlayers", source, playerlist, #GetPlayers()..'/128', 'Staff - '..staffOnline..' | Police - '..pdOnline..' | NHS - '..nhsOnline, value)
end)

RegisterServerEvent("playerlist:getUpdatedPlayers")
AddEventHandler("playerlist:getUpdatedPlayers",function(value)
    TriggerClientEvent("playerlist:updatePlayers", source, playerlist, #GetPlayers()..'/128', 'Staff 🧙‍♂️ '..staffOnline..' | Police 👮‍♂️ '..pdOnline..' | NHS 🚑 '..nhsOnline, value)
end)

AddEventHandler("vRP:playerLeave", function(user_id, source)
    local source = source
    local user_id = vRP.getUserId({source})
    if vRP.getUserId({source}) ~= nil then
        name = GetPlayerName(source)
        user_id = vRP.getUserId({source})
        for k,v in pairs(playerlist) do
            if v.UserID == user_id then
                table.remove(playerlist, k)
            end
        end
    end
    if vRP.hasPermission({user_id, 'admin.tickets'}) then
        staffOnline = staffOnline-1
    end
    if vRP.hasPermission({user_id, 'police.armoury'}) then
        pdOnline = pdOnline-1
    end
    if vRP.hasPermission({user_id, 'nhs.emergency'}) then
        nhsOnline = nhsOnline-1
    end
end)
