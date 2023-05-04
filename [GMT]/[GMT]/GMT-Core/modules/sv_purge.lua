local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface("vRP")

RegisterServerEvent("GMT:activatePurgeSV")
AddEventHandler("GMT:activatePurgeSV", function(purge)
    local source = source
    local user_id = vRP.getUserId({source})
    if vRP.hasPermission({user_id, 'dev.menu'}) then
        if purge then
            TriggerClientEvent('GMT:activatePurge', source)
        end
    end
end) 


RegisterNetEvent("GMT:purgeRespawn")
AddEventHandler("GMT:purgeRespawn", function()
    if purge then
        math.randomseed(GetGameTimer())
        randomweapon = math.random(1,#weapons)
        randomcoords = math.random(1,#coords)
        local a = weapons[randomweapon]
        print(weapons[randomweapon])
       tvRP.allowWeapon(weapons[randomweapon])
      
        tvRP.giveWeapons(weapons[randomweapon], false)
        SetEntityCoords(PlayerPedId(), coords[randomcoords])
    else
        print('Player is cheating')
    end
end)