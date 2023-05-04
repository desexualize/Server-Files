local InRangeGather = false
local InRangeProcess = false
local InRangeSell = false
local CanSeeMarker = false

-- [ScrapJob Gather] --
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(500)

    if IsPlayerNearCoords(vector3(cfgdrugs.ScrapJob.Gather.x,cfgdrugs.ScrapJob.Gather.y,cfgdrugs.ScrapJob.Gather.z), 40.0) then
      SetTextEntry_2("STRING")
      AddTextComponentString("Press [E] to Fix Scrap")
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

                TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_HAMMERING', false, true)
                exports.rprogress:Start("", 5000)
                ClearPedTasksImmediately(ped)
      
                AQUAcfgdrugsServer.ScrapJobGather ()
                Action = false
              else
                AQUA.notify({"~d~You cant gather ScrapJob while Driving!"})
              end
            end
          end
        end)
      end
    else
      InRangeGather = false
    end




    -- [ScrapJob Seller] --

    if IsPlayerNearCoords(vector3(cfgdrugs.ScrapJob.Sell.x,cfgdrugs.ScrapJob.Sell.y,cfgdrugs.ScrapJob.Sell.z), 100.0) then
      if not CanSeeMarker then
        CanSeeMarker = true
        Citizen.CreateThread(function()
          while CanSeeMarker do
            Citizen.Wait(0)
            -- Draw3DText(cfgdrugs.ScrapJob.Sell.x,cfgdrugs.ScrapJob.Sell.y,cfgdrugs.ScrapJob.Sell.z, "Sell ScrapJob")

            DrawMarker(2,  cfgdrugs.ScrapJob.Sell.x,cfgdrugs.ScrapJob.Sell.y,cfgdrugs.ScrapJob.Sell.z+1 - 0.98, 0, 0, 0, 0, 0, 0, 0.3, 0.3, 0.3, 207, 145, 0, 150, true, true, 0, 0, 0, 0, 0)

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

            local v1 = vector3(cfgdrugs.ScrapJob.Sell.x,cfgdrugs.ScrapJob.Sell.y,cfgdrugs.ScrapJob.Sell.z)

            if isInMenu == false then

            if isInArea(v1, 1.4) then 
                alert('Press ~INPUT_VEH_HORN~ to access ~o~Scrap Job Seller')
                if IsControlJustPressed(0, 51) then 
                    currentAmmunition = k
                    RageUI.Visible(RMenu:Get("ScrapJobMenu", "ScrapJob Seller"), true)
                    isInMenu = true
                    currentAmmunition = k 
                end
            end
            end
            if isInArea(v1, 1.4) == false and isInMenu and k == currentAmmunition then
                RageUI.Visible(RMenu:Get("ScrapJobMenu", "ScrapJob Seller"), false)
                isInMenu = false
                currentAmmunition = nil
            end
        Citizen.Wait(0)
    end
end)


RMenu.Add('ScrapJobMenu', 'ScrapJob Seller', RageUI.CreateMenu("", "~o~Scrap Job Seller",1300, 50, "banners", "scrapjob"))

RageUI.CreateWhile(1.0, RMenu:Get('ScrapJobMenu', 'ScrapJob Seller'):SetPosition(1300, 50), nil, function()
  RageUI.IsVisible(RMenu:Get('ScrapJobMenu', 'ScrapJob Seller'), true, false, true, function()
    
    RageUI.ButtonWithStyle("Sell Scrap" , nil, {RightLabel = "~g~£1,000"}, true, function(Hovered, Active, Selected)
        if Selected then
            sellingScrapJobUnits()
        end
    end)

  end, function() end)

end)

function sellingScrapJobUnits()
    AQUAcfgdrugsServer.SellScrapJob({tonumber(1)})
    return false
end

function isInArea(v, dis) 
    
  if #(GetEntityCoords(PlayerPedId(-1)) - v) <= dis then  
      return true
  else 
      return false
  end
end

