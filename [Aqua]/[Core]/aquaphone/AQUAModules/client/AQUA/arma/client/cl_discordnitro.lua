local a = GetGameTimer()
RegisterNetEvent("ARMA:spawnNitroBMX",function()
    if not tARMA.isInComa() and not tARMA.isHandcuffed() and not insideDiamondCasino then --and not isPlayerNearPrison() then
        if GetTimeDifference(GetGameTimer(), a) > 10000 then
            a = GetGameTimer()
            tARMA.notify("~g~Crafting a BMX")
            local b = tARMA.getPlayerPed()
            TaskStartScenarioInPlace(b, "WORLD_HUMAN_HAMMERING", 0, true)
            Wait(5000)
            ClearPedTasksImmediately(b)
            local c = GetEntityCoords(b)
            tARMA.spawnVehicle("bmx", c.x, c.y, c.z, GetEntityHeading(b), true, true, true)
        else
            tARMA.notify("~r~Nitro BMX cooldown, please wait.")
        end
    else
        tARMA.notify("~r~Cannot craft a BMX right now.")
    end
end)
RegisterNetEvent("ARMA:spawnMoped",function()
    if not tARMA.isInComa() and not tARMA.isHandcuffed() and not insideDiamondCasino then --and not isPlayerNearPrison() then
        if GetTimeDifference(GetGameTimer(), a) > 10000 then
            a = GetGameTimer()
            tARMA.notify("~g~Crafting a Moped")
            local b = tARMA.getPlayerPed()
            TaskStartScenarioInPlace(b, "WORLD_HUMAN_HAMMERING", 0, true)
            Wait(5000)
            ClearPedTasksImmediately(b)
            local c = GetEntityCoords(b)
            tARMA.spawnVehicle("faggio", c.x, c.y, c.z, GetEntityHeading(b), true, true, true)
        else
            tARMA.notify("~r~Nitro BMX cooldown, please wait.")
        end
    else
        tARMA.notify("~r~Cannot craft a Moped right now.")
    end
end)
