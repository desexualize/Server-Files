RegisterNetEvent("playRussianRoulette",function(f)
    local g = GetEntityCoords(tARMA.getPlayerPed())
    local h = #(g - f)
    if h <= 15 then
        SendNUIMessage({transactionType = "playRussianRoulette"})
    end
end)

RegisterNetEvent("playEmptyGun",function(f)
    local g = GetEntityCoords(tARMA.getPlayerPed())
    local h = #(g - f)
    if h <= 15 then
        SendNUIMessage({transactionType = "emptygun"})
    end
end)

math.randomseed(GetGameTimer())
RegisterCommand("russianroulette",function()
    local a = tARMA.getPlayerPed()
    if HasPedGotWeapon(a, "WEAPON_PYTHON", false) then
        if GetAmmoInPedWeapon(a, "WEAPON_PYTHON") > 0 then
            tARMA.setWeapon(a, "WEAPON_PYTHON", true)
            local b = GetEntityCoords(a)
            TriggerServerEvent("playRussianRouletteGlobally", b)
            num = math.random(1, 6)
            if not HasAnimDictLoaded("anim@weapons@first_person@aim_rng@general@pistol@revolver@str") then
                RequestAnimDict("anim@weapons@first_person@aim_rng@general@pistol@revolver@str")
                while not HasAnimDictLoaded("anim@weapons@first_person@aim_rng@general@pistol@revolver@str") do
                    Wait(1)
                end
            end
            TaskPlayAnim(a,"anim@weapons@first_person@aim_rng@general@pistol@revolver@str","reload_aim",8.0,8.0,-1,2)
            RemoveAnimDict("anim@weapons@first_person@aim_rng@general@pistol@revolver@str")
            Wait(4500)
            if not HasAnimDictLoaded("mp_suicide") then
                RequestAnimDict("mp_suicide")
                while not HasAnimDictLoaded("mp_suicide") do
                    Wait(1)
                end
            end
            if num == 1 then
                TaskPlayAnim(a, "mp_suicide", "pistol", 4.0, 0.0, -1, 0, 0.1, 0, 0, 0)
                Wait(800)
                SetPedShootsAtCoord(a, 0.0, 0.0, 0.0, 0)
                SetEntityHealth(a, 0)
            else
                local c = GetEntityCoords(a)
                local d = GetEntityHeading(a)
                TaskPlayAnim(a, "mp_suicide", "pistol", 2.0, 100.0, 500, 0, 0.1, 0, 0, 0)
                Wait(500)
                TriggerServerEvent("playEmptyGunGlobally", b)
            end
            RemoveAnimDict("mp_suicide")
            ClearPedSecondaryTask(a)
        end
    end
end)
