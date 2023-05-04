voteCooldown = 1800
currentWeather = "CLEAR"

weatherVoterCooldown = voteCooldown

RegisterServerEvent("ERP:vote") 
AddEventHandler("ERP:vote", function(weatherType)
    TriggerClientEvent("ERP:voteStateChange",-1,weatherType)
end)

RegisterServerEvent("ERP:tryStartWeatherVote") 
AddEventHandler("ERP:tryStartWeatherVote", function()
	local source = source
    if weatherVoterCooldown >= voteCooldown then
        TriggerClientEvent("ERP:startWeatherVote", -1)
        weatherVoterCooldown = 0
    else
		TriggerClientEvent("chatMessage",source,"Another vote can be started in " .. tostring(voteCooldown-weatherVoterCooldown) .. " seconds!",{255, 0, 0})
    end
end)

RegisterServerEvent("ERP:getCurrentWeather") 
AddEventHandler("ERP:getCurrentWeather", function()
    local source = source
    TriggerClientEvent("ERP:voteFinished",source,currentWeather)
end)

RegisterServerEvent("ERP:setCurrentWeather")
AddEventHandler("ERP:setCurrentWeather", function(newWeather)
	currentWeather = newWeather
end)

Citizen.CreateThread(function()
	while true do
		weatherVoterCooldown = weatherVoterCooldown + 1
		Citizen.Wait(1000)
	end
end)

