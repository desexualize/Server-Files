checkTime = 10 --Minutes
deleteTime = 30 --Seconds

local enumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end
		enum.destructor = nil
		enum.handle = nil
	end
}

local function getEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end
    
		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, enumerator)
    
		local next = true
		repeat 
		coroutine.yield(id)
		next, id = moveFunc(iter)
		until not next
  
		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

function getVehicles()
  return getEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end


RegisterNetEvent("AQUA:VehicleCleanup")
AddEventHandler("AQUA:VehicleCleanup", function()
	TriggerEvent('chatMessage', "^7^*[AQUA]^r All unoccupied vehicles will be deleted in "..deleteTime.." seconds!" , { 128, 128, 128 }, message, "alert")
	SetTimeout(deleteTime * 1000, function()
		theVehicles = getVehicles()
		TriggerEvent('chatMessage', "^7^*[AQUA]^r Vehicle cleanup complete!" , { 128, 128, 128 }, message, "alert")
		for veh in theVehicles do
			if (DoesEntityExist(veh)) then 
				if((GetPedInVehicleSeat(veh, -1)) == false) or ((GetPedInVehicleSeat(veh, -1)) == nil) or ((GetPedInVehicleSeat(veh, -1)) == 0)then
					DeleteEntity(veh)
				end
			end
		end
	end)
end)


RegisterNetEvent("AQUA:EntityCleanUp")
AddEventHandler("AQUA:EntityCleanUp", function()
	TriggerEvent('chatMessage', "^7^*[AQUA]^r All unoccupied vehicles will be deleted in "..deleteTime.." seconds!" , { 128, 128, 128 }, message, "alert")
	SetTimeout(deleteTime * 1000, function()
		TriggerEvent('chatMessage', "^7^*[AQUA]^r Vehicle cleanup complete!" , { 128, 128, 128 }, message, "alert")
		TriggerServerEvent('AQUA:CleanAllAuto')

	end)
end)
