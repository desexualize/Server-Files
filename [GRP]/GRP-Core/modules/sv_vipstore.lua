local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP_gunshop")

RegisterServerEvent("GRP:Whitelist")
AddEventHandler('GRP:Whitelist', function(whitelist)
    local source = source
    userid = vRP.getUserId({source})
    --if vRP.hasGroup({userid, 'VIP'}) then
        if whitelist == "1" then
            vRPclient.notify(source,{"~g~Given Weapon Whitelist. ~w~ID: ~r~" .. whitelist})
            -- [WEAPON GIVE]
        end
        if whitelist == "RJB392" then
            vRPclient.notify(source,{"~g~Given Weapon Whitelist. ~w~ID: ~r~" .. whitelist})
            -- [WEAPON GIVE]
        end
    --end
end)



--vRP.Weapons = {}

--vRP.Weapons[source] = {GetHashKey('WEAPON_AK200')} -- add this onto server side wherever you give the client weapons

