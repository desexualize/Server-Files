function Crosshair(enable)
    SendNUIMessage({
      crosshair = enable
    })
  end
  
  RegisterNetEvent("GBRP:PutCrossHairOnScreen")
  AddEventHandler("GBRP:PutCrossHairOnScreen", function(bool)
    Crosshair(bool)
  end)