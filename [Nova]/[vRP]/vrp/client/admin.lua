local noclip = false
local whitelist = false
local blips = false

local config_noclip = {
    controls = {
        up = 44, -- W
        down = 38, -- S 
        goForward = 32, -- W
        goBackward = 33, -- S
        changeSpeed = 21, -- Left Shift
        decreasespeed = 36 -- Left Ctrl
    },

    disabled_controls = {
        32, 
        34, 
        30, 
        35, 
        266,
        267,
        31, 
        33, 
        268,
        269,
        44, 
        74, 
        36, 
        60, 
        62, 
        132,
        224,
        280,
        281,
        326,
        341,
    },

    speeds = {
        {label = "Very Slow", speed = 0.1},
        {label = "Slow", speed = 0.5},
        {label = "Normal", speed = 2},
        {label = "Fast", speed = 4},
        {label = "Very Fast", speed = 6},
        {label = "Extremely Fast", speed = 10},
        {label = "Extremely Fast v2.0", speed = 20},
        {label = "Max Speed", speed = 25}
    },

    bgR = 0,
    bgG = 0,
    bgB = 0,
    bgA = 80
}

local go_backward_instructional_button = GetControlInstructionalButton(1, config_noclip.controls.goBackward, true)
local go_forward_instructional_button = GetControlInstructionalButton(1, config_noclip.controls.goForward, true)

local decrease_speed_instructional_button = GetControlInstructionalButton(1, config_noclip.controls.decreasespeed, true)
local increase_speed_instructional_button = GetControlInstructionalButton(1, config_noclip.controls.changeSpeed, true)

RegisterKeyMapping("noclip", "Staff Noclip", "keyboard", "F4")
RegisterCommand("noclip", function()
    TriggerServerEvent("Nova:noClip")
end)

function Create_No_Clip_Scaleform(scaleform)
    local scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end

    BeginScaleformMovieMethod(scaleform, "CLEAR_ALL")
    EndScaleformMovieMethod()

    --[[
    BeginScaleformMovieMethod(scaleform, "SET_CLEAR_SPACE")
    ScaleformMovieMethodAddParamInt(200)
    EndScaleformMovieMethod()
    ]]

    BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(1)
    ScaleformMovieMethodAddParamPlayerNameString(go_backward_instructional_button)
    ScaleformMovieMethodAddParamPlayerNameString(go_forward_instructional_button)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentSubstringKeyboardDisplay("Go Forwards / Backwards")
    EndTextCommandScaleformString()
    EndScaleformMovieMethod()

    BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(4)
    ScaleformMovieMethodAddParamPlayerNameString(decrease_speed_instructional_button)
    ScaleformMovieMethodAddParamPlayerNameString(increase_speed_instructional_button)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentSubstringKeyboardDisplay("Increase / Decrease Speed (" .. config_noclip.speeds[index].label .. ")")
    EndTextCommandScaleformString()
    EndScaleformMovieMethod()

    PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    EndScaleformMovieMethod()

    return scaleform
end

function DisableControls()
    for _, control_key in pairs(config_noclip.disabled_controls) do
        EnableControlAction(0, control_key, false)
        DisableControlAction(0, control_key, true)
    end
end

