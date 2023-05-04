local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP_gunshop")

local commision = 10
local finalID = nil


RegisterServerEvent("FNR:BuyGun")
AddEventHandler('FNR:BuyGun', function(hash)
    local source = source
    local user_id = vRP.getUserId({source})
    if user_id ~= nil then
        if vRP.hasGroup({user_id, "Gang"}) then
            for k, v in pairs(large.guns) do
                finalCommision = v.price * (commision / 100)
                if v.hash == hash then
                    if vRP.tryPayment({user_id, v.price + finalCommision}) then
                        local finalprice = tonumber(v.price + finalCommision)
                        vRPclient.giveWeapons(source,{{[v.hash] = {ammo=250}}})
                        vRPclient.notify(source, {"~g~Paid £"..getMoneyStringFormatted(v.price)})
                        TriggerClientEvent("FNR:PlaySound", source, 1)
                        local command = {
                            {
                                ["color"] = "3944703",
                                ["title"] = "FNR Gunstore Logs",
                                ["description"] = "",
                                ["text"] = "FNR Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
                                ["fields"] = {
                                    {
                                        ["name"] = "Player Name",
                                        ["value"] = GetPlayerName(source),
                                        ["inline"] = true
                                    },
                                    {
                                        ["name"] = "Player TempID",
                                        ["value"] = source,
                                        ["inline"] = true
                                    },
                                    {
                                        ["name"] = "Player PermID",
                                        ["value"] = user_id,
                                        ["inline"] = true
                                    },
                                    {
                                        ["name"] = "Item Name",
                                        ["value"] = hash,
                                        ["inline"] = true
                                    },
                                    {
                                        ["name"] = "Item Price",
                                        ["value"] = "£"..parseInt(finalprice),
                                        ["inline"] = true
                                    },
                                    {
                                        ["name"] = "Store Name",
                                        ["value"] = "Large Arms",
                                        ["inline"] = true
                                    },
                                    {
                                        ["name"] = "Whitelist",
                                        ["value"] = "false",
                                        ["inline"] = true
                                    }
                                }
                            }
                        }
                        local webhook = "https://discord.com/api/webhooks/1027271668541964378/5ib6k-f_SlEHtG3Px-odF_LSDSb0a1JqPGcUWcOOQRJXkniLjCQfjRkRlCuzDqYH4pv5"
                        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "FNR", embeds = command}), { ['Content-Type'] = 'application/json' }) 
                    else 
                        TriggerClientEvent("FNR:PlaySound", source, 2)
                        vRPclient.notify(source, {"~r~Insufficient funds. Please ensure the commission is set to 0."})


                    end

                --     if finalID ~= nil then 
                --     vRP.giveBankMoney({vRP.getUserId({finalID}),finalCommision}) 
                --     print(finalCommision)
                --     vRPclient.notify(finalID,{"~g~You have been given ~w~£" .. finalCommision.. "~g~."})
                --  end
                end
            end
        else
            vRPclient.notify(source, {"~r~You do not have permission to purchase guns from here"})
            TriggerClientEvent("FNR:PlaySound", source, 2)
        end
    end
end)


RegisterServerEvent("LargeArms:BuyWLGun")
AddEventHandler('LargeArms:BuyWLGun', function(hash)
    local source = source 
    local user_id = vRP.getUserId({source})
    if user_id ~= nil then 
        if vRP.hasGroup({user_id, "Gang"}) then
            exports['ghmattimysql']:execute("SELECT * FROM `weapon_whitelists` WHERE permid = @permid", {permid = user_id}, function(result)
                for k,v in pairs(result) do
        if v.category == "large" then
           if v.gunhash == hash then 
             finalCommision = v.price * (commision / 100)
                if vRP.tryPayment({user_id, tonumber(finalCommision + v.price)}) then
                    local finalprice = tonumber(v.price + finalCommision)
                    vRPclient.giveWeapons(source,{{[hash] = {ammo=250}}})
                    vRPclient.notify(source, {"~g~Paid £"..getMoneyStringFormatted(v.price + finalCommision)})
                    TriggerClientEvent("FNR:PlaySound", source, 1)
                    local command = {
                        {
                            ["color"] = "3944703",
                            ["title"] = "FNR Gunstore Logs",
                            ["description"] = "",
                            ["text"] = "FNR Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
                            ["fields"] = {
                                {
                                    ["name"] = "Player Name",
                                    ["value"] = GetPlayerName(source),
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "Player TempID",
                                    ["value"] = source,
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "Player PermID",
                                    ["value"] = user_id,
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "Item Name",
                                    ["value"] = hash,
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "Item Price",
                                    ["value"] = "£"..parseInt(finalprice),
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "Store Name",
                                    ["value"] = "Large Arms",
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "Whitelist",
                                    ["value"] = "true",
                                    ["inline"] = true
                                }
                            }
                        }
                    }
                    local webhook = "https://discord.com/api/webhooks/1027271668541964378/5ib6k-f_SlEHtG3Px-odF_LSDSb0a1JqPGcUWcOOQRJXkniLjCQfjRkRlCuzDqYH4pv5"
                    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "FNR", embeds = command}), { ['Content-Type'] = 'application/json' }) 
                else
                    TriggerClientEvent("FNR:PlaySound", source, 2)
                    vRPclient.notify(source, {"~r~Insufficient funds. Please ensure the commission is set to 0."})
                end
                -- if finalID ~= nil then 
                --     vRP.giveBankMoney({vRP.getUserId({finalID}),finalCommision}) 
                --     vRPclient.notify(finalID,{"~g~You have been given ~w~£" .. finalCommision.. "~g~."})

                -- end
              end
            end
            end
           end)
        else 
            vRPclient.notify(source, {"~r~You do not have permission to purchase guns from here 🤦‍♂️"})
            TriggerClientEvent("FNR:PlaySound", source, 2)
        end
    end
