local a = false
local b = 0
RegisterNetEvent("ARMA:chatFilterScaleform",function(c, d)
    a = not a
    Citizen.Wait(10)
    b = b + 1
    if b > 2 then
        b = 2
    end
    local e = GetGameTimer()
    local f = RequestScaleformMovie("mp_big_message_freemode")
    while not HasScaleformMovieLoaded(f) do
        Citizen.Wait(0)
    end
    while GetGameTimer() - e < c * 1000 and (a or b == 2) do
        Citizen.Wait(0)
        BeginScaleformMovieMethod(f, "SHOW_SHARD_WASTED_MP_MESSAGE")
        ScaleformMovieMethodAddParamTextureNameString("~r~WARNING")
        ScaleformMovieMethodAddParamTextureNameString(d)
        ScaleformMovieMethodAddParamInt(5)
        EndScaleformMovieMethod()
        DrawScaleformMovieFullscreen(f, 255, 255, 255, 255)
    end
end)
