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

local spawned = false
Citizen.CreateThread(function()
    while true do 
      Citizen.Wait(0)
    if tvRP.getPlayerBucket() == 40  and not spawned then
        spawned = true
        local zombie  = AddBlipForRadius(4823.0229492188,-5095.31640625,19.980527877808, 1108.0)
        SetBlipColour(zombie, 0)
        SetBlipAlpha(zombie, 170)
    end
    end 
end)