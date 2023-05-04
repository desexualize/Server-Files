local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP_gunshop")

PDLARGE = {}
PDLARGE.whitelist = {
}

RegisterServerEvent("policelarge:BuyWeapon")
AddEventHandler("policelarge:BuyWeapon", function(hash)
        local source = source
        userid = vRP.getUserId({source})
        name = GetPlayerName(source)
                if vRP.hasPermission({userid, "police.armoury"}) then
                    for k, v in pairs(policelarge.guns) do
                        if v.hash == hash then
                            if vRP.tryPayment({userid, 0}) then
                                vRPclient.giveWeapons(source, {{[v.hash] = {ammo = 250}}})
                                TriggerEvent("policelarge:senddiscord", userid, hash, name)
                                vRPclient.notify(
                                    source,
                                    {"~g~You have been supplied with a " .. hash.gsub(hash, "WEAPON_", "")}
                                )
                            end
                        end
                    end
                else
                    vRPclient.notify(source, {"~r~You should not be in here, ALARM TRIGGERED"})
            end
        end)

RegisterServerEvent("policelarge:BuyWLWeapon")
AddEventHandler("policelarge:BuyWLWeapon", function(hash)
        local source = source
        userid = vRP.getUserId({source})
        name = GetPlayerName(source)
                if vRP.hasPermission({userid, "police.armoury"}) then
                    for k, v in pairs(PDLARGE.whitelist) do
                        if v.gunhash == hash then
                            if vRP.tryPayment({userid, 0}) then
                                vRPclient.giveWeapons(source, {{[v.gunhash] = {ammo = 250}}})
                                TriggerEvent("policelarge:senddiscord", userid, hash, name)
                                vRPclient.notify(
                                    source,
                                    {"~g~You have been supplied with a " .. hash.gsub(hash, "WEAPON_", "")})
                            end
                        end
                    end
                else
                    vRPclient.notify(source, {"~r~You should not be in here, ALARM TRIGGERED"})
                end
    end)

RegisterNetEvent("policelarge:BuyWeaponAmmo")
AddEventHandler(
    "policelarge:BuyWeaponAmmo",
    function(hash)
        local source = source
        local user_id = vRP.getUserId({source})

                if vRP.hasPermission({userid, "police.armoury"}) then
                    for k, v in pairs(policelarge.guns) do
                        if v.hash == hash then
                            if vRP.tryPayment({user_id, v.price / 2}) then
                                vRPclient.giveWeaponAmmo(source, {v.hash, 250})
                                vRPclient.notify(
                                    source,
                                    {"~g~Paid £" .. tostring(getMoneyStringFormatted(v.price / 2))}
                                )
                            end
                        end
                    end
                else
                    vRPclient.notify(source, {"~r~You should not be in here, ALARM TRIGGERED"})
                end
    end
)
RegisterNetEvent("policelarge:BuyWLWeaponAmmo")
AddEventHandler("policelarge:BuyWLWeaponAmmo", function(hash)
        local source = source
        local user_id = vRP.getUserId({source})
                if vRP.hasPermission({userid, "police.armoury"}) then
                    for k, v in pairs(PDLARGE.whitelist) do
                        if v.gunhash == hash then
                            if vRP.tryPayment({user_id, v.price / 2}) then
                                vRPclient.giveWeaponAmmo(source, {v.hash, 250})
                                vRPclient.notify(source,{"~g~Paid £" .. tostring(getMoneyStringFormatted(v.price / 2))}
                                )
                            end
                        end
                    end
                else
                    vRPclient.notify(source, {"~r~You should not be in here, ALARM TRIGGERED"})
                end
            end)

function getMoneyStringFormatted(cashString)
    local i, j, minus, int, fraction = tostring(cashString):find("([-]?)(%d+)([.]?%d*)")
    int = int:reverse():gsub("(%d%d%d)", "%1,")
    return minus .. int:reverse():gsub("^,", "") .. fraction
end

RegisterServerEvent("policelarge:senddiscord")
AddEventHandler("policelarge:senddiscord", function(userid1, weapon, name)
        local pdlargearmslogs = {
            {
                ["color"] = "255",
                ["description"] = "**Perm ID:** " ..
                    userid1 .. "\n**Name: **" .. name .. "\n**Weapon Bought:** " .. weapon,
                ["footer"] = {
                    ["text"] = os.date("%X")
                }
            }
        }
        PerformHttpRequest(
            "https://discord.com/api/webhooks/1001565319208382476/ebmXG8R-djxdlLgxrHnrEZpZiVBXYCt1PU06js1tj4RI7LV4jMdf5M3RFX33agZrxKT-",
            function(err, text, headers)
            end,
            "POST",
            json.encode({username = "PD Large Arms Logs", embeds = pdlargearmslogs}),
            {["Content-Type"] = "application/json"}
        )
    end
)

RegisterServerEvent("PDLARGE:PULLWHITELISTEDWEAPONS")
AddEventHandler("PDLARGE:PULLWHITELISTEDWEAPONS", function()
        local source = source
        local table = {}
        local user_id = vRP.getUserId({source})
        for i, v in pairs(PDLARGE.whitelist) do
            if v.permid == user_id then
                table[i] = {name = v.name, gunhash = v.gunhash, price = v.price}
            end
        end
        Wait(1)
        TriggerClientEvent("PDLARGE:GUNSRETURNED", source, table)
    end
)
