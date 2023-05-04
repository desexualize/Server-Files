local a = module("cfg/cfg_scubadiving")
local b = {}
local c
local d = 0
local e = false
local f = ""
local g = 0
local h
local i = false
RMenu.Add("scubadiving","main",RageUI.CreateMenu("", "", tARMA.getRageUIMenuWidth(), tARMA.getRageUIMenuHeight(), "banners", "scubajob"))
RMenu:Get("scubadiving", "main"):SetSubtitle("ARMA | ~b~Scuba Diving")
local function j()
    RageUI.ActuallyCloseAll()
    RageUI.Visible(RMenu:Get("scubadiving", "main"), true)
end
local function k()
    RageUI.ActuallyCloseAll()
    RageUI.Visible(RMenu:Get("scubadiving", "main"), false)
end
AddEventHandler("ARMA:onClientSpawn",function(l, m)
    if m then
        local n = tARMA.createDynamicPed(a.jobPedModel,a.jobPedPosition,a.jobPedHeading,true,"mini@strip_club@idles@bouncer@base","base",100,false,function(o)
            local p = math.random(1, 15)
            SetPedComponentVariation(o, 11, 243, p, 0)
            SetPedComponentVariation(o, 3, 123, 0, 0)
            SetPedComponentVariation(o, 4, 94, p, 0)
            SetPedComponentVariation(o, 6, 67, 1, 0)
            SetPedComponentVariation(o, 7, 40, 1, 0)
            SetPedComponentVariation(o, 8, 15, 0, 1)
            SetPedScubaGearVariation(o)
        end)
        tARMA.addBlip(a.jobPosition.x, a.jobPosition.y, a.jobPosition.z, 308, 0, "Scuba Diving")
        tARMA.addMarker(a.jobPosition.x,a.jobPosition.y,a.jobPosition.z - 0.2,0.5,0.5,0.5,0,50,255,170,50,20,false,false,true)
        local q = function(r)
            j()
        end
        local s = function(r)
            k()
        end
        local t = function(r)
        end
        tARMA.createArea("scubajob", a.jobPosition, 1.5, 6, q, s, t, {})
    end
end)
RageUI.CreateWhile(1.0,true,function()
    if RageUI.Visible(RMenu:Get("scubadiving", "main")) then
        RageUI.DrawContent({header=true,glare=false,instructionalButton=true},function()
            if not e then
                RageUI.Button("Request Job",nil,{RightLabel = "→→→"},true,function(u, v, w)
                    if w then
                        TriggerServerEvent("ARMA:requestScubaJob")
                    end
                end)
            end
            if d ~= 0 then
                RageUI.Button("Claim Reward",nil,{RightLabel = "→→→"},true,function(u, v, w)
                    if w then
                        TriggerServerEvent("ARMA:claimScubaReward", c)
                        d = 0
                        c = nil
                        e = false
                        i = false
                        if DoesEntityExist(g) then
                            DeleteVehicle(g)
                        end
                        tARMA.setCustomization(h)
                        local x = PlayerPedId()
                        SetEnableScuba(x, false)
                        SetPedMaxTimeUnderwater(x, 10.0)
                        tARMA.setMaxUnderWaterUITimenewTime(10.0)
                    end
                end)
            end
        end)
    end
end)
local function y()
    for z, A in pairs(b) do
        tARMA.removeMarker(A.objectMarker)
        tARMA.removeArea(A.objectArea)
        if DoesEntityExist(A.objectId) then
            DeleteEntity(A.objectId)
        end
    end
    b = {}
