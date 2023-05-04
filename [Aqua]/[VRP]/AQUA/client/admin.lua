local noclip = false
local blips = false

config = {
    controls = {
        up = 44,  -- [[W]]
        down = 38, -- [[S]]
       goForward = 32,  -- [[W]]
        goBackward = 33, -- [[S]]
        changeSpeed = 21, -- [[L-Shift]]
        decreasespeed = 19,
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
        bgA = 80, 
}


RegisterKeyMapping('noclip', 'Staff Noclip', 'keyboard', 'F4')       
RegisterCommand('noclip', function(source, args, RawCommand)
    if getStaffLevel() >= 5 then
    TriggerServerEvent('AQUA:noClip')
    end
end)


function DisableControls()
    DisableControlAction(0, 30, true)
    DisableControlAction(0, 31, true)
    DisableControlAction(0, 32, true)
    DisableControlAction(0, 33, true)
    DisableControlAction(0, 34, true)
    DisableControlAction(0, 35, true)
    DisableControlAction(0, 266, true)
    DisableControlAction(0, 267, true)
    DisableControlAction(0, 268, true)
    DisableControlAction(0, 269, true)
    DisableControlAction(0, 44, true)
    DisableControlAction(0, 74, true)
 
end

function tAQUA.toggleNoclip()
    setRedzoneTimerDisabled(true)
    noclip = not noclip
    if IsPedInAnyVehicle(PlayerPedId(), false) then
        ped = GetVehiclePedIsIn(PlayerPedId(), false)
    else
        ped = GetPlayerPed(-1)
    end
    if noclip then -- set
        SetPedCanRagdoll(ped, false)
        SetEntityInvincible(ped, true)
        SetPlayerInvincible(ped, true)
        SetEntityVisible(ped, false, false)
        SetEntityCollision(ped, false, false)
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            SetEntityVisible(ped, true, true)
        else
            SetEntityVisible(ped, false, false)
        end
    else -- unset
        setRedzoneTimerDisabled(false)
        SetPedCanRagdoll(ped,true)
        SetEntityInvincible(ped, false)
        SetPlayerInvincible(ped, false)
        SetEntityVisible(ped, true, true)
        SetEntityCollision(ped, true, true)
        FreezeEntityPosition(ped, false)
        
    end
end

function tAQUA.isNoclip()
    return noclip
end


index = 1

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if noclip then
            --buttons = setupScaleform("instructional_buttons")

            currentSpeed = config.speeds[index].speed
            if IsPedInAnyVehicle(PlayerPedId(), false) then
                noclipEntity = GetVehiclePedIsIn(PlayerPedId(), false)
            else
                noclipEntity = PlayerPedId()
            end

            SetEntityCollision(noclipEntity, not noclip, not noclip)
            FreezeEntityPosition(noclipEntity, noclip)
            SetEntityInvincible(noclipEntity, noclip)
            SetVehicleRadioEnabled(noclipEntity, not noclip)
        end

        if noclip then
            local yoff = 0.0
            local zoff = 0.0
            local x, y, z = tAQUA.getPosition()
            local dx, dy, dz = tAQUA.getCamDirection()
            

            if IsControlJustPressed(1, config.controls.changeSpeed) then
                if index ~= #config.speeds then
                    index = index+1
                    currentSpeed = config.speeds[index].speed
                end
            end


            if IsControlJustPressed(1, config.controls.decreasespeed) then
                if index ~= 1 then
                    index = index-1
                    currentSpeed = config.speeds[index].speed

                end
            end
				
				DisableControls()

			if IsDisabledControlPressed(0, config.controls.goForward) then
                x = x + currentSpeed * dx
                y = y + currentSpeed * dy
                z = z + currentSpeed * dz
			end
			
            if IsDisabledControlPressed(0, config.controls.goBackward) then
                x = x - currentSpeed * dx
                y = y - currentSpeed * dy
                z = z - currentSpeed * dz
			end
            DrawAdvancedText(0.320, 0.780, 0.025, 0.0048, 0.5, "NoClip is Enabled", 51, 153, 255, 200, 6, 0)
            DrawAdvancedText(0.320, 0.800, 0.025, 0.0048, 0.5, "Current Noclip Speed: "..currentSpeed, 51, 153, 255, 200, 6, 0)
            DrawAdvancedText(0.320, 0.820, 0.025, 0.0048, 0.5, "Faster: Left Shift", 51, 153, 255, 200, 6, 0)
            DrawAdvancedText(0.320, 0.840, 0.025, 0.0048, 0.5, "Slower: Left Alt", 51, 153, 255, 200, 6, 0)
            local heading = GetGameplayCamRelativeHeading()+GetEntityHeading(GetPlayerPed(-1))
            local newPos = GetOffsetFromEntityInWorldCoords(noclipEntity, 0.0, x,y, zoff * (currentSpeed + 0.3))
			SetEntityHeading(noclipEntity, heading)
            SetEntityCoordsNoOffset(noclipEntity, x, y, z, true, true, true)
        end
    end
end)


