globalHideEmergencyCallUI = false
local a = false
local b = 1
local c = 1
local d = {}
local e = {}
local f = {}
local g = 0.06
local h
local i = 6
local function j()
    f = {}
    f[1] = {}
    c = 1
    local k = 0
    local l = 0
    for m, n in pairs(d) do
        if l % i == 0 then
            k = k + 1
            c = c + 1
            l = 0
            f[k] = {}
            f[k][l + 1] = n
        else
            f[k][l + 1] = n
        end
        l = l + 1
    end
end

RegisterNetEvent("ARMA:addEmergencyCall",function(o, p, q, r, s, t)
    local u = 0
    if t == "admin" and tARMA.getStaffLevel() > 0 then
        tARMA.notify("~b~Admin ticket received.")
        PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
        local v = #(r - GetEntityCoords(tARMA.getPlayerPed()))
        table.insert(d, {o, p, q, v, s, t, u})
        j()
        e[o] = r
    elseif t == "met" and tARMA.globalOnPoliceDuty() then
        tARMA.notify("~b~MET Police call received.")
        PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
        local v = #(r - GetEntityCoords(tARMA.getPlayerPed()))
        table.insert(d, {o, p, q, v, s, t, u})
        j()
        e[o] = r
    elseif t == "nhs" and tARMA.globalNHSOnDuty() then
        tARMA.notify("~b~NHS call received.")
        PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
        local v = #(r - GetEntityCoords(tARMA.getPlayerPed()))
        table.insert(d, {o, p, q, v, s, t, u})
        j()
        e[o] = r
    end
end)

RegisterNetEvent("ARMA:removeEmergencyCall",function(o)
    for m, n in pairs(d) do
        if n[1] == o then
            table.remove(d, m)
        end
    end
    j()
end)

