local a = module("cfg/cfg_stretcher")
local b = false
local c = 0
local d = nil
local e = 1
local function f(g, h)
    local i = tARMA.getPlayerCoords()
    local j = 0
    local k = g
    for l, m in pairs(GetGamePool("CVehicle")) do
        local n = GetEntityModel(m)
        if h[n] then
            local o = GetEntityCoords(m)
            local p = #(i - o)
            if p < k then
                k = p
                j = m
            end
        end
    end
    return j
end
local function q()
    if IsControlJustReleased(0, 299) then
        if NetworkHasControlOfEntity(c) then
            TriggerServerEvent("ARMA:toggleAmbulanceDoors", tARMA.getNetId(c, "Stretchers"))
        else
            if GetVehicleDoorAngleRatio(c, 4) ~= 0 or GetVehicleDoorAngleRatio(c, 3) ~= 0 and globalNHSOnDuty then
                SetVehicleDoorShut(c, 3, false)
                Wait(500)
                SetVehicleDoorShut(c, 4, false)
                tARMA.notify("Door closed.")
            else
                SetVehicleDoorOpen(c, 4, false, false)
                Wait(500)
                SetVehicleDoorOpen(c, 3, false, false)
                tARMA.notify("Door opened.")
            end
        end
    end
end
local function r(s)
    BeginTextCommandDisplayHelp("STRING")
    AddTextEntry("STRETCHER_HELP_TEXT", s)
    AddTextComponentSubstringTextLabel("STRETCHER_HELP_TEXT")
    EndTextCommandDisplayHelp(0, false, false, 0)
end
local function t(u, v)
    AddTextEntry("instructionalText", u)
    SetFloatingHelpTextWorldPosition(1, v)
    SetFloatingHelpTextStyle(0, 2, 2, -1, 2, 0)
    BeginTextCommandDisplayHelp("instructionalText")
    AddTextComponentSubstringPlayerName(u)
    EndTextCommandDisplayHelp(2, false, false, -1)
end
Citizen.CreateThread(function()
    while true do
        Wait(750)
        d = f(6.0, a.stretcherModels)
    end
end)
local function w(x)
    DetachEntity(x, false, false)
    b = false
    e = 1
    SetVehicleEngineOn(d, 0, 1, 1)
    ClearPedTasksImmediately(x)
    PlaceObjectOnGroundProperly(x)
end
local function y(z)
    for l, A in pairs(GetActivePlayers()) do
        local B = GetPlayerPed(A)
        if GetEntityAttachedTo(B) == z then
            return true
        end
    end
    return false
end
local function C(D, E)
    local x = PlayerPedId()
    if not y(D) or b then
        b = true
        SetVehicleEngineOn(D, 1, 1, 1)
        if E then
            e = E
        end
        if e == 3 then
            e = 1
        else
            e = e + 1
        end
        local F = a.positions[e]
        tARMA.loadAnimDict(a.positions[e].animDict)
        DetachEntity(x, false, false)
        AttachEntityToEntity(x,D,x,F.offset.x,F.offset.y,F.offset.z,0.0,0.0,F.offset.heading,0.0,false,false,false,false,2)
        TaskPlayAnim(x, F.animDict, F.animName, 8.0, 8.0, -1, 1, 0, false, false, false)
        RemoveAnimDict(a.positions[e].animDict)
    end
