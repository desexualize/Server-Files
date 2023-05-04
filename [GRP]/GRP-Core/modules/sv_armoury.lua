local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP_gunshop")


RegisterServerEvent("Police:BuyGun")
AddEventHandler('Police:BuyGun', function(hash)
    local source = source
    userid = vRP.getUserId({source})
    local ped = GetPlayerPed(source)
    local playerCoords = GetEntityCoords(ped)

 
    
            local coords = vec3(438.66287231445,-987.72296142578,34.297355651855)
           if vRP.hasPermission({userid, "police.menu"}) then
                if #(playerCoords - coords) <= 5.0 then
                    if vRP.getInventoryWeight({userid}) <= 25 then
                        
                 
                                TriggerClientEvent('police:givegun', source, hash)
                        
                           

                            TriggerClientEvent("GRP:PlaySound", source, 1) 
                            vRPclient.notify(source, {"~g~Purchased Weapon!"})
            
                    else
                        vRPclient.notify(source,{'~r~Not enough Weight.'})
                        TriggerClientEvent("GRP:PlaySound", source, 2)
                    end
                else 
                    vRP.banConsole({userid,"perm","Cheating/ Triggering Events"})
                end
           else
              vRPclient.notify(source,{"~r~You are not apart of the Police Force!"})
                 TriggerClientEvent("GRP:PlaySound", source, 2)
           end

 
end)


RegisterServerEvent("Police:BuyArmour")
AddEventHandler('Police:BuyArmour', function(bool)
    local source = source
    userid = vRP.getUserId({source})
    local ped = GetPlayerPed(source)
    local playerCoords = GetEntityCoords(ped)
    local coords = vec3(438.66287231445,-987.72296142578,34.297355651855)
    if #(playerCoords - coords) <= 5.0 then 
        if vRP.hasPermission({userid, "police.menu"}) then
            if vRP.getInventoryWeight({userid}) <= 25 then
                  
               
                    SetPedArmour(source, 95)
                
                    TriggerClientEvent("GRP:PlaySound", source, 1)
                    vRPclient.notify(source, {"~g~Given Armour!"})
      
            else
                vRPclient.notify(source,{'~r~Not enough Weight.'})
                TriggerClientEvent("GRP:PlaySound", source, 2)
            end
        else
           vRPclient.notify(source,{"~r~You do not have Rebel Access!"})
                TriggerClientEvent("GRP:PlaySound", source, 2)
       end
    else 
        vRP.banConsole({userid,"perm","Cheating/ Triggering Events"})
    end
    
end)


