local InRangeGather = false
local InRangeProcess = false
local InRangeSell = false
local CanSeeMarker = false

-- [Heroin Gather] --
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(500)

    if IsPlayerNearCoords(vector3(cfgdrugs.Heroin.Gather.x,cfgdrugs.Heroin.Gather.y,cfgdrugs.Heroin.Gather.z), 20.0) then
      SetTextEntry_2("STRING")
      AddTextComponentString("Press [E] to gather Opium")
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

                AQUAcfgdrugsServer.HeroinGather ()
                Action = false
              else
                AQUA.notify({"~d~You cant gather Heroin while Driving!"})
              end
            end
          end
        end)
      end
    else
      InRangeGather = false
    end


    -- [Heroin Process] --

    if IsPlayerNearCoords(vector3(cfgdrugs.Heroin.Process.x,cfgdrugs.Heroin.Process.y,cfgdrugs.Heroin.Process.z), 20.0) then
      SetTextEntry_2("STRING")
      AddTextComponentString("Press [E] to process Heroin.")
      EndTextCommandPrint(1000, 1)
      if not InRangeProcess then
        InRangeProcess = true
        Citizen.CreateThread(function()
          while InRangeProcess do
            Citizen.Wait(0)
      
            if IsControlJustReleased(0, 51)  then
              Action = true
              local ped = PlayerPedId()

              TaskStartScenarioInPlace(ped, 'CODE_HUMAN_MEDIC_KNEEL', false, true)

              exports.rprogress:Start("", 5000)
              AQUAcfgdrugsServer.CanProcessHeroin({}, function(canProcess, ketAmount)
                if canProcess and ketAmount then

                  local pid = PlayerPedId()

                  
      


                  Citizen.Wait(1)

                  AQUAcfgdrugsServer.ProcessHeroin()

                  AQUA.notify({"~w~Processed~g~ Heroin~w~ 1."})
                  Action = false
                end
                if not canProcess then
                  AQUA.notify({"~d~You do not have the required license."})
                  else
                    if not ketAmount then
                      AQUA.notify({"~d~You do not have enough Opium."})
                    end
                end
              end)
              ClearPedTasksImmediately(ped, true)
            end
          end
        end)
      end
    else
      InRangeProcess = false
    end

    -- [Heroin Seller] --

    if IsPlayerNearCoords(vector3(cfgdrugs.Heroin.Sell.x,cfgdrugs.Heroin.Sell.y,cfgdrugs.Heroin.Sell.z), 100.0) then
      if not CanSeeMarker then
        CanSeeMarker = true
        Citizen.CreateThread(function()
          while CanSeeMarker do
            Citizen.Wait(0)
            -- Draw3DText(cfgdrugs.Heroin.Sell.x,cfgdrugs.Heroin.Sell.y,cfgdrugs.Heroin.Sell.z, "Sell Heroin")

            DrawMarker(2,  cfgdrugs.Heroin.Sell.x,cfgdrugs.Heroin.Sell.y,cfgdrugs.Heroin.Sell.z+1 - 0.98, 0, 0, 0, 0, 0, 0, 0.3, 0.3, 0.3, 255, 0, 0, 150, true, true, 0, 0, 0, 0, 0)

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

            local v1 = vector3(3587.6159667969,3667.6887207031,33.881023406982)

            if isInMenu == false then

            if isInArea(v1, 1.4) then 
                alert('Press ~INPUT_VEH_HORN~ to access ~d~Heroin Seller')
                if IsControlJustPressed(0, 51) then 
                    currentAmmunition = k
                    RageUI.Visible(RMenu:Get("HeroinMenu", "Heroin Seller"), true)
                    isInMenu = true
                    currentAmmunition = k 
                end
            end
            end
            if isInArea(v1, 1.4) == false and isInMenu and k == currentAmmunition then
                RageUI.Visible(RMenu:Get("HeroinMenu", "Heroin Seller"), false)
                isInMenu = false
                currentAmmunition = nil
            end
        Citizen.Wait(0)
    end
end)


RMenu.Add('HeroinMenu', 'Heroin Seller', RageUI.CreateMenu("", "Heroin Seller",1300, 50, "banners", "heroin"))

RageUI.CreateWhile(1.0, RMenu:Get('HeroinMenu', 'Heroin Seller'):SetPosition(1300, 50), nil, function()
  RageUI.IsVisible(RMenu:Get('HeroinMenu', 'Heroin Seller'), true, false, true, function()
    
    RageUI.ButtonWithStyle("Sell Heroin" , nil, {RightLabel = "~g~£10,000"}, true, function(Hovered, Active, Selected)
        if Selected then
            sellingHeroinUnits()
        end
    end)

  end, function() end)

end)

function sellingHeroinUnits()
    AQUAcfgdrugsServer.SellHeroin({tonumber(1)})
    return false
end

function isInArea(v, dis) 
    
  if #(GetEntityCoords(PlayerPedId(-1)) - v) <= dis then  
      return true
  else 
      return false
  end
end
