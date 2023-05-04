RMenu.Add("gangmenu", "main", RageUI.CreateMenu("", "Nova Gang Menu", 1300, 100, "gang", "gang"))
RMenu.Add("gangmenu", "funds", RageUI.CreateSubMenu(RMenu:Get("gangmenu", "main"), '', 'Funds Tab', 1300, 100))
RMenu.Add("gangmenu", "invite", RageUI.CreateSubMenu(RMenu:Get("gangmenu", "main"), '', 'Invite Members!', 1300, 100))
RMenu.Add("gangmenu", "members", RageUI.CreateSubMenu(RMenu:Get("gangmenu", "main"), '', 'Members Tab', 1300, 100))
RMenu.Add("gangmenu", "logs", RageUI.CreateSubMenu(RMenu:Get("gangmenu", "main"), '', 'Logs Tab', 1300, 100))
RMenu.Add("gangmenu", "leavegang", RageUI.CreateSubMenu(RMenu:Get("gangmenu", "main"), '', 'Leave Gang!', 1300, 100))
RMenu.Add("gangmenu", "disbandgang", RageUI.CreateSubMenu(RMenu:Get("gangmenu", "main"), '', 'Disband Gang!', 1300, 100))
RMenu.Add("gangmenu", "selectedmember", RageUI.CreateSubMenu(RMenu:Get("gangmenu", "members"), '', '', 1300, 100))
RMenu.Add("gangmenu", "updaterank", RageUI.CreateSubMenu(RMenu:Get("gangmenu", "selectedmember"), '', '', 1300, 100))
RMenu.Add("gangmenu", "confirminvite", RageUI.CreateSubMenu(RMenu:Get("gangmenu", "invite"), '', 'Confirm Invite!', 1300, 100))

RMenu.Add("gangmenu", "notingang", RageUI.CreateMenu("", "Create Gang", 1300, 100, "gang", "gang"))
RMenu.Add("gangmenu", "creategang", RageUI.CreateSubMenu(RMenu:Get("gangmenu", "notingang"), '', '', 1300, 100))
RMenu.Add("gangmenu", "confirmgang", RageUI.CreateSubMenu(RMenu:Get("gangmenu", "creategang"), '', 'Confirm Gang!', 1300, 100))

RMenu.Add("gangmenu", "joingang", RageUI.CreateSubMenu(RMenu:Get("gangmenu", "notingang"), '', 'Join A Gang!', 1300, 100))
RMenu.Add("gangmenu", "joingangconfirm", RageUI.CreateSubMenu(RMenu:Get("gangmenu", "joingang"), '', '', 1300, 100))

-- Having a gang license will add an extra menu, check for it on startup
local Has_Gang_License = false
RegisterNetEvent('Nova:GangMenu:Client:CheckHasGangLicense')
AddEventHandler('Nova:GangMenu:Client:CheckHasGangLicense', function(client_has_gang_license)
    Has_Gang_License = client_has_gang_license
    print(string.format('Has Gang License: %s', Has_Gang_License))
end)

local Is_In_Gang = false
RegisterNetEvent('Nova:GangMenu:Client:CheckHasGang')
AddEventHandler('Nova:GangMenu:Client:CheckHasGang', function(client_has_gang)
    Is_In_Gang = client_has_gang
    print(string.format('Has Gang: %s', Is_In_Gang))
end)

-- General User Gang Info
--local Gang_Info_Troll = nil
local Gang_Members_Table = nil
--local My_Info_Troll = nil
local Gang_Invites = nil

-- Gang Info
local Gang_Name = 'None'
local Gang_Leader_Name = 'None'
local Gang_Funds_Amount = 0
RegisterNetEvent('Nova:GangMenu:Client:UpdatedGangFunds')
AddEventHandler('Nova:GangMenu:Client:UpdatedGangFunds', function(updated_money_amount)
    Gang_Funds_Amount = updated_money_amount
end)

