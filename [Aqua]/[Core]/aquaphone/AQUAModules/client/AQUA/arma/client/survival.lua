spawning = true
local a = {}
local b = false
local c = 100000
local d = 0
local e = 300
local f = false
local g = ""
local h = 100
local i = false
local j
local k = GetGameTimer()
local l = 0
local m = 102
local n = 0
WeaponNames = {}
local o = module("arma-weapons", "cfg/weapons")
local p = module("cfg/cfg_respawn")
local q = {}
local r = {}
Citizen.CreateThread(function()
    r = o.nativeWeaponModelsToNames
    for s, t in pairs(o.weapons) do
        r[s] = t.name
    end
    for s, u in pairs(r) do
        WeaponNames[GetHashKey(s)] = u
        q[GetHashKey(s)] = s
    end
    local v = module("cfg/cfg_housing")
    for w, x in pairs(v.homes) do
        p.spawnLocations[w] = {
            name = w,
            coords = vector3(x.entry_point[1], x.entry_point[2], x.entry_point[3]),
            permission = {},
            image = x.image or "https://cdn.cmg.city/content/fivem/houses/citysmallhome.png",
            price = 5000
        }
    end
end)

local y = -1
RegisterNetEvent("ARMA:setNHSCallerId",function(z)
    y = z
end)

AddEventHandler("ARMA:countdownEnded",function()
    f = true
end)

Citizen.CreateThread(function()
    while true do
        if IsDisabledControlJustPressed(0, 38) then
            if b and not i then
                local A = GetEntityCoords(GetPlayerPed(-1))
                if not tARMA.isPlayerInRedZone() and not tARMA.isPlayerInTurf() then -- and not tARMA.isInPaintball() and not globalInBoxingZone then
                    PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                    tARMA.notify("~g~NHS have been notified.")
                    TriggerServerEvent('ARMA:NHSComaCall')
                    TriggerEvent("ARMA:DEATH_SCREEN_NHS_CALLED")
                end
                i = true
            elseif f and b then
                PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                TriggerEvent("ARMA:CLOSE_DEATH_SCREEN")
                tARMA.respawnPlayer()
                i = false
                if y ~= -1 then
                    TriggerServerEvent("ARMA:endNHSCall", y)
                end
                TriggerEvent("ARMA:respawnKeyPressed")
                TriggerServerEvent('ARMA:SendSpawnMenu')
            end
            Wait(1000)
        end
        Wait(0)
    end
end)

local function C()
    local D = tARMA.getPlayerCoords()
    for E, F in pairs(GetGamePool("CPed")) do
        if IsEntityDead(F) and not IsPedAPlayer(F) and #(GetEntityCoords(F, true) - D) < 25.0 then
            local G = GetEntityModel(F)
            if G == "mp_m_freemode_01" or G == "mp_f_freemode_01" then
                DeleteEntity(F)
            end
        end
    end
