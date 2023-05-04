EntityCleanupGun = false;
RegisterNetEvent("ERP:EntityCleanupGun")
AddEventHandler("ERP:EntityCleanupGun", function()
    EntityCleanupGun = not EntityCleanupGun
    if EntityCleanupGun then 
        GiveWeaponToPed(PlayerPedId(), GetHashKey('WEAPON_STAFFGUN'), 250, false, true)
        tvRP.notify("~g~Entity cleanup gun enabled.")
    else 
        tvRP.notify("~r~Entity cleanup gun disabled.")
        RemoveWeaponFromPed(PlayerPedId(), GetHashKey('WEAPON_STAFFGUN'))
    end
end)

Citizen.CreateThread(function()
    while true do 
     
        if EntityCleanupGun then 
            local plr = PlayerId()
            if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_STAFFGUN') then
                
                drawNativeText("Entity Gun Activated.", 0, 255, 0, 255, true)
                if IsPlayerFreeAiming(plr) then 
                    local yes, entity = GetEntityPlayerIsFreeAimingAt(plr)
                    if yes then 
                        tvRP.notify('~g~Deleted Entity: ' .. GetEntityModel(entity))
                        NetworkDelete(entity)
                    end
                end 
            else 
                RemoveWeaponFromPed(PlayerPedId(), GetHashKey('WEAPON_STAFFGUN'))
                EntityCleanupGun = false;
                tvRP.notify("~r~Entity cleanup gun disabled.")
            end 
        end
        Wait(0)
    end

end)



function NetworkDelete(entity)
    Citizen.CreateThread(function()
        if DoesEntityExist(entity) and not (IsEntityAPed(entity) and IsPedAPlayer(entity)) then
            NetworkRequestControlOfEntity(entity)
            local timeout = 5
            while timeout > 0 and not NetworkHasControlOfEntity(entity) do
                Citizen.Wait(1)
                timeout = timeout - 1
            end
            DetachEntity(entity, 0, false)
            SetEntityCollision(entity, false, false)
            SetEntityAlpha(entity, 0.0, true)
            SetEntityAsMissionEntity(entity, true, true)
            SetEntityAsNoLongerNeeded(entity)
            DeleteEntity(entity)
        end
    end)
end


Citizen.CreateThread(function()
    while true do
        Wait(1)
        if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey("WEAPON_STAFFGUN") then

            DisablePlayerFiring(PlayerId(), true)

        end
    end
end)