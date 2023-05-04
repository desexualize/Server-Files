local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP_gunshop")


local Coords = { --Where you want the crate to spawn ALL MESSAGES YOU CAN DELETE AFTER (WOLFHILL)
    vector3(1875.6557617188,285.75283813477,164.30514526367+600), -- dam
    vector3(497.82528686523,5591.2626953125,795.06719970703+600), -- mountain
    vector3(2482.0278320313,1580.984375,32.720272064209+600+600), -- random
    vector3(1544.5241699219,-2103.0690917969,77.245864868164+600), -- random
    vector3(-1788.9268798828,3167.6887207031,32.9303855896+600), -- mill base
    vector3(3526.802734375,3727.2807617188,36.446506500244+600), -- H
    vector3(1082.3488769531,3026.6711425781,41.05823135376+600), -- sandy air strip
    vector3(172.59869384766,-3020.3715820312,5.8506226539612+600), -- bottom map
    vector3(2563.6027832031,-353.79022216797,92.994750976562+600), -- LSD
    vector3(201.96899414062,7008.3798828125,2.1106307506561+600), -- Paleto Beach
    vector3(1968.7473144531,4728.4189453125,41.02095413208+600), -- LSD ATM
}



local stayTime = 900 -- How long till the airdrop disappears (15 mins)
local spawnTime = 3600 -- How long between crate spawns (60 mins)
local amountOffItems = 600 --How many items are in the crate 
local used = false

local dropMsg = "An airdrop is landing..."
local removeMsg = "The airdrop has vanished..."
local lootedMsg = "Someone looted the airdrop!"

local currentLoot = {}

RegisterServerEvent('openLootCrate', function(playerCoords, boxCoords)
    local source = source
    user_id = vRP.getUserId({source})
    if #(playerCoords - boxCoords) < 2.0 then
        if not used then
                used = true
                lootrandom = math.random(1, 3)

                if lootrandom == 1 then -- [Legendary]
                    -- [Legendary]
                    vRP.giveInventoryItem({user_id, "wbody|" .. 'WEAPON_MOSIN', 1, true})
                    vRP.giveInventoryItem({user_id, '7.62 Bullets', 250, true})

                    vRP.giveInventoryItem({user_id, "wbody|" .. 'WEAPON_SPAR16', 1, true})
                    vRP.giveInventoryItem({user_id, '5.56 NATO', 250, true})
                    vRPclient.notify(source,{'Received ~g~£400,000 Cash.'})
                    vRP.giveMoney({user_id,400000})

                    TriggerClientEvent('chat:addMessage', -1, {
                        template = ' Supply Drops^7: ' .. 'The Drop has been Looted. [Rarity: ^3Legendary^0]' .. '</div>',
                        args = { playerName, msg }
                    })
                elseif lootrandom == 2 then 
                    -- [Epic]
                    vRP.giveInventoryItem({user_id, "wbody|" .. 'WEAPON_MOSIN', 1, true})
                    vRP.giveInventoryItem({user_id, '7.62 Bullets', 250, true})

                    vRP.giveInventoryItem({user_id, "wbody|" .. 'WEAPON_UMP45', 1, true})
                    vRP.giveInventoryItem({user_id, '9mm Bullets', 250, true})
                    vRPclient.notify(source,{'Received ~g~£300,000 Cash.'})
                    vRP.giveMoney({user_id,300000})
                    TriggerClientEvent('chat:addMessage', -1, {
                        template = ' Supply Drops^7: ' .. 'The Drop has been Looted. [Rarity: ^6Epic^0]' .. '</div>',
                        args = { playerName, msg }
                    })

                elseif lootrandom == 3 then 
                    -- [Uncommon]
                    vRP.giveInventoryItem({user_id, "wbody|" .. 'WEAPON_UMP45', 1, true})
                    vRP.giveInventoryItem({user_id, '9mm Bullets', 250, true})

                    vRP.giveInventoryItem({user_id, "wbody|" .. 'WEAPON_M1911', 1, true})
                    vRP.giveInventoryItem({user_id, '9mm Bullets', 50, true})
                    vRPclient.notify(source,{'Received ~g~£200,000 Cash.'})
                    vRP.giveMoney({user_id,200000})
                    TriggerClientEvent('chat:addMessage', -1, {
                        template = ' Supply Drops^7: ' .. 'The Drop has been Looted. [Rarity: ^5Uncommon^0]' .. '</div>',
                        args = { playerName, msg }
                    })
               
                end
                
          TriggerClientEvent("removeCrate", -1)
        end
    end
end)


Citizen.CreateThread(function()
    while (true) do
        Wait(spawnTime * 1000)
        local num = math.random(1, #Coords)
        local coords = Coords[num]
        if #GetPlayers() > 5 then
            TriggerClientEvent('crateDrop', -1, coords)
            TriggerClientEvent('chatMessage', -1, "^0FNR │ ^0", {255, 255, 255}, dropMsg, "alert")
            TriggerClientEvent("vrp:PlaySound", -1, "supplydrop")
        end
        used = false
    end
end)



RegisterCommand('cratedrop', function(source, args, RawCommand)
    local user_id = vRP.getUserId({source})
    local num = math.random(1, #Coords)
    local coords = Coords[num]
    if user_id == 1 or user_id == 2 or user_id == 3  or user_id == 12 then
        TriggerClientEvent('crateDrop', -1, coords)
        TriggerClientEvent('chatMessage', -1, "^0FNR │ ^0", {255, 255, 255}, dropMsg, "alert")
        TriggerClientEvent("vrp:PlaySound", -1, "supplydrop")

    used = false
    end
end)
