RMenu.Add("smallarms", "main", RageUI.CreateMenu("", "~r~Nova Small Arms", 1300, 50, "shopui_title_gr_gunmod", "shopui_title_gr_gunmod"))
RMenu.Add("smallarms", "confirm", RageUI.CreateSubMenu(RMenu:Get("smallarms", "main", 1300, 50)), '', 'Are you sure?')

local config = module('vrp', 'sharedcfg/cfg_smallarms')

local function Send_Alert(msg)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayHelp(0, false, true, 1000)
end

local function Get_Nearest_Position(client_coords)
    for location_name, location_info in pairs(config.locations) do
        local position = location_info.position
        local position_distance = #(client_coords - position)
        if position_distance <= config.marker_range then
            return {name = location_name, distance = position_distance, coords = position}
        end
    end

    return false
end

Citizen.CreateThread(function()
    for location_name, location_info in pairs(config.locations) do
        local blip = AddBlipForCoord(location_info.position)
        SetBlipSprite(blip, config.blip_sprite)
        SetBlipColour(blip, config.blip_colour)
        SetBlipScale(blip, config.blip_scale)
        SetBlipDisplay(blip, config.blip_display)
        SetBlipAsShortRange(blip, config.blip_short_range)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName("Small Arms")
        EndTextCommandSetBlipName(blip)
    end
end)

local Current_Location = nil
local Selected_Category = nil
local Selected_Item = nil
local Drawing_Menu = false
local function Menu_Enabled_Thread()
    if Drawing_Menu then
        return
    end
    Drawing_Menu = true

    Citizen.CreateThread(function()
        while Current_Location do
            if RageUI.Visible(RMenu:Get('smallarms', 'main')) then
                RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
                    local location_info = config.locations[Current_Location]
                    if location_info then
                        for weapon_name, weapon_info in pairs(location_info.weapons) do
                            RageUI.Button(weapon_info.name, nil, {RightLabel = ('£%s'):format(shared_functions.Get_Formatted_Money(weapon_info.price))}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    Selected_Category = 'weapon'
                                    Selected_Item = weapon_info.hash
                                end
                            end, RMenu:Get('smallarms', 'confirm'))
                        end
        
                        for armour_percentage, armour_info in pairs(location_info.armour) do
                            RageUI.Button(armour_info.name, nil, {RightLabel = ('£%s'):format(shared_functions.Get_Formatted_Money(armour_info.price))}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    Selected_Category = 'armour'
                                    Selected_Item = armour_info.name
                                end
                            end, RMenu:Get('smallarms', 'confirm'))
                        end
                    end
                end)
        
            elseif RageUI.Visible(RMenu:Get('smallarms', 'confirm')) then
                RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
                    RageUI.Button('Confirm purchase?', nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local client_ped = PlayerPedId()
                            if Selected_Category == 'weapon' then
                                local has_weapon = HasPedGotWeapon(client_ped, Selected_Item, false)
                                if has_weapon then
                                    if GetAmmoInPedWeapon(client_ped, Selected_Item) >= 250 then
                                        return tvRP.notify('~r~You already have max ammo')
                                    end
                                end
                                TriggerServerEvent('Nova:Smallarms:Server:PurchaseWeapon', Current_Location, Selected_Item, has_weapon)
                            elseif Selected_Category == 'armour' then
                                local armour_info = config.Get_Armour_Info(Selected_Item)
                                if armour_info then
                                    local armour_amount = armour_info.value
                                    if GetPedArmour(client_ped) >= armour_amount then
                                        tvRP.notify('~r~You already have ' .. Selected_Item)
                                    else
                                        TriggerServerEvent('Nova:Smallarms:Server:PurchaseArmour', Current_Location, Selected_Item)
                                    end
                                else
                                    tvRP.notify('~r~Something went wrong while retrieving armour info')
                                end
                            end
                        end
                    end, RMenu:Get('smallarms', 'main'))
        
                    RageUI.Button('Cancel', nil, {}, true, function(Hovered, Active, Selected)
                    end, RMenu:Get('smallarms', 'main'))
                end)

            else
                break
            end
            
            Citizen.Wait(1.0)
        end
        Drawing_Menu = false
    end)
end

local Nearest_Marker_Position = nil
local Near_Shop = false
local Drawing_Marker = false
local function Draw_Marker_Thread()
    if Drawing_Marker then
        return
    end
    Drawing_Marker = true

    Citizen.CreateThread(function()
        while Nearest_Marker_Position do
            DrawMarker(
                config.marker_type, -- Marker Type
                Nearest_Marker_Position.x, Nearest_Marker_Position.y, Nearest_Marker_Position.z - 0.9, -- Marker Position
                0, 0, 0, -- Marker Direction
                0, 0, 0, -- Marker Rotation
                0.8, 0.8, 0.8, -- Marker Scale
                255, 0, 0, 255, -- RGBA
                false, -- Bob up and down
                false, -- Face Camera
                0, -- P19 Number
                true -- Rotate
            )
    
            if Near_Shop then
                if IsControlJustPressed(0, config.menu_open_key) then
                    Menu_Enabled_Thread()
                    RageUI.Visible(RMenu:Get('smallarms', 'main'), not RageUI.Visible(RMenu:Get('smallarms', 'main')))
                end
            end
    
            Citizen.Wait(0)
        end
        Drawing_Marker = false
    end)
end

local Sent_Notification = false
Citizen.CreateThread(function()
    while true do
        local client_ped = PlayerPedId()
        local client_coords = GetEntityCoords(client_ped)

        local nearest_info = Get_Nearest_Position(client_coords)
        if nearest_info then
            Nearest_Marker_Position = nearest_info.coords
            Draw_Marker_Thread()

            if nearest_info.distance <= config.menu_range then
                Current_Location = nearest_info.name
                Near_Shop = true
                if not Sent_Notification then
                    Sent_Notification = true
                    Send_Alert('Press ~INPUT_VEH_HORN~ to open shop')
                end
            else
                if RageUI.Visible(RMenu:Get('smallarms', 'confirm')) then
                    RageUI.Visible(RMenu:Get('smallarms', 'confirm'), false)
                end

                if RageUI.Visible(RMenu:Get('smallarms', 'main')) then
                    RageUI.Visible(RMenu:Get('smallarms', 'main'), false)
                end

                Near_Shop = false
                Sent_Notification = false
                Current_Location = nil
            end
        else
            Nearest_Marker_Position = nil
            Near_Shop = false
            Sent_Notification = false
            Current_Location = nil
        end

        Citizen.Wait(1000)
    end
end)