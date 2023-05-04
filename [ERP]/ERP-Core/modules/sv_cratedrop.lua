local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP_gunshop")


local Coords = {
    vector3(1865.0517578125,294.37481689453,168.91744995117+600),
    vector3(120.09413909912,6918.2944335938,21.275566101074+600),
    vector3(2689.6569824219,1484.3740234375,24.57213973999+600),
    vector3(1544.5241699219,-2103.0690917969,77.245864868164+600),
    vector3(-1788.9268798828,3167.6887207031,32.9303855896+600),
    vector3(988.55065917969,-547.29412841797,59.633190155029+600),
    vector3(1664.8455810547,-28.379615783691,196.93627929688+600),
    vector3(1883.6683349609,993.62280273438,276.12557983398+600),
    vector3(2827.2456054688,1472.5734863281,28.68924331665+600),
    vector3(3291.6857910156,3143.8767089844,253.32929992676+600),
    vector3(3695.1235351562,4938.8447265625,20.034393310547+600),
}

local stayTime = 3600 --How long till the airdrop disappears
local spawnTime = 500
local amountOffItems = 600 --How many items are in the crate 
local used = false

local dropMsg = "An airdrop is landing..."
local removeMsg = "The airdrop has vanished..."
local lootedMsg = "Someone looted the airdrop!"
local looteddrop = "The Drop has been Looted."
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
                vRP.giveInventoryItem({user_id, "wbody|" .. 'WEAPON_NERFMOSIN', 1, true})
                vRP.giveInventoryItem({user_id, '7.62 Bullets', 250, true})
                vRP.giveInventoryItem({user_id, "body_armor", 1, true})

                TriggerClientEvent("removeCrate", -1)
                TriggerClientEvent('chat:addMessage', -1, {
                    template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(255,0,0, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> ^7 {0}: {1}</div>',
                    args = { "^7[Drop Zone]", looteddrop }
                  })
                TriggerClientEvent('chatMessage', -1, "^1Drop Zone: ^0 ", {66, 72, 245}, "The Drop has been Looted.", "alert") --Chat message change if you want
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
            TriggerClientEvent('chatMessage', -1, "^1Drop Zone: ^0 ", {66, 72, 245}, lootedMsg, "alert")
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

        TriggerClientEvent('crateDrop', -1, coords)
        TriggerClientEvent('chat:addMessage', -1, {
            color = { 255, 0, 0},
            multiline = true,
            args = {"[Drop Zone]", dropMsg}
          })
        TriggerClientEvent('chatMessage', -1, "^1Drop Zone: ^0", {66, 72, 245}, dropMsg, "alert")
        used = false

        Citizen.SetTimeout(stayTime * 1000, function()
        TriggerClientEvent("removeCrate", -1)
        TriggerClientEvent('chat:addMessage', -1, {
            template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(255,0,0, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> ^7 {0}: {1}</div>',
            args = { "^7[Drop Zone]", removeMsg }
          })
        TriggerClientEvent('chatMessage', -1, "^1Drop Zone: ^0 ", {66, 72, 245}, removeMsg, "alert")
        end)

        Wait(stayTime * 1000 + 500)
    end
end)
