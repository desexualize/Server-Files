local a = -1
local b = 1000
local c = -1
local d = nil
local e = 1000
local f = {}
local g = nil
local h = false
local i = false
local j = false
local k = nil
local l = nil
local m = {}
local n = false
local o = 0
local p = 20
local q = false
local r = false
local s = false
local t = -1
local u = -1
cardObjects = {}
local w = false
local x = 0
local y = 0
local z = 0
sittingAtBlackjackTable = false
local A = false
local B = 100000
local C = {}
local D = false
local E = false
local F = -1
local G = {}
local H = 0
local I = 0
local J = {
    [8] = true,
    [9] = true,
    [10] = true,
    [11] = true,
    [12] = true,
    [13] = true,
    [14] = true,
    [15] = true,
    [20] = true,
    [21] = true,
    [22] = true,
    [23] = true,
    [28] = true,
    [29] = true,
    [30] = true,
    [31] = true,
    [44] = true,
    [45] = true,
    [46] = true,
    [47] = true,
    [48] = true,
    [49] = true,
    [50] = true,
    [51] = true,
    [60] = true,
    [61] = true,
    [62] = true,
    [63] = true,
    [68] = true,
    [69] = true,
    [70] = true,
    [71] = true
}
G.blackjackTables = {
    [0] = {
        dealerPos = vector3(1149.3828125, 269.19174194336, -52.020873718262),
        dealerHeading = 46.0,
        tablePos = vector3(1148.837, 269.747, -52.8409),
        tableHeading = -134.69,
        distance = 1000.0,
        prop = "vw_prop_casino_blckjack_01",
        textureVariant = 0,
        objectId = 0
    },
    [1] = {
        dealerPos = vector3(1151.28, 267.33, -51.840),
        dealerHeading = 222.2,
        tablePos = vector3(1151.84, 266.747, -52.8409),
        tableHeading = 45.31,
        distance = 1000.0,
        prop = "vw_prop_casino_blckjack_01",
        textureVariant = 0,
        objectId = 0
    },
    [2] = {
        dealerPos = vector3(1128.862, 261.795, -51.0357),
        dealerHeading = 315.0,
        tablePos = vector3(1129.406, 262.3578, -52.041),
        tableHeading = 135.31,
        distance = 1000.0,
        prop = "vw_prop_casino_blckjack_01b",
        textureVariant = 3,
        objectId = 0
    },
    [3] = {
        dealerPos = vector3(1143.859, 246.783, -51.035),
        dealerHeading = 313.0,
        tablePos = vector3(1144.429, 247.3352, -52.041),
        tableHeading = 135.31,
        distance = 1000.0,
        prop = "vw_prop_casino_blckjack_01b",
        textureVariant = 3,
        objectId = 0
    },
    [4] = {
        dealerPos = vector3(54.053936004639, 6742.1513671875, -107.354347229),
        dealerHeading = 289.0,
        tablePos = vector3(54.96381, 6742.344, -108.3549),
        tableHeading = 103.31,
        distance = 1000.0,
        prop = "vw_prop_casino_blckjack_01",
        textureVariant = 2,
        objectId = 0
    },
    [5] = {
        dealerPos = vector3(50.321300506592, 6740.3862304688, -107.354347229),
        dealerHeading = 232.0,
        tablePos = vector3(51.11047, 6739.992, -108.3609),
        tableHeading = 58.31,
        distance = 1000.0,
        prop = "vw_prop_casino_blckjack_01b",
        textureVariant = 3,
        objectId = 0
    },
    [6] = {
        dealerPos = vector3(49.360774993896, 6736.0034179688, -107.354347229),
        dealerHeading = 182.0,
        tablePos = vector3(49.38696, 6735.1, -108.356),
        tableHeading = 3.31,
        distance = 1000.0,
        prop = "vw_prop_casino_blckjack_01",
        textureVariant = 2,
        objectId = 0
    },
    [7] = {
        dealerPos = vector3(48.363880157471, 6741.6293945313, -107.35426330566),
        dealerHeading = 51.0,
        tablePos = vector3(47.65973, 6742.091, -108.3627),
        tableHeading = 238.00006103516,
        distance = 1000.0,
        prop = "vw_prop_casino_blckjack_01b",
        textureVariant = 3,
        objectId = 0
    },
    [8] = {
        dealerPos = vector3(47.192687988281, 6745.7915039063, -107.35426330566),
        dealerHeading = 22.87,
        tablePos = vector3(46.76453, 6746.482, -108.3617),
        tableHeading = 208.00006103516,
        distance = 1000.0,
        prop = "vw_prop_casino_blckjack_01",
        textureVariant = 2,
        objectId = 0
    },
    [9] = {
        dealerPos = vector3(44.35587310791, 6739.7065429688, -107.35426330566),
        dealerHeading = 101.87,
        tablePos = vector3(43.54211, 6739.413, -108.3554),
        tableHeading = 288.00006103516,
        distance = 1000.0,
        prop = "vw_prop_casino_blckjack_01",
        textureVariant = 2,
        objectId = 0
    },
    [10] = {
        dealerPos = vector3(-1896.8582763672, 2069.3537597656, 144.86274719238),
        dealerHeading = 319.69,
        tablePos = vector3(-1896.395, 2070.015, 143.8623),
        tableHeading = 140.00010681152,
        distance = 1000.0,
        prop = "vw_prop_casino_blckjack_01",
        textureVariant = 2,
        objectId = 0
    },
    [11] = {
        dealerPos = vector3(774.75134277344, -552.91137695312, 22.498882293701),
        dealerHeading = 327.68,
        tablePos = vector3(775.0756, -552.1633, 21.49033),
        tableHeading = 152.00003,
        distance = 1000.0,
        prop = "vw_prop_casino_blckjack_01",
        textureVariant = 3,
        objectId = 0
    },
    [12] = {
        dealerPos = vector3(761.36926269531, -552.77777099609, 21.998830795288),
        dealerHeading = 352.68,
        tablePos = vector3(761.3812, -551.9634, 20.97152),
        tableHeading = 177.00003,
        distance = 1000.0,
        prop = "vw_prop_casino_blckjack_01",
        textureVariant = 3,
        objectId = 0
    },
    [13] = {
        dealerPos = vector3(-1137.8917236328, -184.71762084961, 40.0803565979),
        dealerHeading = 103.53,
        tablePos = vector3(-1138.666, -185.0631, 39.07666),
        tableHeading = 289.703,
        distance = 1000.0,
        prop = "vw_prop_casino_blckjack_01",
        textureVariant = 0,
        objectId = 0
    },
    [14] = {
        dealerPos = vector3(-1135.7133789062, -187.96678161621, 40.080360412598),
        dealerHeading = 148.16,
        tablePos = vector3(-1136.052, -188.7057, 39.07666),
        tableHeading = 334.44,
        distance = 1000.0,
        prop = "vw_prop_casino_blckjack_01",
        textureVariant = 0,
        objectId = 0
    },
    [15] = {
        dealerPos = vector3(-1125.2545166016, -189.25283813477, 40.080368041992),
        dealerHeading = 65.87,
        tablePos = vector3(-1126.019, -188.9474, 39.07666),
        tableHeading = 242.50,
        distance = 1000.0,
        prop = "vw_prop_casino_blckjack_01",
        textureVariant = 3,
        objectId = 0
    },
    [16] = {
        dealerPos = vector3(422.06201171875, 18.277492523193, 91.935234069824),
        dealerHeading = 63.4,
        tablePos = vector3(421.276, 18.63568, 90.93006),
        tableHeading = 240.00003051758,
        distance = 1000.0,
        prop = "vw_prop_casino_blckjack_01",
        textureVariant = 0,
        objectId = 0
    },
    [17] = {
        dealerPos = vector3(406.5924987793, 10.847332000732, 91.935264587402),
        dealerHeading = 283.87,
        tablePos = vector3(407.3547, 11.09218, 90.93006),
        tableHeading = 106.337,
        distance = 1000.0,
        prop = "vw_prop_casino_blckjack_01",
        textureVariant = 3,
        objectId = 0
    }
}
RegisterCommand(
    "getcasinotable",
    function()
        local K = GetEntityCoords(tARMA.getPlayerPed())
        local L = GetClosestObjectOfType(K.x, K.y, K.z, 1.0, GetHashKey("vw_prop_casino_blckjack_01"), 0, 0, 0)
        if DoesEntityExist(L) then
            print("Found entity")
            print("tablePos pos", GetEntityCoords(L))
            print("tableHeading heading", GetEntityHeading(L))
            print("prop: vw_prop_casino_blckjack_01")
        else
            local M = GetClosestObjectOfType(K.x, K.y, K.z, 1.0, GetHashKey("vw_prop_casino_blckjack_01b"), 0, 0, 0)
            if DoesEntityExist(M) then
                print("Found entity")
                print("tablePos pos:", GetEntityCoords(M))
                print("tableHeading heading:", GetEntityHeading(M))
                print("prop: vw_prop_casino_blckjack_01")
            else
                print("Could not find entity")
            end
        end
    end
)
Citizen.CreateThread(
    function()
        TriggerServerEvent("Blackjack:requestBlackjackTableData")
    end
)
RegisterNetEvent(
    "Blackjack:sendBlackjackTableData",
    function(N)
        m = N
    end
)
Citizen.CreateThread(function()
    math.randomseed(GetGameTimer())
    for O = 0, #G.blackjackTables, 1 do
        math.random()
        math.random()
        math.random()
        randomBlackShit = math.random(1, 13)
        if randomBlackShit < 7 then
            dealerModel = GetHashKey("S_M_Y_Casino_01")
        else
            dealerModel = GetHashKey("S_F_Y_Casino_01")
        end
        local P = G.blackjackTables[O]
        tARMA.createDynamicPed(dealerModel,P.dealerPos,P.dealerHeading,true,nil,nil,75.0,nil,function(Q)
            f[O + 1] = Q
            SetEntityCanBeDamaged(Q, 0)
            SetPedAsEnemy(Q, 0)
            SetBlockingOfNonTemporaryEvents(Q, 1)
            SetPedResetFlag(Q, 249, 1)
            SetPedConfigFlag(Q, 185, true)
            SetPedConfigFlag(Q, 108, true)
            SetPedCanEvasiveDive(Q, 0)
            SetPedCanRagdollFromPlayerImpact(Q, 0)
            SetPedConfigFlag(Q, 208, true)
            setBlackjackDealerPedVoiceGroup(randomBlackShit, Q)
            setBlackjackDealerClothes(randomBlackShit, Q)
            SetEntityCoordsNoOffset(Q,G.blackjackTables[O].dealerPos.x,G.blackjackTables[O].dealerPos.y,G.blackjackTables[O].dealerPos.z,0,0,1)
            SetEntityHeading(Q, G.blackjackTables[O].dealerHeading)
            local dealerAnimDict = "anim_casino_b@amb@casino@games@shared@dealer@"
            tARMA.loadAnimDict(dealerAnimDict)
            if dealerModel == maleCasinoDealer then
                TaskPlayAnim(Q, dealerAnimDict, "idle", 1000.0, -2.0, -1, 2, 1148846080, 0)
            else
                TaskPlayAnim(Q, dealerAnimDict, "female_idle", 1000.0, -2.0, -1, 2, 1148846080, 0)
            end
            PlayFacialAnim(Q, "idle_facial", dealerAnimDict)
            RemoveAnimDict(dealerAnimDict)
        end)
    end
    while true do
        for O = 0, #G.blackjackTables, 1 do
            local R = G.blackjackTables[O]
            local S = R.tablePos
            local T = GetClosestObjectOfType(S.x, S.y, S.z, 1.0, GetHashKey(R.prop), 0, 0, 0)
            if T ~= 0 then
                SetObjectTextureVariation(T, R.textureVariant)
                R.objectId = T
            end
            Wait(1000)
        end
    end
end)
function resetDealerIdle(U)
    local gender = getDealerGenderFromPed(U)
    if DoesEntityExist(U) then
        if gender == "male" then
            genderAnimString = ""
        end
        if gender == "female" then
            genderAnimString = "female_"
        end
        dealerAnimDict = "anim_casino_b@amb@casino@games@shared@dealer@"
        RequestAnimDict(dealerAnimDict)
        while not HasAnimDictLoaded(dealerAnimDict) do
            Wait(0)
        end
        TaskPlayAnim(U, dealerAnimDict, genderAnimString .. "idle", 1000.0, -2.0, -1, 2, 1148846080, 0)
        PlayFacialAnim(U, "idle_facial", dealerAnimDict)
        TaskPlayAnim(tARMA.getPlayerPed(),"anim_casino_b@amb@casino@games@shared@player@","idle_cardgames",1.0,1.0,-1,0)
        RemoveAnimDict(dealerAnimDict)
    end
