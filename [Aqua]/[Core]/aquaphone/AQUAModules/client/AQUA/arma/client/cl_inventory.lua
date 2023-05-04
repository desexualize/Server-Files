drawInventoryUI = false
local a = false
local b = false
local c = false
local currentInventoryWeight = 0.00
local e = 0.00
local f = nil
local g = nil
local h = nil
local closeToRestart = false
local j = nil
local k = 0
local l = 0
local bulletsSelected = false
local bullets = {
    ["9mm Bullets"] = true,
    ["12 Gauge Bullets"] = true,
    [".308 Sniper Rounds"] = true,
    ["7.62mm Bullets"] = true,
    ["5.56mm NATO"] = true,
    [".357 Bullets"] = true,
    ["Police Issued 5.56mm"] = true,
    ["Police Issued .308 Sniper Rounds"] = true,
    ["Police Issued 9mm"] = true,
    [ "Police Issued 12 Gauge"] = true,
}

local BootCar = nil
local VehTypeC = nil
local VehTypeA = nil
local IsLootBagOpening = false
inventoryType = nil
local LootBagCrouchLoop = false
Citizen.CreateThread(function()
    while true do
        if IsControlJustPressed(0, 182) then
            if IsUsingKeyboard(2) and not tARMA.isInComa() and not tARMA.isHandcuffed() then
                TriggerServerEvent('ARMA:FetchPersonalInventory')
                if not closeToRestart then
                    drawInventoryUI = not drawInventoryUI
                    if drawInventoryUI then
                        setCursor(1)
                    else
                        setCursor(0)
                        inGUIARMA = false
                        if BootCar then
                            tARMA.vc_closeDoor(VehTypeC, 5)
                            BootCar = nil;
                            VehTypeC = nil;
                            VehTypeA = nil;
                            TriggerEvent('ARMA:clCloseTrunk')
                        end
                        inventoryType = nil
                    end
                else
                    tARMA.notify("~r~Cannot open inventory right before a restart!")
                end
            end
        end
        Wait(0)
    end
end)
ARMAItemList = {}
ARMASecondItemList = {}
function tARMA.getSpaceInFirstChest()
    return currentInventoryMaxWeight - currentInventoryWeight
end
function tARMA.getSpaceInSecondChest()
    local m = 0
    if next(ARMASecondItemList) == nil then
        return e
    else
        for n, o in pairs(ARMASecondItemList) do
            m = m + o.amount * o.Weight
        end
        return e - m
    end
