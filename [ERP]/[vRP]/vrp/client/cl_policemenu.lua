RMenu.Add('PoliceMenu', 'main', RageUI.CreateMenu("Police", "~b~MET Police Menu",1250,100))
RMenu.Add('PoliceMenu', 'objectmenu',  RageUI.CreateSubMenu(RMenu:Get("PoliceMenu", "main")))
RMenu.Add('PoliceMenu', 'speedzones',  RageUI.CreateSubMenu(RMenu:Get("PoliceMenu", "main")))

local arrst					= false		-- Zostaw na False innaczej bedzie aresztowac na start Skryptu --- Wait to translate them my dick
local arest_on				= false		-- Leave on False otherwise you will be Arreshtowany to start the Script
local variabila3			= 'mp_arrest_paired'	-- Animation Catalog section
local variabila2 			= 'cop_p2_back_left'	-- Arrester Animation
local variabila1			= 'crook_p2_back_left'	-- Animation of the Arrested
local index = {
  object = 1,
  speedRad = 1,
  speed = 1
}

local radiusnum = {
  "0",
  "25",
  "50",
  "75",
  "100",
  "125",
  "150",
  "175",
  "200",
}

local speednum = {
  "0",
  "5",
  "10",
  "15",
  "20",
  "25",
  "30",
  "35",
  "40",
  "45",
  "50",
}
local speedzones = {}

local objects = {
 {"Big Cone","prop_roadcone01a"},
 {"Small Cone","prop_roadcone02b"},
 {"Gazebo","prop_gazebo_02"},
 {"Worklight","prop_worklight_03b"},
 {"Police Slow","prop_barrier_work05"},
 {"Gate Barrier","ba_prop_battle_barrier_02a"},
 {"Concrete Barrier","prop_mp_barrier_01"},
 {"Concrete Barrier 2","prop_mp_barrier_01b"},
}
local listObjects = {}

for k, v in pairs(objects) do 
  listObjects[k] = v[1]
end

local radius 
local speed
local cuffed = false

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('PoliceMenu', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()
            if IsPedInAnyVehicle(GetPlayerPed(-1), false) == false then
                RageUI.Button("Object Menu" , nil, { RightLabel = '→→→'}, true, function(Hovered, Active, Selected) end, RMenu:Get('PoliceMenu', 'objectmenu'))
                RageUI.Button("Speed Zone" , nil, { RightLabel = '→→→'}, true, function(Hovered, Active, Selected) end, RMenu:Get('PoliceMenu', 'speedzones'))
                RageUI.Button("Cuff Nearest Player" , nil, { RightLabel = '→'}, true, function(Hovered, Active, Selected) 
                    if Selected then 
                        TriggerServerEvent('ERP:Handcuff')
                    end
                end)
                RageUI.Button("UnCuff Nearest Player" , nil, { RightLabel = '→'}, true, function(Hovered, Active, Selected) 
                    if Selected then 
                        TriggerServerEvent('ERP:Handcuff')
                    end
                end)
                RageUI.Button("Drag Nearest Player" , nil, { RightLabel = '→'}, true, function(Hovered, Active, Selected) 
                    if Selected then 
                        TriggerServerEvent('Element:Drag')
                    end
                end)
                RageUI.Button("Search Nearest Player" , nil, { RightLabel = '→'}, true, function(Hovered, Active, Selected) 
                    if Selected then 
                        TriggerServerEvent('Element:SearchPlayer')
                    end
                end)
                RageUI.Button("Seize Items" , nil, { RightLabel = '→'}, true, function(Hovered, Active, Selected) 
                    if Selected then 
                        TriggerServerEvent('Element:SeizeWeapons')
                    end
                end)
                RageUI.Button("Put Player in Vehicle" , nil, { RightLabel = '→'}, true, function(Hovered, Active, Selected) 
                    if Selected then 
                        TriggerServerEvent('Element:PutPlrInVeh')
                    end
                end)
                RageUI.Button("Remove Player From Vehicle" , nil, { RightLabel = '→'}, true, function(Hovered, Active, Selected) 
                    if Selected then 
                        TriggerServerEvent('Element:TakeOutOfVehicle')
                    end
                end)
                RageUI.Button("Fine Player" , nil, { RightLabel = '→'}, true, function(Hovered, Active, Selected) 
                    if Selected then 
                        TriggerServerEvent('Element:Fine')
                    end
                end)
                RageUI.Button("Jail Player" , nil, { RightLabel = '→'}, true, function(Hovered, Active, Selected) 
                    if Selected then 
                        TriggerServerEvent('Element:JailPlayer')
                    end
                end)
                RageUI.Button("Unjail Player" , nil, { RightLabel = '→'}, true, function(Hovered, Active, Selected) 
                    if Selected then 
                        TriggerServerEvent('Element:UnJailPlayer')
                    end
                end)

            end
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('PoliceMenu', 'objectmenu')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()
            if IsPedInAnyVehicle(GetPlayerPed(-1), false) == false then
                RageUI.List("Spawn Object", listObjects, index.object, nil, {}, true, function(Hovered, Active, Selected, Index)
                    if (Selected) then
                        if IsPedInAnyVehicle(GetPlayerPed(-1), false) == false then
                        spawnObject(objects[Index][2])
                        end
                    end
                    if (Active) then 
                        index.object = Index;
                    end
                end)
                RageUI.Button("Delete Object" , nil, { RightLabel = '→→→'}, true, function(Hovered, Active, Selected) 
                    if Selected then 
                        if IsPedInAnyVehicle(GetPlayerPed(-1), false) == false then
                        deleteObject()
                        end
                    end
                end)
            end
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('PoliceMenu', 'speedzones')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()
            if IsPedInAnyVehicle(GetPlayerPed(-1), false) == false then
                RageUI.List("Radius", radiusnum, index.speedRad, nil, {}, true, function(Hovered, Active, Selected, Index)
                    if (Active) then 
                        index.speedRad = Index;
                        radius = tonumber(radiusnum[Index])
                    end
                end)
                RageUI.List("Speed", speednum, index.speed, nil, {}, true, function(Hovered, Active, Selected, Index)
                    if (Active) then 
                        index.speed = Index;
                        speed = tonumber(speednum[Index])
                    end
                end)
                RageUI.Button("Create Speedzone" , nil, { }, true, function(Hovered, Active, Selected) 
                    if Selected then 
                      createZone()
                    end
                end)
                RageUI.Button("Delete Speedzone" , nil, {}, true, function(Hovered, Active, Selected) 
                    if Selected then 
                        TriggerServerEvent('Element:RemoveZone')
                        notify("Speed zone removed")
                    end
                end)
            end
        end)
    end
