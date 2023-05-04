local a = module("cfg/cfg_prison")
globalInPrison = false
local b = false
local c = false
local d
local e = {}
local f
local g = false
local h = false
local i = ""
local j = false
local k = 0
local l = 0
local m = 0
local n = false
globalPlayerInPrisonZone = false
RegisterNetEvent("ARMA:prisonBeanbagShotgunClient",function(o)
    SetPedToRagdollWithFall(PlayerPedId(), 5000, 5000, 1, o, 1000.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
end)
AddEventHandler("ARMA:onClientSpawn",function(p, q)
    if q then
        local r = function()
            globalPlayerInPrisonZone = true
        end
        local s = function()
            if b then
                TriggerServerEvent("ARMA:prisonerSentBackToCell")
                tARMA.teleport(a.prisonCells[d].coords.x, a.prisonCells[d].coords.y, a.prisonCells[d].coords.z)
                tARMA.notify("~r~Naughty, go back.")
            end
            globalPlayerInPrisonZone = false
        end
        local t = function()
        end
        tARMA.createArea("forceStayInPrison", a.prisonMainCoords, 225.0, 100.0, r, s, t, {})
        local u = function(v)
            if globalInPrison then
                if v.type == "startingLocations" and i == "" then
                    drawNativeNotification("Press ~INPUT_CONTEXT~ to " .. v.data.action)
                elseif v.type == "endingLocations" and i == v.job then
                    drawNativeNotification("Press ~INPUT_CONTEXT~ to " .. v.data.action)
                end
            end
        end
        local w = function()
        end
        local x = function(v)
            if globalInPrison then
                if IsControlJustPressed(0, 38) then
                    if not h then
                        if v.type == "startingLocations" then
                            h = true
                            i = v.job
                            TriggerServerEvent("ARMA:prisonStartJob", v.job)
                        elseif i == v.job then
                            h = true
                        end
                        if h then
                            FreezeEntityPosition(PlayerPedId(), true)
                            if v.data.heading ~= nil then
                                SetEntityHeading(PlayerPedId(), v.data.heading)
                            end
                            SetEntityCoords(PlayerPedId(), v.coords.x, v.coords.y, v.coords.z)
                            local y = true
                            tARMA.setCanAnim(false)
                            Citizen.CreateThread(function()
                                while y do
                                    if v.data.isScenario == nil then
                                        if not IsEntityPlayingAnim(PlayerPedId(),v.data.animDict,v.data.animName,3) then
                                            tARMA.loadAnimDict(v.data.animDict)
                                            TaskPlayAnim(PlayerPedId(),v.data.animDict,v.data.animName,8.0,1.0,-1,50,0,0,0,0)
                                            RemoveAnimDict(v.data.animDict)
                                        end
                                    else
                                        if not IsPedUsingScenario(PlayerPedId(), v.data.animDict) then
                                            TaskStartScenarioInPlace(PlayerPedId(), v.data.animDict, 0, true)
                                        end
                                    end
                                    Wait(200)
                                end
                            end)
                            Citizen.CreateThread(function()
                                Wait(v.data.duration)
                                FreezeEntityPosition(PlayerPedId(), false)
                                y = false
                                tARMA.setCanAnim(true)
                                ClearPedTasks(PlayerPedId())
                                tARMA.notify(v.data.nextAction)
                                if v.type == "endingLocations" then
                                    i = ""
                                    TriggerServerEvent("ARMA:prisonEndJob", v.job)
                                end
                                h = false
                            end)
                        end
                    end
                end
            end
        end
        for z, A in pairs(a.prisonJobs) do
            for B, C in pairs(A) do
                if type(C.coords) == "table" then
                    for D = 1, #C.coords, 1 do
                        tARMA.createArea("prisonJob_" .. z .. B .. D,C.coords[D],2.0,5.0,u,w,x,{type = z, job = B, data = C, coords = C.coords[D]})
                        tARMA.addMarker(C.coords[D].x,C.coords[D].y,C.coords[D].z + 0.05,0.6,0.6,0.6,30,50,255,255,30,27,false,false,false)
                        tARMA.add3DTextForCoord(C.action, C.coords[D].x, C.coords[D].y, C.coords[D].z + 1.0, 2.2)
                    end
                else
                    tARMA.createArea("prisonJob_" .. z .. B,C.coords,2.0,5.0,u,w,x,{type = z, job = B, data = C, coords = C.coords})
                    tARMA.addMarker(C.coords.x,C.coords.y,C.coords.z + 0.05,0.6,0.6,0.6,30,50,255,255,30,27,false,false,false)
                    tARMA.add3DTextForCoord(C.action, C.coords.x, C.coords.y, C.coords.z + 1.0, 2.2)
                end
            end
        end
    end
end)

RegisterNetEvent("ARMA:setPrisonGuardOnDuty",function(E)
    globalOnPrisonDuty=E 
end)
RegisterNetEvent("ARMA:forcePlayerInPrison",function(E)
    b = E
    globalInPrison = E
end)
RegisterNetEvent("ARMA:prisonUpdateClientTimer",function(F)
    j = false
    local G = math.floor(F / 60)
    if G < 60 then
        l = G
        m = F - math.ceil(l * 60)
    else
        k = math.floor(G / 60)
        l = G - math.ceil(k * 60)
        m = F - G * 60
    end
    j = true
end)
RegisterNetEvent("ARMA:prisonStopClientTimer",function()
    k = 0
    l = 0
    m = 0
    j = false
end)
Citizen.CreateThread(function()
    while true do
        if globalInPrison then
            if j then
                m = m - 1
                if m < 0 then
                    m = 59
                    l = l - 1
                    if l < 0 then
                        l = 59
                        k = k - 1
                        if k < 0 then
                            j = false
                        end
                    end
                end
            end
        end
        Wait(1000)
    end
end)
function func_drawPrisonTimerBar()
    if globalInPrison then
        if j then
            if k == 0 then
                if m < 10 then
                    DrawGTATimerBar("Time Left: ", l .. ":" .. "0" .. m, 3)
                else
                    DrawGTATimerBar("Time Left: ", l .. ":" .. m, 3)
                end
            else
                if l < 10 then
                    if m < 10 then
                        DrawGTATimerBar("Time Left: ", "0" .. k .. ":" .. "0" .. l .. ":" .. "0" .. m, 3)
                    else
                        DrawGTATimerBar("Time Left: ", "0" .. k .. ":" .. "0" .. l .. ":" .. m, 3)
                    end
                else
                    DrawGTATimerBar("Time Left: ", "0" .. k .. ":" .. l .. ":" .. m, 3)
                end
            end
        end
    end
end
tARMA.createThreadOnTick(func_drawPrisonTimerBar)
RegisterNetEvent("ARMA:prisonCreateBreakOutAreas",function()
    local H = false
    local I = function()
        drawNativeNotification("Press ~INPUT_CONTEXT~ to start cutting the wires")
    end
    local J = function()
    end
    local K = function(v)
        if IsControlJustPressed(0, 38) and not g then
            if tARMA.TriggerServerCallback("ARMA:prisonStartWireCutting") then
                g = true
                tARMA.loadAnimDict("anim@gangops@facility@servers@")
                FreezeEntityPosition(PlayerPedId(), true)
                TaskPlayAnim(PlayerPedId(),"anim@gangops@facility@servers@","hotwire",8.0,1.0,-1,1,0,0,0,0)
                SetEntityHeading(PlayerPedId(), v.escapePoint.heading)
                tARMA.notify("~g~Started wire cutting (Press X to cancel)")
                Citizen.CreateThread(function()
                    SetTimeout(60000,function()
                        if g then
                            H = true
                            g = false
                        end
                    end)
                    while g do
                        if not IsEntityPlayingAnim(PlayerPedId(),"anim@gangops@facility@servers@","hotwire",3) then
                            TaskPlayAnim(PlayerPedId(),"anim@gangops@facility@servers@","hotwire",8.0,1.0,-1,1,0,0,0,0)
                        end
                        Wait(200)
                    end
                    RemoveAnimDict("anim@gangops@facility@servers@")
                    if H then
                        FreezeEntityPosition(PlayerPedId(), false)
                        ClearPedTasks(PlayerPedId())
                        TriggerServerEvent("ARMA:prisonBreakOutSuccess")
                        local L = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.5, 0.0)
                        tARMA.teleport(L.x, L.y, L.z)
                    end
                end)
            else
                tARMA.notify("~r~You do not have the required equipment!")
            end
        end
        if IsControlJustPressed(0, 73) and g then
            g = false
            ClearPedTasks(PlayerPedId())
            FreezeEntityPosition(PlayerPedId(), false)
            tARMA.notify("~r~Wire cutting cancelled!")
        end
    end
    for D = 1, #a.escapePoints, 1 do
        tARMA.addMarker(a.escapePoints[D].coords.x,a.escapePoints[D].coords.y,a.escapePoints[D].coords.z,0.6,0.6,0.6,200,0,0,255,70,0,false,true,false)
        tARMA.createArea("prisonEscapeArea_" .. D,a.escapePoints[D].coords,2.0,5.0,I,J,K,{escapePoint = a.escapePoints[D]})
    end
end)
RegisterNetEvent("ARMA:prisonCreateItemAreas",function(M)
    local N = function()
    end
    local O = function()
    end
    local P = function(v)
        if globalInPrison then
            tARMA.DrawText3D(v.coords,"[E] Pickup "..v.item,0.5)
            if IsControlJustPressed(0, 38) then
                TriggerServerEvent("ARMA:prisonPickupItem", v.item)
            end
        end
    end
    for z, A in pairs(M) do
        tARMA.removeArea("prisonPickupItem_" .. z)
        tARMA.createArea("prisonPickupItem_" .. z, A.coords, 2.0, 5.0, N, O, P, {item = z, coords = A.coords})
    end
end)
RegisterNetEvent("ARMA:prisonRemoveItemAreas",function(Q)
    tARMA.removeArea("prisonPickupItem_" .. Q)
end)
RegisterNetEvent("ARMA:prisonReleased",function()
    b = false
    globalInPrison = false
    tARMA.notify("~g~You have been released!")
    tARMA.teleport(a.prisonLeaveCoords.x, a.prisonLeaveCoords.y, a.prisonLeaveCoords.z)
    Citizen.Wait(100)
    SetEntityHeading(PlayerPedId(), 274.58)
    removePrisonBlips()
    j = false
    hoursleft = 0
    l = 0
    m = 0
end)
local function R()
    local S = GetEntityModel(PlayerPedId())
    if S == GetHashKey("mp_m_freemode_01") then
        tARMA.loadCustomisationPreset("PrisonerMale")
    else
        tARMA.loadCustomisationPreset("PrisonerFemale")
    end