end
RegisterNetEvent("ARMA:FetchPersonalInventory",function(inventory, weight, maxWeight)
    ARMAItemList = inventory
    currentInventoryWeight = weight
    currentInventoryMaxWeight = maxWeight
end)
RegisterNetEvent("ARMA:SendSecondaryInventoryData",function(p, q, r)
    ARMASecondItemList = p
    e = r
    c = true
    drawInventoryUI = true
    setCursor(1)
    if r then
        g = r
        h = GetEntityCoords(tARMA.getPlayerPed())
        if r == "notmytrunk" then
            j = GetEntityCoords(tARMA.getPlayerPed())
        end
        if string.match(r, "player_") then
            l = string.gsub(r, "player_", "")
        else
            l = 0
        end
    end
end)
RegisterNetEvent("ARMA:closeToRestart",function(p)
    closeToRestart = true
    Citizen.CreateThread(function()
        while true do
            ARMASecondItemList = {}
            c = false
            drawInventoryUI = false
            setCursor(0)
            Wait(50)
        end
    end)
end)
RegisterNetEvent("ARMA:closeSecondInventory",function()
    ARMASecondItemList = {}
    c = false
    drawInventoryUI = false
    g = nil
    setCursor(0)
end)
AddEventHandler("ARMA:clCloseTrunk",function()
    c = false
    drawInventoryUI = false
    g = nil
    setCursor(0)
    f = nil
    inGUIARMA = false
end)
AddEventHandler("ARMA:clOpenTrunk",function()
    local VehInRadius, VehType, NVeh = tARMA.getNearestOwnedVehicle(3.5)
    VehTypeA = VehType
    VehTypeC = NVeh
    if VehInRadius and IsPedInAnyVehicle(GetPlayerPed(-1), false) == false then 
        BootCar = GetEntityCoords(PlayerPedId())
        tARMA.vc_openDoor(VehType, 5)
        inventoryType = 'CarBoot'
        TriggerServerEvent('ARMA:FetchTrunkInventory', VehType)
    else
        tARMA.notify("~r~You don't have the keys to this vehicle!")
    end
end)
Citizen.CreateThread(function()
    while true do
        if f ~= nil and c then
            local z = GetEntityCoords(tARMA.getPlayerPed())
            local A = GetEntityCoords(f)
            local B = #(z - A)
            if B > 10.0 then
                TriggerEvent("ARMA:clCloseTrunk")
                TriggerServerEvent("ARMA:closeChest")
            end
        end
        if g == "house" and c then
            local z = GetEntityCoords(tARMA.getPlayerPed())
            local A = h
            local B = #(z - A)
            if B > 5.0 then
                TriggerEvent("ARMA:clCloseTrunk")
                TriggerServerEvent("ARMA:closeChest")
            end
        end
        if g == "notmytrunk" and c then
            local z = GetEntityCoords(tARMA.getPlayerPed())
            local A = j
            local B = #(z - A)
            if B > 5.0 then
                TriggerEvent("ARMA:clCloseTrunk")
                TriggerServerEvent("ARMA:closeChest")
            end
        end
        if l ~= 0 and c then
            local z = GetEntityCoords(tARMA.getPlayerPed())
            local A = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(tonumber(l))))
            local B = #(z - A)
            if B > 5.0 then
                TriggerEvent("ARMA:clCloseTrunk")
                TriggerServerEvent("ARMA:closeChest")
            end
        end
        if f == nil and g == "trunk" then
            c = false
            drawInventoryUI = false
        end
        Wait(500)
    end
