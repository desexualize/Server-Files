local CanSeeMarker = false

RegisterNetEvent("ERP:goParachuting")
AddEventHandler("ERP:goParachuting", function()
    if not a then
        a = true
        CreateThread(function()
            GiveWeaponToPed(PlayerPedId(), "GADGET_PARACHUTE")
            DoScreenFadeOut(3000)
            while not IsScreenFadedOut() do
                Wait(0)
            end
            playerCoords = GetEntityCoords(GetPlayerPed(-1))
            SetEntityCoords(GetPlayerPed(-1), playerCoords.x, playerCoords.y, playerCoords.z + 1000.0)
            DoScreenFadeIn(2000)
            Wait(2000)
            SetPlayerInvincible(GetPlayerPed(-1), true)
            SetEntityProofs(GetPlayerPed(-1), true, true, true, true, true, false, 0, false)
            while true do
                if a then
                    if IsPedInParachuteFreeFall(GetPlayerPed(-1)) and not HasEntityCollidedWithAnything(GetPlayerPed(-1)) then
                        ApplyForceToEntity(GetPlayerPed(-1),true,0.0,200.0,2.5,0.0,0.0,0.0,false,true,false,false,false,true)
                    else
                        a = false
                    end
                else
                    break
                end
                Wait(0)
            end
            Wait(3000)
            SetPlayerInvincible(GetPlayerPed(-1), false)
            SetEntityProofs(GetPlayerPed(-1), false, false, false, false, false, false, 0, false)
        end)
    end
end)


Citizen.CreateThread(function()
  while true do
    Citizen.Wait(500)
      if #(vec(-1653.8188476562,-1000.8563232422,13.017389297485+1 - 0.98) - GetEntityCoords(PlayerPedId())) < 100 then
      if not CanSeeMarker then
        CanSeeMarker = true
        Citizen.CreateThread(function()
          while CanSeeMarker do
            Citizen.Wait(0)
            DrawMarker(9, -1653.8188476562,-1000.8563232422,13.017389297485, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 0.8, 0.8, 0.8, 224, 224, 224, 1.0, false, false, 2, true, "dp_clothing", "parachute", false)
          end
        end)
      end
    else
      CanSeeMarker = false
    end
  end
end)

local isInMenu = false
Citizen.CreateThread(function() 
    while true do
        local v1 = vector3(-1653.8188476562,-1000.8563232422,13.017389297485)
        if isInMenu == false then
            if isInArea(v1, 1.4) then 
                alert('Press ~INPUT_VEH_HORN~ to go Parachuting ~g~[£15,000]')
                if IsControlJustPressed(0, 51) then
                    TriggerServerEvent('ERP:checkParachuteMoney')
                end
            end
        end
        Citizen.Wait(0)
    end
end)

function isInArea(v, dis) 
  if #(GetEntityCoords(PlayerPedId(-1)) - v) <= dis then  
      return true
  else 
      return false
  end
end

