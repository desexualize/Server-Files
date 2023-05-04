RMenu.Add("CARDEV", "main", RageUI.CreateMenu("", "~r~Main Menu", 1250, 100, "vehicle", "vehicle"))
RMenu.Add("CARDEV", "vehiclelist", RageUI.CreateSubMenu(RMenu:Get("CARDEV", "main"), "", "~r~Vehicle List", 1250, 100))
RMenu.Add("CARDEV","vehiclelistmain", RageUI.CreateSubMenu(RMenu:Get("CARDEV", "vehiclelist"), "", "~r~Vehicle List", 1250, 100))
RMenu.Add("CARDEV", "vehiclelistspawn", RageUI.CreateSubMenu(RMenu:Get("CARDEV", "vehiclelistmain"), "", "~r~Vehicle Spawn", 1250, 100))

local m = module("Nova-Cars", "garages")
m = m.garage_types
local garageCategorySelected
local veh
local b = false

local q = {"Speed", "Drift", "Handling", "City", "Airport"}
local location_vectors = {
    ["Speed"] = {coords = vector3(2401.1142578125, 2884.9145507812, 40.285655975342), heading = 301.74630737305},
    ["Drift"] = {coords = vector3(969.40270996094, -3004.4916992188, 5.9007596969604), heading = 91.751152038574},
    ["Handling"] = {coords = vector3(1917.2622070312, 3778.8366699219, 32.29475402832), heading = 29.049461364746},
    ["City"] = {coords = vector3(-464.72448730469, -666.30798339844, 32.338081359863), heading = 267.1462097168},
    ["Airport"] = {coords = vector3(-1690.7990722656, -2938.7416992188, 13.944454193115), heading = 235.69161987305}
}
local location_by_indexes = {
    location_vectors["Speed"],
    location_vectors["Drift"],
    location_vectors["Handling"],
    location_vectors["City"],
    location_vectors["Airport"]
}
local s = 1
local savedCoords = nil

local car_dev_active = false
local car_dev_spawned_vehicles = {}

function Car_Dev_Spawn_Vehicle_Function(model, upgrade_vehicle)
    local k = loadModel(model)

    local client_ped = PlayerPedId()
    local coords = GetEntityCoords(client_ped)

    local vehicle_being_used = GetVehiclePedIsIn(client_ped, false)
    if vehicle_being_used ~= 0 then
        DeleteVehicle(vehicle_being_used)
    end

    local nveh = spawnVehicle(k, coords.x, coords.y, coords.z, GetEntityHeading(client_ped), true, true, false)
    SetModelAsNoLongerNeeded(k)
    table.insert(car_dev_spawned_vehicles, nveh)

    SetVehicleOnGroundProperly(nveh)
    SetEntityInvincible(nveh, false)
    SetPedIntoVehicle(client_ped, nveh, -1)
    SetVehicleDirtLevel(nveh, 0)

    if upgrade_vehicle then
        applymods(nveh)
    end

    SetVehRadioStation(vehicle, "OFF")
    Wait(500)
    SetVehRadioStation(vehicle, "OFF")
    return nveh
end

function Toggle_Car_Dev_Universe(leaving_universe) -- Boolean if user is leaving car dev universe set to true if leaving else false
    local client_ped = PlayerPedId()

    DoScreenFadeOut(1000)
    NetworkFadeOutEntity(client_ped, true, false)
    Wait(1000)
    
    if leaving_universe then
        car_dev_active = false
        SetEntityCoords(client_ped, savedCoords)

        if #car_dev_spawned_vehicles > 0 then
            for i, veh in pairs(car_dev_spawned_vehicles) do
                if DoesEntityExist(veh) then
                    DeleteVehicle(veh)
                end
            end
            car_dev_spawned_vehicles = {}
        end
    else
        savedCoords = GetEntityCoords(client_ped)
        local car_dev_spawn_coords = location_vectors["Speed"]
        SetEntityCoords(client_ped, car_dev_spawn_coords.coords)
        SetEntityHeading(client_ped, car_dev_spawn_coords.heading)
        SetGameplayCamRelativeHeading(0)

        car_dev_active = true
        Cardev_Set_Invincible()
    end

    NetworkFadeInEntity(client_ped, 0)
    DoScreenFadeIn(1000)
    b = not leaving_universe -- Set to opposite leaving universe, if leaving_universe (b = false), else (b = true)
    TriggerServerEvent("Nova:setCarDev", b)
end

