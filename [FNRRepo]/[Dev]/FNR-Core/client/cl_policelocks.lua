local doors = {}
local LockHotkey = {0,38}

RegisterNetEvent('vrp:load')
AddEventHandler('vrp:load', function(list)
	doors = list
end)

RegisterNetEvent('vrp:statusSend')
AddEventHandler('vrp:statusSend', function(i, status)
    doors[i].locked = status
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if not IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
			if IsControlJustPressed(table.unpack(LockHotkey)) then
				local id = searchIdDoor()
				if id ~= 0 then
					TriggerServerEvent("vrp:open", id)
				end
			end
		end
	end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
		for k,v in pairs(doors) do
			if GetDistanceBetweenCoords(x,y,z,v.x,v.y,v.z,true) <= 2 then
				local door = GetClosestObjectOfType(v.x,v.y,v.z, 1.0, v.hash, false, false, false)
				if door ~= 0 then
					SetEntityCanBeDamaged(door, false)
					if v.locked == false then
						DrawText3D(v.x,v.y,v.z+0.2, '🔓', 0, 255, 0)
						NetworkRequestControlOfEntity(door)
						FreezeEntityPosition(door, false)
					else
						local locked, heading = GetStateOfClosestDoorOfType(v.hash, v.x,v.y,v.z, locked, heading)
						if heading > -0.02 and heading < 0.02 then
							DrawText3D(v.x,v.y,v.z+0.2, '🔒', 255, 0, 0)
							NetworkRequestControlOfEntity(door)
							FreezeEntityPosition(door, true)
						end
					end
				end
			end
		end
	end
end)

function searchIdDoor()
    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
    for k, v in pairs(doors) do
        if GetDistanceBetweenCoords(x, y, z, v.x, v.y, v.z, true) <= 1.5 then
            return k
        end
    end
    return 0
end

function searchIdDoorCustomRange()
    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
    for k, v in pairs(doors) do
        if v.range ~= nil then
            if GetDistanceBetweenCoords(x, y, z, v.x, v.y, v.z, true) <= v.range then
                return k
            end
        end
    end
    return 0
end

function DrawText3D(x,y,z, text, r,g,b)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	local dist = #(vector3(px,py,pz)-vector3(x,y,z))
  
	local scale = (1/dist)*1.6
	local fov = (1/GetGameplayCamFov())*100
	local scale = scale*fov
  
	if onScreen then
		if not useCustomScale then
			SetTextScale(0.0*scale, 0.55*scale)
		else
			SetTextScale(0.0*scale, customScale)
		end
		SetTextFont(0)
		SetTextProportional(1)
		SetTextColour(r, g, b, 255)
		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextEdge(2, 0, 0, 0, 150)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x,_y)
	end
  end