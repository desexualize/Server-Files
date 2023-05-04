Citizen.CreateThread(function()
    while true do 
        ExecuteCommand('weather clear')
        Citizen.Wait(30000)
    end
end)