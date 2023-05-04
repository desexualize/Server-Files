local a = module("cfg/cfg_emotes")
RMenu.Add("emotesmenu","mainmenu",RageUI.CreateMenu("","Main Menu",tARMA.getRageUIMenuWidth(),tARMA.getRageUIMenuHeight(),"banners", "emotes"))
RMenu.Add("emotesmenu","emotes",RageUI.CreateSubMenu(RMenu:Get("emotesmenu", "mainmenu"),"","Emotes",tARMA.getRageUIMenuWidth(),tARMA.getRageUIMenuHeight(),"banners", "emotes"))
RMenu.Add("emotesmenu","searchemotes",RageUI.CreateSubMenu(RMenu:Get("emotesmenu", "mainmenu"),"","Search Emotes",tARMA.getRageUIMenuWidth(),tARMA.getRageUIMenuHeight(),"banners", "emotes"))
RMenu.Add("emotesmenu","danceemotes",RageUI.CreateSubMenu(RMenu:Get("emotesmenu", "emotes"),"","Dance Emotes",tARMA.getRageUIMenuWidth(),tARMA.getRageUIMenuHeight(),"banners", "emotes"))
RMenu.Add("emotesmenu","customemotes",RageUI.CreateSubMenu(RMenu:Get("emotesmenu", "emotes"),"","Custom Emotes",tARMA.getRageUIMenuWidth(),tARMA.getRageUIMenuHeight(),"banners", "emotes"))
RMenu.Add("emotesmenu","gunemotes",RageUI.CreateSubMenu(RMenu:Get("emotesmenu", "emotes"),"","Gun Emotes",tARMA.getRageUIMenuWidth(),tARMA.getRageUIMenuHeight(),"banners", "emotes"))
RMenu.Add("emotesmenu","propemotes",RageUI.CreateSubMenu(RMenu:Get("emotesmenu", "emotes"),"","Prop Emotes",tARMA.getRageUIMenuWidth(),tARMA.getRageUIMenuHeight(),"banners", "emotes"))
RMenu.Add("emotesmenu","sharedemotes",RageUI.CreateSubMenu(RMenu:Get("emotesmenu", "emotes"),"","Shared Emotes",tARMA.getRageUIMenuWidth(),tARMA.getRageUIMenuHeight(),"banners", "emotes"))
RMenu.Add("emotesmenu","walkingstyles",RageUI.CreateSubMenu(RMenu:Get("emotesmenu", "mainmenu"),"","Walking Styles",tARMA.getRageUIMenuWidth(),tARMA.getRageUIMenuHeight(),"banners", "emotes"))
RMenu.Add("emotesmenu","moods",RageUI.CreateSubMenu(RMenu:Get("emotesmenu", "mainmenu"),"","Moods",tARMA.getRageUIMenuWidth(),tARMA.getRageUIMenuHeight(),"banners", "emotes"))
local b = false
local c = ""
local d = {}
local e = 0
local f = nil
local g = nil
local h = nil
local i = nil
local j = 0
local k = nil
local l = 0
local m = 0
local function n()
    for o, prop in pairs(d) do
        DeleteEntity(prop)
    end
    d = {}
end
local function p(q)
    if not b then
        return
    end
    if not q and GetGameTimer() - e < 1500 then
        tARMA.notify("~r~Emotes are being rate limited.")
        return
    end
    b = false
    f = nil
    g = nil
    if h then
        if h.handle then
            StopParticleFxLooped(h.handle)
        end
        h = nil
    end
    if c == "Scenario" or c == "MaleScenario" then
        ClearPedTasksImmediately(PlayerPedId())
    else
        ClearPedTasks(PlayerPedId())
        n()
    end
end
local function r(s, t, u, v, w, x, y, z)
    local A = PlayerPedId()
    local B = GetEntityCoords(A, true)
    local C = tARMA.loadModel(s)
    prop = CreateObject(GetHashKey(s), B.x, B.y, B.z + 0.2, true, true, true)
    AttachEntityToEntity(prop, A, GetPedBoneIndex(A, t), u, v, w, x, y, z, true, true, false, true, 1, true)
    table.insert(d, prop)
    SetModelAsNoLongerNeeded(C)
