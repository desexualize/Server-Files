vRP = Proxy.getInterface("vRP")

local inventoryOpen = false; 
local debug = false;
local BootCar = nil;
local VehTypeC = nil;
local VehTypeA = nil;
local IsLootBagOpening = false;
local inventoryType = nil;
local NearLootBag = false; 
local LootBagID = nil;
local LootBagIDNew = nil;
local LootBagCoords = nil;
PlayerInComa = false;
local model = GetHashKey('xs_prop_arena_bag_01') -- change this to whatever prop you would like loot bags to be
tvRP = Proxy.getInterface("vRP")

RegisterNetEvent('openBoot')
AddEventHandler('openBoot', function()
    local nearestVeh = vRP.getNearestVehicle({3})
    local VehInRadius, VehType, NVeh = tvRP.getNearestOwnedVehicle({3.5})
    if VehInRadius and IsPedInAnyVehicle(GetPlayerPed(-1), false) == false then 
        ExecuteCommand('inventory')
        BootCar = GetEntityCoords(PlayerPedId())
        VehTypeC = VehType
        VehTypeA = NVeh


        tvRP.vc_openDoor({VehTypeC, 5})
        inventoryType = 'CarBoot'
        TriggerServerEvent('Inventory:FetchTrunkInventory', NVeh, NetworkGetNetworkIdFromEntity(nearestVeh))
    else
        notify("~r~This is not your Vehicle!")
    end
end)

local LootBagCrouchLoop = false;
RegisterCommand('inventory', function()
    if not tvRP.isInComa({}) then
        if not inventoryOpen then
            TriggerServerEvent('Inventory:FetchPersonalInventory')
            inventoryOpen = true; 
            SetNuiFocus(true, true)
            SetNuiFocusKeepInput(true)
            SendNUIMessage({action = 'InventoryDisplay', showInv = true})

        else
            inventoryOpen = false;
            SetNuiFocus(false, false)
            SetNuiFocusKeepInput(false)
            SendNUIMessage({action = 'InventoryDisplay', showInv = false})
            inventoryType = nil;
            if BootCar then
                tvRP.vc_closeDoor({VehTypeC, 5})
                BootCar = nil;
                VehTypeC = nil;
                VehTypeA = nil;
            end
            if IsLootBagOpening then
                if debug then 
                    print('Requested lootbag to close.')
                end
                TriggerServerEvent('Inventory:CloseLootbag')
                IsLootBagOpening = false;
                ResetPedMovementClipset(PlayerPedId(), 0.30 )
                LootBagCrouchLoop = false;
                FreezeEntityPosition(PlayerPedId(), false)
            end
        end
    else 
        tvRP.notify({'~r~You cannot open your inventory while dead.'})
    end
end)

RegisterNetEvent("Jud:OpenHomeStorage")
AddEventHandler("Jud:OpenHomeStorage", function(toggle , houseName)
    if toggle == true then
        TriggerServerEvent('Inventory:FetchPersonalInventory')
        inventoryOpen = true; 
        SetNuiFocus(true, true)
        SetNuiFocusKeepInput(true)
        SendNUIMessage({action = 'InventoryDisplay', showInv = true})
        inventoryType = 'Housing'
        TriggerServerEvent('Jud:FetchHouseInventory', houseName)
    else
        inventoryOpen = false;
        SetNuiFocus(false, false)
        SetNuiFocusKeepInput(false)
        SendNUIMessage({action = 'InventoryDisplay', showInv = false})
        inventoryType = nil;
    end
end)

function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
      RequestAnimDict(dict)
      Citizen.Wait(5)
    end
end

RegisterNetEvent('Inventory:InventoryOpen')
AddEventHandler('Inventory:InventoryOpen', function(toggle, lootbag)
    IsLootBagOpening = lootbag
    if IsLootBagOpening then
        LoadAnimDict('amb@medic@standing@kneel@base')
        LoadAnimDict('anim@gangops@facility@servers@bodysearch@')
        TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
        TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )
        FreezeEntityPosition(PlayerPedId(), true)
        LootBagCrouchLoop = true;
    end
    if toggle then
        inventoryOpen = true; 
        SetNuiFocus(true, true)
        SetNuiFocusKeepInput(true)
        SendNUIMessage({action = 'InventoryDisplay', showInv = true})
    else 
        inventoryOpen = false;
        SetNuiFocus(false, false)
        SetNuiFocusKeepInput(false)
        SendNUIMessage({action = 'InventoryDisplay', showInv = false})
    end
