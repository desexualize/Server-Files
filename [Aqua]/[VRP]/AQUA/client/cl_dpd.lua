local Status = {
	DELIVERY_INACTIVE                 = 0,
	PLAYER_STARTED_DELIVERY           = 1,
	PLAYER_REACHED_VEHICLE_POINT      = 2,
	PLAYER_REMOVED_GOODS_FROM_VEHICLE = 3,
	PLAYER_REACHED_DELIVERY_POINT     = 4,
	PLAYER_RETURNING_TO_BASE          = 5
}

-- Don't touch this, pls :)

local CurrentStatus             = Status.DELIVERY_INACTIVE
local CurrentSubtitle           = nil
local CurrentBlip               = nil
local CurrentType               = nil
local CurrentVehicle            = nil
local CurrentAttachments        = {}
local CurrentVehicleAttachments = {}
local DeliveryLocation          = {}
local DeliveryComplete          = {}
local DeliveryRoutes            = {}
local PlayerJob                 = nil
local clothing = nil
local FinishedJobs              = 0
local starteddpd = false



-- Make player look like a worker

function LoadWorkPlayerSkin(deliveryType)
	
	local playerPed = PlayerPedId()

	if clothing == nil then 
		clothing = tAQUA.getCustomization()
	end
	if IsPedMale(playerPed) then
		for k, v in pairs(dpdcfg.OutfitVan) do
			SetPedComponentVariation(playerPed, k, v.drawables, v.texture, 1)
		end
	else
		for k, v in pairs(dpdcfg.OutfitVanF) do
			SetPedComponentVariation(playerPed, k, v.drawables, v.texture, 1)
		end
	end
end

function LoadDefaultPlayerSkin()
    tAQUA.setCustomization(clothing)
    clothing = nil
end

-- Control the input

function HandleInput()
	
	if CurrentStatus == Status.PLAYER_REMOVED_GOODS_FROM_VEHICLE then
		DisableControlAction(0, 73, true)
		DisableControlAction(0, 22, true)
	else
		Wait(500)
	end
end

-- Main logic handler

function HandleLogic()

	
	local playerPed = PlayerPedId()
	local pCoords   = GetEntityCoords(playerPed)
	
	if CurrentStatus ~= Status.DELIVERY_INACTIVE then
		if IsPedDeadOrDying(playerPed, true) then
			FinishDelivery(CurrentType, false)
			return
		elseif GetVehicleEngineHealth(CurrentVehicle) < 20 and CurrentVehicle ~= nil then
			FinishDelivery(CurrentType, false)
			return
		end
	
		if CurrentStatus == Status.PLAYER_STARTED_DELIVERY then
			if not IsPlayerInsideDeliveryVehicle() then
				CurrentSubtitle = "Enter your ~y~vehicle~s~"
			else
				CurrentSubtitle = nil
			end
			
			if GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, DeliveryLocation.Item1.x, DeliveryLocation.Item1.y, DeliveryLocation.Item1.z, true) < 1.5 then
				CurrentStatus = Status.PLAYER_REACHED_VEHICLE_POINT
				CurrentSubtitle = "Leave your car and retrieve the ~y~goods~w~"
				PlaySound(-1, "Menu_Accept", "Phone_SoundSet_Default", false, 0, true)
			end
		end
		
		if CurrentStatus == Status.PLAYER_REMOVED_GOODS_FROM_VEHICLE then
			if CurrentType == 'truck' then
				CurrentSubtitle = "Deliver the ~y~goods~w~ to displayed marker."
			end
			
			if GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, DeliveryLocation.Item2.x, DeliveryLocation.Item2.y, DeliveryLocation.Item2.z, true) < 1.5 then
				
				TriggerServerEvent("AQUA:finishDelivery:server", CurrentType)
				PlaySound(-1, "Menu_Accept", "Phone_SoundSet_Default", false, 0, true)
				FinishedJobs = FinishedJobs + 1
				if FinishedJobs >= #DeliveryRoutes then
					RemovePlayerProps()
					RemoveBlip(CurrentBlip)
					DeliveryLocation.Item1 = dpdcfg.Base.retveh
					DeliveryLocation.Item2 = {x = 0, y = 0, z = 0}
					CurrentBlip            = CreateBlipAt(DeliveryLocation.Item1.x, DeliveryLocation.Item1.y, DeliveryLocation.Item1.z)
					CurrentSubtitle        = "Get back to the delivery hub and return the car."
					CurrentStatus          = Status.PLAYER_RETURNING_TO_BASE
					return
				else
					RemovePlayerProps()
					GetNextDeliveryPoint(false)
					CurrentStatus = Status.PLAYER_STARTED_DELIVERY
					CurrentSubtitle = "Drive the car to the next delivery ~y~destination~w~"
					PlaySound(-1, "Menu_Accept", "Phone_SoundSet_Default", false, 0, true)
				end
			end
		end
		Wait(500)
	else
		Wait(1000)
	end
