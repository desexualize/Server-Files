sittingAtInsideTrack = false
local a = -1
local b = 1000
local c = false
local d = {}
local e = -1
local f = false
local g = false
local h = false
local i = 0.5
local j = false
local k = 10
local l = 60
local m = false
local n
local o = 0.0
local p = 0
local q = "anim_casino_a@amb@casino@games@insidetrack@male"
local r = 0
local s = true
local t = {
    [0] = vector3(1091.418, 257.544, -52.2409),
    [1] = vector3(1092.072, 258.1984, -52.2409),
    [2] = vector3(1094.473, 260.5995, -52.2409),
    [3] = vector3(1095.127, 261.254, -52.2409),
    [4] = vector3(1095.852, 261.978, -52.2409),
    [5] = vector3(1096.506, 262.6327, -52.2409),
    [6] = vector3(1098.902, 265.0287, -52.2409),
    [7] = vector3(1099.556, 265.683, -52.2409),
    [8] = vector3(1092.974, 255.211, -52.2409),
    [9] = vector3(1093.628, 255.865, -52.2409),
    [10] = vector3(1096.417, 258.6552, -52.2409),
    [11] = vector3(1097.072, 259.309, -52.2409),
    [12] = vector3(1097.797, 260.034, -52.2409),
    [13] = vector3(1098.451, 260.6878, -52.2409),
    [14] = vector3(1101.236, 263.473, -52.2409),
    [15] = vector3(1101.89, 264.127, -52.2409)
}
local u = {}
RMenu.Add("ARMAjackpot","instructions",RageUI.CreateMenu("", "", tARMA.getRageUIMenuWidth(), tARMA.getRageUIMenuHeight(), "banners", "casino_jackpot"))
RMenu:Get("ARMAjackpot", "instructions"):SetSubtitle("~b~JACKPOT")
RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('ARMAjackpot', 'instructions')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            RageUI.FakeButton("","Play Jackpot for a chance to win BIG! \n\nBuy tickets to have a chance at winning a large pot of chips! Your % chance of winning is based on how many tickets have been purchased in that round.\n1 tickett  = 1 chip.",{RightLabel = "→→→"},true,function(v, w, x)
            end,RMenu:Get("ARMAjackpot", "instructions"))
        end)
    end
