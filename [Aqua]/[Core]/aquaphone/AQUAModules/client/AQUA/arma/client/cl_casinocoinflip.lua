local a = -1
local b = 1000
local c = {}
local d = false
local e = false
local f = {}
local g = false
local h = {}
local i
local j
local k
local l = false
local m = false
c.coinflipTables = {
    [0] = {
        tablePos = vector3(1146.329, 261.2543, -52.84094),
        tableHeading = 130.0,
        distance = 1000.0,
        tableModel = "vw_prop_casino_blckjack_coinflip",
        textureVariant = 2,
        objectId = 0
    },
    [1] = {
        tablePos = vector3(1143.338, 264.2453, -52.84094),
        tableHeading = 130.0,
        distance = 1000.0,
        tableModel = "vw_prop_casino_blckjack_coinflip",
        textureVariant = 2,
        objectId = 0
    }
}
local function n(o)
    local p = -1
    for q = 0, o, 4 do
        p = p + 1
    end
    return p
end
local function r(o)
    if o == 0 then
        return 3
    end
    if o == 1 then
        return 2
    end
    if o == 2 then
        return 1
    end
    if o == 3 then
        return 0
    end
end
local function s(o)
    if o == 1 then
        return 1
    end
    if o == 2 then
        return 3
    end
    if o == 3 then
        return 5
    end
    if o == 4 then
        return 7
    end
end
local function t(u)
    if u ~= -1 then
        return u % 4
    else
        return 100
    end
end
local function v(o)
    local p = n(o)
    local w = c.coinflipTables[p].objectId
    if DoesEntityExist(w) then
        local x = t(o)
        local y = s(x)
        local z = "not found"
        if y then
            z = (y + 1) / 2
        end
        return GetWorldPositionOfEntityBone_2(w, y), z
    else
        return vector3(0.0, 0.0, 0.0)
    end
end
local function A(B)
    local p = n(B)
    local w = c.coinflipTables[p].objectId
    if DoesEntityExist(w) then
        local x = t(B)
        x = r(x) + 1
        if x == 3 then
            return GetWorldRotationOfEntityBone(w, s(x)) + vector3(0.0, 0.0, 40.0)
        else
            return GetWorldRotationOfEntityBone(w, s(x))
        end
    else
        return vector3(0.0, 0.0, 0.0)
    end
end

RegisterNetEvent("ARMA:sendCoinflipTableData")
AddEventHandler("ARMA:sendCoinflipTableData",function(C)
    f = C
end)

