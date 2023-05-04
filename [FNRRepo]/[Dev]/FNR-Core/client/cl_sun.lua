--[[Citizen.CreateThread(function()
    while true do
		Citizen.Wait(0)
		WaterOverrideSetStrength(0.0)
		NetworkOverrideClockTime(11, 00, 00)
		SetWeatherTypePersist("EXTRASUNNY")
		SetWeatherTypeNowPersist("EXTRASUNNY")
		SetWeatherTypeNow("EXTRASUNNY")
		SetOverrideWeather("EXTRASUNNY")
		SetForcePedFootstepsTracks(false)
		SetForceVehicleTrails(false)
    end
end)]]