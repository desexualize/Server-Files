local a = module("cfg/cfg_radios")
local b = {}
local c = 0
function tARMA.isInRadioChannel()
    return c ~= 0
end
local function d()
    SendNUIMessage({radioClear = true})
end
local function e(f)
    SendNUIMessage({radioVisibility = true, isVisible = f})
end
local function g(h)
    SendNUIMessage({radioHeader = true, name = h})
end
local function i(j, h, k)
    SendNUIMessage({radioAdd = true, playerSrc = j, name = h, sortOrder = k})
end
local function l(j)
    SendNUIMessage({radioRemove = true, playerSrc = j})
end
local function m(j, n)
    SendNUIMessage({radioTalking = true, playerSrc = j, isTalking = n})
end
local function o(j, p)
    SendNUIMessage({radioMuted = true, playerSrc = j, isMuted = p})
end
RegisterNetEvent("ARMA:radiosAddPlayer",function(q, j, r)
    local s = b[q]
    if not s then
        return
    end
    s.players[j] = r
    if q == c then
        i(j, r.name, r.sortOrder)
    end
end)
RegisterNetEvent("ARMA:radiosRemovePlayer",function(q, j)
    local s = b[q]
    if not s then
        return
    end
    s.players[j] = nil
    if q == c then
        l(j)
    end
end)
local function t()
    exports["pma-voice"]:setRadioChannel(0)
    e(false)
    d()
    c = 0
end
RegisterNetEvent("ARMA:radiosClearAll",function()
    t()
    b = {}
end)
RegisterNetEvent("pma-voice:setTalkingOnRadio",function(j, n)
    --print("pma-voice:setTalkingOnRadio", j, n)
    m(j, n)
end)
AddEventHandler("pma-voice:radioActive",function(n)
    m(GetPlayerServerId(PlayerId()), n)
    if n then
        exports["pma-voice"]:overrideProximityRange(0.75, true)
    else
        exports["pma-voice"]:clearProximityOverride()
    end
end)
RMenu.Add("radios","mainmenu",RageUI.CreateMenu("Radios", "Main Menu", tARMA.getRageUIMenuWidth(), tARMA.getRageUIMenuHeight()))
RMenu.Add("radios","advancedeffects",RageUI.CreateSubMenu(RMenu:Get("radios", "mainmenu"),"Radios","Advanced Effects",tARMA.getRageUIMenuWidth(),tARMA.getRageUIMenuHeight()))
RMenu.Add("radios","channelinfo",RageUI.CreateSubMenu(RMenu:Get("radios", "mainmenu"),"Radios","Channel Information",tARMA.getRageUIMenuWidth(),tARMA.getRageUIMenuHeight()))
local function u(h, v)
    local w = GetResourceKvpInt(h)
    if w <= 0 then
        w = v
    end
    return w
end
local function x()
    local y = GetResourceKvpString("radios_advancedEffects")
    if not y or y == "" then
        return table.copy(a.advancedEffects)
    else
        return json.decode(y)
    end
end
local z = 0
local A = u("radios_volume", 10)
local B = -1
local C = u("radios_leftChannelVolume", 6)
local D = u("radios_rightChannelVolume", 6)
local E = x()
local function F()
    SetAudioSubmixOutputVolumes(B, 0, C / 6, D / 6, 0.0, 0.0, 1.0, 1.0)
end
local function G()
    for H in pairs(a.advancedEffects) do
        SetAudioSubmixEffectParamFloat(B, 0, GetHashKey(H), E[H] + 0.0)
    end
end
local function I()
    SetResourceKvp("radios_advancedEffects", json.encode(E))
end
local function J(q, s)
    exports["pma-voice"]:setRadioChannel(q)
    if exports["pma-voice"]:getRadioVolume() == 0 then
        exports["pma-voice"]:setRadioVolume(u("radios_volume", 10) * 10)
    end
    e(true)
    g(s.name)
    for j, r in pairs(s.players) do
        i(j, r.name, r.sortOrder)
        if r.isMuted then
            o(j, true)
        end
    end
    c = q
end
local function K(L, M)
    for N = 1, 25 do
        for O, r in pairs(L) do
            if r.sortOrder == N then
                M(r)
            end
        end
    end
