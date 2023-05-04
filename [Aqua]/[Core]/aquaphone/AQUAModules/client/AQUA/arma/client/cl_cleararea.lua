local a = {
    ["trflat"] = "trflat",
    ["TRAILERS"] = "TRAILERS",
    ["DockTrailer"] = "DockTrailer",
    ["heli1"] = "heli1",
    ["militaire1"] = "militaire1",
    ["bvttanker"] = "bvttanker",
    ["tr4"] = "tr4"
}
RegisterNetEvent("ARMA:clearVehicles",function()
    for b, c in pairs(GetGamePool("CVehicle")) do
        if NetworkHasControlOfEntity(c) then
            if GetPedInVehicleSeat(c, -1) == 0 and c ~= GetVehiclePedIsIn(tARMA.getPlayerPed(), true) then
                if a[GetEntityModel(c)] == nil and GetEntityModel(c) ~= "gto2" then
                    DeleteEntity(c)
                end
            end
        end
    end
end)
RegisterNetEvent("ARMA:clearBrokenVehicles",function()
    for b, c in pairs(GetGamePool("CVehicle")) do
        if NetworkHasControlOfEntity(c) then
            if GetPedInVehicleSeat(c, -1) == 0 and c ~= GetVehiclePedIsIn(tARMA.getPlayerPed(), true) then
                if GetVehicleEngineHealth(c) <= 200.0 then
                    if a[GetEntityModel(c)] == false then
                        DeleteEntity(c)
                    end
                end
            end
        end
    end
    for b, d in pairs(GetGamePool("CPed")) do
        if NetworkHasControlOfEntity(d) then
            if GetPedType(d) == 28 then
                if IsPedDeadOrDying(d, 1) then
                    DeletePed(d)
                end
            end
        end
    end
end)
