local Tunnel = module('AQUA', 'lib/Tunnel')
local Proxy = module('AQUA', 'lib/Proxy')
AQUA = Proxy.getInterface("AQUA")
AQUAclient = Tunnel.getInterface("AQUA", "AQUA_gunshop")

local commision = 10
local finalID = nil


RegisterServerEvent("AQUA:BuyGun")
AddEventHandler('AQUA:BuyGun', function(hash)
    local source = source
    local user_id = AQUA.getUserId({source})
    if user_id ~= nil then
        if AQUA.hasGroup({user_id, "Gang"}) then
            for k, v in pairs(large.guns) do
                finalCommision = v.price * (commision / 100)
                if v.hash == hash then
                    if AQUA.tryPayment({user_id, v.price + finalCommision}) then
                        local finalprice = tonumber(v.price + finalCommision)
                        AQUAclient.giveWeapons(source,{{[v.hash] = {ammo=250}}})
                        AQUAclient.notify(source, {"~g~Paid £"..getMoneyStringFormatted(v.price)})
                        TriggerClientEvent("AQUA:PlaySound", source, 1)
                        local command = {
                            {
                                ["color"] = "3944703",
                                ["title"] = " Gunstore Logs",
                                ["description"] = "",
                                ["text"] = " Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
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
                        local webhook = "https://discord.com/api/webhooks/1059083317183524885/Xhlktq6Y1adBiXHWNlyhAaqrAGzKW0ubvCGmtexFTuU2B9tTmKJldVoFwubxZnD1J2hi"
                        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "AQUA", embeds = command}), { ['Content-Type'] = 'application/json' }) 
                    else 
                        TriggerClientEvent("AQUA:PlaySound", source, 2)
                        AQUAclient.notify(source, {"~d~Insufficient funds. Please ensure the commission is set to 0."})


                    end

                --     if finalID ~= nil then 
                --     AQUA.giveBankMoney({AQUA.getUserId({finalID}),finalCommision}) 
                --     print(finalCommision)
                --     AQUAclient.notify(finalID,{"~g~You have been given ~w~£" .. finalCommision.. "~g~."})
                --  end
                end
            end
        else
            AQUAclient.notify(source, {"~d~You do not have permission to purchase guns from here"})
            TriggerClientEvent("AQUA:PlaySound", source, 2)
        end
    end
end)


RegisterServerEvent("LargeArms:BuyWLGun")
AddEventHandler('LargeArms:BuyWLGun', function(hash)
    local source = source 
    local user_id = AQUA.getUserId({source})
    if user_id ~= nil then 
        if AQUA.hasGroup({user_id, "Gang"}) then
            exports['ghmattimysql']:execute("SELECT * FROM `weapon_whitelists` WHERE permid = @permid", {permid = user_id}, function(result)
                for k,v in pairs(result) do
        if v.category == "large" then
           if v.gunhash == hash then 
             finalCommision = v.price * (commision / 100)
                if AQUA.tryPayment({user_id, tonumber(finalCommision + v.price)}) then
                    local finalprice = tonumber(v.price + finalCommision)
                    AQUAclient.giveWeapons(source,{{[hash] = {ammo=250}}})
                    AQUAclient.notify(source, {"~g~Paid £"..getMoneyStringFormatted(v.price + finalCommision)})
                    TriggerClientEvent("AQUA:PlaySound", source, 1)
                    local command = {
                        {
                            ["color"] = "3944703",
                            ["title"] = " Gunstore Logs",
                            ["description"] = "",
                            ["text"] = " Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
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
                    local webhook = "https://discord.com/api/webhooks/1059083317183524885/Xhlktq6Y1adBiXHWNlyhAaqrAGzKW0ubvCGmtexFTuU2B9tTmKJldVoFwubxZnD1J2hi"
                    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "AQUA", embeds = command}), { ['Content-Type'] = 'application/json' }) 
                else
                    TriggerClientEvent("AQUA:PlaySound", source, 2)
                    AQUAclient.notify(source, {"~d~Insufficient funds. Please ensure the commission is set to 0."})
                end
                -- if finalID ~= nil then 
                --     AQUA.giveBankMoney({AQUA.getUserId({finalID}),finalCommision}) 
                --     AQUAclient.notify(finalID,{"~g~You have been given ~w~£" .. finalCommision.. "~g~."})

                -- end
              end
            end
            end
           end)
        else 
            AQUAclient.notify(source, {"~d~You do not have permission to purchase guns from here 🤦‍♂️"})
            TriggerClientEvent("AQUA:PlaySound", source, 2)
        end
    end
end)



function sendCom(som, userid2)
    commision = som 
    finalID = userid2
    TriggerClientEvent("currentTurf", -1, som)
    TriggerClientEvent('Large:SendCommision', source, som)
end

