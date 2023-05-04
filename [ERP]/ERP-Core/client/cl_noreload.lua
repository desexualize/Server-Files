Citizen.CreateThread(function()
    while true do 
        if IsPedReloading(GetPlayerPed(-1)) then  
            DisableControlAction(1, 323, true)
        end  
        Citizen.Wait(0) 
    end
end)