end
RegisterNetEvent("ARMA:putInPrisonOnSpawn",function(T)
    Citizen.Wait(5000)
    tARMA.teleport(a.prisonCells[T].coords.x, a.prisonCells[T].coords.y, a.prisonCells[T].coords.z)
    b = true
    globalInPrison = true
    d = T
    Citizen.Wait(100)
    SetEntityHeading(PlayerPedId(), a.prisonCells[T].heading)
    createPrisonBlips()
    createPrisonCraftMenu()
    local S = GetEntityModel(PlayerPedId())
    if S ~= GetHashKey("mp_m_freemode_01") and S ~= GetHashKey("mp_f_freemode_01") then
        tARMA.setCustomization({modelhash = "mp_m_freemode_01"})
    end
    Citizen.Wait(2000)
    R()
end)

RegisterNetEvent("ARMA:prisonTransportWithBus",function(T)
    DetachEntity(PlayerPedId(), false, true)
    R()
    c = true
    local V = getClosestPoliceStation()
    tARMA.teleport(V.coords.x, V.coords.y, V.coords.z)
    Citizen.CreateThread(function()
        while c do
            DisableControlAction(0, 75, true)
            DisableControlAction(27, 75, true)
            Wait(0)
        end
    end)
    local W = tARMA.spawnVehicle("pbus", V.coords.x, V.coords.y, V.coords.z, V.heading, false, false, false)
    RequestModel("s_m_m_prisguard_01")
    while not HasModelLoaded("s_m_m_prisguard_01") do
        Citizen.Wait(0)
    end
    local X = CreatePedInsideVehicle(W, 6, "s_m_m_prisguard_01", -1, false, false)
    SetModelAsNoLongerNeeded("s_m_m_prisguard_01")
    TaskWarpPedIntoVehicle(PlayerPedId(), W, -2)
    Citizen.Wait(2000)
    TaskVehicleDriveToCoordLongrange(X,W,a.prisonArriveCoords.x,a.prisonArriveCoords.y,a.prisonArriveCoords.z,150.0,1,10)
    enter_prisonArrive = function()
        ClearPedTasks(X)
        BringVehicleToHalt(W, 10.0, 5.0, 1)
        Citizen.Wait(3000)
        TaskLeaveVehicle(PlayerPedId(), W, 64)
        TaskGoToCoordAnyMeans(PlayerPedId(), 1845.7423095703, 2585.96484375, 45.672039031982, 1.0, 0, 0, 786603)
        while #(tARMA.getPlayerCoords() - a.prisonArriveMainDoor) > 1 do
            Citizen.Wait(0)
        end
        tARMA.teleport(a.prisonCells[T].coords.x, a.prisonCells[T].coords.y, a.prisonCells[T].coords.z)
        Citizen.Wait(100)
        SetEntityHeading(PlayerPedId(), a.prisonCells[T].heading)
        DeleteEntity(W)
        DeleteEntity(X)
        TriggerServerEvent("ARMA:prisonArrivedForJail")
        c = false
        b = true
        globalInPrison = true
        d = T
        createPrisonBlips()
        createPrisonCraftMenu()
        tARMA.removeArea("prisonArrive")
    end
    exit_prisonArrive = function()
    end
    ontick_prisonArrive = function()
    end
    tARMA.createArea("prisonArrive",a.prisonArriveCoords,5.0,10.0,enter_prisonArrive,exit_prisonArrive,ontick_prisonArrive,{})
end)
RegisterNetEvent("ARMA:prisonSpawnInMedicalBay",function()
    Citizen.Wait(2000)
    tARMA.teleport(a.medicalBayBed.x, a.medicalBayBed.y, a.medicalBayBed.z)
    b = true
    Citizen.Wait(100)
    SetEntityHeading(PlayerPedId(), a.medicalBayHeading)
    tARMA.loadAnimDict("mp_bedmid")
    TaskPlayAnim(PlayerPedId(), "mp_bedmid", "f_sleep_l_loop_bighouse", 8.0, 1.0, -1, 1, 0, 0, 0, 0)
    RemoveAnimDict("mp_bedmid")
end)
RMenu.Add("armaPrisonItemMenu","main",RageUI.CreateMenu("","~b~Craft Items",tARMA.getRageUIMenuWidth(),tARMA.getRageUIMenuHeight(),"banners", "prisonui"))
RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('armaPrisonItemMenu', 'main')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            for D = 1, #a.craftableItems, 1 do
                RageUI.ButtonWithStyle(a.craftableItems[D].name,"Required: " .. a.craftableItems[D].requiredItemString,{RightLabel = "🔨"},true,function(Y, Z, _)
                    if Z then
                        currentButton = D
                    end
                    if _ then
                        if tARMA.TriggerServerCallback("ARMA:prisonCraftItem", currentButton) then
                            local a0 = true
                            FreezeEntityPosition(PlayerPedId(), true)
                            tARMA.loadAnimDict("amb@medic@standing@kneel@base")
                            TaskPlayAnim(PlayerPedId(),"amb@medic@standing@kneel@base","base",8.0,1.0,-1,1,0,0,0,0)
                            Citizen.CreateThread(function()
                                while a0 do
                                    if not IsEntityPlayingAnim(PlayerPedId(),"amb@medic@standing@kneel@base","base",3)then
                                        TaskPlayAnim(PlayerPedId(),"amb@medic@standing@kneel@base","base",8.0,1.0,-1,1,0,0,0,0)
                                    end
                                    Wait(200)
                                end
                                RemoveAnimDict("amb@medic@standing@kneel@base")
                            end)
                            Citizen.Wait(15000)
                            a0 = false
                            FreezeEntityPosition(PlayerPedId(), false)
                            ClearPedTasks(PlayerPedId())
                        else
                            tARMA.notify("~r~You do not have the required items to craft this!")
                        end
                    end
                end,nil)
            end
        end)
    end
