local a = {
    onJob = false,
    spawnVehicleVector = vector3(455.00802612304, -582.24096679688, 28.49980354309),
    startVector = vector3(429.52169799804, -587.45068359375, 29.499813079834),
    tempMarker = 0,
    tempBlip = 0,
    tempVehicle = 0,
    tempObject = 0,
    cashEarned = 0,
    stopNumber = 0
}
local passengerPeds = {
    {pedModel = 'a_f_m_beach_01'}, 
    {pedModel = 'a_f_m_bevhills_01'}, 
    {pedModel = 'a_f_m_bevhills_02'}, 
    {pedModel = 'a_f_m_bodybuild_01'}, 
    {pedModel = 'a_f_m_business_02'},  
    {pedModel = 'a_f_m_downtown_01'},  
    {pedModel = 'a_f_m_eastsa_01'},  
    {pedModel = 'a_f_m_eastsa_02'},  
    {pedModel = 'a_f_m_fatbla_01'},  
    {pedModel = 'a_f_m_fatcult_01'},  
    {pedModel = 'a_f_m_fatwhite_01'},  
    {pedModel = 'a_f_m_ktown_01'},  
    {pedModel = 'a_f_m_ktown_02'},  
    {pedModel = 'a_f_m_prolhost_01'},  
    {pedModel = 'a_f_m_ktown_01'},   
    {pedModel = 'a_f_m_prolhost_01'},   
    {pedModel = 'a_f_m_salton_01'},   
    {pedModel = 'a_f_m_skidrow_01'}, 
}
local b = 10
RegisterNetEvent("ARMA:beginBusJob",function()
    a.tempVehicle = tARMA.spawnVehicle("bus",a.spawnVehicleVector.x,a.spawnVehicleVector.y,a.spawnVehicleVector.z,343,true,true,true)
    a.onJob = true
    tARMA.notify("~g~Bus Job started, exit the bus station and head to the first bus stop.")
    while a.onJob do
        DrawGTATimerBar("PASSENGERS:", a.stopNumber .. "/" .. b, 2)
        DrawGTATimerBar("~g~EARNED:", "£" .. getMoneyStringFormatted(a.cashEarned), 1)
        Wait(0)
    end
end)
RegisterNetEvent("ARMA:endBusJob",function()
    tARMA.notify("~g~Shift complete.")
    DeletePed(busJobPed)
    DeleteVehicle(GetVehiclePedIsIn(GetPlayerPed(-1), false))
    DeleteVehicle(a.tempVehicle)
    a.onJob = false
    a.tempMarker = 0
    a.tempBlip = 0
    a.tempVehicle = 0
    a.tempObject = 0
    a.cashEarned = 0
    a.stopNumber = 0
end)
RegisterNetEvent("ARMA:nextStopReachedBusJob",function(d)
    local e = a.tempVehicle
    a.stopNumber = a.stopNumber + 1
    if d then
        a.cashEarned = a.cashEarned + d
    end
    Citizen.CreateThread(function()
        while e do
            SetVehicleEngineOn(e, false, true, false)
            Wait(0)
        end
    end)
    if a.tempMarker then
        tARMA.removeMarker(a.tempMarker)
    end
    SetVehicleDoorOpen(e, 0)
    SetVehicleDoorOpen(e, 1)
    SetVehicleDoorOpen(e, 2)
    SetVehicleDoorOpen(e, 3)
    SetVehicleDoorOpen(e, 4)
    SetVehicleDoorOpen(e, 5)
    RemoveBlip(a.tempBlip)
    local B=tARMA.loadModel(passengerPeds[a.stopNumber].pedModel)
    local coords = tARMA.getPosition()
    local radius = 10.0
    local foundSafeCoords, safeCoords = GetSafeCoordForPed(coords.x + math.random(-radius, radius), coords.y + math.random(-radius, radius), coords.z, false, 16)
    if not foundSafeCoords then -- The native couldn't find a safe spawn point, in which case we'll calculate the coordinates ourselves. It would probably be better to just not spawn the ped at this coordinates, and recalculate it.
        local z = 0
        repeat
            local onGround, safeZ = GetGroundZFor_3dCoord(coords)
            if not onGround then
                z = z + 0.1
            end
        until onGround
        safeCoords = vector3(coords.x + math.random(-radius, radius), coords.y + math.random(-radius, radius), safeZ)
    end
    DeletePed(busJobPed)
    busJobPed=CreatePed(26,B,safeCoords.x,safeCoords.y,safeCoords.z,GetEntityHeading(e),false,true)
    while not DoesEntityExist(busJobPed)do 
        Wait(0)
    end
    SetEntityCanBeDamaged(busJobPed,0)
    SetPedAsEnemy(busJobPed,0)
    SetBlockingOfNonTemporaryEvents(busJobPed,1)
    SetPedCanRagdollFromPlayerImpact(busJobPed,0)
    TaskGoToEntity(busJobPed,e,10.0,2.0,5.0,false,false)
    Wait(4000)
    for k = 1, GetVehicleMaxNumberOfPassengers(e) do
        if IsVehicleSeatFree(e, k) then
            TaskEnterVehicle(busJobPed,e,10.0,k,5.0,0,0)
        end
    end
    Wait(3000)
    SetTimeout(2500,function()
        SetVehicleDoorShut(e, 0)
        SetVehicleDoorShut(e, 1)
        SetVehicleDoorShut(e, 2)
        SetVehicleDoorShut(e, 3)
        SetVehicleDoorShut(e, 4)
        SetVehicleDoorShut(e, 5)
        e = nil
        busJobPed = nil
    end)
end)
RegisterNetEvent("ARMA:setNextBusJobBlip",function(f)
    a.tempBlip = AddBlipForCoord(f.x, f.y, f.z)
    SetBlipSprite(a.tempBlip, 1)
    SetBlipRoute(a.tempBlip, true)
    a.tempMarker = tARMA.addMarker(f.x, f.y, f.z, 1.2, 1.2, 1.2, 255, 0, 0, 125, 50, 0, true, true)
end)
RegisterNetEvent('ARMA:onClientSpawn')
AddEventHandler("ARMA:onClientSpawn",function(g,h)
    if h then
        local i = function(j)
            drawNativeNotification("Press ~INPUT_PICKUP~ to start your bus shift")
        end
        local k = function(j)
        end
        local l = function(j)
            if IsControlJustReleased(1, 38) and not a.onJob then
                TriggerServerEvent("ARMA:attemptBeginBusJob")
            end
        end
        tARMA.addBlip(a.startVector.x, a.startVector.y, a.startVector.z, 106, 1, "Bus Driver Job")
        tARMA.addMarker(a.startVector.x,a.startVector.y,a.startVector.z - 1,1.0,1.0,1.0,255,0,0,70,50,39,false,false,true)
        tARMA.createArea("bus", a.startVector, 1.5, 6, i, k, l, {})
    end
end)
function alert(msg) 
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0,0,1,-1)
end
function DrawGTAText(A,v,w,a9,aa,ab)
    SetTextFont(0)
    SetTextScale(a9,a9)
    SetTextColour(254,254,254,255)
    if aa then 
        SetTextWrap(v-ab,v)
        SetTextRightJustify(true)
    end;
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(A)
    EndTextCommandDisplayText(v,w)
end;

function DrawGTATimerBar(ac,A,ad)
    local ab=0.17;
    local ae=-0.01;
    local af=0.038;
    local ag=0.008;
    local ah=0.005;
    local ai=0.32;
    local aj=-0.04;
    local ak=0.014;
    local al=GetSafeZoneSize()
    local am=ak+al-ab+ab/2;
    local an=aj+al-af+af/2-(ad-1)*(af+ah)
    DrawSprite("timerbars","all_black_bg",am,an,ab,0.038,0,0,0,0,128)
    DrawGTAText(ac,al-ab+0.06,an-ag,ai)
    DrawGTAText(string.upper(A),al-ae,an-0.0175,0.5,true,ab/2)
end;
