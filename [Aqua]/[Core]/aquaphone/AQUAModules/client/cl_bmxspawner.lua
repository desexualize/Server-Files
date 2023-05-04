--[[local bmxCooldown = false

Citizen.CreateThread(function() 
  while true do
  Citizen.Wait(0)
      for k, v in pairs(bmxSpawns) do
          if isInArea(v, 100.0) then 
              DrawMarker(38, v, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 89, 255, 0, 150, false, true, 0, 0, 0, 0, 0)
          end
          if isInArea(v, 1.4) then 
              TriggerEvent('AQUA:bmxSpawner')
          end
      end
  end
end)

RegisterNetEvent('AQUA:bmxSpawner')
AddEventHandler('AQUA:bmxSpawner', function()
    alert('~g~Press ~INPUT_VEH_HORN~ to spawn ~d~Taxi')
    if IsControlJustPressed(0, 51) then
      if bmxCooldown == false then

        local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 8.0, 0.5))
        veh = "taxi" 
        vehiclehash = GetHashKey(veh)
        RequestModel(vehiclehash)
        
        Citizen.CreateThread(function() 
            local waiting = 0
            while not HasModelLoaded(vehiclehash) do
                waiting = waiting + 100
                Citizen.Wait(100)
                if waiting > 5000 then
                    ShowNotification("~d~Could not load the vehicle model in time, a crash was prevented.")
                    break
                end
            end
            local vehicle = CreateVehicle(vehiclehash, x, y, z, GetEntityHeading(PlayerPedId())+90, 1, 0)
            SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
            bmxCooldown = true
          Wait(60000*1)
          bmxCooldown = false
       end)
      end
      if bmxCooldown == true then
        notify('~d~You have to wait 1 minute before you can spawn another Taxi.')
      end
    end
end)


bmxSpawns = {
  vector3(-510.4303894043,-255.00743103027,35.608993530273),
  vector3(501.21081542969,5593.5561523438,795.47351074219),
}

function isInArea(v, dis) 
    
  if #(GetEntityCoords(PlayerPedId(-1)) - v) <= dis then  
      return true
  else 
      return false
  end
end]]