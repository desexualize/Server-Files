local a = module("cfg/atms")
local b = false
RMenu.Add("armaatm","mainmenu",RageUI.CreateMenu("", "", tARMA.getRageUIMenuWidth(), tARMA.getRageUIMenuHeight(), "banners", "atm"))
RMenu:Get("armaatm", "mainmenu"):SetSubtitle("~b~ATM")
RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('armaatm', 'mainmenu')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            RageUI.Button("Deposit", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected) 
                if Selected then
                    local e = getAtmAmount()
                    if tonumber(e) then
                        if GetVehiclePedIsIn(PlayerPedId(), false) == 0 then
                            if a then
                                tARMA.playAnim(false, {{"amb@prop_human_atm@male@exit", "exit"}}, false)
                                TriggerServerEvent('ARMA:Deposit', tonumber(e))
                            else
                                tARMA.notify("~r~Not near ATM.")
                            end
                        else
                            tARMA.notify("~r~Get out your vehicle to use the ATM")
                        end
                    else
                        tARMA.notify("~r~Invalid amount.")
                    end
                end
            end)
            RageUI.Button("Withdraw", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected) 
                if Selected then
                    local e = getAtmAmount()
                    if tonumber(e) then
                        if GetVehiclePedIsIn(PlayerPedId(), false) == 0 then
                            if a then
                                tARMA.playAnim(false, {{"amb@prop_human_atm@male@exit", "exit"}}, false)
                                TriggerServerEvent('ARMA:Withdraw', tonumber(e))
                            else
                                tARMA.notify("~r~Not near ATM.")
                            end
                        else
                            tARMA.notify("~r~Get out your vehicle to use the ATM")
                        end
                    else
                        tARMA.notify("~r~Invalid amount.")
                    end
                end
            end)
            RageUI.Button("Deposit All", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected) 
                if Selected then
                    if GetVehiclePedIsIn(PlayerPedId(), false) == 0 then
                        if a then
                            tARMA.playAnim(false, {{"amb@prop_human_atm@male@exit", "exit"}}, false)
                            TriggerServerEvent('ARMA:DepositAll')
                        else
                            tARMA.notify("~r~Not near ATM.")
                        end
                    else
                        tARMA.notify("~r~Get out your vehicle to use the ATM")
                    end
                end
            end)
            RageUI.Button("Withdraw All", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected) 
                if Selected then
                    if GetVehiclePedIsIn(PlayerPedId(), false) == 0 then
                        if a then
                            tARMA.playAnim(false, {{"amb@prop_human_atm@male@exit", "exit"}}, false)
                            TriggerServerEvent('ARMA:WithdrawAll')
                        else
                            tARMA.notify("~r~Not near ATM.")
                        end
                    else
                        tARMA.notify("~r~Get out your vehicle to use the ATM")
                    end
                end
            end)
        end)
    end
end)

local function g()
    RageUI.CloseAll()
    RageUI.Visible(RMenu:Get("armaatm", "mainmenu"), true)
end
local function h()
    RageUI.CloseAll()
    RageUI.Visible(RMenu:Get("armaatm", "mainmenu"), false)
end
Citizen.CreateThread(function()
    local i = function(j)
        tARMA.setCanAnim(false)
        g()
        b = true
    end
    local k = function(j)
        h()
        tARMA.setCanAnim(true)
        b = false
    end
    local l = function(j)
    end
    for m, n in pairs(a.atms) do
        tARMA.createArea("atm_" .. m, n, 1.5, 6, i, k, l, {atmId = m})
        local o = tARMA.addBlip(n.x, n.y, n.z, 108, 4, "ATM", 0.8, true)
        tARMA.addMarker(n.x, n.y, n.z, 0.7, 0.7, 0.5, 0, 255, 125, 125, 50, 29, false, false, true)
        for p, q in pairs(a.robberyAtms) do
            if #(n - q.xyz) < 5.0 then
                --SetBlipColour(o, 1)
            end
        end
    end
end)
function getAtmAmount()
    AddTextEntry("FMMC_MPM_NA", "Enter amount")
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Enter amount", "", "", "", "", 30)
    while UpdateOnscreenKeyboard() == 0 do
        DisableAllControlActions(0)
        Wait(0)
    end
    if GetOnscreenKeyboardResult() then
        local r = GetOnscreenKeyboardResult()
        if r then
            return r
        end
    end
    return false