end
local V = false
Citizen.CreateThread(function()
    while true do
        if not sittingAtBlackjackTable then
            if a ~= -1 and b < 2 then
                if not n then
                    if m[a] == false then
                        drawNativeNotification("Press ~INPUT_PICKUP~ to play blackjack")
                    else
                        drawNativeNotification("This seat is taken.")
                    end
                    showHowToBlackjack(true)
                    if not V then
                        V = true
                        PlaySoundFrontend(-1, "DLC_VW_RULES", "dlc_vw_table_games_frontend_sounds", 1)
                        PlaySoundFrontend(-1, "DLC_VW_WIN_CHIPS", "dlc_vw_table_games_frontend_sounds", 1)
                    end
                end
            end
        end
        if E and sittingAtBlackjackTable then
            TaskPlayAnim(
                tARMA.getPlayerPed(),
                "anim_casino_b@amb@casino@games@shared@player@",
                "idle_cardgames",
                1.0,
                1.0,
                -1,
                0
            )
        end
        if a ~= -1 then
            if b > 2 and b < 3 then
                ClearHelp(true)
                showHowToBlackjack(false)
                V = false
            end
        end
        if w then
            BeginTextCommandPrint("STRING")
            AddTextComponentSubstringPlayerName("Your hand is [" .. tostring(x) .. "], the dealers hand is [" .. tostring(y) .. "]")
            EndTextCommandPrint(1000, 1)
        end
        if h then
            if IsDisabledControlJustPressed(0, 22) then
                local W = getGenericTextInput("Bet Amount")
                if tonumber(W) then
                    W = tonumber(W)
                    if W > 0 then
                        if not isChairHighRollers(F) and z > B then
                            tARMA.notify("~r~Maximum bet is " ..tostring(getMoneyStringFormatted(B)) .." please purchase a membership for higher bets.")
                        else
                            z = W
                        end
                    end
                end
            end
            if IsControlJustPressed(0, 201) then
                if tonumber(z) >= 0 then
                    if not isChairHighRollers(F) and z > B then
                        tARMA.notify("~r~Maximum bet is " ..tostring(getMoneyStringFormatted(B)) .." please purchase a membership for higher bets.")
                    elseif isChairHighRollers(F) and z < B then
                        tARMA.notify("~r~Minimum bet is " .. tostring(getMoneyStringFormatted(B)))
                    elseif z > 1000000000 then
                        tARMA.notify("~r~Maximum bet is £1,000,000,000")
                    else
                        TriggerServerEvent("Blackjack:setBlackjackBet", t, math.floor(z), F)
                        d = getClosestDealer()
                        PlayPedAmbientSpeechNative(
                            d,
                            "MINIGAME_DEALER_PLACE_CHIPS",
                            "SPEECH_PARAMS_FORCE_NORMAL_CLEAR"
                        )
                        putBetOnTable()
                        Wait(1000)
                    end
                else
                    tARMA.notify("~r~Invalid amount.")
                end
            end
        end
        if a ~= -1 and b < 2 then
            if IsControlJustPressed(0, 38) then
                if m[a] == false then
                    TriggerServerEvent("Blackjack:requestSitAtBlackjackTable", a)
                end
            end
        end
        Wait(0)
    end
end)
RegisterNetEvent("Blackjack:successBlackjackBet",function()
    r = true
    h = false
    A = false
    k = nil
end)
RegisterNetEvent("Blackjack:sitAtBlackjackTable",function(X)
    F = X
    goToBlackjackSeat(X)
end)
Citizen.CreateThread(function()
    while true do
        if sittingAtBlackjackTable and A then
            SetPedCapsule(tARMA.getPlayerPed(), 0.2)
            if IsControlJustPressed(0, 202) and not i then
                E = false
                Wait(0)
                blackjackAnimDictToLoad = "anim_casino_b@amb@casino@games@shared@player@"
                RequestAnimDict(blackjackAnimDictToLoad)
                while not HasAnimDictLoaded(blackjackAnimDictToLoad) do
                    Wait(0)
                end
                NetworkStopSynchronisedScene(g)
                TaskPlayAnim(tARMA.getPlayerPed(), blackjackAnimDictToLoad, "sit_exit_left", 1.0, 1.0, 2500, 0)
                RemoveAnimDict(blackjackAnimDictToLoad)
                sittingAtBlackjackTable = false
                n = true
                k = nil
                l = nil
                h = false
                w = false
                TriggerServerEvent("Blackjack:leaveBlackjackTable")
                d, closestDealerPedDistance = getClosestDealer()
                PlayPedAmbientSpeechNative(d,"MINIGAME_DEALER_LEAVE_NEUTRAL_GAME","SPEECH_PARAMS_FORCE_NORMAL_CLEAR")
                q = false
                F = -1
                if DoesCamExist(H) then
                    DestroyCam(H, 0)
                    RenderScriptCams(false, true, 3000, 1, 0)
                    H = 0
                end
                if DoesCamExist(I) then
                    DestroyCam(I, 0)
                    RenderScriptCams(false, true, 3000, 1, 0)
                    I = 0
                end
                SetTimeout(5000,function()
                    n = false
                end)
            end
        end
        if j and sittingAtBlackjackTable and D then
            if IsDisabledControlJustPressed(0, 22) then
                j = false
                TriggerServerEvent("Blackjack:hitBlackjack", t, u)
                q = false
                s = true
                requestCard()
            end
            if IsControlJustPressed(0, 202) then
                j = false
                TriggerServerEvent("Blackjack:standBlackjack", t, u)
                q = false
                s = true
                declineCard()
            end
        end
        Wait(0)
    end
end)

Citizen.CreateThread(function()
    Wait(5000)
    while true do
        b = 1000
        a = -1
        local K = GetEntityCoords(tARMA.getPlayerPed())
        for Y = 0, (#G.blackjackTables + 1) * 4 - 1, 1 do
            local Z = blackjack_func_348(Y)
            if Z ~= vector3(0.0, 0.0, 0.0) then
                local _ = #(K - Z)
                if _ < b then
                    b = _
                    a = Y
                end
            end
        end
        Wait(100)
    end
end)
RMenu.Add('armablackjack', 'instructions', RageUI.CreateMenu("", "test",1300, 50,"casinoui_cards_blackjack", "casinoui_cards_blackjack"))
RMenu:Get('armablackjack', 'instructions'):SetSubtitle("Blackjack Table")
RMenu.Add('armablackjack_high', 'instructions', RageUI.CreateMenu("", "test",1300, 50,"casinoui_cards_blackjack_high", "casinoui_cards_blackjack_high"))
RMenu:Get('armablackjack_high', 'instructions'):SetSubtitle("High Rollers Table")


RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('armablackjack', 'instructions')) then
        RageUI.DrawContent({ header = true, glare=  false, instructionalButton = true }, function()           
            RageUI.FakeButton("test", "The aim of Blackjack is to beat the Dealer's hand without going over 21. This game uses four 52           card decks, which are shuffled at the start of every hand.                                                                                    The dealer will stand on soft 17.", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
            end, RMenu:Get('armablackjack', 'instructions'))            
        end, function()
        end)
    end
    if RageUI.Visible(RMenu:Get('armablackjack_high', 'instructions')) then
        RageUI.DrawContent({ header = true, glare=  false, instructionalButton = true }, function()           
            RageUI.FakeButton("test", "The aim of Blackjack is to beat the Dealer's hand without going over 21. This game uses four 52           card decks, which are shuffled at the start of every hand.                                                                                    The dealer will stand on soft 17.", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
            end, RMenu:Get('armablackjack_high', 'instructions'))            
        end, function()
            ---Panels
        end)
    end
end, 1)

function showHowToBlackjack(flag)
    RageUI.ActuallyCloseAll()
    if not isChairHighRollers(a) then
        RageUI.Visible(RMenu:Get('armablackjack', 'instructions'), flag)
    else 
        RageUI.Visible(RMenu:Get('armablackjack_high', 'instructions'), flag)
    end
end

function isChairHighRollers(Y)
    if J[Y] then
        return true
    else
        return false
    end
end
Citizen.CreateThread(function()
    while true do
        if F ~= -1 then
            if IsControlJustPressed(0, 10) then
                if H == 0 then
                    H = blackjackCameraView("playerhand", F)
                else
                    DestroyCam(H, 0)
                    RenderScriptCams(false, true, 3000, 1, 0)
                    H = 0
                end
            end
            if IsControlJustPressed(0, 11) then
                if I == 0 then
                    I = blackjackCameraView("dealerhand", F)
                else
                    DestroyCam(I, 0)
                    RenderScriptCams(false, true, 3000, 1, 0)
                    I = 0
                end
            end
        end
        if k ~= nil then
            DrawScaleformMovieFullscreen(k, 255, 255, 255, 255, 0)
            if h then
                DrawGTATimerBar("BET", getMoneyStringFormatted(z), 2)
            end
        end
        if q then
            if p < 10 then
                DrawGTATimerBar("TIME", "00:0" .. tostring(p), 1)
            else
                DrawGTATimerBar("TIME", "00:" .. tostring(p), 1)
            end
        end
        if l ~= nil and j then
            DrawScaleformMovieFullscreen(l, 255, 255, 255, 255, 0)
        end
        Wait(0)
    end
end)

function blackjackCameraView(a4, Y)
    local tableId = blackjack_func_368(Y)
    local a5 = G.blackjackTables[tableId].objectId
    local a6 = G.blackjackTables[tableId].tablePos
    local a7 = CreateCameraWithParams("DEFAULT_SCRIPTED_CAMERA", a6.x, a6.y, a6.z, 0.0, 0.0, 0.0, 65.0, 0, 2)
    SetCamActive(a7, true)
    RenderScriptCams(true, true, 3000, 1, 0)
    SetCamCoord(a7, a6.x, a6.y, a6.z + 2)
    local localChairId = getLocalChairIndexFromGlobalChairId(Y)
    if a4 == "dealerhand" then
        localChairId = 4
    end
    local cardOffsetX, cardOffsetY, cardOffsetZ = blackjack_func_377(0, localChairId, 1)
    local vVar8 = vector3(0.0, 0.0, getTableHeading(blackjack_func_368(Y)))
    AttachCamToEntity(a7, a5, cardOffsetX, cardOffsetY, cardOffsetZ + 0.5, 1)
    PointCamAtEntity(a7, a5, 0, 0, 0, 1)
    return a7
end
function isNearbyBlackjackTableId(tableId)
    local K = GetEntityCoords(tARMA.getPlayerPed())
    local a6 = G.blackjackTables[tableId].tablePos
    local a8 = #(K - a6)
    if a8 < 100.0 then
        return true
    else
        return false
    end
end
RegisterNetEvent("Blackjack:syncChipsPropBlackjack",function(a9, Y)
        if isNearbyBlackjackTableId(blackjack_func_368(Y)) then
            betBlackjack(a9, Y)
        end
    end
)
RegisterNetEvent(
    "Blackjack:beginBetsBlackjack",
    function(aa, tableId)
        t = aa
        k = setupBlackjackInstructionalScaleform("instructional_buttons")
        ClearHelp(true)
        drawNativeNotification("Place your bets")
        r = false
        q = true
        w = false
        s = false
        A = true
        h = true
        local U = getDealerFromTableId(tableId)
        PlayPedAmbientSpeechNative(U, "MINIGAME_DEALER_PLACE_BET", "SPEECH_PARAMS_FORCE_NORMAL_CLEAR")
        z = 0
        y = 0
        x = 0
        SetEntityCoordsNoOffset(
            U,
            G.blackjackTables[tableId].dealerPos.x,
            G.blackjackTables[tableId].dealerPos.y,
            G.blackjackTables[tableId].dealerPos.z,
            0,
            0,
            1
        )
        SetEntityHeading(U, G.blackjackTables[tableId].dealerHeading)
        Citizen.CreateThread(
            function()
                q = true
                while p > 0 and q do
                    p = p - 1
                    Wait(1000)
                end
                p = 20
                h = false
                q = false
                if not r then
                    drawNativeNotification("No bet placed, round skipped")
                end
            end
        )
    end
)
RegisterNetEvent(
    "Blackjack:beginCardGiveOut",
    function(ab, ac, Y, ad, ae, tableId)
        if isNearbyBlackjackTableId(tableId) then
            D = true
            blackjackAnimsToLoad = {
                "anim_casino_b@amb@casino@games@blackjack@dealer",
                "anim_casino_b@amb@casino@games@shared@dealer@",
                "anim_casino_b@amb@casino@games@blackjack@player",
                "anim_casino_b@amb@casino@games@shared@player@"
            }
            for af, ag in pairs(blackjackAnimsToLoad) do
                if not HasAnimDictLoaded(ag) then
                    RequestAnimDict(v)
                    while not HasAnimDictLoaded(v) do
                        Wait(0)
                    end
                end
            end
            if sittingAtBlackjackTable and r then
                w = true
            end
            local U = getDealerFromTableId(tableId)
            local cardObj = startDealing(U, ab, ac, Y, ad + 1, ae, (tableId + 1) * 4 - 1)
            if blackjack_func_368(F) == tableId and ab == Y and ad == 0 then
                y = ae
                k = nil
            end
            C[ab] = cardObj
            if Y == F and ab ~= Y then
                x = ae
                k = nil
            end
        end
    end
)
RegisterNetEvent(
    "Blackjack:singleCard",
    function(ab, ac, ah, ai, ae, tableId)
        if isNearbyBlackjackTableId(tableId) then
            local U = getDealerFromTableId(tableId)
            startSingleDealing(ah, U, ab, ac, ai + 1, ae)
        end
    end
)
RegisterNetEvent(
    "Blackjack:singleDealerCard",
    function(ab, ac, ai, ae, tableId)
        if isNearbyBlackjackTableId(tableId) then
            local U = getDealerFromTableId(tableId)
            startSingleDealerDealing(U, ab, ac, ai + 1, ae, (tableId + 1) * 4 - 1, tableId)
        end
    end
)
RegisterNetEvent(
    "Blackjack:standOrHit",
    function(ab, Y, ai, tableId)
        if isNearbyBlackjackTableId(tableId) then
            local U = getDealerFromTableId(tableId)
            s = false
            if F == Y then
                u = ai
                j = true
                PlayPedAmbientSpeechNative(U, "MINIGAME_BJACK_DEALER_ANOTHER_CARD", "SPEECH_PARAMS_FORCE_NORMAL_CLEAR")
                startStandOrHit(ab, U, Y, true)
                Citizen.CreateThread(
                    function()
                        if sittingAtBlackjackTable then
                            q = true
                            p = 20
                            while p > 0 do
                                p = p - 1
                                if p == 6 then
                                    PlayPedAmbientSpeechNative(
                                        U,
                                        "MINIGAME_DEALER_COMMENT_SLOW",
                                        "SPEECH_PARAMS_FORCE_NORMAL_CLEAR"
                                    )
                                end
                                if s then
                                    p = 20
                                    q = false
                                    return
                                end
                                Wait(1000)
                            end
                        end
                        if not s and sittingAtBlackjackTable then
                            j = false
                            TriggerServerEvent("Blackjack:standBlackjack", t, u)
                            declineCard()
                            drawNativeNotification("Failed to stand/hit in time, standing.")
                        end
                    end
                )
            else
                startStandOrHit(ab, U, Y, false)
            end
        end
    end
)
function getClosestDealer()
    local aj = nil
    local ak = 100000
    local K = GetEntityCoords(tARMA.getPlayerPed())
    for al, v in pairs(f) do
        local U = v
        local am = #(K - GetEntityCoords(U))
        if am < ak then
            ak = am
            aj = U
        end
    end
    d = aj
    closestDealerPedDistance = ak
    return d, closestDealerPedDistance
end
function getDealerFromChairId(Y)
    tableId = blackjack_func_368(Y)
    d = f[tableId + 1]
    return d
end
function getDealerFromTableId(tableId)
    d = f[tableId + 1]
    return d
