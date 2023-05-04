-- local cleanupgun = false
-- local spawncode = "WEAPON_SPEEDGUN"

-- RegisterCommand("delgun", function(source)
--      if getStaffLevel() > 0 then
--         print(getStaffLevel())
--             if cleanupgun == false then
--                 cleanupgun = true
--                 ShowNotification("~g~Entity gun has been enabled.")
--                 tAQUA.allowWeapon(spawncode)
--                 GiveWeaponToPed(PlayerPedId(), "WEAPON_SPEEDGUN", 0, true, true)
--             else
--                 cleanupgun = false
--                 ShowNotification("~d~Entity cleanup gun has been disabled.")
--                 RemoveWeaponFromPed(PlayerPedId(), "WEAPON_SPEEDGUN")
--          end
--     end
-- end)


-- Citizen.CreateThread(function()
--     while true do 
--         Wait(0)
--         if cleanupgun then 
--             if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey(spawncode) then
--                 local yes, entity = GetEntityPlayerIsFreeAimingAt(PlayerId())
--                 if yes then 
--                     if GetEntityType(entity) ~= 1 then
--                     ShowNotification("~g~Deleted an entity")
--                     DeleteEntity(entity)
--                     end
--                 end 
--             else 
--                 RemoveWeaponFromPed(PlayerPedId(), GetHashKey(spawncode))
--                 cleanupgun = false;
--                 ShowNotification("~d~Entity cleanup gun has been disabled.")
--             end 
--         end
--     end
-- end)

-- function ShowNotification(text)
--     SetNotificationTextEntry("STRING")
--     AddTextComponentString(text)
--     DrawNotification(false, false)
-- end

