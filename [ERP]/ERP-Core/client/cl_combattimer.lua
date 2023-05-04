Ifinred = false

local Timer = 30
local RZ = {
    ["LSD"] = {vector3(2523.62, -379.7, 93.0),120.0}, -- LSD
    ["Rebel"] = {vector3(1457.4250488281,6308.064453125,63.868026733398),130.0}, -- Rebel
	["Heroin"] = {vector3(3529.4702148438,3726.9321289062,36.473175048828),230.0}, --
	["LargeArms"] = {vector3(-1113.1085205078,4922.0400390625,217.8408203125),110.0}, --LargeArms
    ["Grove"] = {vector3(103.05763244629,-1940.3416748047,20.803695678711),50.0}, -- Grove
    ["mili"] = {vector3(-2051.7541503906,3103.533203125,32.810264587402),220.0}, -- mili
}

local function getNonZDistance(vector1,vector2)
    return #(vector3(vector1.x,vector1.y,0.0)-vector3(vector2.x,vector2.y,0.0))
end

Citizen.CreateThread(function()
    while true do
        local playerCoords = GetEntityCoords(PlayerPedId())
        Ifinred = false
        for redZone,v in pairs(RZ) do
            local zoneVector = v[1]
            local zoneRadius = v[2]
            if #(playerCoords-zoneVector) <= zoneRadius then
                Ifinred = true
                local playerCoords = GetEntityCoords(PlayerPedId())
                Timer = 30
                local lastSavedGoodPos
                local startRed = false
                while not startRed do
                    playerCoords = GetEntityCoords(PlayerPedId())
                    while getNonZDistance(playerCoords,zoneVector) <= zoneRadius do
                        playerCoords = GetEntityCoords(PlayerPedId())
                        lastSavedGoodPos = playerCoords
                        if IsPedShooting(PlayerPedId()) and GetSelectedPedWeapon(PlayerPedId()) ~= `WEAPON_UNARMED` then
                            Timer = 30
                        end
                        if Timer == 0 then
                            DrawAdvancedText(0.931, 0.914, 0.005, 0.0028, 0.49, "Combat Timer ended, you may leave.", 244, 11, 27, 255, 7, 0)
                        else
                            DrawAdvancedText(0.931, 0.914, 0.005, 0.0028, 0.49, "Combat Timer: " .. Timer .. " seconds", 244, 11, 27, 255, 7, 0)
                            
                        end
                        Wait(0)
                    end
                    if Timer == 0 then
                        startRed = true
                    else
                        local lineVector = v[1] - GetEntityCoords(PlayerPedId())
                        lastSavedGoodPos = lastSavedGoodPos + (lineVector * 0.01)
                        
                        if GetVehiclePedIsIn(PlayerPedId(),false) == 0 then
                            TaskGoStraightToCoord(PlayerPedId(), lastSavedGoodPos.x, lastSavedGoodPos.y,lastSavedGoodPos.z, 8.0, 1000, GetEntityHeading(PlayerPedId()), 0.0)
                        else
                            SetPedCoordsKeepVehicle(PlayerPedId(), lastSavedGoodPos.x, lastSavedGoodPos.y,lastSavedGoodPos.z)
                        end
                        SetTimeout(1000,function()
                            ClearPedTasks(PlayerPedId())
                        end)
                    end
                    Wait(0)
                end
            end
        end
        Wait(500)
    end
end)

Citizen.CreateThread(function()
    while true do
        if Timer > 0 then
            Timer = Timer - 1
        end
        Wait(1000)
    end
end)
