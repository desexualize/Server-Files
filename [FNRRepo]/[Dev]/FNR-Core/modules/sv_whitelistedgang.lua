local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP_gunshop")



function getMoneyStringFormatted(cashString)
	local i, j, minus, int, fraction = tostring(cashString):find('([-]?)(%d+)([.]?%d*)')
	int = int:reverse():gsub("(%d%d%d)", "%1,")
	return minus .. int:reverse():gsub("^,", "") .. fraction 
end




RegisterServerEvent("WHITELISTEDGANGS:BuyWeapon")
AddEventHandler('WHITELISTEDGANGS:BuyWeapon', function(hash)
    local source = source
    local user_id = vRP.getUserId({source})
    if user_id ~= nil then
        if vRP.hasGroup({user_id, "GANGWHITELIST"}) then
            for k, v in pairs(whitelists.WHITELISTEDGANGS) do
                if v.gunhash == hash then
                    print(hash)
                    if vRP.tryPayment({user_id, v.price}) then
                        vRPclient.giveWeapons(source,{{[v.gunhash] = {ammo=250}}})
                        vRPclient.notify(source, {"~g~Paid £"..getMoneyStringFormatted(v.price)})
                        TriggerClientEvent("FNR:PlaySound", source, 1)
                    end
                end
            end
        end
    end
end)

RegisterNetEvent("WHITELISTEDGANGS:BuyWeaponAmmo")
AddEventHandler("WHITELISTEDGANGS:BuyWeaponAmmo", function(hash)
    local source = source
    local user_id = vRP.getUserId({source})
    if user_id ~= nil then
        for k, v in pairs(whitelists.WHITELISTEDGANGS) do
             if v.gunhash == hash then
                if vRP.tryPayment({user_id, v.price / 2}) then
                    vRPclient.giveWeaponAmmo(source,{v.gunhash, 250})
                    vRPclient.notify(source, {"~g~Paid £"..tostring(getMoneyStringFormatted(v.price/2))})
                    TriggerClientEvent("FNR:PlaySound", source, 1)
                 end
            end
        end
    end
end)

RegisterServerEvent("WHITELISTEDGANGS:PULLWHITELISTEDWEAPONS")
AddEventHandler("WHITELISTEDGANGS:PULLWHITELISTEDWEAPONS", function()
    local source = source
    local table = {}
    local user_id = vRP.getUserId({source})
    for i,v in pairs(whitelists.WHITELISTEDGANGS) do
        if v.permid == user_id then 
            table[i] = {name = v.name, gunhash = v.gunhash, price = v.price}
        end 
    end 
    Wait(0)
    TriggerClientEvent("WHITELISTEDGANGS:GUNSRETURNED", source, table)
end)


RegisterNetEvent('sendWhitelistedgang')
AddEventHandler('sendWhitelistedgang', function()
    user_id = vRP.getUserId({source})
    if vRP.hasGroup({user_id, 'GANGWHITELIST'}) then 
        TriggerClientEvent('returnsendWhitelistedgang', source, true)
    else
        TriggerClientEvent('returnsendWhitelistedgang', source, false)
    end
end)