end
local function D(E)
    SetFacialIdleAnimOverride(PlayerPedId(), E[2], nil)
    b = true
end
local function F(E)
    if tARMA.getPlayerVehicle() ~= 0 then
        tARMA.notify("~r~Can not use scenarios whilst in a vehicle.")
        return
    end
    local A = PlayerPedId()
    if E[1] == "Scenario" then
        ClearPedTasks(A)
        TaskStartScenarioInPlace(A, E[2], 0, true)
    elseif E[1] == "MaleScenario" then
        if tARMA.getModelGender() == "male" then
            ClearPedTasks(A)
            TaskStartScenarioInPlace(A, E[2], 0, true)
        else
            tARMA.notify("~r~This scenario is male only.")
        end
    elseif E[1] == "ScenarioObject" then
        local G = GetOffsetFromEntityInWorldCoords(A, 0.0, 0 - 0.5, -0.5)
        ClearPedTasks(A)
        TaskStartScenarioAtPosition(A, E[2], G.x, G.y, G.z, GetEntityHeading(A), 0, true, false)
    end
    b = true
end
local function H(E)
    local I = E.animationOptions
    if tARMA.getPlayerVehicle() ~= 0 then
        return 51
    elseif not I then
        return 0
    elseif I.emoteLoop then
        if I.emoteMoving then
            return 51
        else
            return 1
        end
    elseif I.emoteMoving then
        return 51
    elseif not I.emoteMoving then
        return 0
    elseif I.emoteStuck then
        return 50
    end
    return 0
end
local function J(E)
    if E.animationOptions then
        return E.animationOptions.emoteDuration or -1
    else
        return -1
    end
end
local function K(E)
    local I = E.animationOptions
    if not I then
        return
    end
    local L = I.prop
    if not L then
        return
    end
    local M = I.propBone
    local N, O, P, Q, R, S = table.unpack(I.propPlacement)
    r(L, M, N, O, P, Q, R, S)
    local T = I.secondProp
    if not T then
        return
    end
    local U = I.secondPropBone
    local V, W, X, Y, Z, _ = table.unpack(I.secondPropPlacement)
    r(T, U, V, W, X, Y, Z, _)
end
local function a0(E)
    local a1, a2 = table.unpack(E)
    local a3 = H(E)
    local a4 = J(E)
    tARMA.loadAnimDict(a1)
    TaskPlayAnim(PlayerPedId(), a1, a2, 2.0, 2.0, a4, a3, 0, false, false, false)
    RemoveAnimDict(a1)
    Citizen.Wait(0)
    b = true
    f = a1
    g = a2
    local a5 = E.animationOptions
    if a5 and a5.ptfxAsset then
        h = {asset = a5.ptfxAsset,name = a5.ptfxName,placement = a5.ptfxPlacement,info = a5.ptfxInfo,wait = a5.ptfxWait}
        tARMA.notify(h.info)
    end
    K(E)
end
local a7 = {2, 160, 161, 163, 167}
local function a6(E)
    if not tARMA.canAnim() or tARMA.isHandcuffed() then
        return true
    end
    local A = PlayerPedId()
    if IsPedReloading(A) or IsPlayerFreeAiming(A) or GetEntityHealth(A) <= 102 then
        return true
    end
    if tARMA.getPlayerCombatTimer() > 0 then
        return true
    end
    local a9 = tARMA.getPlayerVehicle()
    if a9 ~= 0 and GetEntitySpeed(a9) > 1.0 then
        return true
    end
    for p, aa in pairs(a7) do
        if GetIsTaskActive(A, aa) then
            return true
        end
    end
    if isPlayerNearPrison() then -- add this func when hmp is sorted
        if E and E.animationOptions and E.animationOptions.allowedPrison then
            return false
        else
            return true
        end
    end
    return false
end
local function a7(E)
    if a6(E) then
        tARMA.notify("~r~Can not this emote at this time.")
        return
    end
    if GetGameTimer() - e < 1500 then
        tARMA.notify("~r~Emotes are being rate limited.")
        return
    end
    p(true)
    local type = E[1]
    c = type
    e = GetGameTimer()
    if type == "Expression" then
        D(E)
        return
    end
    if type == "Scenario" or type == "MaleScenario" or type == "ScenarioObject" then
        F(E)
        return
    end
    a0(E)