end
Citizen.CreateThread(function()
    Wait(500)
    exports.spawnmanager:setAutoSpawn(false)
    while true do
        Wait(0)
        local F = GetPlayerPed(-1)
        local H = GetEntityHealth(F)
        if IsEntityDead(GetPlayerPed(-1)) and not b then
            pbCounter = 100
            local I = GetEntityCoords(GetPlayerPed(-1), true)
            if currentBackpack then
                TriggerEvent('ARMA:removeBackpack')
            end
            if not tARMA.isPurge() then
                TriggerServerEvent("ARMA:forceStoreWeapons")
            end
            tARMA.ejectVehicle()
            b = true
            j = I
            TriggerServerEvent("ARMA:getNumOfNHSOnline")
            local x,y,z = table.unpack(I)
            ARMAserver.updatePos({x,y,z})
            ARMAserver.updateHealth({0})
            tARMA.setArmour(0)
            Wait(250)
        end
        if h <= 0 then
            h = 100
            local J = GetEntityHealth(GetPlayerPed(-1))
            while J <= 100 do
                Wait(0)
                local K = tARMA.getPosition()
                local L = PlayerPedId()
                NetworkResurrectLocalPlayer(K.x, K.y, K.z, GetEntityHeading(GetPlayerPed(-1)), true, true)
                DeleteEntity(L)
                J = GetEntityHealth(GetPlayerPed(-1))
            end
            SetEntityHealth(GetPlayerPed(-1), 102)
            SetEntityInvincible(GetPlayerPed(-1), true)
            a = getRandomComaAnimation()
            tARMA.loadAnimDict(a.dict)
            TaskPlayAnim(GetPlayerPed(-1), a.dict, a.anim, 3.0, 1.0, -1, 1, 0, 0, 0, 0)
            RemoveAnimDict(a.dict)
            C()
        end
        if H > m and b then
            if IsEntityDead(GetPlayerPed(-1)) then
                local K = tARMA.getPosition()
                local L = PlayerPedId()
                NetworkResurrectLocalPlayer(K.x, K.y, K.z, GetEntityHeading(GetPlayerPed(-1)), true, true)
                DeleteEntity(L)
                Wait(0)
            end
            TriggerEvent("ARMA:CLOSE_DEATH_SCREEN")
            c = 100000
            d = 0
            pbCounter = 100
            f = false
            g = ""
            tARMA.disableComa()
            h = 100
            SetEntityInvincible(GetPlayerPed(-1), false)
            ClearPedSecondaryTask(GetPlayerPed(-1))
            Citizen.CreateThread(
                function()
                    Wait(500)
                    ClearPedSecondaryTask(GetPlayerPed(-1))
                    ClearPedTasks(GetPlayerPed(-1))
                end
            )
        end
        local H = GetEntityHealth(GetPlayerPed(-1))
        if H <= m and not b then
            SetEntityHealth(GetPlayerPed(-1), 0)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        if b then
            local L = PlayerPedId()
            if not IsEntityDead(L) then
                if a.dict == nil then
                    a = getRandomComaAnimation()
                end
                if not IsEntityPlayingAnim(L, a.dict, a.anim, 3) and not tARMA.isUsingStretcher() then
                    if a.dict ~= nil then
                        tARMA.loadAnimDict(a.dict)
                        TaskPlayAnim(L, a.dict, a.anim, 3.0, 1.0, -1, 1, 0, 0, 0, 0)
                        RemoveAnimDict(a.dict)
                    end
                end
            end
            if GetEntityHealth(L) > m then
                tARMA.disableComa()
                if IsEntityDead(L) then
                    local K = tARMA.getPosition()
                    local M = PlayerPedId()
                    NetworkResurrectLocalPlayer(K.x, K.y, K.z, GetEntityHeading(GetPlayerPed(-1)), true, true)
                    DeleteEntity(M)
                    Wait(0)
                end
                c = 100000
                d = 0
                pbCounter = 100
                g = ""
                tARMA.disableComa()
                h = 100
                SetEntityInvincible(L, false)
                ClearPedSecondaryTask(L)
            end
        end
        Wait(0)
    end
end)

function tARMA.RevivePlayer()
    local F = GetPlayerPed(-1)
    if IsEntityDead(F) then
        local K = tARMA.getPosition()
        local L = PlayerPedId()
        NetworkResurrectLocalPlayer(K.x, K.y, K.z, GetEntityHeading(GetPlayerPed(-1)), true, true)
        DeleteEntity(L)
        Citizen.Wait(0)
    end
    local N = PlayerId()
    SetPlayerControl(N, true, false)
    if not IsEntityVisible(F) then
        SetEntityVisible(F, true)
    end
    if not IsPedInAnyVehicle(F) then
        SetEntityCollision(F, true)
    end
    FreezeEntityPosition(F, false)
    SetPlayerInvincible(N, false)
    SetEntityHealth(F, 200)
    tARMA.disableComa()
    h = 100
    local F = GetPlayerPed(-1)
    SetEntityInvincible(F, false)
    ClearPedSecondaryTask(GetPlayerPed(-1))
    Citizen.CreateThread(
        function()
            Wait(500)
            ClearPedSecondaryTask(GetPlayerPed(-1))
            ClearPedTasks(GetPlayerPed(-1))
        end
    )
    TriggerEvent("ARMA:CLOSE_DEATH_SCREEN")
    if y ~= -1 then
        TriggerServerEvent("ARMA:endNHSCall", y)
    end
end

RegisterNetEvent("ARMA:getNumberOfDocsOnline",function(O)
    if not tARMA.isPurge() then
        if tARMA.isPlayerInRedZone() or tARMA.isPlayerInTurf() then
            bleedoutDuration = 50000
        elseif O >= 3 and O <= 5 and not globalNHSOnDuty then
            bleedoutDuration = 170000
        elseif O >= 3 and not globalNHSOnDuty then
            bleedoutDuration = 290000
        else
            bleedoutDuration = 50000
        end
        d = bleedoutDuration + 10000
    else
        d = 3000
    end
    e = d / 1000
    h = 10
    k = GetGameTimer()
    l = d
    local P = false
    if not tARMA.isPurge() then
        if GetVehiclePedIsIn(PlayerPedId(), false) ~= 0 then
            P = true
        else
            TriggerEvent('ARMA:IsInMoneyComa', true)
            ExecuteCommand('storeallweapons')
            if not tARMA.globalOnPoliceDuty() then
                TriggerServerEvent('ARMA:InComa')
            end
            ARMAserver.MoneyDrop()
        end
    end
    CreateThread(function()
        local Q = GetGameTimer()
        while tARMA.getKillerInfo().ready == nil do
            Wait(0)
        end
        local R = tARMA.getKillerInfo()
        local S = false
        if R.name == nil then
            S = true
        end
        f = false
        TriggerEvent("ARMA:SHOW_DEATH_SCREEN", e, R.name or "N/A", R.user_id or "N/A", R.weapon or "N/A", S)
    end)
    if not tARMA.isPurge() then
        while h <= 10 and h >= 0 do
            Wait(1000)
            h = h - 1
        end
        if P then
            TriggerEvent('ARMA:IsInMoneyComa', true)
            ExecuteCommand('storeallweapons')
            if not tARMA.globalOnPoliceDuty() then
                TriggerServerEvent('ARMA:InComa')
            end
            ARMAserver.MoneyDrop()
        end
    end
end)

