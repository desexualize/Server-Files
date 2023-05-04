local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP_gunshop")



function getMoneyStringFormatted(cashString)
	local i, j, minus, int, fraction = tostring(cashString):find('([-]?)(%d+)([.]?%d*)')
	int = int:reverse():gsub("(%d%d%d)", "%1,")
	return minus .. int:reverse():gsub("^,", "") .. fraction 
end




RegisterServerEvent("VIP:BuyWeapon")
AddEventHandler('VIP:BuyWeapon', function(hash)
    local source = source
    local user_id = vRP.getUserId({source})
    if user_id ~= nil then
        if vRP.hasPermission({user_id, VIP.perm}) then
            for k, v in pairs(VIP.guns) do
                if v.hash == hash then
                    if vRP.tryPayment({user_id, v.price}) then
                        vRPclient.giveWeapons(source,{{[v.hash] = {ammo=250}}})
                        vRPclient.notify(source, {"~g~Paid £"..getMoneyStringFormatted(v.price)})
                        TriggerClientEvent("FNR:PlaySound", source, 1)
                    else 
                        TriggerClientEvent("FNR:PlaySound", source, 2)
                        vRPclient.notify(source, {"~r~Insufficient funds"})
                    end
                end
            end
        else
            vRPclient.notify(source, {"~r~You do not have permission to purchase guns from here 🤦‍♂️"})
            TriggerClientEvent("FNR:PlaySound", source, 2)
        end
    end
end)

RegisterServerEvent("VIP:BuyWLWeapon")
AddEventHandler('VIP:BuyWLWeapon', function(hash)
    local source = source
    local user_id = vRP.getUserId({source})
    if user_id ~= nil then
        if vRP.hasPermission({user_id, VIP.perm}) then
            exports['ghmattimysql']:execute("SELECT * FROM `weapon_whitelists` WHERE permid = @permid", {permid = user_id}, function(result)
            for k, v in pairs(result) do
                if v.category == "large" then
                if v.gunhash == hash then
                    local price = v.price
                    if vRP.tryPayment({user_id, tonumber(price)}) then
                        vRPclient.giveWeapons(source,{{[hash] = {ammo=250}}})
                        vRPclient.notify(source, {"~g~Paid £"..getMoneyStringFormatted(v.price)})
                        TriggerClientEvent("FNR:PlaySound", source, 1)
                    else 
                        TriggerClientEvent("FNR:PlaySound", source, 2)
                        vRPclient.notify(source, {"~r~Insufficient funds"})
                    end
                end
            end
        end
            end)
        else
            vRPclient.notify(source, {"~r~You do not have permission to purchase guns from here 🤦‍♂️"})
            TriggerClientEvent("FNR:PlaySound", source, 2)
        end
    end
end)
RegisterServerEvent("VIP:BuyArmour")
AddEventHandler('VIP:BuyArmour', function()
    local user_id = vRP.getUserId({source})
    local currentArmour = GetPedArmour(GetPlayerPed(source))

    if user_id ~= nil then 
        if vRP.hasPermission({user_id, VIP.perm}) and vRP.hasPermission({user_id, "rebel.guns"}) then
            if currentArmour < 100 then
                if vRP.tryPayment({user_id, VIP.maxArmourPrice}) then
                    vRPclient.setArmour(source,{100})
                    TriggerClientEvent("FNR:PlaySound", source, 1)
                    vRPclient.notify(source, {"~g~Paid £"..tostring(getMoneyStringFormatted(VIP.maxArmourPrice))})
                else 
                    TriggerClientEvent("FNR:PlaySound", source, 2)
                    vRPclient.notify(source, {"~r~Insufficient funds"})
                end
            else
                vRPclient.notify(source,{"~r~You already have 100% armour."})
            end
        else
            vRPclient.notify(source, {"~r~You do not have permission to purchase armour from here 🤦‍♂️"})
            TriggerClientEvent("FNR:PlaySound", source, 2)
        end
    end
end)

RegisterServerEvent("VIP:ReplenishArmour")
AddEventHandler('VIP:ReplenishArmour', function()
    local user_id = vRP.getUserId({source})

    if user_id ~= nil then 
        if vRP.hasPermission({user_id, VIP.perm}) and vRP.hasPermission({user_id, "rebel.guns"}) then
            local currentArmour = GetPedArmour(GetPlayerPed(source))
            local newArmour = 100 - currentArmour
            local price = newArmour * 1000

            if newArmour ~= 0 then
                if vRP.tryPayment({user_id, price}) then
                    vRPclient.setArmour(source,{100})
                    TriggerClientEvent("FNR:PlaySound", source, 1)
                    vRPclient.notify(source, {"~g~Paid £"..tostring(getMoneyStringFormatted(price))})
                else 
                    TriggerClientEvent("FNR:PlaySound", source, 2)
                    vRPclient.notify(source, {"~r~Insufficient funds"})
                end
            else
                vRPclient.notify(source,{"~r~You already have 100% armour."})
            end
        else
            vRPclient.notify(source, {"~r~You do not have permission to purchase armour from here 🤦‍♂️"})
            TriggerClientEvent("FNR:PlaySound", source, 2)
        end
    end
end)

RegisterNetEvent("VIP:BuyWeaponAmmo")
AddEventHandler("VIP:BuyWeaponAmmo", function(hash)
    local source = source
    local user_id = vRP.getUserId({source})

    if user_id ~= nil then
        for k, v in pairs(VIP.guns) do
             if v.hash == hash then
                if vRP.tryPayment({user_id, v.price / 2}) then
                    vRPclient.giveWeaponAmmo(source,{v.hash, 250})
                    vRPclient.notify(source, {"~g~Paid £"..tostring(getMoneyStringFormatted(v.price/2))})
                    TriggerClientEvent("FNR:PlaySound", source, 1)
                else 
                    TriggerClientEvent("SmallArms:Error", source, false)
                    vRPclient.notify(source, {"~r~Insufficient funds"})
                    TriggerClientEvent("FNR:PlaySound", source, 2)
                 end
            end
        end
    end
end)

RegisterNetEvent("VIP:BuyWeaponAmmo2")
AddEventHandler("VIP:BuyWeaponAmmo2", function(hash)
    local source = source
    local user_id = vRP.getUserId({source})

    if user_id ~= nil then
        exports['ghmattimysql']:execute("SELECT * FROM `weapon_whitelists` WHERE permid = @permid", {permid = user_id}, function(result)
            for k, v in pairs(result) do
                if v.category == "large" then
             if v.gunhash == hash then
                if vRP.tryPayment({user_id, tonumber(v.price / 2)}) then
                    vRPclient.giveWeaponAmmo(source,{v.gunhash, 250})
                    vRPclient.notify(source, {"~g~Paid £"..tostring(getMoneyStringFormatted(v.price/2))})
                    TriggerClientEvent("FNR:PlaySound", source, 1)
                else 
                    TriggerClientEvent("SmallArms:Error", source, false)
                    vRPclient.notify(source, {"~r~Insufficient funds"})
                    TriggerClientEvent("FNR:PlaySound", source, 2)
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
    local permid = vRP.getUserId({source})
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