end)
RegisterCommand("viewprisoners",function()
    if globalOnPrisonDuty then
        if n then
            n = false
        else
            local a1 = tARMA.TriggerServerCallback("ARMA:requestPrisonerData")
            if a1 ~= nil then
                n = true
                viewPlayersInPrison(a1)
            end
        end
    end
end)
function viewPlayersInPrison(a1)
    while n do
        DrawRect(0.5, 0.5, 0.4, 0.8, 0, 0, 0, 180)
        local a2 = 0.0
        for z, A in pairs(a1) do
            DrawAdvancedText(0.5,0.06 + a2,0.1,0.1,0.5,string.format("Name: %s | Prisoner Number: %s | Cell Number: %s | Time Left: %s minutes",A.prisonerName,A.prisonerSource,A.prisonerCellNumber,A.prisonerTimeLeft),200,200,200,255,4,0)
            a2 = a2 + 0.05
        end
        Wait(0)
    end
end
function createPrisonCraftMenu()
    tARMA.removeMarker(f)
    tARMA.removeArea("prisonCraftItemArea")
    local a3 = function()
        RageUI.Visible(RMenu:Get("armaPrisonItemMenu", "main"), true)
    end
    local a4 = function()
        RageUI.Visible(RMenu:Get("armaPrisonItemMenu", "main"), false)
    end
    local a5 = function()
    end
    local a6 = a.prisonMenuCoords[d].coords
    tARMA.createArea("prisonCraftItemArea", a6, 1.0, 3.0, a3, a4, a5, {})
    f = tARMA.addMarker(a6.x, a6.y, a6.z - 0.975, 0.4, 0.4, 0.5, 30, 50, 255, 255, 30, 27, false, false, false)