end
RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('radios', 'mainmenu')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            RageUI.Separator("Available Channels")
                for q, s in pairs(b) do
                    local P = q == c
                    local Q = string.format("Connected clients: %d", table.count(s.players))
                    local R = P and {RightLabel = "(Selected)"} or {}
                    RageUI.Button(s.name,Q,R,true,function(S, T, U)
                        if U then
                            RMenu:Get("radios", "channelinfo"):SetSubtitle(string.format("Viewing %s", s.name))
                            z = q
                        end
                    end,RMenu:Get("radios", "channelinfo"))
                end
            RageUI.Separator("Radio Settings")
            RageUI.Slider("Total Volume",A,10,"",false,{ProgressBackgroundColor = {R = 0, G = 0, B = 0, A = 255},ProgressColor = {R = 0, G = 117, B = 194, A = 255}},true,function(S, U, T, V)
                if V ~= A and V > 0 then
                    A = V
                    exports["pma-voice"]:setRadioVolume(A * 10)
                    SetResourceKvpInt("radios_volume", A)
                end
            end)
            RageUI.Slider("Left Channel Volume",C,6,"",false,{ProgressBackgroundColor = {R = 0, G = 0, B = 0, A = 255},ProgressColor = {R = 0, G = 117, B = 194, A = 255}},true,function(S, U, T, V)
                if V ~= C and V > 0 then
                    C = V
                    F()
                    SetResourceKvpInt("radios_leftChannelVolume", C)
                end
            end)
            RageUI.Slider("Right Channel Volume",D,6,"",false,{ProgressBackgroundColor = {R = 0, G = 0, B = 0, A = 255},ProgressColor = {R = 0, G = 117, B = 194, A = 255}},true,function(S, U, T, V)
                if V ~= D and V > 0 then
                    D = V
                    F()
                    SetResourceKvpInt("radios_rightChannelVolume", D)
                end
            end)
            RageUI.Button("Advanced Effects","",{},true,function()
            end,RMenu:Get("radios", "advancedeffects"))
        end) 
    end
    if RageUI.Visible(RMenu:Get('radios', 'channelinfo')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            local s = b[z]
            if not s then
                RageUI.GoBack()
                return
            end
            if z ~= c then
                RageUI.Button("~b~Join Channel",nil,{},true,function(S, T, U)
                    if U then
                        J(z, s)
                    end
                end)
            else
                RageUI.Button("~r~Leave Channel",nil,{},true,function(S, T, U)
                    if U then
                        t()
                    end
                end)
            end
            RageUI.Separator("Connected Clients")
            K(s.players,function(r)
                RageUI.Button(r.name,nil,{},true,function()
                end,nil)
            end)
        end) 
    end
    if RageUI.Visible(RMenu:Get('radios', 'advancedeffects')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            RageUI.ButtonWithStyle("Frequency Range In (Low)","",{RightLabel = tostring(E["freq_low"])},true,function(S, T, U)
                if U then
                    tARMA.clientPrompt("Frequency Range In (Low)","",function(W)
                        local w = tonumber(W)
                        if not w then
                            notify("~r~Inputted text could not be parsed as a number.")
                        elseif w < 60 then
                            notify("~r~The minimum value this field can be is 60.")
                        elseif w > 999 then
                            notify("~r~The maximum value this field can be is 999.")
                        else
                            E["freq_low"] = w + 0.0
                            G()
                            I()
                        end
                    end)
                end
            end,nil)
            RageUI.ButtonWithStyle("Frequency Range In (High)","",{RightLabel = tostring(E["freq_hi"])},true,function(S, T, U)
                if U then
                    tARMA.clientPrompt("Frequency Range In (High)","",function(W)
                        local w = tonumber(W)
                        if not w then
                            notify("~r~Inputted text could not be parsed as a number.")
                        elseif w < 1000 then
                            notify("~r~The minimum value this field can be is 1000.")
                        elseif w > 6000 then
                            notify("~r~The maximum value this field can be is 6000.")
                        else
                            E["freq_hi"] = w + 0.0
                            G()
                            I()
                        end
                    end)
                end
            end,nil)
            RageUI.ButtonWithStyle("Ring Modulator (Frequency)","",{RightLabel = tostring(E["rm_mod_freq"])},true,function(S, T, U)
                if U then
                    tARMA.clientPrompt("Ring Modulator (Frequency)","",function(W)
                        local w = tonumber(W)
                        if not w then
                            notify("~r~Inputted text could not be parsed as a number.")
                        elseif w < 0 then
                            notify("~r~The minimum value this field can be is 0.")
                        elseif w > 10000 then
                            notify("~r~The maximum value this field can be is 10000.")
                        else
                            E["rm_mod_freq"] = w + 0.0
                            G()
                            I()
                        end
                    end)
                end
            end,nil)
            RageUI.ButtonWithStyle("Ring Modulator (Mix)","",{RightLabel = tostring(E["rm_mix"])},true,function(S, T, U)
                if U then
                    tARMA.clientPrompt("Ring Modulator (Mix)","",function(W)
                        local w = tonumber(W)
                        if not w then
                            notify("~r~Inputted text could not be parsed as a number.")
                        elseif w < 0 then
                            notify("~r~The minimum value this field can be is 0.")
                        elseif w > 100 then
                            notify("~r~The maximum value this field can be is 100.")
                        else
                            E["rm_mix"] = w + 0.0
                            G()
                            I()
                        end
                    end)
                end
            end,nil)
            RageUI.ButtonWithStyle("Destruction (Fudge)","",{RightLabel = tostring(E["fudge"])},true,function(S, T, U)
                if U then
                    tARMA.clientPrompt("Destruction (Fudge)","",function(W)
                        local w = tonumber(W)
                        if not w then
                            notify("~r~Inputted text could not be parsed as a number.")
                        elseif w < 0 then
                            notify("~r~The minimum value this field can be is 0.")
                        elseif w > 20 then
                            notify("~r~The maximum value this field can be is 20.")
                        else
                            E["fudge"] = w + 0.0
                            G()
                            I()
                        end
                    end)
                end
            end,nil)
            RageUI.ButtonWithStyle("Frequency Range Out (Low)","",{RightLabel = tostring(E["o_freq_lo"])},true,function(S, T, U)
                if U then
                    tARMA.clientPrompt("Frequency Range Out (Low)","",function(W)
                        local w = tonumber(W)
                        if not w then
                            notify("~r~Inputted text could not be parsed as a number.")
                        elseif w < 60 then
                            notify("~r~The minimum value this field can be is 60.")
                        elseif w > 999 then
                            notify("~r~The maximum value this field can be is 999.")
                        else
                            E["o_freq_lo"] = w + 0.0
                            G()
                            I()
                        end
                    end)
                end
            end,nil)
            RageUI.ButtonWithStyle("Frequency Range Out (High)","",{RightLabel = tostring(E["o_freq_hi"])},true,function(S, T, U)
                if U then
                    tARMA.clientPrompt("Frequency Range Out (High)","",function(W)
                        local w = tonumber(W)
                        if not w then
                            notify("~r~Inputted text could not be parsed as a number.")
                        elseif w < 1000 then
                            notify("~r~The minimum value this field can be is 1000.")
                        elseif w > 6000 then
                            notify("~r~The maximum value this field can be is 6000.")
                        else
                            E["o_freq_hi"] = w + 0.0
                            G()
                            I()
                        end
                    end)
                end
            end,nil)
            RageUI.Button("~r~Reset To Default","",{},true,function(S, T, U)
                if U then
                    E = table.copy(a.advancedEffects)
                    G()
                    I()
                end
            end,nil)
        end) 
    end