end
Citizen.CreateThread(function()
    DecorRegister("has_stretcher_inside", 2)
    DecorRegister("inside_ambulance_netid", 3)
    while true do
        Wait(0)
        local x = tARMA.getPlayerPed()
        if b then
            DisableControlAction(0, 24, true)
            DisableControlAction(0, 25, true)
            if GetEntityAttachedTo(x) == 0 then
                w(x)
            else
                r("Press ~INPUT_FRONTEND_RDOWN~ to change position.\nPress ~INPUT_CELLPHONE_CANCEL~ to get up.")
            end
        end
        if d ~= nil and d ~= 0 then
            local G = GetEntityCoords(d)
            if not b and not IsEntityPlayingAnim(x, "anim@heists@box_carry@", "idle", 3) and tARMA.getPlayerVehicle() == 0 then
                if DecorGetInt(d, "inside_ambulance_netid") ~= 0 then
                    if GetVehicleDoorAngleRatio(c, 4) ~= 0 then
                        t("Press ~INPUT_PICKUP~ to push the stretcher.\nPress ~INPUT_FRONTEND_RDOWN~ to use the stretcher.",G)
                    end
                else
                    t("Press ~INPUT_PICKUP~ to push the stretcher.\nPress ~INPUT_FRONTEND_RDOWN~ to use the stretcher.",G)
                end
            end
            if IsEntityPlayingAnim(x, "anim@heists@box_carry@", "idle", 3) and c == 0 then
                local H = -1
                local I = 5.0
                for l, A in pairs(GetActivePlayers()) do
                    local B = GetPlayerPed(A)
                    if B ~= 0 then
                        local J = GetEntityHealth(B)
                        if J >= 100 and J <= 102 and GetEntityAttachedTo(B) == 0 then
                            local p = #(GetEntityCoords(B, true) - G)
                            if p < I then
                                H = A
                                I = p
                            end
                        end
                    end
                end
                local K = "Press ~INPUT_CELLPHONE_CAMERA_EXPRESSION~ to stop pushing the stretcher."
                if H ~= -1 and globalNHSOnDuty then
                    K = "Press ~INPUT_CELLPHONE_CAMERA_EXPRESSION~ to stop pushing the stretcher. Press ~INPUT_CELLPHONE_CAMERA_GRID~ to place the nearest player on."
                    if IsControlJustPressed(0, 183) then
                        local L = GetPlayerServerId(H)
                        local M = NetworkGetNetworkIdFromEntity(d)
                        if L > 0 and M ~= 0 then
                            TriggerServerEvent("ARMA:forcePlayerOnToStretcher", L, M)
                        end
                    end
                end
                r(K)
            end
            if DecorGetBool(c, "has_stretcher_inside") == 1 and globalNHSOnDuty and not IsPedInVehicle(x, c, false) and not b then
                local N = GetWorldPositionOfEntityBone(c, GetEntityBoneIndexByName(c, "bonnet"))
                DrawMarker(1,N.x,N.y,N.z - 1.75,0.0,0.0,0.0,0,0.0,0.0,3.5,3.5,3.5,0,48,135,235,false,true,2,false,false,false,false)
                q()
                r("Press ~INPUT_REPLAY_REWIND~ to open/close rear door.")
            end
            if IsControlJustReleased(0, 51) and not IsEntityPlayingAnim(x, "anim@heists@box_carry@", "idle", 3) and not b then
                if DecorGetInt(d, "inside_ambulance_netid") ~= 0 then
                    local O = tARMA.getObjectId(DecorGetInt(d, "inside_ambulance_netid"), "Stretcher Thread")
                    if GetVehicleDoorAngleRatio(O, 4) ~= 0 or IsThisModelAHeli(GetEntityModel(O)) then
                        pushStretcher(x, d)
                    end
                else
                    pushStretcher(x, d)
                end
            end
            local N = GetWorldPositionOfEntityBone(c, GetEntityBoneIndexByName(c, "bonnet"))
            if not DecorGetBool(c, "has_stretcher_inside") and IsEntityPlayingAnim(x, "anim@heists@box_carry@", "idle", 3) and not IsPedInVehicle(x, c, false) then
                DrawMarker(1,N.x,N.y,N.z - 1.75,0.0,0.0,0.0,0,0.0,0.0,3.5,3.5,3.5,0,48,135,235,false,true,2,false,false,false,false)
                q()
            end
            if IsControlJustReleased(0, 191) and not IsEntityPlayingAnim(x, "anim@heists@box_carry@", "idle", 3) then
                C(d)
            end
            if IsControlJustReleased(0, 202) and b then
                w(x)
                SetEntityCoords(x, G.x, G.y - 1.5, G.z, true, false, false, false)
            end
        end
    end
end)

