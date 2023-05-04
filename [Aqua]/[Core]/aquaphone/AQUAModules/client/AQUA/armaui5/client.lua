local showMenu = false
local Entity = nil
local EntityType = nil
local crosshairStatus = false
local shapeTestHandle = 0
local globalOnPoliceDuty = false
local globalOnNHSDuty = false
local globalOnPrisonDuty = false
local hideHud = false
local draggedPed = 0

RegisterNetEvent("ARMA:showHUD")
AddEventHandler("ARMA:showHUD",function(flag)
    hideHud = not flag
end)

function Crosshair(enable)
    if hideHud then
        SendNUIMessage({
            crosshair = false
        })
    else
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
end

RegisterNUICallback('disablenuifocus', function(data)
    showMenu = data.nuifocus
    SetNuiFocus(data.nuifocus, data.nuifocus)
end)

local rad = math.rad
local cos = math.cos
local sin = math.sin
local abs = math.abs

local function rotationToDirection(rotation)
    local x = rad(rotation.x)
    local z = rad(rotation.z)
    return vector3(-sin(z) * abs(cos(x)), cos(z) * abs(cos(x)), sin(x))
end

local function getDraggedPed()
    local localPlayerPed = PlayerPedId()
    for _, playerIndex in pairs(GetActivePlayers()) do
        local playerPed = GetPlayerPed(playerIndex)
        if GetEntityAttachedTo(playerPed) == localPlayerPed then
            return playerPed
        end
    end
    return 0
end

local function updateShapeTest()
    local result, _, _, _, entity = GetShapeTestResult(shapeTestHandle)
    if result ~= 1 then -- Not Pending
        if result == 2 then -- Complete
            if #(GetEntityCoords(PlayerPedId(), true) - GetEntityCoords(entity, true)) <= 3.5 then
                Entity = entity
                EntityType = GetEntityType(entity)
            else
                Entity = nil
                EntityType = nil
            end
            draggedPed = getDraggedPed()
        end

        local cameraRotation = GetGameplayCamRot()
        local cameraCoord = GetGameplayCamCoord()
        local direction = rotationToDirection(cameraRotation)
        local destination = vector3(cameraCoord.x + direction.x * 15.0, cameraCoord.y + direction.y * 15.0, cameraCoord.z + direction.z * 15.0)
        shapeTestHandle = StartShapeTestLosProbe(cameraCoord.x, cameraCoord.y, cameraCoord.z, destination.x, destination.y, destination.z, -1, -1, 1)
    end
end

function playerIsAlive()
    return GetEntityHealth(PlayerPedId()) > 102
end

Citizen.CreateThread(function()
    while true do
        updateShapeTest()
        local playerPed = PlayerPedId()
        local playerVehicle = GetVehiclePedIsIn(playerPed,false)

        if showMenu and playerVehicle ~= 0 then
            showMenu = false
            SendNUIMessage({
                closeMenu = true
            })
        end

        if EntityType then
            if playerIsAlive() and playerVehicle == 0 then
                if EntityType == 1 and Entity ~= playerPed and IsPedAPlayer(Entity) then
                    Crosshair(true)
                    if IsControlJustReleased(1, 38) then
                        if showMenu == false then
                            showMenu = true
                            SetNuiFocus(true, true)
                            SendNUIMessage({
                                openMenu = true,
                                type = "ped",
                                police = globalOnPoliceDuty or globalOnPrisonDuty,
                                entityId = Entity
                            })
                        end
                    end
                elseif EntityType == 2 and Entity ~= playerVehicle then
                    Crosshair(true)
                    if IsControlJustReleased(1, 38) then
                        if showMenu == false then
                            showMenu = true
                            SetNuiFocus(true, true)
                            SendNUIMessage({
                                openMenu = true,
                                type = "vehicle",
                                police = globalOnPoliceDuty or globalOnPrisonDuty,
                                entityId = Entity
                            })
                        end
                    end
                elseif EntityType == 3 then
                    local entityModel = GetEntityModel(Entity)
                    if `xs_prop_arena_bag_01` == entityModel then
                        Crosshair(true)
                        if IsControlJustReleased(1, 38) then
                            local LootBagID = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 10.5, GetHashKey('xs_prop_arena_bag_01'), false, false, false)
                            local LootBagIDNew = ObjToNet(LootBagID)
                            local LootBagCoords = GetEntityCoords(LootBagID)
                            TriggerServerEvent('ARMA:LootBag', LootBagIDNew)
                            TriggerEvent("ARMA:startCombatTimer", false)
                            Wait(1000)
                        end
                    elseif `prop_poly_bag_money` == entityModel then
                        Crosshair(true)
                        if IsControlJustReleased(1, 38) then
                            local MoneydropID = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 10.5, GetHashKey('prop_poly_bag_money'), false, false, false)
                            local MoneydropIDNew = ObjToNet(MoneydropID)
                            TriggerServerEvent('ARMA:Moneydrop', MoneydropIDNew)
                            TriggerEvent("ARMA:startCombatTimer", false)
                            Wait(1000)
                        end
                    elseif `prop_box_ammo03a` == entityModel then
                        Crosshair(true)
                        if IsControlJustReleased(1, 38) then
                           -- code for looting loot boxes br
                        end
                    elseif `xs_prop_arena_crate_01a` == entityModel then
                        Crosshair(true)
                        if IsControlJustReleased(1, 38) then
                            local id = DecorGetInt(Entity,"lootid")
                            TriggerEvent("ARMA:startCombatTimer", false)
                            TriggerServerEvent("ARMA:openCrate",id)
                            Wait(1000)
                        end
                    end
                else
                    Crosshair(false)
                end
            else
                Crosshair(false)
            end
        else
            Crosshair(false)
        end

        if not crosshairStatus and draggedPed ~= 0 and IsControlPressed(0, 19) and IsControlJustPressed(0, 38) then -- INPUT_CHARACTER_WHEEL (LEFT ALT) + INPUT_PICKUP (E)
            SetNuiFocus(true, true)
            SendNUIMessage({
                openMenu = true,
                type = "ped",
                police = globalOnPoliceDuty or globalOnPrisonDuty,
                entityId = draggedPed
            })
        end

        Citizen.Wait(0)
	end
