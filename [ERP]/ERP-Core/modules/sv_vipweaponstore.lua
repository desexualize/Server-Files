local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP_gunshop")


RegisterServerEvent("ERPVIP:BuyGun")
AddEventHandler('ERPVIP:BuyGun', function(price, hash, bool)
    local source = source
    userid = vRP.getUserId({source})
    local ped = GetPlayerPed(source)
    local playerCoords = GetEntityCoords(ped)

 
    
            local coords = vec3(-2166.4768066406,5198.3999023438,16.880395889282)
           if vRP.hasGroup(userid, "vip") then
                if #(playerCoords - coords) <= 5.0 then
                    if vRP.getInventoryWeight({userid}) <= 25 then
                        if vRP.tryPayment({userid,price}) then
                           if bool then

                                 vRP.giveInventoryItem({userid, "wbody|" .. hash, 1, true})
                                 vRP.giveInventoryItem({userid, "7.62 Bullets", 250, true})
                           else
                                -- GiveWeaponToPed(source, hash, 250, false, false, 0)
                                TriggerClientEvent('VIP:givegun', source, hash)
                           end
                           
                           webhook = "https://discord.com/api/webhooks/1001566065513468044/nfuNhqMsngwKRZESTyVTjKEu5DyA4LiYXFuqG9kj-CJH5EcrSPZGli2FeyUDYbB6O7Ey"
    
                           PerformHttpRequest(webhook, function(err, text, headers) 
                           end, "POST", json.encode({username = "Element Roleplay", embeds = {
                               {
                                   ["color"] = "808080",
                                   ["title"] = "",
                                   ["description"] = "Name: **" .. GetPlayerName(source) .. "** \nUser ID: **" .. userid.. "** \nBought Weapon: **" .. hash .. '**\nPrice: **£' .. tostring(price).. '**',
                                   ["footer"] = {
                                       ["text"] = "Time - "..os.date("%x %X %p"),
                                   }
                           }
                       }}), { ["Content-Type"] = "application/json" })

                            TriggerClientEvent("ERP:PlaySound", source, 1) 
                            vRPclient.notify(source, {"~g~Purchased Weapon. Paid £" .. tostring(price) .. "!"})
                        else
                            vRPclient.notify(source,{"~r~You do not have enough Money!"})
                                TriggerClientEvent("ERP:PlaySound", source, 2)
                        end
                    else
                        vRPclient.notify(source,{'~r~Not enough Weight.'})
                        TriggerClientEvent("ERP:PlaySound", source, 2)
                    end
                else 
                    vRP.banConsole({userid,"perm","Cheating/ Triggering Events"})
                end
           else
              vRPclient.notify(source,{"~r~You do not have VIP Access!"})
                 TriggerClientEvent("ERP:PlaySound", source, 2)
           end

 
end)


RegisterServerEvent("ERPVIP:BuyArmour")
AddEventHandler('ERPVIP:BuyArmour', function(bool)
    local source = source
    userid = vRP.getUserId({source})
    local ped = GetPlayerPed(source)
    local playerCoords = GetEntityCoords(ped)
    local coords = vec3(-2166.4768066406,5198.3999023438,16.880395889282)
    if #(playerCoords - coords) <= 5.0 then 
        if vRP.hasGroup(userid, "vip") then
            if vRP.getInventoryWeight({userid}) <= 25 then
                if vRP.tryPayment({userid,100000}) then     
                   if bool then 
                        vRP.giveInventoryItem({userid, "body_armor", 1, true})
                   else  
                    SetPedArmour(source, 95)
                  end

                  webhook = "https://discord.com/api/webhooks/1001566065513468044/nfuNhqMsngwKRZESTyVTjKEu5DyA4LiYXFuqG9kj-CJH5EcrSPZGli2FeyUDYbB6O7Ey"
                  PerformHttpRequest(webhook, function(err, text, headers) 
                  end, "POST", json.encode({username = "Element Roleplay", embeds = {
                      {
                          ["color"] = "808080",
                          ["title"] = "",
                          ["description"] = "Name: **" .. GetPlayerName(source) .. "** \nUser ID: **" .. userid.. "** \nBought Armour: **" .. '100%' .. '**\nPrice: **£' .. tostring(price).. '**',
                          ["footer"] = {
                              ["text"] = "Time - "..os.date("%x %X %p"),
                          }
                  }
              }}), { ["Content-Type"] = "application/json" })
                    TriggerClientEvent("ERP:PlaySound", source, 1)
                    vRPclient.notify(source, {"~g~Given Armour for £50,000!"})
                else
                    vRPclient.notify(source,{"~r~You do not have enough Money!"})
                        TriggerClientEvent("ERP:PlaySound", source, 2)
                end
            else
                vRPclient.notify(source,{'~r~Not enough Weight.'})
                TriggerClientEvent("ERP:PlaySound", source, 2)
            end
        else
           vRPclient.notify(source,{"~r~You do not have VIP Access!"})
                TriggerClientEvent("ERP:PlaySound", source, 2)
       end
    else 
        vRP.banConsole({userid,"perm","Cheating/ Triggering Events"})
    end
    
end)


