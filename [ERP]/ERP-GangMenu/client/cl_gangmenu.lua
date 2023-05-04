RMenu.Add('gangmenu', 'main', RageUI.CreateMenu("", "ERP Gang Menu", 1300, 100, "gang", "gang"))
RMenu.Add("gangmenu", "funds", RageUI.CreateSubMenu(RMenu:Get("gangmenu", "main", 1300, 100)))
RMenu.Add("gangmenu", "invite", RageUI.CreateSubMenu(RMenu:Get("gangmenu", "main", 1300, 100)))
RMenu.Add("gangmenu", "members", RageUI.CreateSubMenu(RMenu:Get("gangmenu", "main", 1300, 100)))
RMenu.Add("gangmenu", "leavegang", RageUI.CreateSubMenu(RMenu:Get("gangmenu", "main", 1300, 100)))
RMenu.Add("gangmenu", "disbandgang", RageUI.CreateSubMenu(RMenu:Get("gangmenu", "main", 1300, 100)))
RMenu.Add("gangmenu", "selectedmember", RageUI.CreateSubMenu(RMenu:Get("gangmenu", "members", 1300, 100)))
RMenu.Add("gangmenu", "updaterank", RageUI.CreateSubMenu(RMenu:Get("gangmenu", "selectedmember", 1300, 100)))
RMenu.Add("gangmenu", "confirminvite", RageUI.CreateSubMenu(RMenu:Get("gangmenu", "invite", 1300, 100)))


RegisterNetEvent("RecieveGangInfo")
AddEventHandler("RecieveGangInfo", function(ganginfo, gangmembers, myinfo, ganglogs, invites, ingang)
    IsInGang = ingang
    GangInfoTroll = ganginfo
    GangMemberTable = gangmembers
    MyInfoTroll = myinfo
    GangInvites = invites
    for k,v in pairs(GangInfoTroll) do
        GangName = v.gangname
        GangLeader = v.gangleader
        GangFunds = v.gangfunds 
    end
    for k,v in pairs(GangMemberTable) do
        MemberName = v.name
        MemberRank = v.rank
        MemberUserId = v.userid
        ActiveMembers = k
    end
    for k,v in pairs(MyInfoTroll) do
        MyName = v.name
        MyRank = v.rank
        MyGangName = v.gangname
        MyUserID = v.userid
    end
    DoesHaveInvites = json.encode(GangInvites)
    if DoesHaveInvites == '[]' then 
        GangInvites = 'No Invites'
    else
        GangInvites = GangInvites
    end
    if IsInGang == false then 
        RageUI.Visible(RMenu:Get('gangmenu', 'notingang'), not RageUI.Visible(RMenu:Get('gangmenu', 'notingang')))
    else
        RageUI.Visible(RMenu:Get('gangmenu', 'main'), not RageUI.Visible(RMenu:Get('gangmenu', 'main')))
    end
end)

local gangranks = {
    "Owner",
    "Enforcer",
    "Soldier",
    "Member",
    "Recruit",
}

