Citizen.CreateThread(function()
    while true do
        if IsControlJustPressed(1, 82) then
            local veh, name, nveh = tvRP.getNearestOwnedVehicle(5)
            if veh then 
                tvRP.vc_toggleLock(name)
                tvRP.playSound("HUD_MINI_GAME_SOUNDSET", "5_SEC_WARNING")
            end
        end
        Citizen.Wait(1)
    end
end)
