RMenu.Add('CARDEV', 'main', RageUI.CreateMenu("","~r~Car Dev",1250,100, "banners", "cardeveloper"))
RMenu.Add('CARDEV','vehiclelist',RageUI.CreateSubMenu(RMenu:Get('CARDEV','main'),"","~b~Vehicle List",1250,100))
RMenu.Add('CARDEV','vehiclelistmain',RageUI.CreateSubMenu(RMenu:Get('CARDEV','vehiclelist'),"","~b~Vehicle List",1250,100))
RMenu.Add('CARDEV','vehiclelistspawn',RageUI.CreateSubMenu(RMenu:Get('CARDEV','vehiclelistmain'),"","~b~Vehicle Spawn",1250,100))

local m = module("GMTCars", "cfg/cfg_garages")
m=m.garage_types
local garageCategorySelected
local veh
local extraSettings = false
local b = false
local q = {"Speed", "Drift", "Handling", "City", "Airport"}
local r = {
    vector3(2370.8, 2856.58, 40.46),
    vector3(974.58, -3006.6, 5.9),
    vector3(1894.57, 3823.71, 31.98),
    vector3(-482.63, -664.24, 32.74),
    vector3(-1728.25, -2894.99, 13.94)
}
local s = 1
local savedCoords = nil


RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('CARDEV', 'main')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            if b then
                RageUI.ButtonWithStyle("Spawn Vehicle (No mods)", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
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
                                local k=loadModel(result)
                                local coords = GetEntityCoords(PlayerPedId())
                                local nveh=spawnVehicle(k,coords.x, coords.y, coords.z,GetEntityHeading(GetPlayerPed(-1)),true,true,true)
                                SetVehicleOnGroundProperly(nveh)
                                SetEntityInvincible(nveh,false)
                                SetPedIntoVehicle(GetPlayerPed(-1),nveh,-1)
                                SetModelAsNoLongerNeeded(k)
                                SetVehRadioStation(nveh,"OFF")
                                Wait(500)
                                SetVehRadioStation(nveh,"OFF")                            
                            end
                        end
                    end
                end)
                RageUI.ButtonWithStyle("Spawn Vehicle (Full Mods)", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
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
                                local k=loadModel(result)
                                local coords = GetEntityCoords(PlayerPedId())
                                local nveh=spawnVehicle(k,coords.x, coords.y, coords.z,GetEntityHeading(GetPlayerPed(-1)),true,true,true)
                                SetVehicleOnGroundProperly(nveh)
                                SetEntityInvincible(nveh,false)
                                SetPedIntoVehicle(GetPlayerPed(-1),nveh,-1)
                                SetModelAsNoLongerNeeded(k)
                                applymods(nveh)
                                SetVehRadioStation(nveh,"OFF")
                                Wait(500)
                                SetVehRadioStation(nveh,"OFF")                            
                            end
                        end
                    end
                end)
                RageUI.ButtonWithStyle("Fix Vehicle" , nil, { RightLabel = '→→→'}, true, function(Hovered, Active, Selected) 
                    if Selected then 
                        FixVehicle()
                    end
                end)
                RageUI.ButtonWithStyle("Clean Vehicle" , nil, { RightLabel = '→→→'}, true, function(Hovered, Active, Selected) 
                    if Selected then 
                        cleanveh()
                    end
                end)
                RageUI.List("Teleport to ",q,s,nil,{},true,function(x, y, z, N)
                    s = N
                    if z then   
                        if IsPedInAnyVehicle(PlayerPedId(), true) then
                            ped = GetVehiclePedIsIn(PlayerPedId(), true)
                        else
                            ped = GetPlayerPed(-1)
                        end
                        SetEntityCoords(ped, vector3(r[s]), true,false,false,false)
                    end
                end,
                function()
                end)
                RageUI.ButtonWithStyle("Cycle through seats" , nil, { RightLabel = '→→→'}, true, function(Hovered, Active, Selected) 
                    if Selected then 
                        local p = GetPlayerPed(-1)
                        if IsPedInAnyVehicle(p) then
                            local s = GetVehiclePedIsIn(p)
                            local t = GetVehicleModelNumberOfSeats(GetEntityModel(s))
                            for u = -1, t - 2 do
                                if IsVehicleSeatFree(s, u) then
                                    TaskWarpPedIntoVehicle(p, s, u)
                                    Wait(2000)
                                end
                            end
                        else
                            tvRP.notify("~r~Not in a vehicle.")
                        end
                    end
                end)
                if extraSettings then
                    RageUI.ButtonWithStyle("Take Car Screenshot" , nil, { RightLabel = '→→→'}, true, function(Hovered, Active, Selected) 
                        if Selected then 
                            TakeVehScreenshot()
                        end
                    end)
                    RageUI.ButtonWithStyle("Vehicle List",nil,{RightLabel="→→→"},true,function(Hovered, Active, Selected) 
                    end,RMenu:Get('CARDEV','vehiclelist'))
                end
                RageUI.Checkbox("Toggle Extra Settings", nil, extraSettings, {RightLabel = ""}, function(Hovered, Active, Selected, Checked)
                    if Selected then
                        extraSettings = not extraSettings
                    end
                end,RMenu:Get('CARDEV','main'))
                if b then
                    RageUI.Checkbox("Return to normal Universe", "~r~Leave Car Dev Mode", b, {}, function(Hovered, Active, Selected, Checked)
                        if Selected then
                            DoScreenFadeOut(1000)
                            NetworkFadeOutEntity(PlayerPedId(), true, false)
                            Wait(1000)
                            SetEntityCoords(PlayerPedId(), savedCoords)
                            NetworkFadeInEntity(PlayerPedId(), 0)
                            DoScreenFadeIn(1000)
                            b=false
                            TriggerServerEvent("GMT:setCarDev",b)
                        end
                    end)
                else
                    RageUI.Checkbox("Teleport to Car Dev Universe", "~g~Enter Car Dev Mode", b, {}, function(Hovered, Active, Selected, Checked)
                        if Selected then
                            savedCoords = GetEntityCoords(PlayerPedId())
                            DoScreenFadeOut(1000)
                            NetworkFadeOutEntity(PlayerPedId(), true, false)
                            Wait(1000)
                            SetEntityCoords(PlayerPedId(), vector3(2370.8, 2856.58, 40.46))
                            NetworkFadeInEntity(PlayerPedId(), 0)
                            DoScreenFadeIn(1000)
                            b=true
                            TriggerServerEvent("GMT:setCarDev",b)
                        end
                    end)
                    RageUI.Separator("~g~Enter Car Dev Mode to see more options.")
                end
            else
                RageUI.Checkbox("Teleport to Car Dev Universe", "~g~Enter Car Dev Mode", b, {}, function(Hovered, Active, Selected, Checked)
                    if Selected then
                        savedCoords = GetEntityCoords(PlayerPedId())
                        DoScreenFadeOut(1000)
                        NetworkFadeOutEntity(PlayerPedId(), true, false)
                        Wait(1000)
                        SetEntityCoords(PlayerPedId(), vector3(2370.8, 2856.58, 40.46))
                        NetworkFadeInEntity(PlayerPedId(), 0)
                        DoScreenFadeIn(1000)
                        b=true
                        TriggerServerEvent("GMT:setCarDev",b)
                    end
                end)
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('CARDEV', 'vehiclelist')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            if b then
                for k,v in pairs(m) do
                    RageUI.ButtonWithStyle(k,nil,{RightLabel="→→→"},true,function(Hovered, Active, Selected) 
                        if Selected then
                            garageCategorySelected=k
                        end
                    end,RMenu:Get('CARDEV','vehiclelistmain'))
                end
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('CARDEV', 'vehiclelistmain')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            if b then
                for k,v in pairs(m) do
                    if k == garageCategorySelected then
                        for a,l in pairs(v) do
                            if a ~= "_config" then
                                RageUI.ButtonWithStyle(a,""..l[1].."",{RightLabel="→→→"},true,function(Hovered, Active, Selected) 
                                    if Selected then
                                        veh=a
                                    end
                                end,RMenu:Get('CARDEV','vehiclelistspawn'))
                            end
                        end
                    end
                end
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('CARDEV', 'vehiclelistspawn')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            if b then
                RageUI.ButtonWithStyle("Spawn Vehicle (No mods)", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local k=loadModel(veh)
                        local coords = GetEntityCoords(PlayerPedId())
                        local nveh=spawnVehicle(k,coords.x, coords.y, coords.z,GetEntityHeading(GetPlayerPed(-1)),true,true,true)
                        SetVehicleOnGroundProperly(nveh)
                        SetEntityInvincible(nveh,false)
                        SetPedIntoVehicle(GetPlayerPed(-1),nveh,-1)
                        SetModelAsNoLongerNeeded(k)
                        SetVehRadioStation(nveh,"OFF")
                        Wait(500)
                        SetVehRadioStation(nveh,"OFF")                                  
                    end
                end)
                RageUI.ButtonWithStyle("Spawn Vehicle (Full Mods)", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local k=loadModel(veh)
                        local coords = GetEntityCoords(PlayerPedId())
                        local nveh=spawnVehicle(k,coords.x, coords.y, coords.z,GetEntityHeading(GetPlayerPed(-1)),true,true,true)
                        SetVehicleOnGroundProperly(nveh)
                        SetEntityInvincible(nveh,false)
                        SetPedIntoVehicle(GetPlayerPed(-1),nveh,-1)
                        SetModelAsNoLongerNeeded(k)
                        applymods(nveh)
                        SetVehRadioStation(nveh,"OFF")
                        Wait(500)
                        SetVehRadioStation(nveh,"OFF")                       
                    end
                end)
            end
        end)
    end
