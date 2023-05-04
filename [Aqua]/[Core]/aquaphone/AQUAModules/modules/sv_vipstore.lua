local Tunnel = module('AQUA', 'lib/Tunnel')
local Proxy = module('AQUA', 'lib/Proxy')
AQUA = Proxy.getInterface("AQUA")
AQUAclient = Tunnel.getInterface("AQUA", "AQUA_gunshop")



function getMoneyStringFormatted(cashString)
	local i, j, minus, int, fraction = tostring(cashString):find('([-]?)(%d+)([.]?%d*)')
	int = int:reverse():gsub("(%d%d%d)", "%1,")
	return minus .. int:reverse():gsub("^,", "") .. fraction 
end




RegisterServerEvent("VIP:BuyWeapon")
AddEventHandler('VIP:BuyWeapon', function(hash)
    local source = source
    local user_id = AQUA.getUserId({source})
    if user_id ~= nil then
        if AQUA.hasPermission({user_id, VIP.perm}) then
            for k, v in pairs(VIP.guns) do
                if v.hash == hash then
                    if AQUA.tryPayment({user_id, v.price}) then
                        AQUAclient.giveWeapons(source,{{[v.hash] = {ammo=250}}})
                        AQUAclient.notify(source, {"~g~Paid £"..getMoneyStringFormatted(v.price)})
                        TriggerClientEvent("AQUA:PlaySound", source, 1)
                    else 
                        TriggerClientEvent("AQUA:PlaySound", source, 2)
                        AQUAclient.notify(source, {"~d~Insufficient funds"})
                    end
                end
            end
        else
            AQUAclient.notify(source, {"~d~You do not have permission to purchase guns from here 🤦‍♂️"})
            TriggerClientEvent("AQUA:PlaySound", source, 2)
        end
    end
end)

RegisterServerEvent("VIP:BuyWLWeapon")
AddEventHandler('VIP:BuyWLWeapon', function(hash)
    local source = source
    local user_id = AQUA.getUserId({source})
    if user_id ~= nil then
        if AQUA.hasPermission({user_id, VIP.perm}) then
            exports['ghmattimysql']:execute("SELECT * FROM `weapon_whitelists` WHERE permid = @permid", {permid = user_id}, function(result)
            for k, v in pairs(result) do
                if v.category == "large" then
                if v.gunhash == hash then
                    local price = v.price
                    if AQUA.tryPayment({user_id, tonumber(price)}) then
                        AQUAclient.giveWeapons(source,{{[hash] = {ammo=250}}})
                        AQUAclient.notify(source, {"~g~Paid £"..getMoneyStringFormatted(v.price)})
                        TriggerClientEvent("AQUA:PlaySound", source, 1)
                    else 
                        TriggerClientEvent("AQUA:PlaySound", source, 2)
                        AQUAclient.notify(source, {"~d~Insufficient funds"})
                    end
                end
            end
        end
            end)
        else
            AQUAclient.notify(source, {"~d~You do not have permission to purchase guns from here 🤦‍♂️"})
            TriggerClientEvent("AQUA:PlaySound", source, 2)
        end
    end
end)
RegisterServerEvent("VIP:BuyArmour")
AddEventHandler('VIP:BuyArmour', function()
    local user_id = AQUA.getUserId({source})
    local currentArmour = GetPedArmour(GetPlayerPed(source))

    if user_id ~= nil then 
        if AQUA.hasPermission({user_id, VIP.perm}) and AQUA.hasPermission({user_id, "rebel.guns"}) then
            if currentArmour < 100 then
                if AQUA.tryPayment({user_id, VIP.maxArmourPrice}) then
                    AQUAclient.setArmour(source,{100})
                    TriggerClientEvent("AQUA:PlaySound", source, 1)
                    AQUAclient.notify(source, {"~g~Paid £"..tostring(getMoneyStringFormatted(VIP.maxArmourPrice))})
                else 
                    TriggerClientEvent("AQUA:PlaySound", source, 2)
                    AQUAclient.notify(source, {"~d~Insufficient funds"})
                end
            else
                AQUAclient.notify(source,{"~d~You already have 100% armour."})
            end
        else
            AQUAclient.notify(source, {"~d~You do not have permission to purchase armour from here 🤦‍♂️"})
            TriggerClientEvent("AQUA:PlaySound", source, 2)
        end
    end
end)