function pushStretcher(x, d)
    Citizen.CreateThread(function()
        local P = NetworkGetNetworkIdFromEntity(d)
        if P == 0 then
            return
        end
        TriggerServerEvent("ARMA:stretcherAttachPlayer", P)
        AttachEntityToEntity(d,PlayerPedId(),PlayerPedId(),-0.05,1.3,-0.345,180.0,180.0,180.0,0.0,false,false,true,false,2)
        while not NetworkHasControlOfEntity(d) or not IsEntityAttachedToEntity(d, x) do
            Wait(0)
        end
        SetEntityHeading(x, GetEntityHeading(d))
        SetVehicleExtra(d, 1, 0)
        SetVehicleExtra(d, 2, 1)
        tARMA.loadAnimDict("anim@heists@box_carry@")
        local Q = 0
        while IsEntityAttachedToEntity(d, x) do
            Citizen.Wait(0)
            if not IsEntityPlayingAnim(x, "anim@heists@box_carry@", "idle", 3) then
                TaskPlayAnim(x, "anim@heists@box_carry@", "idle", 8.0, 8.0, -1, 50, 0, false, false, false)
            end
            if IsControlJustReleased(0, 73) or IsPedDeadOrDying(x) then
                ClearPedTasksImmediately(x)
                SetVehicleExtra(d, 1, 1)
                SetVehicleExtra(d, 2, 0)
                DetachEntity(d, true, false)
                SetVehicleOnGroundProperly(d)
            end
            if DecorGetInt(d, "inside_ambulance_netid") ~= 0 then
                local O = tARMA.getObjectId(DecorGetInt(d, "inside_ambulance_netid"), "pushStretcher(ped, nearbyStretcher)")
                if DecorGetBool(O, "has_stretcher_inside") ~= false then
                    if not NetworkHasControlOfEntity(O) then
                        if GetGameTimer() - Q > 200 then
                            TriggerServerEvent("ARMA:updateHasStretcherInsideDecor",tARMA.getNetId(O, "Stretchers"),false)
                            Q = GetGameTimer()
                        end
                    else
                        DecorSetBool(O, "has_stretcher_inside", false)
                    end
                end
            end
            c = f(15.0, a.ambulanceModels)
            if c ~= nil and c ~= 0 then
                if GetVehicleDoorAngleRatio(c, 4) == 0 then
                    r("Press ~INPUT_REPLAY_REWIND~ to open rear door.")
                else
                    r("Press ~INPUT_REPLAY_REWIND~ to close rear door.\nPress ~INPUT_REPLAY_FFWD~ to put the stretcher in.")
                end
                local R = DecorGetBool(c, "has_stretcher_inside")
                if not R then
                    local N = GetWorldPositionOfEntityBone(c, GetEntityBoneIndexByName(c, "bonnet"))
                    DrawMarker(1,N.x,N.y,N.z - 1.75,0.0,0.0,0.0,0,0.0,0.0,3.5,3.5,3.5,0,48,135,235,false,true,2,false,false,false,false)
                end
                if IsControlJustReleased(0, 300) and (GetVehicleDoorAngleRatio(c, 4) ~= 0 or IsThisModelAHeli(GetEntityModel(c))) and not R then
                    ClearPedTasksImmediately(x)
                    SetVehicleExtra(d, 1, 1)
                    SetVehicleExtra(d, 2, 0)
                    DetachEntity(d, true, false)
                    SetVehicleOnGroundProperly(d)
                    if IsThisModelAHeli(GetEntityModel(c)) then
                        AttachEntityToEntity(d,c,-1,0.0,0.0,0.0,0.0,0.0,0.0,false,false,false,false,0.0,true)
                    else
                        AttachEntityToEntity(d,c,GetEntityBoneIndexByName(c, "engine"),0.0,-3.0,-1.0,0.0,0.0,0.0,false,false,false,false,0.0,true)
                    end
                    if not NetworkHasControlOfEntity(c) then
                        TriggerServerEvent("ARMA:updateHasStretcherInsideDecor", tARMA.getNetId(c, "Stretcher"), true)
                    else
                        DecorSetBool(c, "has_stretcher_inside", true)
                    end
                    if not NetworkHasControlOfEntity(d) then
                        TriggerServerEvent("ARMA:updateStretcherLocation",tARMA.getNetId(d, "Stretchers"),tARMA.getNetId(c, "Stretchers"))
                    else
                        DecorSetInt(d, "inside_ambulance_netid", tARMA.getNetId(c, "Stretchers"))
                    end
                    FreezeEntityPosition(d, true)
                end
            end
        end
        RemoveAnimDict("anim@heists@box_carry@")
    end)
