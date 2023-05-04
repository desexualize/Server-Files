RMenu.Add("GroupsMenu", "main", RageUI.CreateMenu("", "Nova Group Display", 1300, 100, "group", "group"))
RMenu.Add('GroupsMenu', 'selectedgroup', RageUI.CreateSubMenu(RMenu:Get('GroupsMenu', 'main'), "", 'Nova Group Options', 1300, 100, 'group', 'group'))
RMenu.Add('GroupsMenu', 'confirm', RageUI.CreateSubMenu(RMenu:Get('GroupsMenu', 'selectedgroup'), "", 'Are you sure?', 1300, 100, 'group', 'group'))

local Legal_Groups = {}
local Illegal_Groups = {}
local Selected_Group = nil

local function Is_Table_Empty(table_object)
    for _ in pairs(table_object) do
        return false
    end
    return true
end

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get("GroupsMenu", 'main')) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
            local legal_empty = Is_Table_Empty(Legal_Groups)
            local illegal_empty = Is_Table_Empty(Illegal_Groups)

            if not legal_empty or not illegal_empty then
                if not legal_empty then
                    RageUI.Separator('~g~Legal Groups')
                    for group_name, bool_value in pairs(Legal_Groups) do
                        RageUI.Button(group_name, nil, {RightLabel = '>>>'}, true, function(Hovered, Active, Selected)
                            if Selected then
                                Selected_Group = group_name
                            end
                        end, RMenu:Get('GroupsMenu', 'selectedgroup'))
                    end
                end

                if not illegal_empty then
                    RageUI.Separator('~r~Illegal Groups')
                    for group_name, bool_value in pairs(Illegal_Groups) do
                        RageUI.Button(group_name, nil, {RightLabel = '>>>'}, true, function(Hovered, Active, Selected)
                            if Selected then
                                Selected_Group = group_name
                            end
                        end, RMenu:Get('GroupsMenu', 'selectedgroup'))
                    end
                end
            else
                RageUI.Separator('~r~You do not have any groups :(')
            end
        end)

    elseif RageUI.Visible(RMenu:Get("GroupsMenu", 'selectedgroup')) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
            RageUI.Button('Remove Group', nil, {RightLabel = '>>>'}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('GroupsMenu', 'confirm'))
        end)

    elseif RageUI.Visible(RMenu:Get("GroupsMenu", 'confirm')) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
            RageUI.Button('Confirm', nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('Nova:Server:GroupsMenu:RemoveGroup', Selected_Group)
                end
            end, RMenu:Get('GroupsMenu', 'main'))

            RageUI.Button('Cancel', nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    Selected_Group = nil
                end
            end, RMenu:Get('GroupsMenu', 'main'))
        end)
    end
end)

RegisterKeyMapping('togglegroupsdisplay', 'Toggle the Nova Groups Display menu', 'keyboard', 'f6')
RegisterCommand('togglegroupsdisplay', function()
    local currently_visible = RageUI.Visible(RMenu:Get("GroupsMenu", "main"))
    if not currently_visible then -- If menu is not currently visible request event as it will be made visible now
        TriggerServerEvent("Nova:Server:GroupsMenu:GetGroups")
    end
    RageUI.Visible(RMenu:Get("GroupsMenu", "main"), not currently_visible)
end)

RegisterNetEvent("Nova:Client:GroupsMenu:ReturnGroups")
AddEventHandler("Nova:Client:GroupsMenu:ReturnGroups", function(legal_groups, illegal_groups)
    Legal_Groups = legal_groups
    Illegal_Groups = illegal_groups
end)

RegisterNetEvent('Nova:Client:GroupsMenu:GroupRemoved')
AddEventHandler('Nova:Client:GroupsMenu:GroupRemoved', function(group_removed)
    Selected_Group = nil
    tvRP.notify(('~g~Sucess [%s] Group has been removed'):format(group_removed))
end)