RageUI.CreateWhile(1.0, RMenu:Get('gangmenu', 'main'), nil, function()
    RageUI.IsVisible(RMenu:Get('gangmenu', 'main'), true, false, true, function()
        RageUI.ButtonWithStyle("Gang Members", "", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
            if Selected then
            end
        end, RMenu:Get('gangmenu', 'members'))

        RageUI.ButtonWithStyle("Gang Funds", "", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
            if Selected then
            end
        end, RMenu:Get('gangmenu', 'funds'))

        if MyRank == "Owner" or MyRank == "Enforcer" then
            RageUI.ButtonWithStyle("Invite Members", "", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                if Selected then
                end
            end, RMenu:Get('gangmenu', 'invite'))
        end

        RageUI.ButtonWithStyle("Leave Gang", "", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
            if Selected then
            end
        end, RMenu:Get('gangmenu', 'leavegang'))

        if MyRank == "Owner" then
            RageUI.ButtonWithStyle("Disband the Gang", "", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                if Selected then
                end
            end, RMenu:Get('gangmenu', 'disbandgang'))
        end

        RageUI.Separator("~g~Gang Info", function() end)
        RageUI.Separator("Gang Name: " ..GangName, function() end)
        RageUI.Separator("Gang Funds: £" ..Comma(GangFunds), function() end)
        RageUI.Separator("Gang Creator: " ..GangLeader, function() end)

    end)

    RageUI.IsVisible(RMenu:Get("gangmenu", "members"),true, false,true,function()
        RMenu:Get("gangmenu", "members"):SetSubtitle("Members Tab")
        for k,v in pairs(GangMemberTable) do 
            RageUI.ButtonWithStyle("Name: " ..v.name.. " | Rank: " ..v.rank, "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SelectedMember = v
                end
            end, RMenu:Get('gangmenu', 'selectedmember'))
        end
    end)

    RageUI.IsVisible(RMenu:Get("gangmenu", "funds"),true, false,true,function()
        RMenu:Get("gangmenu", "funds"):SetSubtitle("Funds Tab")
        if MyRank == "Enforcer" or MyRank == "Owner" then
            RageUI.ButtonWithStyle("Withdraw", "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if Selected then
                    local PedCoords = GetEntityCoords(PlayerPedId())
                    local bank = vector3(148.94, -1040.05, 29.38)
                    if #(PedCoords - bank) < 10 then
                        AddTextEntry('FMMC_MPM_NC', "Amount to withdraw")
                        DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
                        while (UpdateOnscreenKeyboard() == 0) do
                            DisableAllControlActions(0);
                            Wait(0);
                        end
                        if (GetOnscreenKeyboardResult()) then
                            local result = GetOnscreenKeyboardResult()
                            if result then 
                                result = result
                                TriggerServerEvent("WithdrawFunds", result)
                            end
                        end
                    else
                        Notify("Need to be in Legion bank!")
                    end
                end
            end)
        end
        RageUI.ButtonWithStyle("Deposit", "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
            if Selected then
                local PedCoords = GetEntityCoords(PlayerPedId())
                local bank = vector3(148.94, -1040.05, 29.38)
                if #(PedCoords - bank) < 10 then
                    AddTextEntry('FMMC_MPM_NC', "Amount to deposit")
                    DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
                    while (UpdateOnscreenKeyboard() == 0) do
                        DisableAllControlActions(0);
                        Wait(0);
                    end
                    if (GetOnscreenKeyboardResult()) then
                        local result = GetOnscreenKeyboardResult()
                        if result then 
                            result = result
                            TriggerServerEvent("DepositFunds", result)
                        end
                    end
                else
                    Notify("Need to be in Legion bank!")
                end
            end
        end)
        RageUI.Separator("Gang Funds: £" ..Comma(GangFunds), function() end)
    end)

    RageUI.IsVisible(RMenu:Get("gangmenu", "invite"),true, false,true,function()
        RMenu:Get("gangmenu", "invite"):SetSubtitle("Invite Members!")
        RageUI.ButtonWithStyle("Members Perm ID", "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
            if Selected then
                AddTextEntry('FMMC_MPM_NC', "Perm ID")
                DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
                while (UpdateOnscreenKeyboard() == 0) do
                    DisableAllControlActions(0);
                    Wait(0);
                end
                if (GetOnscreenKeyboardResult()) then
                    local memperm = GetOnscreenKeyboardResult()
                    if memperm then 
                        MembersPermInvIs = memperm
                    end
                end
            end
        end)
        RageUI.ButtonWithStyle("Confirm", "", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
            if Selected then
                MembersPermToInv = MembersPermInvIs
            end
        end, RMenu:Get('gangmenu', 'confirminvite'))
    end)

    RageUI.IsVisible(RMenu:Get("gangmenu", "confirminvite"),true, false,true,function()
        wow = GangName
        wow2 = GangLeader
        RMenu:Get("gangmenu", "confirminvite"):SetSubtitle("Confirm Invite!")
        RageUI.Separator("Members Perm ID: " ..MembersPermToInv, function() end)

        RageUI.ButtonWithStyle("Are you sure you want to Confirm!", "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
            if Selected then
                TriggerServerEvent("MemberInvites", MembersPermToInv, wow, wow2)
            end
        end)
        RageUI.ButtonWithStyle("Cancel", "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
            if Selected then
                TriggerEvent("closemenu")
                RageUI.Visible(RMenu:Get('gangmenu', 'invite'), not RageUI.Visible(RMenu:Get('gangmenu', 'main')))
            end
        end)
    end)

    RageUI.IsVisible(RMenu:Get("gangmenu", "logs"),true, false,true,function()
        RMenu:Get("gangmenu", "logs"):SetSubtitle("Logs Tab")
        RageUI.Separator("Coming Soon!", function() end)
    end)

    RageUI.IsVisible(RMenu:Get("gangmenu", "leavegang"),true, false,true,function()
        RMenu:Get("gangmenu", "leavegang"):SetSubtitle("Leave Gang!")
        RageUI.ButtonWithStyle("Are you sure you want to leave!", "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
            if Selected then
                if ActiveMembers == 1 then 
                    Notify("Cannot leave gang as you are the last person")
                else
                    if MyRank == "Owner" then
                        Notify("Cant leave gang as you are the owner")
                    else
                        TriggerServerEvent("LeaveGang", MyName, MyRank, MyUserID)
                    end
                end
            end
        end)
        RageUI.ButtonWithStyle("Cancel Leaving", "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
            if Selected then
                RageUI.Visible(RMenu:Get('gangmenu', 'main'), not RageUI.Visible(RMenu:Get('gangmenu', 'main')))
            end
        end)
    end)

    RageUI.IsVisible(RMenu:Get("gangmenu", "selectedmember"),true, false,true,function()
        RMenu:Get("gangmenu", "selectedmember"):SetSubtitle("Name: " ..SelectedMember.name.. " Rank: " ..SelectedMember.rank)
        if MyRank == "Owner" then 
            RageUI.ButtonWithStyle("Update Rank", "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if Selected then
                end
            end, RMenu:Get('gangmenu', 'updaterank'))
        end
        if MyRank == "Enforcer" or MyRank == "Owner" then
            RageUI.ButtonWithStyle("Kick", "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if Selected then
                    if MyName == SelectedMember.name then
                        Notify("Cannot Kick yourself")
                    else 
                        TriggerServerEvent("KickPlayer", SelectedMember.name, SelectedMember.rank, SelectedMember.userid)
                    end
                end
            end)
        end
    end)

    RageUI.IsVisible(RMenu:Get("gangmenu", "updaterank"),true, false,true,function()
        RMenu:Get("gangmenu", "updaterank"):SetSubtitle("Name: " ..SelectedMember.name.. " Rank: " ..SelectedMember.rank)
        for k,v in pairs(gangranks) do
            RageUI.ButtonWithStyle(v, "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if Selected then
                    if SelectedMember.rank == v then
                        Notify("They already have this rank!")
                    else
                        TriggerServerEvent("UpdateRank", SelectedMember.name, SelectedMember.rank, v, SelectedMember.userid)
                    end
                end
            end)
        end
    end)

    RageUI.IsVisible(RMenu:Get("gangmenu", "disbandgang"),true, false,true,function()
        RMenu:Get("gangmenu", "disbandgang"):SetSubtitle("Disband Gang!")
        RageUI.ButtonWithStyle("Are you sure you want to Disband!", "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
            if ActiveMembers == 1 then 
                if Selected then
                    TriggerServerEvent("DisbandGang", GangName, GangLeader, GangFunds, MemberName, MemberUserId)
                end
            else 
                Notify("There are more people in the gang, you need to be the only one!")
            end
        end)
        RageUI.ButtonWithStyle("Cancel Disbanding", "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
            if Selected then
                RageUI.Visible(RMenu:Get('gangmenu', 'main'), not RageUI.Visible(RMenu:Get('gangmenu', 'main')))
            end
        end)
    end)
end)

  
RegisterCommand("gangmenu", function()
    TriggerServerEvent("GetGangInfo")
end)
RegisterKeyMapping("gangmenu", "Gang Menu", "keyboard", "F5")

