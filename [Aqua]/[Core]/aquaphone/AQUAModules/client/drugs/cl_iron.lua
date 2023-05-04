local InRangeGather = false
local InRangeProcess = false
local InRangeSell = false
local InRangeSell3D = false
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(500)
    -- [Iron Gather] --
    if IsPlayerNearCoords(vector3(cfgdrugs.Iron.Gather.x,cfgdrugs.Iron.Gather.y,cfgdrugs.Iron.Gather.z), 40.0) then
      SetTextEntry_2("STRING")
      AddTextComponentString("Press [E] to collect Iron Ore")
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
                AQUAcfgdrugsServer.IronGather()
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

    -- [Iron Process] --

    if IsPlayerNearCoords(vector3(cfgdrugs.Iron.Process.x,cfgdrugs.Iron.Process.y,cfgdrugs.Iron.Process.z), 60.0) then
      SetTextEntry_2("STRING")
      AddTextComponentString("Press [E] to process Iron Ore")
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
              AQUAcfgdrugsServer.IronCanProcess({}, function(canProcess, ketAmount)
                if canProcess and ketAmount then
                  local pid = PlayerPedId()


                  Citizen.Wait(1)

                  AQUAcfgdrugsServer.IronDoneProcessing()
                  AQUA.notify({"~w~Processed~g~ Iron~w~ 1."})
                  Action = false

                end
                if not canProcess then
                  AQUA.notify({"~d~You do not have the required license."})
                  else
                    if not ketAmount then
                      AQUA.notify({"~d~You do not have enough Iron Ore."})
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

    -- [Iron Seller] --



    
  

    if IsPlayerNearCoords(vector3(cfgdrugs.Iron.Sell.x,cfgdrugs.Iron.Sell.y,cfgdrugs.Iron.Sell.z), 100.0) then
      if not InRangeSell3D then
        InRangeSell3D = true
        Citizen.CreateThread(function()
          while InRangeSell3D do

            Citizen.Wait(0)

            DrawMarker(2, cfgdrugs.Iron.Sell.x,cfgdrugs.Iron.Sell.y,cfgdrugs.Iron.Sell.z+1 - 0.98, 0, 0, 0, 0, 0, 0, 0.3, 0.3, 0.3, 0, 191, 255, 150, true, true, 0, 0, 0, 0, 0)

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

            local v1 = vector3(1069.1505126953,-3232.8176269531,5.8964853286743)

            if isInMenu == false then

            if isInArea(v1, 1.4) then 
                alert('Press ~INPUT_VEH_HORN~ to access ~d~Iron Seller')
                if IsControlJustPressed(0, 51) then 
                    currentAmmunition = k
                    RageUI.Visible(RMenu:Get("IronMenu", "Iron Seller"), true)
                    isInMenu = true
                    currentAmmunition = k 
                end
            end
            end
            if isInArea(v1, 1.4) == false and isInMenu and k == currentAmmunition then
                RageUI.Visible(RMenu:Get("IronMenu", "Iron Seller"), false)
                isInMenu = false
                currentAmmunition = nil
            end
        Citizen.Wait(0)
    end
end)

RMenu.Add('IronMenu', 'Iron Seller', RageUI.CreateMenu("", "Iron Seller", 1300, 50, "banners", "Iron"))

RageUI.CreateWhile(1.0, RMenu:Get('IronMenu', 'Iron Seller'):SetPosition(1300, 50), nil, function()
  RageUI.IsVisible(RMenu:Get('IronMenu', 'Iron Seller'), true, false, true, function()
      RageUI.ButtonWithStyle("Sell Iron" , nil, {RightLabel = "~g~£1,500"}, true, function(Hovered, Active, Selected)

        if Selected then
            sellingIronUnits()
        end
      end)
  
  end, function() end)
  
end)

function sellingIronUnits()
     AQUAcfgdrugsServer.SellIronJob({tonumber(1)})
    return false
end

function isInArea(v, dis) 
    
  if #(GetEntityCoords(PlayerPedId(-1)) - v) <= dis then  
      return true
  else 
      return false
  end
end


