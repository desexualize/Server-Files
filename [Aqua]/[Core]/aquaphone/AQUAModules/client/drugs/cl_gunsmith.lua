local InRangeGather = false
local InRangeProcess = false
local InRangeSell = false
local InRangeSell3D = false
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(500)
    -- [Diamond Gather] --
    if IsPlayerNearCoords(vector3(cfgdrugs.Diamond.Gather.x,cfgdrugs.Diamond.Gather.y,cfgdrugs.Diamond.Gather.z), 40.0) then
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
                AQUAcfgdrugsServer.DiamondGather()
                Action = false
              else
                AQUA.notify({"~d~How the fuck are you supposed to gather sitting in that thing?"})
              end
            end
          end
        end)
      end
    else
      InRangeGather = false
    end

    -- [Diamond Process] --

    if IsPlayerNearCoords(vector3(cfgdrugs.Diamond.Process.x,cfgdrugs.Diamond.Process.y,cfgdrugs.Diamond.Process.z), 60.0) then
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
              AQUAcfgdrugsServer.DiamondCanProcess({}, function(canProcess, ketAmount)
                if canProcess and ketAmount then
                  local pid = PlayerPedId()


                  Citizen.Wait(1)

                  AQUAcfgdrugsServer.DiamondDoneProcessing()
                  AQUA.notify({"~w~Processed~g~ Diamond~w~ 1."})
                  Action = false

                end
                if not canProcess then
                  AQUA.notify({"~d~You do not have the required license."})
                  else
                    if not ketAmount then
                      AQUA.notify({"~d~You do not have enough Diamond Crystals."})
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



    
  

    if IsPlayerNearCoords(vector3(cfgdrugs.Diamond.Sell.x,cfgdrugs.Diamond.Sell.y,cfgdrugs.Diamond.Sell.z), 100.0) then
      if not InRangeSell3D then
        InRangeSell3D = true
        Citizen.CreateThread(function()
          while InRangeSell3D do

            Citizen.Wait(0)

            DrawMarker(2, cfgdrugs.Diamond.Sell.x,cfgdrugs.Diamond.Sell.y,cfgdrugs.Diamond.Sell.z+1 - 0.98, 0, 0, 0, 0, 0, 0, 0.3, 0.3, 0.3, 0, 191, 255, 150, true, true, 0, 0, 0, 0, 0)

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

            local v1 = vector3(2448.0822753906,4990.8056640625,46.542667388916)

            if isInMenu == false then

            if isInArea(v1, 1.4) then 
                alert('Press ~INPUT_VEH_HORN~ to access ~d~Diamond Seller')
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

RMenu.Add('DiamondMenu', 'Diamond Seller', RageUI.CreateMenu("", "Diamond Seller", 1300, 50, "banners", "Diamond"))

RageUI.CreateWhile(1.0, RMenu:Get('DiamondMenu', 'Diamond Seller'):SetPosition(1300, 50), nil, function()
  RageUI.IsVisible(RMenu:Get('DiamondMenu', 'Diamond Seller'), true, false, true, function()
      RageUI.ButtonWithStyle("Sell Diamond" , nil, {RightLabel = "~g~£10,000"}, true, function(Hovered, Active, Selected)

        if Selected then
            sellingDiamondUnits()
        end
      end)
  
  end, function() end)
  
end)

function sellingDiamondUnits()
     AQUAcfgdrugsServer.SellDiamondJob({tonumber(1)})
    return false
end

function isInArea(v, dis) 
    
  if #(GetEntityCoords(PlayerPedId(-1)) - v) <= dis then  
      return true
  else 
      return false
  end
end


