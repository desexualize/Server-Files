function loadScaleform(a)
    local b = RequestScaleformMovie(a)
    while not HasScaleformMovieLoaded(b) do
        Wait(0)
    end
    return b
end
local c = "https://www.youtube.com/embed/lX_IN4v-RnA?version=3&fs=1&autoplay=1&loop=1&playlist=lX_IN4v-RnA"
local d = "https://www.youtube.com/embed/n9v-2xF54HM?version=3&fs=1&disablekb=1&modestbranding=1&mute=1&autoplay=1&loop=1&playlist=n9v-2xF54HM"
local e = 0.2
local f = "generic_texture_renderer"
local g = 1280
local h = 720
local i
local j = false
local k
local l
function CreateNamedRenderTargetForModel(m, n)
    local o = 0
    if not IsNamedRendertargetRegistered(m) then
        RegisterNamedRendertarget(m, 0)
    end
    if not IsNamedRendertargetLinked(n) then
        LinkNamedRendertarget(n)
    end
    if IsNamedRendertargetRegistered(m) then
        o = GetNamedRendertargetRenderId(m)
    end
    return o
end
local p = false
function jimmy()
    if p then
        return
    end
    p = true
    print("jimmy tv lego!")
    local n = "des_tvsmash_start"
    local q = vector3(-810.59, 170.46, 77.25)
    local r = GetClosestObjectOfType(q.x, q.y, q.z, 0.05, n, 0, 0, 0)
    local o = CreateNamedRenderTargetForModel("tvscreen", n)
    txd = CreateRuntimeTxd("meows")
    k = CreateDui(c, g, h)
    dui = GetDuiHandle(k)
    tx = CreateRuntimeTextureFromDuiHandle(txd, "woof", dui)
    local s = vector3(-808.93231201172, 170.99266052246, 76.74536895752)
    notify("Go to ~p~Jimmy's room~w~ in Michael's house to stop the music.")
    SetNewWaypoint(s.x, s.y)
    while true do
        if #(tARMA.getPlayerCoords() - s) < 4.0 then
            drawNativeNotification("Press ~INPUT_PICKUP~ to turn the TV off")
            if IsControlJustPressed(0, 38) then
                DestroyDui(k)
                p = false
                return
            end
        end
        SetTextRenderId(o)
        SetScriptGfxDrawOrder(4)
        SetScriptGfxDrawBehindPausemenu(1)
        DrawSprite("meows", "woof", 0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
        SetTextRenderId(GetDefaultScriptRendertargetRenderId())
        SetScriptGfxDrawBehindPausemenu(0)
        Citizen.Wait(0)
    end
end
RegisterCommand("jimmy",function()
    jimmy()
end)
local r = {}
r.VideoType = "CASINO_DIA_PL"
local s = nil
local t = false
function startCasinoThreads()
    RequestStreamedTextureDict("Prop_Screen_Vinewood")
    while not HasStreamedTextureDictLoaded("Prop_Screen_Vinewood") do
        Citizen.Wait(100)
    end
    RegisterNamedRendertarget("casinoscreen_01")
    LinkNamedRendertarget("vw_vwint01_video_overlay")
    s = GetNamedRendertargetRenderId("casinoscreen_01")
    Citizen.CreateThread(function()
        local u = 0
        while true do
            Citizen.Wait(0)
            if not insideDiamondCasino then
                ReleaseNamedRendertarget("casinoscreen_01")
                s = nil
                t = false
                break
            end
            if s then
                local v = GetGameTimer()
                if t then
                    setVideoWallTvChannelWin()
                    u = GetGameTimer() - 33666
                    t = false
                else
                    if v - u >= 42666 then
                        setVideoWallTvChannel()
                        u = v
                    end
                end
                SetTextRenderId(s)
                SetScriptGfxDrawOrder(4)
                SetScriptGfxDrawBehindPausemenu(true)
                DrawInteractiveSprite("Prop_Screen_Vinewood","BG_Wall_Colour_4x4",0.25,0.5,0.5,1.0,0.0,255,255,255,255)
                DrawTvChannel(0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
                SetTextRenderId(GetDefaultScriptRendertargetRenderId())
            end
        end
    end)
end
function setVideoWallTvChannel()
    SetTvChannelPlaylist(0, r.VideoType, true)
    SetTvAudioFrontend(true)
    SetTvVolume(-100.0)
    SetTvChannel(0)
end
function setVideoWallTvChannelWin()
    SetTvChannelPlaylist(0, "CASINO_WIN_PL", true)
    SetTvAudioFrontend(true)
    SetTvVolume(-100.0)
    SetTvChannel(-1)
    SetTvChannel(0)
end
AddEventHandler("ARMA:enteredDiamondCasino",function()
    insideDiamondCasino = true
    startCasinoThreads()
end)

AddEventHandler("ARMA:exitedDiamondCasino",function()
    insideDiamondCasino = false
end)