end)

function GetEntInFrontOfPlayer(Distance, Ped)
    local Ent = nil
    local CoA = GetEntityCoords(Ped, 1)
    local CoB = GetOffsetFromEntityInWorldCoords(Ped, 0.0, Distance, 0.0)
    local RayHandle = StartShapeTestRay(CoA.x, CoA.y, CoA.z, CoB.x, CoB.y, CoB.z, -1, Ped, 0)
    local A,B,C,D,Ent = GetShapeTestResult(RayHandle)
    return Ent
end

-- Camera's coords
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

-- Get entity's ID and coords from where player is targeting
function Target(Distance, Ped)
    local Entity = nil
    local camCoords = GetGameplayCamCoord()
    local farCoordsX, farCoordsY, farCoordsZ = GetCoordsFromCam(Distance)
    local RayHandle = StartShapeTestRay(camCoords.x, camCoords.y, camCoords.z, farCoordsX, farCoordsY, farCoordsZ, -1, Ped, 0)
    --DrawLine(camCoords.x, camCoords.y, camCoords.z, farCoordsX, farCoordsY, farCoordsZ,255,0,0,255)
    local A,B,C,D,Entity = GetShapeTestResult(RayHandle)
    return Entity, farCoordsX, farCoordsY, farCoordsZ
end

