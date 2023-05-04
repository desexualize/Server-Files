local a = true
local b = false
local c = ""
local d = ""
local e = 0.0
local f = 0.0
local g = 0.0
local h = 0.0
local i = ""
local j = ""
local k
local l
local m = {}
local n = false
TriggerEvent("chat:addSuggestion", "/flagf", "Flags the front vehicle", {{name = "Reason", help = "Flag reason"}})
TriggerEvent("chat:addSuggestion", "/flagr", "Flags the rear vehicle", {{name = "Reason", help = "Flag reason"}})
RegisterCommand("flagf",function(o, p)
    if c ~= "" then
        local q = ""
        if table.count(p) ~= 0 then
            q = table.concat(p, " ")
            TriggerServerEvent("ARMA:flagVehicleAnpr", string.upper(c), q)
        else
            tARMA.notify("~r~Error~w~: You must provide a valid flag reason.")
        end
    end
end)
RegisterCommand("flagr",function(o, p)
    if d ~= "" then
        local q = ""
        if table.count(p) ~= 0 then
            q = table.concat(p, " ")
            TriggerServerEvent("ARMA:flagVehicleAnpr", string.upper(d), q)
        else
            tARMA.notify("~r~Error~w~: You must provide a valid flag reason.")
        end
    end
end)
RegisterCommand("anpr",function(p, r)
    a = not a
end,false)
RegisterCommand("lockanpr",function(p, r)
    b = not b
end,false)
local s = false
Citizen.CreateThread(function()
    while true do
        if a then
            s = isPedInPoliceVehicle()
            if s then
                k = anprGetVehicle("front")
                l = anprGetVehicle("rear")
            end
        end
        Wait(250)
    end
end)
local t = vector2(0.07, 0.35)
function func_drawFullAnpr()
    if a and s then
        DrawRect(t.x, t.y, 0.145, 0.125, 0, 0, 0, 128)
        drawFrontAnprText()
        drawRearAnprText()
    end
end
tARMA.createThreadOnTick(func_drawFullAnpr)
function anprGetVehicle(u)
    local v
    if u == "front" then
        v = 50.0
    elseif u == "rear" then
        v = -50.0
    end
    local w = GetVehiclePedIsIn(tARMA.getPlayerPed(), false)
    local x = GetOffsetFromEntityInWorldCoords(w, 0.0, 1.0, 0.3)
    local y = GetOffsetFromEntityInWorldCoords(w, 0.0, v, 0.0)
    local z = StartExpensiveSynchronousShapeTestLosProbe(x, y, 10, w, 0)
    local A, A, A, A, B = GetShapeTestResult(z)
    if B > 0 and IsEntityAVehicle(B) then
        local C = GetVehicleNumberPlateText(B)
        if C ~= nil then
            if m[C] ~= nil then
                local D = m[C]
                if not n then
                    PlaySoundFrontend(-1, "BEEP_GREEN", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
                end
                tARMA.notify(string.format("~r~ANPR Alert~w~: Plate ~b~%s ~w~is flagged for:~b~~n~%s", C, D))
                n = true
                SetTimeout(10000,function()
                    n = false
                end)
            end
        end
        return B
    else
        return nil
    end
end
function isPedInPoliceVehicle()
    if IsPedInAnyVehicle(tARMA.getPlayerPed(), false) then
        if GetVehicleClass(tARMA.getPlayerVehicle()) == 18 and globalOnPoliceDuty then
            return true
        end
    end
    return false
end
function drawFrontAnprText()
    if b then
        DrawAdvancedText(t.x - 0.0335, t.y - 0.235, 0.1, 0.2, 0.5, "FRONT", 200, 0, 0, 255, 4, 0)
        DrawAdvancedText(t.x - 0.0335, t.y - 0.2, 0.1, 0.2, 0.3, "PLATE:  " .. c, 200, 0, 0, 255, 4, 0)
        DrawAdvancedText(t.x - 0.0335, t.y - 0.175, 0.1, 0.2, 0.3, "SPEED:  " .. g .. " MPH", 200, 0, 0, 255, 4, 0)
        DrawAdvancedText(t.x - 0.0335, t.y - 0.15, 0.1, 0.2, 0.3, "MODEL:  " .. i, 200, 0, 0, 255, 4, 0)
    elseif not b then
        if k ~= nil and k ~= 0 then
            c = GetVehicleNumberPlateText(k) or "N/A"
            i = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(k)))
            e = round(GetEntitySpeed(k) * 2.236936, 1)
        end
        g = e
        DrawAdvancedText(t.x - 0.0335, t.y - 0.235, 0.1, 0.2, 0.5, "FRONT", 255, 255, 255, 255, 4, 0)
        DrawAdvancedText(t.x - 0.0335, t.y - 0.2, 0.1, 0.2, 0.3, "PLATE:  " .. c, 255, 255, 255, 255, 4, 0)
        DrawAdvancedText(t.x - 0.0335, t.y - 0.175, 0.1, 0.2, 0.3, "SPEED:  " .. e .. " MPH", 255, 255, 255, 255, 4, 0)
        DrawAdvancedText(t.x - 0.0335, t.y - 0.15, 0.1, 0.2, 0.3, "MODEL:  " .. i, 255, 255, 255, 255, 4, 0)
    end
end
function drawRearAnprText()
    if b then
        DrawAdvancedText(t.x + 0.036, t.y - 0.235, 0.1, 0.2, 0.5, "REAR", 200, 0, 0, 255, 4, 0)
        DrawAdvancedText(t.x + 0.036, t.y - 0.2, 0.1, 0.2, 0.3, "PLATE:  " .. d, 200, 0, 0, 255, 4, 0)
        DrawAdvancedText(t.x + 0.036, t.y - 0.175, 0.1, 0.2, 0.3, "SPEED:  " .. h .. " MPH", 200, 0, 0, 255, 4, 0)
        DrawAdvancedText(t.x + 0.036, t.y - 0.15, 0.1, 0.2, 0.3, "MODEL:  " .. j, 200, 0, 0, 255, 4, 0)
    elseif not b then
        if l ~= nil and l ~= 0 then
            d = GetVehicleNumberPlateText(l) or "N/A"
            j = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(l)))
            f = round(GetEntitySpeed(l) * 2.236936, 1)
        end
        h = f
        DrawAdvancedText(t.x + 0.036, t.y - 0.235, 0.1, 0.2, 0.5, "REAR", 255, 255, 255, 255, 4, 0)
        DrawAdvancedText(t.x + 0.036, t.y - 0.2, 0.1, 0.2, 0.3, "PLATE:  " .. d, 255, 255, 255, 255, 4, 0)
        DrawAdvancedText(t.x + 0.036, t.y - 0.175, 0.1, 0.2, 0.3, "SPEED:  " .. f .. " MPH", 255, 255, 255, 255, 4, 0)
        DrawAdvancedText(t.x + 0.036, t.y - 0.15, 0.1, 0.2, 0.3, "MODEL:  " .. j, 255, 255, 255, 255, 4, 0)
    end
end
function round(E, F)
    local G = 10 ^ (F or 0)
    return math.floor(E * G + 0.5) / G
end
RegisterNetEvent("ARMA:setFlagVehicles",function(H)
    m = H
end)