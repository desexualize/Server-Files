local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP_gunshop")

RegisterServerEvent("Nova:BuyGun")
AddEventHandler("Nova:BuyGun", function(price, hash, bool)
    local source = source
    userid = vRP.getUserId({source})
    local ped = GetPlayerPed(source)
    local playerCoords = GetEntityCoords(ped)

    local coords = vec3(1544.8254394531, 6332.201171875, 24.078239440918)
    if vRP.hasPermission({userid, "rebel.guns"}) then
        if #(playerCoords - coords) <= 5.0 then
            if vRP.getInventoryWeight({userid}) <= 25 then
                if vRP.tryPayment({userid, price}) then
                    if bool then
                        vRP.giveInventoryItem({userid, "wbody|" .. hash, 1, true})
                        vRP.giveInventoryItem({userid, "7.62 Bullets", 250, true})
                    else
                        -- GiveWeaponToPed(source, hash, 250, false, false, 0)
                        TriggerClientEvent("rebel:givegun", source, hash)
                    end

                    webhook =
                        "https://discord.com/api/webhooks/1012748524112318535/T213lyQjgo9zusN5CJYRApT2NR314L3jbEgVX5bCVh2wtzCtSlRjfg3Z8eIPjBPuivJN"

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
                                                        "** \nBought Weapon: **" ..
                                                            hash .. "**\nPrice: **£" .. tostring(price) .. "**",
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
                    vRPclient.notify(source, {"~g~Purchased Weapon. Paid £" .. tostring(price) .. "!"})
                else
                    vRPclient.notify(source, {"~r~You do not have enough Money!"})
                    TriggerClientEvent("Nova:PlaySound", source, 2)
                end
            else
                vRPclient.notify(source, {"~r~Not enough Weight."})
                TriggerClientEvent("Nova:PlaySound", source, 2)
            end
        else
            vRP.banConsole({userid, "perm", "Cheating/ Triggering Events"})
        end
    else
        vRPclient.notify(source, {"~r~You do not have Rebel Access!"})
        TriggerClientEvent("Nova:PlaySound", source, 2)
    end
end)

RegisterServerEvent("Nova:BuyArmour")
AddEventHandler(
    "Nova:BuyArmour",
    function(bool)
        local source = source
        userid = vRP.getUserId({source})
        local ped = GetPlayerPed(source)
        local playerCoords = GetEntityCoords(ped)
        local coords = vec3(1544.8254394531, 6332.201171875, 24.078239440918)
        if #(playerCoords - coords) <= 5.0 then
            if vRP.hasPermission({userid, "rebel.guns"}) then
                if vRP.getInventoryWeight({userid}) <= 25 then
                    if vRP.tryPayment({userid, 100000}) then
                        if bool then
                            vRP.giveInventoryItem({userid, "body_armor", 1, true})
                        else
                            SetPedArmour(source, 95)
                        end

                        webhook =
                            "https://discord.com/api/webhooks/1012748524112318535/T213lyQjgo9zusN5CJYRApT2NR314L3jbEgVX5bCVh2wtzCtSlRjfg3Z8eIPjBPuivJN"
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
                                                            "** \nBought Armour: **" ..
                                                                "100%" .. "**\nPrice: **£" .. tostring(price) .. "**",
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
                        vRPclient.notify(source, {"~g~Given Armour for £100,000!"})
                    else
                        vRPclient.notify(source, {"~r~You do not have enough Money!"})
                        TriggerClientEvent("Nova:PlaySound", source, 2)
                    end
                else
                    vRPclient.notify(source, {"~r~Not enough Weight."})
                    TriggerClientEvent("Nova:PlaySound", source, 2)
                end
            else
                vRPclient.notify(source, {"~r~You do not have Rebel Access!"})
                TriggerClientEvent("Nova:PlaySound", source, 2)
            end
        else
            vRP.banConsole({userid, "perm", "Cheating/ Triggering Events"})
        end
    end
)
