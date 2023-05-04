RegisterCommand("bodybag",function()
    local a = tARMA.getNearestPlayer(3)
    if a then
        TriggerServerEvent("ARMA:requestBodyBag", a)
    else
        tARMA.notify("No one dead nearby")
    end
end)

RegisterNetEvent("ARMA:removeIfOwned",function(b)
    local c = tARMA.getObjectId(b, "bodybag_removeIfOwned")
    if c then
        if DoesEntityExist(c) then
            if NetworkHasControlOfEntity(c) then
                DeleteEntity(c)
            end
        end
    end
end)

RegisterNetEvent("ARMA:placeBodyBag",function()
    local d = tARMA.getPlayerPed()
    local e = GetEntityCoords(d)
    local f = GetEntityHeading(d)
    SetEntityVisible(d, false, 0)
    local g = tARMA.loadModel("xm_prop_body_bag")
    local h = CreateObject(g, e.x, e.y, e.z, true, true, true)
    DecorSetInt(h, "ARMAACVeh", 955)
    PlaceObjectOnGroundProperly(h)
    SetModelAsNoLongerNeeded(g)
    local b = ObjToNet(h)
    TriggerServerEvent("ARMA:removeBodybag", b)
    while GetEntityHealth(tARMA.getPlayerPed()) <= 102 do
        Wait(0)
    end
    DeleteEntity(h)
    SetEntityVisible(d, true, 0)
end)
