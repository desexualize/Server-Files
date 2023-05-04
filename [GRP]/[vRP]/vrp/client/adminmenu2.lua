local plrsInServer = {}
local SelectedPerm = nil;
local SelectedGroup = nil;
local pov = false;
local isDevOP = false;
local isEnIO = false;
local Buttons = {}
local MiscBtn = {}
local EntitysDeleted = {}
local Groups = {}
local cfg = module('cfg/admin_menu')
RMenu.Add('vRPAdmin', 'main', RageUI.CreateMenu("", "Galaxy Admin Menu",1300, 50, "adminmenu", "adminmenu"))
RMenu.Add('vRPAdmin', 'players',  RageUI.CreateSubMenu(RMenu:Get("vRPAdmin", "main")))
RMenu.Add('vRPAdmin', 'searchplayers',  RageUI.CreateSubMenu(RMenu:Get("vRPAdmin", "main")))
RMenu.Add('vRPAdmin', 'searchtempids',  RageUI.CreateSubMenu(RMenu:Get("vRPAdmin", "searchplayers")))
RMenu.Add('vRPAdmin', 'searchpermids',  RageUI.CreateSubMenu(RMenu:Get("vRPAdmin", "searchplayers")))
RMenu.Add('vRPAdmin', 'searchnames',  RageUI.CreateSubMenu(RMenu:Get("vRPAdmin", "searchplayers")))
RMenu.Add('vRPAdmin', 'player_selected',  RageUI.CreateSubMenu(RMenu:Get("vRPAdmin", "players")))
RMenu.Add('vRPAdmin', 'groups',  RageUI.CreateSubMenu(RMenu:Get("vRPAdmin", "player_selected")))
RMenu.Add('vRPAdmin', 'groups_manage',  RageUI.CreateSubMenu(RMenu:Get("vRPAdmin", "groups")))
RMenu.Add('vRPAdmin', 'misc',  RageUI.CreateSubMenu(RMenu:Get("vRPAdmin", "main")))
RMenu.Add('vRPAdmin', 'devop',  RageUI.CreateSubMenu(RMenu:Get("vRPAdmin", "main")))
RMenu.Add('vRPAdmin', 'teleport',  RageUI.CreateSubMenu(RMenu:Get("vRPAdmin", "main")))
RMenu.Add('vRPAdmin', 'EntityOptions',  RageUI.CreateSubMenu(RMenu:Get("vRPAdmin", "main")))
RMenu.Add('vRPAdmin', 'EntitysDeleted',  RageUI.CreateSubMenu(RMenu:Get("vRPAdmin", "main")))

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('vRPAdmin', 'main')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
                RageUI.Button("Players", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected) end, RMenu:Get("vRPAdmin", "players"))
                RageUI.Button("Sub Options", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected) end, RMenu:Get("vRPAdmin", "misc"))
                if isEnIO == true then
                    RageUI.Button("Entity Options", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected) end, RMenu:Get("vRPAdmin", "EntityOptions"))
                end
                if isDevOP == true then 
                    RageUI.Button("Dev Options", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected) end, RMenu:Get("vRPAdmin", "devop"))
                end
                RageUI.Button("Search Players", nil, { RightLabel = "→→→"}, true, function(Hovered, Active, Selected) end, RMenu:Get("vRPAdmin", "searchplayers"))
                RageUI.Button("~b~Teleport Options", nil, {RightLabel = "~b~→→→"}, true, function(Hovered, Active, Selected) end, RMenu:Get("vRPAdmin", "teleport"))
                RageUI.Button("~r~Prop Spawning Options", nil, {RightLabel = "~r~→→→"}, true, function(Hovered, Active, Selected) end, RMenu:Get("vRPAdmin", "EntitysDeleted"))
        end)
    end
    if RageUI.Visible(RMenu:Get('vRPAdmin', 'misc')) then 
        RMenu:Get('vRPAdmin', 'misc'):SetTitle('') 
        RMenu:Get('vRPAdmin', 'misc'):SetSubtitle("Galaxy Sub Options")
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            
            for i,v in pairs(MiscBtn) do 
                RageUI.Button(i, nil, {}, true, function(Hovered, Active, Selected) 
                    if Selected then 
                        cfg.MiscButtons[i][1]()
                    end
                end)
            end


        end)
    end
    if RageUI.Visible(RMenu:Get('vRPAdmin', 'EntitysDeleted')) then 
        RMenu:Get('vRPAdmin', 'EntitysDeleted'):SetTitle('') 
        RMenu:Get('vRPAdmin', 'EntitysDeleted'):SetSubtitle("~w~Add Blacklisted Entities here")
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            RageUI.Button('Clear Entities', nil, {}, true, function(Hovered, Active, Selected) 
                if Selected then 
                    EntitysDeleted = {}
                end
            end)
            for i,v in pairs(EntitysDeleted) do 
                RageUI.Button(i, "This makes it so it can never be spawned again!", {}, true, function(Hovered, Active, Selected) 
                    if Selected then 
                        TriggerServerEvent('vRPAdmin:UpdateBlacklistedProps', i)
                        EntitysDeleted[i] = nil 
                    end
                end)
            end
        end)
    end

    if RageUI.Visible(RMenu:Get('vRPAdmin', 'devop')) then 
        RMenu:Get('vRPAdmin', 'devop'):SetTitle('') 
        RMenu:Get('vRPAdmin', 'devop'):SetSubtitle("~w~Galaxy Dev Menu")
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            RageUI.Button('Spawn a Vehicle', nil, {}, true, function(Hovered, Active, Selected) 
                if Selected then 
                    AddTextEntry('FMMC_MPM_NC', "Enter the car spawncode name")
                    DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
                    while (UpdateOnscreenKeyboard() == 0) do
                        DisableAllControlActions(0);
                        Wait(0);
                    end
                    if (GetOnscreenKeyboardResult()) then
                        local result = GetOnscreenKeyboardResult()
                        if result then 
                            local mhash = GetHashKey(result)
                            local i = 0
                            while not HasModelLoaded(mhash) do
                                RequestModel(mhash)
                                i = i + 1
                                Citizen.Wait(10)
                                if i > 30 then
                                    

                                    break 
                                end
                            end
                                
                                local coords = GetEntityCoords(PlayerPedId())
                                nveh = CreateVehicle(mhash, coords.x, coords.y, coords.z+0.5, 0.0, true, false)
                    
                                SetVehicleOnGroundProperly(nveh)
                                SetEntityInvincible(nveh,false)
                                SetPedIntoVehicle(GetPlayerPed(-1),nveh,-1) -- put player inside
                                SetVehicleNumberPlateText(nveh, "P "..tvRP.getRegistrationNumber())
                                --Citizen.InvokeNative(0xAD738C3085FE7E11, nveh, true, true) -- set as mission entity
                                SetVehicleHasBeenOwnedByPlayer(nveh,true)
                                nid = NetworkGetNetworkIdFromEntity(nveh)
                                SetNetworkIdCanMigrate(nid,cfg.vehicle_migration)
                
                            
                        end
                    end
                end  
            end)
            RageUI.Button('Spawn Weapon', nil, {}, true, function(Hovered, Active, Selected) 
                if Selected then 
                    AddTextEntry('FMMC_MPM_NC', "Enter the weapon hash!")
                    DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
                    while (UpdateOnscreenKeyboard() == 0) do
                        DisableAllControlActions(0);
                        Wait(0);
                    end
                    if (GetOnscreenKeyboardResult()) then
                        local result = GetOnscreenKeyboardResult()
                        if result then 
                            GiveWeaponToPed(PlayerPedId(), result, 250, false, true)
                            if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey(result) then 
                                notify("~g~Successfuly spawned in weapon!")
                            else

                                notify("~r~Failed to spawn in weapon!")
                            end
                        end
                    end
                end  
            end)
            RageUI.Button('Get Coords', nil, {}, true, function(Hovered, Active, Selected) 
                if Selected then 
                   TriggerServerEvent("getCoords", source)
                end  
            end)
        end)
    end
    if RageUI.Visible(RMenu:Get('vRPAdmin', 'EntityOptions')) then 
        RMenu:Get('vRPAdmin', 'EntityOptions'):SetTitle('') 
        RMenu:Get('vRPAdmin', 'EntityOptions'):SetSubtitle("~w~Galaxy Entity Options")
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            RageUI.Button('All Cleanup', nil, {}, true, function(Hovered, Active, Selected) 
                if Selected then 
                    TriggerServerEvent('vRPAdmin:CleanAll')
                end  
            end)
            RageUI.Button('Entity Cleanup', nil, {}, true, function(Hovered, Active, Selected) 
                if Selected then 
                    TriggerServerEvent('vRPAdmin:PropCleanup')
                end  
            end)
            RageUI.Button('Vehicle Cleanup', nil, {}, true, function(Hovered, Active, Selected) 
                if Selected then 
                    TriggerServerEvent('vRPAdmin:VehCleanup')
                end  
            end)
            RageUI.Button('Ped Cleanup', nil, {}, true, function(Hovered, Active, Selected) 
                if Selected then 
                    TriggerServerEvent('vRPAdmin:PedCleanup')
                end  
            end)
            RageUI.Button('~r~Entity Cleanup Gun', nil, {RightLabel = "~r~→→→"}, true, function(Hovered, Active, Selected) 
                if Selected then 
                    TriggerServerEvent('vRPAdmin:EntityCleanupGun')
                end  
            end)
        end)
    end



    if RageUI.Visible(RMenu:Get('vRPAdmin', 'teleport')) then 
        RMenu:Get('vRPAdmin', 'teleport'):SetTitle('') 
        RMenu:Get('vRPAdmin', 'teleport'):SetSubtitle("~w~Galaxy Teleport Menu")
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()


            RageUI.Button('~y~[You Tool]', nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected) 
                if Selected then 
                    SetEntityCoords(PlayerPedId(), 2752.1442871094,3471.1740722656,55.719055175781)
                    notify("~g~Teleported to You Tool!")
                end  
            end)
            RageUI.Button('Drug House ~r~[Access Centre]', nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected) 
                if Selected then 
                    SetEntityCoords(PlayerPedId(), 2451.095703125,4961.8178710938,45.482273101807)
                    notify("~g~Teleported to Drug House!")
                end  
            end)
            RageUI.Button('Dirt Path ~y~[Token Crafter]', nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected) 
                if Selected then 
                    SetEntityCoords(PlayerPedId(), 2705.4543457031,4144.2543945312,43.909889221191)
                    notify("~g~Teleported to Drug House!")
                end  
            end)
            RageUI.Button('Rebel Diner', nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected) 
                if Selected then 
                    SetEntityCoords(PlayerPedId(), 1583.9733886719,6449.6606445312,25.184074401855)
                    notify("~g~Teleported to Drug House!")
                end  
            end)
            


        end)
    end

    if RageUI.Visible(RMenu:Get('vRPAdmin', 'searchplayers')) then
        RMenu:Get('vRPAdmin', 'searchplayers'):SetSubtitle("Search Players")
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            RageUI.Button("Search Perm ID", nil, {}, true, function(Hovered, Active, Selected) end, RMenu:Get('vRPAdmin', 'searchpermids'))
            RageUI.Button("Search Temp ID", nil, {}, true, function(Hovered, Active, Selected) end, RMenu:Get('vRPAdmin', 'searchtempids'))
            RageUI.Button("Search Player Names", nil, {}, true, function(Hovered, Active, Selected) end, RMenu:Get('vRPAdmin', 'searchnames'))
            if variablematched then
                variablematched = false
            end
        end)
    end

    if RageUI.Visible(RMenu:Get('vRPAdmin', 'searchtempids')) then
        RMenu:Get('vRPAdmin', 'searchtempids'):SetSubtitle("Search Temp IDs")
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()


            if not variablematched then
                searchedtempid = SearchTempID()
            end

            for i,v in pairs(plrsInServer) do 
                variablematched = true
                if string.find(v[1],tostring(searchedtempid)) then
                    RageUI.Button(v[2], "Perm ID: " .. i .. ' / Temp ID: ' .. v[1], {}, true, function(Hovered, Active, Selected) 
                        if Selected then 
                            SelectedPerm = i
                            RMenu:Get('vRPAdmin', 'player_selected'):SetSubtitle("~w~Options for " .. v[2] .. " ~m~[ " .. v[1] .. " ]")
                        end
                end, RMenu:Get("vRPAdmin", "player_selected"))
            end
        end

        end)
    end

    if RageUI.Visible(RMenu:Get('vRPAdmin', 'searchpermids')) then
        RMenu:Get('vRPAdmin', 'searchpermids'):SetSubtitle("Search Perm IDs")
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            if not variablematched then
                searchedpermid = SearchPermID()
            end
            for i,v in pairs(plrsInServer) do 
                variablematched = true
                if string.find(i,tostring(searchedpermid)) then
                    RageUI.Button(v[2], "Perm ID: " .. i .. ' / Temp ID: ' .. v[1], {}, true, function(Hovered, Active, Selected) 
                        if Selected then 
                            SelectedPerm = i
                            RMenu:Get('vRPAdmin', 'player_selected'):SetSubtitle("~w~Options for " .. v[2] .. " ~m~[ " .. v[1] .. " ]")
                        end
                end, RMenu:Get("vRPAdmin", "player_selected"))
            end
        end
        
        end)
    end
    if RageUI.Visible(RMenu:Get('vRPAdmin', 'searchnames')) then
        RMenu:Get('vRPAdmin', 'searchnames'):SetSubtitle("Search Player Names")
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            if not variablematched then
                searchedplrname = string.upper(SearchPlrName())
            end
            for i,v in pairs(plrsInServer) do 
                variablematched = true
                if searchedplrname == string.upper(v[2]) then
                    RageUI.Button(v[2], "Perm ID: " .. i .. ' / Temp ID: ' .. v[1], {}, true, function(Hovered, Active, Selected) 
                        if Selected then 
                            SelectedPerm = i
                            RMenu:Get('vRPAdmin', 'player_selected'):SetSubtitle("~w~Options for " .. v[2] .. " ~m~[ " .. v[1] .. " ]")
                        end
                end, RMenu:Get("vRPAdmin", "player_selected"))
            end
        end
        
        end)
    end

    if RageUI.Visible(RMenu:Get('vRPAdmin', 'players')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            for i,v in pairs(plrsInServer) do 
                RageUI.Button(v[2] .. "~m~ [ " .. v[1] .. " ]", "Perm ID: " .. i .. ' / Temp ID: ' .. v[1], {}, true, function(Hovered, Active, Selected) 
                    if Selected then 
                        SelectedPerm = i
                        RMenu:Get('vRPAdmin', 'player_selected'):SetSubtitle("~w~Options for " .. v[2] .. " ~m~[ " .. v[1] .. " ]")
                    end
                end, RMenu:Get("vRPAdmin", "player_selected"))
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('vRPAdmin', 'player_selected')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            for i,v in pairs(Buttons) do 
                RageUI.Button(i, nil, {}, true, function(Hovered, Active, Selected) 
                    if Selected then 
                        cfg.Buttons[i][1](SelectedPerm)
                    end
                end)
            end
 
            RageUI.Button('~y~View Players Groups', nil, { RightLabel = "~y~→→→"}, true, function(Hovered, Active, Selected)
                if Selected then 
                    TriggerServerEvent('vRPAdmin:Groups', SelectedPerm)
                    RMenu:Get('vRPAdmin', 'groups'):SetSubtitle("~w~Groups for PermID: " .. SelectedPerm)
                end
            end, RMenu:Get("vRPAdmin", "groups"))


        end) 
    end
    if RageUI.Visible(RMenu:Get('vRPAdmin', 'groups')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            for i,v in pairs(Groups) do 
                RageUI.Button(i, nil, {}, true, function(Hovered, Active, Selected) 
                    if Selected then 
                        SelectedGroup = i;
                    end
                end, RMenu:Get("vRPAdmin", "groups_manage"))
            end
        end) 
    end
    if RageUI.Visible(RMenu:Get('vRPAdmin', 'groups_manage')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            RageUI.Button('Remove Group', nil, {}, true, function(Hovered, Active, Selected) 
                if Selected then
                    TriggerServerEvent('vRPAdmin:RemoveGroup', SelectedPerm, SelectedGroup)
                end
            end)
        end) 
    end