end)

RegisterCommand("radios",function()
    if table.count(b) == 0 then
        notify("~r~You have no available radio channels")
        return
    end
    RageUI.Visible(RMenu:Get("radios", "mainmenu"), true)
end,false)
RegisterCommand("toggleradiomute",function()
    if A == 1 then
        exports["pma-voice"]:setRadioVolume(u("radios_volume", 10) * 10)
    else
        exports["pma-voice"]:setRadioVolume(10)
    end
end,false)
Citizen.CreateThread(function()
    exports["pma-voice"]:setVoiceProperty("micClicks", false)
    exports["pma-voice"]:setRadioVolume(u("radios_volume", 10) * 10)
    B = CreateAudioSubmix("ARMARadio")
    SetAudioSubmixEffectRadioFx(B, 0)
    SetAudioSubmixEffectParamInt(B, 0, "default", 1)
    F()
    G()
    AddAudioSubmixOutput(B, 0)
    exports["pma-voice"]:setEffectSubmix("radio", B)
    while true do
        if c == 0 and table.count(b) > 0 then
            notify("~r~You are not currently in a radio channel.")
        end
        Citizen.Wait(120000)
    end
end)
AddEventHandler("pma-voice:registerCustomSubmixes",function()
    Citizen.Wait(100)
    exports["pma-voice"]:setEffectSubmix("radio", B)
end)
RegisterNetEvent("ARMA:radiosCreateChannel",function(q, h, L, X)
    if not b[q] then
        b[q] = {name = h, players = L}
        if X then
            Citizen.CreateThread(function()
                while GetIsLoadingScreenActive() do
                    Citizen.Wait(0)
                end
                Citizen.Wait(2000)
                if b[q] then
                    J(q, b[q])
                end
            end)
        end
    end
end)
RegisterCommand("toggleradiomute",function()
    if c ~= 0 then
        if exports["pma-voice"]:getRadioVolume() == 0 then
            exports["pma-voice"]:setRadioVolume(u("radios_volume", 10) * 10)
            TriggerServerEvent("ARMA:radiosSetIsMuted", false)
        else
            exports["pma-voice"]:setRadioVolume(0)
            TriggerServerEvent("ARMA:radiosSetIsMuted", true)
        end
    end
end,false)
RegisterKeyMapping("toggleradiomute", "Toggle Radio Volume", "KEYBOARD", "")
RegisterNetEvent("ARMA:radiosSetPlayerIsMuted",function(q, j, p)
    local s = b[q]
    if not s then
        return
    end
    local r = s.players[j]
    if not r then
        return
    end
    r.isMuted = p
    if q == c then
        o(j, p)
    end
end)
