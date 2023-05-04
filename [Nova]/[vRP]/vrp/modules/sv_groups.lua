local Groups = module('vrp', "cfg/groups")
local Job_Groups = Groups.Job_Groups

RegisterNetEvent("Nova:Server:GroupsMenu:GetGroups")
AddEventHandler("Nova:Server:GroupsMenu:GetGroups", function(player_server_id)
    local source = source
    if player_server_id then
        source = player_server_id
    end

    local user_id = vRP.getUserId(source)

    local legal_groups = {}
    for table_index, group_name in ipairs(Job_Groups.Legal) do
        if vRP.hasGroup(user_id, group_name) then
            legal_groups[group_name] = true
        end
    end

    local illegal_groups = {}
    for table_index, group_name in ipairs(Job_Groups.Illegal) do
        if vRP.hasGroup(user_id, group_name) then
            illegal_groups[group_name] = true
        end
    end

    TriggerClientEvent("Nova:Client:GroupsMenu:ReturnGroups", source, legal_groups, illegal_groups)
end)

RegisterNetEvent('Nova:Server:GroupsMenu:RemoveGroup')
AddEventHandler('Nova:Server:GroupsMenu:RemoveGroup', function(selected_group)
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasGroup(user_id, selected_group) then
        vRP.removeUserGroup(user_id, selected_group)
        TriggerEvent('Nova:Server:GroupsMenu:GetGroups', source)
        TriggerClientEvent('Nova:Client:GroupsMenu:GroupRemoved', source, selected_group)
    else
        vRPclient.notify('~r~You are trying to remove a group you do not have')
    end
end)