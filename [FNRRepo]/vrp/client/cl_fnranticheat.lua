Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)
            local m = PlayerId()
            local l = GetVehiclePedIsIn(m)
            local q = GetPlayerWeaponDamageModifier(m)
            local r = GetPlayerWeaponDefenseModifier(m)
            local s = GetPlayerWeaponDefenseModifier_2(m)
            local t = GetPlayerVehicleDamageModifier(m)
            local u = GetPlayerVehicleDefenseModifier(m)
            local v = GetPlayerMeleeWeaponDefenseModifier(m)
            if l ~= 0 then
                local w = GetVehicleTopSpeedModifier(l)
                if w > 1.0 then
                    TriggerServerEvent("FNR:AnticheatBan", "Type 8", "GetVehicleTopSpeedModifier " .. v)
                end
            end
            local x = GetWeaponDamageModifier(GetCurrentPedWeapon(m))
            local y = GetPlayerMeleeWeaponDamageModifier()
            if q > 1.0 then
                TriggerServerEvent("FNR:AnticheatBan", "Type 8", "PlayerWeaponDamageModifier " .. q)
                Wait(30000)
            end
            if r > 1.0 then
                TriggerServerEvent("FNR:AnticheatBan", "Type 8", "PlayerWeaponDefenseModifier " .. r)
                Wait(30000)
            end
            if s > 1.0 then
                TriggerServerEvent("FNR:AnticheatBan", "Type 8", "PlayerWeaponDefenseModifier_2 " .. s)
                Wait(30000)
            end
            if t > 1.0 then
                TriggerServerEvent("FNR:AnticheatBan", "Type 8", "PlayerVehicleDamageModifier " .. t)
                Wait(30000)
            end
            if u > 1.0 then
                TriggerServerEvent("FNR:AnticheatBan", "Type 8", "PlayerVehicleDefenseModifier " .. u)
                Wait(30000)
            end
            if x > 1.0 then
                TriggerServerEvent("FNR:AnticheatBan", "Type 8", "GetWeaponDamageModifier " .. v)
                Wait(30000)
            end
            if y > 1.0 then
                TriggerServerEvent("FNR:AnticheatBan", "Type 8", "GetPlayerMeleeWeaponDamageModifier " .. v)
                Wait(30000)
            end
            RemoveAllPickupsOfType("PICKUP_HEALTH_SNACK")
            RemoveAllPickupsOfType("PICKUP_HEALTH_STANDARD")
        end
    end)

    Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(30000)
            local o = {
                {txd = "HydroMenu", txt = "HydroMenuHeader", name = "HydroMenu"},
                {txd = "John", txt = "John2", name = "SugarMenu"},
                {txd = "darkside", txt = "logo", name = "Darkside"},
                {txd = "ISMMENU", txt = "ISMMENUHeader", name = "ISMMENU"},
                {txd = "dopatest", txt = "duiTex", name = "Copypaste Menu"},
                {txd = "fm", txt = "menu_bg", name = "Fallout"},
                {txd = "wave", txt = "logo", name = "Wave"},
                {txd = "wave1", txt = "logo1", name = "Wave (alt.)"},
                {txd = "meow2", txt = "woof2", name = "Alokas66", x = 1000, y = 1000},
                {
                    txd = "adb831a7fdd83d_Guest_d1e2a309ce7591dff86",
                    txt = "adb831a7fdd83d_Guest_d1e2a309ce7591dff8Header6",
                    name = "Guest Menu"
                },
                {txd = "hugev_gif_DSGUHSDGISDG", txt = "duiTex_DSIOGJSDG", name = "HugeV Menu"},
                {txd = "MM", txt = "menu_bg", name = "MetrixFallout"},
                {txd = "wm", txt = "wm2", name = "WM Menu"}
            }
            for m, p in pairs(o) do
                if p.x and p.y then
                    if GetTextureResolution(p.txd, p.txt).x == p.x and GetTextureResolution(p.txd, p.txt).y == p.y then
                        TriggerServerEvent("FNR:AnticheatBan", "Type 7", "Menu: " .. p.name .. " Menu")
                        Wait(30000)
                    end
                else
                    if GetTextureResolution(p.txd, p.txt).x ~= 4.0 then
                        TriggerServerEvent("FNR:AnticheatBan", "Type 7", "Menu: " .. p.name .. " Menu")
                        Wait(30000)
                    end
                end
            end
        end
    end)

local z = {["WEAPON_UNARMED"] = true, ["WEAPON_PETROLCAN"] = true, ["WEAPON_SNOWBALL"] = true}
CreateThread(
    function()
        while true do
            local A = PlayerPedId()
            local B = GetSelectedPedWeapon(A)
            for C, D in pairs(z) do
                if GetHashKey(C) == B then
                    return
                end
            end
            if IsPedShooting(A) then
                local E, F = GetAmmoInClip(A, B)
                if F == GetMaxAmmoInClip(A, B) then
                    TriggerServerEvent("FNR:AnticheatBan", "Type 8", "Infinite Ammo")
                    Wait(60000)
                end
            end
            Wait(0)
        end
    end)

