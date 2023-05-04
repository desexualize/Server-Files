local a = {
    allowedWeapons = {},
    InProgress = false,
    startTime = 0,
    type = "",
    targetSrc = -1,
    agressor = {animDict = "anim@gangops@hostage@", anim = "perp_idle", flag = 49},
    hostage = {
        animDict = "anim@gangops@hostage@",
        anim = "victim_idle",
        attachX = -0.24,
        attachY = 0.11,
        attachZ = 0.0,
        flag = 49
    }
}
local b = module("arma-weapons", "cfg/weapons")
Citizen.CreateThread(function()
    for c, d in pairs(b.weapons) do
        if d.class == "Pistol" then
            table.insert(a.allowedWeapons, d.hash)
        end
    end
end)

local function e(f)
    local g = GetActivePlayers()
    local h = -1
    local i = -1
    local j = PlayerPedId()
    local k = GetEntityCoords(j)
    for l, m in ipairs(g) do
        local n = GetPlayerPed(m)
        if n ~= j then
            local o = GetEntityCoords(n)
            local p = #(o - k)
            if h == -1 or h > p then
                i = m
                h = p
            end
        end
    end
    if h ~= -1 and h <= f then
        return i
    else
        return nil
    end
end
local function q(r)
    if not HasAnimDictLoaded(r) then
        RequestAnimDict(r)
        while not HasAnimDictLoaded(r) do
            Wait(0)
        end
    end
    return r
end
local function s(t)
    BeginTextCommandPrint("STRING")
    AddTextComponentSubstringPlayerName(t)
    EndTextCommandPrint(1000, 1)
end
RegisterCommand("takehostage",function()
    callTakeHostage()
end)

RegisterCommand("th",function()
    callTakeHostage()
end)

function callTakeHostage()
    if isInGreenzone then
        return
    end
    ClearPedSecondaryTask(PlayerPedId())
    DetachEntity(PlayerPedId(), true, false)
    local u = false
    for v = 1, #a.allowedWeapons do
        if HasPedGotWeapon(PlayerPedId(), a.allowedWeapons[v], false) then
            if GetAmmoInPedWeapon(PlayerPedId(), a.allowedWeapons[v]) > 0 then
                u = true
                foundWeapon = a.allowedWeapons[v]
                break
            end
        end
    end
    if not u then
        drawNativeNotification("You need a pistol with ammo to take a hostage at gunpoint!")
    end
    if not a.InProgress and u then
        local i = e(3)
        if i then
            local w = GetPlayerServerId(i)
            if w ~= -1 then
                local x = IsEntityPlayingAnim(GetPlayerPed(i), "missminuteman_1ig_2", "handsup_enter", 3)
                if x then
                    tARMA.setWeapon(PlayerPedId(), foundWeapon, true)
                    a.InProgress = true
                    a.startTime = GetGameTimer()
                    a.targetSrc = w
                    TriggerServerEvent("ARMA:takeHostageSync", w)
                    a.type = "agressor"
                else
                    drawNativeNotification("Player must have his hands up!")
                end
            else
                drawNativeNotification("~r~No one nearby to take as hostage!")
            end
        else
            drawNativeNotification("~r~No one nearby to take as hostage!")
        end
    end
end
RegisterNetEvent("ARMA:takeHostageSyncTarget",function(y)
    local n = GetPlayerPed(GetPlayerFromServerId(y))
    a.InProgress = true
    AttachEntityToEntity(PlayerPedId(),n,0,a.hostage.attachX,a.hostage.attachY,a.hostage.attachZ,0.5,0.5,0.0,false,false,false,false,2,false)
    a.type = "hostage"
end)

RegisterNetEvent("ARMA:takeHostageReleaseHostage",function()
    a.InProgress = false
    a.type = ""
    DetachEntity(PlayerPedId(), true, false)
    q("reaction@shove")
    TaskPlayAnim(PlayerPedId(), "reaction@shove", "shoved_back", 8.0, -8.0, -1, 0, 0, false, false, false)
    RemoveAnimDict("reaction@shove")
    Wait(250)
    ClearPedSecondaryTask(PlayerPedId())
end)

RegisterNetEvent("ARMA:takeHostageKillHostage",function()
    a.InProgress = false
    a.type = ""
    SetEntityHealth(PlayerPedId(), 0)
    DetachEntity(PlayerPedId(), true, false)
    q("anim@gangops@hostage@")
    TaskPlayAnim(PlayerPedId(), "anim@gangops@hostage@", "victim_fail", 8.0, -8.0, -1, 168, 0, false, false, false)
    RemoveAnimDict("anim@gangops@hostage@")
end)