function Cardev_Set_Invincible()
    Citizen.CreateThread(function()
        while car_dev_active do
            local client_player = PlayerId()
            if not GetPlayerInvincible(client_player) then
                SetPlayerInvincible(client_player, car_dev_active)
            end
            Citizen.Wait(0)
        end
    end)
end

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get("CARDEV", "main")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
            if b then
                RageUI.Button("Spawn Vehicle (No mods)", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        AddTextEntry("FMMC_MPM_NC", "Enter the car spawncode name")
                        DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
                        while (UpdateOnscreenKeyboard() == 0) do
                            DisableAllControlActions(0)
                            Citizen.Wait(0)
                        end

                        if (GetOnscreenKeyboardResult()) then
                            local result = GetOnscreenKeyboardResult()
                            if result then
                                Car_Dev_Spawn_Vehicle_Function(result)
                            end
                        end
                    end
                end)

                RageUI.Button("Spawn Vehicle (Full Mods)", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        AddTextEntry("FMMC_MPM_NC", "Enter the car spawncode name")
                        DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
                        while (UpdateOnscreenKeyboard() == 0) do
                            DisableAllControlActions(0)
                            Citizen.Wait(0)
                        end

                        if (GetOnscreenKeyboardResult()) then
                            local result = GetOnscreenKeyboardResult()
                            if result then
                                local vehicle = Car_Dev_Spawn_Vehicle_Function(result, true) -- Secondary true will spawn upgraded
                            end
                        end
                    end
                end)

                RageUI.Button("Fix Vehicle", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        Fix_Current_Vehicle()
                    end
                end)

                RageUI.Button("Clean Vehicle", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        cleanveh()
                    end
                end)

                RageUI.List("Teleport to ", q, s, nil, {}, true, function(x, y, z, N)
                    s = N
                    if z then
                        local client_ped = PlayerPedId()
                        local current_ped_vehicle = GetVehiclePedIsIn(client_ped, false)
                        if current_ped_vehicle ~= 0 then
                            client_ped = current_ped_vehicle
                        end

                        local pos_information = location_by_indexes[s]
                        SetEntityCoords(client_ped, pos_information.coords, true, false, false, false)
                        SetEntityHeading(client_ped, pos_information.heading)
                        SetGameplayCamRelativeHeading(0)
                    end
                end)

                RageUI.Button("Cycle through seats", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local client_ped = PlayerPedId()
                        local current_vehicle = GetVehiclePedIsIn(client_ped, false)
                        if current_vehicle ~= 0 then
                            local t = GetVehicleModelNumberOfSeats(GetEntityModel(current_vehicle))
                            for u = -1, t - 2 do
                                if IsVehicleSeatFree(current_vehicle, u) then
                                    TaskWarpPedIntoVehicle(p, current_vehicle, u)
                                    Wait(2000)
                                end
                            end
                        else
                            tvRP.notify("~r~Not in a vehicle.")
                        end
                    end
                end)

                RageUI.Button("Take Car Screenshot", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TakeVehScreenshot()
                    end
                end)

                RageUI.Button("Vehicle List", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                end, RMenu:Get("CARDEV", "vehiclelist"))

                RageUI.Checkbox("Return to normal Universe", "~r~Leave Car Dev Mode", b, {}, function(Hovered, Active, Selected, Checked)
                    if Selected then
                        Toggle_Car_Dev_Universe(true) -- -- True, because universe is being left
                    end
                end, RageUI.Visible(RMenu:Get('cardev', 'main'), false))
            else
                RageUI.Checkbox("Teleport to Car Dev Universe", "~g~Enter Car Dev Mode", b, {}, function(Hovered, Active, Selected, Checked)
                    if Selected then
                        Toggle_Car_Dev_Universe(false) -- False, because universe is being entered
                    end
                end, RageUI.Visible(RMenu:Get('cardev', 'main'), false))
                RageUI.Separator("~g~Enter Car Dev Mode to see more options")
            end
        end)

    elseif RageUI.Visible(RMenu:Get("CARDEV", "vehiclelist")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
            if b then
                for k, v in pairs(m) do
                    RageUI.Button(k, nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            garageCategorySelected = k
                        end
                    end, RMenu:Get("CARDEV", "vehiclelistmain"))
                end
            end
        end)

    elseif RageUI.Visible(RMenu:Get("CARDEV", "vehiclelistmain")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
            if b then
                for k, v in pairs(m) do
                    if k == garageCategorySelected then
                        for a, l in pairs(v) do
                            if a ~= "_config" then
                                if IsModelInCdimage(a) or IsModelValid(a) then
                                    RageUI.Button(a, "" .. l[1] .. "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                                        if Selected then
                                            veh = a
                                        end
                                    end, RMenu:Get("CARDEV", "vehiclelistspawn"))
                                end
                            end
                        end
                    end
                end
            end
        end)

    elseif RageUI.Visible(RMenu:Get("CARDEV", "vehiclelistspawn")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
            if b then
                RageUI.Button("Spawn Vehicle (No mods)", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        Car_Dev_Spawn_Vehicle_Function(veh)
                    end
                end)

                RageUI.Button("Spawn Vehicle (Full Mods)", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local vehicle = Car_Dev_Spawn_Vehicle_Function(veh, true) -- Secondary true will spawn upgraded
                    end
                end)
            end
        end)
    end