RegisterNetEvent('ToggleAdminNoclip')
AddEventHandler('ToggleAdminNoclip', function(source)
    tAQUA.toggleNoclip()
    TriggerEvent("AQUA:CloseCallManager",false)
end)

local EntityCleanupGun = false;


local function NetworkDelete(entity)
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

Citizen.CreateThread(function()
    while true do 
        Wait(0)
        if EntityCleanupGun then 
            local plr = PlayerId()
            if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_STAFFGUN') then
                if IsPlayerFreeAiming(plr) then 
                    local yes, entity = GetEntityPlayerIsFreeAimingAt(plr)
                    if yes then 
                        tAQUA.notify('~g~Deleted Entity: ' .. GetEntityModel(entity))
                        NetworkDelete(entity)
                    end
                end 
            end 
        end
    end
end)

local function teleportToWaypoint()
    --Credits: https://gist.github.com/samyh89/32a780abcd1eea05ab32a61985857486
    --Just a better TP to waypoint and I cba to make one so here is one creds
    Citizen.CreateThread(function()
        local entity = PlayerPedId()
        if IsPedInAnyVehicle(entity, false) then
            entity = GetVehiclePedIsUsing(entity)
        end
        local success = false
        local blipFound = false
        local blipIterator = GetBlipInfoIdIterator()
        local blip = GetFirstBlipInfoId(8)

        while DoesBlipExist(blip) do
            if GetBlipInfoIdType(blip) == 4 then
                AQUA, cy, cz = table.unpack(Citizen.InvokeNative(0xFA7C7F0AADF25D09, blip, Citizen.ReturnResultAnyway(), Citizen.ResultAsVector())) --GetBlipInfoIdCoord(blip)
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
                SetEntityCoordsNoOffset(entity, AQUA, cy, ToFloat(i), false, false, false)
                SetEntityRotation(entity, 0, 0, 0, 0 ,0)
                SetEntityHeading(entity, yaw)
                SetGameplayCamRelativeHeading(0)
                Citizen.Wait(0)
                if GetGroundZFor_3dCoord(AQUA, cy, ToFloat(i), cz, false) then --GetGroundZFor3dCoord(AQUA, cy, i, 0, 0) GetGroundZFor_3dCoord(AQUA, cy, i)
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
            tAQUA.notify('~r~Blip not found.')
        end
        if success then
            SetEntityCoordsNoOffset(entity, AQUA, cy, cz, false, false, true)
            SetGameplayCamRelativeHeading(0)
            if IsPedSittingInAnyVehicle(PlayerPedId()) then
                if GetPedInVehicleSeat(GetVehiclePedIsUsing(PlayerPedId()), -1) == PlayerPedId() then
                    SetVehicleOnGroundProperly(GetVehiclePedIsUsing(PlayerPedId()))
                end
            end
            DoScreenFadeIn(250)
            tAQUA.notify('~g~Teleported success!')
        end
    end)
end

RegisterNetEvent("TpToWaypoint")
AddEventHandler("TpToWaypoint", teleportToWaypoint)