local T = 0
RegisterNetEvent("ARMA:OpenSpawnMenu",function(U)
    DoScreenFadeIn(1000)
    TriggerScreenblurFadeIn(100.0)
    ExecuteCommand("hideui")
    SetPlayerControl(PlayerId(), false, 0)
    local L = PlayerPedId()
    local V = tARMA.getPlayerCoords()
    FreezeEntityPosition(L, true)
    SetEntityCoordsNoOffset(L, V.x, V.y, -100.0, false, false, false)
    SetEntityVisible(L, false, 0)
    TriggerEvent('ARMA:removeBackpack')
    T = CreateCameraWithParams("DEFAULT_SCRIPTED_CAMERA",675.57568359375,1107.1724853516,375.29666137695,0.0,0.0,0.0,65.0,0,2)
    SetCamActive(T, true)
    RenderScriptCams(true, true, 0, true, false)
    SetCamParams(T, -1024.6506347656, -2712.0234375, 79.889106750488, 0.0, 0.0, 0.0, 65.0, 250000, 0, 0, 2)
    local W = {}
    for E, w in pairs(U) do
        if p.spawnLocations[w] then
            table.insert(W, p.spawnLocations[w])
        end
    end
    TriggerEvent("ARMADEATHUI:openSpawnMenu", W)
end)

AddEventHandler("ARMA:respawnButtonClicked",function(X, Y)
    if Y and Y > 0 then
        TriggerServerEvent("ARMA:takeAmount", Y)
    end
    local Z = p.spawnLocations[X].coords
    TriggerEvent("ARMA:playGTAIntro")
    tARMA.ClearWeapons()
    if tARMA.isHandcuffed() then
        TriggerEvent("ARMA:toggleHandcuffs", false)
    end
    SetEntityCoords(PlayerPedId(), Z)
    SetEntityVisible(PlayerPedId(), true, 0)
    SetPlayerControl(PlayerId(), true, 0)
    SetFocusPosAndVel(Z.x, Z.y, Z.z + 1000)
    DestroyCam(T)
    local _ = CreateCameraWithParams("DEFAULT_SCRIPTED_CAMERA", Z.x, Z.y, Z.z + 1000.0, 0.0, 0.0, 0.0, 65.0, 0, 2)
    SetCamActive(_, true)
    RenderScriptCams(true, true, 0, true, false)
    SetCamParams(_, Z.x, Z.y, Z.z, 0.0, 0.0, 0.0, 65.0, 5000, 0, 0, 2)
    Wait(2500)
    ClearFocus()
    Wait(2000)
    FreezeEntityPosition(PlayerPedId(), false)
    DestroyCam(_)
    RenderScriptCams(false, true, 2000, false, false)
    TriggerScreenblurFadeOut(2000.0)
    ExecuteCommand("showui")
    ClearFocus()
end)

function tARMA.respawnPlayer()
    DoScreenFadeOut(1000)
    c = 100000
    d = 0
    pbCounter = 100
    f = false
    g = ""
    SetEntityInvincible(PlayerPedId(), false)
    Wait(1000)
    local L = PlayerPedId()
    local A = GetEntityCoords(L)
    SetEntityCoordsNoOffset(L, A.x, A.y, A.z, false, false, false)
    NetworkResurrectLocalPlayer(A.x, A.y, A.z, 0.0, true, true)
    DeleteEntity(L)
    ClearPedTasksImmediately(L)
    RemoveAllPedWeapons(L)
    TriggerServerEvent('ARMA:playerRespawned')
end

function tARMA.disableComa()
    b = false
    i = false
end

function tARMA.isInComa()
    return b
end

local a0 = false
function tARMA.isTazed(a1)
    return a0 or IsPedBeingStunned(PlayerPedId(), 0) or tARMA.isPedBeingTackled() or isInGreenzone and not globalOnPoliceDuty and not a1
end
function tARMA.isTazedByRevive()
    return a0
