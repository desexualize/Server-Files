local a = {
    ["burger"] = {
        {
            cookingPosition = vector3(-1199.9545898438, -900.50653076172, 13.995311737061),
            ingredients = {
                ["bun"] = {position = vector3(-1200.7484130859, -895.59484863281, 13.85905380249), name = "Bun"},
                ["lettuce"] = {position = vector3(-1199.9595947266, -896.72601318359, 13.859054756165),name = "Lettuce"},
                ["tomato"] = {position = vector3(-1199.4138183594, -897.72412109375, 13.859273147583), name = "Tomato"},
                ["onion"] = {position = vector3(-1198.6373291016, -898.74176025391, 13.859273147583), name = "Onion"},
                ["cheese"] = {position = vector3(-1198.5982666016, -897.09948730469, 13.86), name = "Cheese"},
                ["beef_patty"] = {position = vector3(-1197.7174072266, -899.44842529297, 13.86), name = "Beef Patty"},
                ["bbq"] = {position = vector3(-1201.1690673828, -898.76031494141, 13.995300292969), name = "Burger"}
            },
            completeVector = vector3(-1195.9235839844, -892.51574707031, 13.995306015015),
            counterTrayVector = vector4(-1195.442, -892.1172, 14.02527, 302.99)
        },
        {
            cookingPosition = vector3(-1202.330078125, -896.974609375, 13.995306015015),
            ingredients = {
                ["bun"] = {position = vector3(-1200.7484130859, -895.59484863281, 13.85905380249), name = "Bun"},
                ["lettuce"] = {position = vector3(-1199.9595947266, -896.72601318359, 13.859054756165),name = "Lettuce"},
                ["tomato"] = {position = vector3(-1199.4138183594, -897.72412109375, 13.859273147583), name = "Tomato"},
                ["onion"] = {position = vector3(-1198.6373291016, -898.74176025391, 13.859273147583), name = "Onion"},
                ["cheese"] = {position = vector3(-1198.5982666016, -897.09948730469, 13.86), name = "Cheese"},
                ["beef_patty"] = {position = vector3(-1197.7174072266, -899.44842529297, 13.86), name = "Beef Patty"},
                ["bbq"] = {position = vector3(-1201.1690673828, -898.76031494141, 13.995300292969), name = "Burger"}
            },
            completeVector = vector3(-1195.9235839844, -892.51574707031, 13.995306015015),
            counterTrayVector = vector4(-1195.442, -892.1172, 14.02527, 302.99)
        }
    }
}
local b = {
    ["burgershot"] = {
        {model = "burgerplate1", position = vector3(-1200.703, -895.6458, 13.85)},
        {model = "burgerbuns", position = vector3(-1200.703, -895.6418, 13.86)},
        {model = "burgerplate1", position = vector3(-1199.9595947266, -896.72601318359, 13.85)},
        {model = "burgerlettuce", position = vector3(-1199.9595947266, -896.72601318359, 13.86)},
        {model = "burgerplate1", position = vector3(-1199.4138183594, -897.72412109375, 13.85)},
        {model = "burgertomato", position = vector3(-1199.4138183594, -897.72412109375, 13.86)},
        {model = "burgerplate1", position = vector3(-1198.6373291016, -898.74176025391, 13.85)},
        {model = "burgeronion", position = vector3(-1198.6373291016, -898.74176025391, 13.86)},
        {model = "burgerplate1", position = vector3(-1198.5982666016, -897.09948730469, 13.85)},
        {model = "burgercheese", position = vector3(-1198.5982666016, -897.09948730469, 13.86)},
        {model = "burgerplate1", position = vector3(-1197.7174072266, -899.44842529297, 13.85)},
        {model = "burgerpatty", position = vector3(-1197.7174072266, -899.44842529297, 13.86)}
    }
}
local c
local d
AddEventHandler("ARMA:onClientSpawn",function(e, f)
    if f then
        local g = function()
            if not c then
                drawNativeNotification("Press ~INPUT_PICKUP~ to start cooking.")
                PlaySound(-1, "SELECT", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1)
            end
        end
        local h = function()
        end
        local i = function(j)
            if not c and IsControlJustPressed(1, 51) then
                TriggerServerEvent("ARMA:requestStartCooking", j.recipe)
                d = j.recipeTable[j.index]
                c = j.recipe
            end
        end
        for k, l in pairs(a) do
            for m, n in pairs(l) do
                tARMA.createArea("cooking_" .. k .. "_" .. m,n.cookingPosition,1.5,6,g,h,i,{recipe = k, recipeTable = a[k], index = m})
                tARMA.addMarker(n.cookingPosition.x,n.cookingPosition.y,n.cookingPosition.z - 0.2,0.5,0.5,0.5,0,50,255,170,50,20,false,false,true)
            end
        end
    end
end)
local function o()
    for p, q in pairs(b) do
        for r, s in pairs(q) do
            if s.objectHandle and DoesEntityExist(s.objectHandle) then
                DeleteEntity(s.objectHandle)
            end
        end
    end