Citizen.CreateThread(function()
    Wait(1000)
    TriggerServerEvent("ARMA:requestCoinflipTableData")
    for q = 0, #c.coinflipTables do
        local D = c.coinflipTables[q]
        local DD = tARMA.loadModel(D.tableModel)
        c.coinflipTables[q].objectId = CreateObjectNoOffset(D.tableModel, D.tablePos.x, D.tablePos.y, D.tablePos.z, false, false, false)
        SetModelAsNoLongerNeeded(DD)
        SetEntityHeading(c.coinflipTables[q].objectId, D.tableHeading)
        FreezeEntityPosition(c.coinflipTables[q].objectId, true)
        SetObjectTextureVariant(c.coinflipTables[q].objectId, c.coinflipTables[q].textureVariant)
    end
    while true do
        b = 1000
        a = -1
        local E = GetEntityCoords(PlayerPedId())
        for o = 0, (#c.coinflipTables + 1) * 4 - 1, 1 do
            local F, G = v(o)
            if F ~= vector3(0.0, 0.0, 0.0) then
                local H = #(E - F)
                if H < b then
                    b = H
                    a = o
                end
            end
        end
        Wait(100)
    end
end)

AddEventHandler("onResourceStop",function(I)
    if I == GetCurrentResourceName() then
        for q, J in pairs(c.coinflipTables) do
            DeleteObject(c.coinflipTables[q].objectId)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        if d then
            if m then
                TaskPlayAnim(tARMA.getPlayerPed(),"anim_casino_b@amb@casino@games@shared@player@","idle_cardgames",1.0,1.0,-1,0)
            end
            if not l and IsControlJustPressed(0, 202) and not g and not RageUI.Visible(RMenu:Get("armacoinflip", "confirm")) then
                local K = tARMA.loadAnimDict("anim_casino_b@amb@casino@games@shared@player@")
                NetworkStopSynchronisedScene(Local_198f_255)
                TaskPlayAnim(tARMA.getPlayerPed(), K, "sit_exit_left", 1.0, 1.0, 2500, 0)
                d = false
                e = true
                showHowToCoinflip(false)
                TriggerServerEvent("ARMA:cancelCoinflip", true)
                TriggerServerEvent("ARMA:leaveCoinflipTable")
                h = {}
                m = false
                SetTimeout(5000,function()
                    e = false
                end)
            end
            if b > 5 then
                ClearHelp(true)
                showHowToCoinflip(false)
                playedCasinoGuiSound = false
                if d then
                    d = false
                    e = true
                    showHowToCoinflip(false)
                    TriggerServerEvent("ARMA:cancelCoinflip", true)
                    TriggerServerEvent("ARMA:leaveCoinflipTable")
                    m = false
                    h = {}
                end
            end
        end
        if not d then
            if a ~= -1 and b < 2 then
                if IsControlJustPressed(0, 38) then
                    if f[a] == false then
                        TriggerServerEvent("ARMA:requestSitAtCoinflipTable", a)
                    end
                end
            end
        end
        if not d then
            if a ~= -1 and b < 2 then
                if not e then
                    if f[a] == false then
                        drawNativeNotification("Press ~INPUT_PICKUP~ to play Coinflip")
                    else
                        drawNativeNotification("This seat is taken.")
                    end
                    showHowToCoinflip(true)
                    if not playedCasinoGuiSound then
                        playedCasinoGuiSound = true
                        PlaySoundFrontend(-1, "DLC_VW_RULES", "dlc_vw_table_games_frontend_sounds", 1)
                        PlaySoundFrontend(-1, "DLC_VW_WIN_CHIPS", "dlc_vw_table_games_frontend_sounds", 1)
                    end
                end
            end
        end
        Wait(0)
    end
end)

RegisterNetEvent("ARMA:sitAtCoinflipTable")
AddEventHandler("ARMA:sitAtCoinflipTable",function(o, L)
    if L then
        h[L.betId] = L
    end
    goToCoinflipSeat(o)
end)

local function M(x)
    if x == 0 then
        return "sit_enter_left"
    elseif x == 1 then
        return "sit_enter_left_side"
    elseif x == 2 then
        return "sit_enter_right_side"
    end
    return "sit_enter_left"
end
local function N(u)
    if u ~= -1 then
        return u % 4 + 1
    else
        return 100
    end
end
function goToCoinflipSeat(o)
    g = true
    d = true
    e = true
    SetTimeout(2500,function()
        e = false
        showHowToCoinflip(false)
        showCoinflipMenu(true)
        m = true
    end)
    drawNativeNotification("Waiting for next game to start...")
    local O = {"anim_casino_b@amb@casino@games@blackjack@dealer", "anim_casino_b@amb@casino@games@shared@dealer@", "anim_casino_b@amb@casino@games@blackjack@player", "anim_casino_b@amb@casino@games@shared@player@"}
    for J, P in pairs(O) do
        tARMA.loadAnimDict(P)
    end
    local E = GetEntityCoords(PlayerPedId())
    local p = n(o)
    local w = c.coinflipTables[p].objectId
    local Q = c.coinflipTables[p].tablePos
    local x = t(o)
    local R = GetAnimInitialOffsetPosition("anim_casino_b@amb@casino@games@shared@player@",M(x),Q.x,Q.y,Q.z,0.0,0.0,0.0,0.01,2)
    local S = GetAnimInitialOffsetRotation("anim_casino_b@amb@casino@games@shared@player@",M(x),Q.x,Q.y,Q.z,0.0,0.0,0.0,0.01,2)
    TaskGoStraightToCoord(tARMA.getPlayerPed(), R.x, R.y, R.z, 1.0, 5000, S.z, 0.01)
    Wait(500)
    local T = v(o)
    local U = A(o)
    local V = NetworkCreateSynchronisedScene(T.x, T.y, T.z, U.x, U.y, U.z, 2, 1, 0, 1065353216, 0, 1065353216)
    NetworkAddPedToSynchronisedScene(tARMA.getPlayerPed(),V,"anim_casino_b@amb@casino@games@shared@player@",M(x),2.0,-2.0,13,16,2.0,0)
    NetworkStartSynchronisedScene(V)
    Citizen.InvokeNative(0x79C0E43EB9B944E2, -2124244681)
    Wait(6000)
    Locali98f_55 = NetworkCreateSynchronisedScene(T.x, T.y, T.z, U.x, U.y, U.z, 2, 1, 1, 1065353216, 0, 1065353216)
    NetworkAddPedToSynchronisedScene(tARMA.getPlayerPed(),Locali98f_55,"anim_casino_b@amb@casino@games@shared@player@","idle_cardgames",2.0,-2.0,13,16,1148846080,0)
    NetworkStartSynchronisedScene(Locali98f_55)
    StartAudioScene("DLC_VW_Casino_Table_Games")
    Citizen.InvokeNative(0x79C0E43EB9B944E2, -2124244681)
    g = false
end
function showHowToCoinflip(W)
    RageUI.ActuallyCloseAll()
    RageUI.Visible(RMenu:Get("armacoinflip", "instructions"), W)
end
function showCoinflipMenu(W)
    RageUI.Visible(RMenu:Get("armacoinflip", "mainmenu"), W)
end
RMenu.Add("armacoinflip", "instructions", RageUI.CreateMenu("", "~b~COINFLIP", 0, 100, "banners", "coinflip"))
RMenu.Add("armacoinflip", "mainmenu", RageUI.CreateMenu("", "~b~COINFLIP", 0, 100, "banners", "coinflip"))
RMenu.Add("armacoinflip", "confirm", RageUI.CreateSubMenu(RMenu:Get("armacoinflip", "mainmenu"), "", "~b~COINFLIP", 0, 100, "banners", "coinflip"))


RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('armacoinflip', 'instructions')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            RageUI.Separator("Propose a bet, or accept a proposed bet.")
            RageUI.Separator("Flip a coin against your opponent, winner takes all!")
            RageUI.Separator("Minimum £100,000 per coinflip.")
        end)
    end
    if RageUI.Visible(RMenu:Get('armacoinflip', 'mainmenu')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            RageUI.Button("Propose Bet","",{RightLabel = "→→→"},true,function(X, Y, Z)
                if Z then
                    local _ = getGenericTextInput("Bet Amount")
                    if tonumber(_) then
                        _ = tonumber(_)
                        if _ > 0 then
                            TriggerServerEvent("ARMA:proposeCoinflip", _)
                        end
                    end
                end
            end)
            RageUI.Separator("---")
            if table.count(h) > 0 then
                for a0, L in pairs(h) do
                    RageUI.Button("~y~£" .. getMoneyStringFormatted(L.betAmount),"",{RightBadge=RageUI.BadgeStyle.GoldMedal},true,function(X, Y, Z)
                        if Z then
                            i = a0
                            j = "£" .. getMoneyStringFormatted(L.betAmount)
                            if L.user_id == tARMA.getUserId() then
                                k = true
                            else
                                k = false
                            end
                        end
                    end,
                    RMenu:Get("armacoinflip", "confirm"))
                end
            else
                RageUI.Separator("~r~No pending bets.")
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('armacoinflip', 'confirm')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            if not h[i] then
                RageUI.Visible(RMenu:Get("armacoinflip", "confirm"), false)
                RageUI.Visible(RMenu:Get("armacoinflip", "mainmenu"), true)
            end
            RageUI.Separator("Coinflip " .. j .. "?")
            if k then
                RageUI.Separator("~y~This is your pending proposal.")
                RageUI.Button("Cancel Bet","",{RightBadge= RageUI.BadgeStyle.Tick},true,function(X, Y, Z)
                    if Z then
                        TriggerServerEvent("ARMA:cancelCoinflip")
                    end
                end,RMenu:Get("armacoinflip", "mainmenu"))
                RageUI.Button("Return","",{RightBadge= RageUI.BadgeStyle.Alert},true,function(X, Y, Z)
                if Z then
                    end
                end,
                RMenu:Get("armacoinflip", "mainmenu"))
            else
                RageUI.Button("Accept","",{RightBadge= RageUI.BadgeStyle.Tick},true,function(X, Y, Z)
                    if Z then
                        TriggerServerEvent("ARMA:acceptCoinflip", i)
                    end
                end,
                RMenu:Get("armacoinflip", "mainmenu"))
                RageUI.Button("Decline","",{RightBadge= RageUI.BadgeStyle.Alert},true,function(X, Y, Z)
                end,RMenu:Get("armacoinflip", "mainmenu"))
            end
        end)
    end
