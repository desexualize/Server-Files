local a = {active = false, id = 0, prop = 0, inVehicle = false}
local b = {
    {
        name = "CTSFO",
        model = "prop_shield_one",
        offSet = {-0.59, 0.29, 0.15},
        rotation = {0.16, 79.04, 41.39},
        boneIndex = 24818,
        collision = true,
        allowPistol = true,
        animDict = "combat@combat_reactions@pistol_1h_hillbilly",
        animName = "180"
    },
    {
        name = "Firearms",
        model = "prop_shield_two",
        offSet = {-0.59, 0.29, 0.15},
        rotation = {0.16, 79.04, 41.39},
        boneIndex = 24818,
        collision = true,
        allowPistol = true,
        animDict = "combat@combat_reactions@pistol_1h_hillbilly",
        animName = "180"
    },
    {
        name = "Long",
        model = "prop_shield_three",
        offSet = {-1.2, 0.31, -0.05},
        rotation = {1.0, 74.39, 41.39},
        boneIndex = 24818,
        collision = false,
        allowPistol = false,
        animDict = "combat@combat_reactions@pistol_1h_hillbilly",
        animName = "180"
    },
    {
        name = "Short",
        model = "prop_shield_four",
        offSet = {-0.68, 0.22, 0.15},
        rotation = {0.52, 79.28, 41.39},
        boneIndex = 24818,
        collision = true,
        allowPistol = false,
        animDict = "combat@combat_reactions@pistol_1h_hillbilly",
        animName = "180"
    }
}
local c = {
    "WEAPON_STUNGUN",
    "WEAPON_PDGLOCK",
}
Citizen.CreateThread(function()
    TriggerEvent("chat:addSuggestion", "/shield", "Use a police shield")
    while true do
        if a.active and a.id ~= 0 then
            local g = tARMA.getPlayerPed()
            if IsPedInAnyVehicle(g, true) then
                if not a.inVehicle then
                    SetEntityCollision(a.prop, false, true)
                    a.inVehicle = true
                    if not b[a.id].collision then
                        SetEntityCollision(a.prop, false, true)
                    end
                end
            else
                if a.inVehicle then
                    SetEntityCollision(a.prop, b[a.id].collision, true)
                    if not b[a.id].collision then
                        SetEntityCompletelyDisableCollision(a.prop, true, true)
                    end
                    Wait(200)
                    TaskPlayAnim(g, b[a.id].animDict, b[a.id].animName, 8.0, -8.0, -1, 50, 0.0, 0, 0, 0)
                    a.inVehicle = false
                    if not b[a.id].collision then
                        SetEntityCollision(a.prop, false, true)
                    end
                end
            end
            if not a.inVehicle then
                if b[a.id] ~= nil and b[a.id].animDict ~= nil and b[a.id].animName ~= nil then
                    if not IsEntityPlayingAnim(g, b[a.id].animDict, b[a.id].animName, 3) then
                        TaskPlayAnim(g, b[a.id].animDict, b[a.id].animName, 8.0, -8.0, -1, 50, 0.0, 0, 0, 0)
                    end
                end
                if not b[a.id].collision then
                    SetEntityCollision(a.prop, false, true)
                end
            end
            local h = GetSelectedPedWeapon(g)
            if h ~= GetHashKey("WEAPON_UNARMED") and (not b[a.id].allowPistol or not table.has(c, h)) then
                tARMA.setWeapon(g, "WEAPON_UNARMED", true)
            end
            DisableControlAction(0, 210, true)
            DisableControlAction(1, 210, true)
            DisableControlAction(0, 36, true)
            DisableControlAction(1, 36, true)
            if not b[a.id].collision then
                SetEntityCollision(a.prop, false, true)
            end
        end
        Wait(0)
    end
end)
RMenu.Add("policeshields","main",RageUI.CreateMenu("Police Shields", "~b~Shield Management", tARMA.getRageUIMenuWidth(), tARMA.getRageUIMenuHeight()))
RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('policeshields', 'main')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            for e, f in pairs(b) do
                RageUI.Button(f.name .. " Shield","Use the " .. f.name .. " Shield",{},true,function(i, j, k)
                    if k then
                        createShield(e)
                    end
                end)
            end
            if a.active then
                RageUI.Button("Remove Shield","Removes your current shield",{},true,function(i, j, k)
                    if k then
                        removeShield(true)
                    end
                end)
            end
        end)
    end
end)

RegisterNetEvent("ARMA:toggleShieldMenu",function(l)
    RageUI.Visible(RMenu:Get("policeshields", "main"), true)
end)
function removeShield(m)
    if DoesEntityExist(a.prop) then
        local g = tARMA.getPlayerPed()
        DetachEntity(a.prop)
        DeleteEntity(a.prop)
        a.id = 0
        a.active = false
        ClearPedTasks(g)
        ClearPedTasksImmediately(g)
        SetWeaponAnimationOverride(g, "Default")
        if m then
            tARMA.notify("~g~Success~w~: Shield removed")
        end
    end
end
function createShield(n)
    print('creating shield')
    local o = false
    local g = tARMA.getPlayerPed()
    local p = tARMA.getPlayerCoords()
    if a.active then
        removeShield(false)
    end
    a.id = n
    local q = tARMA.loadModel(b[n].model)
    a.prop = CreateObject(q, p.x, p.y, p.z, true, true, true)
    while not DoesEntityExist(a.prop) do
        Wait(0)
        print('shield doesnt exist')
    end
    SetModelAsNoLongerNeeded(q)
    if not b[n].collision then
        SetEntityCompletelyDisableCollision(a.prop, true, true)
    end
    SetWeaponAnimationOverride(g, "Gang1H")
    tARMA.loadAnimDict(b[n].animDict)
    TaskPlayAnim(g, b[n].animDict, b[n].animName, 8.0, -8.0, -1, 50, 0.0, 0, 0, 0)
    RemoveAnimDict(b[n].animDict)
    local r = GetPedBoneIndex(g, b[n].boneIndex)
    AttachEntityToEntity(a.prop,g,r,b[n].offSet[1],b[n].offSet[2],b[n].offSet[3],b[n].rotation[1],b[n].rotation[2],b[n].rotation[3],true,true,b[n].collision,false,1,true)
    a.active = true
end
