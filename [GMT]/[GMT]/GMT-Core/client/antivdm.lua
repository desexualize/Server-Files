Citizen.CreateThread(function()
    while true do 
        local ped = PlayerPedId()
        local vehiclecheck = GetVehiclePedIsIn(ped, false)
        local players = GetActivePlayers()
        for d,e in pairs(GetGamePool("CVehicle"))do 
            local VehicleC = GetVehicleClass(e)
            if f~=14 and f~=15 and f~=16 then 
                if GetEntitySpeed(e) > 2.0 then 
                    if GetPedInVehicleSeat(e, -1) ~= 0 then 
                        SetEntityNoCollisionEntity(ped, e, true)
                        SetEntityNoCollisionEntity(e, ped, true)
                    end;
                    for d,g in pairs(players) do 
                        local h=GetPlayerPed(g)
                        SetEntityNoCollisionEntity(vehiclecheck, h, true)
                        SetEntityNoCollisionEntity(h, vehiclecheck, true)
                    end 
                end 
            end
         end;
         Wait(0)
        end 
    end)