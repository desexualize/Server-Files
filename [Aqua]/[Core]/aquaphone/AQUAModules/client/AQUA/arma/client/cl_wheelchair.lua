RegisterCommand("wheelchair",function()
    if globalNHSOnDuty then
        local a = tARMA.loadModel("prop_wheelchair_01")
        local b = CreateObject(a, GetEntityCoords(tARMA.getPlayerPed()), true)
        SetModelAsNoLongerNeeded(a)
    end
end,false)
RegisterCommand("removewheelchair",function()
    if globalNHSOnDuty then
        local b = GetClosestObjectOfType(GetEntityCoords(tARMA.getPlayerPed()), 10.0, GetHashKey("prop_wheelchair_01"))
        if DoesEntityExist(b) then
            DeleteEntity(b)
        end
    end
end,false)
Citizen.CreateThread(function()
    while true do
        local c = 500
        local d = tARMA.getPlayerPed()
        local e = GetEntityCoords(d)
        local f = tARMA.getPlayerVehicle()
        if f == 0 then
            local g = GetClosestObjectOfType(e, 3.0, GetHashKey("prop_wheelchair_01"), false)
            if DoesEntityExist(g) and NetworkGetEntityIsNetworked(g) then
                c = 0
                local h = GetEntityCoords(g)
                local i = GetEntityForwardVector(g)
                local j = h + i * -0.5
                local k = h + i * 0.3
                if #(e - j) <= 1.0 then
                    DrawText3Ds(j, "[E] Sit", 0.4)
                    if IsControlJustPressed(0, 38) then
                        SitOnWheelchair(g)
                    end
                end
                if #(e - k) <= 1.0 then
                    DrawText3Ds(k, "[E] Pick up", 0.4)
                    if IsControlJustPressed(0, 38) then
                        PickUpWheelchair(g)
                    end
                end
            end
        end
        Wait(c)
    end
end)
local function l()
    local m = GetPlayers()
    local n = -1
    local o = -1
    local p = tARMA.getPlayerPed()
    local q = GetEntityCoords(p, 0)
    for r, s in ipairs(m) do
        local t = GetPlayerPed(s)
        if t ~= p then
            local u = GetEntityCoords(GetPlayerPed(s), 0)
            local v = Vdist(u["x"], u["y"], u["z"], q["x"], q["y"], q["z"])
            if n == -1 or n > v then
                o = s
                n = v
            end
        end
    end
    return o, n
end
local w = 0
function SitOnWheelchair(x)
    local o, y = l()
    if o ~= nil and y <= 1.5 then
        if IsEntityPlayingAnim(GetPlayerPed(o), "missfinale_c2leadinoutfin_c_int", "_leadin_loop2_lester", 3) then
            ShowNotification("Somebody is already using the wheelchair!")
            return
        end
    end
    LoadAnim("missfinale_c2leadinoutfin_c_int")
    AttachEntityToEntity(tARMA.getPlayerPed(), x, 0, 0, 0.0, 0.4, 0.0, 0.0, 180.0, 0.0, false, false, false, false, 2)
    local z = GetEntityHeading(x)
    while IsEntityAttachedToEntity(tARMA.getPlayerPed(), x) do
        Citizen.Wait(5)
        if IsPedDeadOrDying(tARMA.getPlayerPed()) then
            DetachEntity(tARMA.getPlayerPed(), true, true)
        end
        if not IsEntityPlayingAnim(tARMA.getPlayerPed(), "missfinale_c2leadinoutfin_c_int", "_leadin_loop2_lester", 3) then
            TaskPlayAnim(tARMA.getPlayerPed(),"missfinale_c2leadinoutfin_c_int","_leadin_loop2_lester",8.0,8.0,-1,69,1,false,false,false)
        end
        local A = false
        if IsControlPressed(0, 32) then
            local B, C, D = table.unpack(GetEntityCoords(x) + GetEntityForwardVector(x) * -0.02)
            SetEntityCoords(x, B, C, D)
            PlaceObjectOnGroundProperly(x)
            A = true
        end
        if IsControlPressed(1, 34) then
            z = z + 0.4
            if z > 360 then
                z = 0
            end
            SetEntityHeading(x, z)
            A = true
        end
        if IsControlPressed(1, 9) then
            z = z - 0.4
            if z < 0 then
                z = 360
            end
            SetEntityHeading(x, z)
            A = true
        end
        if IsControlJustPressed(0, 73) or IsControlJustPressed(0, 177) then
            DetachEntity(tARMA.getPlayerPed(), true, true)
            local B, C, D = table.unpack(GetEntityCoords(x) + GetEntityForwardVector(x) * -0.7)
            SetEntityCoords(tARMA.getPlayerPed(), B, C, D)
            A = true
        end
        if A and not NetworkHasControlOfEntity(x) and GetGameTimer() - w >= 200 then
            local E = NetworkGetNetworkIdFromEntity(x)
            if E > 0 then
                TriggerServerEvent("ARMA:syncWheelchairPosition", E, GetEntityCoords(x, true), GetEntityHeading(x))
                w = GetGameTimer()
            end
        end
    end
    ClearPedTasks(PlayerPedId())
    RemoveAnimDict("missfinale_c2leadinoutfin_c_int")
