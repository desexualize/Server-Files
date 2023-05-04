local a = {}
Citizen.CreateThread(
    function()
        while true do
            local b = {}
            b.playerPed = getPlayerPed()
            b.playerCoords = getPlayerCoords()
            b.playerId = getPlayerId()
            b.vehicle = getPlayerVehicle()
            b.weapon = GetSelectedPedWeapon(b.playerPed)
            for c = 1, #a do
                local d = a[c]
                local e, f = pcall(d, b)
                if not e then
                 
                end
            end
            Wait(0)
        end
    end
)
function createThreadOnTick(d)
    a[#a + 1] = d
end