function loadAnimDict(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(0)
	end
end

function lockCar(entityId)
    TriggerEvent("ARMA:lockNearestVehicle")
end

local savedBoot

function openBoot(entityId)
    savedBoot = entityId
    SetVehicleDoorOpen(entityId, 5, true)
    TriggerEvent("ARMA:clOpenTrunk")
    trunkStatus = true
    SendNUIMessage({
        closeMenu = true
    })
    local soundId = GetSoundId()
    PlaySoundFrontend(soundId,"boot_pop","dlc_vw_body_disposal_sounds",true)
    ReleaseSoundId(soundId)
end

RegisterNetEvent("ARMA:clCloseTrunk")
AddEventHandler("ARMA:clCloseTrunk",function()
    if savedBoot then
        SetVehicleDoorShut(savedBoot, 5, true)
    end
end)

function cleanCar(entityId)
    local playerPed = PlayerPedId()
    if GetEntityHealth(playerPed) > 102 and not IsEntityDead(playerPed) then
		TaskStartScenarioInPlace(playerPed, 'world_human_maid_clean', 0, 1)
		Wait(10000)
		SetVehicleDirtLevel(entityId, 0.0)
		SetVehicleUndriveable(entityId, false)
		ClearPedSecondaryTask(playerPed)
		ClearPedTasks(playerPed)
	end
end

function lockpick(entityId)
    TriggerEvent("ARMA:verifyLockpick",entityId)
end

function repairVehicle(entityId)
    TriggerServerEvent("ARMA:attemptRepairVehicle")
end

local hoodStatus = false

function openHood(entityId)
    if not hoodStatus then
        SetVehicleDoorOpen(entityId, 4, false)
        hoodStatus = true
    else
        SetVehicleDoorShut(entityId, 4, false)
        hoodStatus = false
    end
end

function searchVehicle(entityId)
    if globalOnPoliceDuty then
        TriggerEvent("ARMA:searchClient",entityId)
    end
end

function impoundVehicle(entityId)
    if globalOnPoliceDuty then
        local user_id = tonumber(DecorGetInt(entityId, "AQUA_owner"))
        if user_id > 0 then
            exports.arma:impound(user_id, GetEntityModel(entityId), VehToNet(entityId), entityId)
        else
            TriggerEvent("ARMA:Notify","~r~Vehicle is not owned by anyone")
            if GetPedInVehicleSeat(entityId, -1) == 0 and GetPedInVehicleSeat(entityId, 0) == 0 and NetworkGetEntityIsNetworked(entityId) then
                TriggerServerEvent("ARMA:impoundDeleteVehicle", NetworkGetNetworkIdFromEntity(entityId))
            end
        end
    end
end

function robPerson(entityId)
    local player = GetPlayerByEntityID(entityId)
    local playerSrc = GetPlayerServerId(player)
    if playerSrc > 0 then
        if GetSelectedPedWeapon(PlayerPedId()) ~= GetHashKey("WEAPON_UNARMED") then
            TriggerServerEvent("ARMA:robPlayer",playerSrc)
        else
            TriggerEvent("ARMA:Notify","~r~You need a weapon in your hands.")
        end
    end
end

function askId(entityId)
    local player = GetPlayerByEntityID(entityId)
    local playerSrc = GetPlayerServerId(player)
    if playerSrc > 0 then
        TriggerServerEvent("ARMA:askId",playerSrc)
    end
end

function askDriverId(entityId)
    local ped = GetPedInVehicleSeat(entityId, -1)
    if ped ~= 0 then
        local player = GetPlayerByEntityID(ped)
        local playerSrc = GetPlayerServerId(player)
        if playerSrc > 0 then
            TriggerServerEvent("ARMA:askId",playerSrc)
        end
    end
end

function giveCash(entityId)
    local player = GetPlayerByEntityID(entityId)
    local playerSrc = GetPlayerServerId(player)
    if playerSrc > 0 then
        TriggerServerEvent("ARMA:giveCashToPlayer",playerSrc)
    end
end

function searchPlayer(entityId)
    if not exports["arma"]:canAnim() then
        return
    end
    if GetEntityHealth(entityId) <= 102 then
        TriggerEvent("ARMA:Notify","~r~You can not search a player who is dead.")
        return
    end
    local player = GetPlayerByEntityID(entityId)
    if not globalOnPoliceDuty and not globalOnPrisonDuty then
        local ped = GetPlayerPed(player)
        if ped ~= nil then
            if IsEntityPlayingAnim(ped, 'missminuteman_1ig_2', 'handsup_enter', 3) or IsEntityPlayingAnim(ped, "random@arrests", "idle_2_hands_up", 3) or IsEntityPlayingAnim(ped, "random@arrests@busted", "idle_a", 3) then
                local playerSrc = GetPlayerServerId(player)
                if playerSrc > 0 then
                    TriggerServerEvent("ARMA:searchPlayer",playerSrc)
                end
            else
                TriggerEvent("ARMA:Notify","~r~Player must have their hands up or be on their knees!")
            end
        end
    else
        local playerSrc = GetPlayerServerId(player)
        if playerSrc > 0 then
            TriggerServerEvent("ARMA:searchPlayer",playerSrc)
        end
    end
end


function revive(entityId)
    local player = GetPlayerByEntityID(entityId)
    local playerSrc = GetPlayerServerId(player)
    if playerSrc > 0 then
        if globalOnNHSDuty then
            TriggerServerEvent("ARMA:nhsRevive",playerSrc)
        else
            TriggerServerEvent("ARMA:attemptCPR",playerSrc)
        end
    end
end

function handcuff(entityId)
    if globalOnPoliceDuty or globalOnPrisonDuty then
        local player = GetPlayerByEntityID(entityId)
        local playerSrc = GetPlayerServerId(player)
        if playerSrc > 0 then
            ExecuteCommand("cuff")
        end
    end
end

function drag(entityId)
    if globalOnPoliceDuty or globalOnPrisonDuty then
        local player = GetPlayerByEntityID(entityId)
        local playerSrc = GetPlayerServerId(player)
        if playerSrc > 0 then
            TriggerServerEvent("ARMA:dragPlayer",playerSrc)
        end
    end
end

function putInCar(entityId)
    if globalOnPoliceDuty or globalOnPrisonDuty then
        local player = GetPlayerByEntityID(entityId)
        local playerSrc = GetPlayerServerId(player)
        if playerSrc > 0 then
            TriggerServerEvent("ARMA:putInVehicle",playerSrc)
        end
    end
end

local function gunshotTest(entityId)
    local player = GetPlayerByEntityID(entityId)
    local playerSrc = GetPlayerServerId(player)
    if playerSrc > 0 then
        TriggerServerEvent("ARMA:gunshotTest", playerSrc)
    end
end

function jail(entityId) -- need to rewrite jail i'll do it then
    if globalOnPoliceDuty or globalOnPrisonDuty then
        local player = GetPlayerByEntityID(entityId)
        local playerSrc = GetPlayerServerId(player)
        if playerSrc > 0 then
            TriggerServerEvent("ARMA:seizeWeapons",playerSrc)
            TriggerServerEvent("ARMA:jailPlayer",playerSrc)
        end
    end
end

function requestTransport(entityId) -- do later
    if globalOnPoliceDuty or globalOnPrisonDuty then
        local player = GetPlayerByEntityID(entityId)
        local playerSrc = GetPlayerServerId(player)
        if playerSrc > 0 then
            TriggerServerEvent("ARMA:requestTransport",playerSrc)
        end
    end
end

function seizeWeapons(entityId) -- need to check for all weapons except police weapons
    if globalOnPoliceDuty or globalOnPrisonDuty then
        local player = GetPlayerByEntityID(entityId)
        local playerSrc = GetPlayerServerId(player)
        if playerSrc > 0 then
            TriggerServerEvent("ARMA:seizeWeapons",playerSrc)
        end
    end
end

function seizeillegals(entityId) -- need to write drug checks
    if globalOnPoliceDuty or globalOnPrisonDuty then
        local player = GetPlayerByEntityID(entityId)
        local playerSrc = GetPlayerServerId(player)
        if playerSrc > 0 then
            TriggerServerEvent("ARMA:seizeIllegals",playerSrc)
        end
    end
end

RegisterNUICallback("radialClick", function(data)
    local menu = data.itemid
    local entityId = data.entity

    if IsPedInAnyVehicle(PlayerPedId(), true) then
        return
    end

    if menu == "lock" then
        lockCar(entityId)
    elseif menu == "openBoot" then
        openBoot(entityId)
    elseif menu == "cleanCar" then
        cleanCar(entityId)
    elseif menu == "lockpick" then
        lockpick(entityId)
    elseif menu == "repair" then
        repairVehicle(entityId)
    elseif menu == "openHood" then
        openHood(entityId)
    elseif menu == "searchvehicle" then
        searchVehicle(entityId)
    elseif menu == "impoundVehicle" then
        impoundVehicle(entityId)
    elseif menu == "askId" then
        askId(entityId)
    elseif menu == "askDriverId" then
        askDriverId(entityId)
    elseif menu == "giveCash" then
        giveCash(entityId)
    elseif menu == "search" then
        searchPlayer(entityId)
    elseif menu == "robPerson" then
        robPerson(entityId)
    elseif menu == "revive" then
        revive(entityId)
    elseif menu == "handcuff" then
        handcuff(entityId)
    elseif menu == "drag" then
        drag(entityId)
    elseif menu == "putincar" then
        putInCar(entityId)
    elseif menu == "gunshottest" then
        gunshotTest(entityId)
    elseif menu == "jail" then
        jail(entityId)
    elseif menu == "requesttransport" then
        requestTransport(entityId)
    elseif menu == "seizeweapons" then
        seizeWeapons(entityId)
    elseif menu == "seizeillegals" then
        seizeillegals(entityId)
    end
end)

RegisterNetEvent("ARMAUI5:globalOnPoliceDuty")
AddEventHandler("ARMAUI5:globalOnPoliceDuty",function(a)
    globalOnPoliceDuty = a
end)
RegisterNetEvent("ARMAUI5:globalOnNHSDuty")
AddEventHandler("ARMAUI5:globalOnNHSDuty",function(b)
    globalOnNHSDuty = b
end)
RegisterNetEvent("ARMAUI5:globalOnPrisonDuty")
AddEventHandler("ARMAUI5:globalOnPrisonDuty",function(c)
    globalOnPrisonDuty = c
end)

function GetPlayerByEntityID(i)
	for _, id in ipairs(GetActivePlayers()) do
        if i == GetPlayerPed(id) then
            return id
        end
	end
	return nil
end