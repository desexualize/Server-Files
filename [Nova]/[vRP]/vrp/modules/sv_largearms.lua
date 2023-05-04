local commision = 0
local finalID = nil
RegisterServerEvent("Bronze:BuyGun")
AddEventHandler(
    "Bronze:BuyGun",
    function(price, hash, bool)
        local source = source
        userid = vRP.getUserId({source})
        local ped = GetPlayerPed(source)
        local playerCoords = GetEntityCoords(ped)
        finalCommision = price * (commision / 100)

        local coords = vec3(-1111.2548828125, 4937.345703125, 218.38697814941)
        if #(playerCoords - coords) <= 5.0 then
            if vRP.hasGroup({userid, "Gang"}) then
                if vRP.getInventoryWeight({userid}) <= 25 then
                    if vRP.tryPayment({userid, finalCommision + price}) then
                        if bool then
                            vRP.giveInventoryItem({userid, "wbody|" .. hash, 1, true})
                            vRP.giveInventoryItem({userid, "7.62 Bullets", 250, true})
                        else
                            -- GiveWeaponToPed(source, hash, 250, false, false, 0)
                            TriggerClientEvent("large:givegun", source, hash)
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
                        vRPclient.notify(
                            source,
                            {
                                "~g~Purchased Weapon. Paid £" ..
                                    tostring(price + finalCommision) .. " ~w~+" .. commision .. "% Commision!"
                            }
                        )
                        if finalID ~= nil then
                            vRP.giveBankMoney({vRP.getUserId({finalID}), finalCommision})
                            vRPclient.notify(finalID, {"~g~You have been given ~w~£" .. finalCommision .. "~g~."})
                        end
                    else
                        vRPclient.notify(source, {"~r~You do not have enough Money!"})
                        TriggerClientEvent("Nova:PlaySound", source, 2)
                    end
                else
                    vRPclient.notify(source, {"~r~Not enough Weight."})
                    TriggerClientEvent("Nova:PlaySound", source, 2)
                end
            else
                vRPclient.notify(source, {"~r~You do not have Gang License"})
            end
        else
            vRP.banConsole({userid, "perm", "Cheating/ Triggering Events"})
        end
    end
)

function sendCom(som, userid2)
    commision = som
    finalID = userid2
    TriggerClientEvent("currentTurf", -1, som)
end

RegisterServerEvent("Bronze:BuyArmour")
AddEventHandler(
    "Bronze:BuyArmour",
    function(bool)
        local source = source
        userid = vRP.getUserId({source})
        local ped = GetPlayerPed(source)
        local playerCoords = GetEntityCoords(ped)
        finalCommision = 50000 * (commision / 100)

        local coords = vec3(-1111.2548828125, 4937.345703125, 218.38697814941)
        if #(playerCoords - coords) <= 5.0 then
            if vRP.hasGroup({userid, "Gang"}) then
                if vRP.getInventoryWeight({userid}) <= 25 then
                    if vRP.tryPayment({userid, 50000 + finalCommision}) then
                        if bool then
                            vRP.giveInventoryItem({userid, "body_armor2", 1, true})
                        else
                            SetPedArmour(source, 50)
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
                                                                "50%" .. "**\nPrice: **£" .. tostring(price) .. "**",
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
                        vRPclient.notify(source, {"~g~Given Armour for £50,000!"})
                        if finalID ~= nil then
                            vRP.giveBankMoney({vRP.getUserId({finalID}), finalCommision})
                            vRPclient.notify(finalID, {finalCommision})
                        end
                    else
                        vRPclient.notify(source, {"~r~You do not have enough Money!"})
                        TriggerClientEvent("Nova:PlaySound", source, 2)
                    end
                else
                    vRPclient.notify(source, {"~r~Not enough Weight."})
                    TriggerClientEvent("Nova:PlaySound", source, 2)
                end
            else
                vRPclient.notify(source, {"~r~You do not have Gang License"})
            end
        else
            vRP.banConsole({userid, "perm", "Cheating/ Triggering Events"})
        end
    end
)