showNoGangUI=false
showGangUI=false
showPermUI=false
PlayerIsInGang=false
GangBalance=0
ARMAGangInvites={}
ARMAGangInviteIndex=0
selectedGangInvite=nil
selectedMember=nil
gangID=nil
local showLogsGangUI = false
gangPermission=0
local a=18
local b=82
local c=228
local d={}
local d2={}
local e=1
local e2=1
local f=1
local f2=1
ARMAGangMembers={}
AddEventHandler("playerSpawned",function()
    local h = true
    if h then 
        TriggerServerEvent("ARMA:GetGangData")
    end 
end)
RegisterNetEvent("ARMA:GotGangData")
AddEventHandler("ARMA:GotGangData",function(i,j,k,PO)
    if i==nil then 
        PlayerIsInGang=false 
    else 
        PlayerIsInGang=true
        d={}
        f=1
        GangBalance=getMoneyStringFormatted(math.floor(i.money))
        gangID=i.id
        gangPermission=tonumber(k)
        if j~=nil then 
            ARMAGangMembers=j
            local l=1
            d[l]={}
            for m,n in pairs(j)do 
                if m%11==0 then 
                    l=l+1
                    d[l]={}
                    f=f+1 
                else 
                    d[l][m-(l-1)*11]=n 
                end 
            end 
        end 
    end 
end)
RegisterNetEvent("ARMA:disbandedGang")
AddEventHandler("ARMA:disbandedGang",function()
    PlayerIsInGang=false
    showGangUI=false
    showNoGangUI=true
    showSettingsGangUI=false
    showTurfsGangUI=false
    showFundsGangUI=false
    showLogsGangUI=false
    showMembersGangUI=false
    TriggerEvent("ARMA:ForceRefreshData")
end)
RegisterNetEvent("ARMA:ForceRefreshData")
AddEventHandler("ARMA:ForceRefreshData",function()
    TriggerServerEvent("ARMA:GetGangData")
end)
RegisterNetEvent("ARMA:InviteRecieved")
AddEventHandler("ARMA:InviteRecieved",function(o,Q)
    ARMAGangInvites[ARMAGangInviteIndex]=Q
    ARMAGangInviteIndex=ARMAGangInviteIndex+1
    tARMA.notify(o)
end)
RegisterNetEvent("ARMA:gangNameNotTaken")
AddEventHandler("ARMA:gangNameNotTaken",function()
    showNoGangUI=false
    showGangUI=true
    PlayerIsInGang=true 
end)
function func_drawGangUI()
    if showNoGangUI then 
        DrawRect(0.471,0.329,0.285,-0.005,0,168,255,204)
        DrawRect(0.471,0.304,0.285,0.046,0,0,0,150)
        DrawRect(0.471,0.428,0.285,0.194,0,0,0,150)
        DrawRect(0.383,0.442,0.066,0.046,CreateGangSelectionRed,CreateGangSelectionGreen,CreateGangSelectionBlue,150)
        DrawRect(0.469,0.442,0.066,0.046,JoinGangSelectionRed,JoinGangSelectionGreen,JoinGangSelectionBlue,150)
        DrawAdvancedText(0.558,0.303,0.005,0.0028,0.539,"ARMA Gangs",255,255,255,255,7,0)
        DrawAdvancedText(0.478,0.442,0.005,0.0028,0.473,"Create Gang",255,255,255,255,4,0)
        DrawAdvancedText(0.564,0.443,0.005,0.0028,0.473,"Join Gang",255,255,255,255,4,0)
        DrawRect(0.561,0.377,0.065,-0.003,0,168,255,204)
        DrawAdvancedText(0.654,0.37,0.005,0.0028,0.364,"Invite list",255,255,255,255,4,0)
        for p,q in pairs(ARMAGangInvites)do 
            DrawAdvancedText(0.656,0.398+0.020*p,0.005,0.0028,0.234,q,255,255,255,255,0,0)
            if CursorInArea(0.525,0.59,0.38+0.02*p,0.396+0.02*p)and p~=selectedGangInvite then 
                DrawRect(0.56,0.39+0.02*p,0.062,0.019,0,168,255,150)
                if IsControlJustPressed(1,329)or IsDisabledControlJustPressed(1,329)then 
                    selectedGangInvite=p 
                end 
            elseif p==selectedGangInvite then 
                DrawRect(0.56,0.39+0.02*p,0.062,0.019,0,168,255,150)
            end 
        end
        if CursorInArea(0.35,0.415,0.415,0.46)then 
            CreateGangSelectionRed=0
            CreateGangSelectionGreen=168
            CreateGangSelectionBlue=255
            if IsControlJustPressed(1,329)or IsDisabledControlJustPressed(1,329)then 
                PlaySound(-1,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET",0,0,1)
                createGangName=GetGangNameText()
                if createGangName~=nil and createGangName~="null"and createGangName~=""then 
                    TriggerServerEvent("ARMA:CreateGang",createGangName)
                else 
                    tARMA.notify("~r~No gang name entered!")
                end 
            end 
        else 
            CreateGangSelectionRed=0
            CreateGangSelectionGreen=0
            CreateGangSelectionBlue=0 
        end
        if CursorInArea(0.435,0.51,0.415,0.46)then 
            JoinGangSelectionRed=0
            JoinGangSelectionGreen=168
            JoinGangSelectionBlue=255
            if IsControlJustPressed(1,329)or IsDisabledControlJustPressed(1,329)then 
                PlaySound(-1,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET",0,0,1)
                if selectedGangInvite~=nil then 
                    selectedGangInvite=ARMAGangInvites[selectedGangInvite]
                    local perm1s = tARMA.getUserId()
                    TriggerServerEvent("ARMA:addUserToGang",selectedGangInvite,perm1s)
                    ARMAGangInvites={}
                    showNoGangUI=false
                    ARMAGangInviteIndex=0
                    showGangUI=true
                    PlayerIsInGang=true 
                else 
                    tARMA.notify("~r~No gang invite selected")
                end 
            end 
        else 
            JoinGangSelectionRed=0
            JoinGangSelectionGreen=0
            JoinGangSelectionBlue=0 
        end 
    end
    if showFundsGangUI then 
        DrawRect(0.501, 0.558, 0.421, 0.326, 0, 0, 0, 150)
        DrawRect(0.501, 0.374, 0.421, 0.047, 18, 82, 228, 248)
        DrawAdvancedText(0.591,0.378,0.005,0.0028,0.48,"ARMA Gang - Funds",255,255,255,255,7,0)
        DrawAdvancedText(0.581, 0.464, 0.005, 0.0028, 0.5, "Gang Funds", 255, 255, 255, 255, 0, 0)
        DrawAdvancedText(0.581, 0.502, 0.005, 0.0028, 0.4, "£" .. GangBalance, 25, 199, 65, 255, 0, 0)
        DrawAdvancedText(0.436, 0.578, 0.005, 0.0028, 0.4, "Deposit (2% Fee)", 255, 255, 255, 255, 6, 0)
        DrawAdvancedText(0.536, 0.578, 0.005, 0.0028, 0.4, "Deposit All (2% Fee)", 255, 255, 255, 255, 6, 0)
        DrawAdvancedText(0.637, 0.578, 0.005, 0.0028, 0.4, "Withdraw", 255, 255, 255, 255, 6, 0)
        DrawAdvancedText(0.737, 0.578, 0.005, 0.0028, 0.4, "Withdraw All", 255, 255, 255, 255, 6, 0)
        DrawAdvancedText(0.775,0.693,0.005,0.0028,0.4,"Back",255,255,255,255,4,0)
        if CursorInArea(0.3083, 0.3718, 0.5490, 0.5999) then
            DrawRect(0.341, 0.576, 0.075, 0.056, a, b, c, 150)
            if IsControlJustPressed(1, 329) or IsDisabledControlJustPressed(1, 329) then
                PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                amount = GetMoneyAmountText()
                if amount ~= nil then
                    if closeToBarclays() then
                        TriggerServerEvent("ARMA:depositGangBalance", amount)
                    end
                else
                    tARMA.notify("~r~No amount entered!")
                end
            end
        else
            DrawRect(0.341, 0.576, 0.075, 0.056, 0, 0, 0, 150)
        end
        if CursorInArea(0.4083, 0.4718, 0.5490, 0.5999) then
            DrawRect(0.441, 0.576, 0.075, 0.056, a, b, c, 150)
            if IsControlJustPressed(1, 329) or IsDisabledControlJustPressed(1, 329) then
                PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                if closeToBarclays() then
                    TriggerServerEvent("ARMA:depositAllGangBalance")
                end
            end
        else
            DrawRect(0.441, 0.576, 0.075, 0.056, 0, 0, 0, 150)
        end
        if CursorInArea(0.5088, 0.5739, 0.5481, 0.6018) then
            DrawRect(0.542, 0.576, 0.075, 0.056, a, b, c, 150)
            if IsControlJustPressed(1, 329) or IsDisabledControlJustPressed(1, 329) then
                PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                amount = GetMoneyAmountText()
                if amount ~= nil then
                    if gangPermission >= 3 then
                        if closeToBarclays() then
                            TriggerServerEvent("ARMA:withdrawGangBalance", amount)
                        end
                    else
                        tARMA.notify("~r~You don't have a high enough rank to withdraw")
                    end
                else
                    tARMA.notify("~r~No amount entered!")
                end
            end
        else
            DrawRect(0.542, 0.576, 0.075, 0.056, 0, 0, 0, 150)
        end
        if CursorInArea(0.6088, 0.6739, 0.5481, 0.6018) then
            DrawRect(0.642, 0.576, 0.075, 0.056, a, b, c, 150)
            if IsControlJustPressed(1, 329) or IsDisabledControlJustPressed(1, 329) then
                PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                if gangPermission >= 3 then
                    if closeToBarclays() then
                        TriggerServerEvent("ARMA:withdrawAllGangBalance")
                    end
                else
                    tARMA.notify("~r~You don't have a high enough rank to withdraw")
                end
            end
        else
            DrawRect(0.642, 0.576, 0.075, 0.056, 0, 0, 0, 150)
        end
        if CursorInArea(0.6583, 0.7056, 0.6712, 0.7064) then
            DrawRect(0.681, 0.689, 0.045, 0.036, a, b, c, 150)
            if IsControlJustPressed(1, 329) or IsDisabledControlJustPressed(1, 329) then
                PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                showFundsGangUI = false
                showGangUI = true
            end
        else
            DrawRect(0.681, 0.689, 0.045, 0.036, 0, 0, 0, 150)
        end
    end
    if showMembersGangUI then 
        DrawRect(0.501,0.525,0.421,0.387,0,0,0,150)
        DrawRect(0.501,0.308,0.421,0.047,18,82,228,248)
        DrawAdvancedText(0.591,0.312,0.005,0.0028,0.48,"ARMA Gang - Members",255,255,255,255,7,0)
        DrawRect(0.398,0.52,0.195,0.291,0,0,0,150)
        DrawAdvancedText(0.449,0.359,0.005,0.0028,0.4,"Name",255,255,255,255,6,0)
        DrawAdvancedText(0.506,0.359,0.005,0.0028,0.4,"ID",255,255,255,255,6,0)
        DrawAdvancedText(0.555,0.359,0.005,0.0028,0.4,"Rank",255,255,255,255,6,0)
        DrawAdvancedText(0.647,0.447,0.005,0.0028,0.4,"Promote",255,255,255,255,4,0)
        DrawAdvancedText(0.746,0.447,0.005,0.0028,0.4,"Demote",255,255,255,255,4,0)
        DrawAdvancedText(0.647,0.573,0.005,0.0028,0.4,"Kick",255,255,255,255,4,0)
        DrawAdvancedText(0.746,0.572,0.005,0.0028,0.4,"Invite",255,255,255,255,4,0)
        DrawAdvancedText(0.445,0.695,0.005,0.0028,0.4,"Previous",255,255,255,255,4,0)
        DrawAdvancedText(0.531,0.695,0.005,0.0028,0.4,"Next",255,255,255,255,4,0)
        DrawAdvancedText(0.486,0.695,0.005,0.0028,0.4,tostring(e).."/"..tostring(f),255,255,255,255,4,0)
        DrawAdvancedText(0.775,0.693,0.005,0.0028,0.4,"Back",255,255,255,255,4,0)
        for p,r in pairs(d[e])do 
            name,id,rank=table.unpack(r)
            rank = tostring(rank)
            if rank==nil or rank=="nil"or rank=="NULL"then 
                rank="1"
            elseif rank<="1"then 
                rank="Recruit"
            elseif rank=="2"then 
                rank="Member"
            elseif rank=="3"then 
                rank="Lieutenant"
            elseif rank>="4"then 
                rank="Leader"
            end
            DrawAdvancedText(0.449,0.361+0.0287*p,0.005,0.0028,0.4,name,255,255,255,255,6,0)
            DrawAdvancedText(0.506,0.361+0.0287*p,0.005,0.0028,0.4,id,255,255,255,255,6,0)
            DrawAdvancedText(0.555,0.361+0.0287*p,0.005,0.0028,0.4,rank,255,255,255,255,6,0)
            if CursorInArea(0.3000,0.4942,0.3731+0.0287*(p-1),0.4018+0.0287*(p-1))and selectedMember~=id then 
                DrawRect(0.398,0.388+0.0287*(p-1),0.195,0.027,a,b,c,150)
                if IsControlJustPressed(1,329)or IsDisabledControlJustPressed(1,329)then 
                    PlaySound(-1,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET",0,0,1)
                    selectedMember=id 
                end 
            elseif selectedMember==id then 
                DrawRect(0.398,0.388+0.0287*(p-1),0.195,0.027,a,b,c,150)
            end 
        end
        if CursorInArea(0.5187,0.5828,0.4138,0.4694)then 
            DrawRect(0.552,0.443,0.065,0.056,a,b,c,150)
            if IsControlJustPressed(1,329)or IsDisabledControlJustPressed(1,329)then 
                PlaySound(-1,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET",0,0,1)
                if selectedMember~=nil and PlayerIsInGang and gangID~=nil then 
                    if gangPermission>=4 then 
                        TriggerServerEvent("ARMA:PromoteUser",gangID,tonumber(selectedMember))
                    else 
                        tARMA.notify("~r~You don't have permission to promote!")
                    end 
                else 
                    tARMA.notify("~r~No gang member selected")
                end 
            end 
        else 
            DrawRect(0.552,0.443,0.065,0.056,0,0,0,150)
        end
        if CursorInArea(0.6182,0.6822,0.4138,0.4694)then 
            DrawRect(0.651,0.443,0.065,0.056,a,b,c,150)
            if IsControlJustPressed(1,329)or IsDisabledControlJustPressed(1,329)then 
                PlaySound(-1,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET",0,0,1)
                if selectedMember~=nil and PlayerIsInGang and gangID~=nil then 
                    if gangPermission>=4 then 
                        TriggerServerEvent("ARMA:DemoteUser",gangID,selectedMember)
                    else 
                        tARMA.notify("~r~You don't have permission to demote!")
                    end 
                else 
                    tARMA.notify("~r~No gang member selected")
                end 
            end 
        else 
            DrawRect(0.651,0.443,0.065,0.056,0,0,0,150)
        end
        if CursorInArea(0.5187,0.5828,0.5407,0.5962)then 
            DrawRect(0.552,0.569,0.065,0.056,a,b,c,150)
            if IsControlJustPressed(1,329)or IsDisabledControlJustPressed(1,329)then 
                PlaySound(-1,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET",0,0,1)
                if selectedMember~=nil then 
                    if gangPermission>=3 then 
                        if YesNoConfirm()then 
                            TriggerServerEvent("ARMA:kickMemberFromGang",gangID,selectedMember)
                        end 
                    else 
                        tARMA.notify("~r~You don't have permission to kick!")
                    end 
                else 
                    tARMA.notify("~r~No gang member selected")
                end 
            end 
        else 
            DrawRect(0.552,0.569,0.065,0.056,0,0,0,150)
        end
        if CursorInArea(0.6182,0.6822,0.5407,0.5962)then 
            DrawRect(0.651,0.569,0.065,0.056,a,b,c,150)
            if IsControlJustPressed(1,329)or IsDisabledControlJustPressed(1,329)then 
                PlaySound(-1,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET",0,0,1)
                local s=GetPlayerPermID()
                if s~=nil then 
                    if gangPermission>=2 then 
                        TriggerServerEvent("ARMA:InviteUserToGang",gangID,s)
                    else 
                        tARMA.notify("~r~You don't have permission to invite players")
                    end 
                else 
                    tARMA.notify("No player name entered")
                end 
            end 
        else 
            DrawRect(0.651,0.569,0.065,0.056,0,0,0,150)
        end
        if CursorInArea(0.3281,0.3723,0.6768,0.7074)then 
            DrawRect(0.351,0.693,0.045,0.033,a,b,c,150)
            if IsControlJustPressed(1,329)or IsDisabledControlJustPressed(1,329)then 
                PlaySound(-1,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET",0,0,1)
                if e<=1 then 
                    tARMA.notify("~r~Lowest page reached")
                else 
                    e=e-1 
                end 
            end 
        else 
            DrawRect(0.351,0.693,0.045,0.033,0,0,0,150)
        end
        if CursorInArea(0.4130,0.4572,0.6712,0.7064)then 
            DrawRect(0.436,0.693,0.045,0.033,a,b,c,150)
            if IsControlJustPressed(1,329)or IsDisabledControlJustPressed(1,329)then 
                PlaySound(-1,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET",0,0,1)
                if e>=f then 
                    tARMA.notify("~r~Max page reached")
                else 
                    e=e+1 
                end 
            end 
        else 
            DrawRect(0.436,0.693,0.045,0.033,0,0,0,150)
        end
        if CursorInArea(0.6583,0.7056,0.6712,0.7064)then 
            DrawRect(0.681,0.689,0.045,0.036,a,b,c,150)
            if IsControlJustPressed(1,329)or IsDisabledControlJustPressed(1,329)then 
                PlaySound(-1,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET",0,0,1)
                showMembersGangUI=false
                showGangUI=true 
            end 
        else 
            DrawRect(0.681,0.689,0.045,0.036,0,0,0,150)
        end 
    end
    if showLogsGangUI then 
        DrawRect(0.501,0.525,0.421,0.387,0,0,0,150)
        DrawRect(0.501,0.308,0.421,0.047,18,82,228,248)
        DrawAdvancedText(0.591,0.312,0.005,0.0028,0.48,"ARMA Gang - Logs",255,255,255,255,7,0)
        DrawRect(0.502,0.515,0.387,0.276,0,0,0,150)
        -- DrawAdvancedText(0.449,0.365,0.005,0.0028,0.4,"Name",255,255,255,255,4,0)
        -- DrawAdvancedText(0.51,0.365,0.005,0.0028,0.4,"UserID",255,255,255,255,4,0)
        -- DrawAdvancedText(0.583,0.365,0.005,0.0028,0.4,"Date",255,255,255,255,4,0)
        -- DrawAdvancedText(0.757,0.365,0.005,0.0028,0.4,"Amount",255,255,255,255,4,0)
        -- DrawAdvancedText(0.673,0.365,0.005,0.0028,0.4,"New Balance",255,255,255,255,4,0)
        -- DrawRect(0.452,0.686,0.065,0.036,0,0,0,150)
        -- DrawRect(0.545,0.686,0.065,0.036,0,0,0,150)
        -- DrawAdvancedText(0.547,0.688,0.005,0.0028,0.4,"Previous",255,255,255,255,4,0)
        -- DrawAdvancedText(0.639,0.688,0.005,0.0028,0.4,"Next",255,255,255,255,4,0)
        -- DrawAdvancedText(0.591,0.688,0.005,0.0028,0.4,tostring(e).."/"..tostring(f),255,255,255,255,4,0)
        DrawAdvancedText(0.775,0.693,0.005,0.0028,0.4,"Back",255,255,255,255,4,0)
        if CursorInArea(0.6583,0.7056,0.6712,0.7064)then 
            DrawRect(0.681,0.689,0.045,0.036,a,b,c,150)
            if IsControlJustPressed(1,329)or IsDisabledControlJustPressed(1,329)then 
                PlaySound(-1,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET",0,0,1)
                showLogsGangUI=false
                showGangUI=true 
            end 
        else 
            DrawRect(0.681,0.689,0.045,0.036,0,0,0,150)
        end
        DrawAdvancedText(0.596,0.476,0.005,0.0028,1.88,"COMING SOON",205,14,0,255,7,0)
    end
    if showSettingsGangUI then 
        DrawRect(0.501,0.525,0.421,0.387,0,0,0,150)
        DrawRect(0.501,0.308,0.421,0.047,18,82,228,248)
        DrawAdvancedText(0.591,0.312,0.005,0.0028,0.48,"ARMA Gang - Settings",255,255,255,255,7,0)
        DrawAdvancedText(0.7,0.398,0.005,0.0028,0.46,"Permissions Guide",255,255,255,255,6,0)
        DrawAdvancedText(0.7,0.436,0.005,0.0028,0.46,"A recruit can deposit to the gang funds only.",255,255,255,255,6,0)
        DrawAdvancedText(0.7,0.472,0.005,0.0028,0.46,"A member can invite users",255,255,255,255,6,0)
        DrawAdvancedText(0.7,0.51,0.005,0.0028,0.46,"A Lieutenant can invite and kick members",255,255,255,255,6,0)
        DrawAdvancedText(0.7,0.572,0.005,0.0028,0.46,"A Leader can promote and demote members.",255,255,255,255,6,0)
        DrawAdvancedText(0.7,0.532,0.005,0.0028,0.46,"and withdraw from the gang funds.",255,255,255,255,6,0)
        DrawAdvancedText(0.451,0.516,0.005,0.0028,0.4,"Leave Gang",255,255,255,255,6,0)
        DrawAdvancedText(0.554,0.515,0.005,0.0028,0.4,"Disband Gang",255,255,255,255,4,0)
        DrawAdvancedText(0.775,0.693,0.005,0.0028,0.4,"Back",255,255,255,255,4,0)
        if CursorInArea(0.3187,0.3937,0.4712,0.5462)then 
            DrawRect(0.357,0.51,0.075,0.076,a,b,c,150)
            if IsControlJustPressed(1,329)or IsDisabledControlJustPressed(1,329)then 
                PlaySound(-1,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET",0,0,1)
                if YesNoConfirm()then 
                    TriggerServerEvent("ARMA:memberLeaveGang",gangID)
                    setCursor(0)
                    SetPlayerControl(PlayerId(),1,0)
                end 
            end 
        else 
            DrawRect(0.357,0.51,0.075,0.076,0,0,0,150)
        end
        if CursorInArea(0.4197,0.4932,0.4712,0.5462)then 
            DrawRect(0.457,0.51,0.075,0.076,a,b,c,150)
            if IsControlJustPressed(1,329)or IsDisabledControlJustPressed(1,329)then 
                PlaySound(-1,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET",0,0,1)
                if gangPermission>=4 then 
                    if YesNoConfirm()==true and gangID~=nil then 
                        TriggerServerEvent("ARMA:DeleteGang",gangID)
                    end 
                else 
                    tARMA.notify("~r~You don't have permission to disband!")
                end 
            end 
        else 
            DrawRect(0.457,0.51,0.075,0.076,0,0,0,150)
        end
        if CursorInArea(0.6583,0.7056,0.6712,0.7064)then 
            DrawRect(0.681,0.689,0.045,0.036,a,b,c,150)
            if IsControlJustPressed(1,329)or IsDisabledControlJustPressed(1,329)then 
                PlaySound(-1,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET",0,0,1)
                showSettingsGangUI=false
                showGangUI=true 
            end 
        else 
            DrawRect(0.681,0.689,0.045,0.036,0,0,0,150)
        end 
    end
    if showTurfsGangUI then 
        DrawRect(0.501,0.533,0.421,0.497,0,0,0,150)
        DrawRect(0.501,0.308,0.421,0.047,18,82,228,248)
        DrawAdvancedText(0.591,0.312,0.005,0.0028,0.48,"ARMA Gang - Turfs",255,255,255,255,7,0)
        DrawAdvancedText(0.399,0.38,0.005,0.0028,0.4,"Weed Turf - (Owned by " .. turfData[1].gangOwner .. ") Commission - " .. globalWeedCommissionPercent .. "%",255,255,255,255,0,1)
        DrawAdvancedText(0.399,0.44,0.005,0.0028,0.4,"Cocaine Turf - (Owned by " ..turfData[2].gangOwner .. ") Commission - " .. globalCocaineCommissionPercent .. "%",255,255,255,255,0,1)
        DrawAdvancedText(0.399,0.50,0.005,0.0028,0.4,"Meth Turf - (Owned by " .. turfData[3].gangOwner .. ") Commission - " .. globalMethCommissionPercent .. "%",255,255,255,255,0,1)
        DrawAdvancedText(0.399,0.56,0.005,0.0028,0.4,"Heroin Turf - (Owned by " ..turfData[4].gangOwner .. ") Commission - " .. globalHeroinCommissionPercent .. "%",255,255,255,255,0,1)
        DrawAdvancedText(0.399,0.62,0.005,0.0028,0.4,"Large Arms - (Owned by " .. turfData[5].gangOwner .. ") Commission - " .. globalLargeArmsCommission .. "%",255,255,255,255,0,1)
        DrawAdvancedText(0.399,0.68,0.005,0.0028,0.4,"LSD North Turf - (Owned by " ..turfData[6].gangOwner .. ") Commission - " .. globalLSDNorthCommissionPercent .. "%",255,255,255,255,0,1)
        DrawAdvancedText(0.399,0.74,0.005,0.0028,0.4,"LSD South Turf - (Owned by " ..turfData[7].gangOwner .. ") Commission - " .. globalLSDSouthCommissionPercent .. "%",255,255,255,255,0,1)
    end
    if showGangUI then 
        DrawRect(0.501,0.532,0.375,0.225,0,0,0,150)
        DrawRect(0.501,0.396,0.375,0.046,18,82,228,255)
        DrawAdvancedText(0.591,0.399,0.005,0.0028,0.51,"ARMA Gangs",255,255,255,255,7,0)
        DrawAdvancedText(0.46,0.534,0.005,0.0028,0.4,"funds",255,255,255,255,7,0)
        DrawAdvancedText(0.554,0.534,0.005,0.0028,0.4,"members",255,255,255,255,7,0)
        DrawAdvancedText(0.642,0.534,0.005,0.0028,0.4,"logs",255,255,255,255,7,0)
        DrawAdvancedText(0.732,0.534,0.005,0.0028,0.4,"settings",255,255,255,255,7,0)
        DrawAdvancedText(0.596,0.604,0.005,0.0028,0.4,"Turfs",255,255,255,255,7,0)
        if CursorInArea(0.3333,0.3973,0.4981,0.5537)then 
            DrawRect(0.366,0.527,0.065,0.056,a,b,c,150)
            if IsControlJustPressed(1,329)or IsDisabledControlJustPressed(1,329)then 
                PlaySound(-1,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET",0,0,1)
                showGangUI=false
                showFundsGangUI=true 
            end 
        else 
            DrawRect(0.366,0.527,0.065,0.056,0,0,0,150)
        end
        if CursorInArea(0.4244,0.4903,0.4981,0.5537)then 
            DrawRect(0.458,0.527,0.065,0.056,a,b,c,150)
            if IsControlJustPressed(1,329)or IsDisabledControlJustPressed(1,329)then 
                PlaySound(-1,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET",0,0,1)
                showGangUI=false
                showMembersGangUI=true 
            end 
        else 
            DrawRect(0.458,0.527,0.065,0.056,0,0,0,150)
        end
        if CursorInArea(0.5140,0.5776,0.4981,0.5537)then 
            DrawRect(0.546,0.527,0.065,0.056,a,b,c,150)
            if IsControlJustPressed(1,329)or IsDisabledControlJustPressed(1,329)then 
                PlaySound(-1,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET",0,0,1)
                showGangUI=false
                showLogsGangUI=true 
            end 
        else 
            DrawRect(0.546,0.527,0.065,0.056,0,0,0,150)
        end
        if CursorInArea(0.6020,0.6677,0.4981,0.5537)then 
            DrawRect(0.635,0.527,0.065,0.056,a,b,c,150)
            if IsControlJustPressed(1,329)or IsDisabledControlJustPressed(1,329)then 
                PlaySound(-1,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET",0,0,1)
                showGangUI=false
                showSettingsGangUI=true 
            end 
        else 
            DrawRect(0.635,0.527,0.065,0.056,0,0,0,150)
        end
        if CursorInArea(0.4677,0.5333,0.5722,0.6259)then 
            DrawRect(0.501,0.6,0.065,0.056,a,b,c,150)
            if IsControlJustPressed(1,329)or IsDisabledControlJustPressed(1,329)then 
                PlaySound(-1,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET",0,0,1)
                showGangUI=false
                showTurfsGangUI=true 
            end 
        else 
            DrawRect(0.501,0.6,0.065,0.056,0,0,0,150)
        end 
    end 
end
createThreadOnTick(func_drawGangUI)
Citizen.CreateThread(function()
    while true do 
        if IsControlJustPressed(0,166)or IsDisabledControlJustPressed(0,166)then 
            TriggerEvent("ARMA:ForceRefreshData")
            if not PlayerIsInGang then 
                if showNoGangUI then 
                    showNoGangUI=false
                    setCursor(0)
                    inGUIARMA=false
                    selectedGangInvite=nil 
                else 
                    showNoGangUI=true
                    setCursor(1)
                    inGUIARMA=true 
                end 
            end
            if PlayerIsInGang then 
                showSettingsGangUI=false
                showTurfsGangUI=false
                showFundsGangUI=false
                showLogsGangUI=false
                showMembersGangUI=false
                showNoGangUI=false
                if showGangUI then 
                    showGangUI=false
                    setCursor(0)
                    inGUIARMA=false
                    selectedMember=nil 
                else 
                    showGangUI=true
                    setCursor(1)
                    inGUIARMA=true 
                end 
            end
            Wait(100)
        end
        Wait(0)
    end 
end)
function GetGangNameText()
    AddTextEntry('FMMC_MPM_NA',"Enter Gang Name:")
    DisplayOnscreenKeyboard(1,"FMMC_MPM_NA","","","","","",30)
    while UpdateOnscreenKeyboard()==0 do 
        DisableAllControlActions(0)
        Wait(0)
    end
    if GetOnscreenKeyboardResult()then 
        local t=GetOnscreenKeyboardResult()
        return t 
    end
    return nil 
end
function GetPlayerPermID()
    AddTextEntry('FMMC_MPM_NA',"Enter exact player permid to invite:")
    DisplayOnscreenKeyboard(1,"FMMC_MPM_NA","","","","","",30)
    while UpdateOnscreenKeyboard()==0 do 
        DisableAllControlActions(0)
        Wait(0)
    end
    if GetOnscreenKeyboardResult()then 
        local t=GetOnscreenKeyboardResult()
        return t 
    end
    return nil 
end
function YesNoConfirm()
    AddTextEntry('FMMC_MPM_NA',"Are you sure?")
    DisplayOnscreenKeyboard(1,"FMMC_MPM_NA","Are you sure?","Yes | No","","","",30)
    while UpdateOnscreenKeyboard()==0 do 
        DisableAllControlActions(0)
        Wait(0)
    end
    if GetOnscreenKeyboardResult()then 
        local t=GetOnscreenKeyboardResult()
        if t=="yes"or t=="Yes"then 
            return true 
        else 
            return false 
        end 
    end
    return false 
end
function GetMoneyAmountText()
    AddTextEntry('FMMC_MPM_NA',"Enter amount:")
    DisplayOnscreenKeyboard(1,"FMMC_MPM_NA","Enter amount:","","","","",30)
    while UpdateOnscreenKeyboard()==0 do 
        DisableAllControlActions(0)
        Wait(0)
    end
    if GetOnscreenKeyboardResult()then 
        local t=GetOnscreenKeyboardResult()
        return t 
    end
    return nil 
end

RegisterNetEvent("ARMA:Notify",function(u)
    tARMA.notify(u)
end)

function closeToBarclays()
    local v=GetEntityCoords(GetPlayerPed(PlayerId()),false)
    local w=#(v-vector3(151.7451171875,-1036.7829589844,29.338624954224))
    local x=#(v-vector3(4478.2436523438,-4464.0170898438,4.2557549476624))
    local z =#(v-vector3(-104.27473449707,6469.9150390625,31.626708984375))
    if w<10.0 or x<10.0 or z<10.0 then 
        return true 
    else 
        tARMA.notify("~r~You must be near Barclays to access gang funds.")
        return false 
    end 
end
function getMoneyStringFormatted(cashString)
	local i, j, minus, int, fraction = tostring(cashString):find('([-]?)(%d+)([.]?%d*)')
	int = int:reverse():gsub("(%d%d%d)", "%1,")
	return minus .. int:reverse():gsub("^,", "") .. fraction 
end