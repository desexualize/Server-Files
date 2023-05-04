local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local vRP = Proxy.getInterface("vRP")
local vRPclient = Tunnel.getInterface("vRP", 'CrateDrop')

local Crate_Spawn_Coords = {
    vector3(1865.0517578125, 294.37481689453, 168.91744995117 + 1600),
    vector3(2945.5515136719, 2795.4934082031, 40.646308898926 + 1600),
    vector3(-1627.5288085938, 720.173828125, 192.08515930176 + 1600),
    vector3(-62.860485076904, -2493.8740234375, 6.0251984596252 + 1600),
}

local Crate_Create_Wait_Minutes = 60 -- How Long till the first drop is created
local Crate_Remove_Wait_Minutes = 60 --How long till the airdrop disappears
local Crate_Looted_Wait_Minutes = 5 -- How long should the crate stay after it is looted

local Items_Amount = 600 --How many items are in the crate
local Crate_Used = false
local Crate_Being_Looted = false

local Crate_Drop_Message = "An airdrop is landing..."
local Crate_Remove_Message = "The airdrop has vanished..."
local Crate_Being_Looted_Message = 'The airdrop is being looted!'
local Crate_Looted_Message = "The airdrop has been Looted!"

local Available_Items = {
    {"wammo|WEAPON_m1911", "9 mm Bullets", 250, 0.01},
    {"wbody|WEAPON_m1911", "Weapon_m1911 body", 1, 2.5},
    {"wammo|WEAPON_ak74", "7.62 mm Bullets", 250, 0.01},
}

local Crate_Current_Loot = {}

RegisterServerEvent('Nova:Server:CrateBeingLooted')
AddEventHandler('Nova:Server:CrateBeingLooted', function()
    if not Crate_Being_Looted then
        Crate_Being_Looted = true
        TriggerClientEvent('chatMessage', -1, "[Nova]:", {255, 255, 255}, Crate_Being_Looted_Message, "alert")
    end
end)

RegisterServerEvent("Nova:Server:OpenLootCrate") 
AddEventHandler("Nova:Server:OpenLootCrate", function(playerCoords, boxCoords)
    local source = source
    local user_id = vRP.getUserId({source})

    if #(playerCoords - boxCoords) < 2.0 then
        if not Crate_Used then
            Crate_Used = true
            vRP.giveInventoryItem({user_id, "wbody|" .. "WEAPON_MOSIN", 1, true})
            vRP.giveInventoryItem({user_id, "7.62 Bullets", 250, true})

            vRP.giveInventoryItem({user_id, "wbody|" .. "WEAPON_HK45", 1, true})
            vRP.giveInventoryItem({user_id, "9mm Bullets", 250, true})
            vRP.giveInventoryItem({user_id, "body_armor", 3, true})
            vRPclient.notify(source, {"Received ~g~£200,000 ~w~Cash."})
            vRP.giveMoney({user_id, 200000})

            TriggerClientEvent('chatMessage', -1, "[Nova]:", {255, 255, 255}, Crate_Looted_Message, "alert")

            --[[
            TriggerClientEvent(
                "chat:addMessage",
                -1,
                {
                    template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(255, 0, 0, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> Supply Drops^7: ' ..
                        Crate_Looted_Message .. "</div>",
                    args = {playerName, msg}
                }
            )
            ]]

            Citizen.Wait(Crate_Looted_Wait_Minutes * 60 * 1000)
            TriggerClientEvent("Nova:Client:RemoveCrate", -1)
            TriggerClientEvent('chatMessage', -1, "[Nova]:", {255, 255, 255}, Crate_Remove_Message, "alert")
        end
    end
end)

RegisterServerEvent('Nova:Server:UpdateLoot')
AddEventHandler('Nova:Server:UpdateLoot', function(source, item, amount)
    local i = Crate_Current_Loot[item]
    local j = i[2] - amount
    if (j > 0) then
        Crate_Current_Loot[item] = {i[1], j, i[3]}
    else
        Crate_Current_Loot[item] = nil
    end

    if #Crate_Current_Loot == 0 then
        if not Crate_Used then
            Crate_Used = true
            TriggerClientEvent("chatMessage", -1, "[Nova]:", {255, 255, 255}, Crate_Looted_Message, "alert")
        end
    end

    TriggerClientEvent(
        "Nova:SendSecondaryInventoryData",
        source,
        Crate_Current_Loot,
        vRP.computeItemsWeight({Crate_Current_Loot}),
        30
    )
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Crate_Create_Wait_Minutes * 60 * 1000) -- From Minutes to milliseconds

        if #GetPlayers() >= 1 then
            local num = math.random(1, #Crate_Spawn_Coords)
            local new_crate_coords = Crate_Spawn_Coords[num]

            for i = 1, Items_Amount do
                local secondNum = math.random(1, #Available_Items)
                local k = Available_Items[secondNum]
                Crate_Current_Loot[k[1]] = {k[2], k[3], k[4]}
            end

            TriggerClientEvent("Nova:Client:NewCrateDrop", -1, new_crate_coords)
            TriggerClientEvent('chatMessage', -1, "[Nova]:", {255, 255, 255}, Crate_Drop_Message, "alert")

            --[[
            TriggerClientEvent("chat:addMessage", -1,
                {
                    template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(255, 0, 0, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> Supply Drops^7: ' ..
                    Crate_Drop_Message .. "</div>",
                    args = {playerName, msg}
                }
            )
            ]]
            Crate_Used = false
            Crate_Being_Looted = false
        end

        Citizen.Wait(Crate_Remove_Wait_Minutes * 60 * 1000) -- From Minutes to milliseconds
        TriggerClientEvent("Nova:Client:RemoveCrate", -1)
    end
end)