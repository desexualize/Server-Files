local isInMenu = false
local currentAmmunition = nil
Citizen.CreateThread(function() 
      local cryptoped = GetHashKey("s_m_y_doorman_01")
      RequestModel(cryptoped)
      while not HasModelLoaded(cryptoped) do
          Wait(0)
      end

      RequestAnimDict("mini@strip_club@idles@bouncer@base")
      while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
        Wait(1)
      end

      local cryptoentity = CreatePed(26,cryptoped,1096.130859375,-3103.3684082031,-38.999950408936-1.0,0,false,true)
      SetModelAsNoLongerNeeded(cryptoped)     
      SetEntityCanBeDamaged(cryptoentity, 0)
      SetPedAsEnemy(cryptoentity, 0)   
      SetBlockingOfNonTemporaryEvents(cryptoentity, 1)
      SetPedResetFlag(cryptoentity, 249, 1)
      SetPedConfigFlag(cryptoentity, 185, true)
      SetPedConfigFlag(cryptoentity, 108, true)
      SetEntityInvincible(cryptoentity, true)
      SetEntityCanBeDamaged(cryptoentity, false)
      SetPedCanEvasiveDive(cryptoentity, 0)
      SetPedCanRagdollFromPlayerImpact(cryptoentity, 0)
      SetPedConfigFlag(cryptoentity, 208, true)       
      FreezeEntityPosition(cryptoentity, true)
      TaskPlayAnim(cryptoentity,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
      while true do
      Citizen.Wait(0)
            local v1 = vector3(1095.9968261719,-3102.4855957031,-38.999938964844)
            if isInMenu == false then

            if isInArea(v1, 1.4) then 
                alert('Press ~INPUT_VEH_HORN~ to access ~p~Seller')
                if IsControlJustPressed(0, 51) then 
                    currentAmmunition = k
                    RageUI.Visible(RMenu:Get("CryptoMenu", "Seller"), true)
                    isInMenu = true
                    currentAmmunition = k 
                end
            end
            end
            if isInArea(v1, 1.4) == false and isInMenu and k == currentAmmunition then
                RageUI.Visible(RMenu:Get("CryptoMenu", "Seller"), false)
                isInMenu = false
                currentAmmunition = nil
            end
            if IsPlayerNearCoords(vector3(1095.9968261719,-3102.4855957031,-38.999938964844), 10.0) then
              DrawMarker(27,1095.9968261719,-3102.4855957031,-38.999938964844 - 0.98, 0, 0, 0, 0, 0, 0, 1.001, 1.0001, 0.5001, 255,255,255, 200, 0, 0, 0, 0)
            end 
    end
end)


RMenu.Add('CryptoMenu', 'Seller', RageUI.CreateMenu("", "Crypto Dealer",1300, 100, "crypto", "crypto"))

RageUI.CreateWhile(1.0, RMenu:Get('CryptoMenu', 'Seller'):SetPosition(1300, 100), nil, function()
  RageUI.IsVisible(RMenu:Get('CryptoMenu', 'Seller'), true, false, true, function()
    
    RageUI.Button("Sell Litecoin" , "£25,000", {}, true, function(Hovered, Active, Selected)
        if Selected then
            sellingLitecoinUnits()
        end
    end)

    RageUI.Button("Sell Bitcoin" , "£30,000", {}, true, function(Hovered, Active, Selected)
      if Selected then
        sellingBitcoinUnits()
      end
  end)
  end, function() end)

end)

function sellingLitecoinUnits()
  ElementDrugsSV.SellLitecoin({tonumber(1)})
  return false
end

function sellingBitcoinUnits()
  ElementDrugsSV.SellBitcoin({tonumber(1)})
  return false
end

function isInArea(v, dis) 
    
  if #(GetEntityCoords(PlayerPedId(-1)) - v) <= dis then  
      return true
  else 
      return false
  end
end

Citizen.CreateThread(function()
  Citizen.Wait(500)
      cryptomarket = AddBlipForCoord(1125.865234375,-471.47802734375,66.488021850586)
      SetBlipSprite(cryptomarket, 537)
      SetBlipDisplay(cryptomarket, 4)
      SetBlipScale(cryptomarket, 0.4)
      SetBlipAsShortRange(cryptomarket, true)
      SetBlipColour(cryptomarket, 29)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString("Crypto Market")
      EndTextCommandSetBlipName(cryptomarket)
end)