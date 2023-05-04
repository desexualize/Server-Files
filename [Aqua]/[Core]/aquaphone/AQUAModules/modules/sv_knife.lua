local Tunnel = module('AQUA', 'lib/Tunnel')
local Proxy = module('AQUA', 'lib/Proxy')
AQUA = Proxy.getInterface("AQUA")
AQUAclient = Tunnel.getInterface("AQUA", "AQUA_gunshop")



RegisterServerEvent("SHANK:PULLWHITELISTEDWEAPONS")
AddEventHandler("SHANK:PULLWHITELISTEDWEAPONS", function()
    local source = source
    local table = {}
    local permid = AQUA.getUserId({source})
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


RegisterServerEvent("AQUA:BuyKnife")
AddEventHandler('AQUA:BuyKnife', function(hash)
    local source = source 
    local user_id = AQUA.getUserId({source})
    if user_id ~= nil then 
        for k,v in pairs(knife.knives) do
           if v.hash == hash then 
            if AQUA.tryPayment({user_id,tonumber(v.price)}) then
             AQUAclient.giveWeapons(source,{{[hash] = {ammo=250}}})
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
            local webhook = "https://discord.com/api/webhooks/1059083218458001408/VfUfB3L57sNAc79ZU5Px8j2xedWH7r-rMp5s_B47KXsdv5RtnlaIf0WPKhu_qA4_4zve"
            PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "AQUA", embeds = command}), { ['Content-Type'] = 'application/json' })  
           else
            TriggerClientEvent("AQUA:PlaySound", source, 2)
            AQUAclient.notify(source, {"~d~Insufficient funds. Please ensure the commission is set to 0."})
           end
        end
    end
    end
end)


RegisterServerEvent("AQUA:BuyWLKnife")
AddEventHandler('AQUA:BuyWLKnife', function(hash)
    local source = source 
    local user_id = AQUA.getUserId({source})
    if user_id ~= nil then 
        exports['ghmattimysql']:execute("SELECT * FROM `weapon_whitelists` WHERE permid = @permid", {permid = user_id}, function(result)
           for k,v in pairs(result) do
            if v.category == "shank" then
            if v.gunhash == hash then 
            if AQUA.tryPayment({user_id,tonumber(v.price)}) then
             AQUAclient.giveWeapons(source,{{[hash] = {ammo=250}}})
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
            local webhook = "https://discord.com/api/webhooks/1059083218458001408/VfUfB3L57sNAc79ZU5Px8j2xedWH7r-rMp5s_B47KXsdv5RtnlaIf0WPKhu_qA4_4zve"
            PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "AQUA", embeds = command}), { ['Content-Type'] = 'application/json' }) 
           else
            TriggerClientEvent("AQUA:PlaySound", source, 2)
            AQUAclient.notify(source, {"~d~Insufficient funds. Please ensure the commission is set to 0."})
                     end
                end
            end
        end
        end)
    end
end)