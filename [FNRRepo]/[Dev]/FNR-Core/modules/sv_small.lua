local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP_gunshop")


function getMoneyStringFormatted(cashString)
	local i, j, minus, int, fraction = tostring(cashString):find('([-]?)(%d+)([.]?%d*)')
	int = int:reverse():gsub("(%d%d%d)", "%1,")
	return minus .. int:reverse():gsub("^,", "") .. fraction 
end

RegisterServerEvent("SMALLARMS:BuyWeapon")
AddEventHandler('SMALLARMS:BuyWeapon', function(hash)
    local source = source
    local user_id = vRP.getUserId({source})

    if user_id ~= nil then
            for k, v in pairs(smallarms.guns) do
                if v.hash == hash  then
                if vRP.tryPayment({user_id, v.price}) then
                    vRPclient.giveWeapons(source,{{[v.hash] = {ammo=250}}})
                    TriggerClientEvent("FNR:PlaySound", source, 1)
                    vRPclient.notify(source, {"~g~Paid £"..tostring(getMoneyStringFormatted(v.price))})
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
                                    ["value"] = "£"..parseInt(v.price),
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "Store Name",
                                    ["value"] = "Small Arms",
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
                    local webhook = "https://discord.com/api/webhooks/1027275371609075843/8tVnOCkfgfQCD4ZX95W3FCPu6h1-oq3KGcaMLcmRlKouM5A5nnN7sB-RNPssUIl5yawm"
                    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "FNR", embeds = command}), { ['Content-Type'] = 'application/json' }) 
                else 
                    vRPclient.notify(source, {"~r~Insufficient funds"})
                    TriggerClientEvent("FNR:PlaySound", source, 2)
                
                end
            end
        end
    end
end)


RegisterServerEvent("SMALLARMS:BuyWeapon2")
AddEventHandler('SMALLARMS:BuyWeapon2', function(hash)
    local source = source
    local user_id = vRP.getUserId({source})

    if user_id ~= nil then

        exports['ghmattimysql']:execute("SELECT * FROM `weapon_whitelists` WHERE permid = @permid", {permid = user_id}, function(result)
            for i,v in pairs(result) do
             if v.gunhash == hash then
                if v.category == "smallarms" then
            
                    --if vRP.tryPayment({user_id, v.price}) then
                        if vRP.tryPayment({user_id, tonumber(v.price)}) then
                        vRPclient.giveWeapons(source,{{[v.gunhash] = {ammo=250}}})
                        TriggerClientEvent("FNR:PlaySound", source, 1)
                        vRPclient.notify(source, {"~g~Paid £"..tostring(getMoneyStringFormatted(v.price))})
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
                                        ["value"] = "£"..parseInt(v.price),
                                        ["inline"] = true
                                    },
                                    {
                                        ["name"] = "Store Name",
                                        ["value"] = "Small Arms",
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
                        local webhook = "https://discord.com/api/webhooks/1027275371609075843/8tVnOCkfgfQCD4ZX95W3FCPu6h1-oq3KGcaMLcmRlKouM5A5nnN7sB-RNPssUIl5yawm"
                        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "FNR", embeds = command}), { ['Content-Type'] = 'application/json' }) 
                    else 
                        vRPclient.notify(source, {"~r~Insufficient funds"})
                        TriggerClientEvent("FNR:PlaySound", source, 2)
                
                    end
                end
            end
        end
    end)
    end
end)

