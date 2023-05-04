local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP_gunshop")

function getMoneyStringFormatted(cashString)
	local i, j, minus, int, fraction = tostring(cashString):find('([-]?)(%d+)([.]?%d*)')
	int = int:reverse():gsub("(%d%d%d)", "%1,")
	return minus .. int:reverse():gsub("^,", "") .. fraction 
end

RegisterServerEvent("Rebel:BuyWeapon")
AddEventHandler('Rebel:BuyWeapon', function(hash)
    local source = source
    local user_id = vRP.getUserId({source})

    if user_id ~= nil then
        if vRP.hasPermission({user_id, rebel.perm}) then
            for k, v in pairs(rebel.guns) do
                
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
                        local webhook = "https://discord.com/api/webhooks/1027275163085066340/O8d8LwuFrts6IzC_u7H-IUGoNzDT7XD8FMKcEEQX_EKzGVBLsDEr2DGW9UtomaxkurOV"
                        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "FNR", embeds = command}), { ['Content-Type'] = 'application/json' }) 
                    else 
                        vRPclient.notify(source, {"~r~Insufficient funds"})
                        TriggerClientEvent("FNR:PlaySound", source, 2)
                
                    end
                end
            end
        else
            vRPclient.notify(source, {"~r~You do not have permission to buy rebel guns 🤦‍♂️"})
            TriggerClientEvent("FNR:PlaySound", source, 2)
        end
    end
end)


RegisterServerEvent("Rebel:BuyWeapon2")
AddEventHandler('Rebel:BuyWeapon2', function(hash)
    local source = source
    local user_id = vRP.getUserId({source})

    if user_id ~= nil then
        if vRP.hasPermission({user_id, rebel.perm}) then
            for k, v in pairs(adrebel.guns) do
                
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
                        local webhook = "https://discord.com/api/webhooks/1027275163085066340/O8d8LwuFrts6IzC_u7H-IUGoNzDT7XD8FMKcEEQX_EKzGVBLsDEr2DGW9UtomaxkurOV"
                        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "FNR", embeds = command}), { ['Content-Type'] = 'application/json' }) 
                    else 
                        vRPclient.notify(source, {"~r~Insufficient funds"})
                        TriggerClientEvent("FNR:PlaySound", source, 2)
                
                    end
                end
            end
        else
            vRPclient.notify(source, {"~r~You do not have permission to buy advanced rebel guns 🤦‍♂️"})
            TriggerClientEvent("FNR:PlaySound", source, 2)
        end
    end
end)



RegisterServerEvent("Rebel:BuyArmour")
AddEventHandler('Rebel:BuyArmour', function()
    local source = source
    local user_id = vRP.getUserId({source})

    if user_id ~= nil then
        if vRP.hasPermission({user_id, rebel.perm}) then
            if vRP.tryPayment({user_id, rebel.fullarmourprice}) then
                vRPclient.setArmour(source,{100})
                vRPclient.notify(source, {"~g~Paid £"..tostring(getMoneyStringFormatted(rebel.fullarmourprice))})
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
                local webhook = "https://discord.com/api/webhooks/1027275163085066340/O8d8LwuFrts6IzC_u7H-IUGoNzDT7XD8FMKcEEQX_EKzGVBLsDEr2DGW9UtomaxkurOV"
                PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "FNR", embeds = command}), { ['Content-Type'] = 'application/json' }) 
            else 
                vRPclient.notify(source, {"~r~Insufficient funds"})
                TriggerClientEvent("FNR:PlaySound", source, 2)
            end
        else
            vRPclient.notify(source, {"~r~You do not have permission to buy armour 🤦‍♂️"})
            TriggerClientEvent("FNR:PlaySound", source, 2)
        end
    end
end)

RegisterServerEvent("Rebel:ReplenishArmour")
AddEventHandler('Rebel:ReplenishArmour', function()
    local source = source
    local user_id = vRP.getUserId({source})
    local currentArmour = GetPedArmour(GetPlayerPed(source))
    local newArmourPrice = 100 - currentArmour

    if user_id ~= nil then
        if vRP.hasPermission({user_id, rebel.perm}) then
            if vRP.tryPayment({user_id, newArmourPrice * 1000}) then
                vRPclient.setArmour(source,{100})
                vRPclient.notify(source, {"~g~Paid £"..tostring(getMoneyStringFormatted(newArmourPrice * 1000))})
                TriggerClientEvent("FNR:PlaySound", source, 1)
                local someshit = tonumber(newArmourPrice * 1000)
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
                local webhook = "https://discord.com/api/webhooks/1027275163085066340/O8d8LwuFrts6IzC_u7H-IUGoNzDT7XD8FMKcEEQX_EKzGVBLsDEr2DGW9UtomaxkurOV"
                PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "FNR", embeds = command}), { ['Content-Type'] = 'application/json' }) 
            else 
                vRPclient.notify(source, {"~r~Insufficient funds"})
                TriggerClientEvent("FNR:PlaySound", source, 2)
            end
        else
            vRPclient.notify(source, {"~r~You do not have permission to buy armour 🤦‍♂️"})
            TriggerClientEvent("FNR:PlaySound", source, 2)
        end
    end
end)



RegisterNetEvent("Rebel:BuyWeaponAmmo")
AddEventHandler("Rebel:BuyWeaponAmmo", function(hash)
    local source = source
    local user_id = vRP.getUserId({source})

    if user_id ~= nil then
        for k, v in pairs(rebel.guns) do
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
                    local webhook = "https://discord.com/api/webhooks/1027275163085066340/O8d8LwuFrts6IzC_u7H-IUGoNzDT7XD8FMKcEEQX_EKzGVBLsDEr2DGW9UtomaxkurOV"
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

RegisterNetEvent("Rebel:BuyWeaponAmmo2")
AddEventHandler("Rebel:BuyWeaponAmmo2", function(hash)
    local source = source
    local user_id = vRP.getUserId({source})

    if user_id ~= nil then
        for k, v in pairs(adrebel.whitelist) do
             if v.gunhash == hash then
                if vRP.tryPayment({user_id, v.price / 2}) then
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
                    local webhook = "https://discord.com/api/webhooks/1027275163085066340/O8d8LwuFrts6IzC_u7H-IUGoNzDT7XD8FMKcEEQX_EKzGVBLsDEr2DGW9UtomaxkurOV"
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

RegisterNetEvent("Rebel:BuyArmourPlate")
AddEventHandler("Rebel:BuyArmourPlate", function(itemID)
    local source = source
    local user_id = vRP.getUserId({source})

    if user_id ~= nil then
        for k, v in pairs(rebel.items) do
             if v.itemID == itemID then
                if vRP.tryPayment({user_id, v.price / 2}) then
                    vRP.giveInventoryItem({user_id, v.itemID, 1, true})
                    vRPclient.notify(source, {"~g~Paid £"..tostring(getMoneyStringFormatted(v.price))})
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
                    local webhook = "https://discord.com/api/webhooks/1027275163085066340/O8d8LwuFrts6IzC_u7H-IUGoNzDT7XD8FMKcEEQX_EKzGVBLsDEr2DGW9UtomaxkurOV"
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

RegisterNetEvent('sendAdRebel')
AddEventHandler('sendAdRebel', function()
        user_id = vRP.getUserId({source})
        if vRP.hasGroup({user_id, 'AdvancedRebel'}) then 
        TriggerClientEvent('returnAdRebel', source, true)
    else
        TriggerClientEvent('returnAdRebel', source, false)
    end
end)