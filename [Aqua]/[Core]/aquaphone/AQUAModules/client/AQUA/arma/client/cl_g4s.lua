local a = false
local b = 0
local c = 0
local d = vector3(-710.4659, 269.6835, 83.13184)
local e = false
local f = false
local g = 0
local h = false
local i = 0
local j = false
local k = 0
local l = 0
local m = {}
local n = "g4svan"
local o = "g4svan"
local p = {}
local q = {}
local r = false
local s = {}
local t = false
local u = false
local x = 0
local y = 0
local z = ""
local A = {
    hackingEngaged = false,
    netId = 0,
    entity = 0,
    src = 0,
    successful = false,
    hackingCooldown = false,
    awaitingResponse = false
}
local B = {x = -709.134, y = 277.1604, z = 83.89014, heading = 288.89}
local C = {active = false, handle = 0}
local function D()
    local E = tARMA.getPlayerPed()
    local F = 500 * math.ceil(GetDistanceBetweenCoords(tARMA.getPlayerCoords(), GetEntityCoords(b), true) / 10)
    if j then
        RenderScriptCams(0, 1, F, 1, 0)
        ClearTimecycleModifier()
        if DoesCamExist(cameraHandle) then
            DestroyCam(cameraHandle)
        end
        j = false
    else
        cameraHandle = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
        AttachCamToEntity(cameraHandle, b, 2.5, 5.0, 2.0, true)
        local G = GetEntityHeading(b)
        PointCamAtEntity(cameraHandle, b, 1, 1, 1, true)
        RenderScriptCams(1, 1, F, 1, 1)
        Wait(F)
        SetTimecycleModifier("scanline_cam_cheap")
        SetTimecycleModifierStrength(3.0)
        j = true
    end
end
RMenu.Add("g4s","shiftHandler",RageUI.CreateMenu("","Security Company",tARMA.getRageUIMenuWidth(),tARMA.getRageUIMenuHeight(),"banners", "g4s"))
RMenu:Get("g4s", "shiftHandler"):SetSubtitle("Security Company")
RMenu:Get("g4s", "shiftHandler").Closable = true
RMenu.Add("g4s","main",RageUI.CreateMenu("","Security Company",tARMA.getRageUIMenuWidth(),tARMA.getRageUIMenuHeight(),"banners", "g4s"))
RMenu:Get("g4s", "main"):SetSubtitle("Security Company")
RMenu:Get("g4s", "main").Closable = true
TriggerEvent("chat:addSuggestion", "/g4s", "Toggles your G4S menu.")
tARMA.addMarker(d.x, d.y, d.z, 1.2, 1.2, 1.2, 0, 255, 125, 125, 50, 0, true, true)
local H = tARMA.addBlip(d.x, d.y, d.z, 457, 18, "G4S Depot", 1.0, false)
local I = function()
    RageUI.Visible(RMenu:Get("g4s", "shiftHandler"), true)
end
local J = function()
    RageUI.Visible(RMenu:Get("g4s", "shiftHandler"), false)
