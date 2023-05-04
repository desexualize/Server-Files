local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

RegisterServerEvent("ERP:PANIC")
AddEventHandler("ERP:PANIC", function(coords)
    user_id2 = vRP.getUserId({source}) 
    local blipcolor = 0
    if vRP.hasPermission({user_id2, "police.menu"}) or vRP.hasPermission({user_id2, "emergency.vehicle"}) or vRP.hasPermission({user_id2, "lfb.vehicle"}) then 
     if vRP.hasPermission({ user_id2, "police.menu"}) then 
        blipcolor = 75
     end 
     if vRP.hasPermission({ user_id2, "emergency.vehicle"}) then 
        blipcolor = 75
     end 
     if vRP.hasPermission({ user_id2, "lfb.vehicle"}) then 
        blipcolor = 75
     end
local players = GetPlayers()
for i,v in pairs(players) do 
    name = GetPlayerName(v)
    user_id = vRP.getUserId({v})   
    if vRP.hasPermission({user_id, "police.menu"}) or vRP.hasPermission({user_id, "emergency.vehicle"}) or vRP.hasPermission({user_id, "lfb.vehicle"}) then
    TriggerClientEvent("ERP:PANICBUTTON", v, coords,blipcolor)
    end
end
end
end)

