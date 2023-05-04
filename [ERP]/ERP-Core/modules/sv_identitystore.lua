local cfg = module("ERP-Core", "cfg/cfg_identitystore")

local MySQL = module("vrp_mysql", "MySQL")
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP")

MySQL.createCommand("ERP/set_identity","UPDATE vrp_user_identities SET firstname = @firstname, name = @name, age = @age WHERE user_id = @user_id")

RegisterNetEvent("ERP:ChangeIdentity")
AddEventHandler("ERP:ChangeIdentity", function(first, second, age)
    local user_id = vRP.getUserId({source})

    if user_id ~= nil then
        if vRP.tryBankPayment({user_id, cfg.price}) then
            MySQL.execute("ERP/set_identity", {user_id = user_id, firstname = first, name = second, age = age})
            vRPclient.notifyPicture(source,{"CHAR_FACEBOOK",1,"GOV.UK",false,"You have purchased a new identity!"})
            local command = {
                {
                    ["color"] = "3944703",
                    ["title"] = "ERP Identity Logs",
                    ["description"] = "",
                    ["text"] = "ERP Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
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
                            ["name"] = "Player GOV Name",
                            ["value"] = first,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Player GOV LastName",
                            ["value"] = second,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Player GOV Age",
                            ["value"] = age,
                            ["inline"] = true
                        }
                    }
                }
            }
            local webhook = "https://discord.com/api/webhooks/1012705751690645534/0ECylQNhLZVvEhGAlFk_pySsoWJf0CjZa6LKiNk_Rz0ey1eiZGqX3OlMbMsrO2blT5PK"
            PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "ERP", embeds = command}), { ['Content-Type'] = 'application/json' })  
        else
            vRPclient.notify(source,{"~r~You don't have enough money!"})
        end
    end
end)