end
function goToBlackjackSeat(an)
    sittingAtBlackjackTable = true
    i = true
    A = true
    x = 0
    y = 0
    showHowToBlackjack(false)
    d, closestDealerPedDistance = getClosestDealer()
    PlayPedAmbientSpeechNative(d, "MINIGAME_DEALER_GREET", "SPEECH_PARAMS_FORCE_NORMAL_CLEAR")
    drawNativeNotification("Waiting for next game to start...")
    blackjackAnimsToLoad = {
        "anim_casino_b@amb@casino@games@blackjack@dealer",
        "anim_casino_b@amb@casino@games@shared@dealer@",
        "anim_casino_b@amb@casino@games@blackjack@player",
        "anim_casino_b@amb@casino@games@shared@player@"
    }
    for al, v in pairs(blackjackAnimsToLoad) do
        RequestAnimDict(v)
        while not HasAnimDictLoaded(v) do
            Wait(0)
        end
    end
    c = an
    fVar3 = blackjack_func_217(tARMA.getPlayerPed(), blackjack_func_218(c, 0), 1)
    fVar4 = blackjack_func_217(tARMA.getPlayerPed(), blackjack_func_218(c, 1), 1)
    fVar5 = blackjack_func_217(tARMA.getPlayerPed(), blackjack_func_218(c, 2), 1)
    if fVar4 < fVar5 and fVar4 < fVar3 then
        Local_198f_251 = 1
    elseif fVar5 < fVar4 and fVar5 < fVar3 then
        Local_198f_251 = 2
    else
        Local_198f_251 = 0
    end
    local ao = blackjack_func_218(c, Local_198f_251)
    local ap = blackjack_func_216(c, Local_198f_251)
    TaskGoStraightToCoord(tARMA.getPlayerPed(), ao.x, ao.y, ao.z, 1.0, 5000, ap, 0.01)
    local aq = blackjack_func_348(c)
    local ar, as, at = blackjack_func_215(c)
    g = NetworkCreateSynchronisedScene(aq.x, aq.y, aq.z, ar, as, at, 2, 1, 0, 1065353216, 0, 1065353216)
    NetworkAddPedToSynchronisedScene(
        tARMA.getPlayerPed(),
        g,
        "anim_casino_b@amb@casino@games@shared@player@",
        blackjack_func_213(Local_198f_251),
        2.0,
        -2.0,
        13,
        16,
        2.0,
        0
    )
    NetworkStartSynchronisedScene(g)
    Citizen.InvokeNative(0x79C0E43EB9B944E2, -2124244681)
    Wait(6000)
    Locali98f_55 = NetworkCreateSynchronisedScene(aq.x, aq.y, aq.z, ar, as, at, 2, 1, 1, 1065353216, 0, 1065353216)
    NetworkAddPedToSynchronisedScene(
        tARMA.getPlayerPed(),
        Locali98f_55,
        "anim_casino_b@amb@casino@games@shared@player@",
        "idle_cardgames",
        2.0,
        -2.0,
        13,
        16,
        1148846080,
        0
    )
    NetworkStartSynchronisedScene(Locali98f_55)
    StartAudioScene("DLC_VW_Casino_Table_Games")
    Citizen.InvokeNative(0x79C0E43EB9B944E2, -2124244681)
    i = false
    E = true
end
function betBlackjack(au, Y)
    local av = getChipPropFromAmount(au)
    for O, v in ipairs(av) do
        betChipsForNextHand(100, v, 0, Y, false, (O - 1) / 200)
    end