RMenu.Add('gangmenu', 'notingang', RageUI.CreateMenu("", "Create Gang", 1300, 100, "gang", "gang"))
RMenu.Add("gangmenu", "creategang", RageUI.CreateSubMenu(RMenu:Get("gangmenu", "notingang", 1300, 100)))
RMenu.Add("gangmenu", "joingang", RageUI.CreateSubMenu(RMenu:Get("gangmenu", "notingang", 1300, 100)))
RMenu.Add("gangmenu", "confirmgang", RageUI.CreateSubMenu(RMenu:Get("gangmenu", "creategang", 1300, 100)))
RMenu.Add("gangmenu", "joingangconfirm", RageUI.CreateSubMenu(RMenu:Get("gangmenu", "joingang", 1300, 100)))


RageUI.CreateWhile(1.0, RMenu:Get('gangmenu', 'creategang'), nil, function()
    RageUI.IsVisible(RMenu:Get('gangmenu', 'notingang'), true, false, true, function()

        RageUI.ButtonWithStyle("Create Gang", "", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
            if Selected then
            end
        end, RMenu:Get('gangmenu', 'creategang'))

        RageUI.ButtonWithStyle("Join Gang", "", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
            if Selected then
            end
        end, RMenu:Get('gangmenu', 'joingang'))

    end)


    RageUI.IsVisible(RMenu:Get("gangmenu", "joingang"),true, false,true,function()
        RMenu:Get("gangmenu", "joingang"):SetSubtitle("Join A Gang!")
        RageUI.Separator("Gang Invites:", function() end)
        if GangInvites == "No Invites" then 
            RageUI.Separator("None", function() end)
        else 
            for k,v in pairs(GangInvites) do
                RageUI.ButtonWithStyle('Gang Name: ' ..v.gangname.. ' Gang Leader: ' ..v.gangleader, "", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                    if Selected then
                        GangNameToJoin = v.gangname 
                        GangLeaderToJoin = v.gangleader
                        GangPersonInvitedBy = v.personinvitedby
                        UserIDinDatabase = v.userid
                    end
                end, RMenu:Get('gangmenu', 'joingangconfirm'))
            end
        end
    end)

    RageUI.IsVisible(RMenu:Get("gangmenu", "joingangconfirm"),true, false,true,function()
        RageUI.Separator("Gang Name: " ..GangNameToJoin, function() end)
        RageUI.Separator("Gang Leader: " ..GangLeaderToJoin, function() end)
        RageUI.Separator("Invited By: " ..GangPersonInvitedBy, function() end)

        swag = GangNameToJoin
        swag2 = GangLeaderToJoin
        swag3 = GangPersonInvitedBy
        id = UserIDinDatabase
        RageUI.ButtonWithStyle("Are you sure you want to join this gang!", "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
            if Selected then
                TriggerServerEvent("joininggang", swag, swag2, swag3, id)
            end
        end)
        RageUI.ButtonWithStyle("Cancel joining", "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
            if Selected then
                TriggerEvent("closemenu")
                RageUI.Visible(RMenu:Get('gangmenu', 'joingang'), not RageUI.Visible(RMenu:Get('gangmenu', 'main')))
            end
        end)
    end)


    RageUI.IsVisible(RMenu:Get('gangmenu', 'creategang'), true, false, true, function()
        RageUI.ButtonWithStyle("Gang Name", "", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
            if Selected then
                AddTextEntry('FMMC_MPM_NA', "Enter Gang Name")
                DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Enter Gang Name", "", "", "", "", 30)
                while (UpdateOnscreenKeyboard() == 0) do
                    DisableAllControlActions(0);
                    Wait(0);
                end
                if (GetOnscreenKeyboardResult()) then
                    local result = GetOnscreenKeyboardResult()
                    if result then
                        CreatedGangName = result
                    end
                end

            end
        end)
        RageUI.ButtonWithStyle("Gang Leader", "", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
            if Selected then
                AddTextEntry('FMMC_MPM_NA', "Enter Gang Leader (Your Name)")
                DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Enter Gang Leader (Your Name)", "", "", "", "", 30)
                while (UpdateOnscreenKeyboard() == 0) do
                    DisableAllControlActions(0);
                    Wait(0);
                end
                if (GetOnscreenKeyboardResult()) then
                    local result = GetOnscreenKeyboardResult()
                    if result then
                        CreatedGangLeader = result
                    end
                end
            end
        end)
        RageUI.ButtonWithStyle("Confirm", "", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
            if Selected then
                Leader = CreatedGangLeader
                Name = CreatedGangName
            end
        end, RMenu:Get('gangmenu', 'confirmgang'))
    end)

    RageUI.IsVisible(RMenu:Get("gangmenu", "confirmgang"),true, false,true,function()
        RMenu:Get("gangmenu", "confirmgang"):SetSubtitle("Confirm Gang!")
        RageUI.Separator("Gang Name: " ..Name, function() end)
        RageUI.Separator("Gang Leader: " ..Leader, function() end)

        RageUI.ButtonWithStyle("Are you sure you want to Confirm!", "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
            if Selected then
                TriggerServerEvent("creategang", Name, Leader)
            end
        end)
        RageUI.ButtonWithStyle("Cancel Disbanding", "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
            if Selected then
                TriggerEvent("closemenu")
                RageUI.Visible(RMenu:Get('gangmenu', 'creategang'), not RageUI.Visible(RMenu:Get('gangmenu', 'main')))
            end
        end)
    end)
end)

RegisterNetEvent("closemenu")
AddEventHandler("closemenu", function()
    RageUI.CloseAll()
end)




function Notify(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(0,1)
end

function Comma(amount)
    local formatted = amount
    while true do  
      formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
      if (k==0) then
        break
      end
    end
    return formatted
end