end)


RegisterNetEvent('Inventory:ToggleNUIFocus')
AddEventHandler('Inventory:ToggleNUIFocus', function(value)
    SetNuiFocus(value, value)
    SetNuiFocusKeepInput(value)
end)

RegisterNetEvent('Inventory:SendSecondaryInventoryData')
AddEventHandler('Inventory:SendSecondaryInventoryData', function(InventoryData, CurrentKG, MaxKg)
    SendNUIMessage({action = 'loadSecondaryItems', items = InventoryData, CurrentKG = CurrentKG, MaxKG = MaxKg, invType = inventoryType})
    if debug then
        print('Sent secondary inventory data to client.')
    end
end)

RegisterNetEvent('Inventory:FetchPersonalInventory')
AddEventHandler('Inventory:FetchPersonalInventory', function(table, CurrentKG, MaxKG)
    SendNUIMessage({action = 'loadItems', items = table, CurrentKG = CurrentKG, MaxKG = MaxKG})
    if debug then
        print('Sent inventory data to client.')
    end
end)

RegisterNUICallback('UseBtn', function(data, cb)
    TriggerServerEvent('Inventory:UseItem', data.itemId, data.invType)
    cb(true);
    PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
end)

RegisterNUICallback('TrashBtn', function(data, cb)
    TriggerServerEvent('Inventory:TrashItem', data.itemId, data.invType)
    cb(true);
    PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
end)

RegisterNUICallback('GiveBtn', function(data, cb)
    TriggerServerEvent('Inventory:GiveItem', data.itemId, data.invType)
    cb(true)
    PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
end)


RegisterNUICallback('MoveBtn', function(data, cb)
    if not IsLootBagOpening then
        if inventoryType == 'CarBoot' then
            TriggerServerEvent('Inventory:MoveItem', data.invType, data.itemId, VehTypeA) -- for vehicle
        elseif inventoryType == "Housing" then
            TriggerServerEvent('Inventory:MoveItem', data.invType, data.itemId, "home") -- for housing
        end
    else 
        TriggerServerEvent('Inventory:MoveItem', 'LootBag', data.itemId, LootBagIDNew)
    end
    PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
    cb(true)
end)

RegisterNUICallback('MoveXBtn', function(data, cb)
    if not IsLootBagOpening then
        if inventoryType == 'CarBoot' then
            TriggerServerEvent('Inventory:MoveItemX', data.invType, data.itemId, VehTypeA) -- for vehicle
        elseif inventoryType == "Housing" then
            TriggerServerEvent('Inventory:MoveItemX', data.invType, data.itemId, "home") -- for housing
        end
    else 
        TriggerServerEvent('Inventory:MoveItemX', 'LootBag', data.itemId, LootBagIDNew)
    end
    PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
    cb(true)
end)


RegisterNUICallback('MoveAllBtn', function(data, cb)
    if not IsLootBagOpening then
        local nearestVeh2 = vRP.getNearestVehicle({3})
        if inventoryType == 'CarBoot' then
            TriggerServerEvent('Inventory:MoveItemAll', data.invType, data.itemId, VehTypeA, NetworkGetNetworkIdFromEntity(nearestVeh2)) -- for vehicle
        elseif inventoryType == "Housing" then
            TriggerServerEvent('Inventory:MoveItemAll', data.invType, data.itemId, "home") -- for housing
        end
    else 
        TriggerServerEvent('Inventory:MoveItemAll', 'LootBag', data.itemId, LootBagIDNew)
    end
    PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
    cb(true)
end)



Citizen.CreateThread(function()
    while true do
        Wait(0)
        if inventoryOpen then
            DisableControlAction(0, 1, true)
            DisableControlAction(0, 2, true)
            DisableControlAction(0, 4, true)
            DisableControlAction(0, 3, true)
            DisableControlAction(0, 37, true)
            DisableControlAction(0, 7, true)
            DisableControlAction(0, 212, true)
            DisableControlAction(0, 80, true)
            DisableControlAction(0, 25, true)
            DisableControlAction(0, 45, true)
            DisableControlAction(0, 47, true)
            DisableControlAction(0, 58, true)
            DisableControlAction(0, 263, true)
            DisableControlAction(0, 264, true)
            DisableControlAction(0, 257, true)
            DisableControlAction(0, 311, true)
            DisableControlAction(0, 140, true)
            DisableControlAction(0, 141, true)
            DisableControlAction(0, 142, true)
            DisableControlAction(0, 170, true)
            DisableControlAction(0, 143, true)
            DisableControlAction(0, 75, true)
            DisableControlAction(27, 75, true)
            DisableControlAction(0, 22, true)
            DisableControlAction(0, 25, true)
            DisableControlAction(0, 140, true)
            DisablePlayerFiring(PlayerPedId(), true)
        end
    end
end)