local D = {GetHashKey("notonlyfans"), GetHashKey("4x4range")}
Citizen.CreateThread(function()
    while true do
        local d = GetVehiclePedIsIn(PlayerPedId(), false)
            if GetVehicleHasParachute(d) or GetCanVehicleJump(d) or GetHasRocketBoost(d) then
                local G = GetEntityModel(d)
                if not table.has(D, G) then
                    TriggerServerEvent("FNR:AnticheatBan", "Type 12", "Vehicle: " .. globalVehicleModelHashMapping[G])
                end
            end
        Wait(1000)
    end
end)


local checkweapons = {GetHashKey('COMPONENT_COMBATPISTOL_CLIP_01'),GetHashKey('COMPONENT_COMBATPISTOL_CLIP_02'), GetHashKey('COMPONENT_APPISTOL_CLIP_01'),GetHashKey('COMPONENT_APPISTOL_CLIP_02'),GetHashKey('COMPONENT_MICROSMG_CLIP_01'),GetHashKey('COMPONENT_MICROSMG_CLIP_02'),GetHashKey('COMPONENT_SMG_CLIP_01'),GetHashKey('COMPONENT_SMG_CLIP_02'),GetHashKey('COMPONENT_ASSAULTRIFLE_CLIP_01'),GetHashKey('COMPONENT_ASSAULTRIFLE_CLIP_02'),GetHashKey('COMPONENT_CARBINERIFLE_CLIP_01'),GetHashKey('COMPONENT_CARBINERIFLE_CLIP_02'),GetHashKey('COMPONENT_ADVANCEDRIFLE_CLIP_01'),GetHashKey('COMPONENT_ADVANCEDRIFLE_CLIP_02'),GetHashKey('COMPONENT_MG_CLIP_01'),GetHashKey('COMPONENT_MG_CLIP_02'),GetHashKey('COMPONENT_COMBATMG_CLIP_01'),GetHashKey('COMPONENT_COMBATMG_CLIP_02'),GetHashKey('COMPONENT_PUMPSHOTGUN_CLIP_01'),GetHashKey('COMPONENT_SAWNOFFSHOTGUN_CLIP_01'),GetHashKey('COMPONENT_ASSAULTSHOTGUN_CLIP_01'),GetHashKey('COMPONENT_ASSAULTSHOTGUN_CLIP_02'),GetHashKey('COMPONENT_PISTOL50_CLIP_01'), GetHashKey('COMPONENT_PISTOL50_CLIP_02'),GetHashKey('COMPONENT_ASSAULTSMG_CLIP_01'),GetHashKey('COMPONENT_ASSAULTSMG_CLIP_02'),GetHashKey('COMPONENT_AT_RAILCOVER_01'),GetHashKey('COMPONENT_AT_AR_AFGRIP'),GetHashKey('COMPONENT_AT_PI_FLSH'),GetHashKey('COMPONENT_AT_AR_FLSH'),GetHashKey('COMPONENT_AT_SCOPE_MACRO'),GetHashKey('COMPONENT_AT_SCOPE_SMALL'),GetHashKey('COMPONENT_AT_SCOPE_MEDIUM'),GetHashKey('COMPONENT_AT_SCOPE_LARGE'),GetHashKey('COMPONENT_AT_SCOPE_MAX'),GetHashKey('COMPONENT_AT_PI_SUPP'),}
Citizen.CreateThread(function()
    while true do
        local min,max = GetModelDimensions(GetEntityModel(PlayerPedId()))
        if min.y < -0.29 or max.z > 0.98 then
            TriggerServerEvent("FNR:AnticheatKick", "HitBox")
        end
        Wait(4500)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10000)
        for i = 1, #checkweapons do
            local dmg_mod = GetWeaponComponentDamageModifier(checkweapons[i])
            local accuracy_mod = GetWeaponComponentAccuracyModifier(checkweapons[i])
            if dmg_mod > 1.1 or accuracy_mod > 1.2 then
                TriggerServerEvent("FNR:AnticheatKick", "Weapon Damage Modifier")
            end
        end
    end
end)

Citizen.CreateThread(function()
	while true do		
		if NetworkIsInSpectatorMode() then
			TriggerServerEvent("FNR:SpectateBan", "Type #14", "Spectating")
		end
	    Citizen.Wait(1000)
    end
end)

local function trigger_null_event()
    TriggerServerEventInternal(nil, "?", 1)
end

local _szp_xc = function()
    local s, r, e = xpcall(
        function()
            trigger_null_event()
            return true
        end,
        function()
            return false
        end)
    return r
end
CreateThread(function()
    TriggerServerEvent("FNR:ACCheck")
    Wait(10)
    _szp_xc()
    Wait(50)
    TriggerServerEvent("FNR:NOTFNR")
end)

RegisterNUICallback("NuiDevTool",function()
    TriggerServerEvent("FNR:AnticheatBan", "Type #13", "NUI Tools")
end)
print("FNR Anticheat Loaded")