end
local K = function()
end
tARMA.createArea("g4sDepot_", d, 1.5, 6, I, J, K)
Citizen.CreateThread(function()
    while true do
        local E = tARMA.getPlayerPed()
        local L = tARMA.getPlayerCoords()
        if a then
            if not u then
                displayJob()
            end
            if m.jobActive then
                if not m.collected then
                    if t then
                        DrawMarker(29,m.collectionCoords.x,m.collectionCoords.y,m.collectionCoords.z,0.0,0.0,0.0,0.0,180.0,0.0,1.5,1.5,1.5,0,221,255,36,90,true,false,2,nil,nil,false)
                    else
                        DrawMarker(29,m.collectionCoords.x,m.collectionCoords.y,m.collectionCoords.z,0.0,0.0,0.0,0.0,180.0,0.0,1.5,1.5,1.5,0,255,36,36,90,true,false,2,nil,nil,false)
                    end
                    if m.collecting then
                        if not C.active then
                            --toggleCashbox()
                        end
                    else
                        RageUI.Text({message = "Drive to ~b~" .. m.collectionName})
                        if not r then
                            securityCheck(E)
                        end
                    end
                elseif not m.deposited then
                    if m.depositing then
                        if not C.active then
                            --toggleCashbox()
                        end
                    else
                        RageUI.Text({message = "Drive to ~b~" .. m.depositName})
                        if not r then
                            securityCheck(E)
                        end
                    end
                    DrawMarker(29,m.depositCoords.x,m.depositCoords.y,m.depositCoords.z,0.0,0.0,0.0,0.0,180.0,0.0,1.5,1.5,1.5,255,36,36,50,true,true,2,nil,nil,false)
                end
            end
            if j then
                RageUI.Visible(RMenu:Get("g4s", "shiftHandler"), true)
            end
        else
        end
        Wait(0)
    end
end)
Citizen.CreateThread(function()
    while true do
        if not A.hackingEngaged and not a and not A.awaitingResponse then
            if table.count(s) > 0 and tARMA.getPlayerVehicle() == 0 then
                for M, N in pairs(s) do
                    local O = N[3]
                    local P = N[2]
                    local Q = N[1]
                    if table.has(p, Q) or not DoesEntityExist(P) then
                        s[M] = nil
                    else
                        if IsVehicleStopped(P) then
                            local R = #(tARMA.getPlayerCoords() - GetEntityCoords(P))
                            local S = GetOffsetFromEntityInWorldCoords(b, 0.0, -6.0, 0.0)
                            if R <= 11.0 then
                                DrawMarker(29,S.x,S.y,S.z + 0.5,0.0,0.0,0.0,0.0,180.0,0.0,1.5,1.5,1.5,255,36,36,50,true,false,2,nil,nil,false)
                                RageUI.Text({message = "~b~G4S~w~: Press ENTER to hack."})
                                if IsControlJustPressed(1, 18) then
                                    A.netId = O
                                    A.entity = P
                                    A.src = Q
                                    TriggerServerEvent("ARMA:requestHackingChanceServer", O, Q)
                                    A.awaitingResponse = true
                                    break
                                end
                            elseif R <= 35.0 then
                                DrawMarker(29,S.x,S.y,S.z + 0.5,0.0,0.0,0.0,0.0,180.0,0.0,1.5,1.5,1.5,255,36,36,50,true,false,2,nil,nil,false)
                            end
                        end
                    end
                end
            end
        end
        Wait(0)
    end
end)
function toggleCashbox()
    if C.active then
        DeleteObject(C.handle)
        C.active = false
    else
        local o = tARMA.loadModel("cashbox")
        local E = tARMA.getPlayerPed()
        C.handle = CreateObject(o, 0, 0, 0, true, true, true)
        while not DoesEntityExist(C.handle) do
            Wait(0)
        end
        C.active = true
        AttachEntityToEntity(C.handle,E,GetPedBoneIndex(E, 57005),0.50,0,0.03,-95.0,0,90.0,true,true,false,true,1,true)
        SetModelAsNoLongerNeeded(o)
    end