end)

RegisterCommand('pd', function()
  if IsPedInAnyVehicle(GetPlayerPed(-1), false) == false then
    TriggerServerEvent('Element:OpenPoliceMenu')
  end
end)

RegisterNetEvent("Element:PoliceMenuOpened")
AddEventHandler("Element:PoliceMenuOpened",function()
  RageUI.Visible(RMenu:Get('PoliceMenu', 'main'), not RageUI.Visible(RMenu:Get('PoliceMenu', 'main')))
end)

function spawnObject(object) 
    local Player = PlayerPedId()
    local heading = GetEntityHeading(Player)
    local x, y, z = table.unpack(GetEntityCoords(Player))
    RequestModel(object)
    while not HasModelLoaded(object) do
      Citizen.Wait(1)
    end
    local obj = CreateObject(GetHashKey(object), x, y, z, true, false);
    PlaceObjectOnGroundProperly(obj)
    SetEntityHeading(obj, heading)
    SetModelAsNoLongerNeeded(GetHashKey(object))
end

function deleteObject() 
  for k, v in pairs(objects) do 
    local theobject1 = v[2]
    local object1 = GetHashKey(theobject1)
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
    if DoesObjectOfTypeExistAtCoords(x, y, z, 2.0, object1, true) then
        local obj1 = GetClosestObjectOfType(x, y, z, 2.0, object1, false, false, false)
        DeleteObject(obj1)
    end
  end
end

function createZone() 
  if radius == 0 then 
    notify("~r~Please set a radius")
    return
  end
  if speed == 0 then 
    notify("~r~Please set a speed")
    return
  end
      speedZoneActive = true
      notify("Created Speed Zone.")
      local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))
      radius = radius + 0.0
      speed = speed + 0.0
  
      local streetName, crossing = GetStreetNameAtCoord(x, y, z)
      streetName = GetStreetNameFromHashKey(streetName)
  
      local message = "^* ^1Traffic Announcement: ^r^*^7MET Police have ordered that traffic on ^2" .. streetName .. " ^7is to travel at a speed of ^2" .. speed .. "mph ^7due to an incident." 
  
      TriggerServerEvent('Element:ActivateZone', message, speed, radius, x, y, z)
end

