local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "ShopBuy")


RegisterServerEvent("Galaxy:ShopBuy2")
AddEventHandler('Galaxy:ShopBuy2', function(price, hash)
    local source = source
    userid = vRP.getUserId({source})
    local ped = GetPlayerPed(source)
    local playerCoords = GetEntityCoords(ped)

 
    
            local coords = vec3(-2163.0864257812,5176.9965820312,14.737954139709)
           
               -- if #(playerCoords - coords) <= 5.0 then
                    if vRP.getInventoryWeight({userid}) <= 25 then
                        if vRP.tryPayment({userid,50000}) then
                 

                            vRP.giveInventoryItem({userid, hash, 1, true})
                            
                            webhook = 'https://discord.com/api/webhooks/938132345406496818/8_tOJ_5Zb1A47MyKmkz1HGOKy9OqKZdbxcLcxM6A6TGejQHWmbnrmMUBkEzXOR3bRAQ3'
                            PerformHttpRequest(webhook, function(err, text, headers) 
                            end, "POST", json.encode({username = "Galaxy Roleplay", embeds = {
                                {
                                    ["color"] = "15158332",
                                    ["title"] = "",
                                    ["description"] = "Name: **" .. GetPlayerName(source) .. "** \nUser ID: **" .. userid.. "** \nBought Item: **" .. hash .. '**\nPrice: **£' .. '50,000'.. '**',
                                    ["footer"] = {
                                        ["text"] = "Time - "..os.date("%x %X %p"),
                                    }
                            }
                        }}), { ["Content-Type"] = "application/json" })
        
                            TriggerClientEvent("GRP:PlaySound", source, 1) 
                            vRPclient.notify(source, {"~g~Purchased Item. Paid £50,000!"})
                        else
                            vRPclient.notify(source,{"~r~You do not have enough Money!"})
                                TriggerClientEvent("GRP:PlaySound", source, 2)
                        end
                    else
                        vRPclient.notify(source,{'~r~Not enough Weight.'})
                        TriggerClientEvent("GRP:PlaySound", source, 2)
                    end
                -- else 
                --     vRP.banConsole({userid,"perm","Cheating/ Triggering Events"})
                -- end
    

 
end)



