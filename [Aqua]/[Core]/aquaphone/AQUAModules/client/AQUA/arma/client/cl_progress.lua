local a = {}
a.From = 0
a.To = 100
a.Async = true
a.Duration = 5000
a.Label = "Loading..."
a.LabelPosition = "bottom"
a.Color = "rgba(255, 255, 255, 1.0)"
a.BGColor = "rgba(0, 0, 0, 0.4)"
a.x = 0.5
a.y = 0.5
a.Rotation = 0
a.MaxAngle = 360
a.Radius = 50
a.Stroke = 10
a.Width = 300
a.Height = 40
a.Cap = "butt"
a.Padding = 0
a.CancelKey = 178
a.ShowTimer = true
a.ShowProgress = false
a.Easing = "easeLinear"
a.DisableControls = {Mouse = false, Player = false, Vehicle = false}
a.onStart = function()
end
a.onComplete = function()
end
a.MiniGameOptions = {
    MaxAngle = 240,
    Rotation = -120,
    Radius = 100,
    Stroke = 30,
    Difficulty = {
        Custom = {Zone = 40, Duration = 1000},
        Easy = {Zone = 30, Duration = 500},
        Medium = {Zone = 20, Duration = 500},
        Hard = {Zone = 10, Duration = 500}
    }
}
local function b(c)
    local d = {}
    local function e(c)
        if type(c) ~= "table" then
            return c
        elseif d[c] then
            return d[c]
        end
        local f = {}
        d[c] = f
        for g, h in pairs(c) do
            f[e(g)] = e(h)
        end
        return setmetatable(f, getmetatable(c))
    end
    return e(c)
end
local function i(j, k)
    local e = b(j)
    for l, m in pairs(k) do
        if type(m) == "table" then
            if type(e[l] or false) == "table" then
                i(e[l] or {}, k[l] or {})
            else
                e[l] = m
            end
        else
            e[l] = m
        end
    end
    return e
end
local function n(o)
    o = "======== RPROGRESS ERROR: " .. o .. " ========"
    local p = string.rep("=", string.len(o))
    print(p)
    print(o)
    print(p)
end
local function q(r)
    if type(r) ~= "table" then
        n("options must be type:table")
        return true
    end
    for l, m in pairs(r) do
        local s = false
        if l ~= "onStart" and l ~= "onComplete" and l ~= "onTimeout" then
            if
                l == "ShowTimer" or l == "ShowProgress" or l == "Async" or l == "MiniGame" or l == "Loop" or
                    l == "canCancel"
             then
                if type(m) ~= "boolean" then
                    s = {prop = l, type = "boolean"}
                end
            elseif
                l == "Label" or l == "Color" or l == "BGColor" or l == "LabelPosition" or l == "Easing" or l == "Cap" or
                    l == "Type"
             then
                if type(m) ~= "string" then
                    s = {prop = l, type = "string"}
                end
            elseif l == "DisableControls" then
                for t, u in pairs(m) do
                    if type(u) ~= "boolean" then
                        s = {prop = l .. "." .. t, type = "boolean"}
                    end
                end
            elseif l == "Animation" then
                for t, u in pairs(m) do
                    if t == "flag" then
                        if tonumber(u) == nil then
                            s = {prop = l, type = "number"}
                        end
                    else
                        if type(u) ~= "string" then
                            s = {prop = l .. "." .. t, type = "string"}
                        end
                    end
                end
            else
                if tonumber(m) == nil then
                    s = {prop = l, type = "number"}
                end
            end
            if s ~= false then
                n("param '" .. s.prop .. "' must be type:" .. s.type)
                return true
            end
        end
    end
    return false
end
local function v(w)
    if not HasAnimDictLoaded(w) then
        RequestAnimDict(w)
        while not HasAnimDictLoaded(w) do
            Citizen.Wait(1)
        end
    end
end
local function x(o)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(o)
    EndTextCommandThefeedPostTicker(false, true)
end
local y = nil
local z = nil
local A = nil
local B = false
local C = nil
local D = false
local function E(F, G, H, I)
    if type(F) ~= "string" then
        n("param 'text' must be type:string")
        return
    end
    if I then
        z = I
    end
    if tonumber(G) == nil then
        n("param 'duration' must be type:number")
        return
    end
    local r = i(a, {display = true, Duration = G, Label = F})
    if H ~= nil then
        r.Type = "linear"
    end
    r.Async = false
    r.MiniGame = false
    r.onStart = nil
    r.onComplete = nil
    SendNUIMessage(r)
    B = true
    while B do
        DisableControls(r)
        Citizen.Wait(1)
    end
end
local function J()
    if C ~= nil then
        local K = PlayerPedId()
        if DoesEntityExist(K) and not IsEntityDead(K) then
            if C.scenario ~= nil then
                ClearPedTasks(K)
            else
                if C.animationDictionary ~= nil and C.animationName ~= nil then
                    StopAnimTask(K, C.animationDictionary, C.animationName, 1.0)
                end
            end
        end
    end
