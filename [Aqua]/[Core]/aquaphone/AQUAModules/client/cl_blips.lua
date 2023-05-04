Citizen.CreateThread(function() 
    for k, v in pairs(blips.mapblips) do
        local blip = AddBlipForCoord(v.coords)
        SetBlipSprite(blip, v.sprite)
        SetBlipScale(blip, 0.55)
        SetBlipDisplay(blip, 2)
        SetBlipColour(blip, v.colour)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.type)
        EndTextCommandSetBlipName(blip)
    end
end) 


local cocaine  = AddBlipForRadius(143.98948669434,-1299.4553222656,29.062242507935, 50.0)
SetBlipColour(cocaine, 0)
SetBlipAlpha(cocaine, 120)