end

-- Handling markers and object status

function HandleMarkers()
	
	local pCoords = GetEntityCoords(PlayerPedId())
	local deleter = dpdcfg.Base.deleter
	
	if CurrentStatus ~= Status.DELIVERY_INACTIVE then
		DrawMarker(20, deleter.x, deleter.y, deleter.z, 0, 0, 0, 0, 180.0, 0, 1.5, 1.5, 1.5, 249, 38, 114, 150, true, true)
		if GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, deleter.x, deleter.y, deleter.z) < 1.5 then
			DisplayHelpText("Press ~INPUT_CONTEXT~ to end your shift, please remain seated or risk losing your safety deposit.")
			if IsControlJustReleased(0, 51) then
				EndDelivery()
				return
			end
		end
		
		if CurrentStatus == Status.PLAYER_STARTED_DELIVERY then
			if not IsPlayerInsideDeliveryVehicle() and CurrentVehicle ~= nil then
				local VehiclePos = GetEntityCoords(CurrentVehicle)
				local ArrowHeight = VehiclePos.z
				ArrowHeight = VehiclePos.z + 1.0
				
				if CurrentType == 'truck' then
					ArrowHeight = ArrowHeight + 2.0
				end
				
				DrawMarker(20, VehiclePos.x, VehiclePos.y, ArrowHeight, 0, 0, 0, 0, 180.0, 0, 0.8, 0.8, 0.8, 102, 217, 239, 150, true, true)
			else
				local dl = DeliveryLocation.Item1
				if GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, dl.x, dl.y, dl.z, true) < 150 then
					DrawMarker(20, dl.x, dl.y, dl.z, 0, 0, 0, 0, 180.0, 0, 1.5, 1.5, 1.5, 102, 217, 239, 150, true, true)
				end
			end
		end
		
		if CurrentStatus == Status.PLAYER_REACHED_VEHICLE_POINT then
			if not IsPlayerInsideDeliveryVehicle() then
				TrunkPos = GetEntityCoords(CurrentVehicle)
				TrunkForward = GetEntityForwardVector(CurrentVehicle)
				local ScaleFactor = 1.0
				
				for k, v in pairs(dpdcfg.Scales) do
					if k == CurrentType then
						ScaleFactor = v
					end
				end
				
				TrunkPos = TrunkPos - (TrunkForward * ScaleFactor)
				TrunkHeight = TrunkPos.z
				TrunkHeight = TrunkPos.z + 0.7
				
				local ArrowSize = {x = 0.8, y = 0.8, z = 0.8}
				
				DrawMarker(20, TrunkPos.x, TrunkPos.y, TrunkHeight, 0, 0, 0, 180.0, 0, 0, ArrowSize.x, ArrowSize.y, ArrowSize.z, 102, 217, 239, 150, true, true)
				
				if GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, TrunkPos.x, TrunkPos.y, TrunkHeight, true) < 1.0 then
					DisplayHelpText("Press ~INPUT_CONTEXT~ to retrueve the ~y~goods~s~ from the car.")
					if IsControlJustReleased(0, 51) then
						PlayTrunkAnimation()
						GetPlayerPropsForDelivery(CurrentType)
						CurrentStatus = Status.PLAYER_REMOVED_GOODS_FROM_VEHICLE
					end
				end
			end
		end
		
		if CurrentStatus == Status.PLAYER_REMOVED_GOODS_FROM_VEHICLE then
			local dp = DeliveryLocation.Item2
			DrawMarker(20, dp.x, dp.y, dp.z, 0, 0, 0, 0, 180.0, 0, 1.5, 1.5, 1.5, 102, 217, 239, 150, true, true)
			RemoveBlip(CurrentBlip)
			CurrentBlip = CreateBlipAt(dp.x, dp.y, dp.z)
		end
		
		if CurrentStatus == Status.PLAYER_RETURNING_TO_BASE then
			local dp = dpdcfg.Base.deleter
			DrawMarker(20, dp.x, dp.y, dp.z, 0, 0, 0, 0, 180.0, 0, 1.5, 1.5, 1.5, 102, 217, 239, 150, true, true)
		end
	else
		local bCoords = dpdcfg.Base.coords
		if GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, bCoords.x, bCoords.y, bCoords.z, true) < 150.0 then
			local TruckPos   = dpdcfg.Base.truck
			
			DrawMarker(39, TruckPos.x, TruckPos.y, TruckPos.z, 0, 0, 0, 0, 0, 0, 2.5, 2.5, 2.5, 230, 219, 91, 150, true, true)
			
			local SelectType = false
			
			if GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, TruckPos.x, TruckPos.y, TruckPos.z, true) < 1.5 then
				DisplayHelpText("Press ~INPUT_CONTEXT~ to start the delivery job")
				SelectType = 'truck'
			else
				SelectType = false
			end
			
			if SelectType ~= false then
				if IsControlJustReleased(0, 51) then
					StartDelivery(SelectType)
					PlaySound(-1, "Menu_Accept", "Phone_SoundSet_Default", false, 0, true)
				end
			end
		end
	end