end
local T = nil
local U
local V = 2
local W = "HONGKONG"
local X = 8
RegisterNetEvent("ARMA:hackingChanceReturn",function(b, Y, Z, _)
    if _ then
        A.hackingEngaged = true
        A.awaitingResponse = false
        W = Z
        V = 2
        PlaySoundFrontend(-1, "5s_To_Event_Start_Countdown", "GTAO_FM_Events_Soundset", true)
        beginHacking()
        FreezeEntityPosition(tARMA.getPlayerPed(), true)
        tARMA.setWeapon(tARMA.getPlayerPed(), "weapon_unarmed", true)
        local o = tARMA.loadModel("prop_cs_tablet")
        x = CreateObject(o, 0, 0, 0, true, true, true)
        AttachEntityToEntity(x,tARMA.getPlayerPed(),GetPedBoneIndex(tARMA.getPlayerPed(), 57005),0.17,0.10,-0.13,24.0,180.0,180.0,true,true,false,true,1,true)
        SetModelAsNoLongerNeeded(o)
    else
        A.awaitingResponse = false
    end
end)
function beginHacking()
    Citizen.CreateThread(function()
        function Initialize(T)
            local T = RequestScaleformMovieInteractive(T)
            while not HasScaleformMovieLoaded(T) do
                Citizen.Wait(0)
            end
            BeginScaleformMovieMethod(T, "SET_LABELS")
            ScaleformMovieMethodAddParamTextureNameString("Local Disk (C:)")
            ScaleformMovieMethodAddParamTextureNameString("G4S Network")
            ScaleformMovieMethodAddParamTextureNameString("External Device (E:)")
            ScaleformMovieMethodAddParamTextureNameString("HackConnect.exe")
            ScaleformMovieMethodAddParamTextureNameString("G4SHack.exe")
            EndScaleformMovieMethod()
            BeginScaleformMovieMethod(T, "SET_BACKGROUND")
            ScaleformMovieMethodAddParamInt(math.random(1, 6))
            EndScaleformMovieMethod()
            BeginScaleformMovieMethod(T, "ADD_PROGRAM")
            ScaleformMovieMethodAddParamFloat(1.0)
            ScaleformMovieMethodAddParamFloat(4.0)
            ScaleformMovieMethodAddParamTextureNameString("G4S Control Panel")
            EndScaleformMovieMethod()
            BeginScaleformMovieMethod(T, "ADD_PROGRAM")
            ScaleformMovieMethodAddParamFloat(6.0)
            ScaleformMovieMethodAddParamFloat(6.0)
            ScaleformMovieMethodAddParamTextureNameString("Power Off")
            EndScaleformMovieMethod()
            BeginScaleformMovieMethod(T, "SET_COLUMN_SPEED")
            ScaleformMovieMethodAddParamInt(0)
            ScaleformMovieMethodAddParamInt(255)
            EndScaleformMovieMethod()
            BeginScaleformMovieMethod(T, "SET_COLUMN_SPEED")
            ScaleformMovieMethodAddParamInt(1)
            ScaleformMovieMethodAddParamInt(255)
            EndScaleformMovieMethod()
            BeginScaleformMovieMethod(T, "SET_COLUMN_SPEED")
            ScaleformMovieMethodAddParamInt(2)
            ScaleformMovieMethodAddParamInt(255)
            EndScaleformMovieMethod()
            BeginScaleformMovieMethod(T, "SET_COLUMN_SPEED")
            ScaleformMovieMethodAddParamInt(3)
            ScaleformMovieMethodAddParamInt(255)
            EndScaleformMovieMethod()
            BeginScaleformMovieMethod(T, "SET_COLUMN_SPEED")
            ScaleformMovieMethodAddParamInt(4)
            ScaleformMovieMethodAddParamInt(255)
            EndScaleformMovieMethod()
            BeginScaleformMovieMethod(T, "SET_COLUMN_SPEED")
            ScaleformMovieMethodAddParamInt(5)
            ScaleformMovieMethodAddParamInt(255)
            EndScaleformMovieMethod()
            BeginScaleformMovieMethod(T, "SET_COLUMN_SPEED")
            ScaleformMovieMethodAddParamInt(6)
            ScaleformMovieMethodAddParamInt(255)
            EndScaleformMovieMethod()
            BeginScaleformMovieMethod(T, "SET_COLUMN_SPEED")
            ScaleformMovieMethodAddParamInt(7)
            ScaleformMovieMethodAddParamInt(255)
            EndScaleformMovieMethod()
            return T
        end
        T = Initialize("HACKING_PC")
        while true do
            DrawScaleformMovieFullscreen(T, 255, 255, 255, 255, 0)
            BeginScaleformMovieMethod(T, "SET_CURSOR")
            ScaleformMovieMethodAddParamFloat(GetControlNormal(0, 239))
            ScaleformMovieMethodAddParamFloat(GetControlNormal(0, 240))
            EndScaleformMovieMethod()
            if IsDisabledControlJustPressed(0, 24) then
                BeginScaleformMovieMethod(T, "SET_INPUT_EVENT_SELECT")
                U = EndScaleformMovieMethod()
                PlaySoundFrontend(-1, "HACKING_CLICK", "", true)
            elseif IsDisabledControlJustPressed(0, 25) then
                BeginScaleformMovieMethod(T, "SET_INPUT_EVENT_BACK")
                EndScaleformMovieMethod()
                PlaySoundFrontend(-1, "HACKING_CLICK", "", true)
            end
            if s[A.netId] == nil or not A.hackingEngaged then
                SetScaleformMovieAsNoLongerNeeded(T)
                V = 0
                Wait(2000)
                break
            end
            Citizen.Wait(0)
        end
    end)