end)




RegisterCommand('cardev', function()
    TriggerServerEvent('GMT:openCarDev')
end)

RegisterNetEvent("GMT:CarDevMenu")
AddEventHandler("GMT:CarDevMenu",function()
  RageUI.Visible(RMenu:Get('CARDEV', 'main'), not RageUI.Visible(RMenu:Get('CARDEV', 'main')))
end)

function FixVehicle(veh)
    local p = GetPlayerPed(-1)
    if IsPedInAnyVehicle(p) then
    local q = GetVehiclePedIsIn(p)
    SetVehicleEngineHealth(q, 9999)
    SetVehiclePetrolTankHealth(q, 9999)
    SetVehicleFixed(q)
    Notify('~g~Fixed Vehicle')
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
    ToggleVehicleMod(veh, 18, true)
    SetVehicleWindowTint(veh, 1) -- Window Tint
end

function cleanveh()
    local playerPed = GetPlayerPed(-1)
	if IsPedInAnyVehicle(playerPed, false) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		SetVehicleDirtLevel(vehicle, 0)
		Notify("~b~Your vehicle has been cleaned!")
	else
		Notify("~o~You're not in a vehicle! There is no vehicle to clean!")
	end
end

function Notify( text )
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
    DrawNotification( false, false )
end

function spawnVehicle(W,v,w,H,X,Y,Z,_)
    local a0=loadModel(W)
    local a1=CreateVehicle(a0,v,w,H,X,Z,_)
    SetEntityAsMissionEntity(a1)
    SetModelAsNoLongerNeeded(a0)
    if Y then 
        TaskWarpPedIntoVehicle(PlayerPedId(),a1,-1)
    end
    return a1 