end)

RegisterCommand("cardev", function()
    TriggerServerEvent("Nova:openCarDev")
end)

RegisterNetEvent("Nova:CarDevMenu")
AddEventHandler("Nova:CarDevMenu", function()
    RageUI.Visible(RMenu:Get("CARDEV", "main"), not RageUI.Visible(RMenu:Get("CARDEV", "main")))
end)

function Fix_Current_Vehicle()
    local client_ped = PlayerPedId()
    local current_vehicle = GetVehiclePedIsIn(client_ped, false)

    if current_vehicle ~= 0 then
        local previous_velocity = GetEntityVelocity(current_vehicle)
        SetVehicleFixed(current_vehicle)
        SetEntityVelocity(current_vehicle, previous_velocity)
        
        SetVehicleBodyHealth(current_vehicle, 1000.0)
        SetVehicleEngineHealth(current_vehicle, 1000.0)
        SetVehiclePetrolTankHealth(current_vehicle, 1000.0)
        SetVehicleDirtLevel(current_vehicle, 0)
        
        for i = 0, GetVehicleNumberOfWheels(current_vehicle) do
            SetVehicleTyreFixed(current_vehicle, i)
        end
        Notify("~g~Fixed Vehicle")
    else
        Notify('~r~You must be in a vehicle')
    end
end

function applymods(veh)
    SetVehicleModKit(veh, 0)
    Wait(1)
    SetVehicleMod(veh, 11, 3) -- Engine
    SetVehicleMod(veh, 12, 2) -- Brakes
    SetVehicleMod(veh, 13, 2) -- Transmission
    SetVehicleMod(veh, 15, 3) -- Suspension
    SetVehicleMod(veh, 16, 4) -- Armour
    ToggleVehicleMod(veh, 18, true) -- Turbo
    SetVehicleWindowTint(veh, 1) -- Window Tint
end

function cleanveh()
    local client_ped = PlayerPedId()
    local current_vehicle = GetVehiclePedIsIn(client_ped, false)

    if current_vehicle ~= 0 then
        SetVehicleDirtLevel(current_vehicle, 0)
        Notify("~b~Your vehicle has been cleaned!")
    else
        Notify("~o~You must be in a vehicle")
    end
end

function Notify(text)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandThefeedPostTicker(false, false)
end

function spawnVehicle(W, v, w, H, X, Y, Z, _)
    local a0 = loadModel(W)
    local a1 = CreateVehicle(a0, v, w, H, X, Z, _)
    SetEntityAsMissionEntity(a1)
    SetModelAsNoLongerNeeded(a0)

    if Y then
        TaskWarpPedIntoVehicle(PlayerPedId(), a1, -1)
    end
    return a1
end

function loadModel(r)
    local s
    if type(r) ~= "string" then
        s = r
    else
        s = GetHashKey(r)
    end

    if IsModelInCdimage(s) then
        if not HasModelLoaded(s) then
            RequestModel(s)
            while not HasModelLoaded(s) do
                Wait(0)
            end
        end
        return s
    else
        return nil
    end
end

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)

            if TakingCarSS then
                local client_ped = PlayerPedId()
                local current_vehicle = GetVehiclePedIsIn(client_ped, false)

                -- Vehicle Natives
                SetEntityInvincible(current_vehicle, true)
                SetEntityProofs(current_vehicle, true, true, true, true, true, true, true, true)
                SetEntityCanBeDamaged(current_vehicle, false)
                SetVehicleFixed(current_vehicle)
                SetVehicleDirtLevel(current_vehicle, 0.0)

                -- Player Natives
                SetEntityCanBeDamaged(client_ped, false)
                ClearPedBloodDamage(client_ped)

                for i = 0, 360 do
                    DisableControlAction(1, i, true)
                end
            end
        end
    end
)