end
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if HasScaleformMovieLoaded(T) then
            DisableControlAction(0, 24, true)
            DisableControlAction(0, 25, true)
            if IsScaleformMovieMethodReturnValueReady(U) then
                ProgramID = GetScaleformMovieMethodReturnValueInt(U)
                if ProgramID == 82 then
                    PlaySoundFrontend(-1, "HACKING_CLICK_BAD", "", false)
                elseif ProgramID == 83 then
                    BeginScaleformMovieMethod(T, "RUN_PROGRAM")
                    ScaleformMovieMethodAddParamFloat(83.0)
                    EndScaleformMovieMethod()
                    BeginScaleformMovieMethod(T, "SET_ROULETTE_WORD")
                    ScaleformMovieMethodAddParamTextureNameString(W)
                    EndScaleformMovieMethod()
                elseif ProgramID == 87 then
                    V = 0
                    BeginScaleformMovieMethod(T, "SET_ROULETTE_WORD")
                    ScaleformMovieMethodAddParamTextureNameString(W)
                    EndScaleformMovieMethod()
                    Wait(100)
                    BeginScaleformMovieMethod(T, "OPEN_ERROR_POPUP")
                    ScaleformMovieMethodAddParamBool(true)
                    ScaleformMovieMethodAddParamTextureNameString("MET POLICE AWARE, DEVICE SHUTTING DOWN")
                    EndScaleformMovieMethod()
                    Wait(100)
                    SetScaleformMovieAsNoLongerNeeded(T)
                    EndScaleformMovieMethod()
                    imageNotification("notification_images","g4slogo","Our security team have activated the panic for this vehicle.","G4S Security","Police Notified")
                    imageNotification("notification_images","g4slogo","You have failed to hack this vehicle.","G4S Security","Police Notified")
                    TriggerServerEvent("ARMA:updateHackingOutcome", A.netId, A.src, W, false)
                    DeleteObject(x)
                    break
                elseif ProgramID == 92 then
                    PlaySoundFrontend(-1, "HACKING_CLICK_GOOD", "", false)
                elseif ProgramID == 86 then
                    PlaySoundFrontend(-1, "HACKING_SUCCESS", "", true)
                    BeginScaleformMovieMethod(T, "SET_ROULETTE_OUTCOME")
                    ScaleformMovieMethodAddParamBool(true)
                    ScaleformMovieMethodAddParamTextureNameString("G4S HACK SUCCESSFUL!")
                    EndScaleformMovieMethod()
                    Wait(3800)
                    BeginScaleformMovieMethod(T, "CLOSE_APP")
                    EndScaleformMovieMethod()
                    BeginScaleformMovieMethod(T, "OPEN_LOADING_PROGRESS")
                    ScaleformMovieMethodAddParamBool(true)
                    EndScaleformMovieMethod()
                    BeginScaleformMovieMethod(T, "SET_LOADING_PROGRESS")
                    ScaleformMovieMethodAddParamInt(35)
                    EndScaleformMovieMethod()
                    BeginScaleformMovieMethod(T, "SET_LOADING_TIME")
                    ScaleformMovieMethodAddParamInt(35)
                    EndScaleformMovieMethod()
                    BeginScaleformMovieMethod(T, "SET_LOADING_MESSAGE")
                    ScaleformMovieMethodAddParamTextureNameString("Writing data to hack..")
                    ScaleformMovieMethodAddParamFloat(4.0)
                    EndScaleformMovieMethod()
                    Wait(1500)
                    BeginScaleformMovieMethod(T, "SET_LOADING_MESSAGE")
                    ScaleformMovieMethodAddParamTextureNameString("Executing G4SInjection, accessing money..")
                    ScaleformMovieMethodAddParamFloat(2.0)
                    EndScaleformMovieMethod()
                    BeginScaleformMovieMethod(T, "SET_LOADING_TIME")
                    ScaleformMovieMethodAddParamInt(15)
                    EndScaleformMovieMethod()
                    BeginScaleformMovieMethod(T, "SET_LOADING_PROGRESS")
                    ScaleformMovieMethodAddParamInt(75)
                    EndScaleformMovieMethod()
                    Wait(1500)
                    BeginScaleformMovieMethod(T, "OPEN_LOADING_PROGRESS")
                    ScaleformMovieMethodAddParamBool(false)
                    EndScaleformMovieMethod()
                    BeginScaleformMovieMethod(T, "OPEN_ERROR_POPUP")
                    ScaleformMovieMethodAddParamBool(true)
                    ScaleformMovieMethodAddParamTextureNameString("MET POLICE AWARE - DEVICE SHUTTING DOWN")
                    EndScaleformMovieMethod()
                    Wait(3500)
                    SetScaleformMovieAsNoLongerNeeded(T)
                    EndScaleformMovieMethod()
                    imageNotification("notification_images","g4slogo","We have notified the Metropolitan Police service. You are on CCTV.","G4S Security","Police Notified")
                    TriggerServerEvent("ARMA:updateHackingOutcome", A.netId, A.src, W, true)
                    DeleteObject(x)
                    break
                elseif ProgramID == 6 then
                    Wait(500)
                    SetScaleformMovieAsNoLongerNeeded(T)
                    DisableControlAction(0, 24, false)
                    DisableControlAction(0, 25, false)
                end
                if V == 0 then
                    PlaySoundFrontend(-1, "HACKING_FAILURE", "", true)
                    BeginScaleformMovieMethod(T, "SET_ROULETTE_OUTCOME")
                    ScaleformMovieMethodAddParamBool(false)
                    ScaleformMovieMethodAddParamTextureNameString("G4SINJECT - HACK FAILED!")
                    EndScaleformMovieMethod()
                    Wait(3500)
                    BeginScaleformMovieMethod(T, "CLOSE_APP")
                    EndScaleformMovieMethod()
                    BeginScaleformMovieMethod(T, "OPEN_ERROR_POPUP")
                    ScaleformMovieMethodAddParamBool(true)
                    ScaleformMovieMethodAddParamTextureNameString("POLICE AWARE OF HACK ATTEMPT, DEVICE SHUTTING DOWN")
                    EndScaleformMovieMethod()
                    Wait(2500)
                    SetScaleformMovieAsNoLongerNeeded(T)
                    EndScaleformMovieMethod()
                    DisableControlAction(0, 24, false)
                    DisableControlAction(0, 25, false)
                    displayNotification("Hacking Unsuccessful")
                    imageNotification("notification_images","g4slogo","Please note: The police have been notified.","G4S Security","Police Notified")
                    TriggerServerEvent("ARMA:updateHackingOutcome", A.netId, A.src, W, false)
                    DeleteObject(x)
                    break
                end
            end
        end
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('g4s', 'main')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            if not j then
                if tARMA.getPlayerVehicle() == 0 and y < 4 then
                    RageUI.ButtonWithStyle("New Vehicle","Get a new vehicle",{RightLabel = "→→→"},true,function(a0, a1, a2)
                        if a2 then
                            newG4sVehicle()
                        end
                    end)
                end
                RageUI.ButtonWithStyle("End Shift","End your shift",{RightLabel = "→→→"},true,function(a0, a1, a2)
                    if a2 then
                        TriggerServerEvent("ARMA:toggleShiftG4S", false)
                        a = false
                    end
                end)
                RageUI.ButtonWithStyle("Forgot Pin","Get a pin reminder",{RightLabel = "→→→"},true,function(a0, a1, a2)
                    if a2 then
                        imageNotification("CHAR_MP_MEX_DOCKS","CHAR_MP_MEX_DOCKS","Hey mate, I've got you. Your pin is " .. g .. ".","Arthur","07925065325")
                    end
                end)
                if not h then
                    RageUI.ButtonWithStyle("Activate Panic","Activate your panic alarm",{RightLabel = "→→→"},true,function(a0, a1, a2)
                        if a2 then
                            TriggerServerEvent("ARMA:activatePanicServer", c)
                            imageNotification("notification_images","g4slogo","You have activated your panic alarm.","G4S Security","Panic Activated")
                            h = true
                        end
                    end)
                end
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('g4s', 'shiftHandler')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            if not a then
                RageUI.ButtonWithStyle("Start Shift","Start your shift working for G4S.",{RightLabel = "G4S"},true,function(a0, a1, a2)
                    if a2 then
                        RageUI.Visible(RMenu:Get("g4s", "shiftHandler"), false)
                        TriggerServerEvent("ARMA:toggleShiftG4S", true)
                    end
                end)
            else
                RageUI.ButtonWithStyle("End Shift","End your shift working for G4S",{RightLabel = "G4S"},true,function(a0, a1, a2)
                    if a2 then
                        RageUI.Visible(RMenu:Get("g4s", "shiftHandler"), false)
                        TriggerServerEvent("ARMA:toggleShiftG4S", false)
                        a = false
                    end
                end)
            end
        end)
    end