index = 1 -- DONT TOUCH OR JIMMY SAVIL WILL TOUCH YOU
local function No_Clip_Enabled_Thread()
    Citizen.CreateThread(function()
        while noclip do
            currentSpeed = config_noclip.speeds[index].speed
            
            local client_ped = PlayerPedId()
            local noclipEntity = client_ped

            local ped_vehicle = GetVehiclePedIsIn(noclipEntity, false)
            if ped_vehicle ~= 0 then
                noclipEntity = ped_vehicle
                SetVehicleRadioEnabled(noclipEntity, false) -- [[Stop radio from appearing when going upwards.]]
            end
    
            FreezeEntityPosition(noclipEntity, true)
            SetEntityInvincible(noclipEntity, true)
            SetEntityVisible(noclipEntity, false, false)
            SetEntityCollision(noclipEntity, false, false)
    
            local instructional_buttons = Create_No_Clip_Scaleform("instructional_buttons")
            DrawScaleformMovieFullscreen(instructional_buttons)
    
            local yoff = 0.0
            local zoff = 0.0
            local x, y, z = tvRP.getPosition()
            local dx, dy, dz = tvRP.getCamDirection()
            
            DisableControls()
            if IsDisabledControlJustPressed(1, config_noclip.controls.changeSpeed) then
                index = index + 1
                if index > #config_noclip.speeds then
                    index = 1
                end
                currentSpeed = config_noclip.speeds[index].speed
                -- else
                --     currentSpeed = config_noclip.speeds[1].speed
                --     index = 1
                
            elseif IsDisabledControlJustPressed(1, config_noclip.controls.decreasespeed) then
                index = index - 1
                if index < 1 then
                    index = #config_noclip.speeds
                end
                currentSpeed = config_noclip.speeds[index].speed
                -- else
                --     currentSpeed = config_noclip.speeds[1].speed
                --     index = #config_noclip.speeds
            end

            if IsDisabledControlPressed(0, config_noclip.controls.goForward) then
                x = x + currentSpeed * dx
                y = y + currentSpeed * dy
                z = z + currentSpeed * dz
            end
    
            if IsDisabledControlPressed(0, config_noclip.controls.goBackward) then
                x = x - currentSpeed * dx
                y = y - currentSpeed * dy
                z = z - currentSpeed * dz
            end
    
            local heading = GetGameplayCamRelativeHeading() + GetEntityHeading(client_ped)
            local newPos = GetOffsetFromEntityInWorldCoords(noclipEntity, 0.0, x, y, zoff * (currentSpeed + 0.3))

            SetEntityHeading(noclipEntity, heading)
            SetEntityCoordsNoOffset(noclipEntity, x, y, z, true, true, false)
    
            Citizen.Wait(0)
        end
    end)
end

function tvRP.toggleNoclip()
    inRedZone = false
    noclip = not noclip

    local ped = PlayerPedId()
    local ped_current_vehicle = GetVehiclePedIsIn(ped, false)
    if ped_current_vehicle ~= 0 then
        ped = ped_current_vehicle
    end

    if noclip then -- set
        SetPedCanRagdoll(ped, false)
        SetEntityInvincible(ped, true)
        SetPlayerInvincible(ped, true)
        SetEntityVisible(ped, false, false)
        SetEntityCollision(ped, false)
        No_Clip_Enabled_Thread()
    else -- unset
        SetPedCanRagdoll(ped, true)
        SetEntityInvincible(ped, false)
        SetPlayerInvincible(ped, false)
        SetEntityVisible(ped, true, true)
        SetEntityCollision(ped, true)
        FreezeEntityPosition(ped, false)
    end
end

function tvRP.isNoclip()
    return noclip
end

RegisterNetEvent("ToggleAdminNoclip")
AddEventHandler("ToggleAdminNoclip", function()
    tvRP.toggleNoclip()
end)

local Delgun_Enabled = false
local Delgun_Hash = GetHashKey('WEAPON_STAFFGUN')
local function Network_Delete_Function(entity)
    Citizen.CreateThread(function()
        if DoesEntityExist(entity) and not (IsEntityAPed(entity) and IsPedAPlayer(entity)) then
            NetworkRequestControlOfEntity(entity)
            local timeout = 5
            while timeout > 0 and not NetworkHasControlOfEntity(entity) do
                Citizen.Wait(1)
                timeout = timeout - 1
            end
            DetachEntity(entity, 0, false)
            SetEntityCollision(entity, false, false)
            SetEntityAlpha(entity, 0.0, true)
            SetEntityAsMissionEntity(entity, true, true)
            SetEntityAsNoLongerNeeded(entity)
            DeleteEntity(entity)
        end
    end)
end

