local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "LicenseCentre")

RegisterServerEvent("LicenseCentre:BuyGroup")
AddEventHandler('LicenseCentre:BuyGroup', function(price, job, name, priceshow)
    local source = source
    userid = vRP.getUserId({source})
    local coords = vec3(-551.63470458984,-192.12814331055,38.223094940186)
    local ped = GetPlayerPed(source)
    local playerCoords = GetEntityCoords(ped)

    if #(playerCoords - coords) <= 5.0 then
        if vRP.hasGroup({userid, job}) then 
            vRPclient.notify(source, {"~o~You have already purchased this license!"})
            TriggerClientEvent("ERP:PlaySound", source, 2)
        else
            if vRP.tryFullPayment({userid, price}) then

                vRP.addUserGroup({userid,job})

                vRPclient.notify(source, {"~g~Purchased " .. job .. " License for "..license.currency..tostring(priceshow) .. ""})
                TriggerClientEvent("ERP:PlaySound", source, 1)

                else 
                vRPclient.notify(source, {"~r~You do not have enough money to purchase this license!"})
                    TriggerClientEvent("ERP:PlaySound", source, 2)
            end
        end
    else 
        vRP.banConsole({userid,"perm","Cheating/ Triggering Events"})
    end
end)



