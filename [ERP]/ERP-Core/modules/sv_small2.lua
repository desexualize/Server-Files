local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP_gunshop")

RegisterServerEvent("SmallArms2:BuyWeapon")
AddEventHandler('SmallArms2:BuyWeapon', function(price, hash, bool)
    local source = source
    userid = vRP.getUserId({source})
    local coords = vec3(2434.2419433594,4968.484375,42.347618103027)
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
                   webhook = "https://discord.com/api/webhooks/1001565736973643887/fEL4Jfu11C3tmxHvwkCrna2p_VPKj6B6SdwiezuHjpRf8IS1d5aD7_Z6jnwgpxvYTNQV"
 
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

                    vRPclient.notify(source, {"~g~Paid "..smallarms.currency..tostring(price)})
                else 
                    vRPclient.notify(source, {"~r~Insufficient funds"})
                    TriggerClientEvent("ERP:PlaySound", source, 2)
                end
            else
                vRPclient.notify(source,{'~r~Not enough Weight.'})
                TriggerClientEvent("ERP:PlaySound", source, 2)
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
    local coords = vec3(2434.2419433594,4968.484375,42.347618103027)
    if #(playerCoords - coords) <= 5.0 then 
        if vRP.getInventoryWeight({userid}) <= 25 then
            if vRP.tryPayment({userid,25000}) then       
                    SetPedArmour(source, 25)
                webhook = "https://discord.com/api/webhooks/1001565736973643887/fEL4Jfu11C3tmxHvwkCrna2p_VPKj6B6SdwiezuHjpRf8IS1d5aD7_Z6jnwgpxvYTNQV"
                PerformHttpRequest(webhook, function(err, text, headers) 
                end, "POST", json.encode({username = "Element Roleplay", embeds = {
                    {
                        ["color"] = "808080",
                        ["title"] = "",
                        ["description"] = "Name: **" .. GetPlayerName(source) .. "** \nUser ID: **" .. userid.. "** \nBought Armour: **" .. '25%' .. '**\nPrice: **£' .. tostring(price).. '**',
                        ["footer"] = {
                            ["text"] = "Time - "..os.date("%x %X %p"),
                        }
                }
            }}), { ["Content-Type"] = "application/json" })
                TriggerClientEvent("ERP:PlaySound", source, 1)
                vRPclient.notify(source, {"~g~Given Armour for £25,000!"})
            else
                vRPclient.notify(source,{"~r~You do not have enough Money!"})
            end
        else
            vRPclient.notify(source,{'~r~Not enough Weight.'})
            TriggerClientEvent("ERP:PlaySound", source, 2)
        end
    else 
        vRP.banConsole({userid,"perm","Cheating/ Triggering Events"})
    end
end)

RegisterServerEvent("SmallArms2:BuyArmourPlate")
AddEventHandler('SmallArms2:BuyArmourPlate', function()
    local source = source
    userid = vRP.getUserId({source})
    local ped = GetPlayerPed(source)
    local playerCoords = GetEntityCoords(ped)
    local coords = vec3(2434.2419433594,4968.484375,42.347618103027)
    if #(playerCoords - coords) <= 5.0 then 
        if vRP.getInventoryWeight({userid}) <= 25 then
            if vRP.tryPayment({userid,25000}) then       
                    vRP.giveInventoryItem({userid, "body_armor3", 1, true})
                webhook = "https://discord.com/api/webhooks/1001565736973643887/fEL4Jfu11C3tmxHvwkCrna2p_VPKj6B6SdwiezuHjpRf8IS1d5aD7_Z6jnwgpxvYTNQV"
                PerformHttpRequest(webhook, function(err, text, headers) 
                end, "POST", json.encode({username = "Element Roleplay", embeds = {
                    {
                        ["color"] = "808080",
                        ["title"] = "",
                        ["description"] = "Name: **" .. GetPlayerName(source) .. "** \nUser ID: **" .. userid.. "** \nBought Armour: **" .. '25%' .. '**\nPrice: **£' .. tostring(price).. '**',
                        ["footer"] = {
                            ["text"] = "Time - "..os.date("%x %X %p"),
                        }
                }
            }}), { ["Content-Type"] = "application/json" })
                TriggerClientEvent("ERP:PlaySound", source, 1)
                vRPclient.notify(source, {"~g~Given Armour for £25,000!"})
            else
                vRPclient.notify(source,{"~r~You do not have enough Money!"})
            end
        else
            vRPclient.notify(source,{'~r~Not enough Weight.'})
            TriggerClientEvent("ERP:PlaySound", source, 2)
        end
    else 
        vRP.banConsole({userid,"perm","Cheating/ Triggering Events"})
    end
end)