end)
Citizen.CreateThread(function()
    while true do
        if drawInventoryUI then
            DrawRect(0.5, 0.53, 0.572, 0.508, 0, 0, 0, 150)
            DrawAdvancedText(0.593, 0.242, 0.005, 0.0028, 0.66, "ARMA Inventory", 255, 255, 255, 255, 7, 0)
            DrawRect(0.5, 0.24, 0.572, 0.058, 0, 0, 0, 225)
            DrawRect(0.342, 0.536, 0.215, 0.436, 0, 0, 0, 150)
            DrawRect(0.652, 0.537, 0.215, 0.436, 0, 0, 0, 150)
            if bulletsSelected then
                DrawAdvancedText(0.575, 0.364, 0.005, 0.0028, 0.325, "Use", 255, 255, 255, 255, 6, 0)
                DrawAdvancedText(0.615, 0.364, 0.005, 0.0028, 0.325, "Use All", 255, 255, 255, 255, 6, 0)
            else
                DrawAdvancedText(0.594, 0.364, 0.005, 0.0028, 0.4, "Use", 255, 255, 255, 255, 6, 0)
            end
            DrawAdvancedText(0.594, 0.454, 0.005, 0.0028, 0.4, "Move", 255, 255, 255, 255, 6, 0)
            DrawAdvancedText(0.575, 0.545, 0.005, 0.0028, 0.325, "Move X", 255, 255, 255, 255, 6, 0)
            DrawAdvancedText(0.615, 0.545, 0.005, 0.0028, 0.325, "Move All", 255, 255, 255, 255, 6, 0)
            DrawAdvancedText(0.595, 0.634, 0.005, 0.0028, 0.35, "Give to Nearest Player", 255, 255, 255, 255, 6, 0)
            DrawAdvancedText(0.594, 0.722, 0.005, 0.0028, 0.4, "Trash", 255, 255, 255, 255, 6, 0)
            DrawAdvancedText(0.488, 0.335, 0.005, 0.0028, 0.366, "Amount", 255, 255, 255, 255, 4, 0)
            DrawAdvancedText(0.404, 0.335, 0.005, 0.0028, 0.366, "Item Name", 255, 255, 255, 255, 4, 0)
            DrawAdvancedText(0.521, 0.335, 0.005, 0.0028, 0.366, "Weight", 255, 255, 255, 255, 4, 0)
            DrawAdvancedText(0.833, 0.776, 0.005, 0.0028, 0.288, "[Press L to close]", 255, 255, 255, 255, 4, 0)
            DrawRect(0.5, 0.273, 0.572, 0.0069999999999999, 0, 50, 142, 150)
            inGUIARMA = true
            if not c then
                DrawAdvancedText(0.751,0.525,0.005,0.0028,0.49,"2nd Inventory not available",255,255,255,118,6,0)
            elseif g ~= nil then
                DrawAdvancedText(0.798, 0.335, 0.005, 0.0028, 0.366, "Amount", 255, 255, 255, 255, 4, 0)
                DrawAdvancedText(0.714, 0.335, 0.005, 0.0028, 0.366, "Item Name", 255, 255, 255, 255, 4, 0)
                DrawAdvancedText(0.831, 0.335, 0.005, 0.0028, 0.366, "Weight", 255, 255, 255, 255, 4, 0)
                local C = 0.026
                local D = 0.026
                local E = 0
                local F = 0
                local G = sortAlphabetically(ARMASecondItemList)
                for H, I in pairs(G) do
                    local v = I.title
                    local w = I["value"]
                    local J, K, m = w.ItemName, w.amount, w.Weight
                    F = F + K * m
                    DrawAdvancedText(0.714, 0.360 + E * D, 0.005, 0.0028, 0.366, J, 255, 255, 255, 255, 4, 0)
                    DrawAdvancedText(0.831,0.360 + E * D,0.005,0.0028,0.366,tostring(m * K) .. "kg",255,255,255,255,4,0)
                    DrawAdvancedText(0.798, 0.360 + E * D, 0.005, 0.0028, 0.366, K, 255, 255, 255, 255, 4, 0)
                    if CursorInArea(0.5443, 0.7584, 0.3435 + E * D, 0.3690 + E * D) then
                        DrawRect(0.652, 0.331 + C * (E + 1), 0.215, 0.026, 0, 168, 255, 150)
                        if IsControlJustPressed(1, 329) or IsDisabledControlJustPressed(1, 329) then
                            PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                            if not lockInventorySoUserNoSpam then
                                b = v
                                a = false
                                k = K
                                selectedItemWeight = m
                                lockInventorySoUserNoSpam = true
                                Citizen.CreateThread(function()
                                    Wait(250)
                                    lockInventorySoUserNoSpam = false
                                end)
                            end
                        end
                    elseif v == b then
                        DrawRect(0.652, 0.331 + C * (E + 1), 0.215, 0.026, 0, 168, 255, 150)
                    end
                    E = E + 1
                end
                if F / e > 0.5 then
                    if F / e > 0.9 then
                        DrawAdvancedText(0.826,0.307,0.005,0.0028,0.366,"Weight: " .. F .. "/" .. e .. "kg",255,50,0,255,4,0)
                    else
                        DrawAdvancedText(0.826,0.307,0.005,0.0028,0.366,"Weight: " .. F .. "/" .. e .. "kg",255,165,0,255,4,0)
                    end
                else
                    DrawAdvancedText(0.826,0.307,0.005,0.0028,0.366,"Weight: " .. F .. "/" .. e .. "kg",255,255,153,255,4,0)
                end
            end
            if bulletsSelected then
                if CursorInArea(0.46, 0.496, 0.33, 0.383) then
                    DrawRect(0.48, 0.359, 0.0375, 0.056, 0, 168, 255, 150)
                    if IsControlJustPressed(1, 329) or IsDisabledControlJustPressed(1, 329) then
                        PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                        if not lockInventorySoUserNoSpam then
                            if a then
                                TriggerServerEvent('ARMA:UseItem', a, 'Plr')
                                --ARMAserver.useInventoryItem({a})
                            elseif b and g ~= nil and c then
                                ARMAserver.useInventoryItem({b})
                            else
                                tARMA.notify("~r~No item selected!")
                            end
                        end
                        lockInventorySoUserNoSpam = true
                        Citizen.CreateThread(function()
                            Wait(250)
                            lockInventorySoUserNoSpam = false
                        end)
                    end
                else
                    DrawRect(0.48, 0.359, 0.0375, 0.056, 0, 0, 0, 150)
                end
                if CursorInArea(0.501, 0.536, 0.329, 0.381) then
                    DrawRect(0.52, 0.359, 0.0375, 0.056, 0, 168, 255, 150)
                    if IsControlJustPressed(1, 329) or IsDisabledControlJustPressed(1, 329) then
                        PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                        if not lockInventorySoUserNoSpam then
                            if a then
                                TriggerServerEvent('ARMA:UseAllItem', a, 'Plr')
                                --ARMAserver.useInventoryItem({a})
                            elseif b and g ~= nil and c then
                                ARMAserver.useInventoryItem({b})
                            else
                                tARMA.notify("~r~No item selected!")
                            end
                        end
                        lockInventorySoUserNoSpam = true
                        Citizen.CreateThread(function()
                            Wait(250)
                            lockInventorySoUserNoSpam = false
                        end)
                    end
                else
                    DrawRect(0.52, 0.359, 0.0375, 0.056, 0, 0, 0, 150)
                end
            else
                if CursorInArea(0.4598, 0.5333, 0.3283, 0.3848) then
                    DrawRect(0.5, 0.36, 0.075, 0.056, 0, 168, 255, 150)
                    if IsControlJustPressed(1, 329) or IsDisabledControlJustPressed(1, 329) then
                        PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                        if not lockInventorySoUserNoSpam then
                            if a then
                                TriggerServerEvent('ARMA:UseItem', a, 'Plr')
                                --ARMAserver.useInventoryItem({a})
                            elseif b and g ~= nil and c then
                                --ARMAserver.useInventoryItem({b})
                            else
                                tARMA.notify("~r~No item selected!")
                            end
                        end
                        lockInventorySoUserNoSpam = true
                        Citizen.CreateThread(function()
                            Wait(250)
                            lockInventorySoUserNoSpam = false
                        end)
                    end
                else
                    DrawRect(0.5, 0.36, 0.075, 0.056, 0, 0, 0, 150)
                end
            end
            if CursorInArea(0.4598, 0.5333, 0.418, 0.4709) then
                DrawRect(0.5, 0.45, 0.075, 0.056, 0, 168, 255, 150)
                if IsControlJustPressed(1, 329) or IsDisabledControlJustPressed(1, 329) then
                    PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                    if not lockInventorySoUserNoSpam then
                        if c then
                            if a and g ~= nil and c then
                                if tARMA.getPlayerCombatTimer() > 0 then
                                    notify("~r~You can not store items whilst in combat.")
                                else
                                    if inventoryType == 'CarBoot' then
                                        TriggerServerEvent('ARMA:MoveItem', 'Plr', a, VehTypeA, false)
                                    elseif inventoryType == "Housing" then
                                        TriggerServerEvent('ARMA:MoveItem', 'Plr', a, "home", false)
                                    elseif IsLootBagOpening then
                                        TriggerServerEvent('ARMA:MoveItem', 'Plr', a, 'LootBag', true)
                                    end
                                    --ARMAserver.moveClientToChest({a, 1})
                                end
                            elseif b and g ~= nil and c then
                                if inventoryType == 'CarBoot' then
                                    TriggerServerEvent('ARMA:MoveItem', inventoryType, b, VehTypeA, false)
                                elseif inventoryType == "Housing" then
                                    TriggerServerEvent('ARMA:MoveItem', inventoryType, b, "home", false)
                                else
                                    TriggerServerEvent('ARMA:MoveItem', 'LootBag', b, LootBagIDNew, true)
                                end
                                --ARMAserver.moveChestToClient({b, 1})
                            else
                                tARMA.notify("~r~No item selected!")
                            end
                        else
                            tARMA.notify("~r~No second inventory available!")
                        end
                    end
                    lockInventorySoUserNoSpam = true
                    Citizen.CreateThread(function()
                        Wait(250)
                        lockInventorySoUserNoSpam = false
                    end)
                end
            else
                DrawRect(0.5, 0.45, 0.075, 0.056, 0, 0, 0, 150)
            end
            if CursorInArea(0.4598, 0.498, 0.5042, 0.5666) then
                DrawRect(0.48, 0.54, 0.0375, 0.056, 0, 168, 255, 150)
                if IsControlJustPressed(1, 329) or IsDisabledControlJustPressed(1, 329) then
                    PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                    local L = tonumber(GetInvAmountText()) or 1
                    if not lockInventorySoUserNoSpam then
                        if c then
                            if a and g ~= nil and c then
                                if tARMA.getPlayerCombatTimer() > 0 then
                                    notify("~r~You can not store items whilst in combat.")
                                else
                                    if inventoryType == 'CarBoot' then
                                        TriggerServerEvent('ARMA:MoveItemX', 'Plr', a, VehTypeA, false, L)
                                    elseif inventoryType == "Housing" then
                                        TriggerServerEvent('ARMA:MoveItemX', 'Plr', a, "home", false, L)
                                    elseif IsLootBagOpening then
                                        TriggerServerEvent('ARMA:MoveItemX', 'Plr', a, 'LootBag', true, L)
                                    end
                                    --ARMAserver.moveClientToChest({a, L})
                                end
                            elseif b and g ~= nil and c then
                                if inventoryType == 'CarBoot' then
                                    TriggerServerEvent('ARMA:MoveItemX', inventoryType, b, VehTypeA, false, L)
                                elseif inventoryType == "Housing" then
                                    TriggerServerEvent('ARMA:MoveItemX', inventoryType, b, "home", false, L)
                                else
                                    TriggerServerEvent('ARMA:MoveItemX', 'LootBag', b, LootBagIDNew, true, L)
                                end
                                --ARMAserver.moveChestToClient({b, L})
                            else
                                tARMA.notify("~r~No item selected!")
                            end
                        else
                            tARMA.notify("~r~No second inventory available!")
                        end
                    end
                    lockInventorySoUserNoSpam = true
                    Citizen.CreateThread(function()
                        Wait(250)
                        lockInventorySoUserNoSpam = false
                    end)
                end
            else
                DrawRect(0.48, 0.54, 0.0375, 0.056, 0, 0, 0, 150)
            end
            if CursorInArea(0.5004, 0.5333, 0.5042, 0.5666) then
                DrawRect(0.52, 0.54, 0.0375, 0.056, 0, 168, 255, 150)
                if IsControlJustPressed(1, 329) or IsDisabledControlJustPressed(1, 329) then
                    PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                    if not lockInventorySoUserNoSpam then
                        if c then
                            if a and g ~= nil and c then
                                local M = tARMA.getSpaceInSecondChest()
                                local L = k
                                if k * selectedItemWeight > M then
                                    L = math.floor(M / selectedItemWeight)
                                end
                                if L > 0 then
                                    if tARMA.getPlayerCombatTimer() > 0 then
                                        notify("~r~You can not store items whilst in combat.")
                                    else
                                        if inventoryType == 'CarBoot' then
                                            TriggerServerEvent('ARMA:MoveItemAll', 'Plr', a, VehTypeA, NetworkGetNetworkIdFromEntity(tARMA.getNearestVehicle(3)))
                                        elseif inventoryType == "Housing" then
                                            TriggerServerEvent('ARMA:MoveItemAll', 'Plr', a, "home")
                                        elseif IsLootBagOpening then
                                            TriggerServerEvent('ARMA:MoveItemAll', 'Plr', a, 'LootBag')
                                        end
                                        --ARMAserver.moveClientToChest({a, L})
                                    end
                                else
                                    tARMA.notify("~r~Not enough space in secondary chest!")
                                end
                            elseif b and g ~= nil and c then
                                local N = tARMA.getSpaceInFirstChest()
                                local L = k
                                if k * selectedItemWeight > N then
                                    L = math.floor(N / selectedItemWeight)
                                end
                                if L > 0 then
                                    if inventoryType == 'CarBoot' then
                                        TriggerServerEvent('ARMA:MoveItemAll', inventoryType, b, VehTypeA, NetworkGetNetworkIdFromEntity(tARMA.getNearestVehicle(3)))
                                    elseif inventoryType == "Housing" then
                                        TriggerServerEvent('ARMA:MoveItemAll', inventoryType, b, "home")
                                    else
                                        TriggerServerEvent('ARMA:MoveItemAll', 'LootBag', b, LootBagIDNew)
                                    end
                                    --ARMAserver.moveChestToClient({b, L})
                                else
                                    tARMA.notify("~r~Not enough space in secondary chest!")
                                end
                            else
                                tARMA.notify("~r~No item selected!")
                            end
                        else
                            tARMA.notify("~r~No second inventory available!")
                        end
                    end
                    lockInventorySoUserNoSpam = true
                    Citizen.CreateThread(function()
                        Wait(250)
                        lockInventorySoUserNoSpam = false
                    end)
                end
            else
                DrawRect(0.52, 0.54, 0.0375, 0.056, 0, 0, 0, 150)
            end
            if CursorInArea(0.4598, 0.5333, 0.5931, 0.6477) then
                DrawRect(0.5, 0.63, 0.075, 0.056, 0, 168, 255, 150)
                if IsControlJustPressed(1, 329) or IsDisabledControlJustPressed(1, 329) then
                    PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                    if not lockInventorySoUserNoSpam then
                        if a then
                            TriggerServerEvent('ARMA:GiveItem', a, 'Plr')
                            --ARMAserver.giveToNearestPlayer({a})
                        elseif b then
                            ARMAserver.giveToNearestPlayer({b})
                        else
                            tARMA.notify("~r~No item selected!")
                        end
                    end
                    lockInventorySoUserNoSpam = true
                    Citizen.CreateThread(function()
                        Wait(250)
                        lockInventorySoUserNoSpam = false
                    end)
                end
            else
                DrawRect(0.5, 0.63, 0.075, 0.056, 0, 0, 0, 150)
            end
            if CursorInArea(0.4598, 0.5333, 0.6831, 0.7377) then
                DrawRect(0.5, 0.72, 0.075, 0.056, 0, 168, 255, 150)
                if IsControlJustPressed(1, 329) or IsDisabledControlJustPressed(1, 329) then
                    PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                    if not lockInventorySoUserNoSpam then
                        if a then
                            TriggerServerEvent('ARMA:TrashItem', a, 'Plr')
                        elseif b then
                            tARMA.notify("~r~Please move the item to your inventory to trash")
                        else
                            tARMA.notify("~r~No item selected!")
                        end
                    end
                    lockInventorySoUserNoSpam = true
                    Citizen.CreateThread(function()
                        Wait(250)
                        lockInventorySoUserNoSpam = false
                    end)
                end
            else
                DrawRect(0.5, 0.72, 0.075, 0.056, 0, 0, 0, 150)
            end
            local C = 0.026
            local D = 0.026
            local E = 0
            local F = 0
            local G = sortAlphabetically(ARMAItemList)
            for H, I in pairs(G) do
                local v = I.title
                local w = I["value"]
                local J, K, m = w.ItemName, w.amount, w.Weight
                F = F + K * m
                DrawAdvancedText(0.404, 0.360 + E * D, 0.005, 0.0028, 0.366, J, 255, 255, 255, 255, 4, 0)
                DrawAdvancedText(0.521,0.360 + E * D,0.005,0.0028,0.366,tostring(m * K) .. "kg",255,255,255,255,4,0)
                DrawAdvancedText(0.488, 0.360 + E * D, 0.005, 0.0028, 0.366, K, 255, 255, 255, 255, 4, 0)
                if CursorInArea(0.2343, 0.4484, 0.3435 + E * D, 0.3690 + E * D) then
                    DrawRect(0.342, 0.331 + C * (E + 1), 0.215, 0.026, 0, 168, 255, 150)
                    if IsControlJustPressed(1, 329) or IsDisabledControlJustPressed(1, 329) then
                        PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                        a = v
                        if bullets[a] then
                            bulletsSelected = true
                        else
                            bulletsSelected = false
                        end
                        k = K
                        selectedItemWeight = m
                        b = false
                    end
                elseif v == a then
                    DrawRect(0.342, 0.331 + C * (E + 1), 0.215, 0.026, 0, 168, 255, 150)
                end
                E = E + 1
            end
            if F / currentInventoryMaxWeight > 0.5 then
                if F / currentInventoryMaxWeight > 0.9 then
                    DrawAdvancedText(0.516,0.307,0.005,0.0028,0.366,"Weight: " .. F .. "/" .. currentInventoryMaxWeight .. "kg",255,50,0,255,4,0)
                else
                    DrawAdvancedText(0.516,0.307,0.005,0.0028,0.366,"Weight: " .. F .. "/" .. currentInventoryMaxWeight .. "kg",255,165,0,255,4,0)
                end
            else
                DrawAdvancedText(0.516,0.307,0.005,0.0028,0.366,"Weight: " .. F .. "/" .. currentInventoryMaxWeight .. "kg",255,255,255,255,4,0)
            end
        end
        Wait(0)
    end
end)
Citizen.CreateThread(function()
    while true do
        if GetEntityHealth(tARMA.getPlayerPed()) <= 102 then
            ARMASecondItemList = {}
            c = false
            drawInventoryUI = false
            inGUIARMA = false
            setCursor(0)
        end
        Wait(50)
    end
end)
function GetInvAmountText()
    AddTextEntry("FMMC_MPM_NA", "Enter amount: (Blank to cancel)")
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Enter amount: (Blank to cancel)", "", "", "", "", 30)
    while UpdateOnscreenKeyboard() == 0 do
        DisableAllControlActions(0)
        Wait(0)
    end
    if GetOnscreenKeyboardResult() then
        local O = GetOnscreenKeyboardResult()
        return O
    end
    return nil
