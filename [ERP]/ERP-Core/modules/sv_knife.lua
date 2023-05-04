local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP_gunshop")

RegisterServerEvent("ERP:BuyKnife")
AddEventHandler('ERP:BuyKnife', function(price, hash)
    local source = source
    userid = vRP.getUserId({source})
    local ped = GetPlayerPed(source)
    local playerCoords = GetEntityCoords(ped)
    local coords = vec3(711.10620117188,-964.30639648438,30.39533996582)
    if #(playerCoords - coords) <= 5.0 then 
        if vRP.getInventoryWeight({userid}) <= 25 then
                if vRP.tryPayment({userid, price}) then
                    TriggerClientEvent("ERP:PlaySound", source, 1)
                    vRP.giveInventoryItem({userid, 'wbody|' .. hash, 1, true})
                    vRPclient.notify(source, {"~g~Paid "..knife.currency..tostring(price)})

                    webhook = "https://discord.com/api/webhooks/1001564962436681748/ap6MwDhthaZ7BAdDfmIDUQxU5FKgrKlht2ZMKfbj8CLBVhzS9GfzoexrhsOUgsZnJ75y"
        
                    PerformHttpRequest(webhook, function(err, text, headers) 
                    end, "POST", json.encode({username = "Element RP", embeds = {
                        {
                            ["color"] = "808080",
                            ["title"] = "",
                            ["description"] = "Name: **" .. GetPlayerName(source) .. "** \nUser ID: **" .. userid.. "** \nBought Weapon: **" .. hash .. '**\nPrice: **£' .. tostring(price).. '**',
                            ["footer"] = {
                                ["text"] = "Time - "..os.date("%x %X %p"),
                            }
                    }
                }}), { ["Content-Type"] = "application/json" })


                else 
                    TriggerClientEvent("ERP:PlaySound", source, 2)
                    vRPclient.notify(source, {"~r~Insufficient funds"})
                end
        else
            vRPclient.notify(source,{'~r~Not enough Weight.'})
            TriggerClientEvent("ERP:PlaySound", source, 2)
        end

    else 
        vRP.banConsole({userid,"perm","Cheating/ Triggering Events"})
    end
end)




