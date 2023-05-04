function Crosshair(enable)
    SendNUIMessage({
      crosshair = enable
    })
  end
  
  RegisterNetEvent("FNR:PutCrossHairOnScreen")
  AddEventHandler("FNR:PutCrossHairOnScreen", function(bool)
    Crosshair(bool)
  end)