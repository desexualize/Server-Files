local a = module("arma-weapons", "cfg/cfg_weaponsonback")
local b = module("arma-weapons", "cfg/weapons")
Citizen.CreateThread(function()
    for c, d in pairs(b.weapons) do
        if not a.weapons[d.hash] then
            if d.class == "SMG" then
                a.weapons[d.hash] = {bone = 58271,offset = vector3(-0.01, 0.1, -0.07),rotation = vector3(-55.0, 0.10, 0.0),model = GetHashKey(d.model),type = "SMG"}
            elseif d.class == "AR" then
                a.weapons[d.hash] = {bone = 24818,offset = vector3(-0.12, -0.12, -0.13),rotation = vector3(100.0, -3.0, 5.0),model = GetHashKey(d.model),type = "AR"}
            elseif d.class == "Heavy" or d.class == "LMG" then
                a.weapons[d.hash] = {bone = 24818,offset = vector3(-0.12, -0.12, -0.13),rotation = vector3(100.0, -3.0, 5.0),model = GetHashKey(d.model),type = "Heavy"}
            elseif d.class == "Melee" then
                a.weapons[d.hash] = {bone = 24818,offset = vector3(0.32, -0.15, 0.13),rotation = vector3(0.0, -90.0, 0.0),model = GetHashKey(d.model),type = "Melee"}
            elseif d.class == "Shotgun" then
                a.weapons[d.hash] = {bone = 24818,offset = vector3(-0.12, -0.12, -0.13),rotation = vector3(100.0, -3.0, 5.0),model = GetHashKey(d.model),type = "Shotgun"}
            end
        end
    end
end)
AddEventHandler("ARMA:setDiagonalWeapons",function()
    if not LocalPlayer.state.weaponsDiagonal then
        LocalPlayer.state:set("weaponsDiagonal", true, true)
    end
end)
AddEventHandler("ARMA:setVerticalWeapons",function()
    if LocalPlayer.state.weaponsDiagonal then
        LocalPlayer.state:set("weaponsDiagonal", nil, true)
    end
end)
AddEventHandler("ARMA:setFrontAR",function()
    if not LocalPlayer.state.frontAR then
        LocalPlayer.state:set("frontAR", true, true)
    end
end)
AddEventHandler("ARMA:setBackAR",function()
    if LocalPlayer.state.frontAR then
        LocalPlayer.state:set("frontAR", nil, true)
    end
end)
local e = {}
local f = {}
local function g()
    local h = GetSelectedPedWeapon(PlayerPedId())
    local i = tARMA.getWeapons()
    local j = false
    local k = globalOnPoliceDuty and tARMA.getPlayerVehicle() ~= 0
    for l in pairs(i) do
        local m = GetHashKey(l)
        local n = a.weapons[m]
        if n then
            local o = (not k or n.type ~= "Heavy") and (tARMA.isEmergencyService() or not isInGreenzone) and not tARMA.isPlayerInAnimalForm()
            if e[m] and not o then
                e[m] = nil
                j = true
            elseif not e[m] and m ~= h and o then
                e[m] = l
                j = true
            end
        end
    end
    for m, l in pairs(e) do
        if not i[l] or m == h then
            e[m] = nil
            j = true
        end
    end
    if j then
        local p = {}
        for m in pairs(e) do
            table.insert(p, m)
        end
        if #p > 0 then
            LocalPlayer.state:set("weapons", p, true)
        else
            LocalPlayer.state:set("weapons", nil, true)
        end
    end
