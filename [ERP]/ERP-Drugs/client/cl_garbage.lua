local InRangeGather = false
local InRangeProcess = false
local InRangeSell = false
local CanSeeMarker = false

-- [Garbage Gather] --
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(500)

    if IsPlayerNearCoords(vector3(Drugs.Garbage.Gather.x,Drugs.Garbage.Gather.y,Drugs.Garbage.Gather.z), 10.0) then
      SetTextEntry_2("STRING")
      AddTextComponentString("Press [E] to Pickup Garbage")
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

                TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_GARDENER_PLANT', false, true)
                exports.rprogress:Start("", 5000)
                ClearPedTasksImmediately(ped)
      
                ElementDrugsSV.GarbageJobGather()
                Action = false
              else
                vRP.notify({"~r~You cant Pickup Garbage while Driving!"})
              end
            end
          end
        end)
      end
    else
      InRangeGather = false
    end

    if IsPlayerNearCoords(vector3(Drugs.Garbage.Sell.x,Drugs.Garbage.Sell.y,Drugs.Garbage.Sell.z), 100.0) then
      if not CanSeeMarker then
        CanSeeMarker = true
        Citizen.CreateThread(function()
          while CanSeeMarker do
            Citizen.Wait(0)
            DrawMarker(2,  Drugs.Garbage.Sell.x,Drugs.Garbage.Sell.y,Drugs.Garbage.Sell.z+1 - 0.98, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 63, 209, 0, 150, true, true, 0, 0, 0, 0, 0)
          end
        end)
      end
    else
      CanSeeMarker = false
    end
  end
end)

local isInMenu = false
local currentAmmunition = nil
Citizen.CreateThread(function() 
    while true do

            local v1 = vector3(Drugs.Garbage.Sell.x,Drugs.Garbage.Sell.y,Drugs.Garbage.Sell.z)

            if isInMenu == false then

            if isInArea(v1, 1.4) then 
                alert('Press ~INPUT_VEH_HORN~ to access ~g~Garbage Seller')
                if IsControlJustPressed(0, 51) then 
                    currentAmmunition = k
                    RageUI.Visible(RMenu:Get("GarbageMenu", "GarbageSeller"), true)
                    isInMenu = true
                    currentAmmunition = k 
                end
            end
            end
            if isInArea(v1, 1.4) == false and isInMenu and k == currentAmmunition then
                RageUI.Visible(RMenu:Get("GarbageMenu", "GarbageSeller"), false)
                isInMenu = false
                currentAmmunition = nil
            end
        Citizen.Wait(0)
    end
end)


RMenu.Add('GarbageMenu', 'GarbageSeller', RageUI.CreateMenu("", "~g~Garbage Job Seller",1300, 100, "garbage", "garbage"))

RageUI.CreateWhile(1.0, RMenu:Get('GarbageMenu', 'GarbageSeller'):SetPosition(1300, 100), nil, function()
  RageUI.IsVisible(RMenu:Get('GarbageMenu', 'GarbageSeller'), true, false, true, function()
    
    RageUI.Button("Sell Garbage" , nil, {}, true, function(Hovered, Active, Selected)
        if Selected then
          sellinggarbageUnits()
        end
    end)

  end, function() end)

end)

function sellinggarbageUnits()
    ElementDrugsSV.SellGarbageJob({tonumber(1)})
    return false
end

function isInArea(v, dis) 
    
  if #(GetEntityCoords(PlayerPedId(-1)) - v) <= dis then  
      return true
  else 
      return false
  end
end