end
function createPrisonBlips()
    for D = 1, #a.prisonBlips, 1 do
        e[D] = tARMA.addBlip(a.prisonBlips[D].coords.x,a.prisonBlips[D].coords.y,a.prisonBlips[D].coords.z,a.prisonBlips[D].icon,a.prisonBlips[D].colour,a.prisonBlips[D].name)
    end
    if d then
        e[#e + 1] = tARMA.addBlip(a.prisonCells[d].coords.x,a.prisonCells[d].coords.y,a.prisonCells[d].coords.z,253,22,"Your prison cell")
    end
end
function removePrisonBlips()
    for z, A in pairs(e) do
        tARMA.removeBlip(z)
    end
end
function getClosestPoliceStation()
    for D = 1, #a.allPoliceStations, 1 do
        if #(tARMA.getPlayerCoords() - a.allPoliceStations[D].coords) <= 800 then
            return a.allPoliceStations[D]
        end
    end
    return a.allPoliceStations[1]
end
function nearPrisonPayPhone()
    for D = 1, #a.prisonPayPhones, 1 do
        if #(tARMA.getPlayerCoords() - a.prisonPayPhones[D].coords) <= 3.0 then
            return true
        end
    end
    return false
end
function isPlayerInPrison()
    return globalInPrison
end
function isPlayerNearPrison()
    return globalPlayerInPrisonZone or globalInRedzone
end
exports("isPlayerNearPrison", isPlayerNearPrison)
exports("isPlayerInPrison", isPlayerInPrison)
exports("nearPrisonPayPhone", nearPrisonPayPhone)