end
local function a8()
    local a9 = PlayerId()
    local aa = -1
    local ab = 2.0
    local ac = tARMA.getPlayerCoords()
    for o, ad in pairs(GetActivePlayers()) do
        if ad ~= a9 then
            local ae = GetPlayerPed(ad)
            local af = #(GetEntityCoords(ae, true) - ac)
            if af < ab then
                aa = ad
                ab = af
            end
        end
    end
    if aa == -1 then
        return 0
    else
        return GetPlayerServerId(aa)
    end
end
local function ag(ah)
    if a6() then
        tARMA.notify("~r~Can not use shared emotes at this time.")
        return
    end
    local ai = a8()
    if ai ~= 0 then
        i = ah
        j = ai
        TriggerServerEvent("ARMA:sendSharedEmoteRequest", ai, ah)
    else
        tARMA.notify("~r~No player is near by.")
    end
end
local function aj(E)
    Citizen.CreateThreadNow(function()
        local ak = E[1]
        tARMA.loadAnimDict(ak)
        SetPedMovementClipset(PlayerPedId(), ak, 0.2)
        RemoveAnimSet(ak)
        RemoveAnimDict(ak)
    end)
end
local function al(am, an)
    local ao, ap = type(am), type(an)
    if ao ~= ap then
        return ao < ap
    else
        return am < an
    end
end
local function aq(ar, as)
    local at = {}
    local au = 1
    for av in pairs(ar) do
        at[au] = av
        au = au + 1
    end
    as = as or al
    table.sort(at, as)
    return at
end
local function aw(ar, as)
    local at = aq(ar, as)
    local ax = 0
    return function()
        ax = ax + 1
        local av = at[ax]
        if av ~= nil then
            return av, ar[av]
        else
            return nil, nil
        end
    end
end

