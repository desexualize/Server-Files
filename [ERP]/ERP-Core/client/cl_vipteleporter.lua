cfg.location = {
    [0] = {
      coords = {-2164.1796875,5198.1318359375,16.664876937866},
  },
  [1] = {
    coords = {145.95523071289,-1059.0070800781,30.186124801636},
  },
  [2] = {
    coords = {2709.0324707031,3452.2468261719,55.545948028564},
  },
  [3] = {
    coords = {-229.59973144531,6332.1860351562,32.407173156738},
  },
  }
  
  RMenu.Add('VIPTele', 'main', RageUI.CreateMenu("", "~y~VIP Teleport Menu", 1300, 100, "vip", "vip"))
  RMenu.Add('VIPTele', 'sub', RageUI.CreateMenu("", "~y~VIP Teleport Menu", 1300, 100, "vip", "vip"))
  
  RageUI.CreateWhile(1.0, RMenu:Get('VIPTele', 'main'), nil, function()
      RageUI.IsVisible(RMenu:Get('VIPTele', 'main'), true, false, true, function()
          RageUI.Button("Teleport to VIP Island", nil, "→→→", true, function(Hovered, Active, Selected)
              if Selected then
                DoScreenFadeOut(1000)
                Wait(1000)
                SetEntityCoords(PlayerPedId(), -2164.1796875,5198.1318359375,16.664876937866, false, false, false, true)
                DoScreenFadeIn(1000)
              end
          end)
          RageUI.Button("~y~Return From VIP Island", nil, {RightLabel = "→ → →"}, true, function(Hovered, Active, Selected)
          end, RMenu:Get('VIPTele', 'sub'))
      end)
  
  
      RageUI.IsVisible(RMenu:Get('VIPTele', 'sub'), true, false, true, function()
      RageUI.Button("Legion Bank", nil, ">>>", true, function(Hovered, Active, Selected)
          if Selected then
              DoScreenFadeOut(1000)
              Wait(1000)
              SetEntityCoords(PlayerPedId(), 145.95523071289,-1059.0070800781,30.186124801636, false, false, false, true)
              DoScreenFadeIn(1000)
          end 
      end, RMenu:Get('VIPTele', 'main'))
      RageUI.Button("YouTool", nil, ">>>", true, function(Hovered, Active, Selected)
          if Selected then
              DoScreenFadeOut(1000)
              Wait(1000)
              SetEntityCoords(PlayerPedId(), 2709.0324707031,3452.2468261719,55.545948028564, false, false, false, true)
              DoScreenFadeIn(1000)
          end 
      end, RMenu:Get('VIPTele', 'main'))
      RageUI.Button("Paleto", nil, ">>>", true, function(Hovered, Active, Selected)
          if Selected then
              SetEntityCoords(PlayerPedId(), -229.59973144531,6332.1860351562,32.407173156738, false, false, false, true)
              DoScreenFadeIn(1000)
          end
      end, RMenu:Get('VIPTele', 'main'))
    end)
  
      
  end)
  
  
  
  isInMenu = false
  currentAmmunition = nil
  
  Citizen.CreateThread(function() 
      while true do
              if isInArea(v1, 100.0) then 
                  DrawMarker(20, v1+1 - 0.98, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 255,255,0, 100, 1, 0, 0, 0, 0, 0, 0)
              end
              if isInMenu == false then
              if isInArea(v1, 1.4) then 
                alertnotify('Press ~INPUT_VEH_HORN~ To Open the Teleport Menu')
                  if IsControlJustPressed(0, 51) then 
                      currentAmmunition = k
                      RageUI.Visible(RMenu:Get("VIPTele", "main"), true)
                      isInMenu = true
                      currentAmmunition = k
                  end
              end
          end
              if isInArea(v1, 1.4) == false and isInMenu and k == currentAmmunition then
                  RageUI.Visible(RMenu:Get("VIPTele", "main"), false)
                  isInMenu = false
                  currentAmmunition = nil
              end
          end
          Citizen.Wait(0)
  end)
  
  function isInArea(v, dis) 
      if #(GetEntityCoords(PlayerPedId(-1)) - v) <= dis then  
          return true
      else 
          return false
      end
  end
  
  function alertnotify(msg) 
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0,0,1,-1)
  end