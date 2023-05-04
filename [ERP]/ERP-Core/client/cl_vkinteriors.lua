local INTERIORS = {
--[[
	-- VIP ISLAND
    [14] = {id = 14, x = -2164.0842285156, y = 5198.0952148438, z = 16.661527633667,  name = "Enter VIP Island", destination = {15}},
    [15] = {id = 15, x = 145.96948242188, y = -1059.0294189453, z = 30.186124801636,  name = "Exit VIP Island", destination = {14}},

	-- VIP ISLAND
    [16] = {id = 16, x = 2709.0969238281, y = 3452.2697753906, z = 55.542644500732,  name = "Exit VIP Island", destination = {17}}, 
    [17] = {id = 17,x = -2164.0842285156, y = 5198.0952148438, z = 16.661527633667,  name = "Enter VIP Island", destination = {16}},	
    
	
	-- VIP ISLAND
    [18] = {id = 18, x =  -229.48852539062, y = 6332.1450195312, z = 32.409721374512,  name = "Exit VIP Island", destination = {19}}, 
    [19] = {id = 19,x = -2164.0842285156, y = 5198.0952148438, z = 16.661527633667,  name = "Enter VIP Island", destination = {18}},]]
}


POS_actual = 1
PED_hasBeenTeleported = false

function teleport(pos)
    local ped = GetPlayerPed(-1)
    Citizen.CreateThread(function()
        PED_hasBeenTeleported = true
        NetworkFadeOutEntity(ped, true, false)
        Citizen.Wait(500)
        
        SetEntityCoords(ped, pos.x, pos.y, pos.z, 1, 0, 0, 1)
        SetEntityHeading(ped, pos.h)
        NetworkFadeInEntity(ped, 0)

        Citizen.Wait(500)
        PED_hasBeenTeleported = false
    end)
end


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local ped = GetPlayerPed(-1)
        local playerPos = GetEntityCoords(ped, true)

        for i,pos in pairs(INTERIORS) do
            DrawMarker(1, pos.x, pos.y, pos.z-1, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 255,255,255, 200, 0, 0, 2, 0, 0, 0, 0)
            if (Vdist(playerPos.x, playerPos.y, playerPos.z, pos.x, pos.y, pos.z) < 1.0) and (not PED_hasBeenTeleported) then
                POS_actual = pos.id
                if not gui_interiors.opened then
                    gui_interiors_OpenMenu()
                end
            end
        end
    end
end)