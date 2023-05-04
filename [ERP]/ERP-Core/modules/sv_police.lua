local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP_gunshop")

Policesmall = {}
Policesmall.whitelist = {    
    -- {name = "", gunhash = "", permid = 1, price = 0}, example
}

RegisterServerEvent("Polices:buywap")
AddEventHandler("Polices:buywap", function(hash)
        local source = source
        userid = vRP.getUserId({source})
        name = GetPlayerName(source)
                if vRP.hasPermission({userid, "police.armoury"}) then
                    for k, v in pairs(police.guns) do
                        if v.hash == hash then
                            if vRP.tryPayment({userid, 0}) then
                                vRPclient.giveWeapons(source, {{[v.hash] = {ammo = 250}}})
                                TriggerEvent("policesmall:senddiscord", userid, hash, name)
                                vRPclient.notify(source,{"~g~You have been supplied with a " .. hash.gsub(hash, "WEAPON_", "")})
                            end
                        end
                    end
                else
                    vRPclient.notify(source, {"~r~You should not be in here, ALARM TRIGGERED"})
                end
    end)

RegisterServerEvent("Polices:buyWLwap")
AddEventHandler("Polices:buyWLwap",function(hash)
        local source = source
        userid = vRP.getUserId({source})
        name = GetPlayerName(source)
                if vRP.hasPermission({userid, "police.armoury"}) then
                    for k, v in pairs(Policesmall.whitelist) do
                        if v.gunhash == hash then
                            if vRP.tryPayment({userid, 0}) then
                                vRPclient.giveWeapons(source, {{[v.gunhash] = {ammo = 250}}})
                                TriggerEvent("policesmall:senddiscord", userid, hash, name)
                                vRPclient.notify(
                                    source,
                                    {"~g~You have been supplied with a " .. hash.gsub(hash, "WEAPON_", "")}
                                )
                            end
                        end
                    end
                else
                    vRPclient.notify(source, {"~r~You should not be in here, ALARM TRIGGERED "})
                end
    end
)

RegisterNetEvent("Polices:BuyWeaponAmmo")
AddEventHandler(
    "Polices:BuyWeaponAmmo",
    function(hash)
        local source = source
        local user_id = vRP.getUserId({source})
                if vRP.hasPermission({userid, "police.armoury"}) then
                    for k, v in pairs(police.guns) do
                        if v.gunhash == hash then
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
                    vRPclient.notify(source, {"~r~You should not be in here, ALARM TRIGGERED "})
                end
    end
)
RegisterNetEvent("Polices:BuyWLWeaponAmmo")
AddEventHandler(
    "Polices:BuyWLWeaponAmmo",
    function(hash)
        local source = source
        local user_id = vRP.getUserId({source})
                if vRP.hasPermission({userid, "police.armoury"}) then
                    for k, v in pairs(Policesmall.whitelist) do
                        if v.hash == hash then
                            if vRP.tryPayment({user_id, v.price / 2}) then
                                vRPclient.giveWeaponAmmo(source, {v.hash, 250})
                                vRPclient.notify(source,{"~g~Paid £" .. tostring(getMoneyStringFormatted(v.price / 2))})
                            end
                        end
                    end
                else
            vRPclient.notify(source, {"~r~You should not be in here, ALARM TRIGGERED "})
        end
    end)


RegisterServerEvent("policesmall:senddiscord")
AddEventHandler("policesmall:senddiscord",
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
        PerformHttpRequest("small arms pd logs wehook",function(err, text, headers)end,"POST",json.encode({username = "PD Small Arms Logs", embeds = pdsmallarmslogs}),
        {["Content-Type"] = "application/json"}
        )
    end
)

RegisterServerEvent("Police:BuyArmour")
AddEventHandler('Police:BuyArmour', function()
    local source = source
    userid = vRP.getUserId({source})
    name = GetPlayerName(source)
    local ped = GetPlayerPed(source)
    local playerCoords = GetEntityCoords(ped)
    local coords = vec3(442.21801757812,-988.07916259766,34.297271728516)
    local coords2 = -448.63012695312,6021.5864257812,31.755352020264
    if #(playerCoords - coords) <= 5.0 or #(playerCoords - coords2) <= 5.0 then 
        if vRP.hasPermission({userid, "police.armoury"}) then
            if vRP.tryPayment({userid,0}) then     
                SetPedArmour(source, 95)
                TriggerEvent("policesmall:senddiscord", userid, hash, name)
                TriggerClientEvent("ERP:PlaySound", source, 1)
                vRPclient.notify(source, {"~g~Given Armour for £100,000!"})
            else
                vRPclient.notify(source,{"~r~You do not have enough Money!"})
                    TriggerClientEvent("ERP:PlaySound", source, 2)
            end
        else
           vRPclient.notify(source,{"~r~You do not have Access!"})
            TriggerClientEvent("ERP:PlaySound", source, 2)
       end
    else 
        vRP.banConsole({userid,"perm","Cheating/ Triggering Events"})
    end
    
end)

RegisterServerEvent("PDSMALL:PULLWHITELISTEDWEAPONS")
AddEventHandler("PDSMALL:PULLWHITELISTEDWEAPONS",function()
        local source = source
        local table = {}
        local user_id = vRP.getUserId({source})
        for i, v in pairs(Policesmall.whitelist) do
            if v.permid == user_id then
                table[i] = {name = v.name, gunhash = v.gunhash, price = v.price}
            end
        end
        Wait(1)
        TriggerClientEvent("PDSMALL:GUNSRETURNED", source, table)
    end
)
