
  
  Citizen.CreateThread(function()
    while true do 
  
          for _, i in ipairs(GetActivePlayers()) do
            if setDrawGreenZoneUI then
                if i ~= PlayerId() then
                  local closestPlayerPedd = GetPlayerPed(i)
                  local vehh = GetVehiclePedIsIn(closestPlayerPedd, false)
                  SetEntityNoCollisionEntity(vehh, GetVehiclePedIsIn(GetPlayerPed(-1), false), true)
              
                end
              end
            
          end
  
      Citizen.Wait(1)
    end
  end)

  Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
            for _, i in ipairs(GetActivePlayers()) do
              if i ~= PlayerId() then
                  local closestPlayerPed = GetPlayerPed(i)
                  local veh = GetVehiclePedIsIn(closestPlayerPed, false)
                  SetEntityNoCollisionEntity(veh, GetPlayerPed(-1), true, false)
              
              end
            end
    end
  end)
  

  RegisterNetEvent("changeYo")
  AddEventHandler("changeYo", function(bool)
    if bool then 
      isInCityZonee = true 
    else 
    isInCityZonee =false 
    end 
  end)
  
  
  
  
  