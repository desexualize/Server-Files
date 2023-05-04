local doors = {}

RegisterNetEvent('vrp_doors:load')
AddEventHandler('vrp_doors:load', function(list)
    doors = list
end)
RegisterNetEvent('vrp_doors:statusSend')
AddEventHandler('vrp_doors:statusSend', function(id,status)
    doors[id].locked = status
end)

function DrawText3D(x,y,z, text, px, py, pz)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    
    if onScreen then
        SetTextScale(0.2, 0.2)
        SetTextFont(0)
        SetTextProportional(1)
        -- SetTextScale(0.0, 0.55)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 55)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local coords = GetEntityCoords(PlayerPedId(),true)
        for k,v in pairs(doors) do
            if v.range ~= nil and v.range == 10 then 
				newrange = 10.0
			elseif v.range ~= nil and v.range == 5 then
				newrange = 5.0
			else
				newrange = 2.0
			end
            if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.coords[1], v.coords[2], v.coords[3], true) <= newrange then
                local closeDoor = GetClosestObjectOfType(v.coords[1], v.coords[2], v.coords[3], newrange, v.hash, false, false, false)
                local px,py,pz=table.unpack(GetGameplayCamCoords())

                if closeDoor ~= 0 then
                    if v.locked then
                        DrawText3D(v.coords[1], v.coords[2], v.coords[3], "🔒",px,py,pz)
                        local locked, heading = GetStateOfClosestDoorOfType(v.hash, v.coords[1], v.coords[2], v.coords[3], v.locked, 0)
                        if heading > -0.01 and heading < 0.01 then
                            FreezeEntityPosition(closeDoor, v.locked)
                        end
                    else
                        DrawText3D(v.coords[1], v.coords[2], v.coords[3], "🔓",px,py,pz)
                        FreezeEntityPosition(closeDoor, v.locked)
                    end
                    if IsControlJustReleased(0, 38) then
                        toggleClosestDoor()
                    end
                end
            end
        end
    end
end)

function toggleClosestDoor()
    local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(), true))
    for k,v in pairs(doors) do
        if v.close ~= nil then
            local door1 = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.coords[1], v.coords[2], v.coords[3], true )
            if v.range ~= nil and v.range == 10 then 
				newrange = 10.0
			else
				newrange = 2.0
			end
            if door1 < newrange then
                if door1 < GetDistanceBetweenCoords(x,y,z,doors[v.close].coords[1], doors[v.close].coords[2], doors[v.close].coords[3],true) then
                    TriggerServerEvent("vrp_doors:status", k, not v.locked)
                else
                    TriggerServerEvent("vrp_doors:status", v.close, not doors[v.close].locked)
                end
                break
            end
        else
			if v.range ~= nil and v.range == 10 then 
				newrange = 10.0
			else
				newrange = 2.0
			end
            if GetDistanceBetweenCoords(x,y,z,v.coords[1], v.coords[2], v.coords[3],true) <= newrange then
                TriggerServerEvent("vrp_doors:status", k, not v.locked)
            end
        end
    end
end
