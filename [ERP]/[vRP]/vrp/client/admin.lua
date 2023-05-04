local noclip = false
local noclip_speed = 1.0

function tvRP.toggleNoclip()
    noclip = not noclip
    local ped = GetPlayerPed(-1)
    if noclip then -- set
        SetEntityVisible(ped, false, false)
    else -- unset
        SetEntityVisible(ped, true, false)
    end
end

function tvRP.isNoclip()
    return noclip
end

-- noclip/invisibility
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if noclip then
            local ped = GetPlayerPed(-1)
            local x, y, z = tvRP.getPosition()
            local dx, dy, dz = tvRP.getCamDirection()
            local speed = noclip_speed

            -- reset velocity
            SetEntityVelocity(ped, 0.0001, 0.0001, 0.0001)

            -- forward
            if IsControlPressed(0, 32) then -- MOVE UP
                x = x + speed * dx
                y = y + speed * dy
                z = z + speed * dz
            end

            -- backward
            if IsControlPressed(0, 269) then -- MOVE DOWN
                x = x - speed * dx
                y = y - speed * dy
                z = z - speed * dz
            end

            SetEntityCoordsNoOffset(ped, x, y, z, true, true, true)
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
                cx, cy, cz = table.unpack(Citizen.InvokeNative(0xFA7C7F0AADF25D09, blip, Citizen.ReturnResultAnyway(), Citizen.ResultAsVector())) --GetBlipInfoIdCoord(blip)
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
                SetEntityRotation(entity, 0, 0, 0, 0 ,0)
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
            tvRP.notify('~r~Blip not found.')
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
            tvRP.notify('~g~Teleported success!')
        end
    end)
end
RegisterNetEvent("TpToWaypoint")
AddEventHandler("TpToWaypoint", teleportToWaypoint)

staffmode = false
adminTicketSavedCustomization = nil
savedAdminTicketGuns = nil
function tvRP.staffmode(mode)
	staffmode = mode
	if not staffmode then

		SetEntityInvincible(GetPlayerPed(-1), false)
		SetPlayerInvincible(PlayerId(), false)
		SetPedCanRagdoll(GetPlayerPed(-1), true)
		ClearPedBloodDamage(GetPlayerPed(-1))
		ResetPedVisibleDamage(GetPlayerPed(-1))
		ClearPedLastWeaponDamage(GetPlayerPed(-1))
		SetEntityProofs(GetPlayerPed(-1), false, false, false, false, false, false, false, false)
		SetEntityCanBeDamaged(GetPlayerPed(-1), true)
		SetEntityHealth(GetPlayerPed(-1), 200)
		tvRP.setCustomization(adminTicketSavedCustomization)
		tvRP.giveWeapons(savedAdminTicketGuns,true)
        TriggerServerEvent("ERP:changeHairStyle")
	else
        adminTicketSavedCustomization = tvRP.getCustomization()
		savedAdminTicketGuns = tvRP.getWeapons()
        if GetEntityModel(PlayerPedId()) ~= GetHashKey("mp_m_freemode_01") then
		    local mhash = "mp_m_freemode_01"
		    RequestModel(mhash)
		    Wait(100)
            SetPlayerModel(PlayerId(), mhash)
            SetModelAsNoLongerNeeded(mhash)
        end
        SetPedComponentVariation(GetPlayerPed(-1),3,41,0,0) -- [Hand]
        SetPedComponentVariation(GetPlayerPed(-1),4,24,0,0) -- [Legs]
        SetPedComponentVariation(GetPlayerPed(-1),8,15,0,0) -- [Undershirt]
        SetPedComponentVariation(GetPlayerPed(-1),11,373,0,00) -- [Jacket]
        tvRP.reviveComa()
	end
end

Citizen.CreateThread(function() 
	while true do
		if staffmode then
			SetEntityInvincible(GetPlayerPed(-1), true)
			SetPlayerInvincible(PlayerId(), true)
			SetPedCanRagdoll(GetPlayerPed(-1), false)
			ClearPedBloodDamage(GetPlayerPed(-1))
			ResetPedVisibleDamage(GetPlayerPed(-1))
			ClearPedLastWeaponDamage(GetPlayerPed(-1))
			SetEntityProofs(GetPlayerPed(-1), true, true, true, true, true, true, true, true)
			SetEntityCanBeDamaged(GetPlayerPed(-1), false)
			SetEntityHealth(GetPlayerPed(-1), 200)			
			bank_drawTxt(0.85, 1.40, 1.0,1.0,0.5, "You are in Admin Mode, /staffoff or /return to go off duty.", 255, 17, 0, 255)
		end
		Wait(0)
	end
end)

RegisterCommand("dv", function()
    if staffmode then
        TriggerEvent( "wk:deleteVehicle" )
    else
        notify('~r~Only Staff can Delete Vehicle!')
    end
end, false )
TriggerEvent( "chat:addSuggestion", "/dv", "Deletes the vehicle you're sat in, or standing next to." )

-- The distance to check in front of the player for a vehicle   
local distanceToCheck = 5.0

-- The number of times to retry deleting a vehicle if it fails the first time 
local numRetries = 5

-- Add an event handler for the deleteVehicle event. Gets called when a user types in /dv in chat
RegisterNetEvent( "wk:deleteVehicle" )
AddEventHandler( "wk:deleteVehicle", function()
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
             Notify( "~o~You must be in a vehicle to delete it." )
        end 
    end 
end)

RegisterNetEvent('TAC')
AddEventHandler('TAC', function(source)
    tvRP.toggleNoclip()
end)

RegisterKeyMapping('noclip', 'Noclip', 'keyboard', 'F4')       
RegisterCommand('noclip', function(source, args, RawCommand)
    TriggerServerEvent('VRP:noClip')
end)


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