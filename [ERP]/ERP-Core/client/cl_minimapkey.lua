Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlJustReleased(1, 20) then -- 20 is z
			Citizen.Wait(0)
			if not isRadarExtended then
				SetRadarBigmapEnabled(true, false)
				LastGameTimer = GetGameTimer()
				isRadarExtended = true
			elseif isRadarExtended then
				SetRadarBigmapEnabled(false, false)
				LastGameTimer = 0
				isRadarExtended = false
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlJustReleased(1, 243) then -- 20 is z
			Citizen.Wait(0)
			if not isRadarExtended then
				SetBigmapActive(true, true)
				LastGameTimer = GetGameTimer()
				isRadarExtended = true
			elseif isRadarExtended then
				SetBigmapActive(false, false)
				LastGameTimer = 0
				isRadarExtended = false
			end
		end
	end
end)

Citizen.CreateThread(function()
    local minimap = RequestScaleformMovie("minimap")
    SetRadarBigmapEnabled(true, false)
    Wait(0)
    SetRadarBigmapEnabled(false, false)
    while true do
        Wait(0)
        BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
        ScaleformMovieMethodAddParamInt(3)
        EndScaleformMovieMethod()
    end
  end)