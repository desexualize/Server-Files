RMenu.Add("policedog","main",RageUI.CreateMenu("Dog Support Unit", "~b~Dog Management", tARMA.getRageUIMenuWidth(), tARMA.getRageUIMenuHeight()))
AddEventHandler("ARMA:setPoliceOnDuty",function(a)
    if a then
        RegisterKeyMapping("k9attack", "Police Dog Attack", "keyboard", "INSERT")
    end
end)
AddEventHandler("ARMA:setPrisonGuardOnDuty",function(b)
    if b then
        RegisterKeyMapping("k9attack", "Police Dog Attack", "keyboard", "INSERT")
    end
end)
local c = false
local d = {Follow = 1, Stay = 2, Attack = 3, Sit = 4, Trick = 5, SearchNearby = 6, Indicate = 7}
local e = {Success = 1, Error = 2, Alert = 3, Info = 4, Unknown = 5}
local f = {
    active = false,
    handle = 0,
    currentAction = d.Follow,
    insideVehicle = false,
    insideVehicleHandle = 0,
    isAttacking = false
}
local g = {
    Sit = {dict = "creatures@rottweiler@amb@world_dog_sitting@base", anims = {base = "base"}},
    TrickBeg = {dict = "creatures@dog@move", anims = {base = "beg_enter"}},
    TrickPawRight = {dict = "creatures@rottweiler@tricks@", anims = {base = "paw_right_loop"}}
}
TriggerEvent("chat:addSuggestion", "/k9", "Manage your Police Dog")
TriggerEvent("chat:addSuggestion", "/k9attack", "Start a police dog attack")
local h = "HANDLER"
local i = "K9"
local j = "K9TARGET"
RegisterNetEvent("ARMA:policeDogMenu",function()
    if globalOnPoliceDuty and tARMA.hasPoliceCallsign() then
        RMenu:Get("armascenemenu", "main"):SetSubtitle("~b~MPD~w~: " .. tARMA.getPoliceCallsign() .. " - " .. tARMA.getPoliceRank() .. " - " .. tARMA.getPoliceName())
    end
    if globalOnPrisonDuty and tARMA.hasHmpCallsign() then
        RMenu:Get("armascenemenu", "main"):SetSubtitle("~b~HMP~w~: " .. tARMA.getHmpCallsign() .. " - " .. tARMA.getHmpRank() .. " - " .. tARMA.getHmpName())
    end
    RageUI.Visible(RMenu:Get("policedog", "main"), true)
end)
RegisterNetEvent("ARMA:sendClientRagdoll",function()
    SetPedToRagdoll(tARMA.getPlayerPed(), 12000, 12000, 0, 0, 0, 0)
    showNotification("~y~~h~Alert~h~~s~: " .. "You have been bitten by a police dog.")
end)
RegisterNetEvent("ARMA:policeDogAttack",function()
    if f.active and not (f.currentAction == d.Attack) then
        selectAttackTarget()
    end
end)
local k = {"Shepherd", "Husky"}
local l = {"a_c_shepherd", "a_c_husky"}
local m = {breed = 1}
local function n()
    local o = GetResourceKvpString("arma_policedog_customisations")
    if o ~= nil and o ~= "" and o ~= "null" then
        local p = json.decode(o)
        local q = k[m.breed]
        if p[q] ~= nil then
            return p[q]
        end
    end
    return {furColour = 0, vestColour = 0, vestDesign = 0}
end
local function r(s)
    local p = {}
    local o = GetResourceKvpString("arma_policedog_customisations")
    if o ~= nil and o ~= "" and o ~= "null" then
        p = json.decode(o)
    end
    local q = k[m.breed]
    p[q] = s
    SetResourceKvp("arma_policedog_customisations", json.encode(p))
