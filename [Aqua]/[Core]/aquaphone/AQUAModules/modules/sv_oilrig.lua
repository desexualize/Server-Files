local Tunnel = module('AQUA', 'lib/Tunnel')
local Proxy = module('AQUA', 'lib/Proxy')
AQUA = Proxy.getInterface("AQUA")
AQUAclient = Tunnel.getInterface("AQUA", "AQUA_gunshop")


local Coords = { 
    vector3(-1716.6901855469,8880.7080078125,27.359914779663+600), -- Oil RIG
   
}



local stayTime = 900 -- How long till the airdrop disappears (15 mins)
local spawnTime = 3600 -- How long between crate spawns (60 mins)
local amountOffItems = 600 --How many items are in the crate 
local used = false

local dropMsg = "A crate drop has been spotted at oilrig..."
local removeMsg = "A Mali Pirate stole the loot..."
local lootedMsg = "Someone got the loot!"

local currentLoot = {}

RegisterServerEvent('openRigCrate', function(playerCoords, boxCoords)
    local source = source
    user_id = AQUA.getUserId({source})
    if #(playerCoords - boxCoords) < 2.0 then
        if not used then
                used = true
                lootrandom = math.random(1, 3)

                if lootrandom == 1 then -- [Legendary]
                    -- [Legendary]
                    AQUA.giveInventoryItem({user_id, "wbody|" .. 'WEAPON_SCORPIANBLUE', 1, true})
                    AQUA.giveInventoryItem({user_id, '9mm Bullets', 250, true})

                    AQUA.giveInventoryItem({user_id, "wbody|" .. 'WEAPON_CHERRYMOSIN', 1, true})
                    AQUA.giveInventoryItem({user_id, '7,62 Bullets', 250, true})
                    AQUAclient.notify(source,{'Received ~g~£1,000,000 Cash.'})
                    AQUA.giveMoney({user_id,1000000})

                    TriggerClientEvent('chat:addMessage', -1, {
                        template = ' OIL RIG^7: ' .. 'The Drop has been Looted. [Rarity: ^3Legendary^0]' .. '</div>',
                        args = { playerName, msg }
                    })
                elseif lootrandom == 2 then 
                    -- [Epic]
                    AQUA.giveInventoryItem({user_id, "wbody|" .. 'WEAPON_NERFMOSIN', 1, true})
                    AQUA.giveInventoryItem({user_id, '7.62 Bullets', 250, true})

                    AQUA.giveInventoryItem({user_id, "wbody|" .. 'WEAPON_GOLDAK', 1, true})
                    AQUAclient.notify(source,{'Received ~g~£700,000 Cash.'})
                    AQUA.giveMoney({user_id,7000000})
                    TriggerClientEvent('chat:addMessage', -1, {
                        template = ' OIL RIG^7: ' .. 'The Drop has been Looted. [Rarity: ^6Epic^0]' .. '</div>',
                        args = { playerName, msg }
                    })

                elseif lootrandom == 3 then 
                    -- [Uncommon]
                    AQUA.giveInventoryItem({user_id, "wbody|" .. 'WEAPON_VESPER', 1, true})
                    AQUA.giveInventoryItem({user_id, '9mm Bullets', 250, true})

                    AQUA.giveInventoryItem({user_id, "wbody|" .. 'WEAPON_USPSKILLCONFIRMED', 1, true})
                    AQUA.giveInventoryItem({user_id, '9mm Bullets', 50, true})
                    AQUAclient.notify(source,{'Received ~g~£450,000 Cash.'})
                    AQUA.giveMoney({user_id,450000})
                    TriggerClientEvent('chat:addMessage', -1, {
                        template = ' OIL RIG^7: ' .. 'The Drop has been Looted. [Rarity: ^5Uncommon^0]' .. '</div>',
                        args = { playerName, msg }
                    })
                elseif lootrandom == 4 then 
                    -- [Common]
                    AQUA.giveInventoryItem({user_id, "wbody|" .. 'WEAPON_BROOM', 1, true})

                    AQUA.giveInventoryItem({user_id, "wbody|" .. 'WEAPON_UMP45', 1, true})
                    AQUA.giveInventoryItem({user_id, '9mm Bullets', 250, true})
                    AQUAclient.notify(source,{'Received ~g~£200,00 Cash.'})
                    AQUA.giveMoney({user_id,200000})
                    TriggerClientEvent('chat:addMessage', -1, {
                        template = ' OIL RIG^7: ' .. 'The Drop has been Looted. [Rarity: ^9Common^0]' .. '</div>',
                        args = { playerName, msg }
                    })
                end
                
          TriggerClientEvent("removeRIG", -1)
        end
    end
end)


RegisterServerEvent('updateRigLoot', function(source, item, amount)
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
            TriggerClientEvent('chatMessage', -1, "^0OIL RIG │ ^0 ", {255, 255, 255}, lootedMsg, "alert")
        end
    end

            TriggerClientEvent('AQUA:SendSecondaryInventoryData', source, currentLoot, AQUA.computeItemsWeight({currentLoot}), 30)
end) 

Citizen.CreateThread(function()
    while (true) do
        Wait(10800000)
        local num = math.random(1, #Coords)
        local coords = Coords[num]
        if #GetPlayers() > 10 then
            TriggerClientEvent('OilRig', -1, coords)
            TriggerClientEvent('chatMessage', -1, "^0OIL RIG │ ^0", {255, 255, 255}, dropMsg, "alert")
        end
        used = false
    end
end)



RegisterCommand('oilrig', function(source, args, RawCommand)
    local user_id = AQUA.getUserId({source})
    local num = math.random(1, #Coords)
    local coords = Coords[num]
    if user_id == 1 or user_id == 2 or user_id == 3 or user_id == 10 then
        TriggerClientEvent('OilRig', -1, coords)
        TriggerClientEvent('chatMessage', -1, "^0OIL RIG │ ^0", {255, 255, 255}, dropMsg, "alert")

    used = false
    end
end)