end
local s = {}
function tARMA.createAtm(t, u)
    local i = function()
        tARMA.setCanAnim(false)
        g()
        b = true
    end
    local k = function()
        h()
        tARMA.setCanAnim(true)
        b = false
    end
    local v = string.format("atm_%s", t)
    tARMA.createArea(v,u,1.5,6,i,k,function()end)
    local w = tARMA.addMarker(u.x, u.y, u.z, 0.7, 0.7, 0.5, 0, 255, 125, 125, 50, 29, false, false, true)
    s[t] = {area = v, marker = w}
end
function tARMA.deleteAtm(t)
    local x = s[t]
    if x then
        tARMA.removeMarker(x.marker)
        tARMA.removeArea(x.area)
        s[t] = nil
    end
end
local y = false
local function z(A)
    local B = true
    local C = false
    Citizen.CreateThread(function()
        while not C do
            drawNativeNotification("Press ~INPUT_JUMP~ in the correct area to cut the wire.")
            Citizen.Wait(0)
        end
    end)
    for p = 1, math.random(3, 4) do
        local D = math.random(1, 4) <= 3 and "Easy" or "Medium"
        local E = true
        tARMA.minigameCircularProgressBar({Difficulty = D, Timeout = 25000, onComplete = function(F)
            B = F
            E = false
        end, onTimeout = function()
            B = false
            E = false
        end})
        while E do
            drawNativeText("Cut the wires")
            Citizen.Wait(0)
        end
        tARMA.setPlayerCombatTimer(30, false)
        if not B then
            PlaySoundFrontend(-1, "HACKING_CLICK_BAD", "", false)
            break
        else
            PlaySoundFrontend(-1, "HACKING_SUCCESS", "", true)
            Citizen.Wait(2000)
            PlaySoundFrontend(-1, "HACKING_CLICK", "", true)
            tARMA.startCircularProgressBar("",2000,nil,function()end)
            TriggerServerEvent("ARMA:atmWireCutSparks", A, false)
            Citizen.Wait(2000)
        end
    end
    C = true
    return B
end
local function G(H)
    local I = math.rad(-0.8738472)
    local J = math.rad(H.w)
    local K = vector3(-math.sin(J) * math.abs(math.cos(I)), math.cos(J) * math.abs(math.cos(I)), math.sin(I))
    return H.xyz + K * 0.65
