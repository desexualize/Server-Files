RegisterNetEvent("ERP:announceRestart",function(a, b)
        local c = math.floor(tonumber(a))
        if a ~= nil then
            CreateThread(function()
                    while c ~= -1 do
                        c = c - 1
                        Wait(1000)
                    end
                end) 
            scaleform = nil
            CreateThread(function()
                    while c ~= -1 do
                        scaleform = RequestScaleformMovie("MIDSIZED_MESSAGE")
                        while not HasScaleformMovieLoaded(scaleform) do
                            Wait(0)
                        end
                        BeginScaleformMovieMethod(scaleform, "SHOW_SHARD_MIDSIZED_MESSAGE")
                        if b then
                            ScaleformMovieMethodAddParamTextureNameString("~r~Scheduled Server Restart")
                        else
                            ScaleformMovieMethodAddParamTextureNameString("~r~Unscheduled Server Restart")
                        end
                        if c ~= 0 then
                            ScaleformMovieMethodAddParamTextureNameString("In ~r~" .. c .. "~s~ seconds!")
                        else
                            ScaleformMovieMethodAddParamTextureNameString("~r~Restarting")
                        end
                        EndScaleformMovieMethod()
                        Wait(1000)
                    end
                end)
            CreateThread(function()
                    Wait(200)
                    while true do
                        DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
                        Wait(0)
                    end
                end)
        end
    end)
RegisterNetEvent("ERP:Announce")
AddEventHandler("ERP:Announce",function(d)
        if d ~= nil then
            CreateThread(function()
                    local e = GetGameTimer()
                    local scaleform = RequestScaleformMovie("MIDSIZED_MESSAGE")
                    while not HasScaleformMovieLoaded(scaleform) do
                        Wait(0)
                    end
                    BeginScaleformMovieMethod(scaleform, "SHOW_SHARD_MIDSIZED_MESSAGE")
                    ScaleformMovieMethodAddParamTextureNameString("~y~ERP Announcement")
                    ScaleformMovieMethodAddParamTextureNameString(d)
                    ScaleformMovieMethodAddParamInt(5)
                    ScaleformMovieMethodAddParamBool(true)
                    ScaleformMovieMethodAddParamBool(false)
                    EndScaleformMovieMethod()
                    while e + 6 * 1000 > GetGameTimer() do
                        DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
                        Wait(0)
                    end
                end)
        end
    end)
RegisterNetEvent("ERP:smallAnnouncement",function(f, g, h, i)
        announceMpSmallMsg(f, g, h, i)
    end)


function announceMpSmallMsg(f, g, h, i)
    local j = Scaleform("MIDSIZED_MESSAGE")
    j.RunFunction("SHOW_SHARD_MIDSIZED_MESSAGE", {f, g, h, false, false})
    PlaySoundFrontend(-1, "CHECKPOINT_NORMAL", "HUD_MINI_GAME_SOUNDSET", 1)
    local k = false
    SetTimeout(
        i,
        function()
            k = true
        end
    )
    while not k do
        j.Render2D()
        Wait(0)
    end
end
