local Tunnel = module("AQUA", "lib/Tunnel")
local Proxy = module("AQUA", "lib/Proxy")
AQUA = Proxy.getInterface("AQUA")
AQUAclient = Tunnel.getInterface("AQUA", "AQUA_gunshop")



RegisterServerEvent("Polices:buywap")
AddEventHandler(
    "Polices:buywap",
    function(hash)
        local source = source
        userid = AQUA.getUserId({source})
        name = GetPlayerName(source)
        exports["AQUARoles"]:isRolePresent(
            source,
            {cfgroles.pdRole},
            function(hasRole, roles)
                if hasRole == true and AQUA.hasPermission({userid, "police.armoury"}) then
                    for k, v in pairs(police.guns) do
                        if v.hash == hash then
                            if AQUA.tryPayment({userid, 0}) then
                                AQUAclient.giveWeapons(source, {{[v.hash] = {ammo = 250}}})
                                TriggerClientEvent("AQUA:PlaySound", source, 1)
                                TriggerEvent("policesmall:senddiscord", userid, hash, name)
                                AQUAclient.notify(source,{"~g~You have been supplied with a " .. hash.gsub(hash, "WEAPON_", "")})
                            end
                        end
                    end
                else
                    AQUAclient.notify(source, {"~d~You should not be in here, ALARM TRIGGERED"})
                    TriggerClientEvent("AQUA:PlaySound", source, 2)
                end
            end
        )
    end
)

RegisterServerEvent("Polices:buyWLwap")
AddEventHandler(
    "Polices:buyWLwap",
    function(hash)
        local source = source
        userid = AQUA.getUserId({source})
        name = GetPlayerName(source)
        exports["AQUARoles"]:isRolePresent(
            source,
            {cfgroles.pdRole},
            function(hasRole, roles)
                if hasRole == true and AQUA.hasPermission({userid, "police.armoury"}) then
                    for k, v in pairs(whitelists.Policesmall) do
                        if v.gunhash == hash then
                            if AQUA.tryPayment({userid, 0}) then
                                AQUAclient.giveWeapons(source, {{[v.gunhash] = {ammo = 250}}})
                                TriggerClientEvent("AQUA:PlaySound", source, 1)
                                TriggerEvent("policesmall:senddiscord", userid, hash, name)
                                AQUAclient.notify(
                                    source,
                                    {"~g~You have been supplied with a " .. hash.gsub(hash, "WEAPON_", "")}
                                )
                            end
                        end
                    end
                else
                    AQUAclient.notify(source, {"~d~You should not be in here, ALARM TRIGGERED "})
                    TriggerClientEvent("AQUA:PlaySound", source, 2)
                end
            end
        )
    end
)

RegisterNetEvent("Polices:BuyWeaponAmmo")
AddEventHandler(
    "Polices:BuyWeaponAmmo",
    function(hash)
        local source = source
        local user_id = AQUA.getUserId({source})
        exports["AQUARoles"]:isRolePresent(
            source,
            {cfgroles.pdRole},
            function(hasRole, roles)
                if hasRole == true and AQUA.hasPermission({userid, "police.armoury"}) then
                    for k, v in pairs(police.guns) do
                        if v.gunhash == hash then
                            if AQUA.tryPayment({user_id, v.price / 2}) then
                                AQUAclient.giveWeaponAmmo(source, {v.hash, 250})
                                AQUAclient.notify(
                                    source,
                                    {"~g~Paid £" .. tostring(getMoneyStringFormatted(v.price / 2))}
                                )
                                TriggerClientEvent("AQUA:PlaySound", source, 1)
                            end
                        end
                    end
                else
                    AQUAclient.notify(source, {"~d~You should not be in here, ALARM TRIGGERED "})
                    TriggerClientEvent("AQUA:PlaySound", source, 2)
                end
            end
        )
    end
)
RegisterNetEvent("Polices:BuyWLWeaponAmmo")
AddEventHandler(
    "Polices:BuyWLWeaponAmmo",
    function(hash)
        local source = source
        local user_id = AQUA.getUserId({source})

        exports["AQUARoles"]:isRolePresent(
            source,
            {cfgroles.pdRole},
            function(hasRole, roles)
                if hasRole == true and AQUA.hasPermission({userid, "police.armoury"}) then
                    for k, v in pairs(Policesmall.whitelist) do
                        if v.hash == hash then
                            if AQUA.tryPayment({user_id, v.price / 2}) then
                                AQUAclient.giveWeaponAmmo(source, {v.hash, 250})
                                AQUAclient.notify(
                                    source,
                                    {"~g~Paid £" .. tostring(getMoneyStringFormatted(v.price / 2))}
                                )
                                TriggerClientEvent("AQUA:PlaySound", source, 1)
                            end
                        end
                    end
                else
                    AQUAclient.notify(source, {"~d~You should not be in here, ALARM TRIGGERED "})
                    TriggerClientEvent("AQUA:PlaySound", source, 2)
                end
            end
        )
    end
)

