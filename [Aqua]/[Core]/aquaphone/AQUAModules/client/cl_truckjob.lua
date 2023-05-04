RMenu.Add('AQUAtruckjob', 'main', RageUI.CreateMenu("", "~g~Truck Job", nil, nil, "banners", ""))
RMenu:Get('AQUAtruckjob', 'main'):SetPosition(1350, 10)

local jobStarted = false
local truckJobCoords = nil
local truckJobfinishBlip = nil
local currentTruckJob = nil
local truckJobPay = 0
RageUI.CreateWhile(1.0, RMenu:Get('AQUAtruckjob', 'main'), nil, function()

    RageUI.IsVisible(RMenu:Get('AQUAtruckjob', 'main'), true, false, true, function()
        for k,v in pairs(truckjob.locations) do 
            RageUI.ButtonWithStyle(v.name , "~g~On completion you will receive £" ..Comma(v.pay), { RightLabel = '→→→'}, true, function(Hovered, Active, Selected)
                if Selected then
                    if not jobStarted then
                        jobStarted = true
                        truckJobCoords = v.coords
                        truckJobPay = v.pay
                        truckJobfinishBlip = (AddBlipForCoord(v.coords))
                        currentTruckJob = v.name
                        SetBlipSprite(truckJobfinishBlip, 280)
                        SetBlipRoute(truckJobfinishBlip, true)
                        SetBlipRouteColour(truckJobfinishBlip, 5)
                        SpawnTruck()
                        RageUI.CloseAll()
                        notify("~g~Your shift has started, good luck.")
                        TriggerServerEvent('AQUA:startTruckJob', v.name)
                    else
                        notify("~d~You are currently on a job, either finish or stop it.")
                    end
                end
            end)
        end
        if jobStarted then
            RageUI.ButtonWithStyle("End Job" , "~d~Stop your current job", { RightLabel = '→→→'}, true, function(Hovered, Active, Selected)
                if Selected then
                    if jobStarted then
                        jobStarted = false
                        truckJobCoords = nil
                        RageUI.CloseAll()
                        SetEntityAsMissionEntity(GetVehiclePedIsIn(PlayerPedId(), true, true))
                        DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
                        RemoveBlip(truckJobfinishBlip)
                        notify("~g~Stopped your current job.")
                        TriggerServerEvent('AQUA:finishTruckJob')
                        truckJobPay = 0
                    else
                        notify("~d~You are not currently on a job.")
                    end
                end
            end)
        end
    end, function()
    end)
end)


Citizen.CreateThread(function() 
    local blip = AddBlipForCoord(truckjob.startLocation)
    SetBlipSprite(blip, 477)
    SetBlipScale(blip, 0.6)
    SetBlipDisplay(blip, 2)
    SetBlipColour(blip, 1)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Truck Job")
    EndTextCommandSetBlipName(blip)
    while true do
        if isInArea(truckjob.startLocation, 100.0) then 
            DrawMarker(39, truckjob.startLocation, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 240, 47, 47, 50, false, true, 2, true, nil, nil, false)
        end
        if isInArea(vector3(truckjob.startLocation), 2.5) then 
            alert('Press ~INPUT_VEH_HORN~ to open shift manager.')
            if IsControlJustPressed(0, 51) then 
                if not IsPedSittingInAnyVehicle(PlayerPedId()) then
                    RageUI.CloseAll()
                    RageUI.Visible(RMenu:Get("AQUAtruckjob", "main"), true)
                else
                    if (IsPedSittingInAnyVehicle(PlayerPedId())) then
                        if IsVehicleModel(GetVehiclePedIsIn(PlayerPedId(), true), GetHashKey(truckjob.vehicle)) then
                            RageUI.CloseAll()
                            RageUI.Visible(RMenu:Get("AQUAtruckjob", "main"), true)
                        else
                            notify("~d~You must be outside your car.")
                        end
                    end
                end
            end
        end
        Citizen.Wait(0)
    end
end)


Citizen.CreateThread(function() 
    while true do
        if truckJobCoords ~= nil then
            if isInArea(truckJobCoords, 100.0) then 
                DrawMarker(3, truckJobCoords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 240, 47, 47, 50, false, true, 2, true, nil, nil, false)
            end
            if isInArea(truckJobCoords, 2.5) then 
                alert('Press ~INPUT_VEH_HORN~ to finish job.')
                if IsControlJustPressed(0, 51) then 
                    if jobStarted then
                        if (IsPedSittingInAnyVehicle(PlayerPedId())) then
                            if IsVehicleModel(GetVehiclePedIsIn(PlayerPedId(), true), GetHashKey(truckjob.vehicle)) then
                                SetEntityAsMissionEntity(GetVehiclePedIsIn(PlayerPedId(), true, true))
                                DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
                                RemoveBlip(truckJobfinishBlip)
                                notify("~g~Truck job finished. Payment: £" ..Comma(truckJobPay))
                                TriggerServerEvent('AQUA:finishTruckJob', currentTruckJob)
                                jobStarted = false
                                truckJobCoords = nil
                                truckJobfinishBlip = nil
                                truckJobPay = 0
                            else
                                notify("~d~You must be in your truck to finish the job.")
                            end
                        else
                            notify("~d~You must be in your truck to finish the job.")
                        end
                    end
                end
            end
        end
        Citizen.Wait(1)
    end
end)


function isInArea(v, dis) 
    if #(GetEntityCoords(PlayerPedId()) - v) <= dis then  
        return true
    else 
        return false
    end
end

function notify(u)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(u)
    DrawNotification(false, false)
end

function alert(msg) 
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0,0,1,-1)
end

function Comma(amount)
    local formatted = amount
    while true do  
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if (k==0) then
            break
        end
    end
    return formatted
end

function SpawnTruck()
    local vehicle = GetHashKey(truckjob.vehicle)
	RequestModel(vehicle)
	while not HasModelLoaded(vehicle) do
		Wait(1)
	end
	local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0, 5.0, 0)
	local spawned_car = CreateVehicle(vehicle, coords, 180, true, false)
	SetVehicleOnGroundProperly(spawned_car)
	SetVehicleNumberPlateText(spawned_car, "AQUA")
	SetPedIntoVehicle(PlayerPedId(), spawned_car, - 1)
	SetModelAsNoLongerNeeded(vehicle)
	Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(spawned_car))
end