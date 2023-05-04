local Tunnel = module('AQUA', 'lib/Tunnel')
local Proxy = module('AQUA', 'lib/Proxy')
AQUA = Proxy.getInterface("AQUA")
AQUAclient = Tunnel.getInterface("AQUA", "AQUA_gunshop")

function getMoneyStringFormatted(cashString)
	local i, j, minus, int, fraction = tostring(cashString):find('([-]?)(%d+)([.]?%d*)')
	int = int:reverse():gsub("(%d%d%d)", "%1,")
	return minus .. int:reverse():gsub("^,", "") .. fraction 
end

RegisterServerEvent("Rebel:BuyWeapon")
AddEventHandler('Rebel:BuyWeapon', function(hash)
    local source = source
    local user_id = AQUA.getUserId({source})

    if user_id ~= nil then
        if AQUA.hasPermission({user_id, rebel.perm}) then
            for k, v in pairs(rebel.guns) do
                
                if v.hash == hash  then
                    if AQUA.tryPayment({user_id, v.price}) then
                        AQUAclient.giveWeapons(source,{{[v.hash] = {ammo=250}}})
                        TriggerClientEvent("AQUA:PlaySound", source, 1)
                        AQUAclient.notify(source, {"~g~Paid £"..tostring(getMoneyStringFormatted(v.price))})
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
                                        ["value"] = "£"..parseInt(v.price),
                                        ["inline"] = true
                                    },
                                    {
                                        ["name"] = "Store Name",
                                        ["value"] = "Rebel",
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
                        local webhook = "https://discord.com/api/webhooks/1059084196745859092/fRhicBrRDD1uKLPn1psqZhVqHce_MQkNJPZZR6ss6UcXrNAJmylRkXem9dm60oIkwBN9"
                        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "AQUA", embeds = command}), { ['Content-Type'] = 'application/json' }) 
                    else 
                        AQUAclient.notify(source, {"~d~Insufficient funds"})
                        TriggerClientEvent("AQUA:PlaySound", source, 2)
                
                    end
                end
            end
        else
            AQUAclient.notify(source, {"~d~You do not have permission to buy rebel guns 🤦‍♂️"})
            TriggerClientEvent("AQUA:PlaySound", source, 2)
        end
    end
end)


RegisterServerEvent("Rebel:BuyWeapon2")
AddEventHandler('Rebel:BuyWeapon2', function(hash)
    local source = source
    local user_id = AQUA.getUserId({source})

    if user_id ~= nil then
        if AQUA.hasPermission({user_id, rebel.perm}) then
            for k, v in pairs(adrebel.guns) do
                
                if v.hash == hash  then
                    if AQUA.tryPayment({user_id, v.price}) then
                        AQUAclient.giveWeapons(source,{{[v.hash] = {ammo=250}}})
                        TriggerClientEvent("AQUA:PlaySound", source, 1)
                        AQUAclient.notify(source, {"~g~Paid £"..tostring(getMoneyStringFormatted(v.price))})
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
                                        ["value"] = "£"..parseInt(v.price),
                                        ["inline"] = true
                                    },
                                    {
                                        ["name"] = "Store Name",
                                        ["value"] = "Rebel",
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
                        local webhook = "https://discord.com/api/webhooks/1059084196745859092/fRhicBrRDD1uKLPn1psqZhVqHce_MQkNJPZZR6ss6UcXrNAJmylRkXem9dm60oIkwBN9"
                        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "AQUA", embeds = command}), { ['Content-Type'] = 'application/json' }) 
                    else 
                        AQUAclient.notify(source, {"~d~Insufficient funds"})
                        TriggerClientEvent("AQUA:PlaySound", source, 2)
                
                    end
                end
            end
        else
            AQUAclient.notify(source, {"~d~You do not have permission to buy advanced rebel guns 🤦‍♂️"})
            TriggerClientEvent("AQUA:PlaySound", source, 2)
        end
    end
end)



RegisterServerEvent("Rebel:BuyArmour")
AddEventHandler('Rebel:BuyArmour', function()
    local source = source
    local user_id = AQUA.getUserId({source})

    if user_id ~= nil then
        if AQUA.hasPermission({user_id, rebel.perm}) then
            if AQUA.tryPayment({user_id, rebel.fullarmourprice}) then
                AQUAclient.setArmour(source,{100})
                AQUAclient.notify(source, {"~g~Paid £"..tostring(getMoneyStringFormatted(rebel.fullarmourprice))})
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
                                ["value"] = "100% Armour",
                                ["inline"] = true
                            },
                            {
                                ["name"] = "Item Price",
                                ["value"] = "£"..parseInt(rebel.fullarmourprice),
                                ["inline"] = true
                            },
                            {
                                ["name"] = "Store Name",
                                ["value"] = "Rebel",
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
                local webhook = "https://discord.com/api/webhooks/1059084196745859092/fRhicBrRDD1uKLPn1psqZhVqHce_MQkNJPZZR6ss6UcXrNAJmylRkXem9dm60oIkwBN9"
                PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "AQUA", embeds = command}), { ['Content-Type'] = 'application/json' }) 
            else 
                AQUAclient.notify(source, {"~d~Insufficient funds"})
                TriggerClientEvent("AQUA:PlaySound", source, 2)
            end
        else
            AQUAclient.notify(source, {"~d~You do not have permission to buy armour 🤦‍♂️"})
            TriggerClientEvent("AQUA:PlaySound", source, 2)
        end
    end