-- Gang Creation
local Created_Gang_Name = nil
local Created_Gang_Leader_Name = GetPlayerName(PlayerId())

RegisterNetEvent("Nova:GangMenu:Client:RecieveGangInfo")
AddEventHandler("Nova:GangMenu:Client:RecieveGangInfo", function(ganginfo, gangmembers, myinfo, ganglogs, invites, has_gang)
    --Gang_Info_Troll = ganginfo
    Gang_Members_Table = gangmembers
    Gang_Invites = invites  
    Is_In_Gang = has_gang

    if Gang_Members_Table then
        ActiveMembers = 0
        for _, i in pairs(Gang_Members_Table) do
            ActiveMembers = ActiveMembers + 1
        end
    end
    --My_Info_Troll = myinfo

    if ganginfo then
        Gang_Name = ganginfo.gang_name
        Gang_Leader_Name = ganginfo.gang_leader_name
        Gang_Funds_Amount = ganginfo.gang_funds
    end

    --[[
    for k, v in pairs(Gang_Members_Table) do
        MemberName = v.name
        MemberRank = v.rank
        MemberUserId = v.userid
        ActiveMembers = k
    end
    ]]

    if myinfo then
        MyUserID = myinfo.user_id
        MyName = myinfo.user_name
        MyGangName = myinfo.gang_name
        MyRank = myinfo.gang_rank
    end

    if Is_In_Gang then
        RageUI.Visible(RMenu:Get("gangmenu", "main"), not RageUI.Visible(RMenu:Get("gangmenu", "main")))
    else
        RageUI.Visible(RMenu:Get("gangmenu", "notingang"), not RageUI.Visible(RMenu:Get("gangmenu", "notingang")))
    end
end)

local gangranks = {
    "Owner",
    "Enforcer",
    "Soldier",
    "Member",
    "Recruit",
}