end)
function newG4sVehicle()
    local E = tARMA.getPlayerPed()
    if DoesEntityExist(b) and not IsVehicleDriveable(b, true) then
        DeleteEntity(b)
        local a3 = GetOffsetFromEntityInWorldCoords(E, 0.0, 5.0, 0.0)
        b = tARMA.spawnVehicle(n, a3.x, a3.y, a3.z, GetEntityHeading(E), true, true)
        c = VehToNet(b)
        TriggerServerEvent("ARMA:updateCurrentVehicle", c)
        y = y + 1
    end
end
function securityCheck(E)
    local a4 = tARMA.getPlayerVehicle()
    if a4 ~= 0 and a4 ~= nil and b ~= nil and b ~= 0 then
        if a4 ~= b then
            r = true
            imageNotification("notification_images","g4slogo","Please ensure you are in your G4S vehicle.","G4S Security","Human Resources")
            SetTimeout(15000,function()
                a4 = GetVehiclePedIsIn(tARMA.getPlayerPed(), false)
                if a4 ~= 0 then
                    if a4 ~= b then
                        TriggerServerEvent("ARMA:toggleShiftG4S", false)
                        tARMA.removeBlip(k)
                        tARMA.removeBlip(l)
                        ClearGpsPlayerWaypoint()
                    end
                end
                r = false
            end)
        end
    end