end
local function q(m, r)
    local d = a.weapons[m]
    if not d then
        return 0
    end
    local s = d.offset
    local t = d.rotation
    if r.diagonal and s == vector3(-0.12, -0.12, -0.13) then
        s = vector3(0.0, -0.2, 0.0)
        t = vector3(0.0, 45.0, t.z)
    end
    if r.frontAR and d.type == "AR" then
        s = vector3(0.0, 0.18, 0.0)
        t = vector3(180.0, 148.0, 0.0)
    end
    if not HasModelLoaded(d.model) then
        RequestModel(d.model)
        return 0
    end
    local u = 0
    if d.components then
        u = CreateWeaponObject(m, 0, 0.0, 0.0, 0.0, true, 1.0, false)
        for c, v in pairs(d.components) do
            GiveWeaponComponentToWeaponObject(u, v)
        end
        if d.removeComponents then
            for c, v in pairs(d.removeComponents) do
                RemoveWeaponComponentFromWeaponObject(u, v)
            end
        end
    else
        u = CreateObject(d.model, 0.0, 0.0, 0.0, false, false, false)
    end
    AttachEntityToEntity(u,r.ped,GetPedBoneIndex(r.ped, d.bone),s.x,s.y,s.z,t.x,t.y,t.z,false,false,false,false,2,true)
    SetModelAsNoLongerNeeded(d.model)
    return u
end
local function w(r)
    for m, u in pairs(r.weapons) do
        if u ~= 0 then
            DeleteEntity(u)
            r.weapons[m] = 0
        end
    end
end
local function x(r)
    if r.ped == 0 then
        return
    end
    if not IsEntityVisible(r.ped) then
        w(r)
        return
    end
    for m, u in pairs(r.weapons) do
        if u == 0 then
            r.weapons[m] = q(m, r)
        end
    end
end
local function y()
    for z, r in pairs(f) do
        if r.playerIndex == -1 then
            r.playerIndex = GetPlayerFromServerId(z)
        end
        if r.playerIndex ~= -1 then
            for m, u in pairs(r.weapons) do
                if u ~= 0 and not IsEntityAttached(u) then
                    DeleteEntity(u)
                    r.weapons[m] = 0
                end
            end
            if r.ped == 0 or not DoesEntityExist(r.ped) then
                r.ped = GetPlayerPed(r.playerIndex)
            end
            x(r)
        end
    end
end
local A = 0
Citizen.CreateThread(function()
    while true do
        g()
        if A % 3 == 0 then
            y()
        end
        A = A + 1
        Citizen.Wait(1000)
    end
end)
RegisterNetEvent("onPlayerDropped",function(z)
    local r = f[z]
    if r then
        w(r)
        f[z] = nil
    end
end)
AddStateBagChangeHandler("weapons",nil,function(B, c, C)
    local z = tonumber(stringsplit(B, ":")[2])
    local r = f[z]
    if C == nil then
        if r then
            w(r)
            f[z] = nil
        end
        return
    end
    if r then
        for m, u in pairs(r.weapons) do
            if not table.has(C, m) then
                if u ~= 0 then
                    DeleteEntity(u)
                end
                r.weapons[m] = nil
                local d = a.weapons[m]
                if d then
                    SetModelAsNoLongerNeeded(d.model)
                end
            end
        end
        for c, m in pairs(C) do
            if not r.weapons[m] then
                r.weapons[m] = 0
            end
        end
        x(r)
    else
        local D = {}
        for c, m in pairs(C) do
            D[m] = 0
        end
        f[z] = {ped = 0,playerIndex = -1,weapons = D,diagonal = Player(z).state.weaponsDiagonal,frontAR = Player(z).state.frontAR}
    end
end)
AddStateBagChangeHandler("weaponsDiagonal",nil,function(B, c, E)
    local z = tonumber(stringsplit(B, ":")[2])
    local r = f[z]
    if r and r.diagonal ~= E then
        r.diagonal = E
        w(r)
        x(r)
    end
end)
AddStateBagChangeHandler("frontAR",nil,function(B, c, E)
    local z = tonumber(stringsplit(B, ":")[2])
    local r = f[z]
    if r and r.frontAR ~= E then
        r.frontAR = E
        w(r)
        x(r)
    end
end)
AddEventHandler("onResourceStop",function(F)
    if GetCurrentResourceName() == F then
        for c, r in pairs(f) do
            w(r)
        end
    end
end)