RegisterServerEvent("AQUA:BuyArmour")
AddEventHandler('AQUA:BuyArmour', function(price, amount)
    local source = source
    userid = AQUA.getUserId({source})
    finalCommision = price * (commision / 100)
    local currentArmour = GetPedArmour(GetPlayerPed(source))

    expectedPrice = amount*1000
    if not price == expectedPrice then return end
        if AQUA.hasGroup({userid, "Gang"}) then
            if AQUA.getInventoryWeight({userid}) <= 25 then
                if currentArmour < 50 then
                   -- if AQUA.tryPayment({userid,price + finalCommision/2}) then       
                        if AQUA.tryPayment({userid,0}) then     
                        AQUAclient.setArmour(source,{50})
                        TriggerClientEvent("AQUA:PlaySound", source, 1)
                        AQUAclient.notify(source, {"~g~Paid "..large.currency..tostring(getMoneyStringFormatted(price + finalCommision))})
                        local finalprice = tonumber(price + finalCommision)
                        local command = {
                            {
                                ["color"] = "3944703",
                                ["title"] = " Gunstore Logs",
                                ["description"] = "",
                                ["text"] = " Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
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
                        local webhook = "https://discord.com/api/webhooks/1059083317183524885/Xhlktq6Y1adBiXHWNlyhAaqrAGzKW0ubvCGmtexFTuU2B9tTmKJldVoFwubxZnD1J2hi"
                        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "AQUA", embeds = command}), { ['Content-Type'] = 'application/json' }) 
                        
                        -- if finalID ~= nil then
                        --     AQUA.giveBankMoney({AQUA.getUserId({finalID}),finalCommision})
                        --     AQUAclient.notify(finalID,{finalCommision})
                        -- end
                    else
                        AQUAclient.notify(source, {"~d~Insufficient funds"})
                        TriggerClientEvent("AQUA:PlaySound", source, 2)
                    end
                else
                    AQUAclient.notify(source,{"~d~You already have 50% armour."})
                end
            else
                AQUAclient.notify(source,{'~d~Not enough Weight.'})
                TriggerClientEvent("AQUA:PlaySound", source, 2)
            end
        else
            AQUAclient.notify(source,{"~d~You do not have Gang License 🤦‍♂️"})
        end

    
end)


RegisterNetEvent("LargeArms:BuyWeaponAmmo")
AddEventHandler("LargeArms:BuyWeaponAmmo", function(hash)
    local source = source
    local user_id = AQUA.getUserId({source})

    if user_id ~= nil then
        if AQUA.hasGroup({userid, "Gang"}) then
        for k, v in pairs(large.guns) do
             if v.hash == hash then
                if AQUA.tryPayment({user_id, v.price / 2}) then
                    AQUAclient.giveWeaponAmmo(source,{v.hash, 250})
                    AQUAclient.notify(source, {"~g~Paid £"..tostring(getMoneyStringFormatted(v.price/2))})
                    TriggerClientEvent("AQUA:PlaySound", source, 1)
                    local command = {
                        {
                            ["color"] = "3944703",
                            ["title"] = " Gunstore Logs",
                            ["description"] = "",
                            ["text"] = " Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
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
                    local webhook = "https://discord.com/api/webhooks/1059083317183524885/Xhlktq6Y1adBiXHWNlyhAaqrAGzKW0ubvCGmtexFTuU2B9tTmKJldVoFwubxZnD1J2hi"
                    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "AQUA", embeds = command}), { ['Content-Type'] = 'application/json' }) 
                else 
                    TriggerClientEvent("SmallArms:Error", source, false)
                    AQUAclient.notify(source, {"~d~Insufficient funds"})
                    TriggerClientEvent("AQUA:PlaySound", source, 2)
                     end
                 end
            end
        end
    end
end)

RegisterNetEvent("LargeArms:BuyWeaponAmmo2")
AddEventHandler("LargeArms:BuyWeaponAmmo2", function(hash)
    local source = source
    local user_id = AQUA.getUserId({source})

    if user_id ~= nil then
        if AQUA.hasGroup({userid, "Gang"}) then
            exports['ghmattimysql']:execute("SELECT * FROM `weapon_whitelists` WHERE permid = @permid", {permid = user_id}, function(result)
            for k,v in pairs(result) do
                if v.category == "large" then       
             if v.gunhash == hash then
                finalCommision = v.price * (commision / 100)
                if AQUA.tryPayment({user_id, finalCommision + v.price / 2}) then
                    AQUAclient.giveWeaponAmmo(source,{hash, 250})
                    AQUAclient.notify(source, {"~g~Paid £"..tostring(getMoneyStringFormatted(finalCommision + v.price/2))})
                    TriggerClientEvent("AQUA:PlaySound", source, 1)
                    local finalcom = tonumber(finalCommision + v.price/2)
                    local command = {
                        {
                            ["color"] = "3944703",
                            ["title"] = " Gunstore Logs",
                            ["description"] = "",
                            ["text"] = " Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
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
                    local webhook = "https://discord.com/api/webhooks/1059083317183524885/Xhlktq6Y1adBiXHWNlyhAaqrAGzKW0ubvCGmtexFTuU2B9tTmKJldVoFwubxZnD1J2hi"
                    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "AQUA", embeds = command}), { ['Content-Type'] = 'application/json' }) 
                else 
                    TriggerClientEvent("SmallArms:Error", source, false)
                    AQUAclient.notify(source, {"~d~Insufficient funds"})
                    TriggerClientEvent("AQUA:PlaySound", source, 2)
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
    local permid = AQUA.getUserId({source})
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