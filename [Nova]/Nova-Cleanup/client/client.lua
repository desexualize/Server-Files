--------------------------------------
------Created By Whit3Xlightning------
--https://github.com/Whit3XLightning--
--------------------------------------

local function Is_Vehicle_Occupied(vehicle)
    for i = -1, 8 do 
        if GetPedInVehicleSeat(vehicle, i) ~= 0 then
            return true
        end
    end
    return false
end

RegisterNetEvent("Nova:delallveh")
AddEventHandler("Nova:delallveh", function ()
    for vehicle in EnumerateVehicles() do
        if GetVehicleDoorLockStatus(vehicle) == 1 and not Is_Vehicle_Occupied(vehicle) then
            SetVehicleHasBeenOwnedByPlayer(vehicle, false) 
            SetEntityAsMissionEntity(vehicle, false, false) 
            DeleteVehicle(vehicle)
            if (DoesEntityExist(vehicle)) then 
                DeleteVehicle(vehicle) 
            end
        end
    end
end)

function notify(string)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(string)
    EndTextCommandThefeedPostTicker(true, false)
end