end

-- The trunk animation when the player remove the goods from the vehicle
function PlayTrunkAnimation()
	Citizen.CreateThread(function()
		if CurrentType == 'truck' then
			if dpdcfg.Models.vehDoor.usingTrunkForTruck then
				SetVehicleDoorOpen(CurrentVehicle, 5, false, false)
			else
				SetVehicleDoorOpen(CurrentVehicle, 2, false, false)
				SetVehicleDoorOpen(CurrentVehicle, 3, false, false)
			end
		end
		Wait(1000)
		if CurrentType == 'truck' then
			if dpdcfg.Models.vehDoor.usingTrunkForTruck then
				SetVehicleDoorShut(CurrentVehicle, 5, false)
			else
				SetVehicleDoorShut(CurrentVehicle, 2, false)
				SetVehicleDoorShut(CurrentVehicle, 3, false)
			end
		end
	end)
end

-- Create a blip for the location

function CreateBlipAt(x, y, z)
	local tmpBlip = AddBlipForCoord(x, y, z)
	SetBlipSprite(tmpBlip, 1)
	SetBlipColour(tmpBlip, 66)
	SetBlipAsShortRange(tmpBlip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("DPD Centre")
	EndTextCommandSetBlipName(tmpBlip)
	SetBlipAsMissionCreatorBlip(tmpBlip, true)
	SetBlipRoute(tmpBlip, true)
	return tmpBlip
end

function ForceCarryAnimation()
	TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "walk", 8.0, 8.0, -1, 51)
end


function StartDelivery(deliveryType)
	TriggerServerEvent("AQUA:removeSafeMoney:server", deliveryType)
	dpdjob = true
	starteddpd = true
end

function IsPlayerInsideDeliveryVehicle()
	if IsPedSittingInAnyVehicle(PlayerPedId()) then
		local playerVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
		if playerVehicle == CurrentVehicle then
			return true
		end
	end
	return false
end
function IsLastDelivery()
	local isLast = false
	local dp1    = DeliveryLocation.Item2
	local dp2    = DeliveryRoutes[#DeliveryRoutes].Item2
	if dp1.x == dp2.x and dp1.y == dp2.y and dp1.z == dp2.z then
		isLast = true
	end
	return isLast
end

-- Remove all object from the player ped

function RemovePlayerProps()
	for i = 0, #CurrentAttachments do
		DetachEntity(CurrentAttachments[i])
		DeleteEntity(CurrentAttachments[i])
	end
	ClearPedTasks(PlayerPedId())
	CurrentAttachments = {}
end

-- Spawn an object and attach it to the player

function GetPlayerPropsForDelivery(deliveryType)
	RequestAnimDict("anim@heists@box_carry@")
	while not HasAnimDictLoaded("anim@heists@box_carry@") do
		Citizen.Wait(0)
	end
	
	if deliveryType == 'truck' then
		TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "walk", 8.0, 8.0, -1, 51)
		
		local ModelHash = GetHashKey("prop_sacktruck_02b")
		
		WaitModelLoad(ModelHash)
		
		local PlayerPed = PlayerPedId()
		local PlayerPos = GetOffsetFromEntityInWorldCoords(PlayerPed, 0.0, 0.0, -5.0)
		local Object = CreateObject(ModelHash, PlayerPos.x, PlayerPos.y, PlayerPos.z, true, false, false)
		
		AttachEntityToEntity(Object, PlayerPed, GetEntityBoneIndexByName(PlayerPed, "SKEL_Pelvis"), -0.075, 0.90, -0.86, -20.0, -0.5, 181.0, true, false, false, true, 1, true)
		table.insert(CurrentAttachments, Object)
	end
	
	local JobData = (FinishedJobs + 1) / #DeliveryRoutes
	
	if JobData >= 0.5 and #CurrentVehicleAttachments > 2 then
		DetachEntity(CurrentVehicleAttachments[1])
		DeleteEntity(CurrentVehicleAttachments[1])
		table.remove(CurrentVehicleAttachments, 1)
	end
	if JobData >= 1.0 and #CurrentVehicleAttachments > 1 then
		DetachEntity(CurrentVehicleAttachments[1])
		DeleteEntity(CurrentVehicleAttachments[1])
		table.remove(CurrentVehicleAttachments, 1)
	end
