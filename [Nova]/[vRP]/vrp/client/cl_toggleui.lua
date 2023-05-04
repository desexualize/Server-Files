RegisterCommand("hidemap", function()
    while true do
	Citizen.Wait(0)
		if DoesEntityExist(GetPlayerPed(-1)) then
		DisplayRadar(false)
		end
    end
end)

RegisterCommand("showmap", function()
    while true do
	Citizen.Wait(0)
		if DoesEntityExist(GetPlayerPed(-1)) then
		DisplayRadar(true)
		end
    end
end)