function TakeVehScreenshot()
    local client_ped = PlayerPedId()
    local current_vehicle = GetVehiclePedIsIn(client_ped, false)

    if current_vehicle == 0 then
        return notify("~r~You must be in a vehicle.")
    end

    local previous_coords = GetEntityCoords(current_vehicle)
    local previous_heading = GetEntityHeading(current_vehicle)

    TakingCarSS = true
    ExecuteCommand("showhud")
    SetEntityCoords(current_vehicle, vector3(-921.20440673828, -3082.5627441406, 12.557805664062))
    SetEntityHeading(client_ped, 100.0)
    SetGameplayCamRelativePitch(7.5, 1.0)
    SetGameplayCamRelativeHeading(-180.0)
    Wait(3000)
    TriggerServerEvent("Nova:takeCarScreenshot", veh, "front")
    Wait(5000)
    SetGameplayCamRelativeHeading(0.8)
    TriggerServerEvent("Nova:takeCarScreenshot", veh, "rear")
    Wait(5000)
    SetGameplayCamRelativeHeading(92.0)
    TriggerServerEvent("Nova:takeCarScreenshot", veh, "side")
    Wait(5000)
    TakingCarSS = false
    SetEntityInvincible(current_vehicle, false)
    SetEntityProofs(current_vehicle, false, false, false, false, false, false, false, false)
    SetEntityCanBeDamaged(current_vehicle, true)
    SetEntityCanBeDamaged(client_ped, true)
    ExecuteCommand("showhud")

    SetEntityCoords(current_vehicle, previous_coords)
    SetEntityHeading(previous_heading)
    SetGameplayCamRelativeHeading(0)
end

local A = {
    {name = "fMass", type = "float"},
    {name = "fInitialDragCoeff", type = "float"},
    {name = "fDownforceModifier", type = "float"},
    {name = "fPercentSubmerged", type = "float"},
    {name = "vecCentreOfMassOffset", type = "vector"},
    {name = "vecInertiaMultiplier", type = "vector"},
    {name = "fDriveBiasFront", type = "float"},
    {name = "nInitialDriveGears", type = "integer"},
    {name = "fInitialDriveForce", type = "float"},
    {name = "fDriveInertia", type = "float"},
    {name = "fClutchChangeRateScaleUpShift", type = "float"},
    {name = "fClutchChangeRateScaleDownShift", type = "float"},
    {name = "fInitialDriveMaxFlatVel", type = "float"},
    {name = "fBrakeForce", type = "float"},
    {name = "fBrakeBiasFront", type = "float"},
    {name = "fHandBrakeForce", type = "float"},
    {name = "fSteeringLock", type = "float"},
    {name = "fTractionCurveMax", type = "float"},
    {name = "fTractionCurveMin", type = "float"},
    {name = "fTractionCurveLateral", type = "float"},
    {name = "fTractionSpringDeltaMax", type = "float"},
    {name = "fLowSpeedTractionLossMult", type = "float"},
    {name = "fCamberStiffnesss", type = "float"},
    {name = "fTractionBiasFront", type = "float"},
    {name = "fTractionLossMult", type = "float"},
    {name = "fSuspensionForce", type = "float"},
    {name = "fSuspensionCompDamp", type = "float"},
    {name = "fSuspensionReboundDamp", type = "float"},
    {name = "fSuspensionUpperLimit", type = "float"},
    {name = "fSuspensionLowerLimit", type = "float"},
    {name = "fSuspensionRaise", type = "float"},
    {name = "fSuspensionBiasFront", type = "float"},
    {name = "fAntiRollBarForce", type = "float"},
    {name = "fAntiRollBarBiasFront", type = "float"},
    {name = "fRollCentreHeightFront", type = "float"},
    {name = "fRollCentreHeightRear", type = "float"},
    {name = "fCollisionDamageMult", type = "float"},
    {name = "fWeaponDamageMult", type = "float"},
    {name = "fDeformationDamageMult", type = "float"},
    {name = "fEngineDamageMult", type = "float"},
    {name = "fPetrolTankVolume", type = "float"},
    {name = "fOilVolume", type = "float"},
    {name = "fSeatOffsetDistX", type = "float"},
    {name = "fSeatOffsetDistY", type = "float"},
    {name = "fSeatOffsetDistZ", type = "float"},
    {name = "nMonetaryValue", type = "integer"}
}