end

-- Spawn truck

function SpawnDeliveryVehicle(deliveryType)
	
	local Rnd           = GetRandomFromRange(1, #dpdcfg.ParkingSpawns)
	local SpawnLocation = dpdcfg.ParkingSpawns[Rnd]

	if deliveryType == 'truck' then
		local ModelHash = GetHashKey(dpdcfg.Models.truck)
		WaitModelLoad(ModelHash)
		CurrentVehicle = CreateVehicle(ModelHash, SpawnLocation.x, SpawnLocation.y, SpawnLocation.z, SpawnLocation.h, true, true)
		SetVehicleLivery(CurrentVehicle, 3)
	end
	
	DecorSetInt(CurrentVehicle, "Delivery.Rental", dpdcfg.DecorCode)
	SetVehicleOnGroundProperly(CurrentVehicle)
end

-- Get the next destination

function GetNextDeliveryPoint(firstTime)
	if CurrentBlip ~= nil then
		RemoveBlip(CurrentBlip)
	end
	
	for i = 1, #DeliveryComplete do
		if not DeliveryComplete[i] then
			if not firstTime then
				DeliveryComplete[i] = true
				break
			end
		end
	end
	
	for i = 1, #DeliveryComplete do
		if not DeliveryComplete[i] then
			CurrentBlip = CreateBlipAt(DeliveryRoutes[i].Item1.x, DeliveryRoutes[i].Item1.y, DeliveryRoutes[i].Item1.z)
			DeliveryLocation = DeliveryRoutes[i]
			break
		end
	end
end

-- Create some random destinations

function CreateRoute(deliveryType)
	
	local TotalDeliveries = GetRandomFromRange(dpdcfg.Deliveries.min, dpdcfg.Deliveries.max)
	local DeliveryPoints = {}
	
	DeliveryPoints = dpdcfg.DeliveryLocationsTruck
	
	while #DeliveryRoutes < TotalDeliveries do
		Wait(1)
		local PreviousPoint = nil
		if #DeliveryRoutes < 1 then
			PreviousPoint = GetEntityCoords(PlayerPedId())
		else
			PreviousPoint = DeliveryRoutes[#DeliveryRoutes].Item1
		end
		
		local Rnd             = GetRandomFromRange(1, #DeliveryPoints)
		local NextPoint       = DeliveryPoints[Rnd]
		local HasPlayerAround = false
		
		for i = 1, #DeliveryRoutes do
			local Distance = GetDistanceBetweenCoords(NextPoint.Item1.x, NextPoint.Item1.y, NextPoint.Item1.z, DeliveryRoutes[i].x, DeliveryRoutes[i].y, DeliveryRoutes[i].z, true)
			if Distance < 50 then
				HasPlayerAround = true
			end
		end
		
		if not HasPlayerAround then
			table.insert(DeliveryRoutes, NextPoint)
			table.insert(DeliveryComplete, false)
		end
	end
end

-- Create a blip to tell the player back to the delivery hub

function ReturnToBase(deliveryType)
	CurrentBlip = CreateBlipAt(dpdcfg.Base.retveh.x, dpdcfg.Base.retveh.y, dpdcfg.Base.retveh.z)
end

-- End Delivery, is the player finish or failed?

function EndDelivery()
	local PlayerPed = PlayerPedId()
	if not IsPedSittingInAnyVehicle(PlayerPed) or GetVehiclePedIsIn(PlayerPed) ~= CurrentVehicle then
		TriggerEvent("MpGameMessage:send", "Delivery End", "You will lose the safety deposit as your car is either broken or lost.", 3500, 'error')
		FinishDelivery(CurrentType, false)
	else
		TriggerEvent("MpGameMessage:send", "Delivery End", "You finished the deliveries mission", 3500, 'success')
		ReturnVehicle(CurrentType)
	end
end

-- Return the vehicle to system

function ReturnVehicle(deliveryType)
	SetVehicleAsNoLongerNeeded(CurrentVehicle)
	DeleteEntity(CurrentVehicle)
	tAQUA.notify("Your car has been returned")
	FinishDelivery(deliveryType, true)
end

-- When the delivery mission finish

function FinishDelivery(deliveryType, safeReturn)
	if CurrentVehicle ~= nil then
		for i = 0, #CurrentVehicleAttachments do
			DetachEntity(CurrentVehicleAttachments[i])
			DeleteEntity(CurrentVehicleAttachments[i])
		end
		CurrentVehicleAttachments = {}
		DeleteEntity(CurrentVehicle)
	end
	
	CurrentStatus    = Status.DELIVERY_INACTIVE
	starteddpd = false
	CurrentVehicle   = nil
	CurrentSubtitle  = nil
	FinishedJobs     = 0
	DeliveryRoutes   = {}
	DeliveryComplete = {}
	DeliveryLocation = {}
	
	if CurrentBlip ~= nil then
		RemoveBlip(CurrentBlip)
	end
	
	CurrentBlip = nil
	CurrentType = ''
	dpdjob = false
	TriggerServerEvent("AQUA:returnSafe:server", deliveryType, safeReturn)
	
	LoadDefaultPlayerSkin()
end

function DrawGTAText1(A, v, w, a9, aa, ab)
    SetTextFont(0)
    SetTextScale(a9, a9)
    SetTextColour(254, 254, 254, 255)
    if aa then
        SetTextWrap(v - ab, v)
        SetTextRightJustify(true)
    end
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(A)
    EndTextCommandDisplayText(v, w)
end
function DrawGTATimerBar1(ac, A, ad)
    local ab = 0.17
    local ae = -0.01
    local af = 0.038
    local ag = 0.008
    local ah = 0.005
    local ai = 0.32
    local aj = -0.04
    local ak = 0.014
    local al = GetSafeZoneSize()
    local am = ak + al - ab + ab / 2
    local an = aj + al - af + af / 2 - (ad - 1) * (af + ah)
    DrawSprite("timerbars", "all_black_bg", am, an, ab, 0.038, 0, 0, 0, 0, 128)
    DrawGTAText1(ac, al - ab + 0.06, an - ag, ai)
    DrawGTAText1(string.upper(A), al - ae, an - 0.0175, 0.5, true, ab / 2)
end

-- Some helpful functions

function DisplayHelpText(text)
	SetTextComponentFormat('STRING')
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function GetRandomFromRange(a, b)
	return GetRandomIntInRange(a, b)
end

function WaitModelLoad(name)
	RequestModel(name)
	while not HasModelLoaded(name) do
		Wait(0)
	end
end

function Draw2DTextCenter(x, y, text, scale)
    SetTextFont(0)
    SetTextProportional(7)
    SetTextScale(scale, scale)
    SetTextColour(255, 255, 255, 255)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextDropShadow()
    SetTextEdge(4, 0, 0, 0, 255)
    SetTextOutline()
	SetTextCentre(true)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

-- Main thread

Citizen.CreateThread(function()
	blip = AddBlipForCoord(dpdcfg.Base.coords.x, dpdcfg.Base.coords.y, dpdcfg.Base.coords.z)
	SetBlipSprite(blip, 85)
	SetBlipColour(blip, 5)
	SetBlipScale(blip, 0.6)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("DPD Centre")
	EndTextCommandSetBlipName(blip)
end)

-- The other 4 threads

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		HandleInput()
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		HandleLogic()
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		HandleMarkers()
	end
end)

Citizen.CreateThread(function()
	while true do
		if CurrentSubtitle ~= nil then
			Draw2DTextCenter(0.5, 0.88, CurrentSubtitle, 0.7)
		end
		Wait(1)
	end
end)

Citizen.CreateThread(function()
	while true do
		if starteddpd == true then
			DrawGTATimerBar1("Finished Delivery's:", FinishedJobs, 2)
			DrawGTATimerBar1("Total Delivery's:", #DeliveryRoutes, 1)
			
		end
		Wait(1)
	end
end)

RegisterNetEvent('AQUA:startJob:client')
AddEventHandler('AQUA:startJob:client', function(deliveryType)
	TriggerEvent("MpGameMessage:send", "Delivery", "Drive the car safely to the destination and delivery the ~y~goods~s~", 3500, 'success')
	LoadWorkPlayerSkin(deliveryType)
	local ModelHash = GetHashKey("prop_paper_bag_01")
	WaitModelLoad(ModelHash)
	SpawnDeliveryVehicle(deliveryType)
	CreateRoute(deliveryType)
	GetNextDeliveryPoint(true)
	CurrentType   = deliveryType
	CurrentStatus = Status.PLAYER_STARTED_DELIVERY
end)

