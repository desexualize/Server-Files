local LootBagIDNew = nil;
local MoneydropIDNew = nil;
local Entity, farCoordsX, farCoordsY, farCoordsZ = nil,nil,nil,nil
local EntityType = nil
local crosshairStatus = false
local model = GetHashKey('prop_poly_bag_money')

RegisterNetEvent('Crosshair')
AddEventHandler('Crosshair', function(enable)
    if not crosshairStatus and enable then
        crosshairStatus = true
        SendNUIMessage({
            crosshair = enable
        })
    elseif crosshairStatus and not enable then
        crosshairStatus = false
        SendNUIMessage({
            crosshair = enable
        })
    end
end)

function Crosshair(enable)
    if not crosshairStatus and enable then
        crosshairStatus = true
        SendNUIMessage({
            crosshair = enable
        })
    elseif crosshairStatus and not enable then
        crosshairStatus = false
        SendNUIMessage({
            crosshair = enable
        })
    end
end

function RotationToDirection(rotation)
	local adjustedRotation = 
	{ 
		x = (math.pi / 180) * rotation.x, 
		y = (math.pi / 180) * rotation.y, 
		z = (math.pi / 180) * rotation.z 
	}
	local direction = 
	{
		x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), 
		y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), 
		z = math.sin(adjustedRotation.x)
	}
	return direction
end

function RayCastGamePlayCamera(distance)
	local cameraRotation = GetGameplayCamRot()
	local cameraCoord = GetGameplayCamCoord()
	local direction = RotationToDirection(cameraRotation)
	local destination = 
	{ 
		x = cameraCoord.x + direction.x * distance, 
		y = cameraCoord.y + direction.y * distance, 
		z = cameraCoord.z + direction.z * distance 
	}
	local a, b, c, d, e = GetShapeTestResult(StartShapeTestRay(cameraCoord.x, cameraCoord.y, cameraCoord.z, destination.x, destination.y, destination.z, -1, -1, 1))
	return b, c, e
end

function playerIsAlive()
    return GetEntityHealth(PlayerPedId()) > 102
end


Citizen.CreateThread(function()
    while true do
        hit, coords, Entity = RayCastGamePlayCamera(6.0)
        EntityType = GetEntityType(Entity)

        if EntityType then
            local playerPed = PlayerPedId()
            local playerVehicle = GetVehiclePedIsIn(playerPed,false)

            if playerIsAlive() and playerVehicle == 0 then
                if EntityType == 3 then
                    local entityModel = GetEntityModel(Entity)
                    local coords = GetEntityCoords(PlayerPedId())
                        if `prop_poly_bag_money` == entityModel then
                            Crosshair(true)
                            if IsControlJustReleased(1, 38) then
                            
                                local MoneydropID = GetClosestObjectOfType(coords, 10.5, GetHashKey('prop_poly_bag_money'), false, false, false)
                                local MoneydropIDNew = ObjToNet(MoneydropID)
                                TriggerServerEvent('vRP:Moneydrop', MoneydropIDNew)
                                Wait(1000)
                            end
                        end
                    
                else
                    Crosshair(false)
                end
            else
                Crosshair(false)
            end
        end
        Citizen.Wait(0)
	end
end)

function notify(string)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(string)
    DrawNotification(true, false)
end

function GetCoordsFromCam(distance)
    local rot = GetGameplayCamRot(2)
    local coord = GetGameplayCamCoord()

    local tZ = rot.z * 0.0174532924
    local tX = rot.x * 0.0174532924
    local num = math.abs(math.cos(tX))

    newCoordX = coord.x + (-math.sin(tZ)) * (num + distance)
    newCoordY = coord.y + (math.cos(tZ)) * (num + distance)
    newCoordZ = coord.z + (math.sin(tX) * 8.0)
    return newCoordX, newCoordY, newCoordZ
end

function Target(Distance, Ped)
    local Entity = nil
    local camCoords = GetGameplayCamCoord()
    local farCoordsX, farCoordsY, farCoordsZ = GetCoordsFromCam(Distance)
    local RayHandle = StartShapeTestRay(camCoords.x, camCoords.y, camCoords.z, farCoordsX, farCoordsY, farCoordsZ, -1, Ped, 0)
    local A,B,C,D,Entity = GetRaycastResult(RayHandle)
    return Entity, farCoordsX, farCoordsY, farCoordsZ
end