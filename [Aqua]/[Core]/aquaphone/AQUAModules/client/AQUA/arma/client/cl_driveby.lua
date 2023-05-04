local function a()
    local b = tARMA.getPlayerVehicle()
    if b ~= 0 then
        local c = tARMA.getPlayerPed()
        local d = tARMA.getPlayerId()
        if GetVehicleClass(b) == 8 then
            if GetPedInVehicleSeat(b, -1) == c or GetSelectedPedWeapon(c) == GetHashKey("WEAPON_UNARMED") then
                SetPlayerCanDoDriveBy(d, false)
            else
                SetPlayerCanDoDriveBy(d, true)
            end
        elseif GetVehicleClass(b) == 15 and globalOnPoliceDuty then
            SetPlayerCanDoDriveBy(d, true)
        else
            SetPlayerCanDoDriveBy(d, false)
        end
        DisableControlAction(0, 69, true)
        DisableControlAction(0, 70, true)
        DisableControlAction(0, 114, true)
        DisableControlAction(0, 331, true)
    end
end
tARMA.createThreadOnTick(a)