RegisterNetEvent("ARMA:takeHostageCl_stop",function()
    a.InProgress = false
    a.type = ""
    ClearPedSecondaryTask(PlayerPedId())
    DetachEntity(PlayerPedId(), true, false)
end)

Citizen.CreateThread(function()
    while true do
        if a.type == "agressor" then
            if not IsEntityPlayingAnim(PlayerPedId(), a.agressor.animDict, a.agressor.anim, 3) then
                q(a.agressor.animDict)
                TaskPlayAnim(PlayerPedId(),a.agressor.animDict,a.agressor.anim,8.0,-8.0,100000,a.agressor.flag,0,false,false,false)
                RemoveAnimDict(a.agressor.animDict)
            end
        elseif a.type == "hostage" then
            if not IsEntityPlayingAnim(PlayerPedId(), a.hostage.animDict, a.hostage.anim, 3) then
                q(a.hostage.animDict)
                TaskPlayAnim(PlayerPedId(),a.hostage.animDict,a.hostage.anim,8.0,-8.0,100000,a.hostage.flag,0,false,false,false)
                RemoveAnimDict(a.hostage.animDict)
            end
        end
        Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        if a.type == "agressor" then
            DisableControlAction(0, 24, true)
            DisableControlAction(0, 25, true)
            DisableControlAction(0, 47, true)
            DisableControlAction(0, 58, true)
            DisableControlAction(0, 21, true)
            DisablePlayerFiring(PlayerPedId(), true)
            s("Press [G] to release, [H] to kill")
            if IsEntityDead(PlayerPedId()) then
                a.type = ""
                a.InProgress = false
                q("reaction@shove")
                TaskPlayAnim(PlayerPedId(),"reaction@shove","shove_var_a",8.0,-8.0,-1,168,0,false,false,false)
                RemoveAnimDict("reaction@shove")
                TriggerServerEvent("ARMA:takeHostageReleaseHostage", a.targetSrc)
            end
            if IsDisabledControlJustPressed(0, 47) then
                a.type = ""
                a.InProgress = false
                q("reaction@shove")
                TaskPlayAnim(PlayerPedId(),"reaction@shove","shove_var_a",8.0,-8.0,-1,168,0,false,false,false)
                RemoveAnimDict("reaction@shove")
                TriggerServerEvent("ARMA:takeHostageReleaseHostage", a.targetSrc)
            elseif IsDisabledControlJustPressed(0, 74) and GetGameTimer() - a.startTime > 4000 then
                a.type = ""
                a.InProgress = false
                q("anim@gangops@hostage@")
                TaskPlayAnim(PlayerPedId(),"anim@gangops@hostage@","perp_fail",8.0,-8.0,-1,168,0,false,false,false)
                RemoveAnimDict("anim@gangops@hostage@")
                TriggerServerEvent("ARMA:takeHostageKillHostage", a.targetSrc)
                TriggerServerEvent("ARMA:takeHostageStop", a.targetSrc)
                Wait(100)
                SetPedShootsAtCoord(PlayerPedId(), 0.0, 0.0, 0.0, 0)
            end
        elseif a.type == "hostage" then
            DisableControlAction(0, 21, true)
            DisableControlAction(0, 24, true)
            DisableControlAction(0, 25, true)
            DisableControlAction(0, 47, true)
            DisableControlAction(0, 58, true)
            DisableControlAction(0, 263, true)
            DisableControlAction(0, 264, true)
            DisableControlAction(0, 257, true)
            DisableControlAction(0, 140, true)
            DisableControlAction(0, 141, true)
            DisableControlAction(0, 142, true)
            DisableControlAction(0, 143, true)
            DisableControlAction(0, 75, true)
            DisableControlAction(27, 75, true)
            DisableControlAction(0, 22, true)
            DisableControlAction(0, 32, true)
            DisableControlAction(0, 268, true)
            DisableControlAction(0, 33, true)
            DisableControlAction(0, 269, true)
            DisableControlAction(0, 34, true)
            DisableControlAction(0, 270, true)
            DisableControlAction(0, 35, true)
            DisableControlAction(0, 271, true)
        end
        Wait(0)
    end
end)
function tARMA.takeHostageInProgress()
    return a.InProgress
end
