RMenu.Add("dutymenu", "LFB", RageUI.CreateMenu("LFB", "LFB Duty Menu", 1250, 100))
RMenu.Add("dutymenu", "NHS", RageUI.CreateMenu("NHS", "NHS Duty Menu", 1250, 100))
RMenu.Add("dutymenu", "HMP", RageUI.CreateMenu("HMP", "HMP Duty Menu", 1250, 100))
RMenu.Add("dutymenu", "MPD", RageUI.CreateMenu("", "MPD Duty Menu", 1250, 100, 'banners', 'police'))

local config = module('vrp', 'factions/dutymenu/cfg_dutymenu')
local Duty_Groups = config.duty_groups
local Duty_Menu_Locations = config.duty_menu_locations
local Faction_Functions = config.faction_functions
local Suspended_Functions = config.suspended_functions

local Selected_Faction = nil
RageUI.CreateWhile(1.0, true, function()
    if Selected_Faction and RageUI.Visible(RMenu:Get('dutymenu', Selected_Faction)) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
            for table_index, table_info in pairs(Duty_Groups[Selected_Faction]) do
                local group_name = table_info[1]
                local group_clocked_name = table_info[2]
                local text_colour = table_info[4] or ''
                
                RageUI.Button(('%s%s'):format(text_colour, group_name), nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local suspended_function = Suspended_Functions[Selected_Faction]
                        if suspended_function() then
                            tvRP.notify(('~r~You may not clock on %s whilst suspended'):format(Selected_Faction))
                        else
                            TriggerServerEvent("Nova:Server:DutyMenu:ClockOn", group_clocked_name)
                        end
                    end
                end)
            end

            RageUI.Button('~r~Clock Off', nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent("Nova:Server:DutyMenu:ClockOff", Selected_Faction)
                end
            end)
        end)
    end
end)


local function Draw_Clock_Station_Marker(position)
    local x, y, z = table.unpack(position)
    DrawMarker(
        27, -- Marker type (https://docs.fivem.net/docs/game-references/markers/)
        vector3(x, y, z - 0.9), -- Marker Coordinates
        0, 0, 0, -- Direction x, y, z
        0, 0, 0, -- Rotation x, y, z
        0.8, 0.8, 0.8, -- Marker scale / size: x, y, z
        255, 0, 0, 150, -- Marker Colour (RGBA), Red, Green, Blue, Alpha
        false, -- Boolean bob up and down
        false, -- Boolean face camera
        0, -- P19 Number
        true, -- Boolean rotate
        nil, -- texture dict
        nil, -- texture name
        false -- Draw on entities 
    )
end

local currentNhsDutyMenu = nil
local close_enough = false

local Menu_Open_Key = config.Menu_Open_Key
local Menu_Open_Proximity = config.Menu_Open_Proximity
local Extended_Proximity =  config.Extended_Proximity

Citizen.CreateThread(function()
    while true do
        for faction_name, faction_coords_table in pairs(Duty_Menu_Locations) do
            for position_name, duty_position in pairs(faction_coords_table) do
                local has_permission_function = Faction_Functions[faction_name]
                if has_permission_function() then
                    if Is_In_Area(duty_position, 50.0) then
                        Draw_Clock_Station_Marker(duty_position)

                        if Is_In_Area(duty_position, Menu_Open_Proximity) then
                            if not RageUI.Visible(RMenu:Get('dutymenu', faction_name)) then
                                Send_Alert(("Press ~INPUT_VEH_HORN~ to open %s Duty Menu"):format(faction_name))

                                if IsControlJustPressed(0, Menu_Open_Key) then
                                    Selected_Faction = faction_name
                                    RageUI.Visible(RMenu:Get('dutymenu', faction_name), true)
                                end
                            end
                        else
                            if Is_In_Area(duty_position, Extended_Proximity) then
                                if RageUI.Visible(RMenu:Get('dutymenu', faction_name)) then
                                    Selected_Faction = nil
                                    RageUI.Visible(RMenu:Get('dutymenu', faction_name), false)
                                end
                            end
                        end
                    end
                else
                    if RageUI.Visible(RMenu:Get('dutymenu', faction_name)) then
                        Selected_Faction = nil
                        RageUI.Visible(RMenu:Get('dutymenu', faction_name), false)
                    end
                end
            end
        end

        Citizen.Wait(0)
    end
end)

function Is_In_Area(other_coords, distance)
    return #(GetEntityCoords(PlayerPedId()) - other_coords) <= distance -- Returns true if close enough else false
end

function Send_Alert(msg)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayHelp(0, false, true, -1)
end

RegisterNetEvent('Nova:Client:GetWhitelistedFactions')
AddEventHandler('Nova:Client:GetWhitelistedFactions', function(whitelisted_values)
    tvRP.Set_LFB_Permission(whitelisted_values['LFB'])
    tvRP.Set_NHS_Permission(whitelisted_values['NHS'])
    tvRP.Set_HMP_Permission(whitelisted_values['HMP'])
    tvRP.Set_MPD_Permission(whitelisted_values['MPD'])
end)

Citizen.CreateThread(function()
    Citizen.Wait(1000)
    TriggerServerEvent('Nova:Server:DutyMenu:GetWhitelistedFactions')
end)