local emoteString = ''
local foundMatch = false
RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('emotesmenu', 'mainmenu')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            foundMatch = false
            RageUI.Button("Emotes","",{},true,function()
            end,RMenu:Get("emotesmenu", "emotes"))
            RageUI.Button("Search Emotes","",{},true,function()
            end,RMenu:Get("emotesmenu", "searchemotes"))
            RageUI.Button("Cancel Emote","",{},true,function(ay, az, aA)
                if aA then
                    p(false)
                    e = GetGameTimer()
                end
            end)
            RageUI.Button("Walking Styles","",{},true,function()
            end,RMenu:Get("emotesmenu", "walkingstyles"))
            RageUI.Button("Moods","",{},true,function()
            end,RMenu:Get("emotesmenu", "moods"))
        end)
    end
    if RageUI.Visible(RMenu:Get('emotesmenu', 'emotes')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            RageUI.Button("🕺 Dance Emotes","",{},true,function()
            end,RMenu:Get("emotesmenu", "danceemotes"))
            RageUI.Button("🛠️ Custom Emotes","",{},true,function()
            end,RMenu:Get("emotesmenu", "customemotes"))
            RageUI.Button("📦 Prop Emotes","",{},true,function()
            end,RMenu:Get("emotesmenu", "propemotes"))
            RageUI.Button("👫 Shared Emotes","",{},true,function()
            end,RMenu:Get("emotesmenu", "sharedemotes"))
            RageUI.Button("🔫 Gun Emotes","",{},true,function()
            end,RMenu:Get("emotesmenu", "gunemotes"))
            for aB, E in aw(a.emotes) do
                RageUI.Button(E[3],"/e (" .. aB .. ")",{},not a6(E),function(ay, az, aA)
                    if aA then
                        a7(E)
                    end
                end)
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('emotesmenu', 'searchemotes')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            if foundMatch == false then
                emoteString = tARMA.KeyboardInput("Enter Emote Name", "", 10)
                if emoteString == nil then 
                    emoteString = ""
                end
            end
            for aB, E in aw(a.emotes) do
                foundMatch = true
                if string.find(E[3],emoteString) then
                    RageUI.Button(E[3],"/e (" .. aB .. ")",{},not a6(E),function(ay, az, aA)
                        if aA then
                            a7(E)
                        end
                    end)
                end
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('emotesmenu', 'danceemotes')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            for aB, E in aw(a.dances) do
                RageUI.Button(E[3],"/e (" .. aB .. ")",{},not a6(E),function(ay, az, aA)
                    if aA then
                        a7(E)
                    end
                end)
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('emotesmenu', 'customemotes')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            for aB, E in aw(a.custom) do
                RageUI.Button(E[3],"/e (" .. aB .. ")",{},not a6(E),function(ay, az, aA)
                    if aA then
                        a7(E)
                    end
                end)
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('emotesmenu', 'gunemotes')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            for aB, E in aw(a.guns) do
                RageUI.Button(E[3],"/e (" .. aB .. ")",{},not a6(E),function(ay, az, aA)
                    if aA then
                        a7(E)
                    end
                end)
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('emotesmenu', 'propemotes')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            for aB, E in aw(a.props) do
                RageUI.Button(E[3],"/e (" .. aB .. ")",{},not a6(E),function(ay, az, aA)
                    if aA then
                        a7(E)
                    end
                end)
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('emotesmenu', 'sharedemotes')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            for ah, E in aw(a.shared) do
                if not E.animationOptions or not E.animationOptions.invisible then
                    RageUI.Button(E[3],"/nearby (~g~" .. ah .. "~w~)",{},not a6(E),function(ay, az, aA)
                        if aA then
                            ag(ah)
                        end
                    end)
                end
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('emotesmenu', 'walkingstyles')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            RageUI.Button("Normal (Reset)","",{},true,function(ay, az, aA)
                if aA then
                    ResetPedMovementClipset(PlayerPedId())
                end
            end)
            for ah, E in aw(a.walks) do
                RageUI.Button(ah,"",{},true,function(ay, az, aA)
                    if aA then
                        aj(E)
                    end
                end)
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('emotesmenu', 'moods')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            RageUI.Button("Normal (Reset)","",{},true,function(ay, az, aA)
                if aA then
                    ClearFacialIdleAnimOverride(PlayerPedId())
                end
            end)
            for ah, E in aw(a.moods) do
                RageUI.Button(ah,"",{},true,function(ay, az, aA)
                    if aA then
                        a7(E)
                    end
                end)
            end
        end)
    end
end)

RegisterCommand("emotemenu",function(aC, aD, aE)
    RageUI.Visible(RMenu:Get("emotesmenu", "mainmenu"), not RageUI.Visible(RMenu:Get("emotesmenu", "mainmenu")))
end,false)
RegisterKeyMapping("emotemenu", "Toggles the emote menu", "KEYBOARD", "F3")
local function aF(aC, aD, aE)
    if #aD < 1 then
        tARMA.notify("~r~No emote name was specified.")
        return
    end
    local ah = string.lower(aD[1])
    if not ah then
        tARMA.notify("~r~No emote name was specified.")
        return
    elseif ah == "c" then
        p(false)
        return
    end
    if a.emotes[ah] then
        a7(a.emotes[ah])
    elseif a.dances[ah] then
        a7(a.dances[ah])
    elseif a.custom[ah] then
        a7(a.custom[ah])
    elseif a.props[ah] then
        a7(a.props[ah])
    elseif a.guns[ah] then
        a7(a.guns[ah])
    else
        tARMA.notify("~r~Invalid emote name was specified.")
    end
