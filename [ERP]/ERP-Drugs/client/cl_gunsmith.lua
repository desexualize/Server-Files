local InRangeGather = false
local InRangeProcess = false
local InRangeSell = false
local InRangeSell3D = false
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(500)
    -- [Diamond Gather] --
    if IsPlayerNearCoords(vector3(Drugs.Diamond.Gather.x,Drugs.Diamond.Gather.y,Drugs.Diamond.Gather.z), 40.0) then
      SetTextEntry_2("STRING")
      AddTextComponentString("Press [E] to collect Diamond Crystals")
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
                
                
              RequestAnimDict("weapons@first_person@aim_rng@generic@projectile@thermal_charge@")
              while (not HasAnimDictLoaded("weapons@first_person@aim_rng@generic@projectile@thermal_charge@")) do Citizen.Wait(0) end
              TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_GARDENER_PLANT', false, true)
                exports.rprogress:Start("", 5000)
                ClearPedTasksImmediately(ped)
                ElementDrugsSV.DiamondGather()
                Action = false
              else
                vRP.notify({"~r~How the fuck are you supposed to gather sitting in that thing?"})
              end
            end
          end
        end)
      end
    else
      InRangeGather = false
    end

    -- [Diamond Process] --

    if IsPlayerNearCoords(vector3(Drugs.Diamond.Process.x,Drugs.Diamond.Process.y,Drugs.Diamond.Process.z), 60.0) then
      SetTextEntry_2("STRING")
      AddTextComponentString("Press [E] to process Diamonds")
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
              TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_WELDING', false, true)

              exports.rprogress:Start("", 5000)
              ElementDrugsSV.DiamondCanProcess({}, function(canProcess, ketAmount)
                if canProcess and ketAmount then
                  local pid = PlayerPedId()


                  Citizen.Wait(1)

                  ElementDrugsSV.DiamondDoneProcessing()
                  vRP.notify({"~w~Processed~g~ Diamond~w~ 1."})
                  Action = false

                end
                if not canProcess then
                  vRP.notify({"~r~You do not have the required license."})
                  else
                    if not ketAmount then
                      vRP.notify({"~r~You do not have enough Diamond Crystals."})
                    end
                end
              end)
              ClearPedTasks(ped, true)
            end
          end
        end)
      end
    else
      InRangeProcess = false
    end

    -- [Diamond Seller] --



    
  

    if IsPlayerNearCoords(vector3(Drugs.Diamond.Sell.x,Drugs.Diamond.Sell.y,Drugs.Diamond.Sell.z), 100.0) then
      if not InRangeSell3D then
        InRangeSell3D = true
        Citizen.CreateThread(function()
          while InRangeSell3D do

            Citizen.Wait(0)

            DrawMarker(2, Drugs.Diamond.Sell.x,Drugs.Diamond.Sell.y,Drugs.Diamond.Sell.z+1 - 0.98, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 0, 191, 255, 150, true, true, 0, 0, 0, 0, 0)

          end
        end)
      end
    else
      InRangeSell3D = false
    end
  end
end)

local isInMenu = false
local currentAmmunition = nil
Citizen.CreateThread(function() 
    while true do

            local v1 = vector3(1220.6442871094,-3000.6086425781,5.8653602600098)

            if isInMenu == false then

            if isInArea(v1, 1.4) then 
                alert('Press ~INPUT_VEH_HORN~ to access ~b~Diamond Seller')
                if IsControlJustPressed(0, 51) then 
                    currentAmmunition = k
                    RageUI.Visible(RMenu:Get("DiamondMenu", "Diamond Seller"), true)
                    isInMenu = true
                    currentAmmunition = k 
                end
            end
            end
            if isInArea(v1, 1.4) == false and isInMenu and k == currentAmmunition then
                RageUI.Visible(RMenu:Get("DiamondMenu", "Diamond Seller"), false)
                isInMenu = false
                currentAmmunition = nil
            end
        Citizen.Wait(0)
    end
end)

RMenu.Add('DiamondMenu', 'Diamond Seller', RageUI.CreateMenu("", "~b~Diamond Seller", 1300, 100, "Diamond", "Diamond"))

RageUI.CreateWhile(1.0, RMenu:Get('DiamondMenu', 'Diamond Seller'):SetPosition(1300, 100), nil, function()
  RageUI.IsVisible(RMenu:Get('DiamondMenu', 'Diamond Seller'), true, false, true, function()
      RageUI.Button("Sell Diamond's" , nil, {}, true, function(Hovered, Active, Selected)

        if Selected then
            sellingDiamondUnits()
        end
      end)
  
  end, function() end)
  
end)

function sellingDiamondUnits()
     ElementDrugsSV.SellGunBody({tonumber(1)})
    return false
end

function isInArea(v, dis) 
    
  if #(GetEntityCoords(PlayerPedId(-1)) - v) <= dis then  
      return true
  else 
      return false
  end
end