end)
Citizen.CreateThread(function()
    while true do
        if insideDiamondCasino then
            b = 1000
            a = -1
            local y = GetEntityCoords(tARMA.getPlayerPed())
            for z = 0, 15, 1 do
                local A = t[z]
                local B = #(y - A)
                if B < b then
                    b = B
                    a = z
                end
            end
        end
        Wait(100)
    end
end)
local C = false
Citizen.CreateThread(function()
    while true do
        if not sittingAtInsideTrack then
            if a ~= nil and b < 2 then
                if not c then
                    print("closestChair", a)
                    print("jackpotTableData", dump(d))
                    if d[a] == false then
                        drawNativeNotification("Press ~INPUT_PICKUP~ to play Jackpot!")
                    else
                        drawNativeNotification("This seat is taken.")
                    end
                    showHowToJackpot(true)
                    if not C then
                        C = true
                        PlaySoundFrontend(-1, "DLC_VW_RULES", "dlc_vw_table_games_frontend_sounds", 1)
                        PlaySoundFrontend(-1, "DLC_VW_WIN_CHIPS", "dlc_vw_table_games_frontend_sounds", 1)
                    end
                    local D = a
                    while D == a and b < 2 do
                        Wait(0)
                    end
                    showHowToJackpot(false)
                end
            end
        end
        Wait(0)
    end
end)
RegisterNetEvent("ARMA:sitAtJackpotChair",function(E)
    e = E
    sittingAtInsideTrack = true
    goToJackpotChair(E)
end)
RegisterNetEvent("ARMA:updatePlayerWinChance",function(F)
    k = F
end)
RegisterNetEvent("ARMA:updateTotalPot",function(G)
    r = G
end)
function goToJackpotChair(E)
    showHowToJackpot(false)
    local H = getTrackGenderAnimDict()
    q = H
    if not HasAnimDictLoaded(H) then
        RequestAnimDict(H)
        while not HasAnimDictLoaded(H) do
            Wait(0)
        end
    end
    local I = func_4794(E)
    local J = func_4783(E, 0, H, I)
    local K = func_4781(E, 0, H, I)
    local L = PlayerPedId()
    local M = GetAnimInitialOffsetPosition(H, I, J.x, J.y, J.z, 0.0, 0.0, K, 0.0, 2)
    local N = GetAnimInitialOffsetRotation(H, I, J.x, J.y, J.z, 0.0, 0.0, K, 0.0, 2)
    TaskGoStraightToCoord(L, M.x, M.y, M.z, 1.0, 20000, K + 180.0, 0.0)
    while GetScriptTaskStatus(L, "SCRIPT_TASK_GO_STRAIGHT_TO_COORD") ~= 7 do
        Citizen.Wait(0)
    end
    SetEntityCoordsNoOffset(L, M.x, M.y, M.z, false, false, false)
    SetEntityRotation(L, N.x, N.y, N.z, 2, false)
    TaskPlayAnimAdvanced(L, H, I, J.x, J.y, J.z, 0.0, 0.0, K, 2.0, -2.0, -1, 790530, 0.0, 2, 0)
    PlayFacialAnim(tARMA.getPlayerPed(), "enter_left_readyidle_facial", H)
    RemoveAnimDict(H)
    local O
    local P
    non0IndexChairId = E + 1
    if non0IndexChairId >= 10 then
        O = GetHashKey("vw_vwint01_betting_sreen_" .. tostring(non0IndexChairId))
    else
        O = GetHashKey("vw_vwint01_betting_sreen_0" .. tostring(non0IndexChairId))
    end
    if non0IndexChairId >= 8 then
        P = CreateNamedRenderTargetForModel("casinoscreen_" .. tostring(non0IndexChairId + 2), O)
    else
        P = CreateNamedRenderTargetForModel("casinoscreen_0" .. tostring(non0IndexChairId + 2), O)
    end
    f = true
    local Q = setupJackpotInstructionalScaleform("instructional_buttons")
    Citizen.CreateThread(function()
        while sittingAtInsideTrack do
            SetTextRenderId(P)
            SetScriptGfxDrawOrder(4)
            SetScriptGfxDrawBehindPausemenu(1)
            if j then
                DrawAdvancedText(0.584,0.181,0.005,0.0028,0.6,math.floor(k * 1000) / 1000 .. "% chance of winning!",255,255,255,255,0,0)
                DrawAdvancedText(0.489, 0.74, 0.005, 0.0028, 0.6, "Your colour is", 255, 255, 255, 255, 0, 0)
                if u ~= nil then
                    for R, S in pairs(u) do
                        if S.user_id == tARMA.getUserId() then
                            DrawRect(0.72,0.82,0.115,0.156,u[R].colour.r,u[R].colour.g,u[R].colour.b,u[R].colour.a)
                        end
                    end
                end
            else
                DrawAdvancedText(0.584, 0.181, 0.005, 0.0028, 0.6, "Buy Tickets", 255, 255, 255, 255, 0, 0)
            end
            if h then
                DrawAdvancedText(0.584,0.465,0.005,0.0028,0.7,getMoneyStringFormatted(p) .. " tickets",0,153,255,255,0,0)
                DrawAdvancedText(0.584,0.765,0.005,0.0028,0.6,"Press [ENTER] to confirm bet!",255,255,255,255,0,0)
            else
                DrawAdvancedText(0.584,0.465,0.005,0.0028,0.7,getMoneyStringFormatted(p) .. " tickets",0,204,102,255,0,0)
            end
            SetTextRenderId(GetDefaultScriptRendertargetRenderId())
            SetScriptGfxDrawBehindPausemenu(0)
            Wait(0)
        end
    end)
    Citizen.CreateThread(function()
        while f do
            DrawScaleformMovieFullscreen(Q, 255, 255, 255, 255, 0)
            Wait(0)
        end
    end)
