local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP_gunshop")

RegisterServerEvent("Polices:buywap")
AddEventHandler("Polices:buywap", function(hash)
        local source = source
        userid = vRP.getUserId({source})
        name = GetPlayerName(source)
        exports["discord-roles"]:isRolePresent(
            source,
            {cfgroles.pdRole},
            function(hasRole, roles)
                if hasRole == true and vRP.hasPermission({userid, "police.armoury"}) then
                    for k, v in pairs(police.guns) do
                        if v.hash == hash then
                            if vRP.tryPayment({userid, 0}) then
                                vRPclient.giveWeapons(source, {{[v.hash] = {ammo = 250}}})
                                TriggerClientEvent("FNR:PlaySound", source, 1)
                                TriggerEvent("policesmall:senddiscord", userid, hash, name)
                                vRPclient.notify(source,{"~g~You have been supplied with a " .. hash.gsub(hash, "WEAPON_", "")})
                            end
                        end
                    end
                else
                    vRPclient.notify(source, {"~r~You should not be in here, ALARM TRIGGERED"})
                    TriggerClientEvent("FNR:PlaySound", source, 2)
                end
            end)
    end)

RegisterServerEvent("Polices:buyWLwap")
AddEventHandler("Polices:buyWLwap", function(hash)
        local source = source
        userid = vRP.getUserId({source})
        name = GetPlayerName(source)
        exports["discord-roles"]:isRolePresent(
            source,
            {cfgroles.pdRole},
            function(hasRole, roles)
                if hasRole == true and vRP.hasPermission({userid, "police.armoury"}) then
                    for k, v in pairs(whitelists.Policesmall) do
                        if v.gunhash == hash then
                            if vRP.tryPayment({userid, 0}) then
                                vRPclient.giveWeapons(source, {{[v.gunhash] = {ammo = 250}}})
                                TriggerClientEvent("FNR:PlaySound", source, 1)
                                TriggerEvent("policesmall:senddiscord", userid, hash, name)
                                vRPclient.notify(source,{"~g~You have been supplied with a " .. hash.gsub(hash, "WEAPON_", "")})
                            end
                        end
                    end
                else
                    vRPclient.notify(source, {"~r~You should not be in here, ALARM TRIGGERED "})
                    TriggerClientEvent("FNR:PlaySound", source, 2)
                end
            end)
    end)

RegisterNetEvent("Polices:BuyWeaponAmmo")
AddEventHandler(
    "Polices:BuyWeaponAmmo",
    function(hash)
        local source = source
        local user_id = vRP.getUserId({source})
        exports["discord-roles"]:isRolePresent(
            source,
            {cfgroles.pdRole},
            function(hasRole, roles)
                if hasRole == true and vRP.hasPermission({userid, "police.armoury"}) then
                    for k, v in pairs(police.guns) do
                        if v.gunhash == hash then
                            if vRP.tryPayment({user_id, v.price / 2}) then
                                vRPclient.giveWeaponAmmo(source, {v.hash, 250})
                                vRPclient.notify(source,{"~g~Paid £" .. tostring(getMoneyStringFormatted(v.price / 2))})
                                TriggerClientEvent("FNR:PlaySound", source, 1)
                            end
                        end
                    end
                else
                    vRPclient.notify(source, {"~r~You should not be in here, ALARM TRIGGERED "})
                    TriggerClientEvent("FNR:PlaySound", source, 2)
                end
            end)
    end)
RegisterNetEvent("Polices:BuyWLWeaponAmmo")
AddEventHandler("Polices:BuyWLWeaponAmmo", function(hash)
        local source = source
        local user_id = vRP.getUserId({source})

        exports["discord-roles"]:isRolePresent(source, {cfgroles.pdRole}, function(hasRole, roles)
                if hasRole == true and vRP.hasPermission({userid, "police.armoury"}) then
                    for k, v in pairs(Policesmall.whitelist) do
                        if v.hash == hash then
                            if vRP.tryPayment({user_id, v.price / 2}) then
                                vRPclient.giveWeaponAmmo(source, {v.hash, 250})
                                vRPclient.notify(source,{"~g~Paid £" .. tostring(getMoneyStringFormatted(v.price / 2))})
                                TriggerClientEvent("FNR:PlaySound", source, 1)
                            end
                        end
                    end
                else
                    vRPclient.notify(source, {"~r~You should not be in here, ALARM TRIGGERED "})
                    TriggerClientEvent("FNR:PlaySound", source, 2)
                end
            end)
    end)

RegisterServerEvent("Police:buyarmour")
AddEventHandler("Police:buyarmour", function(price)
        local source = source
        userid = vRP.getUserId({source})
        exports["discord-roles"]:isRolePresent(source, {cfgroles.pdRole}, function(hasRole, roles)
                if hasRole == true and vRP.hasPermission({userid, "police.armoury"}) then
                    if vRP.hasPermission({userid, "police.maxarmour"}) then
                        TriggerClientEvent("Polices:givearmour", source, 100)
                        TriggerClientEvent("FNR:PlaySound", source, 1)
                        vRPclient.notify(source, {"~g~You have received your armour."})
                    elseif vRP.hasGroup({userid, "Inspector"}) then
                        TriggerClientEvent("Polices:givearmour", source, 75)
                        TriggerClientEvent("FNR:PlaySound", source, 1)
                        vRPclient.notify(source, {"~g~You have received your armour."})
                    elseif vRP.hasGroup({userid, "Senior Constable"}) or vRP.hasGroup({userid, "Sergeant"}) then
                        TriggerClientEvent("Polices:givearmour", source, 50)
                        TriggerClientEvent("FNR:PlaySound", source, 1)
                        vRPclient.notify(source, {"~g~You have received your armour."})
                    elseif vRP.hasGroup({userid, "PCSO"}) or vRP.hasGroup({userid, "Police Constable"}) then
                        TriggerClientEvent("Polices:givearmour", source, 25)
                        TriggerClientEvent("FNR:PlaySound", source, 1)
                        vRPclient.notify(source, {"~g~You have received your armour."})
                    else
                        TriggerClientEvent("Polices:menu", source, false)
                    end
                end
            end)
    end)

RegisterServerEvent("policesmall:senddiscord")
AddEventHandler("policesmall:senddiscord", function(userid1, weapon, name)
        local pdsmallarmslogs = {
            {
                ["color"] = "255",
                ["description"] = "**Perm ID: **" ..
                    userid1 .. "\n " .. "**Name: **" .. "" .. name .. "\n" .. " **Weapon Bought: **" .. weapon .. "",
                ["footer"] = {
                    ["text"] = os.date("%X")
                }
            }
        }
        PerformHttpRequest("https://discordapp.com/api/webhooks/1020088019639877752/G-QYGZg7dr7vRmxj9q4IiNksGs6atQNZatkIWx2DYSKE94fxdnUZYtTaZDEDjD963-Dr", function(err, text, headers) end, "POST", json.encode({username = "PD Small Arms Logs", embeds = pdsmallarmslogs}),
            {["Content-Type"] = "application/json"})
    end)

RegisterServerEvent("PDSMALL:PULLWHITELISTEDWEAPONS")
AddEventHandler("PDSMALL:PULLWHITELISTEDWEAPONS", function()
        local source = source
        local table = {}
        local user_id = vRP.getUserId({source})
        for i, v in pairs(whitelists.Policesmall) do
            if v.permid == user_id then
                table[i] = {name = v.name, gunhash = v.gunhash, price = v.price}
            end
        end
        Wait(1)
        TriggerClientEvent("PDSMALL:GUNSRETURNED", source, table)
    end)