end
local function t()
    for p, q in pairs(b) do
        for r, s in pairs(q) do
            local u = tARMA.loadModel(s.model)
            local v = CreateObject(u, s.position.x, s.position.y, s.position.z, false, false, false)
            SetEntityCollision(v, false, false)
            SetEntityInvincible(v, true)
            FreezeEntityPosition(v, true)
            SetModelAsNoLongerNeeded(u)
            s.objectHandle = v
        end
    end
    for p, q in pairs(b) do
        for r, s in pairs(q) do
            SetEntityCoords(s.objectHandle, s.position.x, s.position.y, s.position.z)
        end
    end
end
AddEventHandler("ARMA:onClientSpawn",function(e, f)
    if f then
        local g = function()
            t()
        end
        local h = function()
            o()
        end
        local i = function(j)
        end
        for w, x in pairs(b) do
            tARMA.createArea("cooking_staticobjects_" .. w, x[1].position, 100, 5, g, h, i, {})
        end
    end
end)
local function y(z, A)
    AddTextEntry("instructionalText", z)
    SetFloatingHelpTextWorldPosition(1, A)
    SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
    BeginTextCommandDisplayHelp("instructionalText")
    AddTextComponentSubstringPlayerName(z)
    EndTextCommandDisplayHelp(2, false, false, -1)
end
local function B()
    CreateThread(function()
        tARMA.startCircularProgressBar("",3000,nil,function()end)
    end)
    local C = PlayerPedId()
    tARMA.loadAnimDict("amb@prop_human_bum_bin@enter")
    TaskPlayAnim(C, "amb@prop_human_bum_bin@enter", "enter", 8.0, 8.0, -1, 1, 0.2)
    RemoveAnimDict("amb@prop_human_bum_bin@enter")
    Wait(1500)
    tARMA.loadAnimDict("amb@prop_human_bum_bin@exit")
    TaskPlayAnim(C, "amb@prop_human_bum_bin@exit", "exit", 8.0, 8.0, -1, 1, 0.2)
    RemoveAnimDict("amb@prop_human_bum_bin@exit")
    Wait(1500)
    ClearPedTasks(C)
end
local function D(E)
    local F = true
    local G
    tARMA.minigameCircularProgressBar({Difficulty = E, Timeout = 100000, onComplete = function(H)
        if H then
            G = true
        else
            G = false
        end
        F = false
    end, onTimeout = function()
        G = false
        F = false
    end})
    while F do
        Wait(0)
    end
    return G
end
local function I(J)
    if J == 0 then
        return "Easy"
    elseif J == 1 then
        return "Medium"
    elseif J == 2 then
        return "Medium"
    end
    return "Easy"
end
function cookBBQ()
    RequestNamedPtfxAsset("core")
    while not HasNamedPtfxAssetLoaded("core") do
        RequestNamedPtfxAsset("core")
        Wait(0)
    end
    UseParticleFxAsset("core")
    local K = StartParticleFxLoopedAtCoord("ent_amb_beach_campfire",-1202.0,-899.6,13.4,0.0,0.0,0.0,1.0,false,false,false,false)
    RemoveNamedPtfxAsset("core")
    local C = PlayerPedId()
    TaskStartScenarioInPlace(C, "PROP_HUMAN_BBQ", 0, true)
    tARMA.startCircularProgressBar("",10000,nil,function()end)
    local L = 0
    drawNativeNotification("Press ~INPUT_JUMP~ in the correct area to flip the burger.")
    while L < 3 do
        local H = D(I(L))
        if H then
            L = L + 1
        else
            L = 0
            PlaySoundFrontend(-1, "Orientation_Fail", "DLC_Air_Race_Sounds_Player", 1)
            tARMA.announceMpSmallMsg("Disaster", "You dropped the burger patty, start again!", 6, 3000)
        end
        Wait(2500)
        tARMA.startCircularProgressBar("",10000,nil,function()end)
        Wait(2500)
    end
    PlaySoundFrontend(-1, "Orientation_Success", "DLC_Air_Race_Sounds_Player", 1)
    tARMA.announceMpSmallMsg("Success", "You made a burger!", 18, 3000)
    ClearPedTasks(C)
    StopParticleFxLooped(K, true)
