local a = module("cfg/cfg_backpacks")
currentBackpack = nil
local b = nil
local c = nil
local d = nil
function previewBackpack(c)
    local prop0, prop1, prop2, backpackname, price, size, backpackstorename = c[1], c[2], c[3], c[4], c[5], c[6], c[7]
    SetPedComponentVariation(tARMA.getPlayerPed(), prop0, prop1, prop2, 2)
end

RegisterNetEvent("ARMA:boughtBackpack",function(prop0, prop1, prop2, size, backpackname)
    currentBackpack = backpackname
    b = {prop0, prop1, prop2}
    SetPedComponentVariation(tARMA.getPlayerPed(), prop0, prop1, prop2, 2)
    d = nil
    Wait(250)
    EnableAllControlActions(1)
end)

RegisterNetEvent("ARMA:removeBackpack",function()
    if currentBackpack ~= nil then
        ped = tARMA.getPlayerPed()
        SetPedComponentVariation(tARMA.getPlayerPed(), 5, 0, 0, 2)
        currentBackpack = nil
        b = nil
        c = nil
    end
end)

AddEventHandler("ARMA:onClientSpawn",function(D, E)
    if E then
        local g = function()
            setCursor(1)
            inGUIARMA = true
            d = tARMA.getCustomization()
        end
        local h = function()
            setCursor(0)
            inGUIARMA = false
            if d ~= nil then
                tARMA.setCustomization(d)
            end
            d = nil
        end
        local i = function(j)
            local k = 0.033
            local l = 0.033
            local m = 0
            local n = 0.306
            DrawRect(0.5, 0.222, 0.223, 0.075, 16, 86, 229, 255)
            DrawAdvancedText(0.595, 0.213, 0.005, 0.0028, 1.0, "ARMA Backpacks", 255, 255, 255, 255, 1, 0)
            DrawAdvancedText(0.67, 0.275, 0.005, 0.0028, 0.4, "Price", 0, 255, 50, 255, 6, 0)
            DrawAdvancedText(0.550, 0.275, 0.005, 0.0028, 0.4, "Name", 0, 242, 54, 255, 6, 0)
            DrawRect(0.5, 0.272, 0.223, 0.026, 0, 0, 0, 222)
            for o, p in pairs(a.stores[j.storeName]) do
                if o ~= "_config" then
                    backpackname = o
                    prop0, prop1, prop2, price, size = table.unpack(p)
                    DrawAdvancedText(0.550,n + m * k,0.005,0.0028,0.4,tostring(backpackname),255,255,255,255,6,0)
                    DrawAdvancedText(0.672,n + m * k,0.005,0.0028,0.4,"£" .. getMoneyStringFormatted(price),255,255,255,255,6,0)
                    DrawRect(0.5, 0.301 + k * m, 0.223, 0.033, 0, 0, 0, 120)
                    if CursorInArea(0.388, 0.61, 0.283 + m * l, 0.283 + (m + 1) * l) then
                        DrawRect(0.5, 0.301 + k * m, 0.223, 0.033, 255, 255, 255, 120)
                        if IsControlJustPressed(1, 329) or IsDisabledControlJustPressed(1, 329) then
                            PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                            if currentBackpack ~= backpackname then
                                c = {prop0, prop1, prop2, backpackname, price, size, j.storeName}
                                previewBackpack(c)
                            end
                            Wait(250)
                        end
                    end
                    m = m + 1
                end
            end
            DrawAdvancedText(0.550, n + m * k, 0.005, 0.0028, 0.4, "Buy Backpack", 0, 255, 0, 255, 6, 0)
            DrawRect(0.5, 0.301 + k * m, 0.223, 0.033, 0, 0, 0, 120)
            if CursorInArea(0.388, 0.61, 0.283 + m * l, 0.283 + (m + 1) * l) then
                DrawRect(0.5, 0.301 + k * m, 0.223, 0.033, 255, 255, 255, 120)
                if IsControlJustPressed(1, 329) or IsDisabledControlJustPressed(1, 329) then
                    PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                    if currentBackpack ~= backpackname then
                        if c ~= nil then
                            prop0, prop1, prop2, backpackname, price, size, backpackstorename = c[1],c[2],c[3],c[4],c[5],c[6],c[7]
                            TriggerServerEvent("ARMA:BuyBackpack",prop0,prop1,prop2,backpackname,price,size,backpackstorename)
                        else
                            tARMA.notify("No backpack selected!")
                        end
                    else
                        tARMA.notify("~r~You already have this backpack!")
                    end
                    Wait(250)
                    EnableAllControlActions(1)
                end
            end
        end
        for q, r in pairs(a.stores) do
            for s, t in pairs(r) do
                if s == "_config" then
                    local u, v, w, x, y, z, A, B = table.unpack(t)
                    if B then
                        tARMA.addBlip(u, v, w, x, y, z)
                    end
                    tARMA.addMarker(u, v, w, 1.0, 1.0, 1.0, 255, 0, 0, 170, 50, 27)
                    tARMA.createArea("backpack_" .. q, vector3(u, v, w), 1.5, 6, g, h, i, {storeName = q})
                end
            end
        end
    end
end)


local function C()
    if not b then
        return
    end
    local D = tARMA.getPlayerPed()
    local E = GetPedDrawableVariation(D, b[1])
    if E ~= b[2] and GetEntityModel(D) == "mp_m_freemode_01" then
        SetPedComponentVariation(D, b[1], b[2], b[3], 0)
    end
end
tARMA.createThreadOnTick(C)