Citizen.CreateThread(function()
    while true do
        if a then
            SetScriptGfxDrawOrder(0.0)
            DrawRect(0.251, 0.528, 0.485, 0.056, 0, 0, 0, 150)
            SetScriptGfxDrawOrder(0.0)
            DrawRect(0.251, 0.559, 0.485, 0.0059999999999999, 0, 168, 255, 150)
            SetScriptGfxDrawOrder(0.0)
            DrawRect(0.251, 0.775, 0.485, 0.426, 0, 0, 0, 150)
            DrawAdvancedText(0.339, 0.529, 0.005, 0.0028, 0.51, "ARMA Call Manager", 255, 255, 255, 255, 7, 0)
            local w = 0
            local x, y, z = 0, 168, 255
            if f[b] ~= nil then
                for A, n in ipairs(f[b]) do
                    local o, p, q, v, s, t, u = table.unpack(n)
                    DrawAdvancedText(0.458, 0.616 + w * g, 0.005, 0.0028, 0.4, s, 255, 255, 255, 255, 6, 0)
                    if t == "admin" then
                        DrawAdvancedText(0.414,0.592 + w * g, 0.005,0.0028,0.36, p .. " - ID: " .. q .. " - Distance " .. math.floor(v) .. "m - " .. u .. " mins ago",255,20,10,255,6,1)
                    elseif t == "met" then
                        DrawAdvancedText(0.414,0.592 + w * g, 0.005,0.0028,0.36, p .. " - ID: " .. q .. " - Distance " .. math.floor(v) .. "m - " .. u .. " mins ago",0,50,255,255,6,1)
                    elseif t == "nhs" then
                        DrawAdvancedText(0.414,0.592 + w * g, 0.005,0.0028,0.36, p .. " - ID: " .. q .. " - Distance " .. math.floor(v) .. "m - " .. u .. " mins ago",0,255,50,255,6,1)
                    end
                    if CursorInArea(0.2692, 0.4723, 0.5962 + w * g, 0.6305 + w * g) then
                        DrawRect(0.371, 0.615 + w * g, 0.205, 0.035, x, y, z, 150)
                        if IsControlJustPressed(1, 329) or IsDisabledControlJustPressed(1, 329) then
                            PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                            h = o
                            if h ~= nil then
                                SetNewWaypoint(e[h].x, e[h].y)
                            end
                        end
                    elseif o == h then
                        DrawRect(0.371, 0.615 + w * g, 0.205, 0.035, x, y, z, 150)
                    else
                        DrawRect(0.371, 0.615 + w * g, 0.205, 0.035, 0, 0, 0, 150)
                    end
                    w = w + 1
                end
            end
            if CursorInArea(0.2557, 0.2916, 0.9444, 0.9759) then
                DrawRect(0.274, 0.961, 0.037, 0.032, x, y, z, 150)
                if IsControlJustPressed(1, 329) or IsDisabledControlJustPressed(1, 329) then
                    PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                    if d[h] ~= nil then
                        for m, n in pairs(d) do
                            if n[1] == h then
                                table.remove(d, m)
                            end
                        end
                        j()
                    else
                        local B = false
                        for m, n in pairs(d) do
                            if not B then
                                table.remove(d, m)
                                B = true
                            end
                        end
                        j()
                    end
                end
            else
                DrawRect(0.274, 0.961, 0.037, 0.032, 0, 0, 0, 150)
            end
            if CursorInArea(0.3072, 0.3468, 0.9444, 0.9759) then
                DrawRect(0.328, 0.96, 0.04, 0.032, x, y, z, 150)
                if IsControlJustPressed(1, 329) or IsDisabledControlJustPressed(1, 329) then
                    PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                    if b <= 1 then
                        tARMA.notify("~r~Lowest page reached")
                    else
                        b = b - 1
                    end
                end
            else
                DrawRect(0.328, 0.96, 0.04, 0.032, 0, 0, 0, 150)
            end
            if CursorInArea(0.3697, 0.4088, 0.9444, 0.9759) then
                DrawRect(0.39, 0.96, 0.04, 0.032, x, y, z, 150)
                if IsControlJustPressed(1, 329) or IsDisabledControlJustPressed(1, 329) then
                    PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                    if b >= c - 1 then
                        tARMA.notify("~r~Max page reached")
                    else
                        b = b + 1
                    end
                end
            else
                DrawRect(0.39, 0.96, 0.04, 0.032, 0, 0, 0, 150)
            end
            if CursorInArea(0.4234, 0.4614, 0.9444, 0.9759) then
                DrawRect(0.444, 0.96, 0.037, 0.03, x, y, z, 150)
                if IsControlJustPressed(1, 329) or IsDisabledControlJustPressed(1, 329) then
                    PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                    if h ~= nil then
                        TriggerServerEvent("ARMA:TakeTicket", h)
                        a = not a
                        TriggerEvent("ARMA:showHUD", true)
                        globalHideEmergencyCallUI = false
                        SetBigmapActive(false, false)
                        setCursor(0)
                        inGUIARMA = false
                        for m,n in pairs(globalBlips)do 
                            SetBlipAlpha(n,255)
                        end 
                    else
                        local B = false
                        local C
                        for m, n in pairs(d) do
                            if not B then
                                C = n[1]
                                B = true
                            end
                        end
                        if C ~= nil then
                            TriggerServerEvent("ARMA:TakeTicket", C)
                            a = not a
                            SetNewWaypoint(e[h].x, e[h].y)
                            TriggerEvent("ARMA:showHUD", true)
                            globalHideEmergencyCallUI = false
                            SetBigmapActive(false, false)
                            setCursor(0)
                            inGUIARMA = false
                            for m,n in pairs(globalBlips)do 
                                SetBlipAlpha(n,255)
                            end 
                        else
                            tARMA.notify("~r~No calls available.")
                        end
                    end
                end
            else
                DrawRect(0.444, 0.96, 0.037, 0.03, 0, 0, 0, 150)
            end
            DrawAdvancedText(0.453, 0.964, 0.005, 0.0028, 0.4, b .. " / " .. c - 1, 255, 255, 255, 255, 6, 0)
            DrawAdvancedText(0.369, 0.963, 0.005, 0.0028, 0.4, "Deny (-)", 255, 0, 0, 255, 4, 0)
            DrawAdvancedText(0.423, 0.963, 0.005, 0.0028, 0.4, "Previous", 255, 255, 255, 255, 4, 0)
            DrawAdvancedText(0.485, 0.963, 0.005, 0.0028, 0.4, "Next", 255, 255, 255, 255, 4, 0)
            DrawAdvancedText(0.539, 0.963, 0.005, 0.0028, 0.4, "Accept (=)", 12, 255, 26, 255, 4, 0)
            if IsDisabledControlJustPressed(1, 84) then
                PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                if d[h] ~= nil then
                    for m, n in pairs(d) do
                        if n[1] == h then
                            table.remove(d, m)
                        end
                    end
                    j()
                else
                    local B = false
                    for m, n in pairs(d) do
                        if not B then
                            table.remove(d, m)
                            B = true
                        end
                    end
                    j()
                end
            end
            if IsDisabledControlJustPressed(1, 83) then
                PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                if h ~= nil then
                    TriggerServerEvent("ARMA:TakeTicket", h)
                    a = not a
                    TriggerEvent("ARMA:showHUD", true)
                    globalHideEmergencyCallUI = false
                    SetBigmapActive(false, false)
                    setCursor(0)
                    inGUIARMA = false
                    for m,n in pairs(globalBlips)do 
                        SetBlipAlpha(n,255)
                    end 
                else
                    local B = false
                    local C
                    for m, n in pairs(d) do
                        if not B then
                            C = n[1]
                            B = true
                        end
                    end
                    if C ~= nil then
                        TriggerServerEvent("ARMA:TakeTicket", C)
                        a = not a
                        SetNewWaypoint(e[h].x, e[h].y)
                        TriggerEvent("ARMA:showHUD", true)
                        globalHideEmergencyCallUI = false
                        SetBigmapActive(false, false)
                        setCursor(0)
                        inGUIARMA = false
                        for m,n in pairs(globalBlips)do 
                            SetBlipAlpha(n,255)
                        end 
                    else
                        tARMA.notify("~r~No calls available.")
                    end
                end
            end
        end
        Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        if IsControlJustPressed(0, 243) then
            a = not a
            if not a then
                TriggerEvent("ARMA:showHUD", true)
                globalHideEmergencyCallUI = false
                SetBigmapActive(false, false)
                setCursor(0)
                inGUIARMA = false
                for m,n in pairs(globalBlips)do 
                    SetBlipAlpha(n,255)
                end 
            else
                TriggerEvent("ARMA:showHUD", false)
                globalHideEmergencyCallUI = true
                SetBigmapActive(true, true)
                setCursor(1)
                inGUIARMA = true
                for m,n in pairs(globalBlips)do 
                    SetBlipAlpha(n,0)
                end 
            end
        end
        Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        for m, n in pairs(f) do
            for D, E in pairs(n) do
                E[7] = E[7] + 1
            end
        end
        Wait(60000)
    end
end)