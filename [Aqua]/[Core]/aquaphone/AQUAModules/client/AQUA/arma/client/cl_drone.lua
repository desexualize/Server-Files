local a = "frogger"
local b = 190.0
TriggerEvent("chat:addSuggestion", "/drone", "Create or delete a remote controlled drone")
local c = {
    active = false,
    vehicleHandle = 0,
    driverHandle = 0,
    cameraEnabled = false,
    cameraHandle = 0,
    nightVisionEnabled = false,
    thermalEnabled = false,
    landing = false,
    tablet = 0
}
function tARMA.isPlayerInDrone()
    return c.active
end
local function d()
    local e = tARMA.getPlayerPed()
    if c.cameraEnabled then
        if DoesEntityExist(c.tablet) then
            DeleteEntity(c.tablet)
            ClearPedTasks(e)
        end
        local f = 500 * math.ceil(#(tARMA.getPlayerCoords() - GetEntityCoords(c.vehicleHandle)) / 10)
        RenderScriptCams(0, 0, f, 1, 0)
        ClearTimecycleModifier()
        if DoesCamExist(c.cameraHandle) then
            DestroyCam(c.cameraHandle)
        end
        c.cameraEnabled = false
        if c.nightVisionEnabled then
            SetNightvision(false)
            c.nightVisionEnabled = false
        end
        if c.thermalEnabled then
            SetSeethrough(false)
            c.thermalEnabled = false
        end
        FreezeEntityPosition(e, false)
    else
        local g = tARMA.loadModel("prop_cs_tablet")
        c.tablet = CreateObject(g, tARMA.getPlayerCoords(), true)
        SetModelAsNoLongerNeeded(g)
        AttachEntityToEntity(c.tablet,e,GetPedBoneIndex(e, 28422),-0.03,0.0,0.0,0.0,0.0,0.0,true,true,false,true,1,true)
        tARMA.loadAnimDict("amb@code_human_in_bus_passenger_idles@female@tablet@idle_a")
        TaskPlayAnim(e,"amb@code_human_in_bus_passenger_idles@female@tablet@idle_a","idle_a",3.0,-8,-1,63,0,0,0,0)
        c.cameraEnabled = true
        c.cameraHandle = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
        local h = {}
        h.x = 0.0
        h.z = 0.0
        AttachCamToEntity(c.cameraHandle, c.vehicleHandle, 0.0, 0.1, -0.1, true)
        Citizen.CreateThread(function()
            while DoesCamExist(c.cameraHandle) do
                local i = GetEntityRotation(c.vehicleHandle, 2)
                DisableControlAction(0, 32)
                DisableControlAction(0, 33)
                DisableControlAction(0, 34)
                DisableControlAction(0, 35)
                DisableControlAction(0, 157, true)
                DisableControlAction(0, 158, true)
                if IsDisabledControlPressed(0, 32) then
                    h.x = h.x + 1.0
                end
                if IsDisabledControlPressed(0, 33) then
                    h.x = h.x - 1.0
                end
                if IsDisabledControlPressed(0, 34) then
                    h.z = h.z + 1.0
                end
                if IsDisabledControlPressed(0, 35) then
                    h.z = h.z - 1.0
                end
                SetCamRot(c.cameraHandle, i.x + h.x, i.y, i.z + h.z, 2)
                if not IsEntityPlayingAnim(e,"amb@code_human_in_bus_passenger_idles@female@tablet@idle_a","idle_a",3) then
                    TaskPlayAnim(e,"amb@code_human_in_bus_passenger_idles@female@tablet@idle_a","idle_a",3.0,-8,-1,63,0,0,0,0)
                end
                Citizen.Wait(0)
            end
            RemoveAnimDict("amb@code_human_in_bus_passenger_idles@female@tablet@idle_a")
            ClearPedTasks(e)
        end)
        local f = 500 * math.ceil(#(tARMA.getPlayerCoords() - GetEntityCoords(c.vehicleHandle)) / 10)
        RenderScriptCams(1, 1, f, 1, 1)
        Wait(f)
        FreezeEntityPosition(e, true)
        SetTimecycleModifier("scanline_cam_cheap")
        SetTimecycleModifierStrength(0.7)
    end
end
RegisterNetEvent("toggleDrone",function()
    if not c.active then
        if tARMA.getPlayerVehicle() == 0 and not tARMA.isInComa() then
            TriggerServerEvent("ARMA:performDroneLog", "Powered on their DJI Inspire Drone")
            newDrone()
        else
            tARMA.notify("You are not able to use a drone right now.")
        end
    else
        TriggerServerEvent("ARMA:performDroneLog", "Powered off their DJI Inspire Drone")
        deleteDrone()
    end
end)
Citizen.CreateThread(function()
    form = setupScaleform("instructional_buttons")
    while true do
        if c.active then
            DrawScaleformMovieFullscreen(form, 255, 255, 255, 255, 0)
            if not NetworkHasControlOfEntity(c.driverHandle) or not NetworkHasControlOfEntity(c.vehicleHandle) then
                tARMA.notify("You have ~b~lost control ~w~of the drone, after going out of range")
                deleteDrone()
            end
            DisableControlAction(0, 172, true)
            DisableControlAction(1, 172, true)
            DisableControlAction(0, 300, true)
            DisableControlAction(0, 27, true)
            DisableControlAction(1, 27, true)
            DisableControlAction(0, 188, true)
            DisableControlAction(1, 188, true)
            DisableControlAction(0, 191, true)
            DisableControlAction(0, 208, true)
            DisableControlAction(0, 207, true)
            DisableControlAction(0, 174, true)
            DisableControlAction(0, 175, true)
            DisableControlAction(0, 173, true)
            DisableControlAction(0, 121, true)
            local j = false
            local k = GetEntityHeading(c.vehicleHandle)
            local l = GetEntityCoords(c.vehicleHandle)
            local m = 0
            if IsDisabledControlPressed(0, 44) then
                c.landing = false
                m = 3.0
                j = true
            end
            if IsDisabledControlPressed(0, 48) then
                m = -3.0
                j = true
            end
            if IsDisabledControlPressed(0, 46) then
                m = -3.0
                j = true
            end
            if IsDisabledControlPressed(0, 172) then
                local n = GetOffsetFromEntityInWorldCoords(c.vehicleHandle, 0.0, 5.0, 0.0)
                l = n
                j = true
            end
            if IsDisabledControlPressed(0, 173) then
                local n = GetOffsetFromEntityInWorldCoords(c.vehicleHandle, 0.0, -5.0, 0.0)
                l = n
                j = true
            end
            if IsDisabledControlPressed(0, 174) then
                k = k + 45.0
                j = true
            end
            if IsDisabledControlPressed(0, 175) then
                k = k - 45.0
                if k < 0.0 then
                    k = 360.0
                end
                j = true
            end
            if not c.landing then
                TaskHeliMission(c.driverHandle,c.vehicleHandle,nil,nil,l.x,l.y,l.z + m,4,b,1.0,k,-1,-1,-1,0)
            end
            if IsDisabledControlJustPressed(0, 121) then
                c.landing = true
                local l = GetOffsetFromEntityInWorldCoords(c.driverHandle, 0.0, 3.0, 0.0)
                TaskHeliMission(c.driverHandle,c.vehicleHandle,0,0,l.x,l.y,l.z + 2.0,20,b,10.0,GetEntityHeading(c.driverHandle),-1,-1,-1,32)
                j = true
            end
            if IsDisabledControlJustPressed(0, 158) then
                if c.cameraEnabled then
                    if c.nightVisionEnabled then
                        SetNightvision(false)
                        c.nightVisionEnabled = false
                    else
                        SetNightvision(true)
                        c.nightVisionEnabled = true
                    end
                end
            end
            if IsDisabledControlJustPressed(0, 157) then
                if c.cameraEnabled then
                    if c.thermalEnabled then
                        SetSeethrough(false)
                        c.thermalEnabled = false
                    else
                        SetSeethrough(true)
                        c.thermalEnabled = true
                    end
                end
            end
            if IsDisabledControlJustPressed(0, 191) then
                d()
            end
            j = false
        end
        Wait(0)
    end
end)

local o = 0
Citizen.CreateThread(function()
    while true do
        local p = tARMA.getPlayerVehicle()
        if p ~= 0 then
            local q = GetEntityModel(p)
            if q == GetHashKey(a) then
                o = o + 1
                if o > 3 then
                    tARMA.notify("~r~Access Denied~w~: Engaging defences in 3, 2, 1...")
                    Wait(500)
                    local r = tARMA.getPlayerCoords()
                    AddOwnedExplosion(tARMA.getPlayerPed(), r.x, r.y, r.z, 4, 17.0, true, false, 10.0)
                    ExplodeVehicle(p, true, false)
                    PlaySoundFrontend(-1, "EMP_Blast", "DLC_HEISTS_BIOLAB_FINALE_SOUNDS", 1)
                    Wait(2000)
                    PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
                    Wait(2000)
                    PlaySoundFrontend(-1, "Bed", "WastedSounds", 1)
                    if tARMA.getPlayerVehicle() ~= nil and DoesEntityExist(tARMA.getPlayerVehicle()) then
                        DeleteEntity(tARMA.getPlayerVehicle())
                    end
                end
            end
        end
        Wait(5000)
    end
end)
function ButtonMessage(s)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentSubstringKeyboardDisplay(s)
    EndTextCommandScaleformString()
end
function Button(t)
    ScaleformMovieMethodAddParamPlayerNameString(t)
end
function setupScaleform(u)
    local u = RequestScaleformMovie(u)
    while not HasScaleformMovieLoaded(u) do
        Citizen.Wait(0)
    end
    BeginScaleformMovieMethod(u, "CLEAR_ALL")
    EndScaleformMovieMethod()
    BeginScaleformMovieMethod(u, "SET_CLEAR_SPACE")
    ScaleformMovieMethodAddParamInt(200)
    EndScaleformMovieMethod()
    BeginScaleformMovieMethod(u, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(0)
    Button(GetControlInstructionalButton(0, 44, true))
    ButtonMessage("Up")
    EndScaleformMovieMethod()
    BeginScaleformMovieMethod(u, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(1)
    Button(GetControlInstructionalButton(0, 175, true))
    ButtonMessage("Turn Right")
    EndScaleformMovieMethod()
    BeginScaleformMovieMethod(u, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(2)
    Button(GetControlInstructionalButton(0, 174, true))
    ButtonMessage("Turn Left")
    EndScaleformMovieMethod()
    BeginScaleformMovieMethod(u, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(3)
    Button(GetControlInstructionalButton(0, 173, true))
    ButtonMessage("Backward")
    EndScaleformMovieMethod()
    BeginScaleformMovieMethod(u, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(4)
    Button(GetControlInstructionalButton(0, 172, true))
    ButtonMessage("Forward")
    EndScaleformMovieMethod()
    BeginScaleformMovieMethod(u, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(5)
    Button(GetControlInstructionalButton(0, 191, true))
    ButtonMessage("Camera Stream")
    EndScaleformMovieMethod()
    BeginScaleformMovieMethod(u, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(6)
    Button(GetControlInstructionalButton(0, 158, true))
    ButtonMessage("Night Vision")
    EndScaleformMovieMethod()
    BeginScaleformMovieMethod(u, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(7)
    Button(GetControlInstructionalButton(0, 157, true))
    ButtonMessage("Thermal Imaging")
    EndScaleformMovieMethod()
    BeginScaleformMovieMethod(u, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(8)
    Button(GetControlInstructionalButton(0, 121, true))
    ButtonMessage("Land")
    EndScaleformMovieMethod()
    BeginScaleformMovieMethod(u, "DRAW_INSTRUCTIONAL_BUTTONS")
    EndScaleformMovieMethod()
    BeginScaleformMovieMethod(u, "SET_BACKGROUND_COLOUR")
    ScaleformMovieMethodAddParamInt(0)
    ScaleformMovieMethodAddParamInt(0)
    ScaleformMovieMethodAddParamInt(0)
    ScaleformMovieMethodAddParamInt(80)
    EndScaleformMovieMethod()
    return u
end
function newDrone()
    local g = tARMA.loadModel(a)
    local v = tARMA.loadModel("s_m_m_bouncer_01")
    local e = tARMA.getPlayerPed()
    local r = GetOffsetFromEntityInWorldCoords(e, 0.0, 4.0, 0.0)
    local w = GetEntityHeading(e)
    c.vehicleHandle = tARMA.spawnVehicle(a, r, w, true)
    SetModelAsNoLongerNeeded(g)
    SetEntityNoCollisionEntity(tARMA.getPlayerPed(), c.vehicleHandle, 1)
    Wait(1000)
    SetEntityAsMissionEntity(c.vehicleHandle, true, true)
    local x = NetworkGetNetworkIdFromEntity(c.vehicleHandle)
    NetworkSetNetworkIdDynamic(x, true)
    SetNetworkIdCanMigrate(x, true)
    SetNetworkIdExistsOnAllMachines(x, true)
    c.driverHandle = CreatePed(4, v, r, w, true)
    while not DoesEntityExist(c.driverHandle) do
        Wait(0)
    end
    SetModelAsNoLongerNeeded(v)
    SetEntityInvincible(c.driverHandle, true)
    SetEntityVisible(c.driverHandle, false)
    FreezeEntityPosition(c.driverHandle, true)
    SetPedAlertness(c.driverHandle, 0.0)
    TaskWarpPedIntoVehicle(c.driverHandle, c.vehicleHandle, -1)
    SetVehicleDoorsLocked(c.vehicleHandle, 2)
    while not IsPedInVehicle(c.driverHandle, c.vehicleHandle) do
        Wait(0)
    end
    c.active = true
    tARMA.notify("Drone ~b~created~w~.")
    Wait(1000)
    if globalNHSOnDuty then
        tARMA.notify("~y~Reminder~w~: These drones are reserved for usage by HEMS, Specialised Off Road Unit")
        tARMA.notify("and Senior Pilots only. If you are not in these divisions, you ~r~should not ~r~be using this.")
    end
    tARMA.notify("To remove your drone, use ~b~/drone")
end
function deleteDrone()
    Wait(500)
    c.active = false
    DeletePed(c.driverHandle)
    SetEntityAsMissionEntity(c.vehicleHandle, 0, 0)
    DeleteEntity(c.vehicleHandle)
    SetModelAsNoLongerNeeded(a)
    if c.cameraEnabled then
        d()
    end
    tARMA.notify("Drone ~b~removed~w~.")
end
local y = {["rcmavic"] = true, ["grc86gt"] = true, ["rcsultanrs"] = true, ["rc599xx"] = true}
local z = nil
local A = nil
local function B()
    local p = tARMA.getPlayerVehicle()
    if p == 0 then
        if z then
            if #(z - tARMA.getPlayerCoords()) > 20.0 then
                local C = PlayerPedId()
                SetEntityCoordsNoOffset(C, z.x, z.y, z.z, false, false, false)
                ClearPedTasksImmediately(C)
            end
            SetEntityVisible(PlayerPedId(), true, 0)
            z = nil
            RemoveBlip(A)
        end
        return
    end
    local q = GetEntityModel(p)
    local d = {}
    for k,v in pairs(y) do
        table.insert(d, GetHashKey(k))
    end
    if not d[q] then
        return
    end
    local D = GetEntityCoords(p, true)
    if not z then
        z = D
        SetEntityVisible(PlayerPedId(), false, 0)
        A = AddBlipForRadius(D.x, D.y, D.z, 20.0)
        SetBlipColour(A, 5)
    end
    if #(z - D) > 20.0 then
        DisableControlAction(0, 23, true)
        DisableControlAction(0, 75, true)
        if IsDisabledControlJustPressed(0, 23) or IsDisabledControlJustPressed(0, 75) then
            tARMA.notify("You must be near the ~y~start position~w~ to exit.")
        end
    end
end
tARMA.createThreadOnTick(B)