end
RegisterNetEvent("ARMA:atmWireCuttingSuccessSync",function(A)
    local L = a.robberyAtms[A]
    local M = G(L)
    tARMA.loadPtfx("core")
    StartParticleFxNonLoopedAtCoord("ent_sht_electrical_box",M.x,M.y,M.z - 0.5,L.w,0.0,0.0,2.0,false,false,false)
    RemoveNamedPtfxAsset("core")
    tARMA.loadPtfx("scr_xs_celebration")
    local N = StartParticleFxLoopedAtCoord("scr_xs_money_rain",M.x,M.y,M.z - 0.2,L.w + 90.0,0.0,0.0,1.0,false,false,false,0)
    RemoveNamedPtfxAsset("scr_xs_celebration")
    Citizen.Wait(15000)
    StopParticleFxLooped(N, false)
end)
RegisterNetEvent("ARMA:atmWireCuttingSuccess",function()
    local O = GetGameTimer()
    local P = 0
    while true do
        local Q = GetGameTimer()
        if Q - O > 15000 then
            break
        elseif Q - P >= math.random(150, 650) then
            PlaySoundFrontend(-1, "Bus_Schedule_Pickup", "DLC_PRISON_BREAK_HEIST_SOUNDS", false)
            P = Q
        end
        Citizen.Wait(0)
    end
end)
RegisterNetEvent("ARMA:atmWireCutSparks",function(A)
    local L = a.robberyAtms[A]
    local M = G(L)
    tARMA.loadPtfx("core")
    StartParticleFxNonLoopedAtCoord("ent_dst_electrical",M.x,M.y,M.z - 0.5,L.w,0.0,0.0,2.0,false,false,false)
    RemoveNamedPtfxAsset("core")
end)
RegisterNetEvent("ARMA:startAtmWireCutting",function(A)
    y = true
    local V = PlayerPedId()
    local L = a.robberyAtms[A]
    tARMA.setCanAnim(false)
    tARMA.setPlayerCombatTimer(30, false)
    tARMA.setWeapon(V, "WEAPON_UNARMED", true)
    ClearPedTasksImmediately(V)
    Citizen.Wait(1000)
    TaskGoStraightToCoord(V, L.x, L.y, L.z, 1.0, 5000, L.w, 0.1)
    while GetScriptTaskStatus(V, "SCRIPT_TASK_GO_STRAIGHT_TO_COORD") ~= 7 do
        Citizen.Wait(0)
    end
    tARMA.loadClipSet("move_ped_crouched")
    SetPedCanPlayAmbientAnims(V, false)
    SetPedCanPlayAmbientBaseAnims(V, false)
    SetPedMovementClipset(V, "move_ped_crouched", 0.35)
    SetPedStrafeClipset(V, "move_ped_crouched_strafing")
    RemoveClipSet("move_ped_crouched")
    tARMA.loadAnimDict("mini@repair")
    TaskPlayAnim(V, "mini@repair", "fixing_a_ped", 8.0, -8.0, -1, 17, 0, false, false, false)
    RemoveAnimDict("mini@repair")
    local W = z(A)
    TriggerServerEvent("ARMA:returnAtmWireCutting", A, W)
    StopAnimTask(V, "mini@repair", "fixing_a_ped", 1.0)
    ResetPedStrafeClipset(V)
    ResetPedMovementClipset(V, 0.0)
    SetPedCanPlayAmbientAnims(V, true)
    SetPedCanPlayAmbientBaseAnims(V, true)
    tARMA.setCanAnim(true)
    y = false
end)
RegisterNetEvent("ARMA:atmInkArea",function(A)
    local L = a.robberyAtms[A]
    tARMA.loadPtfx("veh_xs_vehicle_mods")
    for p = 1, 10 do
        UseParticleFxAsset("veh_xs_vehicle_mods")
        StartParticleFxNonLoopedAtCoord("exp_xs_mine_tar",L.x,L.y,L.z - 0.5,0.0,0.0,0.0,1.0,false,false,false)
        Citizen.Wait(50)
    end
    RemoveNamedPtfxAsset("veh_xs_vehicle_mods")
end)
RegisterNetEvent("ARMA:atmGenericAlarm",function(A)
    local L = a.robberyAtms[A]
    while not RequestScriptAudioBank("Alarms", false) do
        Citizen.Wait(0)
    end
    local X = GetSoundId()
    PlaySoundFromCoord(X, "Burglar_Bell", L.x, L.y, L.z, "Generic_Alarms", false, 0.05, false)
    Citizen.Wait(60000)
    StopSound(X)
    ReleaseSoundId(X)
end)
local Y = 0
local Z = 0
local _ = false
local a0 = 0
local function a1(j)
    Y = math.random(6, 12)
    a0 = 0
    TriggerServerEvent("ARMA:getAtmHasBeenRobbed", j.robberyId)
end
local function a2(j)
    if y then
        TriggerServerEvent("ARMA:atmStopWireCutting", j.robberyId)
    end
    Z = 0
