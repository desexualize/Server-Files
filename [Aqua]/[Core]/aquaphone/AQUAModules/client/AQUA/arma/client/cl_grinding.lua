local a = false
local b = {
    ["Weed"] = {
        ["mining"] = {position = vector3(2218.0529785156, 5577.3530273438, 53.859241485596), radius = 10},
        ["processing"] = {position = vector3(1065.2957763672, -3183.2448730468, -39.163402557374), radius = 20}
    },
    ["Cocaine"] = {
        ["mining"] = {position = vector3(1542.8984375, 1725.802734375, 109.81414794922), radius = 10},
        ["processing"] = {position = vector3(1088.580078125, -3188.4384765625, -38.993461608886), radius = 10}
    },
    ["Meth"] = {
        ["mining"] = {position = vector3(1391.96484375, 3603.0559082032, 38.941928863526), radius = 2},
        ["processing"] = {position = vector3(1011.0156860352, -3196.03125, -38.993114471436), radius = 4}
    },
    ["Heroin"] = {
        ["mining"] = {position = vector3(2304.98828125, 5135.8110351563, 51.296546936035), radius = 100},
        ["processing"] = {position = vector3(1593.9248046875, 3585.1362304688, 38.964069366456), radius = 3}
    },
    ["LSD"] = {
        ["mining"] = {position = vector3(5382.7719726562, -5251.4077148438, 34.086650848389), radius = 100},
        ["processing"] = {position = vector3(-2082.3818359375, 2611.9619140625, 3.0839722156525), radius = 15},
        ["refinery"] = {position = vector3(461.9499206543, -3230.3815917969, 6.0695543289185), radius = 20}
    },
    ["Copper"] = {
        ["mining"] = {position = vector3(1917.1696777344, 3289.0961914062, 44.55207824707), radius = 50},
        ["processing"] = {position = vector3(863.66119384766, 2166.7131347656, 52.284519195556), radius = 50}
    },
    ["Limestone"] = {
        ["mining"] = {position = vector3(2957.5529785156, 2787.4877929688, 40.078433990478), radius = 50},
        ["processing"] = {position = vector3(2928.1279296875, 4304.5869140625, 50.534091949463), radius = 50}
    },
    ["Gold"] = {
        ["mining"] = {position = vector3(-593.01190185546, 2077.3544921875, 131.38098144532), radius = 10},
        ["processing"] = {position = vector3(2711.3342285156, 1519.6458740234, 24.500577926636), radius = 50}
    },
    ["Diamond"] = {
        ["mining"] = {position = vector3(382.52517700195, 2893.7443847656, 43.554821014404), radius = 100},
        ["processing"] = {position = vector3(2645.3518066406, 2814.0886230469, 33.947082519531), radius = 100}
    }
}
RegisterNetEvent("ARMA:playGrindingScenario",function(c, d)
    if not a then
        a = true
        local e = GetGameTimer()
        TaskStartScenarioInPlace(tARMA.getPlayerPed(), c, 0, true)
        local f
        if d then
            if not HasNamedPtfxAssetLoaded("core") then
                RequestNamedPtfxAsset("core")
                while not HasNamedPtfxAssetLoaded("core") do
                    Wait(0)
                end
            end
            UseParticleFxAsset("core")
            local g = GetEntityCoords(tARMA.getPlayerPed())
            f = StartParticleFxLoopedAtCoord("ent_amb_smoke_foundry",g.x,g.y,g.z - 3,0.0,0.0,0.0,1.0,false,false,false)
            RemoveNamedPtfxAsset("core")
        end
        local h = 10000
        if tARMA.isPlatClub() then
            h = 7500
        end
        CreateThread(function()
            tARMA.startCircularProgressBar("",h,nil,function()end)
        end)
        while e + h > GetGameTimer() do
            Wait(0)
        end
        ClearPedTasksImmediately(tARMA.getPlayerPed())
        if d then
            RemoveParticleFx(f)
        end
        a = false
    end
end)