end
function startSingleDealerDealing(U, ab, ac, ai, ae, Y, tableId)
    N_0x469f2ecdec046337(1)
    StartAudioScene("DLC_VW_Casino_Cards_Focus_Hand")
    ensureCardModelsLoaded()
    local gender = getDealerGenderFromPed(U)
    if DoesEntityExist(U) then
        local nextCard = getCardFromNumber(ac, true)
        local aw = getNewCardFromMachine(nextCard, Y, ab)
        AttachEntityToEntity(aw, U, GetPedBoneIndex(U, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 1, 2, 1)
        if gender == "male" then
            genderAnimString = ""
        end
        if gender == "female" then
            genderAnimString = "female_"
        end
        dealerGiveSelfCard(genderAnimString, U, 3, aw)
        DetachEntity(aw, false, true)
        if blackjack_func_368(F) == tableId then
            y = ae
        end
        local ax = "MINIGAME_BJACK_DEALER_" .. tostring(ae)
        PlayPedAmbientSpeechNative(U, ax, "SPEECH_PARAMS_FORCE_NORMAL_CLEAR")
        vVar8 = vector3(0.0, 0.0, getTableHeading(blackjack_func_368(Y)))
        local tablePosX, tablePosY, tablePosZ = getTableCoords(blackjack_func_368(Y))
        local cardOffsetX, cardOffsetY, cardOffsetZ = blackjack_func_377(ai, 4, 1)
        local ay =
            GetObjectOffsetFromCoords(tablePosX, tablePosY, tablePosZ, vVar8.z, cardOffsetX, cardOffsetY, cardOffsetZ)
        SetEntityCoordsNoOffset(aw, ay.x, ay.y, ay.z, 0, 0, 1)
    end
    ensureCardModelsReleased()
end
function startSingleDealing(Y, U, ab, ac, ai, ae)
    N_0x469f2ecdec046337(1)
    StartAudioScene("DLC_VW_Casino_Cards_Focus_Hand")
    ensureCardModelsLoaded()
    local gender = getDealerGenderFromPed(U)
    if DoesEntityExist(U) then
        local localChairId = getLocalChairIdFromGlobalChairId(Y)
        local nextCard = getCardFromNumber(ac, true)
        local aw = getNewCardFromMachine(nextCard, Y)
        AttachEntityToEntity(aw, U, GetPedBoneIndex(U, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 1, 2, 1)
        if gender == "male" then
            genderAnimString = ""
        end
        if gender == "female" then
            genderAnimString = "female_"
        end
        dealerGiveCards(Y, genderAnimString, U, aw)
        DetachEntity(aw, false, true)
        if Y == F then
            x = ae
        end
        local ax = "MINIGAME_BJACK_DEALER_" .. tostring(ae)
        PlayPedAmbientSpeechNative(U, ax, "SPEECH_PARAMS_FORCE_NORMAL_CLEAR")
        local tablePosX, tablePosY, tablePosZ = getTableCoords(blackjack_func_368(Y))
        local iVar9 = localChairId - 1
        if iVar9 <= 4 then
            cardOffsetX, cardOffsetY, cardOffsetZ = blackjack_func_377(ai, iVar9, 0)
        else
            cardOffsetX, cardOffsetY, cardOffsetZ = 0.5737, 0.2376, 0.948025
        end
        local vVar8 = vector3(0.0, 0.0, getTableHeading(blackjack_func_368(Y)))
        local ay =
            GetObjectOffsetFromCoords(tablePosX, tablePosY, tablePosZ, vVar8.z, cardOffsetX, cardOffsetY, cardOffsetZ)
        SetEntityCoordsNoOffset(aw, ay.x, ay.y, ay.z, 0, 0, 1)
        local cardObjectOffsetRotation = vVar8 + func_376(ai, iVar9, 0, false)
        SetEntityRotation(aw, cardObjectOffsetRotation.x, cardObjectOffsetRotation.y, cardObjectOffsetRotation.z, 2, 1)
    end
    ensureCardModelsReleased()
end
function startDealing(U, ab, ac, Y, ad, ae, az)
    N_0x469f2ecdec046337(1)
    StartAudioScene("DLC_VW_Casino_Cards_Focus_Hand")
    ensureCardModelsLoaded()
    local gender = getDealerGenderFromPed(U)
    if DoesEntityExist(U) then
        nextCard = getCardFromNumber(ac[ad], true)
        local aw = getNewCardFromMachine(nextCard, Y)
        AttachEntityToEntity(aw, U, GetPedBoneIndex(U, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 1, 2, 1)
        if gender == "male" then
            genderAnimString = ""
        end
        if gender == "female" then
            genderAnimString = "female_"
        end
        if Y <= 1000 then
            dealerGiveCards(Y, genderAnimString, U, aw)
        else
            dealerGiveSelfCard(genderAnimString, U, ad, aw)
        end
        DetachEntity(aw, false, true)
        if Y ~= ab or ad ~= 2 then
            local ax = "MINIGAME_BJACK_DEALER_" .. tostring(ae)
            PlayPedAmbientSpeechNative(U, ax, "SPEECH_PARAMS_FORCE_NORMAL_CLEAR")
        end
        cardQueue = ad
        iVar5 = cardQueue
        iVar9 = Y
        if Y <= 1000 then
            vVar8 = vector3(0.0, 0.0, getTableHeading(blackjack_func_368(Y)))
            tablePosX, tablePosY, tablePosZ = getTableCoords(blackjack_func_368(Y))
            cardOffsetX, cardOffsetY, cardOffsetZ = blackjack_func_377(iVar5, getLocalChairIndexFromGlobalChairId(Y), 0)
        else
            vVar8 = vector3(0.0, 0.0, getTableHeading(blackjack_func_368(az)))
            tablePosX, tablePosY, tablePosZ = getTableCoords(blackjack_func_368(az))
            cardOffsetX, cardOffsetY, cardOffsetZ = blackjack_func_377(iVar5, 4, 1)
        end
        local ay =
            GetObjectOffsetFromCoords(tablePosX, tablePosY, tablePosZ, vVar8.z, cardOffsetX, cardOffsetY, cardOffsetZ)
        SetEntityCoordsNoOffset(aw, ay.x, ay.y, ay.z, 0, 0, 1)
        if Y <= 1000 then
            vVar8 = vector3(0.0, 0.0, getTableHeading(blackjack_func_368(Y)))
            cardObjectOffsetRotation = vVar8 + func_376(iVar5, getLocalChairIndexFromGlobalChairId(Y), 0, false)
            SetEntityRotation(
                aw,
                cardObjectOffsetRotation.x,
                cardObjectOffsetRotation.y,
                cardObjectOffsetRotation.z,
                2,
                1
            )
        else
            cardObjectOffsetRotation = blackjack_func_398(blackjack_func_368(az))
        end
        if F == Y and sittingAtBlackjackTable then
            l = setupBlackjackMidBetScaleform("instructional_buttons")
        end
        return aw
    else
    end
    ensureCardModelsReleased()
end
function startStandOrHit(ab, U, Y, aA)
    chairAnimId = getLocalChairIdFromGlobalChairId(Y)
    gender = getDealerGenderFromPed(U)
    if gender == "male" then
        genderAnimString = ""
    end
    if gender == "female" then
        genderAnimString = "female_"
    end
    RequestAnimDict("anim_casino_b@amb@casino@games@blackjack@dealer")
    while not HasAnimDictLoaded("anim_casino_b@amb@casino@games@blackjack@dealer") do
        Wait(0)
    end
    TaskPlayAnim(
        U,
        "anim_casino_b@amb@casino@games@blackjack@dealer",
        genderAnimString .. "dealer_focus_player_0" .. chairAnimId .. "_idle_intro",
        3.0,
        1.0,
        -1,
        2,
        0,
        0,
        0,
        0
    )
    PlayFacialAnim(
        U,
        genderAnimString .. "dealer_focus_player_0" .. chairAnimId .. "_idle_facial",
        "anim_casino_b@amb@casino@games@blackjack@dealer"
    )
    Wait(0)
    while IsEntityPlayingAnim(
        U,
        "anim_casino_b@amb@casino@games@blackjack@dealer",
        genderAnimString .. "dealer_focus_player_0" .. chairAnimId .. "_idle_intro"
    ) do
        Wait(0)
    end
    TaskPlayAnim(
        U,
        "anim_casino_b@amb@casino@games@blackjack@dealer",
        genderAnimString .. "dealer_focus_player_0" .. chairAnimId .. "_idle",
        3.0,
        1.0,
        -1,
        2,
        0,
        0,
        0,
        0
    )
    RemoveAnimDict("anim_casino_b@amb@casino@games@blackjack@dealer")
    if aA then
        waitingForPlayerToHitOrStand = true
    end
end
function flipDealerCard(U, ae, tableId, ab)
    cardObj = C[ab]
    local aB, aC, aD = GetEntityCoords(cardObj)
    local gender = getDealerGenderFromPed(U)
    if gender == "male" then
        genderAnimString = ""
    end
    if gender == "female" then
        genderAnimString = "female_"
    end
    TaskPlayAnim(
        U,
        "anim_casino_b@amb@casino@games@blackjack@dealer",
        genderAnimString .. "check_and_turn_card",
        3.0,
        1.0,
        -1,
        2,
        0,
        0,
        0,
        0
    )
    while not HasAnimEventFired(U, -1345695206) do
        Wait(0)
    end
    AttachEntityToEntity(cardObj, U, GetPedBoneIndex(U, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 1, 2, 1)
    while not HasAnimEventFired(U, 585557868) do
        Wait(0)
    end
    DetachEntity(cardObj, false, true)
    if blackjack_func_368(F) == tableId then
        y = ae
    end
    local ax = "MINIGAME_BJACK_DEALER_" .. tostring(ae)
    PlayPedAmbientSpeechNative(U, ax, "SPEECH_PARAMS_FORCE_NORMAL_CLEAR")
    SetEntityCoordsNoOffset(cardObj, aB, aC, aD)
end
function checkCard(U, cardObj)
    local aB, aC, aD = GetEntityCoords(cardObj)
    AttachEntityToEntity(cardObj, U, GetPedBoneIndex(U, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 1, 2, 1)
    local gender = getDealerGenderFromPed(U)
    if gender == "male" then
        genderAnimString = ""
    end
    if gender == "female" then
        genderAnimString = "female_"
    end
    TaskPlayAnim(
        U,
        "anim_casino_b@amb@casino@games@blackjack@dealer",
        genderAnimString .. "check_card",
        3.0,
        1.0,
        -1,
        2,
        0,
        0,
        0,
        0
    )
    PlayFacialAnim(U, genderAnimString .. "check_card_facial", "anim_casino_b@amb@casino@games@blackjack@dealer")
    while not HasAnimEventFired(U, 585557868) do
        Wait(0)
    end
    Wait(100)
    DetachEntity(cardObj, false, true)
    SetEntityCoordsNoOffset(cardObj, aB, aC, aD)
end
RegisterNetEvent(
    "Blackjack:endStandOrHitPhase",
    function(Y, tableId)
        if isNearbyBlackjackTableId(tableId) then
            local U = getDealerFromTableId(tableId)
            waitingForPlayerToHitOrStand = false
            chairAnimId = getLocalChairIdFromGlobalChairId(Y)
            gender = getDealerGenderFromPed(U)
            if gender == "male" then
                genderAnimString = ""
            end
            if gender == "female" then
                genderAnimString = "female_"
            end
            TaskPlayAnim(
                U,
                "anim_casino_b@amb@casino@games@blackjack@dealer",
                genderAnimString .. "dealer_focus_player_0" .. chairAnimId .. "_idle_outro",
                3.0,
                1.0,
                -1,
                2,
                0,
                0,
                0,
                0
            )
            PlayFacialAnim(
                U,
                genderAnimString .. "dealer_focus_player_0" .. chairAnimId .. "_idle_outro_facial",
                "anim_casino_b@amb@casino@games@blackjack@dealer"
            )
        end
    end
)
RegisterNetEvent(
    "Blackjack:bustBlackjack",
    function(ah, tableId)
        if isNearbyBlackjackTableId(tableId) then
            local U = getDealerFromTableId(tableId)
            PlayPedAmbientSpeechNative(U, "MINIGAME_BJACK_DEALER_PLAYER_BUST", "SPEECH_PARAMS_FORCE_NORMAL_CLEAR")
            TaskPlayAnim(
                U,
                "anim_casino_b@amb@casino@games@blackjack@dealer",
                "reaction_bad",
                3.0,
                1.0,
                -1,
                2,
                0,
                0,
                0,
                0
            )
            if ah == F and sittingAtBlackjackTable then
                angryIBust()
                w = false
                x = 0
                y = 0
                SendNUIMessage({transactionType = "playCasinoLose"})
            end
        end
    end
)
RegisterNetEvent(
    "Blackjack:flipDealerCard",
    function(ae, tableId, ab)
        if isNearbyBlackjackTableId(tableId) then
            local U = getDealerFromTableId(tableId)
            flipDealerCard(U, ae, tableId, ab)
        end
    end
)
RegisterNetEvent(
    "Blackjack:dealerBusts",
    function(tableId)
        if isNearbyBlackjackTableId(tableId) then
            local U = getDealerFromTableId(tableId)
            PlayPedAmbientSpeechNative(U, "MINIGAME_DEALER_BUSTS", "SPEECH_PARAMS_FORCE_NORMAL_CLEAR")
        end
    end
)
RegisterNetEvent(
    "Blackjack:blackjackLose",
    function(tableId)
        D = false
        local U = getDealerFromTableId(tableId)
        PlayPedAmbientSpeechNative(U, "MINIGAME_DEALER_WINS", "SPEECH_PARAMS_FORCE_NORMAL_CLEAR")
        TaskPlayAnim(U, "anim_casino_b@amb@casino@games@blackjack@dealer", "reaction_bad", 3.0, 1.0, -1, 2, 0, 0, 0, 0)
        angryILost()
        A = true
        drawNativeNotification("~r~You lose!")
        w = false
        x = 0
        y = 0
        SendNUIMessage({transactionType = "playCasinoLose"})
    end
)
RegisterNetEvent(
    "Blackjack:blackjackPush",
    function(tableId)
        D = false
        local U = getDealerFromTableId(tableId)
        TaskPlayAnim(
            U,
            "anim_casino_b@amb@casino@games@blackjack@dealer",
            "reaction_impartial",
            3.0,
            1.0,
            -1,
            2,
            0,
            0,
            0,
            0
        )
        annoyedIPushed()
        A = true
        drawNativeNotification("~b~You pushed!")
        w = false
        x = 0
        y = 0
        SendNUIMessage({transactionType = "playCasinoWin"})
    end
)
RegisterNetEvent(
    "Blackjack:blackjackWin",
    function(tableId)
        D = false
        local U = getDealerFromTableId(tableId)
        TaskPlayAnim(U, "anim_casino_b@amb@casino@games@blackjack@dealer", "reaction_good", 3.0, 1.0, -1, 2, 0, 0, 0, 0)
        happyIWon()
        A = true
        drawNativeNotification("~g~You win!")
        w = false
        x = 0
        y = 0
        SendNUIMessage({transactionType = "playCasinoWin"})
    end
)
RegisterNetEvent("Blackjack:chipsCleanup",function(Y, tableId)
        if isNearbyBlackjackTableId(tableId) then
            if string.sub(Y, -5) ~= "chips" then
                local U = getDealerFromTableId(tableId)
                local gender = getDealerGenderFromPed(U)
                if gender == "male" then
                    genderAnimString = ""
                end
                if gender == "female" then
                    genderAnimString = "female_"
                end
                localChairId = getLocalChairIdFromGlobalChairId(Y)
                if Y > 99 then
                    TaskPlayAnim(
                        U,
                        "anim_casino_b@amb@casino@games@blackjack@dealer",
                        genderAnimString .. "retrieve_own_cards_and_remove",
                        3.0,
                        1.0,
                        -1,
                        2,
                        0,
                        0,
                        0,
                        0
                    )
                    PlayFacialAnim(
                        U,
                        genderAnimString .. "retrieve_own_cards_and_remove_facial",
                        "anim_casino_b@amb@casino@games@blackjack@dealer"
                    )
                else
                    TaskPlayAnim(
                        U,
                        "anim_casino_b@amb@casino@games@blackjack@dealer",
                        genderAnimString .. "retrieve_cards_player_0" .. tostring(localChairId),
                        3.0,
                        1.0,
                        -1,
                        2,
                        0,
                        0,
                        0,
                        0
                    )
                    PlayFacialAnim(
                        U,
                        genderAnimString .. "retrieve_cards_player_0" .. tostring(localChairId) .. "_facial",
                        "anim_casino_b@amb@casino@games@blackjack@dealer"
                    )
                end
                while not HasAnimEventFired(U, -1345695206) do
                    Wait(0)
                end
                for al, v in pairs(cardObjects) do
                    if al == Y then
                        for aE, aF in pairs(v) do
                            AttachEntityToEntity(
                                aF,
                                U,
                                GetPedBoneIndex(U, 28422),
                                0.0,
                                0.0,
                                0.0,
                                0.0,
                                0.0,
                                0.0,
                                0,
                                0,
                                0,
                                1,
                                2,
                                1
                            )
                        end
                    end
                end
                while not HasAnimEventFired(U, 585557868) do
                    Wait(0)
                end
                for al, v in pairs(cardObjects) do
                    if al == Y then
                        for aE, aF in pairs(v) do
                            DeleteEntity(aF)
                        end
                    end
                end
            else
                for al, v in pairs(cardObjects) do
                    if al == Y then
                        for aE, aF in pairs(v) do
                            DeleteEntity(aF)
                        end
                    end
                end
            end
        else
            for al, v in pairs(cardObjects) do
                if al == Y then
                    for aE, aF in pairs(v) do
                        DeleteEntity(aF)
                    end
                end
            end
        end
    end
)
RegisterNetEvent("Blackjack:chipsCleanupNoAnim",function(aG)
    for al,v in pairs(cardObjects) do
        if al == aG then
            for aE, aF in pairs(v) do
                DeleteEntity(aF)
            end
        end
    end
end)
function betChipsForNextHand(aH, av, aI, ah, aJ, aK)
    local aL = tARMA.loadModel(av)
    local vVar8 = vector3(0.0, 0.0, getTableHeading(blackjack_func_368(ah)))
    local tablePosX, tablePosY, tablePosZ = getTableCoords(blackjack_func_368(ah))
    local aM = blackjack_func_374(aH, aI, getLocalChairIndexFromGlobalChairId(ah), aJ)
    local aN = GetObjectOffsetFromCoords(tablePosX, tablePosY, tablePosZ, vVar8.z, aM.x, aM.y, aM.z)
    local aO = CreateObjectNoOffset(aL, aN.x, aN.y, aN.z, false, false, 1)
    SetModelAsNoLongerNeeded(aL)
    if cardObjects[tostring(ah) .. "chips"] ~= nil then
        table.insert(cardObjects[tostring(ah) .. "chips"], aO)
    else
        cardObjects[tostring(ah) .. "chips"] = {}
        table.insert(cardObjects[tostring(ah) .. "chips"], aO)
    end
    local aP = blackjack_func_373(aH, 0, getLocalChairIndexFromGlobalChairId(ah), aJ)
    SetEntityCoordsNoOffset(aO, aN.x, aN.y, aN.z + aK, 0, 0, 1)
    SetEntityRotation(aO, vVar8 + aP, 2, 1)
end
function getDealerGenderFromPed(U)
    local maleCasinoDealer = GetHashKey("S_M_Y_Casino_01")
    local aQ = GetHashKey("S_F_Y_Casino_01")
    if GetEntityModel(U) == maleCasinoDealer then
        return "male"
    end
    return "female"
end
function getNewCardFromMachine(nextCard, Y, ab)
    local aR = tARMA.loadModel(nextCard)
    local aS = blackjack_func_399(blackjack_func_368(Y))
    local aw = CreateObjectNoOffset(aR, aS.x, aS.y, aS.z, false, false, 1)
    if cardObjects[Y] ~= nil then
        if ab then
            if cardObjects[ab] == nil then
                cardObjects[ab] = {}
            end
            table.insert(cardObjects[ab], aw)
        else
            table.insert(cardObjects[Y], aw)
        end
    else
        cardObjects[Y] = {}
        if ab then
            if cardObjects[ab] == nil then
                cardObjects[ab] = {}
            end
            table.insert(cardObjects[ab], aw)
        else
            table.insert(cardObjects[Y], aw)
        end
    end
    SetEntityVisible(aw, false)
    SetModelAsNoLongerNeeded(aR)
    local cardObjectOffsetRotation = blackjack_func_398(blackjack_func_368(Y))
    SetEntityCoordsNoOffset(aw, aS.x, aS.y, aS.z, 0, 0, 1)
    SetEntityRotation(aw, cardObjectOffsetRotation.x, cardObjectOffsetRotation.y, cardObjectOffsetRotation.z, 2, 1)
    return aw
end
function dealerGiveCards(Y, gender, U, cardObj)
    local aT = tostring(getLocalChairIdFromGlobalChairId(Y))
    TaskPlayAnim(
        U,
        "anim_casino_b@amb@casino@games@blackjack@dealer",
        gender .. "deal_card_player_0" .. aT,
        3.0,
        1.0,
        -1,
        2,
        0,
        0,
        0,
        0
    )
    PlayFacialAnim(U, "deal_card_player_0" .. aT .. "_facial")
    Wait(300)
    SetEntityVisible(cardObj, true)
    while not HasAnimEventFired(U, 585557868) do
        Wait(0)
    end
end
function dealerGiveSelfCard(gender, U, ad, cardObj)
    if ad == 1 then
        cardAnim = "deal_card_self_second_card"
    elseif ad == 2 then
        cardAnim = "deal_card_self"
    else
        cardAnim = "deal_card_self_card_10"
    end
    TaskPlayAnim(U, "anim_casino_b@amb@casino@games@blackjack@dealer", gender .. cardAnim, 3.0, 1.0, -1, 2, 0, 0, 0, 0)
    PlayFacialAnim(U, gender .. cardAnim .. "_facial", "anim_casino_b@amb@casino@games@blackjack@dealer")
    Wait(300)
    SetEntityVisible(cardObj, true)
    while not HasAnimEventFired(U, 585557868) do
        Wait(0)
    end
    Wait(100)
end
local aU = {
    "vw_prop_chip_10dollar_x1",
    "vw_prop_chip_50dollar_x1",
    "vw_prop_chip_100dollar_x1",
    "vw_prop_chip_50dollar_st",
    "vw_prop_chip_100dollar_st",
    "vw_prop_chip_500dollar_x1",
    "vw_prop_chip_1kdollar_x1",
    "vw_prop_chip_500dollar_st",
    "vw_prop_chip_5kdollar_x1",
    "vw_prop_chip_1kdollar_st",
    "vw_prop_chip_10kdollar_x1",
    "vw_prop_chip_5kdollar_st",
    "vw_prop_chip_10kdollar_st",
    "vw_prop_plaq_5kdollar_x1",
    "vw_prop_plaq_5kdollar_st",
    "vw_prop_plaq_10kdollar_x1",
    "vw_prop_plaq_10kdollar_st",
    "vw_prop_vw_chips_pile_01a",
    "vw_prop_vw_chips_pile_02a",
    "vw_prop_vw_chips_pile_03a",
    "vw_prop_vw_coin_01a"
}
function declineCard()
    E = false
    local aV = blackjack_func_348(F)
    local aW = blackjack_func_215(F)
    local aX = NetworkCreateSynchronisedScene(aV.x, aV.y, aV.z, aW.x, aW.y, aW.z, 2, 1, 0, 1065353216, 0, 1065353216)
    NetworkAddPedToSynchronisedScene(
        tARMA.getPlayerPed(),
        aX,
        "anim_casino_b@amb@casino@games@blackjack@player",
        "decline_card_001",
        4.0,
        -2.0,
        13,
        16,
        1148846080,
        0
    )
    NetworkStartSynchronisedScene(aX)
    SetTimeout(
        3000,
        function()
            E = true
        end
    )
end
function requestCard()
    E = false
    local aV = blackjack_func_348(F)
    local aW = blackjack_func_215(F)
    local aX = NetworkCreateSynchronisedScene(aV.x, aV.y, aV.z, aW.x, aW.y, aW.z, 2, 1, 0, 1065353216, 0, 1065353216)
    NetworkAddPedToSynchronisedScene(tARMA.getPlayerPed(),aX,"anim_casino_b@amb@casino@games@blackjack@player","request_card",4.0,-2.0,13,16,1148846080,0)
    NetworkStartSynchronisedScene(aX)
    SetTimeout(3000,function()
        E = true
    end)
end
function putBetOnTable()
    E = false
    local aV = blackjack_func_348(F)
    local aW = blackjack_func_215(F)
    local aX = NetworkCreateSynchronisedScene(aV.x, aV.y, aV.z, aW.x, aW.y, aW.z, 2, 1, 0, 1065353216, 0, 1065353216)
    NetworkAddPedToSynchronisedScene(tARMA.getPlayerPed(),aX,"anim_casino_b@amb@casino@games@blackjack@player",getAnimNameFromBet(100),4.0,-2.0,13,16,1148846080,0)
    NetworkStartSynchronisedScene(aX)
    SetTimeout(3000,function()
        E = true
    end)
end
function angryIBust()
    E = false
    local aV = blackjack_func_348(F)
    local aW = blackjack_func_215(F)
    local aX = NetworkCreateSynchronisedScene(aV.x, aV.y, aV.z, aW.x, aW.y, aW.z, 2, 1, 0, 1065353216, 0, 1065353216)
    NetworkAddPedToSynchronisedScene(tARMA.getPlayerPed(),aX,"anim_casino_b@amb@casino@games@shared@player@","reaction_terrible_var_01",4.0,-2.0,13,16,1148846080,0)
    NetworkStartSynchronisedScene(aX)
    SetTimeout(5000,function()
        E = true
    end)
end
function angryILost()
    E = false
    local aV = blackjack_func_348(F)
    local aW = blackjack_func_215(F)
    local aX = NetworkCreateSynchronisedScene(aV.x, aV.y, aV.z, aW.x, aW.y, aW.z, 2, 1, 0, 1065353216, 0, 1065353216)
    NetworkAddPedToSynchronisedScene(tARMA.getPlayerPed(),aX,"anim_casino_b@amb@casino@games@shared@player@","reaction_bad_var_01",4.0,-2.0,13,16,1148846080,0)
    NetworkStartSynchronisedScene(aX)
    SetTimeout(5000,function()
        E = true
    end)
end
function annoyedIPushed()
    E = false
    local aV = blackjack_func_348(F)
    local aW = blackjack_func_215(F)
    local aX = NetworkCreateSynchronisedScene(aV.x, aV.y, aV.z, aW.x, aW.y, aW.z, 2, 1, 0, 1065353216, 0, 1065353216)
    NetworkAddPedToSynchronisedScene(tARMA.getPlayerPed(),aX,"anim_casino_b@amb@casino@games@shared@player@","reaction_impartial_var_01",4.0,-2.0,13,16,1148846080,0)
    NetworkStartSynchronisedScene(aX)
    SetTimeout(5000,function()
        E = true
    end)
end
function happyIWon()
    E = false
    local aV = blackjack_func_348(F)
    local aW = blackjack_func_215(F)
    local aX = NetworkCreateSynchronisedScene(aV.x, aV.y, aV.z, aW.x, aW.y, aW.z, 2, 1, 0, 1065353216, 0, 1065353216)
    NetworkAddPedToSynchronisedScene(tARMA.getPlayerPed(),aX,"anim_casino_b@amb@casino@games@shared@player@","reaction_good_var_01",4.0,-2.0,13,16,1148846080,0)
    NetworkStartSynchronisedScene(aX)
    SetTimeout(5000,function()
        E = true
    end)
end
function blackjack_func_398(aY)
    local vVar0 = vector3(0.0, 164.52, 11.5)
    return vector3(getTableHeading(aY), 0.0, 0.0) + vVar0
end
function blackjack_func_399(aY)
    local vVar0 = vector3(0.526, 0.571, 0.963)
    local aZ, a_, b0 = getTableCoords(aY)
    return GetObjectOffsetFromCoords(aZ, a_, b0, getTableHeading(aY), vVar0.x, vVar0.y, vVar0.z)
end
function ensureCardModelsLoaded()
    local b1 = 0
    while b1 < 52 do
        local b2 = 1
        local b3 = getCardFromNumber(b1, b2)
        tARMA.loadModel(b3)
        b1 = b1 + 1
    end
end
function ensureCardModelsReleased()
    local b1 = 0
    while b1 < 52 do
        local b2 = 1
        local b3 = getCardFromNumber(b1, b2)
        SetModelAsNoLongerNeeded(b3)
        b1 = b1 + 1
    end
end
function blackjack_func_204(aY, b4, b5)
    if b5 then
        return vector3(getTableHeading(b4), 0.0, 0.0) + vector3(0, 0.061, -59.1316)
    else
        vVar0 = blackjack_func_215(aY)
        return vector3(vVar0.z, 0.0, 0.0) + vector3(-87.48, 0, -60.84)
    end
    return 0.0, 0.0, 0.0
end
function blackjack_func_205(aY, b4, b5)
    if b5 then
        return GetObjectOffsetFromCoords(getTableCoords(b4), getTableHeading(b4), -0.0094, -0.0611, 1.5098)
    else
        vVar0 = blackjack_func_215(aY)
        return GetObjectOffsetFromCoords(blackjack_func_348(aY), vVar0.z, 0.245, 0.0, 1.415)
    end
    return 0.0, 0.0, 0.0
end
function blackjack_func_216(aY, b4)
    local aq = blackjack_func_348(aY)
    local ar, as, at = blackjack_func_215(aY)
    vVar0 = GetAnimInitialOffsetRotation("anim_casino_b@amb@casino@games@shared@player@",blackjack_func_213(b4),aq.x,aq.y,aq.z,ar,as,at,0.01,2)
    return vVar0.z
end
function blackjack_func_217(aY, b6, b5)
    local vVar0 = {}
    if not IsEntityDead(aY) then
        vVar0 = GetEntityCoords(aY, 1)
    else
        vVar0 = GetEntityCoords(aY, 0)
    end
    return #(vVar0 - b6)
end
function blackjack_func_218(aY, b4)
    local aq = blackjack_func_348(aY)
    local ar, as, at = blackjack_func_215(aY)
    vVar0 =
        GetAnimInitialOffsetPosition(
        "anim_casino_b@amb@casino@games@shared@player@",
        blackjack_func_213(b4),
        aq.x,
        aq.y,
        aq.z,
        ar,
        as,
        at,
        0.01,
        2
    )
    return vVar0
end
function blackjack_func_213(b7)
    if b7 == 0 then
        return "sit_enter_left"
    elseif b7 == 1 then
        return "sit_enter_left_side"
    elseif b7 == 2 then
        return "sit_enter_right_side"
    end
    return "sit_enter_left"
end
function getInverseChairId(Y)
    if Y == 0 then
        return 3
    end
    if Y == 1 then
        return 2
    end
    if Y == 2 then
        return 1
    end
    if Y == 3 then
        return 0
    end
end
function blackjack_func_348(aY)
    local tableId = blackjack_func_368(aY)
    local b8 = G.blackjackTables[tableId].objectId
    if DoesEntityExist(b8) then
        local localChairId = getLocalChairIndexFromGlobalChairId(aY)
        localChairId = getInverseChairId(localChairId) + 1
        local b9 = getBlackjackTableBoneIndex(localChairId)
        return GetEntityBonePosition_2(b8, b9)
    else
        return vector3(0.0, 0.0, 0.0)
    end
end
function getBlackjackTableBoneIndex(Y)
    if Y == 1 then
        return 1
    end
    if Y == 2 then
        return 3
    end
    if Y == 3 then
        return 5
    end
    if Y == 4 then
        return 7
    end
end
function blackjack_func_215(aY)
    local tableId = blackjack_func_368(aY)
    local b8 = G.blackjackTables[tableId].objectId
    if DoesEntityExist(b8) then
        local localChairId = getLocalChairIndexFromGlobalChairId(aY)
        localChairId = getInverseChairId(localChairId) + 1
        return GetEntityBoneRotation(b8, getBlackjackTableBoneIndex(localChairId))
    else
        return vector3(0.0, 0.0, 0.0)
    end
end
function blackjack_func_368(Y)
    local tableId = -1
    for O = 0, Y, 4 do
        tableId = tableId + 1
    end
    return tableId
end
function getLocalChairIdFromGlobalChairId(ba)
    if ba ~= -1 then
        return ba % 4 + 1
    else
        return 100
    end
end
function getLocalChairIndexFromGlobalChairId(ba)
    if ba ~= -1 then
        return ba % 4
    else
        return 100
    end
end
function getTableHeading(bb)
    if G.blackjackTables[bb] ~= nil then
        return G.blackjackTables[bb].tableHeading
    else
        return 0.0
    end
end
function getTableCoords(bb)
    if G.blackjackTables[bb] ~= nil then
        return G.blackjackTables[bb].tablePos.x, G.blackjackTables[bb].tablePos.y, G.blackjackTables[bb].tablePos.z
    else
        return 0.0, 0.0, 0.0
    end
end
function getCardFromNumber(aY, bc)
    if bc then
        if aY == 1 then
            return "vw_prop_vw_club_char_a_a"
        elseif aY == 2 then
            return "vw_prop_vw_club_char_02a"
        elseif aY == 3 then
            return "vw_prop_vw_club_char_03a"
        elseif aY == 4 then
            return "vw_prop_vw_club_char_04a"
        elseif aY == 5 then
            return "vw_prop_vw_club_char_05a"
        elseif aY == 6 then
            return "vw_prop_vw_club_char_06a"
        elseif aY == 7 then
            return "vw_prop_vw_club_char_07a"
        elseif aY == 8 then
            return "vw_prop_vw_club_char_08a"
        elseif aY == 9 then
            return "vw_prop_vw_club_char_09a"
        elseif aY == 10 then
            return "vw_prop_vw_club_char_10a"
        elseif aY == 11 then
            return "vw_prop_vw_club_char_j_a"
        elseif aY == 12 then
            return "vw_prop_vw_club_char_q_a"
        elseif aY == 13 then
            return "vw_prop_vw_club_char_k_a"
        elseif aY == 14 then
            return "vw_prop_vw_dia_char_a_a"
        elseif aY == 15 then
            return "vw_prop_vw_dia_char_02a"
        elseif aY == 16 then
            return "vw_prop_vw_dia_char_03a"
        elseif aY == 17 then
            return "vw_prop_vw_dia_char_04a"
        elseif aY == 18 then
            return "vw_prop_vw_dia_char_05a"
        elseif aY == 19 then
            return "vw_prop_vw_dia_char_06a"
        elseif aY == 20 then
            return "vw_prop_vw_dia_char_07a"
        elseif aY == 21 then
            return "vw_prop_vw_dia_char_08a"
        elseif aY == 22 then
            return "vw_prop_vw_dia_char_09a"
        elseif aY == 23 then
            return "vw_prop_vw_dia_char_10a"
        elseif aY == 24 then
            return "vw_prop_vw_dia_char_j_a"
        elseif aY == 25 then
            return "vw_prop_vw_dia_char_q_a"
        elseif aY == 26 then
            return "vw_prop_vw_dia_char_k_a"
        elseif aY == 27 then
            return "vw_prop_vw_hrt_char_a_a"
        elseif aY == 28 then
            return "vw_prop_vw_hrt_char_02a"
        elseif aY == 29 then
            return "vw_prop_vw_hrt_char_03a"
        elseif aY == 30 then
            return "vw_prop_vw_hrt_char_04a"
        elseif aY == 31 then
            return "vw_prop_vw_hrt_char_05a"
        elseif aY == 32 then
            return "vw_prop_vw_hrt_char_06a"
        elseif aY == 33 then
            return "vw_prop_vw_hrt_char_07a"
        elseif aY == 34 then
            return "vw_prop_vw_hrt_char_08a"
        elseif aY == 35 then
            return "vw_prop_vw_hrt_char_09a"
        elseif aY == 36 then
            return "vw_prop_vw_hrt_char_10a"
        elseif aY == 37 then
            return "vw_prop_vw_hrt_char_j_a"
        elseif aY == 38 then
            return "vw_prop_vw_hrt_char_q_a"
        elseif aY == 39 then
            return "vw_prop_vw_hrt_char_k_a"
        elseif aY == 40 then
            return "vw_prop_vw_spd_char_a_a"
        elseif aY == 41 then
            return "vw_prop_vw_spd_char_02a"
        elseif aY == 42 then
            return "vw_prop_vw_spd_char_03a"
        elseif aY == 43 then
            return "vw_prop_vw_spd_char_04a"
        elseif aY == 44 then
            return "vw_prop_vw_spd_char_05a"
        elseif aY == 45 then
            return "vw_prop_vw_spd_char_06a"
        elseif aY == 46 then
            return "vw_prop_vw_spd_char_07a"
        elseif aY == 47 then
            return "vw_prop_vw_spd_char_08a"
        elseif aY == 48 then
            return "vw_prop_vw_spd_char_09a"
        elseif aY == 49 then
            return "vw_prop_vw_spd_char_10a"
        elseif aY == 50 then
            return "vw_prop_vw_spd_char_j_a"
        elseif aY == 51 then
            return "vw_prop_vw_spd_char_q_a"
        elseif aY == 52 then
            return "vw_prop_vw_spd_char_k_a"
        end
    else
        if aY == 1 then
            return "vw_prop_cas_card_club_ace"
        elseif aY == 2 then
            return "vw_prop_cas_card_club_02"
        elseif aY == 3 then
            return "vw_prop_cas_card_club_03"
        elseif aY == 4 then
            return "vw_prop_cas_card_club_04"
        elseif aY == 5 then
            return "vw_prop_cas_card_club_05"
        elseif aY == 6 then
            return "vw_prop_cas_card_club_06"
        elseif aY == 7 then
            return "vw_prop_cas_card_club_07"
        elseif aY == 8 then
            return "vw_prop_cas_card_club_08"
        elseif aY == 9 then
            return "vw_prop_cas_card_club_09"
        elseif aY == 10 then
            return "vw_prop_cas_card_club_10"
        elseif aY == 11 then
            return "vw_prop_cas_card_club_jack"
        elseif aY == 12 then
            return "vw_prop_cas_card_club_queen"
        elseif aY == 13 then
            return "vw_prop_cas_card_club_king"
        elseif aY == 14 then
            return "vw_prop_cas_card_dia_ace"
        elseif aY == 15 then
            return "vw_prop_cas_card_dia_02"
        elseif aY == 16 then
            return "vw_prop_cas_card_dia_03"
        elseif aY == 17 then
            return "vw_prop_cas_card_dia_04"
        elseif aY == 18 then
            return "vw_prop_cas_card_dia_05"
        elseif aY == 19 then
            return "vw_prop_cas_card_dia_06"
        elseif aY == 20 then
            return "vw_prop_cas_card_dia_07"
        elseif aY == 21 then
            return "vw_prop_cas_card_dia_08"
        elseif aY == 22 then
            return "vw_prop_cas_card_dia_09"
        elseif aY == 23 then
            return "vw_prop_cas_card_dia_10"
        elseif aY == 24 then
            return "vw_prop_cas_card_dia_jack"
        elseif aY == 25 then
            return "vw_prop_cas_card_dia_queen"
        elseif aY == 26 then
            return "vw_prop_cas_card_dia_king"
        elseif aY == 27 then
            return "vw_prop_cas_card_hrt_ace"
        elseif aY == 28 then
            return "vw_prop_cas_card_hrt_02"
        elseif aY == 29 then
            return "vw_prop_cas_card_hrt_03"
        elseif aY == 30 then
            return "vw_prop_cas_card_hrt_04"
        elseif aY == 31 then
            return "vw_prop_cas_card_hrt_05"
        elseif aY == 32 then
            return "vw_prop_cas_card_hrt_06"
        elseif aY == 33 then
            return "vw_prop_cas_card_hrt_07"
        elseif aY == 34 then
            return "vw_prop_cas_card_hrt_08"
        elseif aY == 35 then
            return "vw_prop_cas_card_hrt_09"
        elseif aY == 36 then
            return "vw_prop_cas_card_hrt_10"
        elseif aY == 37 then
            return "vw_prop_cas_card_hrt_jack"
        elseif aY == 38 then
            return "vw_prop_cas_card_hrt_queen"
        elseif aY == 39 then
            return "vw_prop_cas_card_hrt_king"
        elseif aY == 40 then
            return "vw_prop_cas_card_spd_ace"
        elseif aY == 41 then
            return "vw_prop_cas_card_spd_02"
        elseif aY == 42 then
            return "vw_prop_cas_card_spd_03"
        elseif aY == 43 then
            return "vw_prop_cas_card_spd_04"
        elseif aY == 44 then
            return "vw_prop_cas_card_spd_05"
        elseif aY == 45 then
            return "vw_prop_cas_card_spd_06"
        elseif aY == 46 then
            return "vw_prop_cas_card_spd_07"
        elseif aY == 47 then
            return "vw_prop_cas_card_spd_08"
        elseif aY == 48 then
            return "vw_prop_cas_card_spd_09"
        elseif aY == 49 then
            return "vw_prop_cas_card_spd_10"
        elseif aY == 50 then
            return "vw_prop_cas_card_spd_jack"
        elseif aY == 51 then
            return "vw_prop_cas_card_spd_queen"
        elseif aY == 52 then
            return "vw_prop_cas_card_spd_king"
        end
    end
    if bc then
        return "vw_prop_vw_jo_char_01a"
    end
    return "vw_prop_casino_cards_single"
end
function getAnimNameFromBet(a9)
    return "place_bet_small"
end
function blackjack_func_377(aY, b4, b5)
    if b5 == 0 then
        if b4 == 0 then
            if aY == 0 then
                return 0.5737, 0.2376, 0.948025
            elseif aY == 1 then
                return 0.562975, 0.2523, 0.94875
            elseif aY == 2 then
                return 0.553875, 0.266325, 0.94955
            elseif aY == 3 then
                return 0.5459, 0.282075, 0.9501
            elseif aY == 4 then
                return 0.536125, 0.29645, 0.95085
            elseif aY == 5 then
                return 0.524975, 0.30975, 0.9516
            elseif aY == 6 then
                return 0.515775, 0.325325, 0.95235
            end
        elseif b4 == 1 then
            if aY == 0 then
                return 0.2325, -0.1082, 0.94805
            elseif aY == 1 then
                return 0.23645, -0.0918, 0.949
            elseif aY == 2 then
                return 0.2401, -0.074475, 0.950225
            elseif aY == 3 then
                return 0.244625, -0.057675, 0.951125
            elseif aY == 4 then
                return 0.249675, -0.041475, 0.95205
            elseif aY == 5 then
                return 0.257575, -0.0256, 0.9532
            elseif aY == 6 then
                return 0.2601, -0.008175, 0.954375
            end
        elseif b4 == 2 then
            if aY == 0 then
                return -0.2359, -0.1091, 0.9483
            elseif aY == 1 then
                return -0.221025, -0.100675, 0.949
            elseif aY == 2 then
                return -0.20625, -0.092875, 0.949725
            elseif aY == 3 then
                return -0.193225, -0.07985, 0.950325
            elseif aY == 4 then
                return -0.1776, -0.072, 0.951025
            elseif aY == 5 then
                return -0.165, -0.060025, 0.951825
            elseif aY == 6 then
                return -0.14895, -0.05155, 0.95255
            end
        elseif b4 == 3 then
            if aY == 0 then
                return -0.5765, 0.2229, 0.9482
            elseif aY == 1 then
                return -0.558925, 0.2197, 0.949175
            elseif aY == 2 then
                return -0.5425, 0.213025, 0.9499
            elseif aY == 3 then
                return -0.525925, 0.21105, 0.95095
            elseif aY == 4 then
                return -0.509475, 0.20535, 0.9519
            elseif aY == 5 then
                return -0.491775, 0.204075, 0.952825
            elseif aY == 6 then
                return -0.4752, 0.197525, 0.9543
            end
        end
    else
        if b4 == 0 then
            if aY == 0 then
                return 0.6083, 0.3523, 0.94795
            elseif aY == 1 then
                return 0.598475, 0.366475, 0.948925
            elseif aY == 2 then
                return 0.589525, 0.3807, 0.94975
            elseif aY == 3 then
                return 0.58045, 0.39435, 0.950375
            elseif aY == 4 then
                return 0.571975, 0.4092, 0.951075
            elseif aY == 5 then
                return 0.5614, 0.4237, 0.951775
            elseif aY == 6 then
                return 0.554325, 0.4402, 0.952525
            end
        elseif b4 == 1 then
            if aY == 0 then
                return 0.3431, -0.0527, 0.94855
            elseif aY == 1 then
                return 0.348575, -0.0348, 0.949425
            elseif aY == 2 then
                return 0.35465, -0.018825, 0.9502
            elseif aY == 3 then
                return 0.3581, -0.001625, 0.95115
            elseif aY == 4 then
                return 0.36515, 0.015275, 0.952075
            elseif aY == 5 then
                return 0.368525, 0.032475, 0.95335
            elseif aY == 6 then
                return 0.373275, 0.0506, 0.9543
            end
        elseif b4 == 2 then
            if aY == 0 then
                return -0.116, -0.1501, 0.947875
            elseif aY == 1 then
                return -0.102725, -0.13795, 0.948525
            elseif aY == 2 then
                return -0.08975, -0.12665, 0.949175
            elseif aY == 3 then
                return -0.075025, -0.1159, 0.949875
            elseif aY == 4 then
                return -0.0614, -0.104775, 0.9507
            elseif aY == 5 then
                return -0.046275, -0.095025, 0.9516
            elseif aY == 6 then
                return -0.031425, -0.0846, 0.952675
            end
        elseif b4 == 3 then
            if aY == 0 then
                return -0.5205, 0.1122, 0.9478
            elseif aY == 1 then
                return -0.503175, 0.108525, 0.94865
            elseif aY == 2 then
                return -0.485125, 0.10475, 0.949175
            elseif aY == 3 then
                return -0.468275, 0.099175, 0.94995
            elseif aY == 4 then
                return -0.45155, 0.09435, 0.95085
            elseif aY == 5 then
                return -0.434475, 0.089725, 0.95145
            elseif aY == 6 then
                return -0.415875, 0.0846, 0.9523
            end
        elseif b4 == 4 then
            if aY == 0 then
                return -0.293, 0.253, 0.950025
            elseif aY == 1 then
                return -0.093, 0.253, 0.950025
            elseif aY == 2 then
                return 0.0293, 0.253, 0.950025
            elseif aY == 3 then
                return 0.1516, 0.253, 0.950025
            elseif aY == 4 then
                return 0.2739, 0.253, 0.950025
            elseif aY == 5 then
                return 0.3962, 0.253, 0.950025
            elseif aY == 6 then
                return 0.5185, 0.253, 0.950025
            end
        end
    end
    return 0.0, 0.0, 0.947875
end
function func_376(aY, b4, b5, bd)
    if not b5 then
        if b4 == 0 then
            if aY == 0 then
                return vector3(0.0, 0.0, 69.12)
            elseif aY == 1 then
                return vector3(0.0, 0.0, 67.8)
            elseif aY == 2 then
                return vector3(0.0, 0.0, 66.6)
            elseif aY == 3 then
                return vector3(0.0, 0.0, 70.44)
            elseif aY == 4 then
                return vector3(0.0, 0.0, 70.84)
            elseif aY == 5 then
                return vector3(0.0, 0.0, 67.88)
            elseif aY == 6 then
                return vector3(0.0, 0.0, 69.56)
            end
        elseif aY == 1 then
            if aY == 0 then
                return vector3(0.0, 0.0, 22.11)
            elseif aY == 1 then
                return vector3(0.0, 0.0, 22.32)
            elseif aY == 2 then
                return vector3(0.0, 0.0, 20.8)
            elseif aY == 3 then
                return vector3(0.0, 0.0, 19.8)
            elseif aY == 4 then
                return vector3(0.0, 0.0, 19.44)
            elseif aY == 5 then
                return vector3(0.0, 0.0, 26.28)
            elseif aY == 6 then
                return vector3(0.0, 0.0, 22.68)
            end
        elseif aY == 2 then
            if aY == 0 then
                return vector3(0.0, 0.0, -21.43)
            elseif aY == 1 then
                return vector3(0.0, 0.0, -20.16)
            elseif aY == 2 then
                return vector3(0.0, 0.0, -16.92)
            elseif aY == 3 then
                return vector3(0.0, 0.0, -23.4)
            elseif aY == 4 then
                return vector3(0.0, 0.0, -21.24)
            elseif aY == 5 then
                return vector3(0.0, 0.0, -23.76)
            elseif aY == 6 then
                return vector3(0.0, 0.0, -19.44)
            end
        elseif aY == 3 then
            if aY == 0 then
                return vector3(0.0, 0.0, -67.03)
            elseif aY == 1 then
                return vector3(0.0, 0.0, -69.12)
            elseif aY == 2 then
                return vector3(0.0, 0.0, -64.44)
            elseif aY == 3 then
                return vector3(0.0, 0.0, -67.68)
            elseif aY == 4 then
                return vector3(0.0, 0.0, -63.72)
            elseif aY == 5 then
                return vector3(0.0, 0.0, -68.4)
            elseif aY == 6 then
                return vector3(0.0, 0.0, -64.44)
            end
        end
    else
        if b4 == 0 then
            if aY == 0 then
                return vector3(0.0, 0.0, 68.57)
            elseif aY == 1 then
                return vector3(0.0, 0.0, 67.52)
            elseif aY == 2 then
                return vector3(0.0, 0.0, 67.76)
            elseif aY == 3 then
                return vector3(0.0, 0.0, 67.04)
            elseif aY == 4 then
                return vector3(0.0, 0.0, 68.84)
            elseif aY == 5 then
                return vector3(0.0, 0.0, 65.96)
            elseif aY == 6 then
                return vector3(0.0, 0.0, 67.76)
            end
        elseif b4 == 1 then
            if aY == 0 then
                return vector3(0.0, 0.0, 22.11)
            elseif aY == 1 then
                return vector3(0.0, 0.0, 22)
            elseif aY == 2 then
                return vector3(0.0, 0.0, 24.44)
            elseif aY == 3 then
                return vector3(0.0, 0.0, 21.08)
            elseif aY == 4 then
                return vector3(0.0, 0.0, 25.96)
            elseif aY == 5 then
                return vector3(0.0, 0.0, 26.16)
            elseif aY == 6 then
                return vector3(0.0, 0.0, 28.76)
            end
        elseif b4 == 2 then
            if aY == 0 then
                return vector3(0.0, 0.0, -14.04)
            elseif aY == 1 then
                return vector3(0.0, 0.0, -15.48)
            elseif aY == 2 then
                return vector3(0.0, 0.0, -16.56)
            elseif aY == 3 then
                return vector3(0.0, 0.0, -15.84)
            elseif aY == 4 then
                return vector3(0.0, 0.0, -16.92)
            elseif aY == 5 then
                return vector3(0.0, 0.0, -14.4)
            elseif aY == 6 then
                return vector3(0.0, 0.0, -14.28)
            end
        elseif b4 == 3 then
            if aY == 0 then
                return vector3(0.0, 0.0, -67.03)
            elseif aY == 1 then
                return vector3(0.0, 0.0, -67.6)
            elseif aY == 2 then
                return vector3(0.0, 0.0, -69.4)
            elseif aY == 3 then
                return vector3(0.0, 0.0, -69.04)
            elseif aY == 4 then
                return vector3(0.0, 0.0, -68.68)
            elseif aY == 5 then
                return vector3(0.0, 0.0, -66.16)
            elseif aY == 6 then
                return vector3(0.0, 0.0, -63.28)
            end
        end
    end
    if bd then
        vVar0.z = vVar0.z + 90.0
    end
    return vVar0
end
function getChipPropFromAmount(au)
    au = tonumber(au)
    if au < 1000000 then
        denominations = {10, 50, 100, 500, 1000, 5000, 10000}
        chips = {}
        local be = 7
        for al, v in ipairs(denominations) do
            while au >= denominations[be] do
                table.insert(chips, denominations[be])
                au = au - denominations[be]
            end
            be = be - 1
        end
        for al, v in ipairs(chips) do
            chips[al] = getChipFromAmount(v)
        end
        return chips
    elseif au < 5000000 then
        return {"vw_prop_vw_chips_pile_01a"}
    elseif au < 10000000 then
        return {"vw_prop_vw_chips_pile_03a"}
    else
        return {"vw_prop_vw_chips_pile_02a"}
    end
    return {"vw_prop_chip_500dollar_st"}
end
local bf = {
    [1] = "vw_prop_vw_coin_01a",
    [10] = "vw_prop_chip_10dollar_x1",
    [50] = "vw_prop_chip_50dollar_x1",
    [100] = "vw_prop_chip_100dollar_x1",
    [500] = "vw_prop_chip_500dollar_x1",
    [1000] = "vw_prop_chip_1kdollar_x1",
    [5000] = "vw_prop_plaq_5kdollar_x1",
    [10000] = "vw_prop_plaq_10kdollar_x1"
}
function getChipFromAmount(au)
    return bf[au]
end
function blackjack_func_374(a9, b4, Y, bd)
    fVar0 = 0.0
    vVar1 = vector3(0, 0, 0)
    if not bd then
        if a9 == 10 then
            fVar0 = 0.95
        elseif a9 == 20 then
            fVar0 = 0.896
        elseif a9 == 30 then
            fVar0 = 0.901
        elseif a9 == 40 then
            fVar0 = 0.907
        elseif a9 == 50 then
            fVar0 = 0.95
        elseif a9 == 60 then
            fVar0 = 0.917
        elseif a9 == 70 then
            fVar0 = 0.922
        elseif a9 == 80 then
            fVar0 = 0.927
        elseif a9 == 90 then
            fVar0 = 0.932
        elseif a9 == 100 then
            fVar0 = 0.95
        elseif a9 == 150 then
            fVar0 = 0.904
        elseif a9 == 200 then
            fVar0 = 0.899
        elseif a9 == 250 then
            fVar0 = 0.914
        elseif a9 == 300 then
            fVar0 = 0.904
        elseif a9 == 350 then
            fVar0 = 0.924
        elseif a9 == 400 then
            fVar0 = 0.91
        elseif a9 == 450 then
            fVar0 = 0.935
        elseif a9 == 500 then
            fVar0 = 0.95
        elseif a9 == 1000 then
            fVar0 = 0.95
        elseif a9 == 1500 then
            fVar0 = 0.904
        elseif a9 == 2000 then
            fVar0 = 0.899
        elseif a9 == 2500 then
            fVar0 = 0.915
        elseif a9 == 3000 then
            fVar0 = 0.904
        elseif a9 == 3500 then
            fVar0 = 0.925
        elseif a9 == 4000 then
            fVar0 = 0.91
        elseif a9 == 4500 then
            fVar0 = 0.935
        elseif a9 == 5000 then
            fVar0 = 0.95
        elseif a9 == 6000 then
            fVar0 = 0.919
        elseif a9 == 7000 then
            fVar0 = 0.924
        elseif a9 == 8000 then
            fVar0 = 0.93
        elseif a9 == 9000 then
            fVar0 = 0.935
        elseif a9 == 10000 then
            fVar0 = 0.95
        elseif a9 == 15000 then
            fVar0 = 0.902
        elseif a9 == 20000 then
            fVar0 = 0.897
        elseif a9 == 25000 then
            fVar0 = 0.912
        elseif a9 == 30000 then
            fVar0 = 0.902
        elseif a9 == 35000 then
            fVar0 = 0.922
        elseif a9 == 40000 then
            fVar0 = 0.907
        elseif a9 == 45000 then
            fVar0 = 0.932
        elseif a9 == 50000 then
            fVar0 = 0.912
        end
        if Y == 0 then
            if b4 == 0 then
                vVar1 = vector3(0.712625, 0.170625, 0.0001)
            elseif b4 == 1 then
                vVar1 = vector3(0.6658, 0.218375, 0.0)
            elseif b4 == 2 then
                vVar1 = vector3(0.756775, 0.292775, 0.0)
            elseif b4 == 3 then
                vVar1 = vector3(0.701875, 0.3439, 0.0)
            end
        elseif Y == 1 then
            if b4 == 0 then
                vVar1 = vector3(0.278125, -0.2571, 0.0)
            elseif b4 == 1 then
                vVar1 = vector3(0.280375, -0.190375, 0.0)
            elseif b4 == 2 then
                vVar1 = vector3(0.397775, -0.208525, 0.0)
            elseif b4 == 3 then
                vVar1 = vector3(0.39715, -0.1354, 0.0)
            end
        elseif Y == 2 then
            if b4 == 0 then
                vVar1 = vector3(-0.30305, -0.2464, 0.0)
            elseif b4 == 1 then
                vVar1 = vector3(-0.257975, -0.19715, 0.0)
            elseif b4 == 2 then
                vVar1 = vector3(-0.186575, -0.2861, 0.0)
            elseif b4 == 3 then
                vVar1 = vector3(-0.141675, -0.237925, 0.0)
            end
        elseif Y == 3 then
            if b4 == 0 then
                vVar1 = vector3(-0.72855, 0.17345, 0.0)
            elseif b4 == 1 then
                vVar1 = vector3(-0.652825, 0.177525, 0.0)
            elseif b4 == 2 then
                vVar1 = vector3(-0.6783, 0.0744, 0.0)
            elseif b4 == 3 then
                vVar1 = vector3(-0.604425, 0.082575, 0.0)
            end
        end
    else
        if a9 == 10 then
            fVar0 = 0.95
        elseif a9 == 20 then
            fVar0 = 0.896
        elseif a9 == 30 then
            fVar0 = 0.901
        elseif a9 == 40 then
            fVar0 = 0.907
        elseif a9 == 50 then
            fVar0 = 0.95
        elseif a9 == 60 then
            fVar0 = 0.917
        elseif a9 == 70 then
            fVar0 = 0.922
        elseif a9 == 80 then
            fVar0 = 0.927
        elseif a9 == 90 then
            fVar0 = 0.932
        elseif a9 == 100 then
            fVar0 = 0.95
        elseif a9 == 150 then
            fVar0 = 0.904
        elseif a9 == 200 then
            fVar0 = 0.899
        elseif a9 == 250 then
            fVar0 = 0.914
        elseif a9 == 300 then
            fVar0 = 0.904
        elseif a9 == 350 then
            fVar0 = 0.924
        elseif a9 == 400 then
            fVar0 = 0.91
        elseif a9 == 450 then
            fVar0 = 0.935
        elseif a9 == 500 then
            fVar0 = 0.95
        elseif a9 == 1000 then
            fVar0 = 0.95
        elseif a9 == 1500 then
            fVar0 = 0.904
        elseif a9 == 2000 then
            fVar0 = 0.899
        elseif a9 == 2500 then
            fVar0 = 0.915
        elseif a9 == 3000 then
            fVar0 = 0.904
        elseif a9 == 3500 then
            fVar0 = 0.925
        elseif a9 == 4000 then
            fVar0 = 0.91
        elseif a9 == 4500 then
            fVar0 = 0.935
        elseif a9 == 5000 then
            fVar0 = 0.953
        elseif a9 == 6000 then
            fVar0 = 0.919
        elseif a9 == 7000 then
            fVar0 = 0.924
        elseif a9 == 8000 then
            fVar0 = 0.93
        elseif a9 == 9000 then
            fVar0 = 0.935
        elseif a9 == 10000 then
            fVar0 = 0.95
        elseif a9 == 15000 then
            fVar0 = 0.902
        elseif a9 == 20000 then
            fVar0 = 0.897
        elseif a9 == 25000 then
            fVar0 = 0.912
        elseif a9 == 30000 then
            fVar0 = 0.902
        elseif a9 == 35000 then
            fVar0 = 0.922
        elseif a9 == 40000 then
            fVar0 = 0.907
        elseif a9 == 45000 then
            fVar0 = 0.932
        elseif a9 == 50000 then
            fVar0 = 0.912
        end
        if a9 == 50000 then
            if Y == 0 then
                if b4 == 0 then
                    vVar1 = vector3(0.6931, 0.1952, 0.0)
                elseif b4 == 1 then
                    vVar1 = vector3(0.724925, 0.26955, 0.0)
                elseif b4 == 1 then
                    vVar1 = vector3(0.7374, 0.349625, 0.0)
                elseif b4 == 1 then
                    vVar1 = vector3(0.76415, 0.419225, 0.0)
                end
            elseif Y == 1 then
                if b4 == 0 then
                    vVar1 = vector3(0.2827, -0.227825, 0.0)
                elseif b4 == 1 then
                    vVar1 = vector3(0.3605, -0.1898, 0.0)
                elseif b4 == 2 then
                    vVar1 = vector3(0.4309, -0.16365, 0.0)
                elseif b4 == 3 then
                    vVar1 = vector3(0.49275, -0.111575, 0.0)
                end
            elseif Y == 2 then
                if b4 == 0 then
                    vVar1 = vector3(-0.279425, -0.2238, 0.0)
                elseif b4 == 1 then
                    vVar1 = vector3(-0.200775, -0.25855, 0.0)
                elseif b4 == 2 then
                    vVar1 = vector3(-0.125775, -0.26815, 0.0)
                elseif b4 == 3 then
                    vVar1 = vector3(-0.05615, -0.29435, 0.0)
                end
            elseif Y == 3 then
                if b4 == 0 then
                    vVar1 = vector3(-0.685925, 0.173275, 0.0)
                elseif b4 == 1 then
                    vVar1 = vector3(-0.6568, 0.092525, 0.0)
                elseif b4 == 2 then
                    vVar1 = vector3(-0.612875, 0.033025, 0.0)
                elseif b4 == 3 then
                    vVar1 = vector3(-0.58465, -0.0374, 0.0)
                end
            end
        else
            if Y == 0 then
                if b4 == 0 then
                    vVar1 = vector3(0.712625, 0.170625, 0.0)
                elseif b4 == 1 then
                    vVar1 = vector3(0.6658, 0.218375, 0.0)
                elseif b4 == 2 then
                    vVar1 = vector3(0.756775, 0.292775, 0.0)
                elseif b4 == 3 then
                    vVar1 = vector3(0.701875, 0.3439, 0.0)
                end
            elseif Y == 1 then
                if b4 == 0 then
                    vVar1 = vector3(0.278125, -0.2571, 0.0)
                elseif b4 == 1 then
                    vVar1 = vector3(0.280375, -0.190375, 0.0)
                elseif b4 == 2 then
                    vVar1 = vector3(0.397775, -0.208525, 0.0)
                elseif b4 == 3 then
                    vVar1 = vector3(0.39715, -0.1354, 0.0)
                end
            elseif Y == 2 then
                if b4 == 0 then
                    vVar1 = vector3(-0.30305, -0.2464, 0.0)
                elseif b4 == 1 then
                    vVar1 = vector3(-0.257975, -0.19715, 0.0)
                elseif b4 == 2 then
                    vVar1 = vector3(-0.186575, -0.2861, 0.0)
                elseif b4 == 3 then
                    vVar1 = vector3(-0.141675, -0.237925, 0.0)
                end
            elseif Y == 3 then
                if b4 == 0 then
                    vVar1 = vector3(-0.72855, 0.17345, 0.0)
                elseif b4 == 1 then
                    vVar1 = vector3(-0.652825, 0.177525, 0.0)
                elseif b4 == 2 then
                    vVar1 = vector3(-0.6783, 0.0744, 0.0)
                elseif b4 == 3 then
                    vVar1 = vector3(-0.604425, 0.082575, 0.0)
                end
            end
        end
    end
    vVar1 = vVar1 + vector3(0.0, 0.0, fVar0)
    return vVar1
end
function blackjack_func_373(aY, b4, bg, bd)
    if not bd then
        if bg == 0 then
            if b4 == 0 then
                return vector3(0.0, 0.0, 72)
            elseif b4 == 1 then
                return vector3(0.0, 0.0, 64.8)
            elseif b4 == 2 then
                return vector3(0.0, 0.0, 74.52)
            elseif b4 == 3 then
                return vector3(0.0, 0.0, 72)
            end
        elseif bg == 1 then
            if b4 == 0 then
                return vector3(0.0, 0.0, 12.96)
            elseif b4 == 1 then
                return vector3(0.0, 0.0, 29.16)
            elseif b4 == 2 then
                return vector3(0.0, 0.0, 32.04)
            elseif b4 == 3 then
                return vector3(0.0, 0.0, 32.04)
            end
        elseif bg == 2 then
            if b4 == 0 then
                return vector3(0.0, 0.0, -18.36)
            elseif b4 == 1 then
                return vector3(0.0, 0.0, -18.72)
            elseif b4 == 2 then
                return vector3(0.0, 0.0, -15.48)
            elseif b4 == 3 then
                return vector3(0.0, 0.0, -18)
            end
        elseif bg == 3 then
            if b4 == 0 then
                return vector3(0.0, 0.0, -79.2)
            elseif b4 == 1 then
                return vector3(0.0, 0.0, -68.76)
            elseif b4 == 2 then
                return vector3(0.0, 0.0, -57.6)
            elseif b4 == 3 then
                return vector3(0.0, 0.0, -64.8)
            end
        end
    else
        if aY == 50000 then
            if bg == 0 then
                if b4 == 0 then
                    return vector3(0.0, 0.0, -16.56)
                elseif b4 == 1 then
                    return vector3(0.0, 0.0, -22.32)
                elseif b4 == 2 then
                    return vector3(0.0, 0.0, -10.8)
                elseif b4 == 3 then
                    return vector3(0.0, 0.0, -9.72)
                end
            elseif bg == 1 then
                if b4 == 0 then
                    return vector3(0.0, 0.0, -69.12)
                elseif b4 == 1 then
                    return vector3(0.0, 0.0, -64.8)
                elseif b4 == 2 then
                    return vector3(0.0, 0.0, -58.68)
                elseif b4 == 3 then
                    return vector3(0.0, 0.0, -51.12)
                end
            elseif bg == 2 then
                if b4 == 0 then
                    return vector3(0.0, 0.0, -112.32)
                elseif b4 == 1 then
                    return vector3(0.0, 0.0, -108.36)
                elseif b4 == 2 then
                    return vector3(0.0, 0.0, -99.72)
                elseif b4 == 3 then
                    return vector3(0.0, 0.0, -102.6)
                end
            elseif bg == 3 then
                if b4 == 0 then
                    return vector3(0.0, 0.0, -155.88)
                elseif b4 == 1 then
                    return vector3(0.0, 0.0, -151.92)
                elseif b4 == 2 then
                    return vector3(0.0, 0.0, -147.24)
                elseif b4 == 3 then
                    return vector3(0.0, 0.0, -146.52)
                end
            end
        else
            if bg == 0 then
                if b4 == 0 then
                    return vector3(0.0, 0.0, 72)
                elseif b4 == 1 then
                    return vector3(0.0, 0.0, 64.8)
                elseif b4 == 2 then
                    return vector3(0.0, 0.0, 74.52)
                elseif b4 == 3 then
                    return vector3(0.0, 0.0, 72)
                end
            elseif bg == 1 then
                if b4 == 0 then
                    return vector3(0.0, 0.0, 12.96)
                elseif b4 == 1 then
                    return vector3(0.0, 0.0, 29.16)
                elseif b4 == 2 then
                    return vector3(0.0, 0.0, 32.04)
                elseif b4 == 3 then
                    return vector3(0.0, 0.0, 32.04)
                end
            elseif bg == 2 then
                if b4 == 0 then
                    return vector3(0.0, 0.0, -18.36)
                elseif b4 == 1 then
                    return vector3(0.0, 0.0, -18.72)
                elseif b4 == 2 then
                    return vector3(0.0, 0.0, -15.48)
                elseif b4 == 3 then
                    return vector3(0.0, 0.0, -18)
                end
            elseif bg == 3 then
                if b4 == 0 then
                    return vector3(0.0, 0.0, -79.2)
                elseif b4 == 1 then
                    return vector3(0.0, 0.0, -68.76)
                elseif b4 == 2 then
                    return vector3(0.0, 0.0, -57.6)
                elseif b4 == 3 then
                    return vector3(0.0, 0.0, -64.8)
                end
            end
        end
    end
    return vector3(0.0, 0.0, 0)
end
function ButtonMessage(bh)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentSubstringKeyboardDisplay(bh)
    EndTextCommandScaleformString()
end
function Button(bi)
    ScaleformMovieMethodAddParamPlayerNameString(bi)
end
function setupBlackjackInstructionalScaleform(bj)
    local bj = RequestScaleformMovie(bj)
    while not HasScaleformMovieLoaded(bj) do
        Citizen.Wait(0)
    end
    BeginScaleformMovieMethod(bj, "CLEAR_ALL")
    EndScaleformMovieMethod()
    BeginScaleformMovieMethod(bj, "SET_CLEAR_SPACE")
    ScaleformMovieMethodAddParamInt(200)
    EndScaleformMovieMethod()
    BeginScaleformMovieMethod(bj, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(1)
    Button(GetControlInstructionalButton(2, 194, true))
    ButtonMessage("Leave table")
    EndScaleformMovieMethod()
    BeginScaleformMovieMethod(bj, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(0)
    Button(GetControlInstructionalButton(2, 191, true))
    ButtonMessage("Place bet")
    EndScaleformMovieMethod()
    BeginScaleformMovieMethod(bj, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(2)
    Button(GetControlInstructionalButton(2, 11, true))
    ButtonMessage("View dealers hand")
    EndScaleformMovieMethod()
    BeginScaleformMovieMethod(bj, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(3)
    Button(GetControlInstructionalButton(2, 10, true))
    ButtonMessage("View your hand")
    EndScaleformMovieMethod()
    BeginScaleformMovieMethod(bj, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(4)
    Button(GetControlInstructionalButton(2, 22, true))
    ButtonMessage("Choose bet")
    EndScaleformMovieMethod()
    BeginScaleformMovieMethod(bj, "DRAW_INSTRUCTIONAL_BUTTONS")
    EndScaleformMovieMethod()
    BeginScaleformMovieMethod(bj, "SET_BACKGROUND_COLOUR")
    ScaleformMovieMethodAddParamInt(0)
    ScaleformMovieMethodAddParamInt(0)
    ScaleformMovieMethodAddParamInt(0)
    ScaleformMovieMethodAddParamInt(80)
    EndScaleformMovieMethod()
    return bj
end
function setupBlackjackMidBetScaleform(bj)
    local bj = RequestScaleformMovie(bj)
    while not HasScaleformMovieLoaded(bj) do
        Citizen.Wait(0)
    end
    BeginScaleformMovieMethod(bj, "CLEAR_ALL")
    EndScaleformMovieMethod()
    BeginScaleformMovieMethod(bj, "SET_CLEAR_SPACE")
    ScaleformMovieMethodAddParamInt(200)
    EndScaleformMovieMethod()
    BeginScaleformMovieMethod(bj, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(2)
    Button(GetControlInstructionalButton(2, 11, true))
    ButtonMessage("View dealers hand")
    EndScaleformMovieMethod()
    BeginScaleformMovieMethod(bj, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(3)
    Button(GetControlInstructionalButton(2, 10, true))
    ButtonMessage("View your hand")
    EndScaleformMovieMethod()
    BeginScaleformMovieMethod(bj, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(1)
    Button(GetControlInstructionalButton(2, 194, true))
    ButtonMessage("Stand")
    EndScaleformMovieMethod()
    BeginScaleformMovieMethod(bj, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(4)
    Button(GetControlInstructionalButton(2, 22, true))
    ButtonMessage("Hit")
    EndScaleformMovieMethod()
    BeginScaleformMovieMethod(bj, "DRAW_INSTRUCTIONAL_BUTTONS")
    EndScaleformMovieMethod()
    BeginScaleformMovieMethod(bj, "SET_BACKGROUND_COLOUR")
    ScaleformMovieMethodAddParamInt(0)
    ScaleformMovieMethodAddParamInt(0)
    ScaleformMovieMethodAddParamInt(0)
    ScaleformMovieMethodAddParamInt(80)
    EndScaleformMovieMethod()
    return bj
end
function getDealerIdFromEntity(Q)
    local bk = nil
    local bl = 10000
    local bm = GetEntityCoords(Q)
    for al, v in pairs(G.blackjackTables) do
        local bn = v.dealerPos
        if #(bm - bn) < bl then
            bk = al
            bl = #(bm - bn)
        end
    end
    return bk
end
function setBlackjackDealerPedVoiceGroup(bo, U)
    if bo == 0 then
        SetPedVoiceGroup(U, GetHashKey("S_M_Y_Casino_01_WHITE_01"))
    elseif bo == 1 then
        SetPedVoiceGroup(U, GetHashKey("S_M_Y_Casino_01_ASIAN_01"))
    elseif bo == 2 then
        SetPedVoiceGroup(U, GetHashKey("S_M_Y_Casino_01_ASIAN_02"))
    elseif bo == 3 then
        SetPedVoiceGroup(U, GetHashKey("S_M_Y_Casino_01_ASIAN_01"))
    elseif bo == 4 then
        SetPedVoiceGroup(U, GetHashKey("S_M_Y_Casino_01_WHITE_01"))
    elseif bo == 5 then
        SetPedVoiceGroup(U, GetHashKey("S_M_Y_Casino_01_WHITE_02"))
    elseif bo == 6 then
        SetPedVoiceGroup(U, GetHashKey("S_M_Y_Casino_01_WHITE_01"))
    elseif bo == 7 then
        SetPedVoiceGroup(U, GetHashKey("S_F_Y_Casino_01_ASIAN_01"))	
    elseif bo == 8 then
        SetPedVoiceGroup(U, GetHashKey("S_F_Y_Casino_01_ASIAN_02"))
    elseif bo == 9 then
        SetPedVoiceGroup(U, GetHashKey("S_F_Y_Casino_01_ASIAN_01"))
    elseif bo == 10 then
        SetPedVoiceGroup(U, GetHashKey("S_F_Y_Casino_01_ASIAN_02"))
    elseif bo == 11 then
        SetPedVoiceGroup(U, GetHashKey("S_F_Y_Casino_01_LATINA_01"))
    elseif bo == 12 then
        SetPedVoiceGroup(U, GetHashKey("S_F_Y_Casino_01_LATINA_02"))
    elseif bo == 13 then
        SetPedVoiceGroup(U, GetHashKey("S_F_Y_Casino_01_LATINA_01"))
    end
end
function setBlackjackDealerClothes(bo, U)
    if bo == 0 then
        SetPedDefaultComponentVariation(U)
        SetPedComponentVariation(U, 0, 3, 0, 0)
        SetPedComponentVariation(U, 1, 1, 0, 0)
        SetPedComponentVariation(U, 2, 3, 0, 0)
        SetPedComponentVariation(U, 3, 1, 0, 0)
        SetPedComponentVariation(U, 4, 0, 0, 0)
        SetPedComponentVariation(U, 6, 1, 0, 0)
        SetPedComponentVariation(U, 7, 2, 0, 0)
        SetPedComponentVariation(U, 8, 3, 0, 0)
        SetPedComponentVariation(U, 10, 1, 0, 0)
        SetPedComponentVariation(U, 11, 1, 0, 0)
    elseif bo == 1 then
        SetPedDefaultComponentVariation(U)
        SetPedComponentVariation(U, 0, 2, 2, 0)
        SetPedComponentVariation(U, 1, 1, 0, 0)
        SetPedComponentVariation(U, 2, 4, 0, 0)
        SetPedComponentVariation(U, 3, 0, 3, 0)
        SetPedComponentVariation(U, 4, 0, 0, 0)
        SetPedComponentVariation(U, 6, 1, 0, 0)
        SetPedComponentVariation(U, 7, 2, 0, 0)
        SetPedComponentVariation(U, 8, 1, 0, 0)
        SetPedComponentVariation(U, 10, 1, 0, 0)
        SetPedComponentVariation(U, 11, 1, 0, 0)
    elseif bo == 2 then
        SetPedDefaultComponentVariation(U)
        SetPedComponentVariation(U, 0, 2, 1, 0)
        SetPedComponentVariation(U, 1, 1, 0, 0)
        SetPedComponentVariation(U, 2, 2, 0, 0)
        SetPedComponentVariation(U, 3, 0, 3, 0)
        SetPedComponentVariation(U, 4, 0, 0, 0)
        SetPedComponentVariation(U, 6, 1, 0, 0)
        SetPedComponentVariation(U, 7, 2, 0, 0)
        SetPedComponentVariation(U, 8, 1, 0, 0)
        SetPedComponentVariation(U, 10, 1, 0, 0)
        SetPedComponentVariation(U, 11, 1, 0, 0)
    elseif bo == 3 then
        SetPedDefaultComponentVariation(U)
        SetPedComponentVariation(U, 0, 2, 0, 0)
        SetPedComponentVariation(U, 1, 1, 0, 0)
        SetPedComponentVariation(U, 2, 3, 0, 0)
        SetPedComponentVariation(U, 3, 1, 3, 0)
        SetPedComponentVariation(U, 4, 0, 0, 0)
        SetPedComponentVariation(U, 6, 1, 0, 0)
        SetPedComponentVariation(U, 7, 2, 0, 0)
        SetPedComponentVariation(U, 8, 3, 0, 0)
        SetPedComponentVariation(U, 10, 1, 0, 0)
        SetPedComponentVariation(U, 11, 1, 0, 0)
    elseif bo == 4 then
        SetPedDefaultComponentVariation(U)
        SetPedComponentVariation(U, 0, 4, 2, 0)
        SetPedComponentVariation(U, 1, 1, 0, 0)
        SetPedComponentVariation(U, 2, 3, 0, 0)
        SetPedComponentVariation(U, 3, 0, 0, 0)
        SetPedComponentVariation(U, 4, 0, 0, 0)
        SetPedComponentVariation(U, 6, 1, 0, 0)
        SetPedComponentVariation(U, 7, 2, 0, 0)
        SetPedComponentVariation(U, 8, 1, 0, 0)
        SetPedComponentVariation(U, 10, 1, 0, 0)
        SetPedComponentVariation(U, 11, 1, 0, 0)
    elseif bo == 5 then
        SetPedDefaultComponentVariation(U)
        SetPedComponentVariation(U, 0, 4, 0, 0)
        SetPedComponentVariation(U, 1, 1, 0, 0)
        SetPedComponentVariation(U, 2, 0, 0, 0)
        SetPedComponentVariation(U, 3, 0, 0, 0)
        SetPedComponentVariation(U, 4, 0, 0, 0)
        SetPedComponentVariation(U, 6, 1, 0, 0)
        SetPedComponentVariation(U, 7, 2, 0, 0)
        SetPedComponentVariation(U, 8, 1, 0, 0)
        SetPedComponentVariation(U, 10, 1, 0, 0)
        SetPedComponentVariation(U, 11, 1, 0, 0)
    elseif bo == 6 then
        SetPedDefaultComponentVariation(U)
        SetPedComponentVariation(U, 0, 4, 1, 0)
        SetPedComponentVariation(U, 1, 1, 0, 0)
        SetPedComponentVariation(U, 2, 4, 0, 0)
        SetPedComponentVariation(U, 3, 1, 0, 0)
        SetPedComponentVariation(U, 4, 0, 0, 0)
        SetPedComponentVariation(U, 6, 1, 0, 0)
        SetPedComponentVariation(U, 7, 2, 0, 0)
        SetPedComponentVariation(U, 8, 3, 0, 0)
        SetPedComponentVariation(U, 10, 1, 0, 0)
        SetPedComponentVariation(U, 11, 1, 0, 0)
    elseif bo == 7 then
        SetPedDefaultComponentVariation(U)
        SetPedComponentVariation(U, 0, 1, 1, 0)
        SetPedComponentVariation(U, 1, 0, 0, 0)
        SetPedComponentVariation(U, 2, 1, 0, 0)
        SetPedComponentVariation(U, 3, 0, 3, 0)
        SetPedComponentVariation(U, 4, 0, 0, 0)
        SetPedComponentVariation(U, 6, 0, 0, 0)
        SetPedComponentVariation(U, 7, 0, 0, 0)
        SetPedComponentVariation(U, 8, 0, 0, 0)
        SetPedComponentVariation(U, 10, 0, 0, 0)
        SetPedComponentVariation(U, 11, 0, 0, 0)
    elseif bo == 8 then
        SetPedDefaultComponentVariation(U)
        SetPedComponentVariation(U, 0, 1, 1, 0)
        SetPedComponentVariation(U, 1, 0, 0, 0)
        SetPedComponentVariation(U, 2, 1, 1, 0)
        SetPedComponentVariation(U, 3, 1, 3, 0)
        SetPedComponentVariation(U, 4, 0, 0, 0)
        SetPedComponentVariation(U, 6, 0, 0, 0)
        SetPedComponentVariation(U, 7, 2, 0, 0)
        SetPedComponentVariation(U, 8, 1, 0, 0)
        SetPedComponentVariation(U, 10, 0, 0, 0)
        SetPedComponentVariation(U, 11, 0, 0, 0)
    elseif bo == 9 then
        SetPedDefaultComponentVariation(U)
        SetPedComponentVariation(U, 0, 2, 0, 0)
        SetPedComponentVariation(U, 1, 0, 0, 0)
        SetPedComponentVariation(U, 2, 2, 0, 0)
        SetPedComponentVariation(U, 3, 2, 3, 0)
        SetPedComponentVariation(U, 4, 0, 0, 0)
        SetPedComponentVariation(U, 6, 0, 0, 0)
        SetPedComponentVariation(U, 7, 0, 0, 0)
        SetPedComponentVariation(U, 8, 2, 0, 0)
        SetPedComponentVariation(U, 10, 0, 0, 0)
        SetPedComponentVariation(U, 11, 0, 0, 0)
    elseif bo == 10 then
        SetPedDefaultComponentVariation(U)
        SetPedComponentVariation(U, 0, 2, 1, 0)
        SetPedComponentVariation(U, 1, 0, 0, 0)
        SetPedComponentVariation(U, 2, 2, 1, 0)
        SetPedComponentVariation(U, 3, 3, 3, 0)
        SetPedComponentVariation(U, 4, 1, 0, 0)
        SetPedComponentVariation(U, 6, 1, 0, 0)
        SetPedComponentVariation(U, 7, 2, 0, 0)
        SetPedComponentVariation(U, 8, 3, 0, 0)
        SetPedComponentVariation(U, 10, 0, 0, 0)
        SetPedComponentVariation(U, 11, 0, 0, 0)
    elseif bo == 11 then
        SetPedDefaultComponentVariation(U)
        SetPedComponentVariation(U, 0, 3, 0, 0)
        SetPedComponentVariation(U, 1, 0, 0, 0)
        SetPedComponentVariation(U, 2, 3, 0, 0)
        SetPedComponentVariation(U, 3, 0, 1, 0)
        SetPedComponentVariation(U, 4, 1, 0, 0)
        SetPedComponentVariation(U, 6, 1, 0, 0)
        SetPedComponentVariation(U, 7, 1, 0, 0)
        SetPedComponentVariation(U, 8, 0, 0, 0)
        SetPedComponentVariation(U, 10, 0, 0, 0)
        SetPedComponentVariation(U, 11, 0, 0, 0)
        SetPedPropIndex(U, 1, 0, 0, false)
    elseif bo == 12 then
        SetPedDefaultComponentVariation(U)
        SetPedComponentVariation(U, 0, 3, 1, 0)
        SetPedComponentVariation(U, 1, 0, 0, 0)
        SetPedComponentVariation(U, 2, 3, 1, 0)
        SetPedComponentVariation(U, 3, 1, 1, 0)
        SetPedComponentVariation(U, 4, 1, 0, 0)
        SetPedComponentVariation(U, 6, 1, 0, 0)
        SetPedComponentVariation(U, 7, 2, 0, 0)
        SetPedComponentVariation(U, 8, 1, 0, 0)
        SetPedComponentVariation(U, 10, 0, 0, 0)
        SetPedComponentVariation(U, 11, 0, 0, 0)
    elseif bo == 13 then
        SetPedDefaultComponentVariation(U)
        SetPedComponentVariation(U, 0, 4, 0, 0)
        SetPedComponentVariation(U, 1, 0, 0, 0)
        SetPedComponentVariation(U, 2, 4, 0, 0)
        SetPedComponentVariation(U, 3, 2, 1, 0)
        SetPedComponentVariation(U, 4, 1, 0, 0)
        SetPedComponentVariation(U, 6, 1, 0, 0)
        SetPedComponentVariation(U, 7, 1, 0, 0)
        SetPedComponentVariation(U, 8, 2, 0, 0)
        SetPedComponentVariation(U, 10, 0, 0, 0)
        SetPedComponentVariation(U, 11, 0, 0, 0)
        SetPedPropIndex(U, 1, 0, 0, false)
    end
end

RegisterCommand("cleantable",function()
    for al, v in pairs(cardObjects) do
        for af, bp in pairs(v) do
            DeleteObject(bp)
        end
    end
end)

function drawNativeNotification(text)
    SetTextComponentFormat('STRING')
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

RegisterNetEvent("blackjack:notify")
AddEventHandler("blackjack:notify",function(msg)
    notify(msg)
end)