end

Citizen.CreateThread(function()
    while true do 
        Wait(250)
        if BootCar then
            if #(BootCar - GetEntityCoords(PlayerPedId())) > 8.0 then 
                drawInventoryUI = false
                tARMA.vc_closeDoor(VehTypeC, 5)
                BootCar = nil;
                VehTypeC = nil;
                VehTypeA = nil;
                inventoryType = nil;
            end
        end
        if inventoryOpen then
            if tARMA.isInComa() then
                drawInventoryUI = false
                inventoryType = nil;
                if BootCar then
                    tARMA.vc_closeDoor(VehTypeC, 5)
                    BootCar = nil;
                    VehTypeC = nil;
                    VehTypeA = nil;
                end
            end
        end
    end
end)

function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
      RequestAnimDict(dict)
      Citizen.Wait(5)
    end
end

RegisterNetEvent('ARMA:InventoryOpen')
AddEventHandler('ARMA:InventoryOpen', function(toggle, lootbag, bagid)
    IsLootBagOpening = lootbag
    LootBagIDNew = bagid
    if IsLootBagOpening then
        LoadAnimDict('amb@medic@standing@kneel@base')
        LoadAnimDict('anim@gangops@facility@servers@bodysearch@')
        TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
        TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )
    end
    if toggle then
        drawInventoryUI = true
    else 
        drawInventoryUI = false
        setCursor(0)
        inGUIARMA = false
        inventoryType = nil
        ClearPedTasks(PlayerPedId())
        RemoveAnimDict("amb@medic@standing@kneel@base")
        RemoveAnimDict("anim@gangops@facility@servers@bodysearch@")
    end
end)