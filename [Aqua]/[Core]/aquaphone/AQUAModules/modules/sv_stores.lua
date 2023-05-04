local cfg = module("AQUAModules", "cfg/cfg_stores")

local Tunnel = module("AQUA", "lib/Tunnel")
local Proxy = module("AQUA", "lib/Proxy")
AQUA = Proxy.getInterface("AQUA")
AQUAclient = Tunnel.getInterface("AQUA","AQUA")

RegisterNetEvent("AQUA:BuyShopItem")
AddEventHandler("AQUA:BuyShopItem", function(itemID, amount)
    local user_id = AQUA.getUserId({source})

    if user_id ~= nil then
        for k, v in pairs(cfg.items) do
            if itemID == v.itemID then
                if AQUA.tryPayment({user_id, v.price * amount}) then
                    AQUA.giveInventoryItem({user_id, v.itemID, amount, true})
                    AQUAclient.playFrontendSound(source,{"Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS"})
                    local command = {
                        {
                            ["color"] = "3944703",
                            ["title"] = " Store Logs",
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
                    local webhook = "https://discord.com/api/webhooks/1059084554545135716/PsGor6-mohHyJ9N0w2PgajMVgYFdZ0EBybAas2dzw5Lwd0AVyc-5a6tEGlPSFgR3NBy2"
                    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "AQUA", embeds = command}), { ['Content-Type'] = 'application/json' }) 
                else
                    AQUAclient.notify(source,{"~d~You don't have enough money!"})
                end
            end
        end
    end
end)