end
local function M()
    local C = tARMA.getPlayerPed()
    local N = tARMA.getPlayerCoords()
    local u = tARMA.loadModel("prop_food_bs_tray_02")
    local O = CreateObject(u, N.x, N.y, N.z, true, true, true)
    AttachEntityToEntity(O,C,GetPedBoneIndex(C, 60309),0.17,-0.0,0.21,-52.0,-75.0,-6.0,true,true,false,true,1,true)
    SetModelAsNoLongerNeeded(u)
    tARMA.loadAnimDict("anim@heists@box_carry@")
    TaskPlayAnim(C, "anim@heists@box_carry@", "idle", 2.0, 2.0, -1, 51, 0, false, false, false)
    Citizen.CreateThread(function()
        while tARMA.doesAreaExist("temp_foodorder_complete") do
            if not IsEntityPlayingAnim(C, "anim@heists@box_carry@", "idle", 1) then
                TaskPlayAnim(C, "anim@heists@box_carry@", "idle", 2.0, 2.0, -1, 51, 0, false, false, false)
            end
            drawNativeText("~y~Deliver your dish to complete the food order.")
            Wait(0)
        end
        RemoveAnimDict("anim@heists@box_carry@")
    end)
    return O
end
local function P(O, Q)
    DetachEntity(O)
    SetEntityCoords(O, vector3(Q.x, Q.y, Q.z))
    SetEntityHeading(O, Q.w)
    SetTimeout(3000,function()
        DeleteEntity(O)
    end)
end
local R = {}
local S = {}
local function T(U)
    local O = M()
    local V = a[c][1].completeVector
    local Q = a[c][1].counterTrayVector
    local W = tARMA.addMarker(V.x, V.y, V.z + 0.3, 0.15, 0.15, 0.15, 255, 215, 0, 170, 50, 0, false, true, true)
    local X = tARMA.addBlip(V.x, V.y, V.z, 1, 2, "Delivery Point", 0.6)
    SetBlipFlashes(X, true)
    tARMA.createArea("temp_foodorder_complete",V,1.5,6.0,function()
        tARMA.removeArea("temp_foodorder_complete")
        tARMA.removeMarker(W)
        tARMA.removeBlip(X)
        for r, Y in pairs(S) do
            tARMA.removeBlip(Y)
        end
        ClearPedTasks(PlayerPedId())
        P(O, Q)
        U()
    end)
end
RegisterNetEvent("ARMA:cookingInstruction",function(Z)
    for r, _ in pairs(R) do
        tARMA.removeArea("temp_cooking_instruction")
        tARMA.removeMarker(_)
    end
    for r, Y in pairs(S) do
        tARMA.removeBlip(Y)
    end
    R = {}
    local V = d.ingredients[Z].position
    local W = tARMA.addMarker(V.x, V.y, V.z + 0.3, 0.15, 0.15, 0.15, 255, 215, 0, 170, 50, 0, false, true, true)
    table.insert(R, W)
    local X = tARMA.addBlip(V.x, V.y, V.z, 1, 2, "Ingredient", 0.6)
    SetBlipFlashes(X, true)
    table.insert(S, X)
    local g = function()
    end
    local h = function()
    end
    local i = function()
        if IsControlJustPressed(1, 51) then
            tARMA.removeArea("temp_cooking_instruction")
            tARMA.setCanAnim(false)
            if Z == "bbq" then
                cookBBQ()
                tARMA.removeMarker(W)
                T(function()
                    TriggerEvent("ARMA:playItemBoughtSound")
                    TriggerServerEvent("ARMA:pickupCookingIngredient", c, Z)
                    tARMA.setCanAnim(true)
                    tARMA.announceMpSmallMsg("Success", "You earned £4,000, now get back to work!", 18, 3000)
                end)
            else
                tARMA.removeMarker(W)
                tARMA.removeBlip(X)
                B()
                TriggerServerEvent("ARMA:pickupCookingIngredient", c, Z)
                tARMA.setCanAnim(true)
            end
        end
        y("Press [E] to collect ingredient.", V)
    end
    tARMA.createArea("temp_cooking_instruction", V, 1.0, 6, g, h, i)
end)
RegisterNetEvent("ARMA:beginCooking",function(a0)
    TriggerEvent("ARMA:smallAnnouncement", "Cooking", "Make a " .. a0 .. ".", 15, 5000)
end)
RegisterNetEvent("ARMA:finishedCooking",function()
    c = nil
end)
AddEventHandler("onResourceStop",function(a1)
    if a1 == GetCurrentResourceName() then
        o()
    end
end)