RegisterKeyMapping("gangmenu", "Gang Menu", "keyboard", "F5")
RegisterCommand("gangmenu", function()
    if RageUI.Visible(RMenu:Get("gangmenu", "notingang")) or RageUI.Visible(RMenu:Get("gangmenu", "main")) then
        RageUI.CloseAll()
    else
        TriggerServerEvent("Nova:GangMenu:Server:GetGangInfo")
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get("gangmenu", "main")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
            RageUI.Button("Gang Members", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                if Selected then
                end
            end, RMenu:Get("gangmenu", "members"))

            RageUI.Button("Gang Funds", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                if Selected then
                end
            end, RMenu:Get("gangmenu", "funds"))

            if MyRank == "Owner" or MyRank == "Enforcer" then
                RageUI.Button("Gang Logs", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                    end
                end, RMenu:Get("gangmenu", "logs"))
            end

            if MyRank == "Owner" then
                RageUI.Button("Disband the Gang", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                    end
                end, RMenu:Get("gangmenu", "disbandgang"))
            else
                RageUI.Button("Leave Gang", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                    end
                end, RMenu:Get("gangmenu", "leavegang"))
            end

            RageUI.Separator("~g~Gang Info", function()
            end)

            RageUI.Separator("Gang Name: " .. Gang_Name, function()
            end)

            RageUI.Separator("Gang Leader: " .. Gang_Leader_Name, function()
            end)

            RageUI.Separator("Gang Funds: £" .. shared_functions.Get_Formatted_Money(Gang_Funds_Amount), function()
            end)
        end)

    elseif RageUI.Visible(RMenu:Get("gangmenu", "members")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
            if MyRank == "Owner" or MyRank == "Enforcer" then
                RageUI.Button("Invite Members", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                    end
                end, RMenu:Get("gangmenu", "invite"))
            end

            if Gang_Members_Table then
                for k, v in pairs(Gang_Members_Table) do
                    RageUI.Button("Name: " .. v.user_name .. " | Rank: " .. v.gang_rank, "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SelectedMember = v
                        end
                    end, function()
                        if v.name ~= MyName then -- Prevents the Owner from accessing their own tab
                            RMenu:Get("gangmenu", "selectedmember")
                        end
                    end)
                end
            end
        end)

    elseif RageUI.Visible(RMenu:Get("gangmenu", "funds")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
            if MyRank == "Enforcer" or MyRank == "Owner" then
                RageUI.Button("Withdraw", "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local PedCoords = GetEntityCoords(PlayerPedId())
                        local bank = vector3(148.94, -1040.05, 29.38)
                        
                        if #(PedCoords - bank) < 10 then
                            AddTextEntry("FMMC_MPM_NC", "Amount to withdraw")
                            DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
                            while (UpdateOnscreenKeyboard() == 0) do
                                DisableAllControlActions(0)
                                Wait(0)
                            end
                            if (GetOnscreenKeyboardResult()) then
                                local result = GetOnscreenKeyboardResult()
                                if result then
                                    result = result
                                    TriggerServerEvent("Nova:GangMenu:Server:WithdrawGangFunds", result)
                                end
                            end
                        else
                            exports.vrp:notify("Need to be in Legion bank!")
                        end
                    end
                end)
            end

            RageUI.Button("Deposit", "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if Selected then
                    local PedCoords = GetEntityCoords(PlayerPedId())
                    local bank = vector3(148.94, -1040.05, 29.38)

                    if #(PedCoords - bank) < 10 then
                        AddTextEntry("FMMC_MPM_NC", "Amount to deposit")
                        DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
                        while (UpdateOnscreenKeyboard() == 0) do
                            DisableAllControlActions(0)
                            Wait(0)
                        end
                        if (GetOnscreenKeyboardResult()) then
                            local result = GetOnscreenKeyboardResult()
                            if result then
                                result = result
                                TriggerServerEvent("Nova:GangMenu:Server:DepositGangFunds", result)
                            end
                        end
                    else
                        exports.vrp:notify("Need to be in Legion bank!")
                    end
                end
            end)

            RageUI.Separator("Gang Funds: £" .. shared_functions.Get_Formatted_Money(Gang_Funds_Amount), function()
            end)
        end)

    elseif RageUI.Visible(RMenu:Get("gangmenu", "invite")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
            RageUI.Button("Members Perm ID", "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if Selected then
                    AddTextEntry("FMMC_MPM_NC", "Perm ID")
                    DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
                    while (UpdateOnscreenKeyboard() == 0) do
                        DisableAllControlActions(0)
                        Wait(0)
                    end
                    
                    if (GetOnscreenKeyboardResult()) then
                        local memperm = GetOnscreenKeyboardResult()
                        if memperm then
                            MembersPermInvIs = memperm
                        end
                    end
                end
            end)

            RageUI.Button("Confirm", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    MembersPermToInv = MembersPermInvIs
                end
            end, RMenu:Get("gangmenu", "confirminvite"))
        end)

    elseif RageUI.Visible(RMenu:Get("gangmenu", "confirminvite")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
            RageUI.Separator("Members Perm ID: " .. MembersPermToInv, function()
            end)

            RageUI.Button("Are you sure you want to Confirm!", "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent("Nova:GangMenu:Server:InviteMember", MembersPermToInv, Gang_Name, Gang_Leader_Name)
                end
            end)

            RageUI.Button("Cancel", "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerEvent("Nova:GangMenu:Client:CloseAllMenus")
                    RageUI.Visible(RMenu:Get("gangmenu", "invite"), not RageUI.Visible(RMenu:Get("gangmenu", "main")))
                end
            end)
        end)

    elseif RageUI.Visible(RMenu:Get("gangmenu", "logs")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
            RageUI.Separator("Coming Soon!", function()
            end)
        end)

    elseif RageUI.Visible(RMenu:Get("gangmenu", "leavegang")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
            RageUI.Button("Are you sure you want to leave!", "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if Selected then
                    if ActiveMembers == 1 then
                        exports.vrp:notify("Cannot leave gang as you are the last person")
                    else
                        if MyRank == "Owner" then
                            exports.vrp:notify("Cant leave gang as you are the owner")
                        else
                            TriggerServerEvent("Nova:GangMenu:Server:LeaveGang", MyName, MyRank, MyUserID)
                        end
                    end
                end
            end)

            RageUI.Button("Cancel Leaving", "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if Selected then
                    RageUI.Visible(RMenu:Get("gangmenu", "main"), not RageUI.Visible(RMenu:Get("gangmenu", "main")))
                end
            end)
        end)

    elseif RageUI.Visible(RMenu:Get("gangmenu", "selectedmember")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
            RMenu:Get("gangmenu", "selectedmember"):SetSubtitle("Name: " .. SelectedMember.name .. " Rank: " .. SelectedMember.rank)

            if MyRank == "Enforcer" or MyRank == "Owner" then
                if MyRank == "Owner" then
                    RageUI.Button("Update Rank", "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                        if Selected then
                        end
                    end, RMenu:Get("gangmenu", "updaterank"))
                end

                RageUI.Button("Kick", "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        if MyName == SelectedMember.user_name then
                            exports.vrp:notify("Cannot Kick yourself")
                        else
                            TriggerServerEvent(
                                "Nova:GangMenu:Server:KickPlayer",
                                SelectedMember.user_name,
                                SelectedMember.user_id,
                                SelectedMember.gang_rank
                            )
                        end
                    end
                end)
            end
        end)

    elseif RageUI.Visible(RMenu:Get("gangmenu", "updaterank")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
            RMenu:Get("gangmenu", "updaterank"):SetSubtitle("Name: " .. SelectedMember.name .. " Rank: " .. SelectedMember.rank)

            for k, v in pairs(gangranks) do
                RageUI.Button(v, "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        if SelectedMember.name == MyName then
                            exports.vrp:notify("You can't change your own rank")
                        else
                            if SelectedMember.rank == v then
                                exports.vrp:notify("They already have this rank!")
                            else
                                TriggerServerEvent(
                                    "Nova:GangMenu:Server:UpdateGangRank",
                                    SelectedMember.name,
                                    SelectedMember.rank,
                                    v,
                                    SelectedMember.userid
                                )
                            end
                        end
                    end
                end)
            end
        end)

    elseif RageUI.Visible(RMenu:Get("gangmenu", "disbandgang")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
            RageUI.Button("Are you sure you want to Disband!", "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if Selected then
                    --print(ActiveMembers)
                    if ActiveMembers <= 1 then
                        --print('Disbanding Gang', Gang_Name, Gang_Leader_Name, Gang_Funds_Amount, MyName, MyUserID)
                        TriggerServerEvent(
                            "Nova:GangMenu:Server:DisbandGang",
                            Gang_Name,
                            Gang_Leader_Name,
                            Gang_Funds_Amount,
                            MyName,
                            MyUserID
                        )
                    else
                        exports.vrp:notify("There are more people in the gang, you need to be the only one!")
                    end
                end
            end)

            RageUI.Button("Cancel Disbanding", "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if Selected then
                    RageUI.Visible(RMenu:Get("gangmenu", "main"), not RageUI.Visible(RMenu:Get("gangmenu", "main")))
                end
            end)
        end)

    elseif RageUI.Visible(RMenu:Get("gangmenu", "notingang")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
            if Has_Gang_License then
                RageUI.Button("Create Gang", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                    end
                end, RMenu:Get("gangmenu", "creategang"))
            end

            RageUI.Button("Join Gang", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                if Selected then
                end
            end, RMenu:Get("gangmenu", "joingang"))
        end)

    elseif RageUI.Visible(RMenu:Get("gangmenu", "joingang")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
            if Gang_Invites then
                RageUI.Separator("Gang Invites:", function()
                end)
                for k, v in pairs(Gang_Invites) do
                    local invite_gang_name = v.gang_name
                    local invite_gang_leader_name = v.gang_leader_name

                    RageUI.Button(string.format("Gang Name: %s Gang Leader: %s", invite_gang_name, invite_gang_leader_name), "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            GangNameToJoin = invite_gang_name
                            GangLeaderToJoin = invite_gang_leader_name
                            GangPersonInvitedBy = v.invited_by_name
                            UserIDinDatabase = v.user_id
                        end
                    end, RMenu:Get("gangmenu", "joingangconfirm"))
                end
            else
                RageUI.Separator("Gang Invites: No Invites", function()
                end)
            end
        end)

    elseif RageUI.Visible(RMenu:Get("gangmenu", "joingangconfirm")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
            RageUI.Separator("Gang Name: " .. GangNameToJoin, function()
            end)

            RageUI.Separator("Gang Leader: " .. GangLeaderToJoin, function()
            end)

            RageUI.Separator("Invited By: " .. GangPersonInvitedBy, function()
            end)

            swag = GangNameToJoin
            swag2 = GangLeaderToJoin
            swag3 = GangPersonInvitedBy
            id = UserIDinDatabase
            RageUI.Button("Are you sure you want to join this gang!", "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent("Nova:GangMenu:Server:JoinGang", swag, swag2, swag3, id)
                end
            end)
            
            RageUI.Button("Cancel joining", "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerEvent("Nova:GangMenu:Client:CloseAllMenus")
                    RageUI.Visible(RMenu:Get("gangmenu", "joingang"), not RageUI.Visible(RMenu:Get("gangmenu", "main")))
                end
            end)
        end)

    elseif RageUI.Visible(RMenu:Get("gangmenu", "creategang")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
            RageUI.Button("Gang Name", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    AddTextEntry("FMMC_MPM_NA", "Enter Gang Name")
                    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Enter Gang Name", "", "", "", "", 30)
                    while (UpdateOnscreenKeyboard() == 0) do
                        DisableAllControlActions(0)
                        Wait(0)
                    end

                    if (GetOnscreenKeyboardResult()) then
                        local result = GetOnscreenKeyboardResult()
                        if result then
                            Created_Gang_Name = result
                        end
                    end
                end
            end)

            RageUI.Button("Confirm", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    if Created_Gang_Name then
                        -- Works 
                        --RageUI.Visible(RMenu:Get("gangmenu", "confirmgang"), true)
    
                        -- Doesn't work
                        --RMenu:Get("gangmenu", "confirmgang")
                        --print('Gang Details Entered, Moving to confirm gang menu')
                    else
                        exports.vrp:notify('~r~You must enter a gang name')
                    end
                end
            end)
        end)

    elseif RageUI.Visible(RMenu:Get("gangmenu", "confirmgang")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
            RageUI.Separator("Gang Name: " .. Created_Gang_Name, function()
            end)
            
            RageUI.Separator("Gang Leader: " .. Created_Gang_Leader_Name, function()
            end)

            RageUI.Button("Are you sure you want to Confirm!", "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent("Nova:GangMenu:Server:CreateGang", Created_Gang_Name, Created_Gang_Leader_Name)
                end
            end)

            RageUI.Button("Cancel Disbanding", "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if Selected then
                    Created_Gang_Name = nil
                    TriggerEvent("Nova:GangMenu:Client:CloseAllMenus")
                end
            end)
        end)
    end
end)

RegisterNetEvent("Nova:GangMenu:Client:CloseAllMenus")
AddEventHandler("Nova:GangMenu:Client:CloseAllMenus", function()
    RageUI.CloseAll()
end)

Citizen.CreateThread(function() -- Trigger Events for various checks
    Citizen.Wait(1000) -- Wait 1 second to allow server to cache gangs
    TriggerServerEvent('Nova:GangMenu:Server:CheckHasGangLicense')
    TriggerServerEvent('Nova:GangMenu:Server:CheckHasGang')
end)