end
RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('policedog', 'main')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            if c == false then
                c = true
                showNotification(e.Info, "Press INSERT to attack another player without having the menu open.")
            end
            if not f.active then
                RageUI.List("Select Breed",k,m.breed,nil,{},true,function(t, u, v, w)
                    if v then
                        Citizen.Trace(k[w])
                    end
                    if u then
                        m.breed = w
                    end
                end)
                RageUI.Button("Create Dog","Create a police dog",{},true,function(t, u, v)
                    if v then
                        newDog(l[m.breed], k[m.breed])
                    end
                end)
            else
                if not f.insideVehicle then
                    if not (f.currentAction == d.Follow) then
                        RageUI.Button("Follow","Dog will follow you",{},true,function(t, u, v)
                            if v then
                                showNotification(e.Info, "Dog is now following.")
                                dogFollow()
                            end
                        end)
                    end
                    if not (f.currentAction == d.Stay) then
                        RageUI.Button("Stay","Dog will stay",{},true,function(t, u, v)
                            if v then
                                showNotification(e.Info, "Dog is now staying.")
                                dogStay()
                            end
                        end)
                    end
                    if not (f.currentAction == d.Sit) then
                        RageUI.Button("Sit","Dog will sit",{},true,function(t, u, v)
                            if v then
                                showNotification(e.Info, "Dog is now sitting.")
                                dogSit()
                            end
                        end)
                    end
                    if not (f.currentAction == d.Attack) then
                        RageUI.Button("Attack","Begin a dog attack",{},true,function(t, u, v)
                            if v then
                                selectAttackTarget()
                            end
                        end)
                    else
                        RageUI.Button("Stop Attack","Stop the current attack",{},true,function(t, u, v)
                            if v then
                                showNotification(e.Alert, "The attack has been cancelled.")
                                ClearPedTasks(f.handle)
                                f.currentAction = d.Follow
                                showNotification(e.Info, "Dog is now following.")
                                dogFollow()
                            end
                        end)
                    end
                else
                    RageUI.Button("Remove from vehicle","Remove the dog from the vehicle",{},true,function(t, u, v)
                        if v then
                            showNotification(e.Info, "Dog is now out of the vehicle.")
                            removeFromVehicle()
                        end
                    end)
                end
                if not f.insideVehicle then
                    RageUI.Button("Put in vehicle","Put the dog in a vehicle",{},true,function(t, u, v)
                        if v then
                            putInVehicle()
                        end
                    end)
                    RageUI.Button("Paw Trick","Perform the paw trick",{},true,function(t, u, v)
                        if v then
                            performTrick(g.TrickPawRight)
                        end
                    end)
                    RageUI.Button("Beg Trick","Perform the beg trick",{},true,function(t, u, v)
                        if v then
                            performTrick(g.TrickBeg)
                        end
                    end)
                    RageUI.Button("Search Nearby","Dog will follow and sniff close pedestrians",{},true,function(t, u, v)
                        if v then
                            showNotification(e.Info, "Dog is now searching.")
                            Citizen.CreateThread(performSearchNearby)
                        end
                    end)
                    RageUI.Button("Teleport Dog","Teleport the dog to you",{},true,function(t, u, v)
                        if v then
                            showNotification(e.Success, "Dog has now been teleported")
                            tpDog()
                        end
                    end)
                    RageUI.Button("Change Fur Colour","Cycle through colours",{},true,function(t, u, v)
                        if v then
                            local x = GetPedTextureVariation(f.handle, 0)
                            local y = GetNumberOfPedTextureVariations(f.handle, 0, 0)
                            local s = n()
                            if x + 1 < y then
                                SetPedComponentVariation(f.handle, 0, 0, x + 1, 0)
                                s.furColour = x + 1
                            elseif x + 1 == y then
                                SetPedComponentVariation(f.handle, 0, 0, 0, 0)
                                s.furColour = 0
                            end
                            r(s)
                        end
                    end)
                    if m.breed == 1 then
                        RageUI.Button("Change Vest Colour","Cycle through colours",{},true,function(t, u, v)
                            if v then
                                local x = GetPedTextureVariation(f.handle, 3)
                                local y = GetNumberOfPedTextureVariations(f.handle, 3, 0)
                                local s = n()
                                if x + 1 < y then
                                    SetPedComponentVariation(f.handle, 3, 0, x + 1, 0)
                                    s.vestColour = x + 1
                                elseif x + 1 == y then
                                    SetPedComponentVariation(f.handle, 3, 0, 0, 0)
                                    s.vestColour = 0
                                end
                                r(s)
                            end
                        end)
                        RageUI.Button("Change Vest Design","Cycle through designs",{},true,function(t, u, v)
                            if v then
                                local x = GetPedTextureVariation(f.handle, 8)
                                local y = GetNumberOfPedTextureVariations(f.handle, 8, 0)
                                local s = n()
                                if x + 1 < y then
                                    SetPedComponentVariation(f.handle, 8, 0, x + 1, 0)
                                    s.vestDesign = x + 1
                                elseif x + 1 == y then
                                    SetPedComponentVariation(f.handle, 8, 0, 0, 0)
                                    s.vestDesign = 0
                                end
                                r(s)
                            end
                        end)
                    end
                    RageUI.Button("Delete Dog","Delete the dog",{},true,function(t, u, v)
                        if v then
                            showNotification(e.Success, "Dog has now been deleted.")
                            deleteDog()
                        end
                    end)
                end
            end
        end) 
    end