local function B()
    return {
        speedBuffer = {},
        speed = 0.0,
        speedDisplay = 0.0,
        accel = 0.0,
        accelDisplay = 0.0,
        decel = 0.0,
        decelDisplay = 0.0
    }
end

function getPlayerVehicle()
    local a = PlayerPedId()
    local b = GetVehiclePedIsIn(a, false)
    local g = GetPedInVehicleSeat(b, -1)
    local e = g == a
    return b, e
end

local C = false
local D = B()

local function E()
    local q = getPlayerVehicle()
    local F = GetEntitySpeed(q)
    table.insert(D.speedBuffer, F)
    if #D.speedBuffer > 100 then
        table.remove(D.speedBuffer, 1)
    end

    local G = 0.0
    local H = 0.0
    local I = 0
    local J = 0
    for K, L in ipairs(D.speedBuffer) do
        if K > 1 then
            local M = L - D.speedBuffer[K - 1]
            if M > 0.0 then
                G = G + M
                I = I + 1
            else
                H = G + M
                J = J + 1
            end
        end
    end

    G = G / I
    H = H / J
    D.speed = math.max(D.speed, F)
    D.speedDisplay = D.speed * 2.236936
    D.accel = math.max(D.accel, G)
    D.accelDisplay = D.accel * 60.0 * 2.236936
    D.decel = math.min(D.decel, H)
    D.decelDisplay = math.abs(D.decel) * 60.0 * 2.236936
end

local function N(O)
    local q = getPlayerVehicle()
    if q == 0 then
        return "0.0"
    end

    local o_type = O.type
    local o_name = O.name

    if o_type == "float" then
        local P = GetVehicleHandlingFloat(q, "CHandlingData", o_name)
        return string.format("%.5f", P)
    elseif o_type == "integer" then
        local Q = GetVehicleHandlingInt(q, "CHandlingData", o_name)
        return tostring(Q)
    elseif o_type == "vector" then
        local R = GetVehicleHandlingVector(q, "CHandlingData", o_name)
        return string.format("%.3f %.3f %.3f", R.x, R.y, R.z)
    end
    return "INVALID"
end

local function S()
    AddTextEntry("FMMC_MPM_NA", "Enter Value")
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Enter Value", "", "", "", "", 30)
    while UpdateOnscreenKeyboard() == 0 do
        DisableAllControlActions(0)
        Wait(0)
    end
    if GetOnscreenKeyboardResult() then
        local T = GetOnscreenKeyboardResult()
        if T then
            return T
        end
    end
    return false
end

local function stringsplit(input, seperator)
    if seperator == nil then
        seperator = "%s"
    end

    local t = {}
    i = 1

    for str in string.gmatch(input, "([^" .. seperator .. "]+)") do
        t[i] = str
        i = i + 1
    end

    return t
end

local function U(O)
    local V = S()
    if not V then
        tvRP.notify("~r~Input cancelled.")
        return
    end

    local q = getPlayerVehicle()
    local o_type = O.type
    local o_name = O.name

    if o_type == "float" then
        local W = tonumber(V)
        if W then
            SetVehicleHandlingFloat(q, "CHandlingData", o_name, W + 0.0)
        else
            tvRP.notify("~r~Can not parse float.")
        end
    elseif o_type == "integer" then
        local W = tonumber(V)
        if W then
            SetVehicleHandlingInt(q, "CHandlingData", o_name, math.floor(W))
        else
            tvRP.notify("~r~Can not parse integer.")
        end
    elseif o_type == "vector" then
        local X = stringsplit(V, " ")
        if X and #X >= 3 then
            local Y = tonumber(X[1])
            local Z = tonumber(X[2])
            local _ = tonumber(X[3])
            if Y and Z and _ then
                SetVehicleHandlingVector(q, "CHandlingData", o_name, vector3(Y + 0.0, Z + 0.0, _ + 0.0))
            else
                tvRP.notify("~r~Can not parse vector.")
            end
        else
            tvRP.notify("~r~Expected 3 floats.")
        end
    end
    ModifyVehicleTopSpeed(q, 1.0)
end

local function a0(W)
    W = W * 10000.0
    return (W % 1.0 > 0.5 and math.ceil(W) or math.floor(W)) / 10000.0
end

