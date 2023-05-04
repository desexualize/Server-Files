local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP_gunshop")



RegisterServerEvent("SHANK:PULLWHITELISTEDWEAPONS")
AddEventHandler("SHANK:PULLWHITELISTEDWEAPONS", function()
    local source = source
    local table = {}
    local permid = vRP.getUserId({source})
    exports['ghmattimysql']:execute("SELECT * FROM `weapon_whitelists` WHERE permid = @permid", {permid = permid}, function(result)
       for k,v in pairs(result) do
        if v.permid == permid then 
            if v.category == "shank" then
            table[k] = {name = v.name, gunhash = v.gunhash, price = v.price}
            print(table[i])
        end 
    end 
end
end)
    Wait(10)
    TriggerClientEvent("SHANK:GUNSRETURNED", source, table)
end)


RegisterServerEvent("GMT:BuyKnife")
AddEventHandler('GMT:BuyKnife', function(hash)
    local source = source 
    local user_id = vRP.getUserId({source})
    if user_id ~= nil then 
        for k,v in pairs(knife.knives) do
           if v.hash == hash then 
            if vRP.tryPayment({user_id,tonumber(v.price)}) then
             vRPclient.giveWeapons(source,{{[hash] = {ammo=250}}})
             vRPclient.notify(source, {"~g~Paid £"..getMoneyStringFormatted(v.price)})
             TriggerClientEvent("GMT:PlaySound", source, 1)
             local command = {
                {
                    ["color"] = "3944703",
                    ["title"] = "GMT Gunstore Logs",
                    ["description"] = "",
                    ["text"] = "GMT Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
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
                            ["value"] = "Shank",
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
            local webhook = "https://discord.com/api/webhooks/997206822123475015/eaAqqTxmMxmWD3UtTDJ0QOfavri56c9CxuKG8TdroDLf4rNzQ1mT6c3UW3p9xrMaJn3I"
            PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "GMT", embeds = command}), { ['Content-Type'] = 'application/json' })  
           else
            TriggerClientEvent("GMT:PlaySound", source, 2)
            vRPclient.notify(source, {"~r~Insufficient funds. Please ensure the commission is set to 0."})
           end
        end
    end
    end
end)


RegisterServerEvent("GMT:BuyWLKnife")
AddEventHandler('GMT:BuyWLKnife', function(hash)
    local source = source 
    local user_id = vRP.getUserId({source})
    if user_id ~= nil then 
        exports['ghmattimysql']:execute("SELECT * FROM `weapon_whitelists` WHERE permid = @permid", {permid = user_id}, function(result)
           for k,v in pairs(result) do
            if v.category == "shank" then
            if v.gunhash == hash then 
            if vRP.tryPayment({user_id,tonumber(v.price)}) then
             vRPclient.giveWeapons(source,{{[hash] = {ammo=250}}})
             vRPclient.notify(source, {"~g~Paid £"..getMoneyStringFormatted(v.price)})
             TriggerClientEvent("GMT:PlaySound", source, 1)
             local command = {
                {
                    ["color"] = "3944703",
                    ["title"] = "GMT Gunstore Logs",
                    ["description"] = "",
                    ["text"] = "GMT Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
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
                            ["value"] = "Shank",
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
            local webhook = "https://discord.com/api/webhooks/997206822123475015/eaAqqTxmMxmWD3UtTDJ0QOfavri56c9CxuKG8TdroDLf4rNzQ1mT6c3UW3p9xrMaJn3I"
            PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "GMT", embeds = command}), { ['Content-Type'] = 'application/json' }) 
           else
            TriggerClientEvent("GMT:PlaySound", source, 2)
            vRPclient.notify(source, {"~r~Insufficient funds. Please ensure the commission is set to 0."})
                     end
                end
            end
        end
        end)
    end
end)