RMenu.Add("trafficmenu", "main", RageUI.CreateMenu('Traffic Menu', 'Select category', 1300, 100))
RMenu.Add("trafficmenu", "objects", RageUI.CreateSubMenu(RMenu:Get("trafficmenu", "main"), 'Object Menu', 'Create an object'))
RMenu.Add("trafficmenu", "speedzones", RageUI.CreateSubMenu(RMenu:Get("trafficmenu", "main"), 'Zone Menu', 'Create a speed zone'))

local In_Speed_Zone = false
function tvRP.Is_In_Speed_Zone()
    return In_Speed_Zone
end

local Speed_Zone_Cooldown = 60
local Current_Cooldown = 0

local Active_Speed_Zones = {}
local Creating_Zone_Speed = 0
local Creating_Zone_Radius = 0

local current_index = {
    object = 1,
    separation_distance = 1,
    object_amount = 1,
    object_heading = 1,
    radius = 1,
    speed = 1,
}

local Zone_Radius_Options = {0, 25, 50, 75, 100, 125, 150, 175, 200}
local Zone_Speed_Options = {0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50}

local objects = {
    {"Big Cone", "prop_roadcone01a"},
    {"Small Cone", "prop_roadcone02b"},
    {"Gazebo", "prop_gazebo_02"},
    {"Worklight", "prop_worklight_03b"},
    {"Police Slow", "prop_barrier_work05"},
    {"Gate Barrier", "ba_prop_battle_barrier_02a"},
    {"Concrete Barrier", "prop_mp_barrier_01"},
    {"Concrete Barrier 2", "prop_mp_barrier_01b"},
}

local Object_Distance_Options = {1, 2, 3, 4, 5}
local Object_Amount_Options = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
local Object_Rotation_Options = {'Heading'}
for i = 0, 72 do
    table.insert(Object_Rotation_Options, i * 5)
end

local listObjects = {}
for table_id, prop_info in pairs(objects) do
    listObjects[table_id] = prop_info[1]
end

local Placed_Objects = {}
local function Create_Objects(preview_object)
    local client_ped = PlayerPedId()
    local heading = GetEntityHeading(client_ped)

    local object_model = objects[current_index.object][2]
    local object_hash = GetHashKey(object_model)

    local selected_heading = Object_Rotation_Options[current_index.object_heading]
    if selected_heading == 'Heading' then
        selected_heading = GetEntityHeading(client_ped)
        if object_model == 'prop_worklight_03b' then 
            selected_heading = selected_heading + 180.0
        end
    else
        selected_heading = selected_heading - 360.0
    end

    RequestModel(object_hash)
    while not HasModelLoaded(object_hash) do
        Citizen.Wait(0)
    end

    local forward_distance = 1
    local created_objects = {}
    for i = 1, current_index.object_amount do 
        if i ~= 1 then
            forward_distance = forward_distance + Object_Distance_Options[current_index.separation_distance]
        end
        local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(client_ped, 0, forward_distance + 0.0, 0))
        
        local object_prop = CreateObject(object_hash, x, y, z, preview_object, false)
        if preview_object then
            SetEntityCompletelyDisableCollision(object_prop, false, false)
            SetEntityCollision(object_prop, false, false)
            SetEntityAlpha(object_prop, 150, false)
        else
            table.insert(Placed_Objects, object_prop)
        end

        FreezeEntityPosition(object_prop, true)
        PlaceObjectOnGroundProperly(object_prop)
        SetEntityHeading(object_prop, selected_heading + 0.0)
        table.insert(created_objects, object_prop)
    end

    SetModelAsNoLongerNeeded(object_hash)
    return created_objects
end

local function Delete_All_Placed_Objects()
    for table_index, prop_item in pairs(Placed_Objects) do
        DeleteObject(prop_item)
    end
    Placed_Objects = {}
end

