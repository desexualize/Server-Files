-- Menu state
local showMenu = false                 

local Entity, farCoordsX, farCoordsY, farCoordsZ = nil,nil,nil,nil
local EntityType = nil
local crosshairStatus = false

-- Keybind Lookup table
local keybindControls = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18, ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182, ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81, ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178, ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173, ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local MAX_MENU_ITEMS = 7

function playerIsAlive()
    return GetEntityHealth(PlayerPedId()) > 102
end

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


-- Main thread
CreateThread(function()
    local keyBind = "E"
    local inCarBind = "F1"
    while true do
        Wait(1)
        if IsControlPressed(1, keybindControls[keyBind]) and GetLastInputMethod(2) and showMenu then

            showMenu = false
            SetNuiFocus(false, false)
        end
        hit, coords, Entity = GetPlayerInCamera(6.0)
        EntityType = GetEntityType(Entity)
        if EntityType then
            local playerPed = PlayerPedId()
            local playerVehicle = GetVehiclePedIsIn(playerPed,false)
            if playerIsAlive() and playerVehicle == 0 then
                if EntityType == 1 and Entity ~= playerPed and IsPedAPlayer(Entity) then
                    Crosshair(true)
                    if IsDisabledControlPressed(0, keybindControls[keyBind]) and GetLastInputMethod(2) and not showMenu then
                        Crosshair(false)
                        TriggerServerEvent("ERP:PoliceCheck")
                        TriggerServerEvent("ERP:NHSCheck")
                        showMenu = true
                        local enabledMenus = {}
                        for _, menuConfig in ipairs(rootMenuConfig) do
                            if menuConfig:enableMenu() then
                                local dataElements = {}
                                local hasSubMenus = false
                                if menuConfig.subMenus ~= nil and #menuConfig.subMenus > 0 then
                                    txt = "~y~To Exit Menu Use Exit Button In One Of The Sub Menus"
                                    TriggerEvent("ERPCli:Notify", txt)
                                    hasSubMenus = true
                                    local previousMenu = dataElements
                                    local currentElement = {}
                                    for i = 1, #menuConfig.subMenus do
                                        if newSubMenus[menuConfig.subMenus[i]] ~= nil and newSubMenus[menuConfig.subMenus[i]].enableMenu ~= nil and not newSubMenus[menuConfig.subMenus[i]]:enableMenu() then
                                            else
                                            currentElement[#currentElement+1] = newSubMenus[menuConfig.subMenus[i]]
                                            currentElement[#currentElement].id = menuConfig.subMenus[i]
                                            currentElement[#currentElement].enableMenu = nil
                
                                            if i % MAX_MENU_ITEMS == 0 and i < (#menuConfig.subMenus - 1) then
                                                previousMenu[MAX_MENU_ITEMS + 1] = {
                                                    id = "_more",
                                                    title = "More",
                                                    icon = "#more",
                                                    items = currentElement
                                                }
                                                previousMenu = currentElement
                                                currentElement = {}
                                            end
                                        end
                                    end
                                    if #currentElement > 0 then
                                        previousMenu[MAX_MENU_ITEMS + 1] = {
                                            id = "_more",
                                            title = "More",
                                            icon = "#more",
                                            items = currentElement
                                        }
                                    end
                                    dataElements = dataElements[MAX_MENU_ITEMS + 1].items

                                end
                                enabledMenus[#enabledMenus+1] = {
                                    id = menuConfig.id,
                                    title = menuConfig.displayName,
                                    functionName = menuConfig.functionName,
                                    icon = menuConfig.icon,
                                }
                                if hasSubMenus then
                                    enabledMenus[#enabledMenus].items = dataElements
                                end
                            end
                        end
                        SendNUIMessage({
                            state = "show",
                            resourceName = GetCurrentResourceName(),
                            data = enabledMenus,
                            menuKeyBind = keyBind
                        })
                        SetCursorLocation(0.5, 0.5)
                        SetNuiFocus(true, true)

                        -- Play sound
                        PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1)


                        while showMenu == true do Wait(100) end
                        Wait(100)
                        while IsDisabledControlPressed(0, keybindControls[keyBind]) and GetLastInputMethod(2) do Wait(100) end
                    end
                else
                    if EntityType == 2 and Entity ~= playerPed then
                        Crosshair(true)
                        if IsDisabledControlPressed(0, keybindControls[keyBind]) and GetLastInputMethod(2) and not showMenu then
                            Crosshair(false)
                            TriggerServerEvent("ERP:PoliceCheck")
                            TriggerServerEvent("ERP:NHSCheck")
                            showMenu = true
                            local enabledCarMenus = {}
                            for _, menuConfig in ipairs(rootCarMenuConfig) do
                                if menuConfig:enableMenu() then
                                    local dataElements = {}
                                    local hasSubMenus = false
                                    if menuConfig.subMenus ~= nil and #menuConfig.subMenus > 0 then
                                        hasSubMenus = true
                                        local previousMenu = dataElements
                                        local currentElement = {}
                                        for i = 1, #menuConfig.subMenus do
                                            if newSubMenus[menuConfig.subMenus[i]] ~= nil and newSubMenus[menuConfig.subMenus[i]].enableMenu ~= nil and not newSubMenus[menuConfig.subMenus[i]]:enableMenu() then
                                                else
                                                currentElement[#currentElement+1] = newSubMenus[menuConfig.subMenus[i]]
                                                currentElement[#currentElement].id = menuConfig.subMenus[i]
                                                currentElement[#currentElement].enableMenu = nil
                    
                                                if i % MAX_MENU_ITEMS == 0 and i < (#menuConfig.subMenus - 1) then
                                                    previousMenu[MAX_MENU_ITEMS + 1] = {
                                                        id = "_more",
                                                        title = "More",
                                                        icon = "#more",
                                                        items = currentElement
                                                    }
                                                    previousMenu = currentElement
                                                    currentElement = {}
                                                end
                                            end
                                        end
                                        if #currentElement > 0 then
                                            previousMenu[MAX_MENU_ITEMS + 1] = {
                                                id = "_more",
                                                title = "More",
                                                icon = "#more",
                                                items = currentElement
                                            }
                                        end
                                        dataElements = dataElements[MAX_MENU_ITEMS + 1].items
    
                                    end
                                    enabledCarMenus[#enabledCarMenus+1] = {
                                        id = menuConfig.id,
                                        title = menuConfig.displayName,
                                        functionName = menuConfig.functionName,
                                        icon = menuConfig.icon,
                                    }
                                    if hasSubMenus then
                                        enabledCarMenus[#enabledCarMenus].items = dataElements
                                    end
                                end
                            end
                            SendNUIMessage({
                                state = "show",
                                resourceName = GetCurrentResourceName(),
                                data = enabledCarMenus,
                                menuKeyBind = keyBind
                            })
                            SetCursorLocation(0.5, 0.5)
                            SetNuiFocus(true, true)
                            txt = "~y~To Exit Menu Use Exit Button In One Of The Sub Menus"
                            TriggerEvent("ERPCli:Notify", txt)
    
                            -- Play sound
                            PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1)
    
    
                            while showMenu == true do Wait(100) end
                            Wait(100)
                            while IsDisabledControlPressed(0, keybindControls[keyBind]) and GetLastInputMethod(2) do Wait(100) end
                        end
                    end
                end
            elseif IsPedInAnyVehicle(PlayerPedId()) then
                if 1 == 1 then
                    Crosshair(true)
                    if IsDisabledControlPressed(0, keybindControls[inCarBind]) and GetLastInputMethod(2) and not showMenu then
                        Crosshair(false)
                        TriggerServerEvent("ERP:PoliceCheck")
                        TriggerServerEvent("ERP:NHSCheck")
                        showMenu = true
                        carMenu = true
                        local enabledMenus = {}
                        for _, menuConfig in ipairs(rootInCarMenuConfig) do
                            if menuConfig:enableMenu() then
                                local dataElements = {}
                                local hasSubMenus = false
                                if menuConfig.subMenus ~= nil and #menuConfig.subMenus > 0 then
                                    txt = "~y~To Exit Menu Use Exit Button In One Of The Sub Menus"
                                    TriggerEvent("ERPCli:Notify", txt)
                                    hasSubMenus = true
                                    local previousMenu = dataElements
                                    local currentElement = {}
                                    for i = 1, #menuConfig.subMenus do
                                        if newSubMenus[menuConfig.subMenus[i]] ~= nil and newSubMenus[menuConfig.subMenus[i]].enableMenu ~= nil and not newSubMenus[menuConfig.subMenus[i]]:enableMenu() then
                                            else
                                            currentElement[#currentElement+1] = newSubMenus[menuConfig.subMenus[i]]
                                            currentElement[#currentElement].id = menuConfig.subMenus[i]
                                            currentElement[#currentElement].enableMenu = nil
                
                                            if i % MAX_MENU_ITEMS == 0 and i < (#menuConfig.subMenus - 1) then
                                                previousMenu[MAX_MENU_ITEMS + 1] = {
                                                    id = "_more",
                                                    title = "More",
                                                    icon = "#more",
                                                    items = currentElement
                                                }
                                                previousMenu = currentElement
                                                currentElement = {}
                                            end
                                        end
                                    end
                                    if #currentElement > 0 then
                                        previousMenu[MAX_MENU_ITEMS + 1] = {
                                            id = "_more",
                                            title = "More",
                                            icon = "#more",
                                            items = currentElement
                                        }
                                    end
                                    dataElements = dataElements[MAX_MENU_ITEMS + 1].items

                                end
                                enabledMenus[#enabledMenus+1] = {
                                    id = menuConfig.id,
                                    title = menuConfig.displayName,
                                    functionName = menuConfig.functionName,
                                    icon = menuConfig.icon,
                                }
                                if hasSubMenus then
                                    enabledMenus[#enabledMenus].items = dataElements
                                end
                            end
                        end
                        SendNUIMessage({
                            state = "show",
                            resourceName = GetCurrentResourceName(),
                            data = enabledMenus,
                            menuKeyBind = keyBind
                        })
                        SetCursorLocation(0.5, 0.5)
                        SetNuiFocus(true,true)

                        -- Play sound
                        PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1)


                        while showMenu == true do Wait(100) end
                        Wait(100)
                        while IsDisabledControlPressed(0, keybindControls[keyBind]) and GetLastInputMethod(2) do Wait(100) end
                    end
                end
            end
        end
    end
end)





RegisterCommand("closemenu", function()
    showMenu = false
    SetNuiFocus(false, false)
    SendNUIMessage({
        state = 'destroy'
    })
end)




function GetPlayerInCamera(distance)
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

-- Callback function for closing menu
RegisterNUICallback('closemenu', function(data, cb)
    -- Clear focus and destroy UI
    showMenu = false
    SetNuiFocus(false, false)
    SendNUIMessage({
        state = 'destroy'
    })

    -- Play sound
    PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1)

    -- Send ACK to callback function
    cb('ok')
end)

-- Callback function for when a slice is clicked, execute command
RegisterNUICallback('triggerAction', function(data, cb)
    -- Clear focus and destroy UI
    showMenu = false
    SetNuiFocus(false, false)
    SendNUIMessage({
        state = 'destroy'
    })


    -- Play sound
    PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1)

    -- Run command
    --ExecuteCommand(data.action)
    TriggerEvent(data.action, data.parameters)
    TriggerServerEvent(data.action, data.parameters)

    -- Send ACK to callback function
    cb('ok')

end)

RegisterNetEvent("menu:menuexit")
AddEventHandler("menu:menuexit", function()
    showMenu = false
    SetNuiFocus(false, false)
end)


RegisterNetEvent("police:impound")
AddEventHandler("police:impound",function()
    local ped = GetPlayerPed( -1 )
    if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
        local pos = GetEntityCoords( ped )

        if ( IsPedSittingInAnyVehicle( ped ) ) then 
            local vehicle = GetVehiclePedIsIn( ped, false )

            if ( GetPedInVehicleSeat( vehicle, -1 ) == ped ) then 
                DeleteGivenVehicle( vehicle, numRetries )
            else 
            end 
        end 
    end 
end)

function DeleteGivenVehicle( veh, timeoutMax )
    local timeout = 0 
    SetEntityAsMissionEntity( veh, true, true )
    DeleteVehicle( veh )
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