end
local function a3()
    RequestScriptAudioBank("NIGEL_02_CRASH_A", true, -1)
    RequestScriptAudioBank("NIGEL_02_CRASH_B", true, -1)
    Citizen.Wait(500)
    local a4 = tARMA.getPlayerCoords()
    local a5 = math.random(1, 10) >= 8 and "WINDOW_CRASH" or "WALL_CRASH"
    PlaySoundFromCoord(-1, a5, a4.x, a4.y, a4.z, "NIGEL_02_SOUNDSET", 0, 0, 0)
    Citizen.Wait(1500)
    ReleaseNamedScriptAudioBank("NIGEL_02_CRASH_B")
    ReleaseNamedScriptAudioBank("NIGEL_02_CRASH_A")
end
local a6 = {{"des_vaultdoor", "ent_ray_pro1_concrete_impacts"}, {"des_fib_glass", "ent_ray_fbi2_window_break"}}
local function a7()
    local a8 = a6[math.random(1, #a6)]
    tARMA.loadPtfx(a8[1])
    Citizen.Wait(500)
    UseParticleFxAsset(a8[1])
    local a4 = tARMA.getPlayerCoords() + GetEntityForwardVector(PlayerPedId()) * 1.0
    StartParticleFxNonLoopedAtCoord(a8[2], a4.x, a4.y, a4.z, 0.0, 0.0, 0.0, 1.0, false, false, false)
    RemoveNamedPtfxAsset(a8[1])
end
local function a9(j)
    if y then
        return
    end
    local V = PlayerPedId()
    if select(2, GetCurrentPedWeapon(V)) == "WEAPON_CROWBAR" then
        if a0 > 0 then
            local T = a0 + 900000 - GetNetworkTime()
            if T > 0 then
                local aa = formatTimeString(formatTime(T / 1000))
                drawNativeNotification("This ATM has been robbed recently. You can rob it in " .. aa, true)
            end
            return
        end
        drawNativeNotification("Hit the ATM with ~INPUT_ATTACK~ to begin breaking the door.")
        if Z > 0 then
            local ab = math.floor(Z / Y * 100)
            if ab > 100 then
                ab = 100
            end
            subtitleText("~r~ATM door damage " .. tostring(ab) .. "%")
        end
        if RageUI.Visible(RMenu:Get("armaatm", "mainmenu")) then
            RageUI.Visible(RMenu:Get("armaatm", "mainmenu"), false)
        end
        DisableControlAction(0, 24, true)
        if IsDisabledControlJustPressed(0, 24) and not _ then
            Citizen.CreateThreadNow(function()
                _ = true
                local L = a.robberyAtms[j.robberyId]
                ClearPedTasks(V)
                TaskGoStraightToCoord(V, L.x, L.y, L.z, 1.0, 3000, L.w, 0.35)
                while GetScriptTaskStatus(V, "SCRIPT_TASK_GO_STRAIGHT_TO_COORD") ~= 7 do
                    Citizen.Wait(0)
                end
                tARMA.loadAnimDict("melee@small_wpn@streamed_core")
                V = PlayerPedId()
                TaskPlayAnim(V,"melee@small_wpn@streamed_core","ground_attack_on_spot",8.0,8.0,-1,1,1.0,false,false,false)
                RemoveAnimDict("melee@small_wpn@streamed_core")
                Citizen.CreateThread(a3)
                Citizen.CreateThread(a7)
                Citizen.Wait(2000)
                ClearPedTasks(V)
                Z = Z + 1
                if Z >= Y then
                    TriggerServerEvent("ARMA:startAtmWireCutting", j.robberyId)
                end
                TaskPedSlideToCoord(V, L.x, L.y, L.z, L.w, 2000)
                while GetScriptTaskStatus(V, "SCRIPT_TASK_PED_SLIDE_TO_COORD") ~= 7 do
                    Citizen.Wait(0)
                end
                _ = false
            end)
        end
    end
end
Citizen.CreateThread(function()
    for A, L in pairs(a.robberyAtms) do
        tARMA.createArea("atmrobbery_" .. A, L.xyz, 1.5, 6, a1, a2, a9, {robberyId = A})
    end
end)
RegisterNetEvent("ARMA:setAtmHasBeenRobbed",function(ac)
    a0 = ac
end)
