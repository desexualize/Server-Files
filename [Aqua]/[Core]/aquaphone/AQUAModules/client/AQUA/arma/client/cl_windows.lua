local a = true
RegisterCommand("roll",function(b, c, d)
    local e = tARMA.getPlayerPed()
    if IsPedInAnyVehicle(e, false) then
        local f = GetVehiclePedIsIn(e, false)
        if GetPedInVehicleSeat(f, -1) == e then
            SetEntityAsMissionEntity(f, true, true)
            if a then
                RollDownWindow(f, 0)
                RollDownWindow(f, 1)
                TriggerEvent("chatMessage", "", {255, 0, 0}, "Windows down")
                a = false
            else
                RollUpWindow(f, 0)
                RollUpWindow(f, 1)
                TriggerEvent("chatMessage", "", {255, 0, 0}, "Windows up")
                a = true
            end
        end
    end
end,false)
