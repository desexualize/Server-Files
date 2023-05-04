globalInBoxingZone = false
local a = {
    {pos = vector3(-50.477890014648, -1282.771484375, 29.429399490356), radius = 2},
    {pos = vector3(-575.4462890625, 286.91946411133, 94.939964294434), radius = 2},
    {pos = vector3(-294.72583007812, -1992.2838134766, 30.966064453125), radius = 4},
    {pos = vector3(-301.53894042969, 6267.5932617188, 24.484985351562), radius = 2},
    {pos = vector3(1642.041015625, 2526.7734375, 45.56485748291), radius = 8.0}
}
local b = true
local c = false
RegisterCommand("togglemelee",function()
    if tARMA.getUserId()==1 or tARMA.getUserId()==2 then 
        c = not c
        tARMA.notify('Melee Combat: '..(c and "~g~Enabled" or "~r~Disabled"))
    end 
end)
function tARMA.enablePunching(d)
    c = d
end
Citizen.CreateThread(function()
    tARMA.enablePunching(false)
    while true do
        local e = PlayerPedId()
        local f = tARMA.getPlayerVehicle()
        local g = PlayerId()
        if not globalInBoxingZone and not c then
            if GetSelectedPedWeapon(e) == GetHashKey('WEAPON_UNARMED') then
                DisableControlAction(0, 263, true)
                DisableControlAction(0, 264, true)
                DisableControlAction(0, 257, true)
                DisableControlAction(0, 140, true)
                DisableControlAction(0, 141, true)
                DisableControlAction(0, 142, true)
                DisableControlAction(0, 143, true)
                DisableControlAction(0, 24, true)
                DisableControlAction(0, 25, true)
            end
        end
        SetPedCanBeDraggedOut(e, false)
        SetPedConfigFlag(e, 149, true)
        SetPedConfigFlag(e, 438, true)
        SetPedConfigFlag(e, 250, false)
        SetPlayerTargetingMode(3)
        local h = GetSelectedPedWeapon(PlayerPedId())
        if h == GetHashKey('WEAPON_UNARMED') or h == GetHashKey('WEAPON_STAFFGUN') or GetWeapontypeGroup(h) == GetHashKey("GROUP_MELEE") then
            SetPlayerLockonRangeOverride(g, 50.0)
            SetPlayerLockon(g, true)
        else
            SetPlayerLockonRangeOverride(g, 0.0)
            SetPlayerLockon(g, false)
        end
        RestorePlayerStamina(g, 1.0)
        if f ~= 0 and b then
            if GetPedInVehicleSeat(f, 0) == e then
                if GetIsTaskActive(e, 165) then
                    SetPedIntoVehicle(e, f, 0)
                end
            end
        end
        Wait(0)
    end
end)
function disableSeatShuffle(d)
    b = d
end
AddEventHandler("ARMA:onClientSpawn",function(h, i)
    if i then
        local j = function(k)
            globalInBoxingZone = true
        end
        local l = function(k)
            globalInBoxingZone = false
        end
        local m = function(k)
        end
        for n, o in pairs(a) do
            tARMA.createArea("boxing_" .. n, o.pos, o.radius, 6, j, l, m, {})
        end
    end
end)
RegisterCommand("shuff",function(p, q, r)
    if IsPedInAnyVehicle(tARMA.getPlayerPed(), false) then
        disableSeatShuffle(false)
        Citizen.Wait(5000)
        disableSeatShuffle(true)
    else
        CancelEvent()
    end
end,false)
local s = false
local t = {
    vector3(-60.958786010742, -1291.7238769531, 29.905078887939),
    vector3(1645.5516357422, 2536.77734375, 44.564895629883)
}
AddEventHandler("ARMA:onClientSpawn",function(h, i)
    if i then
        local j = function(k)
            if not s then
                drawNativeNotification("Press ~INPUT_PICKUP~ to pick up 🥊")
            else
                drawNativeNotification("Press ~INPUT_PICKUP~ to take off 🥊")
            end
        end
        local l = function(k)
        end
        local m = function(k)
            if IsControlJustPressed(1, 51) then
                if not s then
                    putGloves()
                    s = true
                else
                    removeGloves()
                    s = false
                end
            end
        end
        for n, u in pairs(t) do
            tARMA.addMarker(u.x, u.y, u.z, 1.0, 1.0, 1.0, 0, 0, 255, 100, 50, 27, false, false, true)
            tARMA.createArea(n .. "_boxingGloves", u, 1.5, 6, j, l, m, {})
        end
    end
end)
local v = {}
function putGloves()
    local w = tARMA.getPlayerPed()
    local x = tARMA.loadModel("prop_boxing_glove_01")
    local y = GetEntityCoords(w)
    local z = CreateObject(x, y.x, y.y, y.z + 0.50, true, false, false)
    local A = CreateObject(x, y.x, y.y, y.z + 0.50, true, false, false)
    table.insert(v, z)
    table.insert(v, A)
    SetModelAsNoLongerNeeded(x)
    FreezeEntityPosition(z, false)
    SetEntityCollision(z, false, true)
    ActivatePhysics(z)
    FreezeEntityPosition(A, false)
    SetEntityCollision(A, false, true)
    ActivatePhysics(A)
    if not w then
        w = tARMA.getPlayerPed()
    end
    AttachEntityToEntity(z,w,GetPedBoneIndex(w, 0xEE4F),0.05,0.00,0.04,00.0,90.0,-90.0,true,true,false,true,1,true)
    AttachEntityToEntity(A,w,GetPedBoneIndex(w, 0xAB22),0.05,0.00,-0.04,00.0,90.0,90.0,true,true,false,true,1,true)
end
function removeGloves()
    for B, C in pairs(v) do
        DeleteObject(C)
    end
    v = {}
end
