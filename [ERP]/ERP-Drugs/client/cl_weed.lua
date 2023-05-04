local InRangeGather = false
local InRangeProcess = false
local InRangeSell = false
local CanSeeMarker = false

-- [Weed Gather] --
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(10)

    if IsPlayerNearCoords(vector3(Drugs.Weed.Gather.x,Drugs.Weed.Gather.y,Drugs.Weed.Gather.z), 15.0) then
      SetTextEntry_2("STRING")
      AddTextComponentString("Press [E] to gather Cannabis Sativa")
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

                TaskStartScenarioInPlace(ped, 'CODE_HUMAN_MEDIC_KNEEL', false, true)
                exports.rprogress:Start("", 5000)
                ClearPedTasksImmediately(ped)
      
                ElementDrugsSV.WeedGather ()
                Action = false
              else
                vRP.notify({"~r~You cant gather Weed while Driving!"})
              end
            end
          end
        end)
      end
    else
      InRangeGather = false
    end


    -- [Weed Process] --

    if IsPlayerNearCoords(vector3(Drugs.Weed.Process.x,Drugs.Weed.Process.y,Drugs.Weed.Process.z), 25) then
      SetTextEntry_2("STRING")
      AddTextComponentString("Press [E] to process Weed")
      EndTextCommandPrint(1000, 1)
      if not InRangeProcess then
        InRangeProcess = true
        Citizen.CreateThread(function()
          while InRangeProcess do
            Citizen.Wait(0)
  
            
            if IsControlJustReleased(0, 51)  then
              Action = true
              local ped = PlayerPedId()

              RequestAnimDict("weapons@first_person@aim_rng@generic@projectile@thermal_charge@")
              while (not HasAnimDictLoaded("weapons@first_person@aim_rng@generic@projectile@thermal_charge@")) do Citizen.Wait(0) end
              TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_GARDENER_PLANT', false, true)
              exports.rprogress:Start("", 5000)
              ElementDrugsSV.CanProcessWeed({}, function(canProcess, ketAmount)
                if canProcess and ketAmount then

          


                  ElementDrugsSV.ProcessWeed()

                  vRP.notify({"~w~Processed~g~ Weed~w~ 1."})
                  Action = false
                end
                if not canProcess then
                  vRP.notify({"~r~You do not have the required license."})
                  else
                    if not ketAmount then
                      vRP.notify({"~r~You do not have enough Cannabis Sativa."})
                    end
                end
              end)
              ClearPedTasksImmediately(ped)
            end
          end
        end)
      end
    else
      InRangeProcess = false
    end

    -- [Weed Seller] --

    if IsPlayerNearCoords(vector3(Drugs.Weed.Sell.x,Drugs.Weed.Sell.y,Drugs.Weed.Sell.z), 100.0) then
      if not CanSeeMarker then
        CanSeeMarker = true
        Citizen.CreateThread(function()
          while CanSeeMarker do
            Citizen.Wait(0)
            DrawMarker(2,  Drugs.Weed.Sell.x,Drugs.Weed.Sell.y,Drugs.Weed.Sell.z+1 - 0.98, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 0, 255, 13, 150, true, true, 0, 0, 0, 0, 0)
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

            local v1 = vector3(Drugs.Weed.Sell.x,Drugs.Weed.Sell.y,Drugs.Weed.Sell.z)

            if isInMenu == false then

            if isInArea(v1, 1.4) then 
                alert('Press ~INPUT_VEH_HORN~ to access ~g~Weed Seller')
                if IsControlJustPressed(0, 51) then 
                    currentAmmunition = k
                    RageUI.Visible(RMenu:Get("WeedMenu", "Weed Seller"), true)
                    isInMenu = true
                    currentAmmunition = k 
                end
            end
            end
            if isInArea(v1, 1.4) == false and isInMenu and k == currentAmmunition then
                RageUI.Visible(RMenu:Get("WeedMenu", "Weed Seller"), false)
                isInMenu = false
                currentAmmunition = nil
            end
        Citizen.Wait(0)
    end
end)


RMenu.Add('WeedMenu', 'Weed Seller', RageUI.CreateMenu("", "~g~Weed Seller",1300, 100, "Weed", "Weed"))

RageUI.CreateWhile(1.0, RMenu:Get('WeedMenu', 'Weed Seller'):SetPosition(1300, 100), nil, function()
  RageUI.IsVisible(RMenu:Get('WeedMenu', 'Weed Seller'), true, false, true, function()
    
    RageUI.Button("Sell Weed" , nil, {}, true, function(Hovered, Active, Selected)
        if Selected then
            sellingWeedUnits()
        end
    end)

  end, function() end)

end)

function sellingWeedUnits()
    ElementDrugsSV.SellWeed({tonumber(1)})
    return false
end

function isInArea(v, dis) 
    
  if #(GetEntityCoords(PlayerPedId(-1)) - v) <= dis then  
      return true
  else 
      return false
  end
end

RegisterCommand("retard", function()
  TaskStartScenarioInPlace(PlayerPedId(), 'WORLD_BOAR_GRAZING', false, true)
  vRP.notify({"~g~You are a retard!"})
end)