local Marker_Colours = {
    {148, 0, 211}, -- Violet
    {75, 0, 130}, -- Indigo
    {0, 0, 255}, -- Blue
    {255, 255, 0}, -- Yellow
    {255, 127, 0}, -- Orange
    {255, 0 , 0}, -- Red
}
local function Draw_Entity_Marker(entity)
    local entity_coords = GetEntityCoords(entity)
    local r, g, b = table.unpack(Marker_Colours[math.random(1, #Marker_Colours)])

    DrawMarker(
        1, -- Marker Type
        entity_coords, -- Marker Coords (x, y, z)
        0.0, 0.0, 0.0, -- Marker Direction (x, y, z)
        0.0, 0, 0.0, -- Marker Rotation (x, y, z)
        1.0, 1.0, 1.0, -- Marker Scale (x, y, z)
        r, g, b, 255, -- RGBA
        false, -- Bob Up and Down
        false, -- Face Camera
        0, -- P19 Number
        false -- Rotate
    )
end

local function Entity_Gun_Delete_Thread()
    Citizen.CreateThread(function()
        while Delgun_Enabled do
            local client_ped = PlayerPedId()
            if HasPedGotWeapon(client_ped, Delgun_Hash, false) then
                if GetSelectedPedWeapon(client_ped) == Delgun_Hash then
                    local plr = PlayerId()
                    local found, entity = GetEntityPlayerIsFreeAimingAt(plr)
                    if found then
                        if IsControlJustPressed(0, 24) or IsDisabledControlJustPressed(0, 24) then
                            tvRP.notify("~g~Deleted Entity: " .. GetEntityModel(entity))
                            Network_Delete_Function(entity)
                        else
                            Draw_Entity_Marker(entity)
                        end 
                    end
                    Citizen.Wait(0)
                else
                    Citizen.Wait(1000)
                end
            else
                Delgun_Enabled = false
            end
        end
    end)
end

local Had_Delgun = false
RegisterCommand('delgun', function()
    if tvRP.isAdmin() then
        Delgun_Enabled = not Delgun_Enabled
        local client_ped = PlayerPedId()
        if Delgun_Enabled then
            if HasPedGotWeapon(client_ped, Delgun_Hash, false) then
                Had_Delgun = true
            else
                GiveWeaponToPed(client_ped, Delgun_Hash, 0, false, true)
            end
            Entity_Gun_Delete_Thread()
            tvRP.notify('~g~Delgun Enabled')
        else
            if Had_Delgun then
                Had_Delgun = false
            else
                RemoveWeaponFromPed(client_ped, Delgun_Hash)
            end
            tvRP.notify('~r~Delgun Disabled')
        end
    else
        tvRP.notify('~r~This can only be used by staff')
    end
end)

local function teleportToWaypoint()
    --Credits: https://gist.github.com/samyh89/32a780abcd1eea05ab32a61985857486
    --Just a better TP to waypoint and I cba to make one so here is one creds
    Citizen.CreateThread(function()
        local entity = PlayerPedId()
        local client_vehicle = GetVehiclePedIsIn(entity, false)
        if client_vehicle ~= 0 then
            entity = client_vehicle
        end

        local success = false
        local blipFound = false
        local blipIterator = GetWaypointBlipEnumId()
        local blip = GetFirstBlipInfoId(8)

        while DoesBlipExist(blip) do
            if GetBlipInfoIdType(blip) == 4 then
                cx, cy, cz =
                    table.unpack(
                    Citizen.InvokeNative(
                        0xFA7C7F0AADF25D09,
                        blip,
                        Citizen.ReturnResultAnyway(),
                        Citizen.ResultAsVector()
                    )
                ) --GetBlipInfoIdCoord(blip)
                blipFound = true
                break
            end
            blip = GetNextBlipInfoId(blipIterator)
        end

        if blipFound then
            DoScreenFadeOut(250)
            while IsScreenFadedOut() do
                Citizen.Wait(250)
            end
            local groundFound = false
            local yaw = GetEntityHeading(entity)

            for i = 0, 1000, 1 do
                SetEntityCoordsNoOffset(entity, cx, cy, ToFloat(i), false, false, false)
                SetEntityRotation(entity, 0, 0, 0, 0, 0)
                SetEntityHeading(entity, yaw)
                SetGameplayCamRelativeHeading(0)
                Citizen.Wait(0)
                if GetGroundZFor_3dCoord(cx, cy, ToFloat(i), cz, false) then --GetGroundZFor3dCoord(cx, cy, i, 0, 0) GetGroundZFor_3dCoord(cx, cy, i)
                    cz = ToFloat(i)
                    groundFound = true
                    break
                end
            end
            if not groundFound then
                cz = -300.0
            end
            success = true
        else
            tvRP.notify("~r~Blip not found")
        end

        if success then
            SetEntityCoordsNoOffset(entity, cx, cy, cz, false, false, true)
            SetGameplayCamRelativeHeading(0)
            if IsPedSittingInAnyVehicle(PlayerPedId()) then
                if GetPedInVehicleSeat(GetVehiclePedIsUsing(PlayerPedId()), -1) == PlayerPedId() then
                    SetVehicleOnGroundProperly(GetVehiclePedIsUsing(PlayerPedId()))
                end
            end
            DoScreenFadeIn(250)
            tvRP.notify("~g~Teleported success!")
        end
    end)
end

RegisterNetEvent("TpToWaypoint")
AddEventHandler("TpToWaypoint", teleportToWaypoint)

RegisterNetEvent("Nova:vehicleMenu")
AddEventHandler("Nova:vehicleMenu")

function drawNativeText(V)
    BeginTextCommandPrint("STRING")
    AddTextComponentSubstringPlayerName(V)
    EndTextCommandPrint(100, 1)
end

RegisterCommand("dv", function()
    local ped = PlayerPedId()
    if (DoesEntityExist(ped) and not IsEntityDead(ped)) then
        local ped_vehicle = GetVehiclePedIsIn(ped, false)
        if ped_vehicle ~= 0 then
            if GetPedInVehicleSeat(ped_vehicle, -1) == ped then
                DeleteGivenVehicle(ped_vehicle, numRetries)
            else
                Notify("You must be in the driver's seat!")
            end
        else
            Notify("~o~You must be in a vehicle to delete it")
        end
    end
end)

local function Blips_Enabled_Thread()
    Citizen.CreateThread(function()
        while blips do
            local client_ped = PlayerPedId()
            for k, v in ipairs(GetActivePlayers()) do
                local ped = GetPlayerPed(v)
                if ped ~= client_ped then
                    local blip = GetBlipFromEntity(ped)
                    if not DoesBlipExist(blip) then
                        blip = AddBlipForEntity(ped)
                        SetBlipSprite(blip, 1)
                        Citizen.InvokeNative(0x5FBCA48327B914DF, blip, true)
                        local R = GetVehiclePedIsIn(ped, false)
                        Citizen.InvokeNative(0x5FBCA48327B914DF, blip, true)
                        SetBlipRotation(blip, math.ceil(GetEntityHeading(R)))
                        SetBlipNameToPlayerName(blip, P)
                        SetBlipScale(blip, 0.85)
                        SetBlipAlpha(blip, 255)
                    end
                end
            end
            Citizen.Wait(1000)
        end
    end)
end

RegisterNetEvent("Nova:showBlips")
AddEventHandler("Nova:showBlips", function()
    blips = not blips
    if blips then
        Blips_Enabled_Thread()
        tvRP.notify("~g~Blips enabled")
    else
        tvRP.notify("~r~Blips disabled")
        local client_ped = PlayerPedId()
        for k, v in ipairs(GetActivePlayers()) do
            local Q = GetPlayerPed(v)
            if Q ~= client_ped then
                blip = GetBlipFromEntity(Q)
                RemoveBlip(blip)
            end
        end
    end
end)

-- The distance to check in front of the player for a vehicle
local distanceToCheck = 5.0

-- The number of times to retry deleting a vehicle if it fails the first time
local numRetries = 5

-- Add an event handler for the deleteVehicle event. Gets called when a user types in /dv in chat

function DeleteGivenVehicle(veh, timeoutMax)
    local timeout = 0

    SetEntityAsMissionEntity(veh, true, true)
    DeleteVehicle(veh)

    if (DoesEntityExist(veh)) then
        Notify("~r~Failed to delete vehicle, trying again")

        -- Fallback if the vehicle doesn't get deleted
        while (DoesEntityExist(veh) and timeout < timeoutMax) do
            DeleteVehicle(veh)

            -- The vehicle has been banished from the face of the Earth!
            if (not DoesEntityExist(veh)) then
                Notify("~g~Vehicle deleted")
            end

            -- Increase the timeout counter and make the system wait
            timeout = timeout + 1
            Citizen.Wait(500)

            -- We've timed out and the vehicle still hasn't been deleted.
            if (DoesEntityExist(veh) and (timeout == timeoutMax - 1)) then
                Notify("~r~Failed to delete vehicle after " .. timeoutMax .. " retries")
            end
        end
    else
        Notify("~g~Vehicle deleted")
    end
end

-- Gets a vehicle in a certain direction
-- Credit to Konijima
function GetVehicleInDirection(entFrom, coordFrom, coordTo)
    local rayHandle =
        StartShapeTestCapsule(
        coordFrom.x,
        coordFrom.y,
        coordFrom.z,
        coordTo.x,
        coordTo.y,
        coordTo.z,
        5.0,
        10,
        entFrom,
        7
    )
    local _, _, _, _, vehicle = GetShapeTestResult(rayHandle)

    if (IsEntityAVehicle(vehicle)) then
        return vehicle
    end
end

-- Shows a notification on the player's screen
function Notify(text)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandThefeedPostTicker(false, false)
end

function bank_drawTxt(x, y, width, height, scale, text, r, g, b, a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if (outline) then
        SetTextOutline()
    end
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(x - width / 2, y - height / 2 + 0.005)
end

RegisterNetEvent('Nova:Client:FixCurrentVehicle')
AddEventHandler('Nova:Client:FixCurrentVehicle', function()
    Fix_Current_Vehicle()
end)