end
local function L(r, M)
    if q(r) then
        return
    end
    local N = {Mouse = a.DisableControls.Mouse, Player = a.DisableControls.Player, Vehicle = a.DisableControls.Vehicle}
    if r.DisableControls ~= nil then
        N = r.DisableControls
    end
    r = i(a, r)
    r.DisableControls = i(a.DisableControls, N)
    r.display = true
    if r.ShowProgress == true then
        r.ShowTimer = false
    end
    y = r.onStart
    z = r.onComplete
    A = r.onTimeout
    C = nil
    if r.Animation ~= nil then
        C = r.Animation
    end
    r.onStart = nil
    r.onComplete = nil
    r.onTimeout = nil
    if M == true then
        return r
    end
    if r.MiniGame then
        SetNuiFocus(true, true)
    end
    SendNUIMessage(r)
    B = true
    if r.Async == false then
        while B do
            if IsControlJustPressed(0, a.CancelKey) and r.canCancel then
                z(true)
                TriggerEvent("rprogress:stop")
            end
            DisableControls(r)
            Citizen.Wait(1)
        end
        J()
    else
        Citizen.CreateThread(function()
            while B do
                if IsControlJustPressed(0, a.CancelKey) and r.canCancel then
                    z(true)
                    TriggerEvent("rprogress:stop")
                end
                DisableControls(r)
                Citizen.Wait(0)
            end
        end)
    end
end
local function O(F, G)
    E(F, G, true)
end
local function P()
    SendNUIMessage({stop = true})
end
local function Q(R)
    local r = L(R, true)
    r.display = false
    r.static = true
    SendNUIMessage(r)
    return {Show = function()
            r.hide = false
            r.show = true
            r.progress = false
            SendNUIMessage(r)
        end, SetProgress = function(S)
            r.hide = false
            r.show = true
            r.progress = tonumber(S)
            if r.progress < 0 then
                r.progress = 0
            elseif r.progress > 100 then
                r.progress = 100
            end
            SendNUIMessage(r)
        end, Hide = function()
            r.show = false
            r.hide = true
            r.progress = false
            SendNUIMessage(r)
        end, Destroy = function()
            r.show = false
            r.hide = false
            r.progress = false
            r.destroy = true
            SendNUIMessage(r)
        end}
end
local function T(r)
    if B then
        return
    end
    D = false
    r = i(a.MiniGameOptions, r)
    if r.Zone == nil and r.Duration == nil then
        local U = "Easy"
        if r.Difficulty ~= nil then
            U = r.Difficulty
        end
        r.Zone = a.MiniGameOptions.Difficulty[U].Zone
        r.Duration = a.MiniGameOptions.Difficulty[U].Duration
    end
    r.Difficulty = nil
    r.MiniGame = true
    L(r)
    if r.Timeout ~= nil and r.Timeout > 0 then
        Citizen.SetTimeout(r.Timeout,function()
            if A ~= nil and type(A) == "function" then
                if not D then
                    P()
                    A()
                end
            end
        end)
    end
end
function DisableControls(r)
    if r.DisableControls.Mouse then
        DisableControlAction(1, 1, true)
        DisableControlAction(1, 2, true)
        DisableControlAction(1, 106, true)
    end
    if r.DisableControls.Player then
        DisableControlAction(0, 21, true)
        DisableControlAction(0, 30, true)
        DisableControlAction(0, 31, true)
        DisableControlAction(0, 36, true)
    end
    if r.DisableControls.Vehicle then
        DisableControlAction(0, 71, true)
        DisableControlAction(0, 72, true)
        DisableControlAction(0, 75, true)
    end
end
local function V()
    if C ~= nil then
        local K = PlayerPedId()
        if DoesEntityExist(K) and not IsEntityDead(K) then
            Citizen.CreateThread(function()
                if C.scenario ~= nil then
                    TaskStartScenarioInPlace(K, C.scenario, 0, true)
                else
                    if C.animationDictionary ~= nil and C.animationName ~= nil then
                        if C.flag == nil then
                            C.flag = 1
                        end
                        RequestAnimDict(C.animationDictionary)
                        TaskPlayAnim(K, C.animationDictionary, C.animationName, 3.0, 1.0, -1, C.flag, 0, 0, 0, 0)
                        RemoveAnimDict(C.animationDictionary)
                    end
                end
            end)
        end
    end
end
local function W()
    B = false
    SetNuiFocus(false, false)
end
W()
RegisterNUICallback("progress_start",function(X, I)
    if y ~= nil then
        y()
    end
    I("ok")
end)
RegisterNUICallback("progress_complete",function(X, I)
    W()
    if z ~= nil then
        z()
        J()
    end
    I("ok")
end)
RegisterNUICallback("progress_stop",function(X, I)
    W()
    J()
    I("ok")
end)
RegisterNUICallback("progress_minigame_input",function(X, I)
    D = true
    if z ~= nil then
        z(X.success == true)
    end
    J()
    I("ok")
end)
RegisterNUICallback("progress_minigame_complete",function(X, I)
    W()
    I("ok")
end)
RegisterNetEvent("rprogress:start")
RegisterNetEvent("rprogress:stop")
RegisterNetEvent("rprogress:custom")
RegisterNetEvent("rprogress:linear")
RegisterNetEvent("rprogress:minigame")
AddEventHandler("rprogress:start", E)
AddEventHandler("rprogress:stop", P)
AddEventHandler("rprogress:custom",function(r)
    r.Async = false
    r.onStart = nil
    r.onComplete = nil
    L(r)
end)
AddEventHandler("rprogress:linear", O)
AddEventHandler("rprogress:minigame", T)
exports("progressStart", E)
exports("progressCustom", L)
exports("progressStop", P)
exports("progressStatic", Q)
exports("progressLinear", O)
exports("progressMiniGame", T)
tARMA.startCircularProgressBar = E
tARMA.customCircularProgressBar = L
tARMA.stopCircularProgressBar = P
tARMA.staticCircularProgressBar = Q
tARMA.linerCircularProgressBar = O
tARMA.minigameCircularProgressBar = T