end)

RegisterCommand('openadminmenu', function()
    TriggerServerEvent('vRPAdmin:ReturnPlayers')
end, false)


RegisterKeyMapping('openadminmenu', 'Opens admin menu', 'keyboard', 'F2')



RegisterNetEvent('vRPAdmin:RecievePlayers')
AddEventHandler('vRPAdmin:RecievePlayers', function(table, perms, misc)
    plrsInServer = table
    Buttons = perms
    MiscBtn = misc
    RageUI.Visible(RMenu:Get('vRPAdmin', 'main'), not RageUI.Visible(RMenu:Get('vRPAdmin', 'main')))
end)

RegisterNetEvent('vRPAdmin:ReturnGroups')
AddEventHandler('vRPAdmin:ReturnGroups', function(groups)
    Groups = groups
end)

local Spectating = false;
local LastCoords = nil;
RegisterNetEvent('vRPAdmin:Spectate')
AddEventHandler('vRPAdmin:Spectate', function(plr,tpcoords)
    local playerPed = PlayerPedId()
    local targetPed = GetPlayerPed(GetPlayerFromServerId(plr))
    if not Spectating then
        LastCoords = GetEntityCoords(playerPed) 
        if tpcoords then 
            SetEntityCoords(playerPed, tpcoords - 10.0)
        end
        Wait(300)
        targetPed = GetPlayerPed(GetPlayerFromServerId(plr))
        if targetPed == playerPed then tvRP.notify('~r~I mean you cannot spectate yourself...') return end
		NetworkSetInSpectatorMode(true, targetPed)
        SetEntityCollision(playerPed, false, false)
        SetEntityVisible(playerPed, false, 0)
		SetEveryoneIgnorePlayer(playerPed, true)	
		
        Spectating = true
        tvRP.notify('~g~Spectating Player.')
    else 
        NetworkSetInSpectatorMode(false, targetPed)
        SetEntityVisible(playerPed, true, 0)
		SetEveryoneIgnorePlayer(playerPed, false)
		
		SetEntityCollision(playerPed, true, true)
        Spectating = false;
        SetEntityCoords(playerPed, LastCoords)
        tvRP.notify('~r~Stopped Spectating Player.')
    end 
end)