end
Citizen.CreateThread(function()
    while true do
        if f then
            if IsDisabledControlJustPressed(0, 22) then
                local T = getGenericTextInput("Bet Amount")
                if tonumber(T) then
                    T = tonumber(T)
                    if T > 0 then
                        p = T
                        h = false
                    end
                end
            end
            if IsControlJustPressed(0, 201) then
                if h then
                    TriggerServerEvent("ARMA:setJackpotBet", p)
                else
                    if tonumber(p) >= 0 then
                        h = true
                        Wait(100)
                    else
                        tARMA.notify("~r~Invalid amount.")
                    end
                end
            end
            if IsControlPressed(0, 10) then
                p = p + 100
                h = false
            end
            if IsControlPressed(0, 11) then
                if p >= 100 then
                    p = p - 100
                    h = false
                end
            end
        end
        Wait(0)
    end
end)
function setupJackpotInstructionalScaleform(U)
    local U = RequestScaleformMovie(U)
    while not HasScaleformMovieLoaded(U) do
        Citizen.Wait(0)
    end
    BeginScaleformMovieMethod(U, "CLEAR_ALL")
    EndScaleformMovieMethod()
    BeginScaleformMovieMethod(U, "SET_CLEAR_SPACE")
    ScaleformMovieMethodAddParamInt(200)
    EndScaleformMovieMethod()
    BeginScaleformMovieMethod(U, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(1)
    Button(GetControlInstructionalButton(2, 194, true))
    ButtonMessage("Leave chair")
    EndScaleformMovieMethod()
    BeginScaleformMovieMethod(U, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(0)
    Button(GetControlInstructionalButton(2, 191, true))
    ButtonMessage("Place bet")
    EndScaleformMovieMethod()
    BeginScaleformMovieMethod(U, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(2)
    Button(GetControlInstructionalButton(2, 11, true))
    ButtonMessage("Lower bet")
    EndScaleformMovieMethod()
    BeginScaleformMovieMethod(U, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(3)
    Button(GetControlInstructionalButton(2, 10, true))
    ButtonMessage("Increase bet")
    EndScaleformMovieMethod()
    BeginScaleformMovieMethod(U, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(4)
    Button(GetControlInstructionalButton(2, 22, true))
    ButtonMessage("Custom bet")
    EndScaleformMovieMethod()
    BeginScaleformMovieMethod(U, "DRAW_INSTRUCTIONAL_BUTTONS")
    EndScaleformMovieMethod()
    BeginScaleformMovieMethod(U, "SET_BACKGROUND_COLOUR")
    ScaleformMovieMethodAddParamInt(0)
    ScaleformMovieMethodAddParamInt(0)
    ScaleformMovieMethodAddParamInt(0)
    ScaleformMovieMethodAddParamInt(80)
    EndScaleformMovieMethod()
    return U
end
function func_4794(E)
    local V = func_4795(E)
    if V <= 180.0 then
        if V < 90.0 + 15.0 then
            if E == 14 then
                return "ENTER_LEFT_READYIDLE_SHORT"
            end
        end
        return "ENTER_LEFT_READYIDLE"
    end
    if V > 270.0 - 15.0 then
        if E == 15 then
            return "ENTER_RIGHT_READYIDLE_SHORT"
        end
    end
    return "ENTER_RIGHT_READYIDLE"
end
function func_4783(W, X, Y, Z)
    vVar0 = vector3(0.0, 0.0, 0.0)
    if X then
        vVar0 = func_4621(W)
    else
        vVar0 = GetAnimInitialOffsetPosition(Y, Z, func_4621(W), 0.0, 0.0, func_4782(), 0.01, 2)
    end
    return vVar0
end
function func_4781(W, X, Y, Z)
    vVar0 = vector3(0.0, 0.0, 0.0)
    if X then
        vVar0 = func_4782()
    else
        vVar0 = GetAnimInitialOffsetRotation(Y, Z, func_4621(W), 0.0, 0.0, func_4782(), 0.01, 2)
    end
    return vVar0
end
function func_4795(E)
    local _ = func_4621(E)
    local y = GetEntityCoords(tARMA.getPlayerPed())
    local a0 = GetHeadingFromVector_2d(y.x - _.x, y.y - _.y)
    a0 = a0 - func_4782()
    return func_4796(a0 - 180.0, 0.0, 360.0)
end
function func_4796(a1, a2, a3)
    if a2 == a3 then
        return a2
    end
    local V = a3 - a2
    local a1 = a1 - math.floor((a1 - a2) / V * V)
    if a1 < a2 then
        a1 = a1 + V
    end
    return a1
end
function func_4621(E)
    return t[E]
end
function func_4782()
    return -135.0
end
function showHowToJackpot(a4)
    RageUI.ActuallyCloseAll()
    if a ~= -1 then
        RageUI.Visible(RMenu:Get("ARMAjackpot", "instructions"), a4)
    end
end
Citizen.CreateThread(function()
    while true do
        if a ~= -1 and b < 2 then
            if IsControlJustPressed(0, 38) then
                if d[a] == false then
                    TriggerServerEvent("ARMA:requestSitAtJackpot", a)
                end
            end
        end
        Wait(0)
    end
end)
AddEventHandler("ARMA:onClientSpawn",function(a5, a6)
    if a6 then
        TriggerServerEvent("ARMA:requestJackpotChairData")
    end
end)
RegisterNetEvent("ARMA:sendJackpotChairData",function(a7)
    d = a7
end)
Citizen.CreateThread(function()
    while true do
        if sittingAtInsideTrack and f then
            SetPedCapsule(tARMA.getPlayerPed(), 0.2)
            if IsControlJustPressed(0, 202) and not g then
                local E = e
                local H = getTrackGenderAnimDict()
                local I = "exit_left"
                local J = func_4783(E, 0, H, I)
                local K = func_4781(E, 0, H, I)
                TaskPlayAnimAdvanced(PlayerPedId(),H,I,J.x,J.y,J.z,0.0,0.0,K,2.0,-2.0,-1,790528,0.0,2,0)
                PlayFacialAnim(tARMA.getPlayerPed(), "exit_left_facial", H)
                SetTimeout(2500,function()
                    ClearPedTasks(tARMA.getPlayerPed())
                end)
                sittingAtInsideTrack = false
                c = true
                f = false
                showHowToJackpot(false)
                TriggerServerEvent("ARMA:leaveJackpotChair")
                e = -1
                SetTimeout(5000,function()
                    c = false
                end)
            end
        end
        Wait(0)
    end
end)
RegisterNetEvent("ARMA:rollJackpot",function(a8, a9, aa, ab, ac)
    if tARMA.getUserId() == 1 then
        print(a8, a9, aa, ab, ac)
    end
    if not u[a8] then
        return
    end
    i = 0.5
    local ad = u[a8].centerXPos
    local ae = u[a8].rectLength
    ad = ad - ae / 2 + a9 * ae
    local af = 0.5
    local ag = ad
    local ah = 0
    local ai = false
    local aj = 0
    local y = GetEntityCoords(tARMA.getPlayerPed())
    local ak = #(y - vector3(1096.3543701172, 261.18997192383, -51.241153717041))
    local al = false
    if ak <= 10 then
        SendNUIMessage({transactionType = "jackpotroll"})
        al = true
    end
    local am = GetGameTimer()
    while af ~= 0.0 do
        local an = GetFrameTime()
        if i > 0.9 then
            i = 0.1
            ah = ah + 1
        end
        if ah == 1 and not ai then
            ai = true
            SetTimeout(4000,function()
                af = 0.4
                SetTimeout(2500,function()
                    af = 0.35
                    SetTimeout(1250,function()
                        af = 0.3
                        SetTimeout(625,function()
                            af = 0.25
                            SetTimeout(625,function()
                                af = 0.2
                                SetTimeout(500,function()
                                    af = 0.15
                                    SetTimeout(500,function()
                                        af = 0.1
                                        SetTimeout(1500,function()
                                            SetTimeout(1000,function()
                                                SetTimeout(750,function()
                                                    local ao = 0
                                                    if i > ag then
                                                        ao = 0.9
                                                    end
                                                    local ap = ag - (i - ao)
                                                    if i < ag then
                                                        while i - ao < ag and GetGameTimer() - am < 120000 do
                                                            if i > ag then
                                                                ao = 0.9
                                                            else
                                                                ao = 0.0
                                                            end
                                                            ap = ag - (i - ao)
                                                            if ap < 0.1 then
                                                                af = 0.025
                                                            elseif ap < 0.3 then
                                                                af = 0.035
                                                            elseif ap < 0.40 then
                                                                af = 0.05
                                                            elseif ap < 0.50 then
                                                                af = 0.075
                                                            end
                                                            Wait(0)
                                                        end
                                                    elseif i > ag then
                                                        while i - ao < ag and GetGameTimer() - am < 120000 do
                                                            if i > ag then
                                                                ao = 0.9
                                                            else
                                                                ao = 0.0
                                                            end
                                                            ap = ag - (i - ao)
                                                            if ap < 0.1 then
                                                                af = 0.025
                                                            elseif ap < 0.3 then
                                                                af = 0.035
                                                            elseif ap < 0.40 then
                                                                af = 0.05
                                                            elseif ap < 0.50 then
                                                                af = 0.075
                                                            end
                                                            Wait(0)
                                                        end
                                                    end
                                                    af = 0.0
                                                    n = aa
                                                    o = ab
                                                    if al then
                                                        if ac == tARMA.getUserId() then
                                                            SendNUIMessage({transactionType = "playCasinoWin"})
                                                            TriggerServerEvent("ARMA:waitingOnWinConfirm")
                                                        else
                                                            if e ~= -1 then
                                                                SendNUIMessage({transactionType = "playCasinoLose"})
                                                            end
                                                        end
                                                    end
                                                end)
                                            end)
                                        end)
                                    end)
                                end)
                            end)
                        end)
                    end)
                end)
            end)
        end
        i = i + af * an
        aj = aj + af * an
        Wait(0)
    end
end)
Citizen.CreateThread(function()
    while not insideDiamondCasino do
        Wait(0)
    end
    Wait(5000)
    local O = "vw_vwint01_betting_screen"
    local P = CreateNamedRenderTargetForModel("casinoscreen_02", O)
    while true do
        SetTextRenderId(P)
        SetScriptGfxDrawOrder(4)
        SetScriptGfxDrawBehindPausemenu(1)
        if #u ~= 0 then
            local ar = u[#u].tickets_end
            local as = 0.1
            local ae = 0.8
            local at = 0.0
            for z = 1, #u, 1 do
                local au = u[z].tickets_end - u[z].tickets_start + 1
                local av = au / ar
                local aw = av * ae
                u[z].centerXPos = as + ae * at + aw / 2
                u[z].rectLength = aw
                DrawRect(as + ae * at + aw / 2,0.5,ae * av,0.2,u[z].colour.r,u[z].colour.g,u[z].colour.b,u[z].colour.a)
                at = at + av
            end
            if m then
                DrawAdvancedText(0.6,0.161,0.005,0.0028,1.12,"Round starting in " .. l .. "s",255,255,255,255,4,0)
            elseif s then
                DrawAdvancedText(0.6, 0.161, 0.005, 0.0028, 1.12, "Waiting for bets", 255, 255, 255, 255, 4, 0)
            end
            if n then
                DrawAdvancedText(0.6,0.161,0.005,0.0028,1.12,n .. " wins with a chance of " .. math.floor(o * 1000) / 1000 .. "%!",255,255,255,255,4,0)
            end
            if r then
                DrawAdvancedText(0.92,0.161,0.005,0.0028,1.12,"Total Pot: " .. getMoneyStringFormatted(r),255,255,255,255,4,0)
            end
            DrawRect(i, 0.5, -0.0025, 0.346, 243, 198, 50, 255)
        else
            DrawAdvancedText(0.6, 0.161, 0.005, 0.0028, 1.12, "Waiting for bets", 255, 255, 255, 255, 4, 0)
        end
        SetTextRenderId(GetDefaultScriptRendertargetRenderId())
        SetScriptGfxDrawBehindPausemenu(0)
        Wait(0)
    end
end)
function getTrackGenderAnimDict()
    local ax = GetEntityModel(tARMA.getPlayerPed())
    if ax == "mp_m_freemode_01" then
        return "anim_casino_a@amb@casino@games@insidetrack@male"
    else
        return "anim_casino_a@amb@casino@games@insidetrack@female"
    end
end
RegisterNetEvent("ARMA:successJackpotBet",function()
    f = false
    h = false
    j = true
    PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", 1)
end)
RegisterNetEvent("ARMA:beginJackpot",function()
    s = false
    l = 60
    m = true
    SetTimeout(60000,function()
        m = false
    end)
end)
RegisterNetEvent("ARMA:newJackpotBet",function(ay)
    table.insert(u, ay)
end)
RegisterNetEvent("ARMA:cleanupJackpot",function()
    u = {}
    if e ~= -1 then
        f = true
        local H = getTrackGenderAnimDict()
        local I = "playidle_var_01"
        local J = func_4783(e, 0, H, I)
        local K = func_4781(e, 0, H, I)
        local az = NetworkCreateSynchronisedScene(J.x, J.y, J.z, 0.0, 0.0, K, 2, 1, 0, 1065353216, 0, 1065353216)
        NetworkAddPedToSynchronisedScene(tARMA.getPlayerPed(), az, H, I, 2.0, -2.0, 5, 0, 1148846080, 0)
        NetworkStartSynchronisedScene(az)
        local Q = setupJackpotInstructionalScaleform("instructional_buttons")
        Citizen.CreateThread(function()
            while f do
                DrawScaleformMovieFullscreen(Q, 255, 255, 255, 255, 0)
                Wait(0)
            end
        end)
    end
    h = false
    j = false
    p = 0
    n = nil
    o = 0
    s = true
    r = 0
end)
Citizen.CreateThread(function()
    while true do
        if l >= 0 then
            l = l - 1
        end
        Wait(1000)
    end
end)