end)
function tpDog()
    local z = GetEntityCoords(tARMA.getPlayerPed(), true)
    SetEntityCoords(f.handle, z.x, z.y, z.z - 1.0, 0.0, 0.0, 0.0, false)
end
function ButtonMessage(A)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentSubstringKeyboardDisplay(A)
    EndTextCommandScaleformString()
end
function Button(B)
    ScaleformMovieMethodAddParamPlayerNameString(B)
end
function setupDogScaleform(C)
    local C = RequestScaleformMovie(C)
    while not HasScaleformMovieLoaded(C) do
        Citizen.Wait(0)
    end
    BeginScaleformMovieMethod(C, "CLEAR_ALL")
    EndScaleformMovieMethod()
    BeginScaleformMovieMethod(C, "SET_CLEAR_SPACE")
    ScaleformMovieMethodAddParamInt(200)
    EndScaleformMovieMethod()
    if f.isAttacking then
        BeginScaleformMovieMethod(C, "SET_DATA_SLOT")
        ScaleformMovieMethodAddParamInt(1)
        Button(GetControlInstructionalButton(1, 178, true))
        ButtonMessage("Cancel Attack")
        EndScaleformMovieMethod()
    else
        BeginScaleformMovieMethod(C, "SET_DATA_SLOT")
        ScaleformMovieMethodAddParamInt(0)
        Button(GetControlInstructionalButton(2, 191, true))
        ButtonMessage("Select Target")
        EndScaleformMovieMethod()
        BeginScaleformMovieMethod(C, "SET_DATA_SLOT")
        ScaleformMovieMethodAddParamInt(1)
        Button(GetControlInstructionalButton(1, 178, true))
        ButtonMessage("Cancel Attack")
        EndScaleformMovieMethod()
    end
    BeginScaleformMovieMethod(C, "DRAW_INSTRUCTIONAL_BUTTONS")
    EndScaleformMovieMethod()
    BeginScaleformMovieMethod(C, "SET_BACKGROUND_COLOUR")
    ScaleformMovieMethodAddParamInt(0)
    ScaleformMovieMethodAddParamInt(0)
    ScaleformMovieMethodAddParamInt(0)
    ScaleformMovieMethodAddParamInt(80)
    EndScaleformMovieMethod()
    return C
end
local D = function(E)
    local F = {}
    local G = GetGameTimer() / 200
    F.r = math.floor(math.sin(G * E + 0) * 127 + 128)
    F.g = math.floor(math.sin(G * E + 2) * 127 + 128)
    F.b = math.floor(math.sin(G * E + 4) * 127 + 128)
    return F
