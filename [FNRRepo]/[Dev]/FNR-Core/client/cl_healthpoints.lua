

local HealthPoints = {
    {-254.53, 6332.55, 32.42},
    {308.17, -592.17, 43.30},
    {1832.58, 3682.88, 34.27},
}

Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(0)
        for k,v in pairs(HealthPoints) do
            local x,y,z = v[1], v[2], v[3]
            local Ped = PlayerPedId()
            local Coords = GetEntityCoords(Ped)
            if #(vec3(x,y,z) - Coords) < 10.0 then
                DrawMarker(27, x,y,z-0.99, 0, 0, 0, 0, 0, 0, 0.99, 0.99, 0.99, 0, 233, 32, 175, 0, 0, 0, 1, 0, 0, 0)
            end
            if #(vec3(x,y,z) - Coords) < 1.0 then
                alert('Press ~INPUT_PICKUP~ to get Medical Attention.')
                if IsControlJustPressed(1,38) then
                    if GetEntityHealth(Ped) < 200 then
                        if GetEntityHealth(Ped) > 102 then
                            SetEntityHealth(Ped, 200)
                            notify("~g~You have been healed.")
                        else
                            notify("~r~You Cant heal while dead.")
                        end
                    else
                        notify("~g~You are healthy.")
                    end
                end
            end
        end
    end
end)

function alert(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0,0,1,-1)
end

function notify(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(true, true)
end