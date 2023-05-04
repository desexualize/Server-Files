other = nil
drag = false
playerStillDragged = false

Citizen.CreateThread(function()
    while true do
        HideHudComponentThisFrame(3)
        HideHudComponentThisFrame(4)
        Citizen.Wait(0)
    end 
end)

RegisterNetEvent('ERP:policeHotkeysTrue')
AddEventHandler('ERP:policeHotkeysTrue', function() 
    handcuffed = true
end)

RegisterNetEvent('ERP:policeHotkeysFalse')
AddEventHandler('ERP:policeHotkeysFalse', function() 
    handcuffed = false
end)

local l = 1

Citizen.CreateThread(function()
    while true do
        if handcuffed then
            SetPedStealthMovement(GetPlayerPed(-1),true,"")
            HideHudComponentThisFrame(19)
            DisplayRadar(false)
            DisableControlAction(0,21,true) 
            DisableControlAction(0,7,true) 
            DisableControlAction(0,80,true)  -- disable attack
            DisableControlAction(0,25,true) -- disable aim
            DisableControlAction(0,45,true) -- disable weapon
            DisableControlAction(0,47,true) -- disable weapon
            DisableControlAction(0,58,true) -- disable weapon
            DisableControlAction(0,263,true) -- disable melee
            DisableControlAction(0,264,true) -- disable melee
            DisableControlAction(0,257,true) -- disable punching / shooting
            DisableControlAction(0,69,true) -- disable punching / shooting
            DisableControlAction(0,135,true) -- disable punching / shooting
            DisableControlAction(0,142,true) -- disable punching / shooting
            DisableControlAction(0,144,true) -- disable punching / shooting
            DisableControlAction(0,131,true) -- disable running
            DisableControlAction(0,209,true) -- disable running
            DisableControlAction(0,254,true) -- disable running
            DisableControlAction(0,340,true) -- disable running
            DisableControlAction(0,352,true) -- disable running
            DisableControlAction(0,311,true) -- disable melee
            DisableControlAction(0,140,true) -- disable melee
            DisableControlAction(0,141,true) -- disable melee
            DisableControlAction(0,18,true) 
            DisableControlAction(0,22,true) 
            DisableControlAction(0,55,true) 
            DisableControlAction(0,76,true) 
            DisableControlAction(0,102,true) 
            DisableControlAction(0,143,true) 
            DisableControlAction(0,179,true) 
            DisableControlAction(0,203,true) 
            DisableControlAction(0,216,true) 
            DisableControlAction(0,255,true) 
            DisableControlAction(0,298,true) 
            DisableControlAction(0,321,true) 
            DisableControlAction(0,328,true) 
            DisableControlAction(0,353,true) 
            DisableControlAction(0,170,true) -- disable melee
            DisableControlAction(0,143,true) -- disable melee
            DisableControlAction(0,75,true) -- disable exit vehicle
            DisableControlAction(27,75,true) -- disable exit vehicle
            DisableControlAction(0,22,true)    
            DisableControlAction(0, 25, true)
            DisableControlAction(0, 140, true)
        else
	        DisplayRadar(true)
	    end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlPressed(0, 19, true) and IsControlPressed(0, 30, true) then
            TriggerServerEvent('ERP:policeDrag')
            
            Wait(1000)
            
        end
    end
end)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlPressed(0, 344, true) then
            TriggerServerEvent('ERP:policeCuff')
            Wait(1000)
        end
    end
end)

RegisterNetEvent("ERP:cuffAnimPolice")
AddEventHandler("ERP:cuffAnimPolice", function(nplayer, player)
    local player = player
    local nplayer = nplayer
    TriggerServerEvent("ERP:PlayWithinDistance", 0.2 , "cuffing", 1, GetEntityCoords(GetPlayerPed(-1))) 
    local ped = GetPlayerPed(GetPlayerFromServerId(nplayer))
    local myped = GetPlayerPed(GetPlayerFromServerId(player))
    AttachEntityToEntity(GetPlayerPed(-1), ped, 20781, 11816, -1.0, 0.0, -1.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
    FreezeEntityPosition(ped, true)
    Wait(5000)
    DetachEntity(myped, true, false)
    FreezeEntityPosition(ped, false)
    FreezeEntityPosition(ped, true)


end)
RegisterNetEvent("ERP:cuffAnimPerp")
AddEventHandler("ERP:cuffAnimPerp", function()

    TriggerServerEvent("ERP:PlayWithinDistance", 0.2 , "cuffing", 1, GetEntityCoords(GetPlayerPed(-1))) 
    SetCurrentPedWeapon(GetPlayerPed(-1),GetHashKey("WEAPON_UNARMED"),true)
    FreezeEntityPosition(GetPlayerPed(-1), true)
    Wait(5000)
    FreezeEntityPosition(GetPlayerPed(-1), false)


end)

RegisterNetEvent("ERP:drag")
AddEventHandler('ERP:drag', function(pl)
    other = pl
    drag = not drag
end)

RegisterNetEvent("ERP:undrag")
AddEventHandler('ERP:undrag', function(pl)
    drag = false
end)

Citizen.CreateThread(function()
    while true do
        if drag and other ~= nil then
            local ped = GetPlayerPed(GetPlayerFromServerId(other))
            local myped =PlayerPedId()
            AttachEntityToEntity(myped, ped, 20781, 11816, 0.54, 0.0, -1.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
            playerStillDragged = true
        else
            if(playerStillDragged) then
                DetachEntity(GetPlayerPed(-1), true, false)
                playerStillDragged = false
            end
        end
        Citizen.Wait(0)
    end
end)