RegisterNetEvent("ARMA:playGrindingPickaxe",function()
    if not a then
        a = true
        local e = GetGameTimer()
        RequestAnimDict("melee@large_wpn@streamed_core")
        while not HasAnimDictLoaded("melee@large_wpn@streamed_core") do
            Wait(0)
        end
        local i = tARMA.getPlayerPed()
        local j = tARMA.loadModel("prop_tool_pickaxe")
        local k = CreateObject(j, 0, 0, 0, true, true, true)
        AttachEntityToEntity(k,i,GetPedBoneIndex(i, 57005),0.18,-0.02,-0.02,350.0,100.00,140.0,true,true,false,true,1,true)
        SetModelAsNoLongerNeeded(j)
        local h = 10000
        if tARMA.isPlatClub() then
            h = 7500
        end
        CreateThread(function()
            tARMA.startCircularProgressBar("",h,nil,function()end)
        end)
        while e + h > GetGameTimer() do
            while IsEntityPlayingAnim(tARMA.getPlayerPed(),"melee@large_wpn@streamed_core","ground_attack_on_spot",3) == 1 do
                Wait(0)
            end
            TaskPlayAnim(i,"melee@large_wpn@streamed_core","ground_attack_on_spot",8.0,8.0,1250,80,0,0,0,0)
            Wait(0)
        end
        RemoveAnimDict("melee@large_wpn@streamed_core")
        DeleteEntity(k)
        ClearPedTasksImmediately(i)
        a = false
    else
        tARMA.notify("~r~Mining currently in progress.")
    end
end)
local l = false
local function m()
    for n, o in pairs(GetGamePool("CObject")) do
        if GetEntityModel(o) == "p_cs_clipboard" then
            SetEntityAsMissionEntity(o, false, false)
            DeleteEntity(o)
        end
    end
end
AddEventHandler("ARMA:onClientSpawn",function(p, q)
    if q then
        local r = function(s)
            s.nearby = true
            if not l then
                if s.drug == "LSD" and s.type == "mining" then
                    l = true
                end
            end
        end
        local t = function(s)
            s.nearby = false
        end
        local u = function(s)
            if s.nearby then
                if IsControlJustReleased(0, 38) and GetVehiclePedIsIn(PlayerPedId(), false) == 0 then
                    if not a then
                        m()
                        TriggerServerEvent("ARMA:requestGrinding", s.drug, s.type)
                        Wait(500)
                    else
                        tARMA.notify("~r~Action in progress, please wait.")
                    end
                end
            end
        end
        for v, w in pairs(b) do
            for x, y in pairs(w) do
                tARMA.createArea(v .. "_" .. x,y.position,y.radius,6,r,t,u,{drug = v, type = x, nearby = false})
            end
        end
    end
end)

local z = {
    vector3(-2538.2626953125, 2538.5344238281, 1.5569897890091),
    vector3(-2539.4194335938, 2539.9475097656, 1.7244160175323),
    vector3(-2538.71484375, 2543.5520019531, 1.0692403316498),
    vector3(-2533.0373535156, 2542.5346679688, 0.32451114058495),
    vector3(-2527.6525878906, 2537.4482421875, 0.56682348251343),
    vector3(-2523.6909179688, 2529.111328125, 1.4954501390457),
    vector3(-2525.0510253906, 2531.9443359375, 0.9762516617775),
    vector3(-2526.4099121094, 2525.73828125, 1.6228685379028),
    vector3(-2533.9858398438, 2521.1958007813, 3.1568129062653),
    vector3(-2543.078125, 2522.0473632813, 3.0881731510162),
    vector3(-2550.4807128906, 2524.4438476563, 3.1460916996002),
    vector3(-2553.2941894531, 2529.9609375, 2.8802394866943),
    vector3(-2530.7827148438, 2530.3264160156, 1.5112105607986),
    vector3(-2530.287109375, 2523.9948730469, 2.4006836414337),
    vector3(-2521.775390625, 2524.0747070313, 1.6176110506058)
}
Citizen.CreateThread(function()
    while not l do
        Wait(100)
    end
    local A = tARMA.loadModel("a_c_hen")
    for n, B in pairs(z) do
        local C = CreatePed(5, A, B.x, B.y, B.z, 0.0, false, true)
        SetEntityInvincible(C, true)
        SetBlockingOfNonTemporaryEvents(C, true)
    end
    SetModelAsNoLongerNeeded(A)
end)