RegisterNetEvent('Element:ZoneCreated')
AddEventHandler('Element:ZoneCreated', function(speed, radius, x, y, z)

  blip = AddBlipForRadius(x, y, z, radius)
  SetBlipAlpha(blip,80)
  SetBlipSprite(blip,9)
  SetBlipColour(blip,26)
  local speedZone = AddSpeedZoneForCoord(x, y, z, radius, speed, false)

  table.insert(speedzones, {x, y, z, speedZone, blip})

end)

RegisterNetEvent('Element:RemovedBlip')
AddEventHandler('Element:RemovedBlip', function()

    if speedzones == nil then
      return
    end
    local playerPed =PlayerPedId()
    local closestSpeedZone = 0
    local closestDistance = 1000
    for i = 1, #speedzones, 1 do
        local distance = #(vector3(speedzones[i][1], speedzones[i][2], speedzones[i][3]) - GetEntityCoords(playerPed, true))
        if distance < closestDistance then
            closestDistance = distance
            closestSpeedZone = i
        end
    end
    RemoveSpeedZone(speedzones[closestSpeedZone][4])
    RemoveBlip(speedzones[closestSpeedZone][5])
    table.remove(speedzones, closestSpeedZone)

end)


other = nil
drag = false
playerStillDragged = false

RegisterNetEvent("Element:DragPlayer")
AddEventHandler('Element:DragPlayer', function(pl)
    other = pl
    drag = not drag
end)

Citizen.CreateThread(function()
    while true do
        if drag and other ~= nil then
            local ped = GetPlayerPed(GetPlayerFromServerId(other))
            local myped = GetPlayerPed(-1)
            AttachEntityToEntity(myped, ped, 4103, 11816, 0.54, 0.04, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
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

local frozen = false
local unfrozen = false
function tvRP.loadFreeze(notify,god,ghost)
	if not frozen then
	  if notify then
	    vRP.notify({"~r~You've been frozen."})
	  end
	  frozen = true
	  invincible = god
	  invisible = ghost
	  unfrozen = false
	else
	  if notify then
	    vRP.notify({"~g~You've been unfrozen."})
	  end
	  unfrozen = true
	  invincible = false
	  invisible = false
	end
end

RegisterKeyMapping('pd', 'Opens the PD menu', 'keyboard', 'U')

local isInJail = false
v5 = vector3(1779.7868652344,2583.9130859375,45.797805786133)
RegisterNetEvent("stopjail")
AddEventHandler("stopjail", function(source)
	while true do 
		if isInJail == true then 
			if isInArea(v5, 20.4) then 

			else
				SetEntityCoords(PlayerPedId(), 1779.7868652344,2583.9130859375,45.797805786133)
				vRP.notify({"~r~You have be teleported back to prison!"})
			
				
			end
		end 
		Citizen.Wait(0)
	end 
end)

RegisterNetEvent("returnTrue")
AddEventHandler("returnTrue", function(source)

		isInJail = true 

end)

RegisterNetEvent("returnFalse")
AddEventHandler("returnFalse", function(source)

		isInJail = false

end)

RegisterNetEvent('mita:arrestonway')
AddEventHandler('mita:arrestonway', function(target)             -- sa fac rost de asta in server side
	arest_on = true

	local playerPed = GetPlayerPed(-1)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
	RequestAnimDict(variabila3)

	while not HasAnimDictLoaded(variabila3) do
		Citizen.Wait(10)
	end

	AttachEntityToEntity(GetPlayerPed(-1), targetPed, 11816, -0.1, 0.45, 0.0, 0.0, 0.0, 20.0, false, false, false, false, 20, false)
	TaskPlayAnim(playerPed, variabila3, variabila1, 8.0, -8.0, 5500, 33, 0, false, false, false)
	Citizen.Wait(950)
	DetachEntity(GetPlayerPed(-1), true, false)
	arest_on = false
end) 


RegisterNetEvent('radu:arrest')
AddEventHandler('radu:arrest', function()
	local playerPed = GetPlayerPed(-1)
	RequestAnimDict(variabila3)
	while not HasAnimDictLoaded(variabila3) do
		Citizen.Wait(10)
	end
	TaskPlayAnim(playerPed, variabila3, variabila2, 8.0, -8.0, 5500, 33, 0, false, false, false)
	Citizen.Wait(3000)
	arrst = false
end)

RegisterNetEvent('Cuff:Sound')
AddEventHandler('Cuff:Sound', function(netid)
    TriggerServerEvent("Server:SoundToRadius", PlayerId(), 10, "Cuff", 0.5);
end)