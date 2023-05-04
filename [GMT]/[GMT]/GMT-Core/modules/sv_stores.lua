local cfg = module("GMT-Core", "cfg/cfg_stores")

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP")

RegisterNetEvent("GMT:BuyShopItem")
AddEventHandler("GMT:BuyShopItem", function(itemID, amount)
    local user_id = vRP.getUserId({source})

    if user_id ~= nil then
        for k, v in pairs(cfg.items) do
            if itemID == v.itemID then
                if vRP.tryPayment({user_id, v.price * amount}) then
                    vRP.giveInventoryItem({user_id, v.itemID, amount, true})
                    vRPclient.playFrontendSound(source,{"Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS"})
                    local command = {
                        {
                            ["color"] = "3944703",
                            ["title"] = "GMT Store Logs",
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
                                    ["value"] = v.itemID,
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "Item Price",
                                    ["value"] = "£"..parseInt(someshit),
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "Item Amount",
                                    ["value"] = parseInt(amount),
                                    ["inline"] = true
                                }
                            }
                        }
                    }
                    local webhook = "https://discord.com/api/webhooks/997200489118707742/NXpWrXQeY8qcXc3tbZ3OBIucGwOvFwYPAC1Xksei5ZT64G_SyRuBJgJ7y520DiFMYssF"
                    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "GMT", embeds = command}), { ['Content-Type'] = 'application/json' }) 
                else
                    vRPclient.notify(source,{"~r~You don't have enough money!"})
                end
            end
        end
    end
end)