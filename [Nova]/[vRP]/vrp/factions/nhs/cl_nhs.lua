-- this module define some police tools and functions

local handcuffed = false
local nhs = false
local nhs_permission = false
local nhs_suspended = false

function tvRP.setNHS(flag)
    nhs = flag
    TriggerEvent('Nova:Factions:Client:Clocked')
end

function tvRP.IsNHS()
    return nhs
end

function tvRP.Set_NHS_Permission(flag)
    nhs_permission = flag
end

function tvRP.Has_NHS_Permission(flag)
    return nhs_permission
end

function tvRP.Set_NHS_Suspended(flag)
    nhs_suspended = flag
end

function tvRP.Is_NHS_Suspended()
    return nhs_suspended
end

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1)
            if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey("weapon_unarmed") then
                DisableControlAction(0, 263, true)
                DisableControlAction(0, 264, true)
                DisableControlAction(0, 257, true)
                DisableControlAction(0, 140, true)
                DisableControlAction(0, 141, true)
                DisableControlAction(0, 142, true)
                DisableControlAction(0, 143, true)
                DisableControlAction(0, 24, true)
                DisableControlAction(0, 25, true)
            end
        end
    end
)