end
function PickUpWheelchair(x)
    local o, y = l()
    if o ~= nil and y <= 1.5 then
        if IsEntityPlayingAnim(GetPlayerPed(o), "anim@heists@box_carry@", "idle", 3) then
            ShowNotification("Somebody is already driving the wheelchair!")
            return
        end
    end
    local F = NetworkGetNetworkIdFromEntity(x)
    if F == 0 then
        return
    end
    TriggerServerEvent("ARMA:wheelchairAttachPlayer", F)
    while not NetworkHasControlOfEntity(x) or not IsEntityAttachedToEntity(x, tARMA.getPlayerPed()) do
        Wait(0)
    end
    LoadAnim("anim@heists@box_carry@")
    Wait(0)
    while IsEntityAttachedToEntity(x, tARMA.getPlayerPed()) do
        Citizen.Wait(5)
        if not IsEntityPlayingAnim(tARMA.getPlayerPed(), "anim@heists@box_carry@", "idle", 3) then
            TaskPlayAnim(tARMA.getPlayerPed(), "anim@heists@box_carry@", "idle", 8.0, 8.0, -1, 50, 0, false, false, false)
        end
        if IsPedDeadOrDying(tARMA.getPlayerPed()) then
            DetachEntity(x, true, true)
        end
        if IsControlJustPressed(0, 73) or IsControlJustPressed(0, 177) then
            DetachEntity(x, true, true)
        end
    end
    ClearPedTasks(PlayerPedId())
    RemoveAnimDict("anim@heists@box_carry@")
end
RegisterNetEvent("ARMA:wheelchairAttachPlayer",function(F, G)
    if not NetworkDoesNetworkIdExist(F) then
        return
    end
    local b = NetworkGetEntityFromNetworkId(F)
    local H = GetPlayerFromServerId(G)
    if b == 0 or H == -1 then
        return
    end
    local I = GetPlayerPed(H)
    if I == 0 then
        return
    end
    AttachEntityToEntity(b,I,GetPedBoneIndex(I, 28422),-0.00,-0.3,-0.73,195.0,180.0,180.0,0.0,false,false,true,false,2)
end)
function DrawText3Ds(J, K, L)
    local B, C, D = J.x, J.y, J.z
    local M, N, O = GetScreenCoordFromWorldCoord(B, C, D)
    local P, Q, R = table.unpack(GetFinalRenderedCamCoord())
    SetTextScale(L, L)
    SetTextFont(4)
    SetTextProportional(1)
    BeginTextCommandDisplayText("STRING")
    SetTextCentre(1)
    SetTextColour(255, 255, 255, 215)
    AddTextComponentSubstringPlayerName(K)
    EndTextCommandDisplayText(N, O)
    local S = string.len(K) / 370
    DrawRect(N, O + 0.0150, 0.030 + S, 0.025, 41, 11, 41, 100)
end
function LoadAnim(T)
    if not HasAnimDictLoaded(T) then
        RequestAnimDict(T)
        while not HasAnimDictLoaded(T) do
            Wait(0)
        end
    end
end
function ShowNotification(U)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringWebsite(U)
    EndTextCommandThefeedPostTicker(false, true)
end