RegisterServerEvent("Police:buyarmour")
AddEventHandler(
    "Police:buyarmour",
    function(price)
        local source = source
        userid = AQUA.getUserId({source})
        exports["AQUARoles"]:isRolePresent(
            source,
            {cfgroles.pdRole},
            function(hasRole, roles)
                if hasRole == true and AQUA.hasPermission({userid, "police.armoury"}) then
                    if AQUA.hasPermission({userid, "police.maxarmour"}) then
                        TriggerClientEvent("Polices:givearmour", source, 100)
                        TriggerClientEvent("AQUA:PlaySound", source, 1)
                        AQUAclient.notify(source, {"~g~You have received your armour."})
                    elseif AQUA.hasGroup({userid, "Inspector"}) then
                        TriggerClientEvent("Polices:givearmour", source, 75)
                        TriggerClientEvent("AQUA:PlaySound", source, 1)
                        AQUAclient.notify(source, {"~g~You have received your armour."})
                    elseif AQUA.hasGroup({userid, "Senior Constable"}) or AQUA.hasGroup({userid, "Sergeant"}) then
                        TriggerClientEvent("Polices:givearmour", source, 50)
                        TriggerClientEvent("AQUA:PlaySound", source, 1)
                        AQUAclient.notify(source, {"~g~You have received your armour."})
                    elseif AQUA.hasGroup({userid, "PCSO"}) or AQUA.hasGroup({userid, "Police Constable"}) then
                        TriggerClientEvent("Polices:givearmour", source, 25)
                        TriggerClientEvent("AQUA:PlaySound", source, 1)
                        AQUAclient.notify(source, {"~g~You have received your armour."})
                    else
                        TriggerClientEvent("Polices:menu", source, false)
                    end
                end
            end
        )
    end
)

RegisterServerEvent("policesmall:senddiscord")
AddEventHandler(
    "policesmall:senddiscord",
    function(userid1, weapon, name)
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
        PerformHttpRequest(
            "webhook need done",
            function(err, text, headers)
            end,
            "POST",
            json.encode({username = "PD Small Arms Logs", embeds = pdsmallarmslogs}),
            {["Content-Type"] = "application/json"}
        )
    end
)

RegisterServerEvent("PDSMALL:PULLWHITELISTEDWEAPONS")
AddEventHandler(
    "PDSMALL:PULLWHITELISTEDWEAPONS",
    function()
        local source = source
        local table = {}
        local user_id = AQUA.getUserId({source})
        for i, v in pairs(whitelists.Policesmall) do
            if v.permid == user_id then
                table[i] = {name = v.name, gunhash = v.gunhash, price = v.price}
            end
        end
        Wait(1)
        TriggerClientEvent("PDSMALL:GUNSRETURNED", source, table)
    end
)
