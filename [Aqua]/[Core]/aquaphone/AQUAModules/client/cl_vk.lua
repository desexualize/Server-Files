POS_actual = 1
PED_hasBeenTeleported = false

RMenu.Add('PDTP', 'main', RageUI.CreateMenu("Teleport Menu", "~d~Teleport Menu", GetRageUIMenuWidth(),GetRageUIMenuHeight()))
RMenu.Add('PDTOMPD', 'main', RageUI.CreateMenu("Teleport Menu", "~d~Teleport Menu", GetRageUIMenuWidth(),GetRageUIMenuHeight()))

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
            DrawMarker(27, pos.x, pos.y, pos.z-1, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 255,255,255, 200, 0, 0, 2, 0, 0, 0, 0)
            if (Vdist(playerPos.x, playerPos.y, playerPos.z, pos.x, pos.y, pos.z) < 1.0) and (not PED_hasBeenTeleported) then
                POS_actual = pos.id
                if not gui_interiors.opened then
                    gui_interiors_OpenMenu()
                end
            end
        end
    end
end)
RageUI.CreateWhile(1.0, RMenu:Get('PDTP', 'main'), nil, function()
    RageUI.IsVisible(RMenu:Get('PDTP', 'main'), true, false, true, function()
    for k,v in pairs(vk.TP) do
       if hadPDPERMS then
       RageUI.ButtonWithStyle("Teleport to Traning Grounds" , nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if Selected then
                local x,y,z = table.unpack(v.trainingexit)
               -- print(x,y,z)
                local ped = GetPlayerPed(-1)
                --TriggerEvent('SETPDCOORDS', source, x,y,z)
                SetEntityCoords(ped,x,y,z,true,false,true)
                end
             end)
            end
        end
    end, function()
        ---Panels
    end)
end)

RageUI.CreateWhile(1.0, RMenu:Get('PDTOMPD', 'main'), nil, function()
    RageUI.IsVisible(RMenu:Get('PDTOMPD', 'main'), true, false, true, function()
    for k,v in pairs(vk.TP) do
       if hadPDPERMS then
       RageUI.ButtonWithStyle("Teleport to Mission Row" , nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if Selected then
                local c,n,r = table.unpack(v.marker)
               -- print(x,y,z)
                local ped = GetPlayerPed(-1)
                --TriggerEvent('SETPDCOORDS', source, x,y,z)
                SetEntityCoords(ped,c,n,r,true,false,true)
                end
             end)
            end
        end
        
    end, function()
        ---Panels
    end)
end)



isinPDTP = false
Citizen.CreateThread(function() 
    while true do
        for k, v in pairs(vk.TP) do 
            local x,y,z = table.unpack(v.marker)
            local v1 = vector3(x,y,z)
            if isInArea(v1, 100.0) then
                ticks = 1 
                DrawMarker(27, 470.83456420898,-984.7470703125,30.689601898193 - 0.999999, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 2.5, 255, 0, 0, 250, 0, 0, 2, 0, 0, 0, false)
            end
            if isinPDTP == false then
            if isInArea(v1, 1.4) then 
                ticks = 1
                --alert('~g~Press ~INPUT_VEH_HORN~ to access ~d~Police Teleporter')
                --if IsControlJustPressed(0, 51) then 
                    TriggerServerEvent('AQUA:PDVK')
                    RageUI.Visible(RMenu:Get("PDTP", "main"), true)
                    isinPDTP = true
                  
                --end
            end
            end
            if isInArea(v1, 1.4) == false and isinPDTP  then
                ticks = 1
                RageUI.Visible(RMenu:Get("PDTP", "main"), false)
                isinPDTP = false

            end
        end
        Citizen.Wait(ticks)
        ticks = 500
    end
end)

isinPDTP2 = false
Citizen.CreateThread(function() 
    while true do
        for k, v in pairs(vk.TP) do 
            local x,y,z = table.unpack(v.trainingexit)
            local v1 = vector3(x,y,z)
            if isInArea(v1, 100.0) then
                ticks = 1 
                DrawMarker(27, -1950.9876708984,3019.8894042969,32.810291290283 - 0.999999, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 2.5, 255, 0, 0, 250, 0, 0, 2, 0, 0, 0, false)
            end
            if isinPDTP2 == false then
            if isInArea(v1, 1.4) then 
                ticks = 1
                --alert('~g~Press ~INPUT_VEH_HORN~ to access ~d~Police Teleporter')
                --if IsControlJustPressed(0, 51) then 
                    TriggerServerEvent('AQUA:PDVK')
                    RageUI.Visible(RMenu:Get("PDTOMPD", "main"), true)
                    isinPDTP2 = true
                  
                --end
            end
            end
            if isInArea(v1, 1.4) == false and isinPDTP2  then
                ticks = 1
                RageUI.Visible(RMenu:Get("PDTOMPD", "main"), false)
                isinPDTP2 = false

            end
        end
        Citizen.Wait(ticks)
        ticks = 500
    end
end)

RegisterNetEvent('SETPDCOORDS')
AddEventHandler('SETPDCOORDS', function(source, x,y,z)
    local ped = GetPlayerPed(source)
    --local x,y,z = table.unpack(coords)
    SetEntityCoords(ped,x,y,z,true,false,true)

end)


RegisterNetEvent('sendvkpdperms')
AddEventHandler('sendvkpdperms', function(bool)
    if bool then 
        hadPDPERMS = true 
    else
        hadPDPERMS = false
    end
end)