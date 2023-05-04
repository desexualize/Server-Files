local Client_Player = PlayerId()
local Client_Ped = PlayerPedId()
local Client_Vehicle = GetVehiclePedIsIn(Client_Ped, false)
local Active_Peds = {}
local Active_Vehicles = {}

Citizen.CreateThread(function()
    while true do
        Client_Ped = PlayerPedId()
        Client_Vehicle = GetVehiclePedIsIn(Client_Ped, false)
        
        Active_Peds = {}
        Active_Vehicles = {}
        for _, i in ipairs(GetActivePlayers()) do
            if i ~= Client_Player then
                local player_ped = GetPlayerPed(i)
                table.insert(Active_Peds, player_ped)

                local player_vehicle = GetVehiclePedIsIn(player_ped, false)
                if player_vehicle ~= 0 then
                    table.insert(Active_Vehicles, player_vehicle)
                end
            end
        end
        Citizen.Wait(2000)
    end
end)

local function Is_Vehicle_Occupied(vehicle)
    for i = -1, 8 do 
        if GetPedInVehicleSeat(vehicle, i) ~= 0 then
            return true
        end
    end
    return false
end

Citizen.CreateThread(function()
    while true do
        for _, player_ped in ipairs(Active_Peds) do
            SetPedAsEnemy(player_ped, true)
            if Client_Vehicle ~= 0 then
                SetEntityNoCollisionEntity(player_ped, Client_Vehicle, true)
            end
        end

        for _, player_vehicle in ipairs(Active_Vehicles) do
            local vehicle_type = GetVehicleType(player_vehicle)
            if vehicle_type ~= 'plane' and vehicle_type ~= 'submarine' and vehicle_type ~= 'boat' then
                if Is_Vehicle_Occupied(player_vehicle) then
                    SetEntityNoCollisionEntity(player_vehicle, Client_Ped, true)
                end
            end

            if setDrawGreenZoneUI then
                SetEntityNoCollisionEntity(player_vehicle, Client_Vehicle, true)
            end
        end

        Citizen.Wait(1)
    end
end)