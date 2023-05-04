local Tunnel = module('AQUA', 'lib/Tunnel')
local Proxy = module('AQUA', 'lib/Proxy')
AQUA = Proxy.getInterface("AQUA")

RegisterServerEvent("AQUA:activatePurgeSV")
AddEventHandler("AQUA:activatePurgeSV", function(purge)
    local source = source
    local user_id = AQUA.getUserId({source})
    if AQUA.hasPermission({user_id, 'dev.menu'}) then
        if purge then
            TriggerClientEvent('AQUA:activatePurge', source)
        end
    end
end) 


RegisterNetEvent("AQUA:purgeRespawn")
AddEventHandler("AQUA:purgeRespawn", function()
    if purge then
        math.randomseed(GetGameTimer())
        randomweapon = math.random(1,#weapons)
        randomcoords = math.random(1,#coords)
        local a = weapons[randomweapon]
        print(weapons[randomweapon])
       tAQUA.allowWeapon(weapons[randomweapon])
      
        tAQUA.giveWeapons(weapons[randomweapon], false)
        SetEntityCoords(PlayerPedId(), coords[randomcoords])
    else
        print('Player is cheating')
    end
end)