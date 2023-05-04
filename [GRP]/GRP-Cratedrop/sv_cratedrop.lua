local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP_gunshop")


local Coords = { --Where you want the crate to spawn ALL MESSAGES YOU CAN DELETE AFTER (WOLFHILL)
    vector3(1865.0517578125,294.37481689453,168.91744995117+1600),
    vector3(2945.5515136719,2795.4934082031,40.646308898926+1600),
    vector3(-1627.5288085938,720.173828125,192.08515930176+1600),
    vector3(-62.860485076904,-2493.8740234375,6.0251984596252+1600),
}

local stayTime = 3600 --How long till the airdrop disappears
local spawnTime = 120
local amountOffItems = 600 --How many items are in the crate 
local used = false

local dropMsg = "An airdrop is landing..."
local removeMsg = "The airdrop has vanished..."
local lootedMsg = "Someone looted the airdrop!"

local avaliableItems = { --Where you put you weapons and how frequently you want them to spawn E.G M1911 with its ammo. and put that in there twice and akm once the m1911 will have more chance of spawning
    {"wammo|WEAPON_m1911", "9 mm Bullets", 250, 0.01},
    {"wbody|WEAPON_m1911", "Weapon_m1911 body", 1, 2.5},
    {"wammo|WEAPON_ak74", "7.62 mm Bullets", 250, 0.01},
}

local currentLoot = {}

RegisterServerEvent('openLootCrate', function(playerCoords, boxCoords)
    local source = source
    user_id = vRP.getUserId({source})
    if #(playerCoords - boxCoords) < 2.0 then
        if not used then
            
                used = true
                vRP.giveInventoryItem({user_id, "wbody|" .. 'WEAPON_MOSIN', 1, true})
                vRP.giveInventoryItem({user_id, '7.62 Bullets', 250, true})

                vRP.giveInventoryItem({user_id, "wbody|" .. 'WEAPON_HK45', 1, true})
                vRP.giveInventoryItem({user_id, '9mm Bullets', 250, true})
                vRP.giveInventoryItem({user_id, "body_armor", 3, true})
                vRPclient.notify(source,{'Received ~g~£200,000 ~w~Cash.'})
                vRP.giveMoney({user_id,200000})
                
                --TriggerClientEvent('chatMessage', -1, "^1[Galaxy RP]: ^0 ", {66, 72, 245}, "The Drop has been Looted.", "alert")
        TriggerClientEvent('chat:addMessage', -1, {
            template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(255, 0, 0, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> Supply Drops^7: ' .. 'The Drop has been Looted.' .. '</div>',
            args = { playerName, msg }
          })
          Citizen.Wait(300*1000)
          TriggerClientEvent("removeCrate", -1)
        end
    end
end)

RegisterServerEvent('updateLoot', function(source, item, amount)
    local i = currentLoot[item]
    local j = i[2] - amount
    if (j > 0) then
        currentLoot[item] = {i[1], j, i[3]}
    else
        currentLoot[item] = nil
    end

    if #currentLoot == 0 then
        if not used then
            used = true
            TriggerClientEvent('chatMessage', -1, "^1[Galaxy RP]: ^0 ", {66, 72, 245}, lootedMsg, "alert")
        end
    end

            TriggerClientEvent('Galaxy:SendSecondaryInventoryData', source, currentLoot, vRP.computeItemsWeight({currentLoot}), 30)
end) 

Citizen.CreateThread(function()
    while (true) do
        Wait(1000 * 3600)
        if GetActivePlayers() >= 10 then
            local num = math.random(1, #Coords)
            local coords = Coords[num]

            for i = 1, amountOffItems do
                local secondNum = math.random(1, #avaliableItems)
                local k = avaliableItems[secondNum]
                currentLoot[k[1]] = {k[2], k[3], k[4]}
            end 

            TriggerClientEvent('crateDrop', -1, coords)
            --TriggerClientEvent('chatMessage', -1, "^1[Galaxy RP]: ^0", {66, 72, 245}, dropMsg, "alert")
            TriggerClientEvent('chat:addMessage', -1, {
                template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(255, 0, 0, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> Supply Drops^7: ' .. dropMsg .. '</div>',
                args = { playerName, msg }
              })
            used = false
        end
        -- Citizen.SetTimeout(stayTime * 1000, function()
        --     TriggerClientEvent("removeCrate", -1)
        --     TriggerClientEvent('chatMessage', -1, "^1[Galaxy RP]: ^0 ", {66, 72, 245}, removeMsg, "alert")
        -- end)

        -- Wait(stayTime * 1000 + 500)
        Wait(1000 * 3600)
        TriggerClientEvent("removeCrate", -1)
        Wait(1000)
    end
end)