end
function selectAttackTarget()
    Citizen.CreateThread(function()
        f.currentAction = d.Attack
        local C = setupDogScaleform("instructional_buttons")
        showNotification(e.Info, "Aim at the ~b~target ~s~and press ENTER to begin the attack.")
        while true do
            if f.currentAction == d.Attack then
                local H, I = GetEntityPlayerIsFreeAimingAt(PlayerId())
                if H then
                    if IsEntityAPed(I) and I ~= f.handle then
                        DrawScaleformMovieFullscreen(C, 255, 255, 255, 255, 0)
                        local J = GetEntityCoords(I, true)
                        local K = D(0.5)
                        DrawMarker(1,J.x,J.y,J.z - 1.02,0,0,0,0,0,0,0.7,0.7,1.5,K.r,K.g,K.b,200,0,0,2,0,0,0,0)
                        if IsControlJustPressed(1, 18) then
                            SetCanAttackFriendly(f.handle, true, true)
                            TaskCombatPed(f.handle, I, 0, 16)
                            f.isAttacking = true
                            C = setupDogScaleform("instructional_buttons")
                            showNotification(e.Info, "Attack has started, press ~b~DEL ~s~to stop the attack.")
                            local H = false
                            while true do
                                DrawScaleformMovieFullscreen(C, 255, 255, 255, 255, 0)
                                if H == false then
                                    local z = GetEntityCoords(I, true)
                                    local L = GetEntityCoords(f.handle, true)
                                    local M = #(L - z)
                                    if M < 2.0 then
                                        local N = GetActivePlayers()
                                        for O, P in pairs(N) do
                                            if I == GetPlayerPed(P) then
                                                local Q = GetPlayerServerId(P)
                                                TriggerServerEvent("ARMA:performDogLog","Instructed dog to attack ID: " .. Q)
                                                TriggerServerEvent("ARMA:serverDogAttack", Q)
                                                H = true
                                                Wait(1000)
                                                ClearPedTasksImmediately(f.handle)
                                                f.currentAction = d.Follow
                                                dogFollow()
                                                showNotification(e.Alert, "The attack has successfully finished.")
                                                break
                                            end
                                        end
                                    end
                                end
                                if IsControlJustPressed(1, 178) then
                                    ClearPedTasksImmediately(f.handle)
                                    showNotification(e.Alert, "You have now stopped the attack.")
                                    f.currentAction = d.Follow
                                    dogFollow()
                                    break
                                end
                                Wait(0)
                            end
                            SetCanAttackFriendly(f.handle, false, false)
                            f.isAttacking = false
                            break
                        else
                            if IsControlJustPressed(1, 178) then
                                dogFollow()
                                break
                            end
                        end
                    end
                end
            else
                break
            end
            Wait(0)
        end
    end)
end
function performTrick(R)
    f.currentAction = d.Trick
    ClearPedTasks(f.handle)
    local S = R.dict
    local T = R.anims.base
    RequestAnimDict(S)
    while not HasAnimDictLoaded(S) do
        Citizen.Wait(0)
    end
    TaskPlayAnim(f.handle, S, T, 8.0, -8.0, -1, 2, 0.0, false, false, false)
    RemoveAnimDict(S)