RegisterNetEvent('vRPAdmin:TPTo')
AddEventHandler('vRPAdmin:TPTo', function(coords, plr)
    if coords then 
        SetEntityCoords(PlayerPedId(), coords)
    else 
        local targetPed = GetPlayerPed(GetPlayerFromServerId(plr))
        local plrcoords = GetEntityCoords(targetPed)
        SetEntityCoords(PlayerPedId(), plrcoords)
    end
end)

RegisterNetEvent('vRPAdmin:Bring')
AddEventHandler('vRPAdmin:Bring', function(coords, plr)
    if coords then 
        SetEntityCoords(PlayerPedId(), coords)
    else 
        local targetPed = GetPlayerPed(GetPlayerFromServerId(plr))
        local plrcoords = GetEntityCoords(targetPed)
        SetEntityCoords(PlayerPedId(), plrcoords)
    end
end)

function NetworkDelete(entity)
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

RegisterNetEvent("vRPAdmin:EntityWipe")
AddEventHandler("vRPAdmin:EntityWipe", function(id)
    Citizen.CreateThread(function() 
        for k,v in pairs(GetAllEnumerators()) do 
            local enum = v
            for entity in enum() do 
                local owner = NetworkGetEntityOwner(entity)
                local playerID = GetPlayerServerId(owner)
                NetworkDelete(entity)
            end
        end
    end)
end)