end

function loadModel(r)
    local s
    if type(r)~="string"then 
        s=r 
    else 
        s=GetHashKey(r)
    end
    if IsModelInCdimage(s)then 
        if not HasModelLoaded(s)then 
            RequestModel(s)
            while not HasModelLoaded(s)do 
                Wait(0)
            end 
        end
        return s 
    else 
        return nil 
    end 
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if TakingCarSS then
            SetEntityInvincible(GetVehiclePedIsIn(GetPlayerPed(-1),false),true)
            SetEntityProofs(GetVehiclePedIsIn(GetPlayerPed(-1),false),true,true,true,true,true,true,true,true)
            SetEntityCanBeDamaged(GetVehiclePedIsIn(GetPlayerPed(-1),false),false)
            SetEntityCanBeDamaged(GetPlayerPed(-1),false)
            SetVehicleFixed(GetVehiclePedIsIn(PlayerPedId(), true))
            SetVehicleDirtLevel(GetVehiclePedIsIn(PlayerPedId(), true),0.0)
            ClearPedBloodDamage(GetPlayerPed(-1))
            for i=0,360 do
                DisableControlAction(1,i,true)
            end
        end
    end
end)

function TakeVehScreenshot()
    if GetVehiclePedIsIn(PlayerPedId(),false)==0 then
        notify("~r~You must be in a vehicle.")
        return 
    end
    TakingCarSS = true
    ExecuteCommand('hideui')
    ped = GetVehiclePedIsIn(PlayerPedId(), true)
    SetEntityCoords(ped, vector3(-921.20440673828,-3082.5627441406,12.557805664062))
    SetEntityHeading(PlayerPedId(),100.0)
    SetGameplayCamRelativePitch(7.5,1.0)
    SetGameplayCamRelativeHeading(-180.0)
    Wait(3000)
    TriggerServerEvent('GMT:takeCarScreenshot')
    Wait(5000)
    SetGameplayCamRelativeHeading(0.8)
    TriggerServerEvent('GMT:takeCarScreenshot')
    Wait(5000)
    SetGameplayCamRelativeHeading(92.0)
    TriggerServerEvent('GMT:takeCarScreenshot')
    Wait(5000)
    TakingCarSS = false
    SetEntityInvincible(GetVehiclePedIsIn(GetPlayerPed(-1),false),false)
    SetEntityProofs(GetVehiclePedIsIn(GetPlayerPed(-1),false),false,false,false,false,false,false,false,false)
    SetEntityCanBeDamaged(GetVehiclePedIsIn(GetPlayerPed(-1),false),true)
    SetEntityCanBeDamaged(GetPlayerPed(-1),true)
    ExecuteCommand('showui')
end

