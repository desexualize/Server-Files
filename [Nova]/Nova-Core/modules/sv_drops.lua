local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "ShopBuy")

RegisterServerEvent("Nova:ShopBuy")
AddEventHandler(
    "Nova:ShopBuy",
    function(price, hash)
        local source = source
        userid = vRP.getUserId({source})
        local ped = GetPlayerPed(source)
        local playerCoords = GetEntityCoords(ped)

        local coords = vec3(-2163.0864257812, 5176.9965820312, 14.737954139709)

        if #(playerCoords - coords) <= 5.0 then
            if vRP.getInventoryWeight({userid}) <= 25 then
                if vRP.tryPayment({userid, price}) then
                    vRP.giveInventoryItem({userid, hash, 1, true})

                    TriggerClientEvent("Nova:PlaySound", source, 1)
                    vRPclient.notify(source, {"~g~Purchased Item. Paid £" .. tostring(price) .. "!"})
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
    end
)