local Preview_Objects = {}
local function Delete_Nearby_Object()
    for table_index, prop_info in pairs(objects) do
        local prop_model = prop_info[2]
        local prop_hash = GetHashKey(prop_model)

        local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
        if DoesObjectOfTypeExistAtCoords(x, y, z, 2.0, prop_hash, true) then
            local prop_item = GetClosestObjectOfType(x, y, z, 2.0, prop_hash, false, false, false)
            DeleteObject(prop_item)
        end
    end
end

local function Delete_Preview_Objects()
    if #Preview_Objects > 0 then
        for table_index, object_item in pairs(Preview_Objects) do
            DeleteObject(object_item)
            Preview_Objects = {}
        end
    end
end

local function Create_Preview_Objects()
    Delete_Preview_Objects()
    Preview_Objects = Create_Objects(true)
end

local function Create_Speed_Zone()
    if Creating_Zone_Radius == 0 then
        return tvRP.notify("~r~Please set a radius")
    end

    if Creating_Zone_Speed == 0 then
        return tvRP.notify("~r~Please set a speed")
    end

    local faction
    local clocked_faction
    if tvRP.IsLFB() then
        faction = 'London Fire Brigade'
        clocked_faction = 'LFB'
    elseif tvRP.IsNHS() then
        faction = 'National Health Service'
        clocked_faction = 'NHS'
    elseif tvRP.IsMPD() then
        faction = 'Metropolitan Police'
        clocked_faction = 'MPD'
    else
        return tvRP.notify('~r~You should not be using this menu')
    end

    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
    Creating_Zone_Radius = Creating_Zone_Radius + 0.0
    Creating_Zone_Speed = Creating_Zone_Speed + 0.0

    local street_name, crossing = GetStreetNameAtCoord(x, y, z)
    street_name = GetStreetNameFromHashKey(street_name)

    local announcement = ("The %s has ordered that traffic on ^2%s ^7is to travel at a speed of ^2%s MPH ^7due to an incident"):format(faction, street_name, Creating_Zone_Speed)
    TriggerServerEvent("Nova:Server:AddSpeedZone", x, y, z, Creating_Zone_Radius, Creating_Zone_Speed, announcement, clocked_faction, street_name)

    local colour = exports['vrp']:Get_Faction_Notification_Colour(clocked_faction)
    tvRP.SendHoursInformation(colour, 'Zone Created', ('Radius: %s Metres\nSpeed: %s MPH'):format(Creating_Zone_Radius, Creating_Zone_Speed))

    Creating_Zone_Radius = 0
    Creating_Zone_Speed = 0

    Current_Cooldown = Speed_Zone_Cooldown
    Citizen.CreateThread(function()
        while Current_Cooldown ~= 0 do
            Citizen.Wait(1000)
            Current_Cooldown = Current_Cooldown - 1
        end
    end)
end

local Preview_Blip = nil
local function Create_Preview_Zone()
    if Preview_Blip then
        RemoveBlip(Preview_Blip)
    end

    Preview_Blip = AddBlipForRadius(GetEntityCoords(PlayerPedId()), Creating_Zone_Radius + 0.0)
    SetBlipAlpha(Preview_Blip, 80)
    SetBlipSprite(Preview_Blip, 9)
    SetBlipColour(Preview_Blip, 26)
end

local function Delete_Preview_Zone()
    if Preview_Blip then
        RemoveBlip(Preview_Blip)
        Preview_Blip = nil
    end
end

local function Get_Closest_Speed_Zone(client_ped)
    local client_coords = GetEntityCoords(client_ped)
    for zone_id, zone_info in pairs(Active_Speed_Zones) do
        if zone_info then
            local zone_radius = zone_info.Radius
            local zone_position = zone_info.Position

            if #(client_coords - zone_position) <= zone_radius then
                In_Speed_Zone = true
                return zone_id, zone_info.Speed
            end
        end
    end

    In_Speed_Zone = false
    return false
end