end)

AddEventHandler("ARMA:onClientSpawn",function(D, E)
    if E then
        TriggerServerEvent("ARMA:requestCoinflipTableData")
    end
end)

RegisterNetEvent("ARMA:addCoinflipProposal",function(a0, L)
    h[a0] = L
end)

RegisterNetEvent("ARMA:cancelCoinflipBet",function(a0)
    h[a0] = nil
end)

RegisterNetEvent("ARMA:clearCoinflipBets",function()
    h = {}
end)

RegisterNetEvent("ARMA:coinflipOutcome",function(a3, a4)
    l = true
    showCoinflipMenu(false)
    SendNUIMessage({transactionType = "jackpotroll"})
    local a5 = Scaleform("MP_BIG_MESSAGE_FREEMODE")
    local a6 = false
    local a7 = false
    SetTimeout(10000,function()
        a6 = true
        if a3 then
            tARMA.notify("~g~ You won £" .. getMoneyStringFormatted(a4.amount) .. "!")
            SendNUIMessage({transactionType = "playCasinoWin"})
        else
            tARMA.notify("~r~ You lost £" .. getMoneyStringFormatted(a4.amount) .. "!")
            SendNUIMessage({transactionType = "playCasinoLose"})
        end
    end)
    SetTimeout(15000,function()
        a7 = true
    end)
    local a8 = false
    local a9 = 0.0
    local aa = 2.71828182846
    local ab = 0.00
    local E = tARMA.getPlayerCoords()
    while not a7 do
        local ac = GetFrameTime()
        a9 = a9 + 0.01 * ac
        local ad = 1 - math.pow(aa, -80 * a9)
        if ad > ab + 0.005 then
            ab = ad
            a8 = not a8
            local ae = GetSoundId()
            PlaySoundFromCoord(ae, "Spin_Single_Ticks", E.x, E.y, E.z, "dlc_vw_casino_lucky_wheel_sounds", 0, 0, 0)
            SetTimeout(100,function()
                ReleaseSoundId(ae)
            end)
        end
        if a8 then
            if not a6 then
                a5.RunFunction("SHOW_SHARD_WASTED_MP_MESSAGE", {a4.winner, "Rolling...", 0, false, false})
            end
        else
            if not a6 then
                a5.RunFunction("SHOW_SHARD_WASTED_MP_MESSAGE", {a4.loser, "Rolling...", 0, false, false})
            end
        end
        if a6 then
            if a3 then
                a5.RunFunction("SHOW_SHARD_WASTED_MP_MESSAGE", {a4.winner, "~g~You WON!", 0, false, false})
            else
                a5.RunFunction("SHOW_SHARD_WASTED_MP_MESSAGE", {a4.winner, "~r~You LOST!", 0, false, false})
            end
        end
        a5.Render2D()
        Wait(0)
    end
    h = {}
    showCoinflipMenu(true)
    l = false
end)

function getGenericTextInput(a)
    if a == nil then
        a = ""
    end
    AddTextEntry("FMMC_MPM_NA", "Enter " .. tostring(a))
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Enter " .. tostring(a) .. " message", "", "", "", "", 30)
    while UpdateOnscreenKeyboard() == 0 do
        DisableAllControlActions(0)
        Wait(0)
    end
    if GetOnscreenKeyboardResult() then
        local b = GetOnscreenKeyboardResult()
        if b then
            return b
        end
    end
    return false
end
