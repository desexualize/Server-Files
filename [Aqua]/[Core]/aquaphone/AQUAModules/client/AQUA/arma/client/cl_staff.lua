usingDelgun = false
local a = false
local c = function(d)
    local e = {}
    local f = GetGameTimer() / 200
    e.r = math.floor(math.sin(f * d + 0) * 127 + 128)
    e.g = math.floor(math.sin(f * d + 2) * 127 + 128)
    e.b = math.floor(math.sin(f * d + 4) * 127 + 128)
    return e
end
RegisterCommand("delgun",function()
    if tARMA.getStaffLevel() > 0 then
        usingDelgun = not usingDelgun
        local g = tARMA.getPlayerPed()
        local h = "WEAPON_STAFFGUN"
        if usingDelgun then
            a = HasPedGotWeapon(g, h, false)
            tARMA.allowWeapon(h)
            GiveWeaponToPed(g, h, nil, false, true)
            Citizen.CreateThread(function()
                while usingDelgun do
                    Citizen.Wait(0)
                    drawNativeText("~b~Aim ~w~at an object and press ~b~Enter ~w~to delete it. ~r~Have fun!")
                end
            end)
            tARMA.drawNativeNotification("Don't forget to use ~b~/delgun ~w~to disable the delete gun!")
        else
            if not a then
                RemoveWeaponFromPed(g, h)
            end
            a = false
        end
    end
end)

RegisterNetEvent("ARMA:returnObjectDeleted",function(i)
    drawNativeNotification(i)
end)

local j = 0
function func_staffDelGun(k)
    if usingDelgun then
        SetPlayerTargetingMode(2)
        j = j + 1
        if j > 1000 then
            j = 0
        end
        DisableControlAction(1, 18, true)
        DisablePlayerFiring(PlayerId(), true)
        if IsPlayerFreeAiming(PlayerId()) then
            local l, m = GetEntityPlayerIsFreeAimingAt(PlayerId())
            if l then
                local n = GetEntityType(m)
                local o = true
                if o then
                    local p = GetEntityCoords(m)
                    local q = c(0.5)
                    DrawMarker(1,p.x,p.y,p.z - 1.02,0,0,0,0,0,0,0.7,0.7,1.5,q.r,q.g,q.b,200,0,0,2,0,0,0,0)
                    if IsDisabledControlJustPressed(1, 18) then
                        local r = NetworkGetNetworkIdFromEntity(m)
                        TriggerServerEvent("ARMA:delGunDelete", r)
                        if GetEntityType(m) == 2 then
                            SetEntityAsMissionEntity(m, false, true)
                            DeleteVehicle(m)
                        end
                    end
                end
            end
        end
    end
end
RegisterNetEvent("ARMA:deletePropClient",function(r)
    local s = tARMA.getObjectId(r)
    if DoesEntityExist(s) then
        DeleteEntity(s)
    end
end)
tARMA.createThreadOnTick(func_staffDelGun)
local t = {}
function tARMA.isLocalPlayerHidden()
    if t[tARMA.getUserId()] then
        return true
    else
        return false
    end
end
function tARMA.isUserHidden(u)
    if t[u] and tARMA.getUserId() ~= u then
        return true
    else
        return false
    end
end
RegisterNetEvent("ARMA:setHiddenUsers",function(v)
    t = v
end)