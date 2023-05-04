RMenu.Add("PoliceMenu", "small_arms", RageUI.CreateMenu("", "~b~Nova Police Armoury", 1300, 50, "police", "police"))
RMenu.Add("PoliceMenu", "large_arms",  RageUI.CreateMenu("", "~b~Nova Police Armoury", 1300, 50, "police", "police"))
RMenu.Add('PoliceMenu', 'confirm_purchase', RageUI.CreateMenu("", "~b~Nova Police Armoury", 1300, 50, "police", "police"))

local shared_config = module('vrp', 'factions/mpd/cfg_mpd')
SetFlashLightKeepOnWhileMoving(shared_config.keep_flash_light_while_moving)

local current_weapon_hash = nil
local previous_menu = nil
local pressed_weapon = false
RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get("PoliceMenu", "small_arms")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = true}, function()
            for i, weapon_info in pairs(shared_config.small_arms_weapons) do
                RageUI.Button(weapon_info.name, nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        current_weapon_hash = weapon_info.hash
                        previous_menu = 'small_arms'
                    end
                end, RMenu:Get("PoliceMenu", "confirm_purchase"))
            end
        end)

    elseif RageUI.Visible(RMenu:Get("PoliceMenu", "large_arms")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = true}, function()
            for i, weapon_info in pairs(shared_config.large_arms_weapons) do
                RageUI.Button(weapon_info.name, nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        current_weapon_hash = weapon_info.hash
                        previous_menu = 'large_arms'
                    end
                end, RMenu:Get("PoliceMenu", "confirm_purchase"))
            end
        end)
     
    elseif RageUI.Visible(RMenu:Get("PoliceMenu", "confirm_purchase")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = true}, function()
            RageUI.Button("Confirm", nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                if Selected then
                    local client_ped = PlayerPedId()
                    if HasPedGotWeapon(client_ped, current_weapon_hash, false) then
                        SetPedAmmo(client_ped, current_weapon_hash, shared_config.police_ammo_count)
                        TriggerEvent("Nova:PlaySound", 1)
                        tvRP.notify('~g~Purchased ammo')
                    else
                        TriggerServerEvent("Police:Server:GetWeapon", current_weapon_hash)
                    end
                end
            end, RMenu:Get("PoliceMenu", previous_menu))

            RageUI.Button("Decline", nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
            end, RMenu:Get("PoliceMenu", previous_menu))
        end)
    end
end)

local function Create_Marker(marker_type, marker_coords, colour_r, colour_g, colour_b, colour_a)
    DrawMarker(
        marker_type, -- Marker type (https://docs.fivem.net/docs/game-references/markers/)
        marker_coords, -- Marker Coordinates
        0, 0, 0, -- Direction x, y, z
        0, 0, 0, -- Rotation x, y, z
        0.8, 0.8, 0.8, -- Marker scale / size: x, y, z
        colour_r, colour_g, colour_b, colour_a, -- Marker Colour (RGBA), Red, Green, Blue, Alpha
        false, -- Boolean bob up and down
        false, -- Boolean face camera
        0, -- P19 Number
        true, -- Boolean rotate
        nil, -- texture dict
        nil, -- texture name
        false -- Draw on entities
    )
end

local armour_wait_after_use = 5
local armour_cooldown = 0
local function Get_Client_Police_Armour()
    if GetPedArmour(PlayerPedId()) <= 99 then
        TriggerServerEvent("Police:Server:GetArmour")
        armour_cooldown = armour_wait_after_use
        Citizen.CreateThread(function()
            while armour_cooldown ~= 0 do
                Citizen.Wait(1000)
                armour_cooldown = armour_cooldown - 1
            end
        end)
    else
        notify("~r~You already have max armour")
    end
end

local input_key_e = 51
Citizen.CreateThread(function()
    while true do
        if tvRP.IsMPD() then
            local client_ped = PlayerPedId()
            local client_coords = GetEntityCoords(client_ped)

            for _, item_info_table in pairs(shared_config.item_shop) do
                for i, item_details in pairs(item_info_table) do
                    local item_coords = vector3(item_details.x, item_details.y, item_details.z)
                    Create_Marker(
                        item_details.marker_type, item_coords,
                        item_details.r, item_details.g, item_details.b, item_details.a
                    )

                    local item_type = item_details.item_type
                    local player_menu_distance =  #(client_coords - item_coords)
                    if player_menu_distance <= item_details.range then
                        if item_type == 'weapon' then
                            if not RageUI.Visible(RMenu:Get('PoliceMenu', item_details.menu_name)) and not RageUI.Visible(RMenu:Get("PoliceMenu", "confirm_purchase")) then
                                Send_Alert("Press ~INPUT_VEH_HORN~ to open locker")
                                if IsControlJustPressed(0, input_key_e) then
                                    RageUI.Visible(RMenu:Get('PoliceMenu', item_details.menu_name), true)
                                    break
                                end
                            end
                        else
                            Send_Alert('Press ~INPUT_VEH_HORN~ to get armour')
                            if IsControlJustPressed(0, input_key_e) then
                                if armour_cooldown == 0 then
                                    Get_Client_Police_Armour()
                                else
                                    tvRP.notify(('~r~You must wait %s more seconds to get armour'):format(armour_cooldown))
                                end
                                break
                            end
                        end
                    else
                        if player_menu_distance <= item_details.range * 2 then
                            if RageUI.Visible(RMenu:Get('PoliceMenu', item_details.menu_name)) then
                                RageUI.Visible(RMenu:Get('PoliceMenu', item_details.menu_name), false)
                            end
                        end
                    end
                end
            end

            Citizen.Wait(0)
        else
            Citizen.Wait(2000) -- Wait 2 seconds if not cop
        end
    end
end)

function Send_Alert(msg)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayHelp(0, false, true, -1)
end