end
function startScubaDiving()
    tARMA.loadAnimDict("missheistchem2")
    local x = PlayerPedId()
    local B = GetVehiclePedIsIn(x, false)
    local C = GetEntityCoords(B)
    SetBoatAnchor(B, true)
    SetVehicleEngineOn(B, false, 0, 0)
    ClearPedTasksImmediately(x)
    local D = CreateSynchronizedScene(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2)
    TaskSynchronizedScene(x, D, "missheistchem2", "Boat_Dive_Enter_Player", 1000.0, -8.0, 4, 0, 1148846080, 0)
    AttachSynchronizedSceneToEntity(D, B, 0)
    StartAudioScene("FBI_5_DIVE_IN_SYNC_SCENE")
    while IsSynchronizedSceneRunning(D) and GetSynchronizedScenePhase(D) < 1.0 do
        Wait(0)
    end
    local E = CreateSynchronizedScene(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2)
    TaskSynchronizedScene(x, E, "missheistchem2", "Boat_Dive_Idle_Player", 8.0, -8.0, 4, 0, 8.0, 1024)
    AttachSynchronizedSceneToEntity(E, B, 0)
    SetSynchronizedSceneLooped(E, 1)
    local F = false
    SetPedScubaGearVariation(GetPlayerPed(-1))
    tARMA.drawNativeNotification("Press ~INPUT_PICKUP~ to start Scuba Diving.")
    while not F do
        if IsControlJustReleased(1, 38) then
            break
        end
        Wait(0)
    end
    SetPlayerControl(PlayerId(), false, 256)
    local E = CreateSynchronizedScene(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2)
    TaskSynchronizedScene(PlayerPedId(),E,"missheistchem2","Boat_Dive_Exit_Player",1000.0,-8.0,4,0,1148846080,0)
    AttachSynchronizedSceneToEntity(E, B, 0)
    local G = false
    local H = false
    local I = false
    SetEnableScuba(x, true)
    SetPedMaxTimeUnderwater(x, 400.0)
    tARMA.setMaxUnderWaterUITimenewTime(400.0)
    while IsSynchronizedSceneRunning(E) do
        if GetSynchronizedScenePhase(E) > 0.147 and not G then
            tARMA.loadPtfx("scr_fbi5a")
            StartParticleFxNonLoopedOnEntity("scr_fbi5_ped_water_splash",PlayerPedId(),0.0,0.0,0.0,0.0,0.0,0.0,1065353216,0,0,0)
            RemoveNamedPtfxAsset("scr_fbi5a")
            G = true
        end
        if GetSynchronizedScenePhase(E) > 0.48 and not H then
            tARMA.loadPtfx("scr_fbi5a")
            StartParticleFxNonLoopedOnEntity("water_splash_ped_bubbles",PlayerPedId(),0.0,0.0,0.0,0.0,0.0,0.0,1065353216,0,0,0)
            H = true
            DetachEntity(PlayerPedId())
            RemoveNamedPtfxAsset("scr_fbi5a")
        end
        if GetSynchronizedScenePhase(E) > 0.65 and not I then
            I = true
            DetachEntity(PlayerPedId())
            TaskPlayAnim(PlayerPedId(), "SWIMMING@scuba", "dive_run", 4.0, -1.5, 1000, 131081, 0, 0, 0, 0)
            TaskForceMotionState(PlayerPedId(), -1855028596, 0)
            TaskGoStraightToCoord(PlayerPedId(), C.x, C.y, C.z - 5.0, -7.5, 2, -1, 1193033728)
            SetPlayerControl(PlayerId(), true, 256)
        end
        Wait(0)
    end
    RemoveAnimDict("missheistchem2")
    while GetVehiclePedIsIn(PlayerPedId(), false) ~= B do
        Wait(250)
    end
    f = "~g~Scuba Diving job ended, return to HQ to get paid!"
    SetNewWaypoint(-2195.6926269531, -394.82040405273)
    y()
    if d > 6 then
        d = 6
    end
    TriggerServerEvent("ARMA:finishScubaJob", c, d)