local EntityCleanupGun = false;
RegisterNetEvent("vRPAdmin:EntityCleanupGun")
AddEventHandler("vRPAdmin:EntityCleanupGun", function()
    EntityCleanupGun = not EntityCleanupGun
    if EntityCleanupGun then 
        GiveWeaponToPed(PlayerPedId(), GetHashKey('WEAPON_RAYPISTOL'), 250, false, true)
        DisablePlayerFiring(GetPlayerPed(-1), true)    
        tvRP.notify("~g~Entity cleanup gun enabled.")
    else 
        tvRP.notify("~r~Entity cleanup gun disabled.")
        RemoveWeaponFromPed(PlayerPedId(), GetHashKey('WEAPON_RAYPISTOL'))
        DisablePlayerFiring(GetPlayerPed(-1), false)    
    end
end)

Citizen.CreateThread(function()
    while true do 
        Wait(0)
        if EntityCleanupGun then 
            local plr = PlayerId()
            if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_RAYPISTOL') then
                if IsPlayerFreeAiming(plr) then 
                    local yes, entity = GetEntityPlayerIsFreeAimingAt(plr)
                    if yes then 
                        EntitysDeleted[GetEntityModel(entity)] = true;
                        tvRP.notify('~g~Deleted Entity: ' .. GetEntityModel(entity))
                        NetworkDelete(entity)
                    end
                end 
            else 
                RemoveWeaponFromPed(PlayerPedId(), GetHashKey('WEAPON_RAYPISTOL'))
                EntityCleanupGun = false;
                tvRP.notify("~r~Entity cleanup gun disabled.")
            end 
        end
    end
end)