end)

RegisterServerEvent("Rebel:ReplenishArmour")
AddEventHandler('Rebel:ReplenishArmour', function()
    local source = source
    local user_id = AQUA.getUserId({source})
    local currentArmour = GetPedArmour(GetPlayerPed(source))
    local newArmourPrice = 100 - currentArmour

    if user_id ~= nil then
        if AQUA.hasPermission({user_id, rebel.perm}) then
            if AQUA.tryPayment({user_id, newArmourPrice * 1000}) then
                AQUAclient.setArmour(source,{100})
                AQUAclient.notify(source, {"~g~Paid £"..tostring(getMoneyStringFormatted(newArmourPrice * 1000))})
                TriggerClientEvent("AQUA:PlaySound", source, 1)
                local someshit = tonumber(newArmourPrice * 1000)
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
                                ["value"] = "Replenish Armour",
                                ["inline"] = true
                            },
                            {
                                ["name"] = "Item Price",
                                ["value"] = "£"..parseInt(someshit),
                                ["inline"] = true
                            },
                            {
                                ["name"] = "Store Name",
                                ["value"] = "Rebel",
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
                local webhook = "https://discord.com/api/webhooks/1059084196745859092/fRhicBrRDD1uKLPn1psqZhVqHce_MQkNJPZZR6ss6UcXrNAJmylRkXem9dm60oIkwBN9"
                PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "AQUA", embeds = command}), { ['Content-Type'] = 'application/json' }) 
            else 
                AQUAclient.notify(source, {"~d~Insufficient funds"})
                TriggerClientEvent("AQUA:PlaySound", source, 2)
            end
        else
            AQUAclient.notify(source, {"~d~You do not have permission to buy armour 🤦‍♂️"})
            TriggerClientEvent("AQUA:PlaySound", source, 2)
        end
    end
end)



RegisterNetEvent("Rebel:BuyWeaponAmmo")
AddEventHandler("Rebel:BuyWeaponAmmo", function(hash)
    local source = source
    local user_id = AQUA.getUserId({source})

    if user_id ~= nil then
        for k, v in pairs(rebel.guns) do
             if v.hash == hash then
                if AQUA.tryPayment({user_id, v.price / 2}) then
                    AQUAclient.giveWeaponAmmo(source,{v.hash, 250})
                    AQUAclient.notify(source, {"~g~Paid £"..tostring(getMoneyStringFormatted(v.price/2))})
                    TriggerClientEvent("AQUA:PlaySound", source, 1)
                    local someshit = tonumber(v.price/2)
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
                                    ["value"] = "£"..parseInt(someshit),
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "Store Name",
                                    ["value"] = "Rebel",
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
                    local webhook = "https://discord.com/api/webhooks/1059084196745859092/fRhicBrRDD1uKLPn1psqZhVqHce_MQkNJPZZR6ss6UcXrNAJmylRkXem9dm60oIkwBN9"
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

RegisterNetEvent("Rebel:BuyWeaponAmmo2")
AddEventHandler("Rebel:BuyWeaponAmmo2", function(hash)
    local source = source
    local user_id = AQUA.getUserId({source})

    if user_id ~= nil then
        for k, v in pairs(adrebel.whitelist) do
             if v.gunhash == hash then
                if AQUA.tryPayment({user_id, v.price / 2}) then
                    AQUAclient.giveWeaponAmmo(source,{v.gunhash, 250})
                    AQUAclient.notify(source, {"~g~Paid £"..tostring(getMoneyStringFormatted(v.price/2))})
                    TriggerClientEvent("AQUA:PlaySound", source, 1)
                    local someshit = tonumber(v.price/2)
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
                                    ["value"] = "£"..parseInt(someshit),
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "Store Name",
                                    ["value"] = "Rebel",
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
                    local webhook = "https://discord.com/api/webhooks/1059084196745859092/fRhicBrRDD1uKLPn1psqZhVqHce_MQkNJPZZR6ss6UcXrNAJmylRkXem9dm60oIkwBN9"
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

RegisterNetEvent("Rebel:BuyArmourPlate")
AddEventHandler("Rebel:BuyArmourPlate", function(itemID)
    local source = source
    local user_id = AQUA.getUserId({source})

    if user_id ~= nil then
        for k, v in pairs(rebel.items) do
             if v.itemID == itemID then
                if AQUA.tryPayment({user_id, v.price / 2}) then
                    AQUA.giveInventoryItem({user_id, v.itemID, 1, true})
                    AQUAclient.notify(source, {"~g~Paid £"..tostring(getMoneyStringFormatted(v.price))})
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
                                    ["value"] = itemID,
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "Item Price",
                                    ["value"] = "£"..parseInt(v.price),
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "Store Name",
                                    ["value"] = "Rebel",
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
                    local webhook = "https://discord.com/api/webhooks/1059084196745859092/fRhicBrRDD1uKLPn1psqZhVqHce_MQkNJPZZR6ss6UcXrNAJmylRkXem9dm60oIkwBN9"
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

RegisterNetEvent('sendAdRebel')
AddEventHandler('sendAdRebel', function()
        user_id = AQUA.getUserId({source})
        if AQUA.hasGroup({user_id, 'AdvancedRebel'}) then 
        TriggerClientEvent('returnAdRebel', source, true)
    else
        TriggerClientEvent('returnAdRebel', source, false)
    end
end)