local function a1()
    local a2 = ""
    local function a3(a4)
        if a2 ~= "" then
            a2 = a2 .. "\n\t\t\t"
        end
        a2 = a2 .. a4
    end

    local q = getPlayerVehicle()
    for a5, O in pairs(A) do
        local o_type = O.type
        local o_name = O.name

        if o_type == "float" then
            local W = GetVehicleHandlingFloat(q, "CHandlingData", o_name)
            a3(string.format('<%s value="%s" />', o_name, a0(W)))
        elseif o_type == "integer" then
            local W = GetVehicleHandlingInt(q, "CHandlingData", o_name)
            a3(string.format('<%s value="%s" />', o_name, W))
        elseif o_type == "vector" then
            local W = GetVehicleHandlingVector(q, "CHandlingData", o_name)
            a3(string.format('<%s x="%s" y="%s" z="%s" />', o_name, W.x, W.y, W.z))
        end
    end
    TriggerServerEvent("Nova:getCarDevDebug", {a2})
end

local function a6(a7)
    C = a7
    setCursor(a7 and 1 or 0)
end

function DrawAdvancedTextNoOutline(v, w, x, y, z, A, B, C, D, E, F, G)
    SetTextFont(F)
    SetTextProportional(0)
    SetTextScale(z, z)
    SetTextJustification(G)
    SetTextColour(B, C, D, E)
    SetTextDropShadow()
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(A)
    EndTextCommandDisplayText(v - 0.1 + x, w - 0.02 + y)
end

local function a8()
    if not b then
        if C then
            a6(false)
            inCarDevDebug = false
        end
        return
    end

    E()
    local a9 = 6
    local aa = C and 0.345 or 0.505

    DrawAdvancedTextNoOutline(
        aa,
        0.055,
        0.005,
        0.02,
        0.45,
        string.format("Top Speed: %.5f", D.speedDisplay),
        255,
        255,
        255,
        255,
        a9,
        1
    )
    DrawAdvancedTextNoOutline(
        aa,
        0.075,
        0.005,
        0.02,
        0.45,
        string.format("Top Acceleration: %.5f", D.accelDisplay),
        255,
        255,
        255,
        255,
        a9,
        1
    )
    DrawAdvancedTextNoOutline(
        aa,
        0.095,
        0.005,
        0.02,
        0.45,
        string.format("Top Deacceleration: %.5f", D.decelDisplay),
        255,
        255,
        255,
        255,
        a9,
        1
    )

    local s = getPlayerVehicle()
    DisableControlAction(0, 19, true)

    if s ~= 0 and IsDisabledControlJustPressed(0, 19) then
        a6(not C)
    end

    if not C then
        return
    elseif s == 0 then
        a6(false)
        inCarDevDebug = false
    end

    for K, O in pairs(A) do
        local ab = K > 23 and 1 or 0
        local ac = 0.14 + (K - ab * 23) * 0.0215
        local ad = CursorInArea(0.25 + ab * 0.27, 0.5 + ab * 0.27, ac, ac + 0.0215)
        local ae = ad and 100 or 255

        DrawAdvancedTextNoOutline(0.345 + ab * 0.27, ac, 0.005, 0.02, 0.45, O.name, ae, ae, 255, 255, a9, 1)
        DrawAdvancedTextNoOutline(0.516 + ab * 0.231, ac + 0.001, 0.005, 0.02, 0.45, N(O), ae, ae, 255, 255, a9, 1)

        if ad and IsDisabledControlJustPressed(0, 24) then
            Citizen.CreateThreadNow(
                function()
                    U(O)
                end
            )
        end
    end

    DrawRect(0.465, 0.415, 0.09, 0.495, 0, 0, 0, 100)
    DrawRect(0.695, 0.415, 0.09, 0.495, 0, 0, 0, 100)
    DrawRect(0.278, 0.14, 0.055, 0.02, 255, 255, 255, 230)

    DrawAdvancedTextNoOutline(0.346, 0.129, 0.005, 0.02, 0.24, "Copy Handling", 0, 0, 0, 255, 0, 1)
    if CursorInArea(0.25, 0.31, 0.12, 0.15) and IsDisabledControlJustPressed(0, 24) then
        a1()
    end
    DrawRect(0.338, 0.14, 0.055, 0.02, 255, 255, 255, 230)
    DrawAdvancedTextNoOutline(0.41, 0.129, 0.005, 0.02, 0.24, "Reset Stats", 0, 0, 0, 255, 0, 1)
    if CursorInArea(0.31, 0.37, 0.12, 0.15) and IsDisabledControlJustPressed(0, 24) then
        D = B()
    end
end

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            a8()
            inCarDevDebug = C
        end
    end
)
