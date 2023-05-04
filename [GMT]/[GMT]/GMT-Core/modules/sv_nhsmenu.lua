local lang = vRP.lang
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP") 
vRPclient = Tunnel.getInterface("vRP","vRP")

RegisterServerEvent('GMT:OpenNHSMenu')
AddEventHandler('GMT:OpenNHSMenu', function()
    local source = source
    local user_id = vRP.getUserId({source})
    if user_id ~= nil and vRP.hasPermission({user_id, "nhs.menu"}) then
        TriggerClientEvent("GMT:NHSMenuOpened", source)
    elseif user_id ~= nil and vRP.hasPermission({user_id, "clockon.nhs"}) then
      vRPclient.notify(source,{"You are not on duty"})
    else
        print("You are not a part of the NHS")
    end
end)

local revive_seq = {{"amb@medic@standing@kneel@enter", "enter", 1}, {"amb@medic@standing@kneel@idle_a", "idle_a", 1},
                    {"amb@medic@standing@kneel@exit", "exit", 1}}

RegisterServerEvent('GMT:PerformCPR')
AddEventHandler('GMT:PerformCPR', function()
    player = source
    local user_id = vRP.getUserId(player)
    if user_id ~= nil and vRP.hasPermission(user_id, "nhs.revive") then
        vRPclient.getNearestPlayer(player, {3}, function(nplayer)
            local nuser_id = vRP.getUserId(nplayer)
            if nuser_id ~= nil then
                vRPclient.isInComa(nplayer, {}, function(in_coma)
                    if in_coma then
                        vRPclient.playAnim(player, {false, revive_seq, false}) -- anim
                        SetTimeout(15000, function()
                          TriggerClientEvent('GMT:FixPlayer',nplayer)
                          vRPclient.varyHealth(nplayer, 50) -- heal 50
                          vRPclient.notify(nplayer,{"~g~You have been revived by an NHS Member, free of charge"})
                          vRPclient.notify(player,{"~g~You revived someone, as a reward, here is £10,000 into your bank"})
                          vRP.giveBankMoney(player,10000)
                        end)
                    else
                        vRPclient.notify(player, {"~r~Player is alive and healthy"})
                    end
                end)
            else
                vRPclient.notify(player, {"~r~There is no player nearby"})
            end
        end)
    end
end)

RegisterServerEvent('GMT:HealPlayer')
AddEventHandler('GMT:HealPlayer', function()
    player = source
    local user_id = vRP.getUserId(player)
    if user_id ~= nil and vRP.hasPermission(user_id, "nhs.revive") then
        vRPclient.getNearestPlayer(player, {3}, function(nplayer)
            local nuser_id = vRP.getUserId(nplayer)
            if nuser_id ~= nil then
                vRPclient.playAnim(player, {false, revive_seq, false}) -- anim
                SetTimeout(10000, function()
                    vRPclient.varyHealth(nplayer, 100) -- heal 100
                    vRPclient.notify(nplayer,{"~g~You have been healed by an NHS Member, free of charge"})
                    vRPclient.notify(player,{"~g~You healed someone, as a reward, here is £5,000 into your bank"})
                    vRP.giveBankMoney(player,5000)
                end)
            else
                vRPclient.notify(player, {"~r~There is no player nearby"})
            end
        end)
    end
end)