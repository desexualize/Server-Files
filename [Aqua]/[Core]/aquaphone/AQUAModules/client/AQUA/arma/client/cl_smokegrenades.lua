local a = 0
local function b()
    local c = math.random(1, 1000000)
    TriggerServerEvent("ARMA:startThrowSmokeGrenade", c)
    Citizen.Wait(100)
    local d = tARMA.getPlayerCoords()
    local e = GetClosestObjectOfType(d.x, d.y, d.z, 10.0, "w_ex_smokegrenade", false, false, false)
    if e == 0 then
        return
    end
    local f = GetGameTimer()
    while GetEntitySpeed(e) > 0.2 and GetGameTimer() - f < 6000 do
        Citizen.Wait(0)
    end
    local g = GetEntityCoords(e, true)
    TriggerServerEvent("ARMA:endThrowSmokeGrenade", c, g)
end
local function h(i)
    local j = GetSelectedPedWeapon(i.playerPed)
    if j == GetHashKey("WEAPON_SMOKEGRENADE") or j == GetHashKey("WEAPON_SMOKEGRENADEPD") then
        if GetGameTimer() - a < 4000 then
            DisableControlAction(0, 24, true)
            DisableControlAction(0, 69, true)
            DisableControlAction(0, 257, true)
        elseif IsPedShooting(i.playerPed) then
            Citizen.CreateThreadNow(b)
            a = GetGameTimer()
        end
    end
end
tARMA.createThreadOnTick(h)
local function k(l)
    if not l.isDeleted then
        tARMA.loadPtfx("core")
        UseParticleFxAsset("core")
        l.handle = StartParticleFxLoopedAtCoord("exp_grd_grenade_smoke",l.coords.x,l.coords.y,l.coords.z,0.0,0.0,0.0,2.0,false,false,false,false)
        RemoveNamedPtfxAsset("core")
    end
end
local function m(l)
    if l.handle then
        StopParticleFxLooped(l.handle, false)
        l.handle = nil
    end
end
RegisterNetEvent("ARMA:displaySmokeGrenade",function(c, g)
    local l = {coords = g, isDeleted = false}
    tARMA.createArea("smoke_" .. tostring(c),g,250.0,1000.0,k,m,function()end,l)
    Citizen.Wait(60000)
    tARMA.removeArea("smoke_" .. tostring(c))
    if l.handle then
        StopParticleFxLooped(l.handle, false)
        l.handle = nil
        l.isDeleted = true
    end
end)
