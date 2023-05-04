RMenu.Add("ARMAtattoos","mainMenu",RageUI.CreateMenu("","Tattoo Store",tARMA.getRageUIMenuWidth(),tARMA.getRageUIMenuHeight(),"shopui_title_tattoos2","shopui_title_tattoos2"))
local a = module("cfg/cfg_tattoos")
local b = -1
local c = false
local d = {
    {name = "Part 1", value = "mpbeach_overlays", currentListIndex = 1},
    {name = "Part 2", value = "mpbusiness_overlays", currentListIndex = 1},
    {name = "Part 3", value = "mphipster_overlays", currentListIndex = 1},
    {name = "Part 4", value = "mpbiker_overlays", currentListIndex = 1},
    {name = "Part 5", value = "mpairraces_overlays", currentListIndex = 1},
    {name = "Part 6", value = "mpbeach_overlays", currentListIndex = 1},
    {name = "Part 7", value = "mpchristmas2_overlays", currentListIndex = 1},
    {name = "Part 8", value = "mpgunrunning_overlays", currentListIndex = 1},
    {name = "Part 9", value = "mpimportexport_overlays", currentListIndex = 1},
    {name = "Part 10", value = "mplowrider2_overlays", currentListIndex = 1},
    {name = "Part 11", value = "mplowrider_overlays", currentListIndex = 1},
    {name = "Custom Tattoos", value = "new_overlays", currentListIndex = 1}
}
local e = a.tattoosList
local f = a.tattoosShops
local g
local h = {}
local i = {}
local j = nil
local k = false
local l = false
local m = {}
local n = {}
local o = false
local p = false
local q
local r
local s
local t
local u
local v
local w
local x
local y = 0
local function z()
    AddTextEntry("FMMC_MPM_NA", "Enter tattoo ID you want to wear")
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Enter tattoo ID you want to wear", "", "", "", "", 30)
    while UpdateOnscreenKeyboard() == 0 do
        Wait(0)
    end
    if GetOnscreenKeyboardResult() then
        local A = GetOnscreenKeyboardResult()
        if A then
            l = false
            local B = tonumber(A)
            local C = tARMA.getPlayerPed()
            if B ~= nil then
                m["id"] = B + 1
            else
                m["id"] = n.index
            end
            k = true
            return A
        end
    end
    l = false
end
AddEventHandler("ARMA:onClientSpawn",function(D, E)
    if E then
        local F = function()
            TriggerServerEvent("ARMA:getPlayerTattoos")
            Citizen.Wait(500)
            c = true
            i = deepcopy(h)
            j = tARMA.getCustomization()
            RageUI.Visible(RMenu:Get("ARMAtattoos", "mainMenu"), true)
        end
        local G = function()
            if DoesCamExist(b) then
                RenderScriptCams(false, false, 0, 1, 0)
                DestroyCam(b, false)
            end
            RageUI.Visible(RMenu:Get("ARMAtattoos", "mainMenu"), false)
            tARMA.setCustomization(j)
            j = nil
            ClearPedDecorations(tARMA.getPlayerPed())
            for H = 1, #i, 1 do
                AddPedDecorationFromHashes(tARMA.getPlayerPed(),GetHashKey(i[H].collection),GetHashKey(e[i[H].collection][i[H].current].nameHash))
            end
            c = false
            h = {}
        end
        local I = function()
            if c and not o then
                drawSkinInstructionKeys()
                o = true
            end
            if RageUI.Visible(RMenu:Get("ARMAtattoos", "mainMenu")) then
                if IsControlJustPressed(0, 179) and not l then
                    l = true
                    z()
                end
            end
        end
        for B, J in pairs(f) do
            RequestStreamedTextureDict("mptattoos1")
            Wait(100)
            tARMA.createArea("tattoParlour_" .. B, J, 1.5, 6, F, G, I)
            tARMA.addBlip(J.x, J.y, J.z, 75, 0, "Tattoo Parlour")
            tARMA.addMarker(J.x,J.y,J.z,0.6,0.6,0.6,10,255,81,170,50,9,false,false,true,"mptattoos1","tattoo_defend_safehouse",90.0,90.0,0.0)
        end
    end
end)
function deepcopy(K)
    local L = type(K)
    local M
    if L == "table" then
        M = {}
        for N, O in next, K, nil do
            M[deepcopy(N)] = deepcopy(O)
        end
        setmetatable(M, deepcopy(getmetatable(K)))
    else
        M = K
    end
    return M