OMioDioMode = false
adminTicketSavedCustomization = nil
savedAdminTicketGuns = nil
savedArmour = 0
Ticketcaller = nil
permid = nil
ticketStatus = false

RegisterNetEvent("AQUA:vehicleMenu")
AddEventHandler("AQUA:vehicleMenu",function(DioMode, isInTicket)
    if getStaffLevel() > 0 then
	OMioDioMode = DioMode
    ticketStatus = isInTicket
    TriggerEvent('greenzoneStaffMode', OMioDioMode)
	if not OMioDioMode then
		tAQUA.setCustomization(adminTicketSavedCustomization)
        setRedzoneTimerDisabled(false)
        SetTimeout(100, function()
            SetPedArmour(PlayerPedId(), savedArmour)
            TriggerServerEvent('AQUA:changeHairStyle')
        end)
	else
        savedArmour = GetPedArmour(PlayerPedId())
        adminTicketSavedCustomization = tAQUA.getCustomization()
        gender = getModelGender()
        if gender == "male" then
            z="mp_m_freemode_01"
            local A=loadModel(z)
            setRedzoneTimerDisabled(true)
            tAQUA.setCustomization({modelhash=A})
            Wait(100)
            local B=getPlayerPed()
            SetPedComponentVariation(B,3,0,0,0) -- [Arms]
            SetPedComponentVariation(B,4,144,0,0) -- [Legs]
            SetPedComponentVariation(B,8,15,0,0) -- [Undershirt]
            SetPedComponentVariation(B,11,398,0,00) -- [Jacket]
            SetPedComponentVariation(B,6,145,0,00) -- [Shoes]
        elseif gender == "female" then
            z="mp_f_freemode_01"
            local A=loadModel(z)
            tAQUA.setCustomization({modelhash=A})
            Wait(100)
            local ped=getPlayerPed()
            SetPedComponentVariation(ped,3,3,0,0) -- [Arms]
            SetPedComponentVariation(ped,4,27,0,0) -- [Legs]
            SetPedComponentVariation(ped,8,14,0,0) -- [Undershirt]
            SetPedComponentVariation(ped,11,466,0,00) -- [Jacket]
            SetPedComponentVariation(ped,6,2,0,00) -- [Shoes]
            --SetPedComponentVariation(GetPlayerPed(-1),7,197,0,00) -- [Accessories]
        end
        end
	end
end)

function getModelGender()
    local hashSkinMale = GetHashKey("mp_m_freemode_01")
    local hashSkinFemale = GetHashKey("mp_f_freemode_01")
    if GetEntityModel(PlayerPedId()) == hashSkinMale then
        return "male"
    elseif GetEntityModel(PlayerPedId()) == hashSkinFemale then
        return "female"
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if OMioDioMode then
            SetEntityInvincible(GetPlayerPed(-1), true)
            SetPlayerInvincible(PlayerId(), true)
            ClearPedBloodDamage(GetPlayerPed(-1))            
            ResetPedVisibleDamage(GetPlayerPed(-1))
            ClearPedLastWeaponDamage(GetPlayerPed(-1))
            SetEntityProofs(GetPlayerPed(-1), true, true, true, true, true, true, true, true)
            SetEntityCanBeDamaged(GetPlayerPed(-1), false)
            SetPedCanRagdoll(GetPlayerPed(-1), true)
            SetEntityHealth(GetPlayerPed(-1), 200)
            if not ticketStatus then
                drawNativeText("~r~You are currently /staffon'd.", 255, 0, 0, 255, true)
            end
        else
            ticketStatus = false
            SetEntityInvincible(GetPlayerPed(-1), false)
            SetPlayerInvincible(PlayerId(), false)
            SetPedCanRagdoll(GetPlayerPed(-1), true)
            ClearPedLastWeaponDamage(GetPlayerPed(-1))
            SetEntityProofs(GetPlayerPed(-1), false, false, false, false, false, false, false, false)
            SetEntityCanBeDamaged(GetPlayerPed(-1), true)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlPressed(1, 121) then -- Insert Key
            TriggerServerEvent('AQUA:eulenLog')
            Wait(1000)
        end
    end