end
RegisterNetEvent("TriggerTazer",function()
    a0 = true
    tARMA.setCanAnim(false)
    local L = PlayerPedId()
    tARMA.loadClipSet("move_m@drunk@verydrunk")
    SetPedMinGroundTimeForStungun(L, 15000)
    SetPedMovementClipset(L, "move_m@drunk@verydrunk", 1.0)
    RemoveClipSet("move_m@drunk@verydrunk")
    SetTimecycleModifier("spectator5")
    SetPedIsDrunk(L, true)
    Wait(15000)
    a0 = false
    tARMA.setCanAnim(true)
    SetPedMotionBlur(L, true)
    Wait(60000)
    ClearTimecycleModifier()
    ResetScenarioTypesEnabled()
    ResetPedMovementClipset(L, 0)
    SetPedIsDrunk(L, false)
    SetPedMotionBlur(L, false)
end)
function getRandomComaAnimation()
    local a2 = {
        {"combat@damage@writheidle_a", "writhe_idle_a"},
        {"combat@damage@writheidle_a", "writhe_idle_b"},
        {"combat@damage@writheidle_a", "writhe_idle_c"},
        {"combat@damage@writheidle_b", "writhe_idle_d"},
        {"combat@damage@writheidle_b", "writhe_idle_e"},
        {"combat@damage@writheidle_b", "writhe_idle_f"},
        {"combat@damage@writheidle_c", "writhe_idle_g"},
        {"combat@damage@rb_writhe", "rb_writhe_loop"},
        {"combat@damage@writhe", "writhe_loop"}
    }
    local a3 = {}
    local a4, a5 = table.unpack(a2[math.random(1, #a2)])
    a3["dict"] = a4
    a3["anim"] = a5
    return a3
end
local R = {}
function tARMA.getKillerInfo()
    return R
end
Citizen.CreateThread(function()
    Wait(10000)
    local a6, a7, a8, a9, s
    while true do
        Citizen.Wait(0)
        if IsEntityDead(PlayerPedId()) then
            Citizen.Wait(500)
            local aa = GetPedSourceOfDeath(PlayerPedId())
            a8 = GetPedCauseOfDeath(PlayerPedId())
            a9 = WeaponNames[a8]
            s = q[a8]
            if IsEntityAPed(aa) and IsPedAPlayer(aa) then
                a7 = NetworkGetPlayerIndexFromPed(aa)
            elseif
                IsEntityAVehicle(aa) and IsEntityAPed(GetPedInVehicleSeat(aa, -1)) and
                    IsPedAPlayer(GetPedInVehicleSeat(aa, -1))
                then
                a7 = NetworkGetPlayerIndexFromPed(GetPedInVehicleSeat(aa, -1))
            end
            local ab = tARMA.getPedServerId(aa)
            if inOrganHeist then
                TriggerServerEvent("ARMA:diedInOrganHeist", ab)
                tARMA.setDeathInOrganHeist()
            end
            local ac = false
            local ad = 0
            if a7 == PlayerId() or a7 == nil then
                ac = true
            else
                local ae = GetPlayerName(a7)
                R.name = ae
                ad = #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(aa))
            end
            R.source = ab
            R.user_id = tARMA.getUserId(ab)
            R.weapon = tostring(a9)
            R.ready = true
            if GetGameTimer() < k + 10000 then
                local ab = tARMA.getPedServerId(aa)
                TriggerServerEvent("ARMA:onPlayerKilled", "killed", ab, a9, ac, ad)
                n = 0
            elseif GetGameTimer() < k + l then
                local ab = tARMA.getPedServerId(aa)
                l = 0
                TriggerServerEvent("ARMA:onPlayerKilled", "finished off", ab, a9)
                n = 0
            end
            a7 = nil
            a6 = nil
            a8 = nil
            a9 = nil
        end
        while IsEntityDead(PlayerPedId()) do
            Citizen.Wait(0)
        end
        R = {}
    end
end)

function tARMA.varyHealth(ag)
    local F = PlayerPedId()
    local ah = math.floor(GetEntityHealth(F) + ag)
    SetEntityHealth(F, ah)
end
function tARMA.getHealth()
    return GetEntityHealth(PlayerPedId())
end
function tARMA.setHealth(H)
    local ah = math.floor(H)
    SetEntityHealth(PlayerPedId(), ah)
end
function tARMA.setFriendlyFire(ai)
    NetworkSetFriendlyFireOption(ai)
    SetCanAttackFriendly(GetPlayerPed(-1), ai, ai)
end
AddEventHandler("ARMA:onClientSpawn",function(aj, ak)
    if ak then
        local N = PlayerId()
        SetPoliceIgnorePlayer(N, true)
        SetDispatchCopsForPlayer(N, false)
        tARMA.setFriendlyFire(true)
    end
end)