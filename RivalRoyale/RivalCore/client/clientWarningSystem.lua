WARNING_SYSTEM = {}
WARNING_SYSTEM.adminView = false
WARNING_SYSTEM.adminWarnings = {}

-- Toggles the warning system
RegisterCommand('+WARNINGSYSTEM', function()
  CONTROLS.warningSystemOpen = not CONTROLS.warningSystemOpen

  if CONTROLS.warningSystemOpen then
    NUI:extraModule('WarningSystem', true)

    if SQUAD.inSquad then
      TriggerScreenblurFadeIn(350.0)
      return NUI:redirect('/hidden')
    end

    NUI:toggleFocus(true)
  end
end)

-- Closes the warning system
RegisterSafeNUICallback('RIVAL::closeWarningSystem', function(data, cb)
  WARNING_SYSTEM.adminView = false
  CONTROLS.warningSystemOpen = false
  NUI:extraModule('WarningSystem', false)

  if SQUAD.inSquad then
    TriggerScreenblurFadeOut(500.0)
    NUI:redirect('/')

    return
  end

  NUI:toggleFocus(false)
end)

-- Return all warning data to be displayed in the NUI
RegisterNUICallback('RIVAL::fetchWarnings', function(data, cb)
  if WARNING_SYSTEM.adminView then
    return cb(WARNING_SYSTEM.adminWarnings)
  end

  local Warnings = TriggerServerCallback('RIVAL::getWarnings') or {}
  cb(Warnings)
end)

RegisterNetEvent('RIVAL::showWarnings', function(warnings)
  WARNING_SYSTEM.adminView = true
  WARNING_SYSTEM.adminWarnings = warnings
  ExecuteCommand('+WARNINGSYSTEM')
end)
