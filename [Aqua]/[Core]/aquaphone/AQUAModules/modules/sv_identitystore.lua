local cfg = module("AQUAModules", "cfg/cfg_identitystore")

local MySQL = module("aqua_mysql", "MySQL")
local Tunnel = module("AQUA", "lib/Tunnel")
local Proxy = module("AQUA", "lib/Proxy")
AQUA = Proxy.getInterface("AQUA")
AQUAclient = Tunnel.getInterface("AQUA","AQUA")

MySQL.createCommand("AQUA/set_identity","UPDATE aqua_user_identities SET firstname = @firstname, name = @name, age = @age WHERE user_id = @user_id")

RegisterNetEvent("AQUA:ChangeIdentity")
AddEventHandler("AQUA:ChangeIdentity", function(first, second, age)
    local user_id = AQUA.getUserId({source})

    if user_id ~= nil then
        if AQUA.tryBankPayment({user_id, cfg.price}) then
            MySQL.execute("AQUA/set_identity", {user_id = user_id, firstname = first, name = second, age = age})
            AQUAclient.notifyPicture(source,{"CHAR_FACEBOOK",1,"GOV.UK",false,"You have purchased a new identity!"})
            local command = {
                {
                    ["color"] = "3944703",
                    ["title"] = " Identity Logs",
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
            local webhook = "https://discord.com/api/webhooks/1059083136560025650/Dt0s7Ub2RmDjfgpvPNf2zMxbg_hukGXzA7SAdlHxGT40J2kuFVp3N9ejqLS21S2i9u9D"
            PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "AQUA", embeds = command}), { ['Content-Type'] = 'application/json' })  
        else
            AQUAclient.notify(source,{"~d~You don't have enough money!"})
        end
    end
end)