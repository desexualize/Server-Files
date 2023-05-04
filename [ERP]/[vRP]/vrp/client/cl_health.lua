Citizen.CreateThread(function()
  while true do 
      Wait(5)
      if b==nil then
          a2=GetPlayerServerId(PlayerId())
          b=GetEntityHealth(PlayerPedId())
      else
          if GetEntityHealth(PlayerPedId())>b and not c and a2==GetPlayerServerId(PlayerId())and a then
              if (GetEntityHealth(PlayerPedId())-b)>0 then
                  TriggerServerEvent("ERP:AnticheatBan", "Type #11", GetEntityHealth(PlayerPedId()))
                  Wait(100)
              else
                  a2=GetPlayerServerId(PlayerId())
                  b=GetEntityHealth(PlayerPedId())
              end
          end
      end
  end
end)

function tvRP.setHealth(z)
  c=true
  SetEntityHealth(GetPlayerPed(-1),z)
  Wait(100)
  c=false
end