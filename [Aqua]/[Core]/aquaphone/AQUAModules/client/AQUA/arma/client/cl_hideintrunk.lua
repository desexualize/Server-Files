local a = {
    [0] = true,
    [1] = true,
    [2] = true,
    [3] = true,
    [4] = true,
    [5] = true,
    [6] = true,
    [9] = true,
    [11] = true,
    [12] = true,
    [17] = true,
    [18] = true
}
local function b(vehicle)
    local c = GetActivePlayers()
    local d = tARMA.getPlayerCoords()
    for e, f in pairs(c) do
        local g = GetPlayerPed(f)
        local h = GetEntityCoords(g)
        local i = #(d - h)
        if i < 5 and IsEntityPlayingAnim(g, "timetable@floyd@cryingonbed@base", "base", 3) then
            return true
        end
    end
    return false
end
local j = false
function tARMA.isPlayerHidingInBoot()
    return j
end
local function k(vehicle, l)
    if tARMA.isHandcuffed() or tARMA.isTazed() then
        return false
    end
    local m = GetEntitySpeed(PlayerPedId())
    local n = GetEntitySpeed(vehicle)
    if m > 1.0 or n > 2.5 then
        return false
    end
    if l and #(tARMA.getPlayerCoords() - l) > 1.0 then
        return false
    end
    return true
end
Citizen.CreateThread(
    function()
        local o = 250
        while true do
            Citizen.Wait(o)
            local p = tARMA.getPlayerPed()
            local q = tARMA.getPlayerVehicle()
            local r = tARMA.getClosestVehicle(7.0)
            local s = GetVehicleClass(r)
            local t = GetVehicleDoorLockStatus(r)
            if q == 0 and a[s] and GetEntityHealth(tARMA.getPlayerPed()) > 102 and not noclipActive then
                if r and r ~= 0 then
                    o = 0
                    local u = GetEntityBoneIndexByName(r, "boot")
                    local v = GetWorldPositionOfEntityBone(r, u)
                    local w = #(v - tARMA.getPlayerCoords())
                    if w < 2 then
                        DrawMarker(0,v.x,v.y,v.z,0.0,0.0,0.0,0.0,0.0,0.0,0.3,0.3,0.3,0,255,150,255,true)
                        drawNativeNotification("~s~~INPUT_VEH_PUSHBIKE_SPRINT~ to get inside the boot.")
                        if IsDisabledControlJustReleased(1, 137) and k(vehicle) then
                            if not b(vehicle) then
                                local l = tARMA.getPlayerCoords()
                                tARMA.startCircularProgressBar("",2000,nil,function()
                                end)
                                if k(vehicle, l) then
                                    if t <= 1 then
                                        tARMA.setCanAnim(false)
                                        tARMA.setWeapon(p, "WEAPON_UNARMED", true)
                                        j = true
                                        local x = GetEntityCoords(PlayerPedId())
                                        local y = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
                                        SetCamCoord(y, x)
                                        PointCamAtEntity(y, r)
                                        SetCamActive(y, true)
                                        RenderScriptCams(true, false, 0, true, true)
                                        SetVehicleDoorOpen(r, 5, false, false)
                                        RaiseConvertibleRoof(r, false)
                                        AttachEntityToEntity(p,r,-1,0.0,-2.2,0.5,0.0,0.0,0.0,false,false,false,false,20,true)
                                        ClearPedTasksImmediately(p)
                                        Wait(100)
                                        tARMA.loadAnimDict("timetable@floyd@cryingonbed@base")
                                        TaskPlayAnim(p,"timetable@floyd@cryingonbed@base","base",1.0,-1,-1,1,0,0,0,0)
                                        RemoveAnimDict("timetable@floyd@cryingonbed@base")
                                        Wait(1000)
                                        SetVehicleDoorShut(r, 5, false)
                                        DestroyCam(y, 0)
                                        RenderScriptCams(0, 0, 1, 1, 1)
                                        AttachEntityToEntity(p,r,u,0.0,0.0,-0.5,0.0,0.0,0.0,false,false,false,false,20,true)
                                        drawNativeNotification("~s~~INPUT_FRONTEND_RRIGHT~ To exit the boot.")
                                        local z = true
                                        local A = false
                                        while z and j do
                                            DisableAllControlActions(0)
                                            DisableAllControlActions(1)
                                            DisableAllControlActions(2)
                                            EnableControlAction(0, 0, true)
                                            EnableControlAction(0, 249, true)
                                            EnableControlAction(2, 1, true)
                                            EnableControlAction(2, 2, true)
                                            EnableControlAction(0, 177, true)
                                            EnableControlAction(0, 200, true)
                                            if IsDisabledControlPressed(0, 177) then
                                                if GetVehicleDoorLockStatus(r) <= 1 then
                                                    z = false
                                                else
                                                    tARMA.notify("~r~Vehicle is locked, cannot get in boot.")
                                                end
                                            end
                                            if not DoesEntityExist(r) then
                                                z = false
                                            end
                                            if GetEntityHealth(p) <= 102 then
                                                z = false
                                            end
                                            if not IsEntityPlayingAnim(p, "timetable@floyd@cryingonbed@base", "base", 3) then
                                                TaskPlayAnim(p,"timetable@floyd@cryingonbed@base","base",1.0,-1,-1,1,0,0,0,0)
                                            end
                                            Wait(0)
                                        end
                                        j = false
                                        DetachEntity(p, true, true)
                                        SetEntityVisible(p, true, true)
                                        ClearAllHelpMessages()
                                        ClearPedTasks(PlayerPedId())
                                        SetVehicleDoorOpen(r, 5, false, false)
                                        tARMA.setCanAnim(true)
                                        Wait(1000)
                                        SetVehicleDoorShut(r, 5, false)
                                    else
                                        tARMA.notify("~r~Vehicle is locked, cannot get out of boot.")
                                    end
                                else
                                    tARMA.notify("~r~You and the vehicle must remain stationary to get in.")
                                end
                            else
                                tARMA.notify("~r~Someone is already in this boot.")
                            end
                        end
                    else
                        ClearHelp(true)
                    end
                else
                    o = 250
                end
            end
        end
    end
)
RegisterNetEvent("ARMA:removeHiddenInBoot",function()
    j = false
end)
