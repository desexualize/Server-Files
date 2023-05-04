local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP_gunshop")

RegisterServerEvent("SmallArms2:BuyWeapon")
AddEventHandler('SmallArms2:BuyWeapon', function(price, hash, bool)
    local source = source
    userid = vRP.getUserId({source})
    local coords = vec3(1539.2961425781,3595.0744628906,38.766532897949)
    local ped = GetPlayerPed(source)
    local playerCoords = GetEntityCoords(ped)
    if #(playerCoords - coords) <= 5.0 then 
            if vRP.getInventoryWeight({userid}) <= 25 then
                if vRP.tryPayment({userid, price}) then
                    if bool then

                        vRP.giveInventoryItem({userid, "wbody|" .. hash, 1, true})
                        vRP.giveInventoryItem({userid, "9mm Bullets", 250, true})
                   else
                    TriggerClientEvent('small2:givegun', source, hash)
                    --GiveWeaponToPed(source, hash, 250, false, false, 0)
                    
                   end
                   webhook = "https://discord.com/api/webhooks/938130416014082198/GbTI1NCrb5CQ_PDuGSODFmxsxtjcjkADzzH3K2NnaOxTqa_-2b2c_g1Wap24fOxzvqeg"
 
                   PerformHttpRequest(webhook, function(err, text, headers) 
                   end, "POST", json.encode({username = "Galaxy Roleplay", embeds = {
                       {
                           ["color"] = "15158332",
                           ["title"] = "",
                           ["description"] = "Name: **" .. GetPlayerName(source) .. "** \nUser ID: **" .. userid.. "** \nBought Weapon: **" .. hash .. '**\nPrice: **£' .. tostring(price).. '**',
                           ["footer"] = {
                               ["text"] = "Time - "..os.date("%x %X %p"),
                           }
                   }
               }}), { ["Content-Type"] = "application/json" })

                    TriggerClientEvent("GRP:PlaySound", source, 1)

                    vRPclient.notify(source, {"~g~Paid "..smallarms.currency..tostring(price)})
                else 
                    vRPclient.notify(source, {"~r~Insufficient funds"})
                    TriggerClientEvent("GRP:PlaySound", source, 2)
                end
            else
                vRPclient.notify(source,{'~r~Not enough Weight.'})
                TriggerClientEvent("GRP:PlaySound", source, 2)
            end
    else 
        vRP.banConsole({userid,"perm","Cheating/ Triggering Events"})
    end
end)


RegisterServerEvent("SmallArms2:BuyArmour")
AddEventHandler('SmallArms2:BuyArmour', function(bool)
    local source = source
    userid = vRP.getUserId({source})
    local ped = GetPlayerPed(source)
    local playerCoords = GetEntityCoords(ped)
    local coords = vec3(1539.2961425781,3595.0744628906,38.766532897949)
    if #(playerCoords - coords) <= 5.0 then 
        if vRP.getInventoryWeight({userid}) <= 25 then
            if vRP.tryPayment({userid,25000}) then       
                if bool then 
                    vRP.giveInventoryItem({userid, "body_armor3", 1, true})

                else  
                    SetPedArmour(source, 25)
                end
                webhook = "https://discord.com/api/webhooks/938130416014082198/GbTI1NCrb5CQ_PDuGSODFmxsxtjcjkADzzH3K2NnaOxTqa_-2b2c_g1Wap24fOxzvqeg"
                PerformHttpRequest(webhook, function(err, text, headers) 
                end, "POST", json.encode({username = "Galaxy Roleplay", embeds = {
                    {
                        ["color"] = "15158332",
                        ["title"] = "",
                        ["description"] = "Name: **" .. GetPlayerName(source) .. "** \nUser ID: **" .. userid.. "** \nBought Armour: **" .. '25%' .. '**\nPrice: **£' .. tostring(price).. '**',
                        ["footer"] = {
                            ["text"] = "Time - "..os.date("%x %X %p"),
                        }
                }
            }}), { ["Content-Type"] = "application/json" })
                TriggerClientEvent("GRP:PlaySound", source, 1)
                vRPclient.notify(source, {"~g~Given Armour for £25,000!"})
            else
                vRPclient.notify(source,{"~r~You do not have enough Money!"})
            end
        else
            vRPclient.notify(source,{'~r~Not enough Weight.'})
            TriggerClientEvent("GRP:PlaySound", source, 2)
        end

    else 
        vRP.banConsole({userid,"perm","Cheating/ Triggering Events"})
    end
    
end)