end
local U = {}
function performSearchNearby()
    if f.currentAction == d.SearchNearby then
        return
    end
    f.currentAction = d.SearchNearby
    while f.currentAction == d.SearchNearby and DoesEntityExist(f.handle) do
        local V = {}
        local L = GetEntityCoords(f.handle, true)
        if GetScriptTaskStatus(f.handle, "SCRIPT_TASK_FOLLOW_TO_OFFSET_OF_ENTITY") == 7 then
            TaskFollowToOffsetOfEntity(f.handle, PlayerPedId(), 0.0, 0.0, 0.0, 7.0, -1, 2.0, true)
        end
        for W, X in pairs(GetActivePlayers()) do
            local Y = GetPlayerPed(X)
            if GetVehiclePedIsUsing(Y) == 0 and IsEntityVisible(Y) and #(GetEntityCoords(Y, true) - L) < 5.0 then
                local Z = GetPlayerServerId(X)
                local _ = tARMA.clientGetUserIdFromSource(Z)
                if tARMA.getJobType(_) == "" then
                    table.insert(V, {source = Z, ped = Y})
                end
            end
        end
        if #V > 0 then
            local a0 = nil
            for W, a1 in pairs(V) do
                if not U[a1.source] then
                    a0 = a1
                    break
                end
            end
            if not a0 then
                a0 = V[math.random(1, #V)]
            end
            if not U[a0.source] then
                notify("~y~Dog is smelling a nearby pedestrian...")
                U[a0.source] = true
                Citizen.CreateThread(function()
                    Citizen.Wait(30000)
                    U[a0.source] = nil
                end)
                TaskFollowToOffsetOfEntity(f.handle, a0.ped, 0.0, 0.0, 0.0, 7.0, 4500, 1.0, false)
            end
            TriggerServerEvent("ARMA:policeDogSniffPlayer", a0.source)
        end
        Citizen.Wait(5000)
    end
end
function putInVehicle()
    local a2 = tARMA.getNearestVehicle(7.0)
    Citizen.Trace(a2)
    if a2 ~= -1 and a2 ~= nil and a2 ~= 0 then
        ClearPedTasks(f.handle)
        local a3 = GetEntityBoneIndexByName(a2, "seat_dside_r")
        if a3 == -1 then
            a3 = GetEntityBoneIndexByName(a2, "seat_pside_f")
        end
        f.currentAction = d.Sit
        dogSit()
        AttachEntityToEntity(f.handle, a2, a3, 0.0, -0.1, 0.4, 0.0, 0.0, 0.0, 0, false, false, true, 0, true)
        f.insideVehicle = true
        f.insideVehicleHandle = a2
        showNotification(e.Info, "Dog is now inside the vehicle")
    else
        showNotification(e.Error, "No nearby vehicle found.")
    end
end
function removeFromVehicle()
    if IsPedInAnyVehicle(tARMA.getPlayerPed(), true) then
        showNotification(e.Error, "You must be outside the vehicle.")
    else
        ClearPedTasks(f.handle)
        local z = GetEntityCoords(tARMA.getPlayerPed(), true)
        DetachEntity(f.handle, true, true)
        SetEntityCoords(f.handle, z.x, z.y, z.z - 1.0, 0.0, 0.0, 0.0, false)
        f.insideVehicle = false
        f.insideVehicleHandle = 0
        f.currentAction = d.Follow
        dogFollow()
    end
end
function newDog(q, a4)
    local a5 = tARMA.getPlayerPed()
    if not IsPedInAnyPoliceVehicle(a5) then
        local a6 = tARMA.loadModel(q)
        local z = GetOffsetFromEntityInWorldCoords(a5, 0.0, 1.0, 0.0)
        local a7 = GetEntityHeading(a5)
        f.handle = CreatePed(28, a6, z.x, z.y, z.z, a7, true, true)
        SetModelAsNoLongerNeeded(a6)
        Wait(2000)
        if DoesEntityExist(f.handle) then
            f.active = true
            SetBlockingOfNonTemporaryEvents(f.handle, true)
            SetPedMoveRateOverride(f.handle, 60.0)
            GiveWeaponToPed(f.handle, "WEAPON_ANIMAL", 200, true, true)
            SetCanAttackFriendly(f.handle, false, false)
            local a8 = {0, 3, 5, 46}
            for W, P in pairs(a8) do
                SetPedFleeAttributes(f.handle, P, true)
            end
            ClearPedTasks(f.handle)
            dogFollow()
            local a9 = AddBlipForEntity(f.handle)
            local aa = 61
            SetBlipSprite(a9, 526)
            SetBlipColour(a9, aa)
            SetBlipScale(a9, 1.0)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName("Police Dog")
            EndTextCommandSetBlipName(a9)
            SetBlipAsFriendly(a9, true)
            SetBlipBright(a9, true)
            local s = n()
            SetPedComponentVariation(f.handle, 0, 0, s.furColour, 0)
            SetPedComponentVariation(f.handle, 3, 0, s.vestColour, 0)
            SetPedComponentVariation(f.handle, 8, 0, s.vestDesign, 0)
            dogFollow()
            showNotification(e.Success, "Police Dog has been created. Breed: " .. a4)
            TriggerServerEvent("ARMA:performDogLog", "Created a new police dog")
        end
    end
end
function deleteDog()
    DeleteEntity(f.handle)
    f.active = false
    f.handle = 0
    TriggerServerEvent("ARMA:performDogLog", "Deleted dog")
end
function dogFollow()
    if not f.active then
        return
    end
    if f.currentAction ~= d.Follow then
        ClearPedTasks(f.handle)
        TaskFollowToOffsetOfEntity(f.handle, tARMA.getPlayerPed(), 0.0, 0.0, 0.0, 7.0, -1, 10.0, true)
        f.currentAction = d.Follow
    else
        ClearPedTasks(f.handle)
        f.currentAction = d.Follow
        TaskFollowToOffsetOfEntity(f.handle, tARMA.getPlayerPed(), 0.0, 0.0, 0.0, 7.0, -1, 10.0, true)
    end
end
function dogFollowTarget(I)
    if not f.active then
        return
    end
    ClearPedTasks(f.handle)
    TaskFollowToOffsetOfEntity(f.handle, I, 0.0, 0.0, 0.0, 0.0, -1, 0.0, true)
end
function dogStay()
    if not f.active then
        return
    end
    ClearPedTasks(f.handle)
    f.currentAction = d.Stay
end
function dogSit()
    if not f.active then
        return
    end
    ClearPedTasks(f.handle)
    local S = g.Sit.dict
    local T = g.Sit.anims.base
    RequestAnimDict(S)
    while not HasAnimDictLoaded(S) do
        Citizen.Wait(0)
    end
    TaskPlayAnim(f.handle, S, T, 8.0, -8.0, -1, 2, 0.0, false, false, false)
    RemoveAnimDict(S)
    f.currentAction = d.Sit
end
function showNotification(ab, A)
    BeginTextCommandThefeedPost("STRING")
    if ab == e.Success then
        AddTextComponentSubstringPlayerName("~g~~h~Success~h~~s~: " .. A)
    elseif ab == e.Error then
        AddTextComponentSubstringPlayerName("~r~~h~Error~h~~s~: " .. A)
    elseif ab == e.Alert then
        AddTextComponentSubstringPlayerName("~y~~h~Alert~h~~s~: " .. A)
    elseif ab == e.Unknown then
        AddTextComponentSubstringPlayerName(A)
    elseif ab == e.Info then
        AddTextComponentSubstringPlayerName("~b~~h~Info~h~~s~: " .. A)
    else
        AddTextComponentSubstringPlayerName(A)
    end
    EndTextCommandThefeedPostTicker(false, false)
end
function attackHandler(ac)
    ClearPedTasks(f.handle)
    local I = GetPlayerPed(ac)
    TaskCombatPed(f.handle, I, 0, 16)
    f.currentAction = d.Attack
end
RegisterNetEvent("ARMA:policeDogIndicate",function(ad)
    local ae = GetPlayerFromServerId(ad)
    if ae == -1 then
        return
    end
    local af = GetPlayerPed(ae)
    if af == 0 then
        return
    end
    if not f.active or not DoesEntityExist(f.handle) then
        return
    end
    if f.currentAction ~= d.SearchNearby then
        return
    end
    f.currentAction = d.Indicate
    notify("~b~Your dog starts indicating.")
    ClearPedTasks(f.handle)
    local ag = 0
    while f.currentAction == d.Indicate and DoesEntityExist(af) do
        local M = #(GetEntityCoords(af, true) - GetEntityCoords(f.handle, true))
        if M > 1.5 then
            if GetScriptTaskStatus(f.handle, "SCRIPT_TASK_FOLLOW_TO_OFFSET_OF_ENTITY") == 7 then
                TaskFollowToOffsetOfEntity(f.handle, af, 0.0, 0.0, 0.0, 7.0, -1, 2.0, true)
                ag = 0
            end
        elseif GetGameTimer() - ag > 3500 then
            if not IsEntityPlayingAnim(f.handle, g.Sit.dict, g.Sit.anims.base, 3) then
                tARMA.loadAnimDict(g.Sit.dict)
                TaskPlayAnim(f.handle, g.Sit.dict, g.Sit.anims.base, 8.0, -8.0, -1, 2, 0.0, false, false, false)
                RemoveAnimDict(g.Sit.dict)
            end
        else
            if GetScriptTaskStatus(f.handle, "SCRIPT_TASK_TURN_PED_TO_FACE_ENTITY") == 7 then
                TaskTurnPedToFaceEntity(f.handle, af, 4000)
                ag = GetGameTimer()
            end
        end
        Citizen.Wait(0)
    end
end)