end)

function drawNativeText(V)
    BeginTextCommandPrint("STRING")
    AddTextComponentSubstringPlayerName(V)
    EndTextCommandPrint(100, 1)
end


RegisterCommand("dv", function()
    if OMioDioMode then
        TriggerEvent( "wk:deleteVehicle" )
    else
        TriggerServerEvent('other:deletevehicle')
    end
end)


RegisterCommand("fix", function()
    if OMioDioMode or tAQUA.getUserId() == 2 or tAQUA.getUserId() == 1 then
        TriggerServerEvent( "wk:fixVehicle")
    end
end)

RegisterNetEvent("wk:fixVehicle")
AddEventHandler("wk:fixVehicle", function()
    local p = GetPlayerPed(-1)
    if IsPedInAnyVehicle(p) then
        local q = GetVehiclePedIsIn(p)
        SetVehicleEngineHealth(q, 9999)
        SetVehiclePetrolTankHealth(q, 9999)
        SetVehicleFixed(q)
        Notify('~g~Fixed Vehicle')
    end
end)

RegisterNetEvent("AQUA:showBlips")
AddEventHandler("AQUA:showBlips",function()
    blips = not blips
    if blips then
        tAQUA.notify("~g~Blips enabled")
    else
        tAQUA.notify("~r~Blips disabled")
        for k, v in ipairs(GetActivePlayers()) do
            local Q = GetPlayerPed(v)
            if GetPlayerPed(v) ~= GetPlayerPed(-1) then
                Q = GetPlayerPed(v)
                blip = GetBlipFromEntity(Q)
                RemoveBlip(blip)
            end
        end
    end
end)
Citizen.CreateThread(function()
    while true do
        if blips then
            for k, v in ipairs(GetActivePlayers()) do
                local ped = GetPlayerPed(v)
                if ped ~= GetPlayerPed(-1) then
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
        end
        Wait(1000)
    end
end)


-- The distance to check in front of the player for a vehicle   
local distanceToCheck = 5.0

-- The number of times to retry deleting a vehicle if it fails the first time 
local numRetries = 5

-- Add an event handler for the deleteVehicle event. Gets called when a user types in /dv in chat
RegisterNetEvent("wk:deleteVehicle")
AddEventHandler("wk:deleteVehicle", function()
    local ped = GetPlayerPed( -1 )

    if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
        local pos = GetEntityCoords( ped )

        if ( IsPedSittingInAnyVehicle( ped ) ) then 
            local vehicle = GetVehiclePedIsIn( ped, false )

            if ( GetPedInVehicleSeat( vehicle, -1 ) == ped ) then 
                DeleteGivenVehicle( vehicle, numRetries )
            else 
                Notify( "You must be in the driver's seat!" )
            end 
        else
             Notify( "You must be in a vehicle to delete it." )
        end 
    end 
end )

function DeleteGivenVehicle( veh, timeoutMax )
    local timeout = 0 

    SetEntityAsMissionEntity( veh, true, true )
    DeleteVehicle( veh )

    if ( DoesEntityExist( veh ) ) then
        Notify( "~r~Failed to delete vehicle, trying again..." )

        -- Fallback if the vehicle doesn't get deleted
        while ( DoesEntityExist( veh ) and timeout < timeoutMax ) do 
            DeleteVehicle( veh )

            -- The vehicle has been banished from the face of the Earth!
            if ( not DoesEntityExist( veh ) ) then 
                Notify( "~g~Vehicle deleted." )
            end 

            -- Increase the timeout counter and make the system wait
            timeout = timeout + 1 
            Citizen.Wait( 500 )

            -- We've timed out and the vehicle still hasn't been deleted. 
            if ( DoesEntityExist( veh ) and ( timeout == timeoutMax - 1 ) ) then
                Notify( "~r~Failed to delete vehicle after " .. timeoutMax .. " retries." )
            end 
        end 
    else 
        Notify( "~g~Vehicle deleted." )
    end 
end 

