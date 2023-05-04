local config = module('vrp', 'factions/dutymenu/cfg_dutymenu')

local function Get_User_Clocked_Ranks(user_id) -- Retrieves all the ranks that the user is clocked on as
    local clocked_on = false
    local clocked_ranks = {}

    for faction_name, faction_groups_table in pairs(config.duty_groups) do
        for table_index, groups_table in pairs(faction_groups_table) do
            local group_clocked_name = groups_table[2]
            if vRP.hasGroup(user_id, group_clocked_name) then
                clocked_on = true
                clocked_ranks[group_clocked_name] = faction_name
            end
        end
    end

    if clocked_on then
        return clocked_ranks
    else
        return nil
    end
end
exports('Get_User_Clocked_Ranks', Get_User_Clocked_Ranks)

RegisterServerEvent("Nova:Server:DutyMenu:ClockOn")
AddEventHandler("Nova:Server:DutyMenu:ClockOn", function(selected_group_name)
    local source = source
    local group_information = config.Get_Group_Permission(selected_group_name)
    if group_information then
        local faction_name, rank_name, permission = table.unpack(group_information)
        local client_coords = GetEntityCoords(GetPlayerPed(source))
        if config.Is_Near_Duty_Point(faction_name, client_coords) then
            local user_id = vRP.getUserId(source)
            if not user_id then
                vRPclient.notify(source, {"~r~You are a nil User ID, please relog"})

            elseif not vRP.hasPermission(user_id, permission) then
                vRPclient.notify(source, {"~r~Hey! You aren't allowed to clock on as that rank"})

            elseif vRP.hasGroup(user_id, selected_group_name) then
                vRPclient.notify(source, {("~r~You are already clocked on as %s"):format(rank_name)})
            
            elseif not vRP.hasGroup(user_id, selected_group_name) then
                exports.vrp:Clock_Off_All_Ranks(source, selected_group_name)
                vRP.addUserGroup(user_id, selected_group_name)
                vRPclient.notify(source, {"~b~You have clocked on as a " .. rank_name})

                local user_discord_id = exports['Discord-Groups']:Get_Client_Discord_ID(source)
                exports.vrp:Save_Faction_Hours(user_id, GetPlayerName(source), user_discord_id, faction_name, rank_name)
            end
        else
            -- Anticheat ban here
        end
    else
        vRPclient.notify(source, {'~r~Requested Clock on rank was not found'})
    end
end)

RegisterServerEvent("Nova:Server:DutyMenu:ClockOff")
AddEventHandler("Nova:Server:DutyMenu:ClockOff", function(selected_faction, player_server_id)
    local source = source
    if player_server_id then
        if source == '' or source == 0 or source == nil then
            source = player_server_id
        end
    end

    if not player_server_id then
        local client_coords = GetEntityCoords(GetPlayerPed(source))
        if not config.Is_Near_Duty_Point(selected_faction, client_coords) then
            -- Anticheat ban here
        end
    end
    
    local user_id = vRP.getUserId(source)
    local clocked_ranks = Get_User_Clocked_Ranks(user_id)
    if clocked_ranks then
        for rank_name, faction_name in pairs(clocked_ranks) do
            vRP.removeUserGroup(user_id, rank_name)
        end

        if selected_faction == 'MPD' then
            TriggerClientEvent('MPD:Client:RemovePoliceWeapons', source)
        end

        if player_server_id then
            vRPclient.notify(source, {"You have been clocked off due to a suspension"})
        else
            vRPclient.notify(source, {"You have clocked off"})
        end

        local user_discord_id = exports['Discord-Groups']:Get_Client_Discord_ID(source)
        exports.vrp:Save_Faction_Hours(user_id, GetPlayerName(source), user_discord_id)
    else
        if not player_server_id then
            vRPclient.notify(source, {"You are not clocked on"})
        end
    end
end)

RegisterNetEvent('Nova:Server:DutyMenu:GetWhitelistedFactions')
AddEventHandler('Nova:Server:DutyMenu:GetWhitelistedFactions', function(player_server_id, modified_group)
    local source = source
    if player_server_id then
        source = player_server_id
    end

    local user_id = vRP.getUserId(source)
    if modified_group then
        local faction_name, reversed_group = config.Get_Reverse_Group(modified_group)
        if faction_name and reversed_group then
            if vRP.hasGroup(user_id, reversed_group) then
                vRP.removeUserGroup(user_id, reversed_group)
                local user_discord_id = exports['Discord-Groups']:Get_Client_Discord_ID(source)
                exports.vrp:Save_Faction_Hours(user_id, GetPlayerName(source), user_discord_id)
            end
        end
    end

    local whitelisted_values = {}
    local lfb_clock_permission = vRP.hasPermission(user_id, 'lfb_clockon.menu')
    whitelisted_values['LFB'] = lfb_clock_permission

    local nhs_clock_permission = vRP.hasPermission(user_id, 'nhs_clockon.menu')
    whitelisted_values['NHS'] = nhs_clock_permission

    local hmp_clock_permission = vRP.hasPermission(user_id, 'hmp_clockon.menu')
    whitelisted_values['HMP'] = hmp_clock_permission

    local mpd_clock_permission = vRP.hasPermission(user_id, 'mpd_clockon.menu')
    whitelisted_values['MPD'] = mpd_clock_permission

    TriggerClientEvent('Nova:Client:GetWhitelistedFactions', source, whitelisted_values)

    if not lfb_clock_permission then
        exports.vrp:Clock_Off_All_Ranks(source, nil, 'LFB')
    end

    if not nhs_clock_permission then
        exports.vrp:Clock_Off_All_Ranks(source, nil, 'NHS')
    end

    if not hmp_clock_permission then
        exports.vrp:Clock_Off_All_Ranks(source, nil, 'HMP')
    end

    if not mpd_clock_permission then
        exports.vrp:Clock_Off_All_Ranks(source, nil, 'MPD')
    end
end)