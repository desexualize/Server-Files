local a = {
    vector3(-815.59008789063, -182.16806030273, 37.568920135498),
    vector3(139.21583557129, -1708.9689941406, 29.301620483398),
    vector3(-1281.9802246094, -1119.6861572266, 7.0001249313354),
    vector3(1934.115234375, 3730.7399902344, 32.854434967041),
    vector3(1211.0759277344, -475.00064086914, 66.218032836914),
    vector3(-34.97777557373, -150.9037322998, 57.086517333984),
    vector3(-280.37301635742, 6227.017578125, 31.705526351929)
}

AddEventHandler("ARMA:onClientSpawn",function(D, E)
    if E then
        local d = function()
            drawNativeNotification("Press ~INPUT_PICKUP~ to get a haircut.")
            PlaySound(-1, "SELECT", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1)
        end
        local e = function()
        end
        local f = function()
            if IsControlJustPressed(1, 51) then
                TriggerEvent("ARMA:openBarbershop")
            end
        end
        for g, h in pairs(a) do
            tARMA.createArea("barbershop_" .. g, h, 1.5, 6, d, e, f)
            tARMA.addMarker(h.x, h.y, h.z - 0.2, 0.5, 0.5, 0.5, 0, 50, 255, 170, 50, 20, false, false, true)
            tARMA.addBlip(h.x, h.y, h.z, 71, 13, "Barber Shop")
        end
    end
end)