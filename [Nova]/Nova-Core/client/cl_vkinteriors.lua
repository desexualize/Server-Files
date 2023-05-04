INTERIORS = {
	-- VIP ISLAND
    [1] = {id = 1, x = -2182.8488769531, y = 5155.4682617188, z = 9.3517646789551, w = 344.89727783203,  name = "Enter VIP Island", destination = {2}},
    [2] = {id = 2, x = 146.00216674805, y = -1058.9512939453, z = 30.186157226562, w = 112.92094421387, name = "Exit VIP Island (Legion Square)", destination = {1}},

	-- VIP ISLAND
    [3] = {id = 3, x = 2709.1049804688, y = 3452.3566894531, z = 55.541660308838, w = 102.96519470215, name = "Exit VIP Island (You Tool)", destination = {4}}, 
    [4] = {id = 4, x = -2184.6354980469, y = 5154.0048828125, z = 9.3517465591431, w = 337.44125366211,  name = "Enter VIP Island", destination = {3}},	
    
	-- VIP ISLAND
    [5] = {id = 5, x = -228.51652526855, y = 6333.181640625, z = 32.410079956055, w = 180.11434936523, name = "Exit VIP Island (Paleto Medical)", destination = {6}}, 
    [6] = {id = 6, x = -2181.1462402344, y = 5156.7407226562, z = 9.3517465591431, w = 338.22662353516, name = "Enter VIP Island", destination = {5}},
    
    [7] = {id = 7, x = 470.1565246582, y = -984.83966064453, z = 30.689298629761, w = 87.568923950195,  name = "Mission Row PD", destination = {8}, permissions = {"police.menu"}}, 
    [8] = {id = 8, x = -1965.5189208984, y = 3031.6330566406, z = 32.810291290283, w = 326.41064453125,  name = "SCO 19 - Training Grounds", destination = {7},  permissions = {"police.menu"}},
    
    [9] = {id = 9, x = 340.01309204102, y = -584.44488525391, z = 74.161682128906, w = 250.94201660156, name = "ST Thomas - Top Floor", destination = {10}}, 
    [10] = {id = 10, x = 344.59658813477, y = -586.41381835938, z = 28.796821594238, w = 241.96606445313,  name = "ST Thomas - Bottom Floor", destination = {9}}
}

POS_actual = nil
PED_hasBeenTeleported = false

function teleport(pos)
    local ped = PlayerPedId()
    Citizen.CreateThread(function()
        PED_hasBeenTeleported = true
        NetworkFadeOutEntity(ped, true, false)
        Citizen.Wait(500)
        
        SetEntityCoords(ped, pos.x, pos.y, pos.z, 1, 0, 0, 1)
        SetEntityHeading(ped, pos.w)
        SetGameplayCamRelativeHeading(0)
        NetworkFadeInEntity(ped, 0)

        Citizen.Wait(500)
        PED_hasBeenTeleported = false
    end)
end

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local playerPos = GetEntityCoords(ped, true)

        for i, pos in pairs(INTERIORS) do
            DrawMarker(27, pos.x, pos.y, pos.z - 0.9, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 0, 255, 255, 200, 0, 0, 2, 0, 0, 0, 0)
            if (Vdist(playerPos.x, playerPos.y, playerPos.z, pos.x, pos.y, pos.z) < 1.0) and (not PED_hasBeenTeleported) then
                POS_actual = pos.id
                if not gui_interiors.opened then
                    gui_interiors_OpenMenu()
                end
            end
        end
        Citizen.Wait(0)
    end
end)


