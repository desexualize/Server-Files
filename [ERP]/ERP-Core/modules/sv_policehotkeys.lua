local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp","lib/Tunnel")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_policeHotkeys")

RegisterNetEvent('ERP:policeDrag')
AddEventHandler('ERP:policeDrag', function()
    
    local source = source
    Citizen.Wait(0)
    local user_id = vRP.getUserId({source})
    
    if user_id ~= nil and vRP.hasPermission({user_id, "police.menu"}) then
        
        vRPclient.getNearestPlayer(source,{2},function(nplayer)
            local nplayer = nplayer
            
            if nplayer ~= nil then
                local nuser_id = vRP.getUserId({nplayer})
            if nuser_id ~= nil then
                vRPclient.isHandcuffed(nplayer,{},function(handcuffed)
                if handcuffed then
                    TriggerClientEvent("ERP:drag", nplayer, source)
                else
                    --vRPclient.notify(source,{"Player is not handcuffed."})
                end
                end)
            else
                --vRPclient.notify(source,{lang.common.no_player_near()})
                
            end
            else
            --vRPclient.notify(source,{lang.common.no_player_near()})
            
            end
        end)
    end
end)

local crookanim = {

    {"mp_arrest_paired","crook_p2_back_left",1},
}

local policeanim = {

    {"mp_arrest_paired","cop_p2_back_left",1},
}
local policeuncuff = {

    {"mp_arresting", "a_uncuff", 1},

}
local crookuncuff = {

    {"mp_arresting", "b_uncuff", 1},

}
local playerHandcuffed = false

RegisterNetEvent("ERP:policeCuff")
AddEventHandler("ERP:policeCuff", function()
    local player = source
    local user_id = vRP.getUserId({source})
    handcuffed = nil
    if user_id ~= nil and vRP.hasPermission({user_id, "police.menu"}) then
        vRPclient.getNearestPlayer(player,{2},function(nplayer)
            nplayer = nplayer
            local nuser_id = vRP.getUserId({nplayer})

            vRPclient.isHandcuffed(nplayer,{},function(handcuffed)
                local nplayer = nplayer
                local nuser_id = vRP.getUserId({nplayer})
                local handcuffed = handcuffed
                print(handcuffed)

                
                if nuser_id ~= nil then
                    if handcuffed == false then
                        vRPclient.playAnim(nplayer,{true,crookanim,false})
                        vRPclient.playAnim(player,{true,policeanim,false})
                        vRPclient.toggleHandcuff(nplayer,{})
                        TriggerClientEvent("ERP:cuffAnimPolice", player, nplayer, player)
                        TriggerClientEvent("ERP:cuffAnimPerp", nplayer, nplayer, player)
                    elseif handcuffed == true then
                        vRPclient.playAnim(nplayer,{true,crookuncuff,false})
                        vRPclient.playAnim(player,{true,policeuncuff,false})
                        vRPclient.toggleHandcuff(nplayer,{})
                        TriggerClientEvent("ERP:cuffAnimPolice", player, nplayer, player)
                        TriggerClientEvent("ERP:cuffAnimPerp", nplayer, nplayer, player)
                    end
                else
                    vRPclient.notify(player,"No player near you")
                end

            end)
        end)
    end
    


end)