end
Citizen.CreateThread(function()
    local P = false
    while true do
        Wait(500)
        if tARMA.isInComa() and not P then
            P = true
        end
        if not tARMA.isInComa() and P then
            Wait(5000)
            TriggerServerEvent("ARMA:getPlayerTattoos")
            P = false
        end
    end
end)
RegisterNetEvent("ARMA:setTattoos",function(Q)
    Citizen.Wait(500)
    if Q == nil then return end
    local R = Q
    for H = 1, #R, 1 do
        for S = 1, #d, 1 do
            if d[S].name == R[H].part then
                d[S].currentListIndex = R[H].current
            end
        end
        AddPedDecorationFromHashes(tARMA.getPlayerPed(),GetHashKey(R[H].collection),GetHashKey(e[R[H].collection][R[H].current].nameHash))
        table.insert(h, R[H])
    end
end)
RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('ARMAtattoos', 'mainMenu')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            for H = 1, #d, 1 do
                local T = d[H]
                n = T
                RageUI.List(T.name,get_num_tattoos(T.value),d[H].currentListIndex,"Tattoo Add/Removal Price: £1,000",{},true,function(U, V, W, X)
                    if V then
                        if IsControlJustPressed(0, 177) or IsControlJustPressed(0, 194) or IsControlJustPressed(0, 202) then
                            if DoesCamExist(b) then
                                RenderScriptCams(false, false, 0, 1, 0)
                                DestroyCam(b, false)
                            end
                        end
                        if IsControlJustPressed(0, 172) or IsControlJustPressed(0, 241) or IsControlJustPressed(0, 173) or IsControlJustPressed(0, 242) then
                            if T.index ~= n.index then
                                n = T
                            end
                        end
                        if T.name == n.name then
                            local C = tARMA.getPlayerPed()
                            if k then
                                if m ~= nil and m["id"] <= #get_num_tattoos(T.value) and m["id"] >= 0 then
                                    X = m["id"]
                                    drawTattoo(X, n.value, T.name)
                                    k = false
                                else
                                    k = false
                                end
                            else
                                if d[H].currentListIndex ~= X then
                                    drawTattoo(X, n.value, T.name)
                                end
                            end
                            d[H].currentListIndex = X
                        end
                        if c and not l and IsControlJustReleased(0, 178) then
                            p = true
                            drawTattoo(X, n.value, n.name)
                            TriggerServerEvent("ARMA:saveTattoos", i, 1000)
                        end
                    end
                    if W then
                        table.insert(i, {part = T.name, collection = n.value, current = X})
                        TriggerServerEvent("ARMA:saveTattoos", i, 1000)
                    end
                end,
                function()end,nil)
            end
       end)
    end
end)
function get_num_tattoos(type)
    local C = tARMA.getPlayerPed()
    local Y = #e[type] - 1
    local Z = {"0/" .. Y}
    for H = 1, #e[type] - 1, 1 do
        Z[#Z + 1] = H .. "/" .. Y
    end
    return Z
end
function drawTattoo(_, a0, a1)
    SetEntityHeading(tARMA.getPlayerPed(), 297.7296)
    local C = tARMA.getPlayerPed()
    local a2 = false
    if _ ~= nil and a0 ~= nil and a1 ~= nil then
        if p then
            for H = 1, #i, 1 do
                if i[H] ~= nil then
                    if i[H].current == _ then
                        table.remove(i, H)
                    end
                end
            end
            ClearPedDecorations(tARMA.getPlayerPed())
            for H = 1, #i, 1 do
                AddPedDecorationFromHashes(tARMA.getPlayerPed(),GetHashKey(i[H].collection),GetHashKey(e[i[H].collection][i[H].current].nameHash))
            end
            p = false
        else
            if GetEntityModel(tARMA.getPlayerPed()) == -1667301416 then
                tARMA.loadCustomisationPreset("TattooMale")
            else
                tARMA.loadCustomisationPreset("TattooFemale")
            end
            ClearPedDecorations(tARMA.getPlayerPed())
            for H = 1, #i, 1 do
                AddPedDecorationFromHashes(tARMA.getPlayerPed(),GetHashKey(i[H].collection),GetHashKey(e[i[H].collection][i[H].current].nameHash))
            end
            AddPedDecorationFromHashes(tARMA.getPlayerPed(), GetHashKey(a0), GetHashKey(e[a0][_].nameHash))
            if not DoesCamExist(b) then
                b = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
                SetCamCoord(b, GetEntityCoords(tARMA.getPlayerPed()))
                SetCamRot(b, 0.0, 0.0, 0.0)
                SetCamActive(b, true)
                RenderScriptCams(true, false, 0, true, true)
                SetCamCoord(b, GetEntityCoords(tARMA.getPlayerPed()))
            end
            local S, a3, a4 = table.unpack(GetEntityCoords(tARMA.getPlayerPed()))
            SetCamCoord(b, S + e[a0][_].addedX, a3 + e[a0][_].addedY, a4 + e[a0][_].addedZ)
            SetCamRot(b, 0.0, 0.0, e[a0][_].rotZ)
        end
        g = a1
    end
end
function drawSkinInstructionKeys()
    local a5 = {
        {["label"] = "Enter Tattoo ID ", ["button"] = "~INPUT_CELLPHONE_EXTRA_OPTION~"},
        {["label"] = "Remove Current Tattoo ", ["button"] = "~INPUT_CELLPHONE_OPTION~"},
        {["label"] = "Purchase Current Tattoo ", ["button"] = "~INPUT_CELLPHONE_SELECT~"},
        {["label"] = "Next Index ", ["button"] = "~INPUT_CELLPHONE_RIGHT~"},
        {["label"] = "Previous Index ", ["button"] = "~INPUT_CELLPHONE_LEFT~"}
    }
    Citizen.CreateThread(function()
        Wait(0)
        local a6 = RequestScaleformMovie("instructional_buttons")
        while not HasScaleformMovieLoaded(a6) do
            Wait(0)
        end
        BeginScaleformMovieMethod(a6, "CLEAR_ALL")
        BeginScaleformMovieMethod(a6, "TOGGLE_MOUSE_BUTTONS")
        ScaleformMovieMethodAddParamBool(0)
        EndScaleformMovieMethod()
        for a7, a8 in ipairs(a5) do
            BeginScaleformMovieMethod(a6, "SET_DATA_SLOT")
            ScaleformMovieMethodAddParamInt(a7 - 1)
            ScaleformMovieMethodAddParamPlayerNameString(a8["button"])
            ScaleformMovieMethodAddParamTextureNameString(a8["label"])
            EndScaleformMovieMethod()
        end
        BeginScaleformMovieMethod(a6, "DRAW_INSTRUCTIONAL_BUTTONS")
        ScaleformMovieMethodAddParamInt(-1)
        EndScaleformMovieMethod()
        while c do
            Wait(0)
            DrawScaleformMovieFullscreen(a6, 255, 255, 255, 255)
        end
        o = false
    end)
end
