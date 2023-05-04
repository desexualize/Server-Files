Citizen.CreateThread(function()
    while true do 
        local e=PlayerPedId()
        local f=GetVehiclePedIsIn(PlayerPedId(), false)
        local g=PlayerId()
        if GetSelectedPedWeapon(e)==`WEAPON_UNARMED`then 
            DisableControlAction(0,263,true)
            DisableControlAction(0,264,true)
            DisableControlAction(0,257,true)
            DisableControlAction(0,140,true)
            DisableControlAction(0,141,true)
            DisableControlAction(0,142,true)
            DisableControlAction(0,143,true)
            DisableControlAction(0,24,true)
            DisableControlAction(0,25,true)
        end 
        SetPedCanBeDraggedOut(e,false)
        SetPedConfigFlag(e,149,true)
        SetPedConfigFlag(e,438,true)
        SetPlayerTargetingMode(3)
        RestorePlayerStamina(g,1.0)
        Wait(0)
    end 
end)