end
RegisterNetEvent("ARMA:createScubaJob",function(J, K)
    c = K
    e = true
    tARMA.disableCustomizationSave(e)
    DoScreenFadeOut(500)
    Wait(600)
    local L = AddBlipForRadius(J.position.x, J.position.y, J.position.z, 250.0)
    SetBlipColour(L, 30)
    SetBlipAlpha(L, 180)
    local q = function(r)
        tARMA.drawNativeNotification("Press ~INPUT_DETONATE~ to begin diving!")
    end
    local s = function(r)
    end
    local t = function(r)
        if IsControlJustReleased(1, 47) then
            local x = tARMA.getPlayerPed()
            local M = tARMA.getPlayerVehicle()
            if M ~= 0 then
                if GetEntityModel(M) ~= GetHashKey("dinghy") then
                    tARMA.notify("~r~You must be in a dinghy to start scuba diving!")
                else
                    tARMA.removeArea("scubajob_" .. J.name)
                    f = "~y~Search for treasures and return to your boat when finished"
                    createRewardObjects(J)
                    CreateThread(startScubaDiving)
                end
            else
                tARMA.notify("~r~You must be in a boat to start scuba diving!")
            end
        end
    end
    SetWaypointOff()
    local N = tARMA.addBlip(J.position.x, J.position.y, J.position.z, J.blipId, J.blipColour, "Scuba Diving")
    SetNewWaypoint(J.position.x, J.position.y)
    tARMA.createArea("scubajob_" .. J.name, J.position, 250, 15, q, s, t, {})
    h = tARMA.getCustomization()
    local p = math.random(1, 15)
    local O = PlayerPedId()
    SetPedComponentVariation(PlayerPedId(), 11, 243, p, 0)
    SetPedComponentVariation(PlayerPedId(), 3, 123, 0, 0)
    SetPedComponentVariation(PlayerPedId(), 4, 94, p, 0)
    SetPedComponentVariation(PlayerPedId(), 6, 67, 1, 0)
    SetPedComponentVariation(PlayerPedId(), 7, 40, 1, 0)
    SetPedComponentVariation(PlayerPedId(), 8, 15, 0, 1)
    SetPedScubaGearVariation(PlayerPedId())
    Wait(0)
    local P = math.random(#J.dinghySpawnPositions)
    SetEntityCoords(PlayerPedId(), J.dinghySpawnPositions[P])
    g = tARMA.spawnVehicle("dinghy",J.dinghySpawnPositions[P].x,J.dinghySpawnPositions[P].y,J.dinghySpawnPositions[P].z,J.dinghySpawnHeading,true,true,true)
    local Q = AddBlipForEntity(g)
    SetBlipSprite(Q, 427)
    SetBlipDisplay(Q, 4)
    SetBlipScale(Q, 1.0)
    SetBlipColour(Q, 2)
    SetBlipAsShortRange(Q, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Scuba Dinghy")
    EndTextCommandSetBlipName(Q)
    Wait(2000)
    local R = NetworkGetNetworkIdFromEntity(g)
    TriggerServerEvent("ARMA:scubaSetVehicle", c, R)
    DoScreenFadeIn(2000)
    SetPedScubaGearVariation(PlayerPedId())
    Citizen.CreateThread(function()
        while e do
            if i then
                drawPlaneScaleForm("~r~MISSION FAILED", "Your boat has been destroyed, go get a new one!")
                SetWaypointOff()
                TriggerServerEvent("ARMA:finishScubaJob", c, 0)
                TriggerServerEvent("ARMA:claimScubaReward", c)
                d = 0
                c = nil
                e = false
                tARMA.disableCustomizationSave(e)
                i = false
                tARMA.setCustomization(h)
                local x = PlayerPedId()
                SetEnableScuba(x, false)
                SetPedMaxTimeUnderwater(x, 10.0)
                tARMA.setMaxUnderWaterUITimenewTime(10.0)
                y()
                break
            end
            Wait(250)
        end
    end)
    f = "~y~Head to the diving location: " .. J.name
    while e do
        drawNativeText(f)
        Wait(0)
    end
    tARMA.removeBlip(N)
    RemoveBlip(L)
end)
RegisterNetEvent("ARMA:ScubaBoatDestroyed",function(S)
    if e and S == c then
        i = true
    end
end)
function createRewardObjects(J)
    for z, A in pairs(J.rewardObjects) do
        local T = tARMA.loadModel(A.objectModel)
        local U = CreateObject(T, A.objectPosition.x, A.objectPosition.y, A.objectPosition.z, false, true, false)
        SetModelAsNoLongerNeeded(T)
        local V =
            tARMA.addMarker(A.objectPosition.x,A.objectPosition.y,A.objectPosition.z + 0.6,0.5,0.5,0.5,255,223,0,150,50.0,0,false,true,true)
        local q = function(r)
            tARMA.drawNativeNotification("Press ~INPUT_PICKUP~ to collect!")
        end
        local s = function(r)
        end
        local t = function(r)
            if IsControlJustReleased(1, 38) and e then
                tARMA.notify("~g~Item collected.")
                d = d + 1
                tARMA.removeMarker(b[r.objectId].objectMarker)
                tARMA.removeArea(b[r.objectId].objectArea)
                DeleteEntity(b[r.objectId].objectId)
                b[r.objectId].objectMarker = nil
                b[r.objectId].objectArea = nil
                b[r.objectId].objectId = nil
            end
        end
        tARMA.createArea("scubajob_" .. J.name .. "_obj_" .. z, A.objectPosition, 3.0, 3.0, q, s, t, {objectId = z})
        b[z] = {}
        b[z].objectId = U
        b[z].objectMarker = V
        b[z].objectArea = "scubajob_" .. J.name .. "_obj_" .. z
    end
end