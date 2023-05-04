local a = {{entryPosition = vector3(1109.76, 227.89, -49.64)}}
local b
local c
local d = false
c = "m4lb"
RMenu.Add("luckywheel", "casino", RageUI.CreateMenu("", "", 0, 100, "casinoui_lucky_wheel", "casinoui_lucky_wheel"))
RMenu:Get("luckywheel", "casino"):SetSubtitle("~b~You may only spin the wheel once per restart.")
RegisterNetEvent("ARMA:frameworkCleanup")
AddEventHandler("ARMA:frameworkCleanup",function()
    DeleteEntity(b)
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('luckywheel', 'casino')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            RageUI.ButtonWithStyle("Spin the wheel of ARMA (50,000 Chips)","",{RightLabel = "→→→"},true,function(e, f, g)
                if g then
                    tARMA.notify("~r~Biome's dad needs to fix it.")
                    --TriggerServerEvent("ARMA:requestSpinLuckyWheel")
                end
            end)
        end)
    end
end)

function showCasinoLuckyWheelUI(h)
    RageUI.ActuallyCloseAll()
    RageUI.Visible(RMenu:Get("luckywheel", "casino"), h)
end
Citizen.CreateThread(function()
    while not insideDiamondCasino do
        Wait(1000)
    end
    local i = tARMA.loadModel("vw_prop_vw_luckywheel_02a")
    local j = tARMA.loadModel(c)
    b = CreateObject(i, 1111.05, 229.81, -50.38, false, false, true)
    SetEntityHeading(b, 0.0)
    SetModelAsNoLongerNeeded(i)
    local k = CreateVehicle(j, 1100.39, 220.09, -51.25, 0.0, false, false)
    DecorSetInt(k,"ARMAACVeh",955)
    SetModelAsNoLongerNeeded(j)
    FreezeEntityPosition(k, true)
    local l = GetEntityCoords(k)
    SetEntityCoords(k, l.x, l.y, l.z + 1, false, false, true, true)
    SetVehicleOnGroundProperly(k, 5.0)
    c = k
end)

Citizen.CreateThread(function()
    while not insideDiamondCasino do
        Wait(1000)
    end
    while true do
        if insideDiamondCasino then
            if c ~= nil then
                local m = GetEntityHeading(c)
                local n = m - 0.1
                SetEntityHeading(c, n)
            end
        end
        Citizen.Wait(5)
    end
end)

function actuallyRollWheel(o)
    SetEntityHeading(b, -30.9754)
    Citizen.CreateThread(function()
        local p = 1
        local q
        local r = (o - 1) * 18
        local s = r + 360 * 8
        local t = s / 2
        local u = 0
        local v = -20
        while p > 0 do
            local w = GetEntityRotation(b, 1)
            if s > t then
                p = p + 1
            else
                p = p - 1
                if p < 0 then
                    p = 0
                end
            end
            u = u + 1
            q = p / 200
            local x = w.y - q
            if x - v < 5 and x - v > -5 then
                local soundId = PlaySoundFromCoord(GetSoundId(),"Spin_Single_Ticks",1109.76,227.89,-49.64,"dlc_vw_casino_lucky_wheel_sounds",0,0,0)
                SetTimeout(100,function()
                    ReleaseSoundId(soundId)
                end)
                v = v - 20
                if v == -180 then
                    v = 180
                end
            else
                if v == 180 then
                    angleCounter2 = -180
                    if x - angleCounter2 < 5 and x - angleCounter2 > -5 then
                        SetTimeout(100,function()
                            ReleaseSoundId(soundId)
                        end)
                    end
                    v = v - 20
                end
            end
            s = s - q
            SetEntityHeading(b, -30.9754)
            SetEntityRotation(b, 0.0, x, 0.0, 2, true)
            Citizen.Wait(5)
        end
        PlaySoundFromCoord(GetSoundId(),"Win",1109.76,227.89,-49.64,"dlc_vw_casino_lucky_wheel_sounds",0,0,0)
        d = false
    end)
end
function goToWheel()
    if not d then
        d = true
        local y = tARMA.getPlayerPed()
        local z = "anim_casino_a@amb@casino@games@lucky7wheel@female"
        if IsPedMale(y) then
            z = "anim_casino_a@amb@casino@games@lucky7wheel@male"
        end
        local A, B = z, "enter_right_to_baseidle"
        RequestAnimDict(A)
        Wait(50)
        local C = vector3(1109.55, 228.88, -49.64)
        TaskGoStraightToCoord(y, C.x, C.y, C.z, 1.0, -1, 312.2, 0.0)
        local D = false
        while not D do
            local E = GetEntityCoords(tARMA.getPlayerPed())
            if E.x >= C.x - 0.01 and E.x <= C.x + 0.01 and E.y >= C.y - 0.01 and E.y <= C.y + 0.01 then
                D = true
            end
            Citizen.Wait(0)
        end
        TaskPlayAnim(y, A, B, 8.0, -8.0, -1, 0, 0, false, false, false)
        while IsEntityPlayingAnim(y, A, B, 3) do
            Citizen.Wait(0)
            DisableAllControlActions(0)
        end
        TaskPlayAnim(y, A, "enter_to_armraisedidle", 8.0, -8.0, -1, 0, 0, false, false, false)
        while IsEntityPlayingAnim(y, A, "enter_to_armraisedidle", 3) do
            Citizen.Wait(0)
            DisableAllControlActions(0)
        end
        TaskPlayAnim(y, A, "armraisedidle_to_spinningidle_high", 8.0, -8.0, -1, 0, 0, false, false, false)
        SetEntityHeading(tARMA.getPlayerPed(), 10.9754)
        Wait(2000)
        TaskPlayAnim(y, A, "baseidle_variation_02", 8.0, -8.0, -1, 1, 0, false, false, false)
    end
end

AddEventHandler("ARMA:onClientSpawn",function(D, E)
    if E then
		local H = function(I)
            showCasinoLuckyWheelUI(true)
        end
        local J = function(I)
            showCasinoLuckyWheelUI(false)
        end
        local K = function(I)
        end
        local L = function(I)
        end
        for M, N in pairs(a) do
            tARMA.addBlip(N.entryPosition.x, N.entryPosition.y, N.entryPosition.z, 681, 0, "ARMA Wheel", 0.7, true)
            tARMA.createArea("armawheel_" .. M, N.entryPosition, 1.5, 6, H, J, K, {})
        end
	end
end)

RegisterNetEvent("ARMA:syncLuckyWheel")
AddEventHandler("ARMA:syncLuckyWheel",function(O)
    Wait(900)
    actuallyRollWheel(O)
end)

RegisterNetEvent("ARMA:spinLuckyWheel")
AddEventHandler("ARMA:spinLuckyWheel",function()
    goToWheel()
end)

RegisterNetEvent("ARMA:spinLuckyWheelReaction")
AddEventHandler("ARMA:spinLuckyWheelReaction",function(P)
    local y = tARMA.getPlayerPed()
    local A = "anim_casino_a@amb@casino@games@lucky7wheel@female"
    if IsPedMale(y) then
        A = "anim_casino_a@amb@casino@games@lucky7wheel@male"
    end
    TaskPlayAnim(y, A, "win" .. P, 8.0, -8.0, -1, 0, 0, false, false, false)
end)