end)



function sendCom(som, userid2)
    commision = som 
    finalID = userid2
    TriggerClientEvent("currentTurf", -1, som)
    TriggerClientEvent('Large:SendCommision', source, som)
end

RegisterServerEvent("FNR:BuyArmour")
AddEventHandler('FNR:BuyArmour', function(price, amount)
    local source = source
    userid = vRP.getUserId({source})
    finalCommision = price * (commision / 100)
    local currentArmour = GetPedArmour(GetPlayerPed(source))

    expectedPrice = amount*1000
    if not price == expectedPrice then return end
        if vRP.hasGroup({userid, "Gang"}) then
            if vRP.getInventoryWeight({userid}) <= 25 then
                if currentArmour < 50 then
                   -- if vRP.tryPayment({userid,price + finalCommision/2}) then       
                        if vRP.tryPayment({userid,0}) then     
                        vRPclient.setArmour(source,{50})
                        TriggerClientEvent("FNR:PlaySound", source, 1)
                        vRPclient.notify(source, {"~g~Paid "..large.currency..tostring(getMoneyStringFormatted(price + finalCommision))})
                        local finalprice = tonumber(price + finalCommision)
                        local command = {
                            {
                                ["color"] = "3944703",
                                ["title"] = "FNR Gunstore Logs",
                                ["description"] = "",
                                ["text"] = "FNR Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
                                ["fields"] = {
                                    {
                                        ["name"] = "Player Name",
                                        ["value"] = GetPlayerName(source),
                                        ["inline"] = true
                                    },
                                    {
                                        ["name"] = "Player TempID",
                                        ["value"] = source,
                                        ["inline"] = true
                                    },
                                    {
                                        ["name"] = "Player PermID",
                                        ["value"] = user_id,
                                        ["inline"] = true
                                    },
                                    {
                                        ["name"] = "Item Name",
                                        ["value"] = "50% Armour",
                                        ["inline"] = true
                                    },
                                    {
                                        ["name"] = "Item Price",
                                        ["value"] = "£"..parseInt(finalprice),
                                        ["inline"] = true
                                    },
                                    {
                                        ["name"] = "Store Name",
                                        ["value"] = "Large Arms",
                                        ["inline"] = true
                                    }
                                }
                            }
                        }
                        local webhook = "https://discord.com/api/webhooks/1027271668541964378/5ib6k-f_SlEHtG3Px-odF_LSDSb0a1JqPGcUWcOOQRJXkniLjCQfjRkRlCuzDqYH4pv5"
                        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "FNR", embeds = command}), { ['Content-Type'] = 'application/json' }) 
                        
                        -- if finalID ~= nil then
                        --     vRP.giveBankMoney({vRP.getUserId({finalID}),finalCommision})
                        --     vRPclient.notify(finalID,{finalCommision})
                        -- end
                    else
                        vRPclient.notify(source, {"~r~Insufficient funds"})
                        TriggerClientEvent("FNR:PlaySound", source, 2)
                    end
                else
                    vRPclient.notify(source,{"~r~You already have 50% armour."})
                end
            else
                vRPclient.notify(source,{'~r~Not enough Weight.'})
                TriggerClientEvent("FNR:PlaySound", source, 2)
            end
        else
            vRPclient.notify(source,{"~r~You do not have Gang License 🤦‍♂️"})
        end

    
end)