RegisterNetEvent("Nova:Client:AddSpeedZone")
AddEventHandler("Nova:Client:AddSpeedZone", function(zone_id, x, y, z, radius, speed)
    local blip = AddBlipForRadius(x, y, z, radius)
    SetBlipAlpha(blip, 80)
    SetBlipSprite(blip, 9)
    SetBlipColour(blip, 26)

    Active_Speed_Zones[zone_id] = {Position = vector3(x, y, z), Radius = radius, Speed = speed, Blip = blip}
end)

RegisterNetEvent("Nova:Client:RemoveSpeedZone")
AddEventHandler("Nova:Client:RemoveSpeedZone", function(zone_id)
    local zone_info = Active_Speed_Zones[zone_id]
    if zone_info  then
        RemoveBlip(zone_info.Blip)
        Active_Speed_Zones[zone_id] = nil
    end
end)

RegisterNetEvent('Nova:Client:GetActiveSpeedZones')
AddEventHandler('Nova:Client:GetActiveSpeedZones', function(existing_zones)
    for zone_id, zone_info in pairs(existing_zones) do
        if zone_info then
            TriggerEvent('Nova:Client:AddSpeedZone', zone_id, zone_info.zone_x, zone_info.zone_y, zone_info.zone_z, zone_info.zone_radius, zone_info.zone_speed)
        end
    end
end)

