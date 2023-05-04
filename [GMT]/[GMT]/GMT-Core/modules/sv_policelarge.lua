local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP_gunshop")


RegisterServerEvent("policelarge:BuyWeapon")
AddEventHandler("policelarge:BuyWeapon",function(hash)
    local source = source
    userid = vRP.getUserId({source})
    name = GetPlayerName(source)
    exports["discord-roles"]:isRolePresent(source,{cfgroles.pdLargeArmsRole},function(hasRole, roles)
        if hasRole == true and vRP.hasPermission({userid, "police.armoury"}) then
            for k, v in pairs(policelarge.guns) do
                if v.hash == hash then
                    if vRP.tryPayment({userid, 0}) then
                        vRPclient.giveWeapons(source, {{[v.hash] = {ammo = 250}}})
                        TriggerClientEvent("GMT:PlaySound", source, 1)
                        TriggerEvent("policelarge:senddiscord", userid, hash, name)
                        vRPclient.notify(source,{"~g~You have been supplied with a " .. hash.gsub(hash, "WEAPON_", "")})
                    end
                end
            end
        else
            vRPclient.notify(source, {"~r~You should not be in here, ALARM TRIGGERED"})
            TriggerClientEvent("GMT:PlaySound", source, 2)
        end
    end)
end)
RegisterServerEvent("policelarge:BuyWLWeapon")
AddEventHandler("policelarge:BuyWLWeapon",function(hash)
    local source = source
    userid = vRP.getUserId({source})
    name = GetPlayerName(source)
    exports["discord-roles"]:isRolePresent(source,{cfgroles.pdLargeArmsRole},function(hasRole, roles)
        if hasRole == true and vRP.hasPermission({userid, "police.armoury"}) then
            exports['ghmattimysql']:execute("SELECT * FROM `weapon_whitelists` WHERE permid = @permid", {permid = userid}, function(result)
                for k,v in pairs(result) do
                    if v.category == "pdlarge" then
                        if v.gunhash == hash then
                            if vRP.tryPayment({userid, 0}) then
                                vRPclient.giveWeapons(source, {{[v.gunhash] = {ammo = 250}}})
                                TriggerClientEvent("GMT:PlaySound", source, 1)
                                TriggerEvent("policelarge:senddiscord", userid, gunhash, name)
                                vRPclient.notify(source,{"~g~You have been supplied with a " .. gunhash.gsub(gunhash, "WEAPON_", "")})
                            end
                        end
                    end
                end
            end)
        else
            vRPclient.notify(source, {"~r~You should not be in here, ALARM TRIGGERED"})
            TriggerClientEvent("GMT:PlaySound", source, 2)
        end
    end)
end)

RegisterNetEvent("policelarge:BuyWeaponAmmo")
AddEventHandler("policelarge:BuyWeaponAmmo",function(hash)
    local source = source
    local user_id = vRP.getUserId({source})
    exports["discord-roles"]:isRolePresent(source,{cfgroles.pdLargeArmsRole},function(hasRole, roles)
        if hasRole == true and vRP.hasPermission({userid, "police.armoury"}) then
            for k, v in pairs(policelarge.guns) do
                if v.hash == hash then
                    if vRP.tryPayment({user_id, v.price / 2}) then
                        vRPclient.giveWeaponAmmo(source, {v.hash, 250})
                        vRPclient.notify(source,{"~g~Paid £" .. tostring(getMoneyStringFormatted(v.price / 2))})
                        TriggerClientEvent("GMT:PlaySound", source, 1)
                    end
                end
            end
        else
            vRPclient.notify(source, {"~r~You should not be in here, ALARM TRIGGERED"})
            TriggerClientEvent("GMT:PlaySound", source, 2)
        end
    end)
end)
RegisterNetEvent("policelarge:BuyWLWeaponAmmo")
AddEventHandler("policelarge:BuyWLWeaponAmmo",function(hash)
    local source = source
    local user_id = vRP.getUserId({source})
    exports["discord-roles"]:isRolePresent(source,{cfgroles.pdLargeArmsRole},function(hasRole, roles)
        if hasRole == true and vRP.hasPermission({userid, "police.armoury"}) then
            for k, v in pairs(PDLARGE.whitelist) do
                if v.gunhash == hash then
                    if vRP.tryPayment({user_id, v.price / 2}) then
                        vRPclient.giveWeaponAmmo(source, {v.hash, 250})
                        vRPclient.notify(source,{"~g~Paid £" .. tostring(getMoneyStringFormatted(v.price / 2))})
                        TriggerClientEvent("GMT:PlaySound", source, 1)
                    end
                end
            end
        else
            vRPclient.notify(source, {"~r~You should not be in here, ALARM TRIGGERED"})
            TriggerClientEvent("GMT:PlaySound", source, 2)
        end
    end)
end)

function getMoneyStringFormatted(cashString)
    local i, j, minus, int, fraction = tostring(cashString):find("([-]?)(%d+)([.]?%d*)")
    int = int:reverse():gsub("(%d%d%d)", "%1,")
    return minus .. int:reverse():gsub("^,", "") .. fraction
end

RegisterServerEvent("policelarge:senddiscord")
AddEventHandler("policelarge:senddiscord",function(userid1, weapon, name)
    --local weaponname = weapon.gsub(weapon, "WEAPON_", "")
    local command = {
        {
            ["color"] = "3944703",
            ["title"] = "GMT Armoury Logs",
            ["description"] = "",
            ["text"] = "GMT Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
            ["fields"] = {
                {
                    ["name"] = "Officer Name",
                    ["value"] = GetPlayerName(vRP.getUserSource({userid1})),
                    ["inline"] = true
                },
                {
                    ["name"] = "Officer TempID",
                    ["value"] = vRP.getUserSource({userid1}),
                    ["inline"] = true
                },
                {
                    ["name"] = "Officer PermID",
                    ["value"] = userid1,
                    ["inline"] = true
                },
                {
                    ["name"] = "Weapon",
                    ["value"] = weapon,
                    ["inline"] = true
                }
            }
        }
    }
    local webhook = "https://discord.com/api/webhooks/1003604963823460462/t04G3GSmap0hnA8jUCWrjlvQd1FSnLU6ySYwoX9wwVVqyOwfc4hWygOp_e11K0sftFnr"
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "GMT", embeds = command}), { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent("PDLARGE:PULLWHITELISTEDWEAPONS")
AddEventHandler("PDLARGE:PULLWHITELISTEDWEAPONS",function()
    local source = source
    local table = {}
    local user_id = vRP.getUserId({source})
    exports['ghmattimysql']:execute("SELECT * FROM `weapon_whitelists` WHERE permid = @permid", {permid = user_id}, function(result)
        for i, v in pairs(result) do
            if v.permid == user_id then
                if v.category == "pdlarge" then
                    table[i] = {name = v.name, gunhash = v.gunhash, price = v.price}
                end
            end
        end
    end)
    Wait(10)
    TriggerClientEvent("PDLARGE:GUNSRETURNED", source, table)
end)