RegisterNetEvent("LargeArms:BuyWeaponAmmo")
AddEventHandler("LargeArms:BuyWeaponAmmo", function(hash)
    local source = source
    local user_id = vRP.getUserId({source})

    if user_id ~= nil then
        if vRP.hasGroup({userid, "Gang"}) then
        for k, v in pairs(large.guns) do
             if v.hash == hash then
                if vRP.tryPayment({user_id, v.price / 2}) then
                    vRPclient.giveWeaponAmmo(source,{v.hash, 250})
                    vRPclient.notify(source, {"~g~Paid £"..tostring(getMoneyStringFormatted(v.price/2))})
                    TriggerClientEvent("FNR:PlaySound", source, 1)
                    local command = {
                        {
                            ["color"] = "3944703",
                            ["title"] = "FNR Gunstore Logs",
                            ["description"] = "",
                            ["text"] = "FNR Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
                            ["fields"] = {
                                {
                                    ["name"] = "Player Name",
                                    ["value"] = GetPlayerName(source),
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "Player TempID",
                                    ["value"] = source,
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "Player PermID",
                                    ["value"] = user_id,
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "Item Name",
                                    ["value"] = "250 Ammo ["..v.hash.."]",
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "Item Price",
                                    ["value"] = "£"..parseInt(finalprice),
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "Store Name",
                                    ["value"] = "Large Arms",
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "Whitelist",
                                    ["value"] = "false",
                                    ["inline"] = true
                                }
                            }
                        }
                    }
                    local webhook = "https://discord.com/api/webhooks/1027271668541964378/5ib6k-f_SlEHtG3Px-odF_LSDSb0a1JqPGcUWcOOQRJXkniLjCQfjRkRlCuzDqYH4pv5"
                    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "FNR", embeds = command}), { ['Content-Type'] = 'application/json' }) 
                else 
                    TriggerClientEvent("SmallArms:Error", source, false)
                    vRPclient.notify(source, {"~r~Insufficient funds"})
                    TriggerClientEvent("FNR:PlaySound", source, 2)
                     end
                 end
            end
        end
    end
end)

RegisterNetEvent("LargeArms:BuyWeaponAmmo2")
AddEventHandler("LargeArms:BuyWeaponAmmo2", function(hash)
    local source = source
    local user_id = vRP.getUserId({source})

    if user_id ~= nil then
        if vRP.hasGroup({userid, "Gang"}) then
            exports['ghmattimysql']:execute("SELECT * FROM `weapon_whitelists` WHERE permid = @permid", {permid = user_id}, function(result)
            for k,v in pairs(result) do
                if v.category == "large" then       
             if v.gunhash == hash then
                finalCommision = v.price * (commision / 100)
                if vRP.tryPayment({user_id, finalCommision + v.price / 2}) then
                    vRPclient.giveWeaponAmmo(source,{hash, 250})
                    vRPclient.notify(source, {"~g~Paid £"..tostring(getMoneyStringFormatted(finalCommision + v.price/2))})
                    TriggerClientEvent("FNR:PlaySound", source, 1)
                    local finalcom = tonumber(finalCommision + v.price/2)
                    local command = {
                        {
                            ["color"] = "3944703",
                            ["title"] = "FNR Gunstore Logs",
                            ["description"] = "",
                            ["text"] = "FNR Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
                            ["fields"] = {
                                {
                                    ["name"] = "Player Name",
                                    ["value"] = GetPlayerName(source),
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "Player TempID",
                                    ["value"] = source,
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "Player PermID",
                                    ["value"] = user_id,
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "Item Name",
                                    ["value"] = "250 Ammo ["..hash.."]",
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "Item Price",
                                    ["value"] = "£"..parseInt(finalcom),
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "Store Name",
                                    ["value"] = "Large Arms",
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "Whitelist",
                                    ["value"] = "true",
                                    ["inline"] = true
                                }
                            }
                        }
                    }
                    local webhook = "https://discord.com/api/webhooks/1027271668541964378/5ib6k-f_SlEHtG3Px-odF_LSDSb0a1JqPGcUWcOOQRJXkniLjCQfjRkRlCuzDqYH4pv5"
                    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "FNR", embeds = command}), { ['Content-Type'] = 'application/json' }) 
                else 
                    TriggerClientEvent("SmallArms:Error", source, false)
                    vRPclient.notify(source, {"~r~Insufficient funds"})
                    TriggerClientEvent("FNR:PlaySound", source, 2)
                            end
                        
                    end
                end
             end
        end)
    end
end
end)






Citizen.CreateThread(function()
    Wait(2500)
    exports['ghmattimysql']:execute([[
            CREATE TABLE IF NOT EXISTS `weapon_whitelists` (
                `permid` int(11) NOT NULL AUTO_INCREMENT,
                `name` VARCHAR(100) NOT NULL,
                `gunhash` VARCHAR(100) NOT NULL,
                `price` VARCHAR(100) NOT NULL,
                `category` VARCHAR(100) NOT NULL,
                `owner` tinyint(1) NOT NULL,
                PRIMARY KEY(permid,gunhash)
              );
        ]])
    print("Gun Whitelists initialised")
end)



RegisterServerEvent("largearms:PULLWHITELISTEDWEAPONS")
AddEventHandler("largearms:PULLWHITELISTEDWEAPONS", function()
    local source = source
    local table = {}
    local permid = vRP.getUserId({source})
    exports['ghmattimysql']:execute("SELECT * FROM `weapon_whitelists` WHERE permid = @permid", {permid = permid}, function(result)
        for k,v in pairs(result) do
           if v.permid == permid then 
              if v.category == "large" then   
                 table[k] = {name = v.name, gunhash = v.gunhash, price = v.price}
        end 
    end
end
end) 
Wait(10)
TriggerClientEvent("largearms:GUNSRETURNED", source,table)
end)