RegisterCommand('trafficmenu', function()
    if tvRP.IsLFB() or tvRP.IsNHS() or tvRP.IsMPD() then
        RageUI.Visible(RMenu:Get('trafficmenu', 'main'), not RageUI.Visible(RMenu:Get('trafficmenu', 'main')))
    else
        tvRP.notify('~r~You do not have access to the trafficmenu')
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get("trafficmenu", "main")) then
        Delete_Preview_Objects()
        Delete_Preview_Zone()

        RageUI.DrawContent({header = true, glare = false, instructionalButton = true}, function()
            if not IsPedInAnyVehicle(PlayerPedId(), false) then
                RageUI.Button("Object Menu", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                end, RMenu:Get("trafficmenu", "objects"))

                RageUI.Button("Zone Menu", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                end, RMenu:Get("trafficmenu", "speedzones"))
            else
                RageUI.Visible(RMenu:Get("trafficmenu", "main"), false)
                tvRP.notify('~r~You may not use this whilst in a vehicle')
            end
        end)
    
    elseif RageUI.Visible(RMenu:Get("trafficmenu", "objects")) then
        Delete_Preview_Zone()

        RageUI.DrawContent({header = true, glare = false, instructionalButton = true}, function()
            if not IsPedInAnyVehicle(PlayerPedId(), false) then
                RageUI.List("Select Object", listObjects, current_index.object, nil, {}, true, function(Hovered, Active, Selected, Index)
                    if (Active) then
                        current_index.object = Index
                        Create_Preview_Objects()
                    end
                end)

                RageUI.List('Select Heading', Object_Rotation_Options, current_index.object_heading, nil, {}, true, function(Hovered, Active, Selected, Index)
                    if (Active) then
                        current_index.object_heading = Index
                        Create_Preview_Objects()
                    end
                end)

                RageUI.List('Select Amount', Object_Amount_Options, current_index.object_amount, nil, {}, true, function(Hovered, Active, Selected, Index)
                    if (Active) then
                        current_index.object_amount = Index
                        Create_Preview_Objects()
                    end
                end)

                if current_index.object_amount > 1 then
                    RageUI.List('Separation Distance', Object_Distance_Options, current_index.separation_distance, nil, {}, true, function(Hovered, Active, Selected, Index)
                        if (Active) then
                            current_index.separation_distance = Index
                            Create_Preview_Objects()
                        end
                    end)
                    RageUI.Menus:RefreshIndex()
                else
                    current_index.separation_distance = 1
                end

                RageUI.Button('Create Object', nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        Delete_Preview_Objects()
                        Create_Objects(false)

                    elseif Active then
                        Create_Preview_Objects()
                    end
                end)

                RageUI.Button("Delete Object", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        Delete_Preview_Objects()
                        Delete_Nearby_Object()
                    
                    elseif Active then
                        Delete_Preview_Objects()
                    end
                end)

                if #Placed_Objects > 0 then
                    RageUI.Button("Delete All Objects", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            Delete_All_Placed_Objects()

                        elseif Active then
                            Delete_Preview_Objects()
                        end
                    end)
                    RageUI.Menus:RefreshIndex()
                end
            else
                RageUI.Visible(RMenu:Get("trafficmenu", "objects"), false)
            end
        end)

    elseif RageUI.Visible(RMenu:Get("trafficmenu", "speedzones")) then
        Delete_Preview_Objects()

        RageUI.DrawContent({header = true, glare = false, instructionalButton = true}, function()
            if not IsPedInAnyVehicle(PlayerPedId(), false) then
                RageUI.List("Select Radius", Zone_Radius_Options, current_index.radius, nil, {RightLabel = 'Metres'}, true, function(Hovered, Active, Selected, Index)
                    if (Active) then
                        if current_index.radius ~= Index then
                            current_index.radius = Index
                            Creating_Zone_Radius = Zone_Radius_Options[Index]
                            Create_Preview_Zone()
                        else
                            if not Preview_Blip or GetBlipCoords(Preview_Blip) ~= GetEntityCoords(PlayerPedId()) then
                                Creating_Zone_Radius = Zone_Radius_Options[Index]
                                Create_Preview_Zone()
                            end
                        end
                    end
                end)

                RageUI.List("Select Speed", Zone_Speed_Options, current_index.speed, nil, {RightLabel = 'MPH'}, true, function(Hovered, Active, Selected, Index)
                    if (Active) then
                        if current_index.speed ~= Index then
                            current_index.speed = Index
                            Creating_Zone_Speed = Zone_Speed_Options[Index]
                            Create_Preview_Zone()
                        else
                            if not Preview_Blip or GetBlipCoords(Preview_Blip) ~= GetEntityCoords(PlayerPedId()) then
                                Create_Preview_Zone()
                            end
                        end
                    end
                end)

                RageUI.Button("Create Speedzone", nil, {}, true, function(Hovered, Active, Selected)
                    if Selected then
                        if Current_Cooldown > 0 then
                            tvRP.notify(('~r~You must wait %s seconds before creating another zone'):format(Current_Cooldown))
                        else
                            local zone_id, zone_speed = Get_Closest_Speed_Zone(PlayerPedId())
                            if zone_id and zone_speed then
                                tvRP.notify('~r~There is already a speed zone here')
                            else
                                Delete_Preview_Zone()
                                Create_Speed_Zone()
                            end
                        end

                    elseif Active then
                        Create_Preview_Zone()
                    end
                end)

                RageUI.Button("Delete Speedzone", nil, {}, true, function(Hovered, Active, Selected)
                    if Selected then
                        Delete_Preview_Zone()
                        
                        local zone_id, zone_speed = Get_Closest_Speed_Zone(PlayerPedId())
                        if zone_id and zone_speed then
                            TriggerServerEvent("Nova:Server:RemoveSpeedZone", zone_id)
                            notify("Speed zone removed")
                        else
                            tvRP.notify('~r~There is no speed zone here')
                        end
                    
                    elseif Active then
                        Delete_Preview_Zone()
                    end
                end)
            else
                RageUI.Visible(RMenu:Get("trafficmenu", "speedzones"), false)
            end
        end)
    end
end)

Citizen.CreateThread(function()
    TriggerServerEvent('Nova:Server:GetActiveSpeedZones')

    while true do
        local client_ped = PlayerPedId()
        local client_vehicle = GetVehiclePedIsIn(client_ped, false)

        if client_vehicle ~= 0 then
            local zone_id, zone_speed = Get_Closest_Speed_Zone(client_ped)
            if zone_id and zone_speed then
                SetEntityMaxSpeed(client_vehicle, zone_speed / 2.237) -- Speed is in Metres per second so calculate MPH
            end
        end

        Citizen.Wait(200)
    end
end)