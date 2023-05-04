local InRangeGather = false
local InRangeProcess = false
local InRangeSell = false
local InRangeSell3D = false
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(500)
    -- [Cocaine Gather] --
    if IsPlayerNearCoords(vector3(cfgdrugs.Cocaine.Gather.x,cfgdrugs.Cocaine.Gather.y,cfgdrugs.Cocaine.Gather.z), 40.0) then
      SetTextEntry_2("STRING")
      AddTextComponentString("Press [E] to collect Coca Leaves")
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
                AQUAcfgdrugsServer.CocaineGather()
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

    -- [Cocaine Process] --

    if IsPlayerNearCoords(vector3(cfgdrugs.Cocaine.Process.x,cfgdrugs.Cocaine.Process.y,cfgdrugs.Cocaine.Process.z), 60.0) then
      SetTextEntry_2("STRING")
      AddTextComponentString("Press [E] to process Coca Leaves")
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
              AQUAcfgdrugsServer.CocaineCanProcess({}, function(canProcess, ketAmount)
                if canProcess and ketAmount then
                  local pid = PlayerPedId()


                  Citizen.Wait(1)

                  AQUAcfgdrugsServer.CocaineDoneProcessing()
                  AQUA.notify({"~w~Processed~g~ Cocaine~w~ 1."})
                  Action = false

                end
                if not canProcess then
                  AQUA.notify({"~d~You do not have the required license."})
                  else
                    if not ketAmount then
                      AQUA.notify({"~d~You do not have enough Cocaine."})
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

    -- [Cocaine Seller] --



    
  

    if IsPlayerNearCoords(vector3(cfgdrugs.Cocaine.Sell.x,cfgdrugs.Cocaine.Sell.y,cfgdrugs.Cocaine.Sell.z), 100.0) then
      if not InRangeSell3D then
        InRangeSell3D = true
        Citizen.CreateThread(function()
          while InRangeSell3D do

            Citizen.Wait(0)

            DrawMarker(2, cfgdrugs.Cocaine.Sell.x,cfgdrugs.Cocaine.Sell.y,cfgdrugs.Cocaine.Sell.z+1 - 0.98, 0, 0, 0, 0, 0, 0, 0.3, 0.3, 0.3, 255, 255, 255, 150, true, true, 0, 0, 0, 0, 0)

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

            local v1 = vector3(107.24119567871,-1303.2884521484,28.768787384033)

            if isInMenu == false then

            if isInArea(v1, 1.4) then 
                alert('Press ~INPUT_VEH_HORN~ to access ~d~Cocaine Seller')
                if IsControlJustPressed(0, 51) then 
                    currentAmmunition = k
                    RageUI.Visible(RMenu:Get("CocaineMenu", "Cocaine Seller"), true)
                    isInMenu = true
                    currentAmmunition = k 
                end
            end
            end
            if isInArea(v1, 1.4) == false and isInMenu and k == currentAmmunition then
                RageUI.Visible(RMenu:Get("CocaineMenu", "Cocaine Seller"), false)
                isInMenu = false
                currentAmmunition = nil
            end
        Citizen.Wait(0)
    end
end)

RMenu.Add('CocaineMenu', 'Cocaine Seller', RageUI.CreateMenu("", "Cocaine Seller", 1300, 50))

RageUI.CreateWhile(1.0, RMenu:Get('CocaineMenu', 'Cocaine Seller'):SetPosition(1300, 50), nil, function()
  RageUI.IsVisible(RMenu:Get('CocaineMenu', 'Cocaine Seller'), true, false, true, function()
      RageUI.ButtonWithStyle("Sell Cocaine" , nil, {RightLabel = "~g~£1,500"}, true, function(Hovered, Active, Selected)

        if Selected then
            sellingCocaineUnits()
        end
      end)
  
  end, function() end)
  
end)

function sellingCocaineUnits()
     AQUAcfgdrugsServer.SellCocaineJob({tonumber(1)})
    return false
end

function isInArea(v, dis) 
    
  if #(GetEntityCoords(PlayerPedId(-1)) - v) <= dis then  
      return true
  else 
      return false
  end
end