RegisterNetEvent("SMALLARMS:BuyWeaponAmmo")
AddEventHandler("SMALLARMS:BuyWeaponAmmo", function(hash)
    local source = source
    local user_id = vRP.getUserId({source})

    if user_id ~= nil then
        for k, v in pairs(smallarms.guns) do
             if v.hash == hash then
                if vRP.tryPayment({user_id, v.price / 2}) then
                    vRPclient.giveWeaponAmmo(source,{v.hash, 250})
                    vRPclient.notify(source, {"~g~Paid £"..tostring(getMoneyStringFormatted(v.price/2))})
                    TriggerClientEvent("FNR:PlaySound", source, 1)
                    local someshit = tonumber(v.price/2)
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
                                    ["value"] = "£"..parseInt(someshit),
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "Store Name",
                                    ["value"] = "Small Arms",
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
                    local webhook = "https://discord.com/api/webhooks/1027275371609075843/8tVnOCkfgfQCD4ZX95W3FCPu6h1-oq3KGcaMLcmRlKouM5A5nnN7sB-RNPssUIl5yawm"
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

RegisterNetEvent("SMALLARMS:BuyWeaponAmmo2")
AddEventHandler("SMALLARMS:BuyWeaponAmmo2", function(hash)
    local source = source
    local user_id = vRP.getUserId({source})
    if user_id ~= nil then
        exports['ghmattimysql']:execute("SELECT * FROM `weapon_whitelists` WHERE permid = @permid", {permid = user_id}, function(result)
            for i,v in pairs(result) do
             if v.gunhash == hash then
                if v.category == "smallarms" then
                if vRP.tryPayment({user_id, tonumber(v.price / 2)}) then
                    vRPclient.giveWeaponAmmo(source,{v.gunhash, 250})
                    vRPclient.notify(source, {"~g~Paid £"..tostring(getMoneyStringFormatted(v.price/2))})
                    TriggerClientEvent("FNR:PlaySound", source, 1)
                    local someshit = tonumber(v.price/2)
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
                                    ["value"] = "£"..parseInt(someshit),
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "Store Name",
                                    ["value"] = "Small Arms",
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
                    local webhook = "https://discord.com/api/webhooks/1027275371609075843/8tVnOCkfgfQCD4ZX95W3FCPu6h1-oq3KGcaMLcmRlKouM5A5nnN7sB-RNPssUIl5yawm"
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
end)

RegisterServerEvent("SmallArms:BuyArmour")
AddEventHandler('SmallArms:BuyArmour', function()
    local source = source
    local user_id = vRP.getUserId({source})
    local currentArmour = GetPedArmour(GetPlayerPed(source))

    if user_id ~= nil then
        if currentArmour < 25 then
            if vRP.tryPayment({user_id, smallarms.armourprice}) then
                vRPclient.setArmour(source,{25})
                vRPclient.notify(source, {"~g~Paid £"..tostring(getMoneyStringFormatted(smallarms.armourprice))})
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
                                ["value"] = "25% Armour",
                                ["inline"] = true
                            },
                            {
                                ["name"] = "Item Price",
                                ["value"] = "£"..parseInt(smallarms.armourprice),
                                ["inline"] = true
                            },
                            {
                                ["name"] = "Store Name",
                                ["value"] = "Small Arms",
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
                local webhook = "https://discord.com/api/webhooks/1027275371609075843/8tVnOCkfgfQCD4ZX95W3FCPu6h1-oq3KGcaMLcmRlKouM5A5nnN7sB-RNPssUIl5yawm"
                PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "FNR", embeds = command}), { ['Content-Type'] = 'application/json' }) 
            else 
                TriggerClientEvent("SmallArms:Error", source, false)
                vRPclient.notify(source, {"~r~Insufficient funds"})
                TriggerClientEvent("FNR:PlaySound", source, 2)
            end
        else
            vRPclient.notify(source,{"~r~You already have 25% armour."})
        end
    end
end)



RegisterServerEvent("SMALL:PULLWHITELISTEDWEAPONS")
AddEventHandler("SMALL:PULLWHITELISTEDWEAPONS", function()
    local source = source
    local table = {}
    local user_id = vRP.getUserId({source})
    exports['ghmattimysql']:execute("SELECT * FROM `weapon_whitelists` WHERE permid = @permid", {permid = user_id}, function(result)
    for i,v in pairs(result) do
        if v.permid == user_id then 
            if v.category == "smallarms" then
       table[i] = {name = v.name, gunhash = v.gunhash, price = v.price}
        end 
    end
end
end)
Wait(1)
TriggerClientEvent("SMALL:GUNSRETURNED", source,table)
end)


