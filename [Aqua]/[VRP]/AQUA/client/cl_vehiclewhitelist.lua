
local whitelistedvehicles = {
    [`foid`] = {1},
    
}
local function disablecar(j)
    DisableControlAction(0, 32, true)
    DisableControlAction(0, 33, true)
    DisableControlAction(0, 34, true)
    DisableControlAction(0, 35, true)
    DisableControlAction(0, 71, true)
    DisableControlAction(0, 72, true)
    DisableControlAction(0, 350, true)
    DisableControlAction(0, 351, true)
    SetVehicleRocketBoostPercentage(j, 0.0)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName("~d~Get out my car little boy!")
    EndTextCommandThefeedPostTicker(false, false)
end

local function checkdavehicle()
    local j, l = getPlayerVehicle()
    local permid = getUserId()
    if j ~= 0 and l and not isDeveloper(permid) then
        local entity = GetEntityModel(j)
        local vehicles = whitelistedvehicles[entity]
        if vehicles then
            local candrive = false
            for f, p in pairs(vehicles) do
                if p == permid then
                    candrive = true
                    break
                end
            end
            if not candrive then
                disablecar(j)
            end
        end
    end
end

createThreadOnTick(checkdavehicle)
