globalInRedzone = false
local a = false
local b = 0
local c = false
local d = {
    ["Rebel"] = {type = "radius", pos = vector3(1468.5318603516, 6328.529296875, 18.894895553589), radius = 100.0},
    ["Heroin"] = {type = "radius", pos = vector3(3545.048828125, 3724.0776367188, 36.64262008667), radius = 170.0},
    ["LargeArms"] = {type = "radius", pos = vector3(-1118.4926757813, 4926.1889648438, 218.35691833496), radius = 170.0},
    ["LargeArmsCayo"] = {type = "radius",pos = vector3(5115.7465820312, -4623.2915039062, 2.642692565918),radius = 85.0},
    ["RebelCayo"] = {type = "radius", pos = vector3(4982.5634765625, -5175.1079101562, 2.4887988567352), radius = 120.0},
    ["LSDNorth"] = {type = "radius", pos = vector3(1317.0300292969, 4309.8359375, 38.005485534668), radius = 90.0},
    ["LSDSouth"] = {type = "radius", pos = vector3(2539.0964355469, -376.51586914063, 92.986785888672), radius = 120.0},
}
function tARMA.setRedzoneTimerDisabled(e)
    a = e
end
function tARMA.isPlayerInRedZone()
    return globalInRedzone
end
local f = 0
function tARMA.setPlayerCombatTimer(g, h)
    if tARMA.isPurge() then return end
    b = g
    if h then
        c = true
    end
    if GetGameTimer() - f > 2500 or tARMA.isStaffedOn() then
        TriggerServerEvent("ARMA:setCombatTimer", g)
        f = GetGameTimer()
    end
end
function tARMA.getPlayerCombatTimer()
    return b, c
end
local function i(j, k, l)
    if k.type == "radius" then
        if l then
            return #(j.xy - k.pos.xy) <= k.radius
        else
            return #(j - k.pos) <= k.radius
        end
    elseif k.type == "area" then
        local m = k.width / 2.0
        local n = k.height / 2.0
        if #(j - k.pos) <= m + n then
            local o = vector3(m, n, 0.0)
            local p = k.pos + o
            local q = k.pos - o
            return j.x < p.x and j.y < p.y and j.x > q.x and j.y > q.y
        end
    end
    return false
end
Citizen.CreateThread(function()
    while true do
        if not a then
            local r = GetEntityCoords(tARMA.getPlayerPed())
            globalInRedzone = false
            for s, k in pairs(d) do
                if i(r, k, false) then
                    globalInRedzone = true
                    local r = GetEntityCoords(tARMA.getPlayerPed())
                    tARMA.setPlayerCombatTimer(30, false)
                    local t
                    local u = false
                    while not u do
                        r = GetEntityCoords(tARMA.getPlayerPed())
                        while i(r, k, true) do
                            r = GetEntityCoords(tARMA.getPlayerPed())
                            t = r
                            if IsPedShooting(tARMA.getPlayerPed()) and GetSelectedPedWeapon(tARMA.getPlayerPed()) ~= GetHashKey("WEAPON_UNARMED") then
                                tARMA.setPlayerCombatTimer(60, true)
                            end
                            if b == 0 then
                                DrawAdvancedText(0.931,0.914,0.005,0.0028,0.49,"Combat Timer ended, you may leave.",255,51,51,255,7,0)
                            end
                            Wait(0)
                        end
                        if b == 0 then
                            u = true
                        else
                            local v = k.pos - GetEntityCoords(tARMA.getPlayerPed())
                            t = t + v * 0.01
                            if GetVehiclePedIsIn(tARMA.getPlayerPed(), false) == 0 then
                                TaskGoStraightToCoord(tARMA.getPlayerPed(),t.x,t.y,t.z,8.0,1000,GetEntityHeading(tARMA.getPlayerPed()),0.0)
                                local w = GetSoundId()
                                PlaySoundFrontend(w, "End_Zone_Flash", "DLC_BTL_RB_Remix_Sounds", true)
                                ReleaseSoundId(w)
                                tARMA.announceMpBigMsg("~r~WARNING", "Get back in the redzone!", 2000)
                            else
                                SetEntityCoords(tARMA.getPlayerPed(), t.x, t.y, t.z)
                            end
                            SetTimeout(1000,function()
                                ClearPedTasks(tARMA.getPlayerPed())
                            end)
                        end
                        Wait(0)
                    end
                end
            end
        end
        Wait(500)
    end
end)
Citizen.CreateThread(function()
    while true do
        if b > 0 then
            if a then
                tARMA.setPlayerCombatTimer(0, false)
            else
                b = b - 1
                if b == 0 then
                    c = false
                end
            end
        end
        Wait(1000)
    end
end)
local x = {["WEAPON_UNARMED"] = true, ["WEAPON_PETROLCAN"] = true, ["WEAPON_SNOWBALL"] = true}
function tARMA.isEmergencyService()
    return globalOnPoliceDuty or globalOnPrisonDuty or globalNHSOnDuty or globalLFBOnDuty
end
AddEventHandler("ARMA:startCombatTimer",function(h)
    if not tARMA.isEmergencyService() then --and not tARMA.isInPaintball() then
        tARMA.setPlayerCombatTimer(60, h)
    end
end)
local function y()
    if not tARMA.isEmergencyService() and not tARMA.isInComa() then --and not tARMA.isInPaintball() then
        local z = PlayerPedId()
        if HasEntityBeenDamagedByWeapon(z, 0, 2) then
            Citizen.CreateThread(function()
                ClearEntityLastDamageEntity(z)
                ClearEntityLastWeaponDamage(z)
            end)
            tARMA.setPlayerCombatTimer(60, true)
        end
        local A = GetSelectedPedWeapon(z)
        if IsPedShooting(z) and not x[A] then
            tARMA.setPlayerCombatTimer(60, true)
        elseif GetPlayerTargetEntity(tARMA.getPlayerId()) and IsControlPressed(0, 24) then
            tARMA.setPlayerCombatTimer(60, true)
        end
    end
    if b > 0 then
        DrawAdvancedText(0.985,0.965,0.005,0.0028,0.467,"COMBAT TIMER: " .. b .. " seconds",246,74,70,255,7,0)
    end
end
tARMA.createThreadOnTick(y)
local function B()
    local z = PlayerPedId()
    SetCanPedEquipWeapon(z, "WEAPON_MOLOTOV", false)
    if GetSelectedPedWeapon(z) == GetHashKey("WEAPON_MOLOTOV") then
        tARMA.setWeapon(z, "WEAPON_UNARMED", true)
    end
end
local function C()
    SetCanPedEquipWeapon(PlayerPedId(), "WEAPON_MOLOTOV", true)
end
tARMA.createArea("rig_disable_molotovs",vector3(-1703.7, 8886.5, 28.7),125.0,250.0,B,C,function()end)
