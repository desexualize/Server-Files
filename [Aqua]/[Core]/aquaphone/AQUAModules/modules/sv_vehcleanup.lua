local CheckTime = 1
deleteTime = 30 --Seconds

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(600000)
        VehCleanup()
	end
end)

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(3600000)
        entityCleanup()
	end
end)


function VehCleanup()
    TriggerClientEvent("AQUA:VehicleCleanup", -1)
end

function entityCleanup()
    TriggerClientEvent("AQUA:EntityCleanup", -1)
end

RegisterNetEvent('AQUA:CleanAllAuto')
AddEventHandler('AQUA:CleanAllAuto', function()
        for i,v in pairs(GetAllVehicles()) do 
            DeleteEntity(v)
            print(v)
        end
        for i,v in pairs(GetAllPeds()) do 
            DeleteEntity(v)
        end
        for i,v in pairs(GetAllObjects()) do
            DeleteEntity(v)
    end
end)




RegisterCommand('entity', function(source, args, RawCommand)
    local user_id = AQUA.getUserId(source)
    if AQUA.hasPermission(user_id, "admin.tickets") then
    TriggerClientEvent('AQUA:EntityCleanUp', -1)
    end
end)
