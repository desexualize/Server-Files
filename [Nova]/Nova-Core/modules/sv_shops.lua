local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "ShopBuy")

RegisterServerEvent("Nova:ShopBuy2")
AddEventHandler(
    "Nova:ShopBuy2",
    function(price, hash)
        local source = source
        userid = vRP.getUserId({source})
        local ped = GetPlayerPed(source)
        local playerCoords = GetEntityCoords(ped)

        local coords = vec3(-2163.0864257812, 5176.9965820312, 14.737954139709)

        -- if #(playerCoords - coords) <= 5.0 then
        if vRP.getInventoryWeight({userid}) <= 25 then
            if vRP.tryPayment({userid, 50000}) then
                vRP.giveInventoryItem({userid, hash, 1, true})

                webhook =
                    "https://discord.com/api/webhooks/1012750574581710979/TMSZB9ixWv7puLJErFCYjVKmR15BvrNQRx3afToZDaffrmNIDmmdX5FQSsvuqNTeacwX"
                PerformHttpRequest(
                    webhook,
                    function(err, text, headers)
                    end,
                    "POST",
                    json.encode(
                        {
                            embeds = {
                                {
                                    ["color"] = "15158332",
                                    ["title"] = "",
                                    ["description"] = "Name: **" ..
                                        GetPlayerName(source) ..
                                            "** \nUser ID: **" ..
                                                userid ..
                                                    "** \nBought Item: **" ..
                                                        hash .. "**\nPrice: **£" .. "50,000" .. "**",
                                    ["footer"] = {
                                        ["text"] = "Time - " .. os.date("%x %X %p")
                                    }
                                }
                            }
                        }
                    ),
                    {["Content-Type"] = "application/json"}
                )

                TriggerClientEvent("Nova:PlaySound", source, 1)
                vRPclient.notify(source, {"~g~Purchased Item. Paid £50,000!"})
            else
                vRPclient.notify(source, {"~r~You do not have enough Money!"})
                TriggerClientEvent("Nova:PlaySound", source, 2)
            end
        else
            vRPclient.notify(source, {"~r~Not enough Weight."})
            TriggerClientEvent("Nova:PlaySound", source, 2)
        end
        -- else
        --     vRP.banConsole({userid,"perm","Cheating/ Triggering Events"})
        -- end
    end
)