Citizen.CreateThread(function()
    while true do 
        Wait(250)
        if BootCar then
            if #(BootCar - GetEntityCoords(PlayerPedId())) > 8.0 then 
                inventoryOpen = false;
                SetNuiFocus(false, false)
                SetNuiFocusKeepInput(false)
                SendNUIMessage({action = 'InventoryDisplay', showInv = false})
                tvRP.vc_closeDoor({VehTypeC, 5})
                BootCar = nil;
                VehTypeC = nil;
                VehTypeA = nil;
                inventoryType = nil;
            end
        end
        if inventoryOpen then
            if tvRP.isInComa({}) then
                inventoryOpen = false;
                SetNuiFocus(false, false)
                SetNuiFocusKeepInput(false)
                SendNUIMessage({action = 'InventoryDisplay', showInv = false})
                inventoryType = nil;
                if BootCar then
                    tvRP.vc_closeDoor({VehTypeC, 5})
                    BootCar = nil;
                    VehTypeC = nil;
                    VehTypeA = nil;
                end
            end
        end
    end
end)

RegisterKeyMapping('inventory', 'Opens / Closes your inventory', 'keyboard', 'L')

-- LOOT BAG CODE BELOW 


AddEventHandler('vRP:IsInComa', function(coma)
    PlayerInComa = coma;
    if coma then 
        LootBagCoords = false;
        NearLootBag = false; 
        LootBagID = nil;
    end
end)

Citizen.CreateThread(function()
    while true do 
        Wait(250)
        if not PlayerInComa then
            local coords = GetEntityCoords(PlayerPedId())
            if DoesObjectOfTypeExistAtCoords(coords, 2.5, model, true) then
                if not NearLootBag then
                    NearLootBag = true;
                    LootBagID = GetClosestObjectOfType(coords, 2.5, model, false, false, false)
                    LootBagIDNew = ObjToNet(LootBagID)
                    LootBagCoords = GetEntityCoords(LootBagID)
                end
            else 
                LootBagCoords = false;
                NearLootBag = false; 
                LootBagID = nil;
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do 
        Wait(0)
        if NearLootBag then
            local coords = GetEntityCoords(PlayerPedId())
            hit2, coords2, Entity2 = RayCastGamePlayCamera(6.0)
            EntityType2 = GetEntityType(Entity2)

            if EntityType2 then
                if IsPedInAnyVehicle(GetPlayerPed(-1), false) == false then
                    if EntityType2 == 3 then
                        local entityModel = GetEntityModel(Entity2)
                        if model == entityModel then
                            if IsControlJustReleased(1, 38) then
                                LootBagID = GetClosestObjectOfType(coords, 2.5, model, false, false, false)
                                LootBagIDNew = ObjToNet(LootBagID)
                                TriggerServerEvent('vRP:LootBag', LootBagIDNew)
                                Wait(1000)
                            end
                        end
                    end
                end
            end
        end
    end
end)

function notify(string)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(string)
    DrawNotification(true, false)
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

--- [Lootbags]

RegisterNetEvent("anim")
AddEventHandler("anim", function()
    LoadAnimDict('amb@medic@standing@kneel@base')
    LoadAnimDict('anim@gangops@facility@servers@bodysearch@')
    TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
    TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )
end)

function Draw3DText(coords, text)
    local x,y,z = table.unpack(coords)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.32, 0.32)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 80)
end

function getNearestVehicle(radius)
    local x,y,z = vRP.getPosition()
    local ped =PlayerPedId()
    if IsPedSittingInAnyVehicle(ped) then
      return GetVehiclePedIsIn(ped, true)
    else
      -- flags used:
      --- 8192: boat
      --- 4096: helicos
      --- 4,2,1: cars (with police)
  
      local veh = GetClosestVehicle(x+0.0001,y+0.0001,z+0.0001, radius+0.0001, 0, 8192+4096+4+2+1)  -- boats, helicos
      if not IsEntityAVehicle(veh) then veh = GetClosestVehicle(x+0.0001,y+0.0001,z+0.0001, radius+0.0001, 0, 4+2+1) end -- cars
      return veh
    end
  end