local KickActive = false;
local currenttime = 300; 

RegisterNetEvent('VRPAdmin:ActivateShutdown')
AddEventHandler('VRPAdmin:ActivateShutdown', function()
    KickActive = true;
end)

Citizen.CreateThread(function()
    while true do 
        Wait(1000)
        if KickActive then
            currenttime = currenttime - 1 
        end
    end
end)

local scaleform = RequestScaleformMovie("MP_BIG_MESSAGE_FREEMODE")
Citizen.CreateThread(function()
    while true do
        Wait(0)
        if KickActive then
            if HasScaleformMovieLoaded(scaleform) then
                PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
                BeginTextComponent("STRING")
                AddTextComponentString("~r~THIS SERVER IS SHUTTING DOWN IN: " .. currenttime .. " Seconds")
                EndTextComponent()
                PopScaleformMovieFunctionVoid()
                DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
            end
        else 
            currenttime = 300
        end
    end
end)

function notify(string)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(string)
    DrawNotification(true, false)
end

function SearchTempID()
	AddTextEntry('FMMC_MPM_NA', "Enter Temp ID to search")
	DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Enter Temp ID to search", "", "", "", "", 30)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        local result = GetOnscreenKeyboardResult()
		if result then
			return result
		end
    end
	return false
end

function SearchPermID()
	AddTextEntry('FMMC_MPM_NA', "Enter Perm ID to search")
	DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Enter Perm ID to search", "", "", "", "", 30)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        local result = GetOnscreenKeyboardResult()
		if result then
			return result
		end
    end
	return false
end

function SearchPlrName()
	AddTextEntry('FMMC_MPM_NA', "Enter Player Name to search")
	DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Enter Player Name to search", "", "", "", "", 30)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        local result = GetOnscreenKeyboardResult()
		if result then
			return result
		end
    end
	return false
end

local hasTeleported = false
RegisterNetEvent("tpWith")
AddEventHandler("tpWith", function()
    hasTeleported = false
    while true do
        if hasTeleported == false then
            if IsControlJustPressed(0, 58) then
                SetEntityCoords(PlayerPedId(), 3501.3525390625,2590.6750488281,13.562794685364)
                notify("Teleported to player.")
                hasTeleported = true
            end
        end
        Citizen.Wait(10)
    end
end)

RegisterNetEvent("returnDevOP")
AddEventHandler("returnDevOP", function(booll)
    if booll == true then 
        isDevOP = true 
    else
        isDevOP = false
    end
end)

RegisterNetEvent("returnEnOP")
AddEventHandler("returnEnOP", function(booll)
    if booll == true then 
        isEnIO = true 
    else
        isEnIO = false
    end
end)


