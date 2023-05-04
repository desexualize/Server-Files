-- this module define some police tools and functions

local handcuffed = false
local lfb = false
local lfb_permission = false
local lfb_suspended = false

function tvRP.setLFB(flag)
    lfb = flag
    TriggerEvent('Nova:Factions:Client:Clocked')
end

function tvRP.IsLFB()
    return lfb
end

exports('IsLFB', function()
    return lfb
end)

function tvRP.Set_LFB_Permission(flag)
    lfb_permission = flag
end

function tvRP.Has_LFB_Permission(flag)
    return lfb_permission
end

function tvRP.Set_LFB_Suspended(flag)
    lfb_suspended = flag
end

function tvRP.Is_LFB_Suspended()
    return lfb_suspended
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