end
RegisterNetEvent("ARMA:stretcherAttachPlayer",function(P, S)
    if not NetworkDoesNetworkIdExist(P) then
        return
    end
    local D = NetworkGetEntityFromNetworkId(P)
    local T = GetPlayerFromServerId(S)
    if D == 0 or T == -1 then
        return
    end
    local U = GetPlayerPed(T)
    if U == 0 then
        return
    end
    AttachEntityToEntity(D, U, U, -0.05, 1.3, -0.345, 180.0, 180.0, 180.0, 0.0, false, false, true, false, 2)
end)
RegisterCommand("stretcher",function()
    if globalNHSOnDuty then
        local x = tARMA.getPlayerPed()
        local v = tARMA.getPlayerCoords()
        local g = tARMA.loadModel("trump-stretcher")
        local D = tARMA.spawnVehicle(g, v.x, v.y, v.z, GetEntityHeading(x), false, true, true)
        SetVehicleDoorsLocked(D, 2)
        SetVehicleOnGroundProperly(D)
        SetVehicleExtra(D, 7, 1)
        SetVehicleExtra(D, 6, 1)
        SetVehicleExtra(D, 5, 1)
        SetVehicleExtra(D, 3, 1)
        SetVehicleExtra(D, 1, 1)
        SetVehicleExtra(D, 2, 0)
        SetVehicleExtra(D, 11, 0)
        SetVehicleExtra(D, 12, 1)
        SetModelAsNoLongerNeeded(g)
        tARMA.notify("Stretcher created.")
    end
end,false)
RegisterCommand("removestretcher",function()
    if globalNHSOnDuty then
        local V = f(5.0, a.stretcherModels)
        if V ~= nil then
            TriggerServerEvent("ARMA:removeStretcher", tARMA.getNetId(V, "Stretchers"))
        end
    end
end,false)
RegisterNetEvent("ARMA:setStretcherInside",function(P, W)
    local D = tARMA.getObjectId(P, "ARMA:setStretcherInside")
    DecorSetInt(D, "inside_ambulance_netid", W)
end)
RegisterNetEvent("ARMA:setHasStretcherInsideDecor",function(X, Y)
    local c = tARMA.getObjectId(X, "ARMA:setHasStretcherInsideDecor")
    DecorSetBool(c, "has_stretcher_inside", Y)
end)
RegisterNetEvent("ARMA:toggleAmbulanceDoorStatus",function(X)
    local c = tARMA.getObjectId(X, "ARMA:toggleAmbulanceDoorStatus")
    if GetVehicleDoorAngleRatio(c, 4) ~= 0 or GetVehicleDoorAngleRatio(c, 3) ~= 0 then
        SetVehicleDoorShut(c, 3, false)
        Wait(500)
        SetVehicleDoorShut(c, 4, false)
    else
        SetVehicleDoorOpen(c, 4, false, false)
        Wait(500)
        SetVehicleDoorOpen(c, 3, false, false)
    end
end)
function tARMA.isUsingStretcher()
    return b
end
RegisterNetEvent("ARMA:forcePlayerOnToStretcher",function(P)
    if not NetworkDoesNetworkIdExist(P) then
        return
    end
    local D = NetworkGetEntityFromNetworkId(P)
    if D ~= 0 then
        C(D, 2)
    end
end)