end
RegisterNetEvent("ARMA:resetPanicStatus",function()
    h = false
end)
RegisterNetEvent("ARMA:updateJobInformation",function(a5)
    if l ~= 0 then
        tARMA.removeBlip(l)
    end
    if a5.jobActive then
        if not a5.collected then
            if k ~= 0 then
                tARMA.removeBlip(k)
            end
            k = tARMA.addBlip(a5.collectionCoords.x,a5.collectionCoords.y,a5.collectionCoords.z,500,18,"G4S Collection",1.0,false)
            SetBlipRoute(k, true)
            SetBlipRouteColour(k, 18)
        elseif not a5.deposited then
            tARMA.removeBlip(k)
            l = tARMA.addBlip(a5.depositCoords.x,a5.depositCoords.y,a5.depositCoords.z,500,47,"G4S Deposit",1.0,false)
            SetBlipRoute(l, true)
            SetBlipRouteColour(l, 47)
        end
        m = a5
        PlaySoundFrontend(-1, "Out_Of_Bounds_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 1)
    else
        displayNotification("~b~New job received:~w~\nCollection: " .. a5.collectionName .. "\nDestination: " .. a5.depositName)
        Wait(3000)
        TriggerServerEvent("ARMA:acceptJob")
    end
end)
function createInstuctionButtons()
    local T = RequestScaleformMovie("instructional_buttons")
    while not HasScaleformMovieLoaded(T) do
        Citizen.Wait(10)
    end
    BeginScaleformMovieMethod(T, "CLEAR_ALL")
    EndScaleformMovieMethod()
    BeginScaleformMovieMethod(T, "SET_CLEAR_SPACE")
    ScaleformMovieMethodAddParamInt(200)
    EndScaleformMovieMethod()
    BeginScaleformMovieMethod(T, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(0)
    ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(1, 191, true))
    InstructionButtonMessage("Accept Job")
    EndScaleformMovieMethod()
    BeginScaleformMovieMethod(T, "DRAW_INSTRUCTIONAL_BUTTONS")
    EndScaleformMovieMethod()
    BeginScaleformMovieMethod(T, "SET_BACKGROUND_COLOUR")
    ScaleformMovieMethodAddParamInt(0)
    ScaleformMovieMethodAddParamInt(0)
    ScaleformMovieMethodAddParamInt(0)
    ScaleformMovieMethodAddParamInt(80)
    EndScaleformMovieMethod()
    return T
end
RegisterNetEvent("ARMA:startShiftG4S",function(a6)
    local E = tARMA.getPlayerPed()
    local L = tARMA.getPlayerCoords()
    a = true
    tARMA.disableCustomizationSave(a)
    b = tARMA.spawnVehicle(n, B.x, B.y, B.z, B.heading, true, true)
    c = VehToNet(b)
    TaskWarpPedIntoVehicle(E, b, -1)
    g = a6
    local a7 = {"Marcus", "Arthur", "Rob", "Thomas", "Despawned"}
    local a8 = math.random(1, 5)
    local a9 = a7[a8]
    imageNotification("CHAR_MP_MEX_DOCKS","CHAR_MP_MEX_DOCKS","Hey, I'm " .. a9 .. " , another agent for G4S. I'll be here giving you some tips along the way.",a9,"07925065325")
    TriggerServerEvent("ARMA:updateCurrentVehicle", c)
    local aa = false
    local ab = false
    local ac = GetEntityModel(E)
    if ac == "mp_m_freemode_01" then
        aa = true
    elseif ac == "mp_f_freemode_01" then
        ab = true
    else
        aa = true
        tARMA.setCustomization({modelhash = "mp_m_freemode_01"})
    end
    z = json.encode(tARMA.getCustomization())
    if aa then
        tARMA.loadCustomisationPreset("G4SMale")
    else
        tARMA.loadCustomisationPreset("G4SFemale")
    end
    Wait(2000)
    TaskVehicleDriveToCoord(tARMA.getPlayerPed(),b,-672.356,282.3297,81.43005,convert(250.0),1,GetHashKey(GetEntityModel(b)),60,5,true)
    Wait(5000)
    TaskVehicleTempAction(tARMA.getPlayerPed(), b, 27, 10.0)
    Wait(2000)
    imageNotification("CHAR_MP_MEX_DOCKS", "CHAR_MP_MEX_DOCKS", "Use /g4s to access the G4S menu.", a9, "G4S")
end)
RegisterNetEvent("ARMA:endShiftG4S",function()
    if DoesEntityExist(b) then
        DeleteEntity(b)
    end
    m.jobActive = false
    a = false
    tARMA.disableCustomizationSave(a)
    if j then
        D()
    end
    local E = tARMA.getPlayerPed()
    tARMA.setCustomization(json.decode(z))
    if C.active then
        toggleCashbox()
    end
    if k ~= 0 then
        tARMA.removeBlip(k)
    end
    if l ~= 0 then
        tARMA.removeBlip(l)
    end
    ClearGpsPlayerWaypoint()
end)
RegisterNetEvent("ARMA:requestMoneyInVehicle",function()
    local ad = math.random(1, 4)
    if ad == 1 then
        imageNotification("notification_images", "g4slogo", "Use /g4s to access your G4S Menu.", "G4S Security", "Alert")
    end
    t = true
    local ae = tARMA.getPlayerPed()
    if IsPedInAnyVehicle(ae, true) then
        while IsPedInAnyVehicle(ae, true) do
            Wait(400)
        end
    end
    SetVehicleDoorOpen(b, 3, false, false)
    SetVehicleDoorOpen(b, 4, false, false)
    local af = false
    local ag = GetOffsetFromEntityInWorldCoords(b, 0.0, -5.0, 0.0)
    while not f do
        DrawMarker(29,ag.x,ag.y,ag.z + 0.5,0.0,0.0,0.0,0.0,180.0,0.0,1.5,1.5,1.5,255,36,36,50,true,false,2,nil,nil,false)
        local R = #(tARMA.getPlayerCoords() - ag)
        if R <= 1.0 then
            af = true
            local ah = requestSafeCode()
            af = false
            if ah then
                f = true
            end
            while af do
                Wait(100)
            end
        end
        Wait(0)
    end
    SetVehicleDoorShut(b, 3, false)
    SetVehicleDoorShut(b, 4, false)
    m.collecting = false
    if C.active then
        toggleCashbox()
    end
    TriggerServerEvent("ARMA:updateMoneyInVehicle")
    t = false
end)

RegisterNetEvent("ARMA:requestMoneyOutVehicle",function()
    local ae = tARMA.getPlayerPed()
    while IsPedInAnyVehicle(ae, true) do
        Wait(400)
    end
    SetVehicleDoorOpen(b, 3, false, false)
    SetVehicleDoorOpen(b, 4, false, false)
    m.depositing = true
    local af = false
    local ag = GetOffsetFromEntityInWorldCoords(b, 0.0, -5.0, 0.0)
    while f do
        DrawMarker(29,ag.x,ag.y,ag.z + 0.5,0.0,0.0,0.0,0.0,180.0,0.0,1.5,1.5,1.5,255,36,36,50,true,false,2,nil,nil,false)
        local R = #(tARMA.getPlayerCoords() - ag)
        if R <= 1.0 then
            af = true
            local ah = requestSafeCode()
            af = false
            if ah then
                f = false
            end
            while af do
                Wait(100)
            end
        end
        Wait(0)
    end
    SetVehicleDoorShut(b, 3, false)
    SetVehicleDoorShut(b, 4, false)
    if C.active then
        toggleCashbox()
    end
    y = 1
    TriggerServerEvent("ARMA:updateMoneyOutVehicle")
end)

function enterPinScaleform()
    u = true
    SetScaleformMovieAsNoLongerNeeded()
    local T = RequestScaleformMovie("ATM")
    while not HasScaleformMovieLoaded(T) do
        Citizen.Wait(0)
    end
    BeginScaleformMovieMethod(T, "enterPINanim")
    EndScaleformMovieMethod()
    local ai = true
    SetTimeout(3000,function()
        ai = false
    end)
    while ai do
        DrawScaleformMovie(T, 0.5, 0.5, 0.8, 0.8, 255, 255, 255, 0, 0)
        Citizen.Wait(0)
    end
    SetScaleformMovieAsNoLongerNeeded(T)
    EndScaleformMovieMethod()
    u = false
end
function requestSafeCode()
    FreezeEntityPosition(tARMA.getPlayerPed(), true)
    imageNotification("notification_images","g4slogo","You are required to enter your pin key to access the safe.","G4S Security","Pin Requested")
    AddTextEntry("FMMC_KEY_TIP1", "Enter the safe code:")
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", "", "", "", "", 10)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        RageUI.Text({message = "Your pin is ~b~" .. g})
        Wait(500)
    end
    if UpdateOnscreenKeyboard() ~= 2 then
        local aj = GetOnscreenKeyboardResult()
        enterPinScaleform()
        if tostring(aj) == tostring(g) then
            imageNotification("notification_images","g4slogo","The safe pin has been entered correctly.","G4S Security","Authorised")
            FreezeEntityPosition(tARMA.getPlayerPed(), false)
            return true
        else
            PlaySoundFrontend(-1, "Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", 1)
            Wait(2000)
            FreezeEntityPosition(tARMA.getPlayerPed(), false)
            return false
        end
    end
    FreezeEntityPosition(tARMA.getPlayerPed(), false)
end
function displayJob()
    SetTextFont(4)
    SetTextScale(0.7, 0.7)
    SetTextColour(0, 121, 235, 255)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName("G4S")
    EndTextCommandDisplayText(0.011, 0.43)
    DrawRect(0.0, 0.51, 0.35, 0.17, 0, 0, 0, 150)
    displayJobDetails()
end
function displayJobDetails()
    SetTextFont(4)
    SetTextScale(0.5, 0.5)
    SetTextColour(255, 255, 255, 255)
    SetTextDropshadow(0, 0, 0, 0, 255)
    BeginTextCommandDisplayText("STRING")
    if m.jobActive then
        AddTextComponentSubstringPlayerName("Current Job: " .. m.collectionName.." - "..g)
    else
        AddTextComponentSubstringPlayerName("Pending")
    end
    EndTextCommandDisplayText(0.011, 0.47)
    displayDestination()
end
function displayDestination()
    if m.jobActive then
        SetTextFont(4)
        SetTextScale(0.5, 0.5)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        BeginTextCommandDisplayText("STRING")
        AddTextComponentSubstringPlayerName("Destination: " .. m.depositName)
        EndTextCommandDisplayText(0.011, 0.51)
        displayStatistics()
    end
end
function displayStatistics()
    SetTextFont(6)
    SetTextScale(0.5, 0.5)
    SetTextColour(255, 255, 255, 255)
    SetTextDropshadow(0, 0, 0, 0, 255)
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName("Job Number: " .. m.totalJobs)
    EndTextCommandDisplayText(0.011, 0.55)
    DrawRect(0.175, 0.51, 0.005, 0.17, 0, 121, 235, 255)
end
function displayNotification(ak)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(ak)
    EndTextCommandThefeedPostTicker(false, false)
end
function imageNotification(al, am, an, ao, ap)
    if al == "notification_images" and not HasStreamedTextureDictLoaded("notification_images") then
        RequestStreamedTextureDict("notification_images", true)
        while not HasStreamedTextureDictLoaded("notification_images") do
            Wait(0)
        end
    end
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(an)
    local ao = ao
    local ap = ap
    local aq = 0
    local ar = false
    EndTextCommandThefeedPostMessagetext(al, am, ar, aq, ao, ap)
    local as = true
    local at = false
    EndTextCommandThefeedPostTicker(at, as)
    PlaySoundFrontend(-1, "CHECKPOINT_NORMAL", "HUD_MINI_GAME_SOUNDSET", 1)
end
function helpNotification(ak)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(ak)
    EndTextCommandDisplayHelp(0, 0, 1, -1)
end
RegisterNetEvent("ARMA:openG4SMenu",function()
    RageUI.Visible(RMenu:Get("g4s", "main"), true)
end)
RegisterNetEvent("ARMA:imageNotification",function(al, am, an, ao, ap)
    imageNotification(al, am, an, ao, ap)
end)
function InstructionButton(au)
    ScaleformMovieMethodAddParamPlayerNameString(au)
end
function InstructionButtonMessage(ak)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentSubstringKeyboardDisplay(ak)
    EndTextCommandScaleformString()
end
RegisterNetEvent("ARMA:bottomMessage",function(ak, av)
    bottomMessage(ak, av)
end)
function bottomMessage(ak, av)
    local aw = 0
    while aw < av do
        RageUI.Text({message = ak})
        Wait(0)
    end
end
local function ax()
    local ay = GetGameTimer()
    while not RequestScriptAudioBank("DLC_SECURITY\\SIREN_ONE", false) do
        if GetGameTimer() - ay > 1500 then
            print("Failed to load DLC_SECURITY audio bank")
            ReleaseNamedScriptAudioBank("DLC_SECURITY\\SIREN_ONE")
            return
        end
        Citizen.Wait(0)
    end
end
RegisterNetEvent("ARMA:activatePanicAll",function(az, aA)
    if az ~= 0 and NetworkDoesNetworkIdExist(az) then
        local aB = GetSoundId()
        local aC = NetToVeh(az)
        if DoesEntityExist(aC) then
            ax()
            PlaySoundFromEntity(aB, "siren_one", aC, "dlc_security_soundset", 0, 0)
            RequestNamedPtfxAsset("core")
            while not HasNamedPtfxAssetLoaded("core") do
                RequestNamedPtfxAsset("core")
                Wait(0)
            end
            if A.netId == az then
                A.hackingEngaged = false
                A.netId = 0
                A.entity = 0
                V = 0
                FreezeEntityPosition(tARMA.getPlayerPed(), false)
                imageNotification("notification_images","g4slogo","The alarm has been manually activated.","G4S Security","Alarm Activated")
            end
            UseParticleFxAsset("core")
            local aD = StartParticleFxLoopedOnEntity("exp_grd_grenade_smoke",NetToVeh(az),0.0,0.0,0.0,0.0,0.0,0.0,1.0,true,true,true)
            RemoveNamedPtfxAsset("core")
            Citizen.CreateThread(
                function()
                    Wait(100000)
                    StopSound(aB)
                    ReleaseSoundId(aB)
                    StopParticleFxLooped(aD, true)
                end
            )
            ReleaseNamedScriptAudioBank("DLC_SECURITY\\SIREN_ONE")
        end
    end
end)

RegisterNetEvent("ARMA:activeVansUpdate",function(az, Q, aE)
    if not a then
        local b = tARMA.getObjectId(az, "ARMA:activeVansUpdate 1")
        if b ~= 0 and b ~= nil and DoesEntityExist(b) then
            if aE then
                s[az] = nil
            else
                if not table.has(s, az) then
                    local b = tARMA.getObjectId(az, "ARMA:activeVansUpdate")
                    s[az] = {Q, b, az}
                end
            end
        end
    end
end)

RegisterNetEvent("ARMA:terminateHacking",function()
    PlaySoundFrontend(-1, "FocusIn", "HintCamSounds", true)
    A.hackingEngaged = false
    A.netId = 0
    A.entity = 0
    V = 0
    FreezeEntityPosition(tARMA.getPlayerPed(), false)
end)
