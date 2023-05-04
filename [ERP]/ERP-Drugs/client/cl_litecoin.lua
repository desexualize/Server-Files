local InRangeGather = false
local InRangeSell = false

-- [Litecoin Gather] --
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(500)
    local coords = vector3(Drugs.Litecoin.Gather.x,Drugs.Litecoin.Gather.y,Drugs.Litecoin.Gather.z)
    if IsPlayerNearCoords(vector3(Drugs.Litecoin.Gather.x,Drugs.Litecoin.Gather.y,Drugs.Litecoin.Gather.z), 5.0) then
      SetTextEntry_2("STRING")
      AddTextComponentString("Press [E] to mine Litecoin")
      EndTextCommandPrint(1000, 1)
      if not InRangeGather then
        InRangeGather = true
        Citizen.CreateThread(function()
          while InRangeGather do
            Citizen.Wait(0)
            if IsControlJustReleased(0, 51)  then
              if not pedinveh then
                Action = true
                local ped = PlayerPedId()
                ExecuteCommand("e type")
                exports.rprogress:Start("", 10000)
                ClearPedTasksImmediately(ped)
                ElementDrugsSV.LitecoinGather()
                Action = false
              else
                vRP.notify({"~r~You cant mine Litecoin while Driving!"})
              end
            end
          end
        end)
      end
    else
      InRangeGather = false
    end
  end
end)

local isInMenu = false
local currentAmmunition = nil
Citizen.CreateThread(function() 
    while true do
            local coords = vector3(Drugs.Litecoin.Gather.x,Drugs.Litecoin.Gather.y,Drugs.Litecoin.Gather.z)
            if isInMenu == false then

            if isInArea(coords,5.0) then
            Draw3DText(Drugs.Litecoin.Gather.x,Drugs.Litecoin.Gather.y,Drugs.Litecoin.Gather.z, 0.3, "Gather Litecoin")
            end
            
            if IsPlayerNearCoords(vector3(Drugs.Seller.Sell.x,Drugs.Seller.Sell.y,Drugs.Seller.Sell.z), 50.0) then
              DrawMarker(2,1125.865234375,-471.47802734375,66.488021850586+1 - 0.98, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 69, 97, 171, 150, true, true, 0, 0, 0, 0, 0)
            end  
        Citizen.Wait(0)
    end
end
end)

function isInArea(v, dis) 
    
  if #(GetEntityCoords(PlayerPedId(-1)) - v) <= dis then  
      return true
  else 
      return false
  end
end

function Draw3DText(x, y, z, scl_factor, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov * scl_factor
    if onScreen then
        SetTextScale(0.0, scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

Citizen.CreateThread(function()
  Citizen.Wait(500)
      ltcblip = AddBlipForCoord(Drugs.Litecoin.Gather.x,Drugs.Litecoin.Gather.y,Drugs.Litecoin.Gather.z)
      SetBlipSprite(ltcblip, 537)
      SetBlipDisplay(ltcblip, 4)
      SetBlipScale(ltcblip, 0.4)
      SetBlipAsShortRange(ltcblip, true)
      SetBlipColour(ltcblip, 3)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString("Litecoin Mine")
      EndTextCommandSetBlipName(ltcblip)
end)