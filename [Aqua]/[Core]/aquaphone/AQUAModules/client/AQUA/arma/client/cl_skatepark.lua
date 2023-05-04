local a = {
    {position = vector3(-933.89794921875, -808.49810791016, 15.908717155457), carName = "BMX", carID = "bmx"},
    --{position = vector3(1253.1735839844, 4804.3740234375, -39.328578948975), carName = "Caddy", carID = "caddy3"}
}
local cd = 0
AddEventHandler("ARMA:onClientSpawn",function(b, c)
    if c then
        local d = function(e)
            PlaySound(-1, "Hit", "RESPAWN_SOUNDSET", 0, 0, 1)
            drawNativeNotification("Press ~INPUT_PICKUP~ spawn a " .. a[e.skateparkId].carName)
        end
        local f = function(e)
        end
        local g = function(e)
            print(GetGameTimer(), cd)
            print(GetGameTimer() - cd)
            if IsControlJustPressed(1, 38)  then
                if GetGameTimer() - cd > 60000 then
                    local h = tARMA.loadModel(a[e.skateparkId].carID)
                    local i = CreateVehicle(h,a[e.skateparkId].position.x,a[e.skateparkId].position.y,a[e.skateparkId].position.z + 0.5,0.0,true,false)
                    DecorSetInt(i, "ARMAACVeh", 955)
                    SetVehicleOnGroundProperly(i)
                    SetEntityInvincible(i, false)
                    SetPedIntoVehicle(tARMA.getPlayerPed(), i, -1)
                    SetModelAsNoLongerNeeded(h)
                    cd = GetGameTimer()
                else
                    tARMA.notify('~r~Please wait before spawning another BMX.')
                end
            end
        end
        for j, k in pairs(a) do
            tARMA.createArea("skatepark_" .. j, k.position, 1.5, 6, d, f, g, {skateparkId = j})
            tARMA.addMarker(k.position.x,k.position.y,k.position.z,1.0,1.0,1.0,255,0,0,170,50,38,false,false,true)
        end
    end
end)
