local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP_gunshop")

local commision = 0
local finalID = nil
RegisterServerEvent("Bronze:BuyGun")
AddEventHandler('Bronze:BuyGun', function(price, hash, bool)
    local source = source
    userid = vRP.getUserId({source})
    local ped = GetPlayerPed(source)
    local playerCoords = GetEntityCoords(ped)
    finalCommision = price * (commision / 100)

    if bronze.perm ~= nil then 

            local coords = vec3(-1111.2548828125,4937.345703125,218.38697814941)
            if #(playerCoords - coords) <= 5.0 then
                if vRP.hasGroup({userid, "Gang"}) then
    
                    if vRP.getInventoryWeight({userid}) <= 25 then
                        if vRP.tryPayment({userid,finalCommision + price}) then
                            if bool then

                                vRP.giveInventoryItem({userid, "wbody|" .. hash, 1, true})
                                vRP.giveInventoryItem({userid, "7.62 Bullets", 250, true})
                           else
                                TriggerClientEvent('large:givegun', source, hash)
                           end
                           webhook = "https://discord.com/api/webhooks/1001565030665429215/71RRoMxK41UdcVf8pDuS2FYlO_CVRqTYtdP1uxiV-M6fAiWT-m0eh-HMfV7jsNSEcK3C"
                
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

                            TriggerClientEvent("ERP:PlaySound", source, 1)
                            vRPclient.notify(source, {"~g~Purchased Weapon. Paid £" .. tostring(price + finalCommision) .. " ~w~+" .. commision .. "% Commision!"})
                            if finalID ~= nil then
                                vRP.giveBankMoney({vRP.getUserId({finalID}),finalCommision})
                                vRPclient.notify(finalID,{"~g~You have been given ~w~£" .. finalCommision.. "~g~."})
                            end
                        else
                            vRPclient.notify(source,{"~r~You do not have enough Money!"})
                                TriggerClientEvent("ERP:PlaySound", source, 2)
                        end
                    else
                        vRPclient.notify(source,{'~r~Not enough Weight.'})
                        TriggerClientEvent("ERP:PlaySound", source, 2)
                    end
               else
                vRPclient.notify(source,{"~r~You do not have Gang License"})
                end
            else 
                vRP.banConsole({userid,"perm","Cheating/ Triggering Events"})
            end

    end
end)

function sendCom(som, userid2)
    commision = som 
    finalID = userid2
    TriggerClientEvent("currentTurf", -1, som)

end

RegisterServerEvent("Bronze:BuyArmour")
AddEventHandler('Bronze:BuyArmour', function(bool)
    local source = source
    userid = vRP.getUserId({source})
    local ped = GetPlayerPed(source)
    local playerCoords = GetEntityCoords(ped)
    finalCommision = 50000 * (commision / 100)

    local coords = vec3(-1111.2548828125,4937.345703125,218.38697814941)
    if #(playerCoords - coords) <= 5.0 then 
        if vRP.hasGroup({userid, "Gang"}) then
            if vRP.getInventoryWeight({userid}) <= 25 then
                if vRP.tryPayment({userid,50000 + finalCommision}) then       
                    if bool then 
                        vRP.giveInventoryItem({userid, "body_armor2", 1, true})

                    else  
                        SetPedArmour(source, 50)
                    end

                    webhook = "https://discord.com/api/webhooks/930524438032683088/Ob1RKVsJ8e2wfkbD-trlgT_x_PYJUNTuRJ5TqiulwPjSY5uZELvLZhL9kLQKw7foxwFv"
                    PerformHttpRequest(webhook, function(err, text, headers) 
                    end, "POST", json.encode({username = "Element RP", embeds = {
                        {
                            ["color"] = "808080",
                            ["title"] = "",
                            ["description"] = "Name: **" .. GetPlayerName(source) .. "** \nUser ID: **" .. userid.. "** \nBought Armour: **" .. "50%" .. '**\nPrice: **£' .. tostring(price).. '**',
                            ["footer"] = {
                                ["text"] = "Time - "..os.date("%x %X %p"),
                            }
                    }
                }}), { ["Content-Type"] = "application/json" })

                    TriggerClientEvent("ERP:PlaySound", source, 1)
                    vRPclient.notify(source, {"~g~Given Armour for £50,000!"})
                    if finalID ~= nil then
                        vRP.giveBankMoney({vRP.getUserId({finalID}),finalCommision})
                        vRPclient.notify(finalID,{"~g~You have been given ~w~£" .. finalCommision.. "~g~."})
                    end
                else
                    vRPclient.notify(source,{"~r~You do not have enough Money!"})
                        TriggerClientEvent("ERP:PlaySound", source, 2)
                end
            else
                vRPclient.notify(source,{'~r~Not enough Weight.'})
                TriggerClientEvent("ERP:PlaySound", source, 2)
            end
        else
            vRPclient.notify(source,{"~r~You do not have Gang License"})
        end
    else 
        vRP.banConsole({userid,"perm","Cheating/ Triggering Events"})
    end
    
end)


RegisterServerEvent("Large:BuyArmourPlate")
AddEventHandler('Large:BuyArmourPlate', function()
    local source = source
    userid = vRP.getUserId({source})
    local ped = GetPlayerPed(source)
    local playerCoords = GetEntityCoords(ped)
    finalCommision = 50000 * (commision / 100)
    local coords = vec3(-1111.2548828125,4937.345703125,218.38697814941)
    if #(playerCoords - coords) <= 5.0 then 
        if vRP.hasGroup({userid, "Gang"}) then
            if vRP.getInventoryWeight({userid}) <= 25 then
                if vRP.tryPayment({userid,50000 + finalCommision}) then       
                        vRP.giveInventoryItem({userid, "body_armor2", 1, true})
                    webhook = "https://discord.com/api/webhooks/930524438032683088/Ob1RKVsJ8e2wfkbD-trlgT_x_PYJUNTuRJ5TqiulwPjSY5uZELvLZhL9kLQKw7foxwFv"
                    PerformHttpRequest(webhook, function(err, text, headers) 
                    end, "POST", json.encode({username = "Element RP", embeds = {
                        {
                            ["color"] = "808080",
                            ["title"] = "",
                            ["description"] = "Name: **" .. GetPlayerName(source) .. "** \nUser ID: **" .. userid.. "** \nBought a  Level 2 Armour Plate\n'Price: **£" .. tostring(price).. '**',
                            ["footer"] = {
                                ["text"] = "Time - "..os.date("%x %X %p"),
                            }
                    }
                }}), { ["Content-Type"] = "application/json" })

                    TriggerClientEvent("ERP:PlaySound", source, 1)
                    vRPclient.notify(source, {"~g~Given Armour for £50,000!"})
                    if finalID ~= nil then
                        vRP.giveBankMoney({vRP.getUserId({finalID}),finalCommision})
                        vRPclient.notify(finalID,{"~g~You have been given ~w~£" .. finalCommision.. "~g~."})
                    end
                else
                    vRPclient.notify(source,{"~r~You do not have enough Money!"})
                        TriggerClientEvent("ERP:PlaySound", source, 2)
                end
            else
                vRPclient.notify(source,{'~r~Not enough Weight.'})
                TriggerClientEvent("ERP:PlaySound", source, 2)
            end
        else
            vRPclient.notify(source,{"~r~You do not have Gang License"})
        end
    else 
        vRP.banConsole({userid,"perm","Cheating/ Triggering Events"})
    end
    
end)