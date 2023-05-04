function Scaleform(a)
    local b = {}
    local a = RequestScaleformMovie(a)
    while not HasScaleformMovieLoaded(a) do
        Citizen.Wait(0)
    end
    b.RunFunction = function(c, d)
        BeginScaleformMovieMethod(a, c)
        for e = 1, #d do
            local f = d[e]
            if type(f) == "string" then
                BeginTextCommandScaleformString("STRING")
                AddTextComponentSubstringPlayerName(f)
                EndTextCommandScaleformString()
            elseif type(f) == "number" then
                ScaleformMovieMethodAddParamInt(f)
            elseif type(f) == "boolean" then
                ScaleformMovieMethodAddParamBool(f)
            elseif type(f) == "float" then
                ScaleformMovieMethodAddParamFloat(f)
            elseif type(f) == "function" then
                f()
            end
        end
        EndScaleformMovieMethod()
    end
    b.Render2D = function()
        DrawScaleformMovieFullscreen(a, 255, 255, 255, 255, 0)
    end
    b.Render3D = function(g, h, i)
        DrawScaleformMovie_3dSolid(a, g.x, g.y, g.z, h.x, h.y, h.z, 2.0, 2.0, 1.0, i.x, i.x, i.x, 2)
    end
    b.Handle = a
    return b
end