end
RegisterCommand("e", aF, false)
RegisterCommand("emote", aF, false)
RegisterCommand("nearby",function(aC, aD, aE)
    if #aD < 1 then
        tARMA.notify("~r~No emote name was specified.")
        return
    end
    local ah = string.lower(aD[1])
    if not ah then
        tARMA.notify("~r~No emote name was specified.")
        return
    end
    if a.shared[ah] then
        ag(ah)
    else
        tARMA.notify("~r~Invalid emote name was specified.")
    end
end)
RegisterCommand("walk",function(aC, aD, aE)
    if #aD < 1 then
        tARMA.notify("~r~No walk name was specified.")
        return
    end
    local ah = aD[1]
    if not ah then
        tARMA.notify("~r~No walk name was specified.")
        return
    end
    if a.walks[ah] then
        aj(a.walks[ah])
    else
        tARMA.notify("~r~Invalid walk name was specified.")
    end
end)
RegisterNetEvent("ARMA:sendSharedEmoteRequest",function(aG, ah)
    if a.shared[ah] and not a6() then
        k = ah
        l = aG
        m = GetGameTimer()
        tARMA.notify("~y~Y~w~ to accept, ~r~L~w~ to refuse (~g~" .. a.shared[ah][3] .. "~w~)")
    end
end)
RegisterNetEvent("ARMA:receiveSharedEmoteRequest",function(ah)
    p(false)
    Citizen.Wait(300)
    a7(a.shared[ah])
end)
RegisterNetEvent("ARMA:receiveSharedEmoteRequestSource",function()
    local aH = GetPlayerFromServerId(j)
    if aH == -1 then
        return
    end
    local aI = GetPlayerPed(aH)
    if aI == 0 then
        return
    end
    local aJ = GetEntityHeading(aI)
    local B = GetOffsetFromEntityInWorldCoords(aI, 0.0, 1.0, 0.0)
    local E = a.shared[i]
    if E.animationOptions and E.animationOptions.syncOffsetFront then
        B = GetOffsetFromEntityInWorldCoords(aI, 0.0, E.animationOptions.syncOffsetFront, 0.0)
    end
    local A = PlayerPedId()
    SetEntityHeading(A, aJ - 180.1)
    SetEntityCoordsNoOffset(A, B.x, B.y, B.z, 0)
    p(false)
    Citizen.Wait(300)
    a7(E)
end)
local function aK()
    k = nil
    l = 0
    m = 0
end
local function aL()
    if h.handle then
        return
    end
    tARMA.loadPtfx(h.asset)
    UseParticleFxAsset(h.asset)
    local aM, aN, aO, aP, aQ, aR, aS = table.unpack(h.placement)
    h.handle = StartNetworkedParticleFxLoopedOnEntityBone(h.name,PlayerPedId(),aM,aN,aO,aP,aQ,aR,GetEntityBoneIndexByName(h.name, "VFX"),1065353216,0,0,0,1065353216,1065353216,1065353216,0)
    Citizen.CreateThread(function()
        SetParticleFxLoopedColour(h.handle, 1.0, 1.0, 1.0, false)
        Citizen.Wait(h.wait)
        StopParticleFxLooped(h.handle)
        h.handle = nil
    end)
end
local function aT()
    if k then
        if GetGameTimer() - m > 5000 then
            aK()
        elseif IsControlJustPressed(1, 246) then
            if a6() then
                tARMA.notify("~r~You can not use emotes at this time.")
            else
                TriggerServerEvent("ARMA:receiveSharedEmoteRequest", l, a.shared[k][4])
            end
            aK()
        end
    end
    if b and f and g then
        if h and IsControlJustPressed(0, 47) then
            aL()
        end
        if not IsEntityPlayingAnim(PlayerPedId(), f, g, 3) or tARMA.getPlayerCombatTimer() > 0 then
            p(true)
        end
    end
end
function tARMA.playEmote(ah)
    if a.emotes[ah] then
        a7(a.emotes[ah])
    elseif a.dances[ah] then
        a7(a.dances[ah])
    elseif a.custom[ah] then
        a7(a.custom[ah])
    elseif a.props[ah] then
        a7(a.props[ah])
    elseif a.guns[ah] then
        a7(a.guns[ah])
    end
end
tARMA.cancelEmote = p
Citizen.CreateThread(function()
    TriggerEvent("chat:addSuggestion","/e","Play an emote",{{name = "emotename", help = "dance, camera, sit or any valid emote."}})
    TriggerEvent("chat:addSuggestion","/emote","Play an emote",{{name = "emotename", help = "dance, camera, sit or any valid emote."}})
    TriggerEvent("chat:addSuggestion", "/emotemenu", "Open emotes menu (F3) by default.")
    TriggerEvent("chat:addSuggestion","/walk","Set your walkingstyle.",{{name = "style", help = "/walks for a list of valid styles"}})
    tARMA.createThreadOnTick(aT)
end)
