RMenu.Add('CARDEV', 'main', RageUI.CreateMenu("","Car Development",1300,100, "banners", "adminmenu"))
RMenu.Add('CARDEV','vehiclelist',RageUI.CreateSubMenu(RMenu:Get('CARDEV','main'),"","Vehicle List",1300,100))
RMenu.Add('CARDEV','vehiclelistmain',RageUI.CreateSubMenu(RMenu:Get('CARDEV','vehiclelist'),"","Vehicle List",1300,100))
RMenu.Add('CARDEV','vehiclelistspawn',RageUI.CreateSubMenu(RMenu:Get('CARDEV','vehiclelistmain'),"","Vehicle Spawn",1300,100))

local m = module("cfg/garages");
m=m.garage_types
local garageCategorySelected
local veh
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
                RageUI.Button("Spawn Vehicle (No mods)", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
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
                RageUI.Button("Spawn Vehicle (Full Mods)", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
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
                RageUI.Button("Fix Vehicle" , nil, { RightLabel = '→→→'}, true, function(Hovered, Active, Selected) 
                    if Selected then 
                        FixVehicle()
                    end
                end)
                RageUI.Button("Delete Vehicle", "Deletes your vehicle", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        SetEntityAsMissionEntity(GetVehiclePedIsIn(PlayerPedId(), true, true))
                        DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
                    end
                end)
                RageUI.Button("Clean Vehicle" , nil, { RightLabel = '→→→'}, true, function(Hovered, Active, Selected) 
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
                RageUI.Button("Cycle through seats" , nil, { RightLabel = '→→→'}, true, function(Hovered, Active, Selected) 
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
                            tAQUA.notify("~d~Not in a vehicle.")
                        end
                    end
                end)
                RageUI.Button("Take Car Screenshot" , nil, { RightLabel = '→→→'}, true, function(Hovered, Active, Selected) 
                    if Selected then 
                        TakeVehScreenshot()
                    end
                end)
                RageUI.Button("Vehicle List",nil,{RightLabel="→→→"},true,function(Hovered, Active, Selected) 
                end,RMenu:Get('CARDEV','vehiclelist'))
                if b then
                    RageUI.Checkbox("Return to normal Universe", "~d~Leave Car Dev Mode", b, {}, function(Hovered, Active, Selected, Checked)
                        if Selected then
                            NetworkFadeOutEntity(PlayerPedId(), true, false)
                            SetEntityCoords(PlayerPedId(), savedCoords)
                            NetworkFadeInEntity(PlayerPedId(), 0)
                            b=false
                            TriggerServerEvent("AQUA:setCarDev",b)
                        end
                    end)
                else
                    RageUI.Checkbox("Teleport to Car Dev Universe", "~g~Enter Car Dev Mode", b, {}, function(Hovered, Active, Selected, Checked)
                        if Selected then
                            savedCoords = GetEntityCoords(PlayerPedId())
                            NetworkFadeOutEntity(PlayerPedId(), true, false)
                            SetEntityCoords(PlayerPedId(), vector3(2370.8, 2856.58, 40.46))
                            NetworkFadeInEntity(PlayerPedId(), 0)
                            b=true
                            TriggerServerEvent("AQUA:setCarDev",b)
                        end
                    end)
                    RageUI.Separator("~g~Enter Car Dev Mode to see more options.")
                end
            else
                RageUI.Checkbox("Teleport to Car Dev Universe", "~g~Enter Car Dev Mode", b, {}, function(Hovered, Active, Selected, Checked)
                    if Selected then
                        savedCoords = GetEntityCoords(PlayerPedId())
                        NetworkFadeOutEntity(PlayerPedId(), true, false)
                        SetEntityCoords(PlayerPedId(), vector3(2370.8, 2856.58, 40.46))
                        NetworkFadeInEntity(PlayerPedId(), 0)
                        b=true
                        TriggerServerEvent("AQUA:setCarDev",b)
                    end
                end)
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('CARDEV', 'vehiclelist')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            if b then
                for k,v in pairs(m) do
                    RageUI.Button(k,nil,{RightLabel="→→→"},true,function(Hovered, Active, Selected) 
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
                                RageUI.Button(a,""..l[1].."",{RightLabel="→→→"},true,function(Hovered, Active, Selected) 
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
                RageUI.Button("Spawn Vehicle (No mods)", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
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
                RageUI.Button("Spawn Vehicle (Full Mods)", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
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
    TriggerServerEvent('AQUA:openCarDev')
end)

function tAQUA.openCarDev()
    RageUI.Visible(RMenu:Get('CARDEV', 'main'), not RageUI.Visible(RMenu:Get('CARDEV', 'main')))
end

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
		Notify("~d~Your vehicle has been cleaned!")
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
        notify("~d~You must be in a vehicle.")
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
    TriggerServerEvent('AQUA:takeCarScreenshot')
    Wait(5000)
    SetGameplayCamRelativeHeading(0.8)
    TriggerServerEvent('AQUA:takeCarScreenshot')
    Wait(5000)
    SetGameplayCamRelativeHeading(92.0)
    TriggerServerEvent('AQUA:takeCarScreenshot')
    Wait(5000)
    TakingCarSS = false
    SetEntityInvincible(GetVehiclePedIsIn(GetPlayerPed(-1),false),false)
    SetEntityProofs(GetVehiclePedIsIn(GetPlayerPed(-1),false),false,false,false,false,false,false,false,false)
    SetEntityCanBeDamaged(GetVehiclePedIsIn(GetPlayerPed(-1),false),true)
    SetEntityCanBeDamaged(GetPlayerPed(-1),true)
    ExecuteCommand('showui')
end
local A={
    {name="fMass",type="float"},
    {name="fInitialDragCoeff",type="float"},
    {name="fDownforceModifier",type="float"},
    {name="fPercentSubmAQUAed",type="float"},
    {name="vecCentreOfMassOffset",type="vector"},
    {name="vecInertiaMultiplier",type="vector"},
    {name="fDriveBiasFront",type="float"},
    {name="nInitialDriveGears",type="integer"},
    {name="fInitialDriveForce",type="float"},
    {name="fDriveInertia",type="float"},
    {name="fClutchChangeRateScaleUpShift",type="float"},
    {name="fClutchChangeRateScaleDownShift",type="float"},
    {name="fInitialDriveMaxFlatVel",type="float"},
    {name="fBrakeForce",type="float"},
    {name="fBrakeBiasFront",type="float"},
    {name="fHandBrakeForce",type="float"},
    {name="fSteeringLock",type="float"},
    {name="fTractionCurveMax",type="float"},
    {name="fTractionCurveMin",type="float"},
    {name="fTractionCurveLateral",type="float"},
    {name="fTractionSpringDeltaMax",type="float"},
    {name="fLowSpeedTractionLossMult",type="float"},
    {name="fCamberStiffnesss",type="float"},
    {name="fTractionBiasFront",type="float"},
    {name="fTractionLossMult",type="float"},
    {name="fSuspensionForce",type="float"},
    {name="fSuspensionCompDamp",type="float"},
    {name="fSuspensionReboundDamp",type="float"}
    ,{name="fSuspensionUpperLimit",type="float"},{name="fSuspensionLowerLimit",type="float"},{name="fSuspensionRaise",type="float"},{name="fSuspensionBiasFront",type="float"},{name="fAntiRollBarForce",type="float"},{name="fAntiRollBarBiasFront",type="float"},{name="fRollCentreHeightFront",type="float"},{name="fRollCentreHeightRear",type="float"},{name="fCollisionDamageMult",type="float"},{name="fWeaponDamageMult",type="float"},{name="fDeformationDamageMult",type="float"},{name="fEngineDamageMult",type="float"},{name="fPetrolTankVolume",type="float"},{name="fOilVolume",type="float"},{name="fSeatOffsetDistX",type="float"},{name="fSeatOffsetDistY",type="float"},{name="fSeatOffsetDistZ",type="float"},{name="nMonetaryValue",type="integer"}
}
local function B()
    return{speedBuffer={},speed=0.0,speedDisplay=0.0,accel=0.0,accelDisplay=0.0,decel=0.0,decelDisplay=0.0}
end
function getPlayerVehicle()
    local a=PlayerPedId()
    local b=GetVehiclePedIsIn(a,false)
    local g=GetPedInVehicleSeat(b,-1)
    local e=g==a
    return b,e
end
local C=false
local D=B()
local function E()
    local q=getPlayerVehicle()
    local F=GetEntitySpeed(q)
    table.insert(D.speedBuffer,F)
    if#D.speedBuffer>100 then 
        table.remove(D.speedBuffer,1)
    end
    local G=0.0
    local H=0.0
    local I=0
    local J=0
    for K,L in ipairs(D.speedBuffer)do 
        if K>1 then 
            local M=L-D.speedBuffer[K-1]
            if M>0.0 then 
                G=G+M
                I=I+1 
            else 
                H=G+M
                J=J+1 
            end 
        end 
    end
    G=G/I
    H=H/J
    D.speed=math.max(D.speed,F)
    D.speedDisplay=D.speed*2.236936
    D.accel=math.max(D.accel,G)
    D.accelDisplay=D.accel*60.0*2.236936
    D.decel=math.min(D.decel,H)
    D.decelDisplay=math.abs(D.decel)*60.0*2.236936 
end
local function N(O)
    local q=getPlayerVehicle()
    if q==0 then 
        return"0.0"
    end
    if O.type=="float"then 
        local P=GetVehicleHandlingFloat(q,"CHandlingData",O.name)
        return string.format("%.5f",P)
    elseif O.type=="integer"then 
        local Q=GetVehicleHandlingInt(q,"CHandlingData",O.name)
        return tostring(Q)
    elseif O.type=="vector"then 
        local R=GetVehicleHandlingVector(q,"CHandlingData",O.name)
        return string.format("%.3f %.3f %.3f",R.x,R.y,R.z)
    end
    return"INVALID"
end
local function S()
    AddTextEntry("FMMC_MPM_NA","Enter Value")
    DisplayOnscreenKeyboard(1,"FMMC_MPM_NA","Enter Value","","","","",30)
    while UpdateOnscreenKeyboard()==0 do 
        DisableAllControlActions(0)
        Wait(0)
    end
    if GetOnscreenKeyboardResult()then 
        local T=GetOnscreenKeyboardResult()
        if T then 
            return T 
        end 
    end
    return false 
end
local function stringsplit(input, seperator)
	if seperator == nil then
		seperator = '%s'
	end
	
	local t={} ; i=1
	
	for str in string.gmatch(input, '([^'..seperator..']+)') do
		t[i] = str
		i = i + 1
	end
	
	return t
end
local function U(O)
    local V=S()
    if not V then 
        notify("~d~Input cancelled.")
        return 
    end
    local q=getPlayerVehicle()
    if O.type=="float"then 
        local W=tonumber(V)
        if W then 
            SetVehicleHandlingFloat(q,"CHandlingData",O.name,W+0.0)
        else 
            notify("~d~Can not parse float.")
        end 
    elseif O.type=="integer"then 
        local W=tonumber(V)
        if W then 
            SetVehicleHandlingInt(q,"CHandlingData",O.name,math.floor(W))
        else 
            notify("~d~Can not parse integer.")
        end 
    elseif O.type=="vector"then 
        local X=stringsplit(V," ")
        if X and#X>=3 then 
            local Y=tonumber(X[1])
            local Z=tonumber(X[2])
            local _=tonumber(X[3])
            if Y and Z and _ then 
                SetVehicleHandlingVector(q,"CHandlingData",O.name,vector3(Y+0.0,Z+0.0,_+0.0))
            else 
                notify("~d~Can not parse vector.")
            end 
        else 
            notify("~d~Expected 3 floats.")
        end 
    end
    ModifyVehicleTopSpeed(q,1.0)
end
local function a0(W)
    W=W*10000.0
    return(W%1.0>0.5 and math.ceil(W)or math.floor(W))/10000.0 
end
local function a1()
    local a2=""
    local function a3(a4)
        if a2~=""then 
            a2=a2 .."\n\t\t\t"
        end
        a2=a2 ..a4 
    end
    local q=getPlayerVehicle()
    for a5,O in pairs(A)do 
        if O.type=="float"then 
            local W=GetVehicleHandlingFloat(q,"CHandlingData",O.name)
            a3(string.format("<%s value=\"%s\" />",O.name,a0(W)))
        elseif O.type=="integer"then 
            local W=GetVehicleHandlingInt(q,"CHandlingData",O.name)
            a3(string.format("<%s value=\"%s\" />",O.name,W))
        elseif O.type=="vector"then 
            local W=GetVehicleHandlingVector(q,"CHandlingData",O.name)
            a3(string.format("<%s x=\"%s\" y=\"%s\" z=\"%s\" />",O.name,W.x,W.y,W.z))
        end 
    end
    TriggerServerEvent('AQUA:getCarDevDebug',{a2})
end
local function a6(a7)
    C=a7
    setCursor(a7 and 1 or 0)
end
function getFontId(e)
    return 6
end
function DrawAdvancedTextNoOutline(v,w,x,y,z,A,B,C,D,E,F,G)
    SetTextFont(F)
    SetTextProportional(0)
    SetTextScale(z,z)
    N_0x4e096588b13ffeca(G)
    SetTextColour(B,C,D,E)
    SetTextDropShadow()
    SetTextEntry("STRING")
    AddTextComponentString(A)
    DrawText(v-0.1+x,w-0.02+y)
end
local function a8()
    if not b then 
        if C then
            a6(false)
        end
        return 
    end
    E()
    local a9=getFontId()
    local aa=C and 0.345 or 0.505
    DrawAdvancedTextNoOutline(aa,0.055,0.005,0.02,0.35,string.format("Top Speed: %.5f",D.speedDisplay),255,255,255,255,a9,1)
    DrawAdvancedTextNoOutline(aa,0.075,0.005,0.02,0.35,string.format("Top Acceleration: %.5f",D.accelDisplay),255,255,255,255,a9,1)
    DrawAdvancedTextNoOutline(aa,0.095,0.005,0.02,0.35,string.format("Top Deacceleration: %.5f",D.decelDisplay),255,255,255,255,a9,1)
    local s=getPlayerVehicle()
    DisableControlAction(0,19,true)
    if s~=0 and IsDisabledControlJustPressed(0,19)then 
        a6(not C)
    end
    if not C then 
        return 
    elseif s==0 then 
        a6(false)
    end
    for K,O in pairs(A)do 
        local ab=K>23 and 1 or 0
        local ac=0.14+(K-ab*23)*0.0215
        local ad=CursorInArea(0.25+ab*0.27,0.5+ab*0.27,ac,ac+0.0215)
        local ae=ad and 100 or 255
        DrawAdvancedTextNoOutline(0.345+ab*0.27,ac,0.005,0.02,0.35,O.name,ae,ae,255,255,a9,1)
        DrawAdvancedTextNoOutline(0.516+ab*0.231,ac+0.001,0.005,0.02,0.35,N(O),ae,ae,255,255,a9,1)
        if ad and IsDisabledControlJustPressed(0,24)then 
            Citizen.CreateThreadNow(function()
                U(O)
            end)
        end 
    end
    DrawRect(0.465,0.415,0.09,0.495,0,0,0,100)
    DrawRect(0.695,0.415,0.09,0.495,0,0,0,100)
    DrawRect(0.278,0.14,0.055,0.02,255,255,255,230)
    DrawAdvancedTextNoOutline(0.346,0.129,0.005,0.02,0.24,"Send Handling",0,0,0,255,0,1)
    if CursorInArea(0.25,0.31,0.12,0.15)and IsDisabledControlJustPressed(0,24)then 
        a1()
    end
    DrawRect(0.338,0.14,0.055,0.02,255,255,255,230)
    DrawAdvancedTextNoOutline(0.41,0.129,0.005,0.02,0.24,"Reset Stats",0,0,0,255,0,1)
    if CursorInArea(0.31,0.37,0.12,0.15)and IsDisabledControlJustPressed(0,24)then 
        D=B()
    end 
end
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        a8()
    end
end)