RegisterServerEvent("VIP:ReplenishArmour")
AddEventHandler('VIP:ReplenishArmour', function()
    local user_id = AQUA.getUserId({source})

    if user_id ~= nil then 
        if AQUA.hasPermission({user_id, VIP.perm}) and AQUA.hasPermission({user_id, "rebel.guns"}) then
            local currentArmour = GetPedArmour(GetPlayerPed(source))
            local newArmour = 100 - currentArmour
            local price = newArmour * 1000

            if newArmour ~= 0 then
                if AQUA.tryPayment({user_id, price}) then
                    AQUAclient.setArmour(source,{100})
                    TriggerClientEvent("AQUA:PlaySound", source, 1)
                    AQUAclient.notify(source, {"~g~Paid £"..tostring(getMoneyStringFormatted(price))})
                else 
                    TriggerClientEvent("AQUA:PlaySound", source, 2)
                    AQUAclient.notify(source, {"~d~Insufficient funds"})
                end
            else
                AQUAclient.notify(source,{"~d~You already have 100% armour."})
            end
        else
            AQUAclient.notify(source, {"~d~You do not have permission to purchase armour from here 🤦‍♂️"})
            TriggerClientEvent("AQUA:PlaySound", source, 2)
        end
    end
end)

RegisterNetEvent("VIP:BuyWeaponAmmo")
AddEventHandler("VIP:BuyWeaponAmmo", function(hash)
    local source = source
    local user_id = AQUA.getUserId({source})

    if user_id ~= nil then
        for k, v in pairs(VIP.guns) do
             if v.hash == hash then
                if AQUA.tryPayment({user_id, v.price / 2}) then
                    AQUAclient.giveWeaponAmmo(source,{v.hash, 250})
                    AQUAclient.notify(source, {"~g~Paid £"..tostring(getMoneyStringFormatted(v.price/2))})
                    TriggerClientEvent("AQUA:PlaySound", source, 1)
                else 
                    TriggerClientEvent("SmallArms:Error", source, false)
                    AQUAclient.notify(source, {"~d~Insufficient funds"})
                    TriggerClientEvent("AQUA:PlaySound", source, 2)
                 end
            end
        end
    end
end)

RegisterNetEvent("VIP:BuyWeaponAmmo2")
AddEventHandler("VIP:BuyWeaponAmmo2", function(hash)
    local source = source
    local user_id = AQUA.getUserId({source})

    if user_id ~= nil then
        exports['ghmattimysql']:execute("SELECT * FROM `weapon_whitelists` WHERE permid = @permid", {permid = user_id}, function(result)
            for k, v in pairs(result) do
                if v.category == "large" then
             if v.gunhash == hash then
                if AQUA.tryPayment({user_id, tonumber(v.price / 2)}) then
                    AQUAclient.giveWeaponAmmo(source,{v.gunhash, 250})
                    AQUAclient.notify(source, {"~g~Paid £"..tostring(getMoneyStringFormatted(v.price/2))})
                    TriggerClientEvent("AQUA:PlaySound", source, 1)
                else 
                    TriggerClientEvent("SmallArms:Error", source, false)
                    AQUAclient.notify(source, {"~d~Insufficient funds"})
                    TriggerClientEvent("AQUA:PlaySound", source, 2)
                 end
            end
        end
    end
        end)
    end
end)


RegisterServerEvent("VIP:PULLWHITELISTEDWEAPONS")
AddEventHandler("VIP:PULLWHITELISTEDWEAPONS", function()
    local source = source
    local table = {}
    local permid = AQUA.getUserId({source})
    exports['ghmattimysql']:execute("SELECT * FROM `weapon_whitelists` WHERE permid = @permid", {permid = permid}, function(result)
        for k,v in pairs(result) do
           if v.permid == permid then 
              if v.category == "large" then   
                 table[k] = {name = v.name, gunhash = v.gunhash, price = v.price}
        end 
    end
end
end) 
Wait(10)
TriggerClientEvent("VIP:GUNSRETURNED", source,table)
end)