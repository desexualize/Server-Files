voteCooldown = 1800
currentWeather = "CLEAR"

weatherVoterCooldown = voteCooldown

RegisterServerEvent("Nova:vote") 
AddEventHandler("Nova:vote", function(weatherType)
    TriggerClientEvent("Nova:voteStateChange",-1,weatherType)
end)

RegisterServerEvent("Nova:tryStartWeatherVote") 
AddEventHandler("Nova:tryStartWeatherVote", function()
	local source = source
    if weatherVoterCooldown >= voteCooldown then
        TriggerClientEvent("Nova:startWeatherVote", -1)
        weatherVoterCooldown = 0
    else
		TriggerClientEvent("chatMessage",source,"Another vote can be started in " .. tostring(voteCooldown-weatherVoterCooldown) .. " seconds!",{255, 0, 0})
    end
end)

RegisterServerEvent("Nova:getCurrentWeather") 
AddEventHandler("Nova:getCurrentWeather", function()
    local source = source
    TriggerClientEvent("Nova:voteFinished",source,currentWeather)
end)

RegisterServerEvent("Nova:setCurrentWeather")
AddEventHandler("Nova:setCurrentWeather", function(newWeather)
	currentWeather = newWeather
end)

Citizen.CreateThread(function()
	while true do
		weatherVoterCooldown = weatherVoterCooldown + 1
		Citizen.Wait(1000)
	end
end)