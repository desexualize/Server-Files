AddEventHandler('entityDamaged', function(victim, culprit, weapon, baseDamage)
  local pedCoords = RIVAL.getPlayerPosition()
  if victim == culprit or not IsEntityAPed(victim) then
    return
  end

  if RIVAL.getPlayerPed() == culprit then
    return NUI:playSound('hitshot')
  end

  if RIVAL.getPlayerPed() == victim and GetEntityHealth(victim) == 0 then
    NUI:playSound('death')
    TriggerServerEvent('RIVAL::syncDeathSound', pedCoords, RIVAL.getPlayerPed())
  end
end)
