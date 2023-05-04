local a = 0
local b = 0
local c = 0
local d = vector3(0, 0, 0)
local e = false
local f = PlayerPedId
function savePlayerInfo()
    a = f()
    b = GetVehiclePedIsIn(a, false)
    c = PlayerId()
    d = GetEntityCoords(a)
    local g = GetPedInVehicleSeat(b, -1)
    e = g == a
end
_G["PlayerPedId"] = function()
    return a
end
function getPlayerPed()
    return a
end
function getPlayerVehicle()
    return b, e
end
function getPlayerId()
    return c
end
function getPlayerCoords()
    return d
end

createThreadOnTick(savePlayerInfo)