local a = {}
local b = {}
local c = {}
Citizen.CreateThread(function()
    if tARMA.isPurge()then return end
    while true do
        local d = tARMA.getPlayerPed()
        local e = tARMA.getPlayerVehicle()
        local f = GetActivePlayers()
        for g, h in pairs(GetGamePool("CVehicle")) do
            if a[h] and b[h] then
                if GetEntitySpeed(h) > 5.0 then
                    if not c[h] then
                        c[h] = true
                        if GetPedInVehicleSeat(h, -1) ~= 0 then
                            SetEntityNoCollisionEntity(d, h)
                            SetEntityNoCollisionEntity(h, d)
                        end
                        for g, i in pairs(f) do
                            local j = GetPlayerPed(i)
                            SetEntityNoCollisionEntity(e, j)
                            SetEntityNoCollisionEntity(j, e)
                        end
                    end
                elseif c[h] then
                    c[h] = nil
                    if GetPedInVehicleSeat(h, -1) ~= 0 then
                        SetEntityNoCollisionEntity(d, h, true)
                        SetEntityNoCollisionEntity(h, d, true)
                    end
                    for g, i in pairs(f) do
                        local j = GetPlayerPed(i)
                        SetEntityNoCollisionEntity(e, j, true)
                        SetEntityNoCollisionEntity(j, e, true)
                    end
                end
            end
        end
        Wait(0)
    end
end)
Citizen.CreateThread(function()
    if tARMA.isPurge()then return end
    while true do
        for g, h in pairs(GetGamePool("CVehicle")) do
            if a[h] == nil then
                local k = GetVehicleClass(h)
                if k ~= 14 and k ~= 15 and k ~= 16 then
                    a[h] = true
                else
                    a[h] = false
                end
            end
        end
        Wait(250)
    end
end)
Citizen.CreateThread(function()
    if tARMA.isPurge()then return end
    while true do
        local l = tARMA.getPlayerCoords()
        for g, h in pairs(GetGamePool("CVehicle")) do
            if #(l - GetEntityCoords(h)) < 50.0 then
                b[h] = true
            else
                b[h] = nil
            end
        end
        Wait(250)
    end
end)
