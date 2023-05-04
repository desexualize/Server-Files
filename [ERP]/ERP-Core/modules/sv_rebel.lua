local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP_gunshop")


RegisterServerEvent("Rebel:BuyGun")
AddEventHandler('Rebel:BuyGun', function(price, hash, bool)
    local source = source
    userid = vRP.getUserId({source})
    local ped = GetPlayerPed(source)
    local playerCoords = GetEntityCoords(ped)
            local coords = vec3(1545.2042236328,6332.3295898438,24.078683853149)
           if vRP.hasPermission({userid, "rebel.guns"}) then
                if #(playerCoords - coords) <= 5.0 then
                    if vRP.getInventoryWeight({userid}) <= 25 then
                        if vRP.tryPayment({userid,price}) then
                           if bool then

                                 vRP.giveInventoryItem({userid, "wbody|" .. hash, 1, true})
                                 vRP.giveInventoryItem({userid, "7.62 Bullets", 250, true})
                           else
                                TriggerClientEvent('rebel:givegun', source, hash)
                           end
                           
                           webhook = "https://discord.com/api/webhooks/1001565378520039505/0wtnul9CumdSnB3yMZ2XzS_5_EGVj8tJ2CuEzMnNFgTU22Y7oRn1E0xhXJj34BNc7r5q"
    
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
              vRPclient.notify(source,{"~r~You do not have Rebel Access!"})
                 TriggerClientEvent("ERP:PlaySound", source, 2)
           end

 
end)


RegisterServerEvent("Rebel:BuyArmour")
AddEventHandler('Rebel:BuyArmour', function(bool)
    local source = source
    userid = vRP.getUserId({source})
    local ped = GetPlayerPed(source)
    local playerCoords = GetEntityCoords(ped)
    local coords = vec3(1545.2042236328,6332.3295898438,24.078683853149)
    if #(playerCoords - coords) <= 5.0 then 
        if vRP.hasPermission({userid, "rebel.guns"}) then
            if vRP.getInventoryWeight({userid}) <= 25 then
                if vRP.tryPayment({userid,100000}) then     
                    SetPedArmour(source, 95)
                  webhook = "https://discord.com/api/webhooks/1001565378520039505/0wtnul9CumdSnB3yMZ2XzS_5_EGVj8tJ2CuEzMnNFgTU22Y7oRn1E0xhXJj34BNc7r5q"
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
                    vRPclient.notify(source, {"~g~Given Armour for £100,000!"})
                else
                    vRPclient.notify(source,{"~r~You do not have enough Money!"})
                        TriggerClientEvent("ERP:PlaySound", source, 2)
                end
            else
                vRPclient.notify(source,{'~r~Not enough Weight.'})
                TriggerClientEvent("ERP:PlaySound", source, 2)
            end
        else
           vRPclient.notify(source,{"~r~You do not have Rebel Access!"})
                TriggerClientEvent("ERP:PlaySound", source, 2)
       end
    else 
        vRP.banConsole({userid,"perm","Cheating/ Triggering Events"})
    end
    
end)

RegisterServerEvent("Rebel:BuyArmourPlate")
AddEventHandler('Rebel:BuyArmourPlate', function()
    local source = source
    userid = vRP.getUserId({source})
    local ped = GetPlayerPed(source)
    local playerCoords = GetEntityCoords(ped)
    local coords = vec3(1545.2042236328,6332.3295898438,24.078683853149)
    if #(playerCoords - coords) <= 5.0 then 
        if vRP.hasPermission({userid, "rebel.guns"}) then
            if vRP.getInventoryWeight({userid}) <= 25 then
                if vRP.tryPayment({userid,100000}) then     
                vRP.giveInventoryItem({userid, "body_armor", 1, true})
                  webhook = "https://discord.com/api/webhooks/1001565378520039505/0wtnul9CumdSnB3yMZ2XzS_5_EGVj8tJ2CuEzMnNFgTU22Y7oRn1E0xhXJj34BNc7r5q"
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
                    vRPclient.notify(source, {"~g~Given Armour for £100,000!"})
                else
                    vRPclient.notify(source,{"~r~You do not have enough Money!"})
                        TriggerClientEvent("ERP:PlaySound", source, 2)
                end
            else
                vRPclient.notify(source,{'~r~Not enough Weight.'})
                TriggerClientEvent("ERP:PlaySound", source, 2)
            end
        else
           vRPclient.notify(source,{"~r~You do not have Rebel Access!"})
                TriggerClientEvent("ERP:PlaySound", source, 2)
       end
    else 
        vRP.banConsole({userid,"perm","Cheating/ Triggering Events"})
    end
    
end)