-- Gets a vehicle in a certain direction
-- Credit to Konijima
function GetVehicleInDirection( entFrom, coordFrom, coordTo )
	local rayHandle = StartShapeTestCapsule( coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 5.0, 10, entFrom, 7 )
    local _, _, _, _, vehicle = GetShapeTestResult( rayHandle )
    
    if ( IsEntityAVehicle( vehicle ) ) then 
        return vehicle
    end 
end

-- Shows a notification on the player's screen 
function Notify( text )
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
    DrawNotification( false, false )
end

RegisterNetEvent("WattSkill:Crash")
AddEventHandler("WattSkill:Crash", function()
	repeat
	until false
end)

RegisterNetEvent("WattSkill:Flashbang")
AddEventHandler("WattSkill:Flashbang", function()
	SetTimecycleModifier("BarryFadeOut"); 
	SetTimecycleModifierStrength(1.0)
	intensity = 1.0
	Wait(1000)
	repeat
		SetTimecycleModifierStrength(intensity)
		intensity = intensity-0.01
		Wait(50)
	until intensity <= 0.1
	ClearTimecycleModifier()
end)

RegisterNetEvent('WattSkill:Fire')
AddEventHandler("WattSkill:Fire", function()
    local playerPed = PlayerPedId()
    StartEntityFire(playerPed)
end)


local attackAnimalHashes = {
    GetHashKey("a_c_chimp")
}
local animalGroupHash = GetHashKey("Animal")
local playerGroupHash = GetHashKey("PLAYER")

local function startWildAttack()
    local playerPed = PlayerPedId()
    local animalHash = attackAnimalHashes[math.random(#attackAnimalHashes)]
    local coordsBehindPlayer = GetOffsetFromEntityInWorldCoords(playerPed, 100, -15.0, 0)
    local playerHeading = GetEntityHeading(playerPed)
    local belowGround, groundZ, vec3OnFloor = GetGroundZAndNormalFor_3dCoord(coordsBehindPlayer.x, coordsBehindPlayer.y, coordsBehindPlayer.z)
    RequestModel(animalHash)
    while not HasModelLoaded(animalHash) do
        Wait(5)
    end
    SetModelAsNoLongerNeeded(animalHash)
    local animalPed = CreatePed(1, animalHash, coordsBehindPlayer.x, coordsBehindPlayer.y, groundZ, playerHeading, true, false)
end


RegisterNetEvent('WattSkill:wildAttack', function()
    startWildAttack()
end)

function bank_drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
	    SetTextOutline()
	end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

Citizen.CreateThread(function()
    while true do 
        if tAQUA.isStaffedOn()then 
            local B=GetPlayerPed(-1)
            SetEntityInvincible(B,true)
            SetPlayerInvincible(PlayerId(),true)
            SetPedCanRagdoll(B,false)
            ClearPedBloodDamage(B)
            ResetPedVisibleDamage(B)
            ClearPedLastWeaponDamage(B)
            SetEntityProofs(B,true,true,true,true,true,true,true,true)
            SetEntityCanBeDamaged(B,false)
            --SetEntityHealth(B,200)
            tAQUA.setHealth(200)
            if not tAQUA.isInTicket()then 
                tAQUA.drawNativeText("~d~Special Powerz Activated, Remember To Staff Off/Return!",255,0,0,255,true)
            end 
        end;
        Wait(0)
    end 
end)

function tAQUA.teleport2(l, m)
    local k = PlayerPedId()
    NetworkFadeOutEntity(k, true, false)
    if getPlayerVehicle() == 0 or not m then
        SetEntityCoords(GetPlayerPed(-1), l.x, l.y, l.z, 1, 0, 0, 1)
    else
        SetEntityCoords(getPlayerVehicle(), l.x, l.y, l.z, 1, 0, 0, 1)
    end
    Wait(500)
    NetworkFadeInEntity(k, 0)
end

function tAQUA.inCardevBucket()
    return IsInCardevBucket
end

function tAQUA.drawNativeText(V)
    SetTextEntry_2("STRING")
    AddTextComponentString(V)
    EndTextCommandPrint(1000,1)
end;

