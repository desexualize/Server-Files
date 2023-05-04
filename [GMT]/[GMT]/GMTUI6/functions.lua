-- Leaked By: Leaking Hub | J. Snow | leakinghub.com
local Window1 = 1
local Window2 = 1
local Window3 = 1
local Window4 = 1
local Windows1 = 1
local Windows2 = 1
local WindowsAll = 1
function CloseDoor(doors)
    local playerPed = GetPlayerPed(-1)
	if IsPedSittingInAnyVehicle(playerPed)then 
		local playerVeh = GetVehiclePedIsIn(playerPed, false)
        if GetVehicleDoorAngleRatio(playerVeh, doors) > 0.0 then
            SetVehicleDoorShut(playerVeh, doors, false)         
        else
            SetVehicleDoorOpen(playerVeh, doors, false)          
        end
    end
end

function WindowRightFront()
    local playerPed = GetPlayerPed(-1)
    local playerVeh = GetVehiclePedIsIn(playerPed, false)
    if ( IsPedSittingInAnyVehicle( playerPed ) ) and Window1 == 0 then
        RollUpWindow(playerVeh, 1)
        Window1 = 1
    else
        RollDownWindow(playerVeh, 1)
        Window1 = 0
    end
    return Window1
end

function WindowLeftFront()
    local playerPed = GetPlayerPed(-1)
    local playerVeh = GetVehiclePedIsIn(playerPed, false)
    if ( IsPedSittingInAnyVehicle( playerPed ) ) and Window2 == 0 then
        RollUpWindow(playerVeh, 0)
        Window2 = 1
    else
        RollDownWindow(playerVeh, 0)
        Window2 = 0
    end
end

function WindowLeftRear()
    local playerPed = GetPlayerPed(-1)
    local playerVeh = GetVehiclePedIsIn(playerPed, false)
    if ( IsPedSittingInAnyVehicle( playerPed ) ) and Window3 == 0 then
        RollUpWindow(playerVeh, 2)
        Window3 = 1
    else
        RollDownWindow(playerVeh, 2)
        Window3 = 0
    end
end

function WindowRightRear()
    local playerPed = GetPlayerPed(-1)
    local playerVeh = GetVehiclePedIsIn(playerPed, false)
    if ( IsPedSittingInAnyVehicle( playerPed ) ) and Window4 == 0 then
        RollUpWindow(playerVeh, 3)
        Window4 = 1
    else
        RollDownWindow(playerVeh, 3)
        Window4 = 0
    end
end

function WindowsFront()
    local playerPed = GetPlayerPed(-1)
    local playerVeh = GetVehiclePedIsIn(playerPed, false)
    if ( IsPedSittingInAnyVehicle( playerPed ) ) and Windows1 == 0 then
        RollUpWindow(playerVeh, 1)
        RollUpWindow(playerVeh, 0)
        Windows1 = 1
    else
        RollDownWindow(playerVeh, 1)
        RollDownWindow(playerVeh, 0)
        Windows1 = 0
    end
end

function WindowsRear()
    local playerPed = GetPlayerPed(-1)
    local playerVeh = GetVehiclePedIsIn(playerPed, false)
    if ( IsPedSittingInAnyVehicle( playerPed ) ) and Windows2 == 0 then
        RollUpWindow(playerVeh, 2)
        RollUpWindow(playerVeh, 3)
        Windows2 = 1
    else
        RollDownWindow(playerVeh, 2)
        RollDownWindow(playerVeh, 3)
        Windows2 = 0
    end
end

function WindowsAll()
    local playerPed = GetPlayerPed(-1)
    local playerVeh = GetVehiclePedIsIn(playerPed, false)
    if ( IsPedSittingInAnyVehicle( playerPed ) ) and WindowsAll == 0 then
        RollUpWindow(playerVeh, 0)
        RollUpWindow(playerVeh, 1)
        RollUpWindow(playerVeh, 2)
        RollUpWindow(playerVeh, 3)
        WindowsAll = 1
    else
        RollDownWindow(playerVeh, 0)
        RollDownWindow(playerVeh, 1)
        RollDownWindow(playerVeh, 2)
        RollDownWindow(playerVeh, 3)
        WindowsAll = 0
    end
end
RegisterNetEvent('Ax-Radial:Doors')
AddEventHandler('Ax-Radial:Doors',function(option)
    if option == 'f_r_doors' then
        CloseDoor(1)
    elseif option == 'f_l_doors' then
        CloseDoor(0)
    elseif option == 'r_r_doors' then
        CloseDoor(3)
    elseif option == 'r_l_doors' then
        CloseDoor(2)
    elseif option == 'hood' then
        CloseDoor(4)
    elseif option =='trunk' then
        CloseDoor(5)
    end
end)
RegisterNetEvent('Ax-Radial:Walkstyle')
AddEventHandler('Ax-Radial:Walkstyle',function(option)
    ExecuteCommand('walk '..option)
end)
RegisterNetEvent('Ax-Radial:Emote')
AddEventHandler('Ax-Radial:Emote',function(option)
    ExecuteCommand('e '..option)
end)