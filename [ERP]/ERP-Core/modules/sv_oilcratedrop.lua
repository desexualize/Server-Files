local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP_gunshop")


local Coords = { --Where you want the crate to spawn ALL MESSAGES YOU CAN DELETE AFTER (WOLFHILL)
    vector3(-1717.25,8880.02734375,27.359891891479)
}

local stayTime = 3600 --How long till the airdrop disappears
local spawnTime = 180
local amountOffItems = 600 --How many items are in the crate 
local used = false

local dropMsg = "Oil Rig care package is landing..."
local removeMsg = "Oil Rig care package has vanished..."
local lootedMsg = "Someone looted Oil Rig care package!"
local looteddrop = "The Drop has been Looted."
local avaliableItems = { --Where you put you weapons and how frequently you want them to spawn E.G M1911 with its ammo. and put that in there twice and akm once the m1911 will have more chance of spawning
    {"wammo|WEAPON_m1911", "9 mm Bullets", 250, 0.01},
    {"wbody|WEAPON_m1911", "Weapon_m1911 body", 1, 2.5},
    {"wammo|WEAPON_ak74", "7.62 mm Bullets", 250, 0.01},
}

local currentLoot = {}

RegisterServerEvent('OilopenLootCrate', function(playerCoords, boxCoords)
    local source = source
    user_id = vRP.getUserId({source})
    if #(playerCoords - boxCoords) < 2.0 then
        if not used then
            
                used = true
                vRP.giveInventoryItem({user_id, "wbody|" .. 'WEAPON_NERFMOSIN', 1, true})
                vRP.giveInventoryItem({user_id, '7.62 Bullets', 50, true})
                vRP.giveInventoryItem({user_id, "body_armor", 1, true})

                TriggerClientEvent("OilremoveCrate", -1)
                TriggerClientEvent('chat:addMessage', -1, {
                    template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(255,0,0, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> ^7 {0}: {1}</div>',
                    args = { "^7[Drop Zone]", looteddrop }
                  })
                TriggerClientEvent('chatMessage', -1, "^1AirDrop: ^0 ", {66, 72, 245}, "The Drop has been Looted.", "drop") --Chat message change if you want
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
            TriggerClientEvent('chat:addMessage', -1, {
                template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(255,0,0, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> ^7 {0}: {1}</div>',
                args = { "^7[Drop Zone]", lootedMsg }
              })
            TriggerClientEvent('chatMessage', -1, "^1AirDrop: ^0 ", {66, 72, 245}, lootedMsg, "drop")
        end
    end

            TriggerClientEvent('Inventory:SendSecondaryInventoryData', source, currentLoot, vRP.computeItemsWeight({currentLoot}), 30)
end) 

Citizen.CreateThread(function()
    while (true) do
        Wait(spawnTime * 1000)

        local num = math.random(1, #Coords)
        local coords = Coords[num]

        for i = 1, amountOffItems do
            local secondNum = math.random(1, #avaliableItems)
            local k = avaliableItems[secondNum]
            currentLoot[k[1]] = {k[2], k[3], k[4]}
        end 

        TriggerClientEvent('OilcrateDrop', -1, coords)
          TriggerClientEvent('chat:addMessage', -1, {
            template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(255,0,0, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> ^7 {0}: {1}</div>',
            args = { "^7[Drop Zone]", dropMsg }
          })
        TriggerClientEvent('chatMessage', -1, "^1AirDrop: ^0", {66, 72, 245}, dropMsg, "drop")
        used = false

        Citizen.SetTimeout(stayTime * 1000, function()
        TriggerClientEvent("OilremoveCrate", -1)
        TriggerClientEvent('chat:addMessage', -1, {
            template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(255,0,0, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> ^7 {0}: {1}</div>',
            args = { "^7[Drop Zone]", removeMsg }
          })
        TriggerClientEvent('chatMessage', -1, "^1AirDrop: ^0 ", {66, 72, 245}, removeMsg, "drop")
        end)

        Wait(stayTime * 1000 + 500)
    end
end)