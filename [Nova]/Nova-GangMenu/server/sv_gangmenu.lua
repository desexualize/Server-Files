local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local vRP = Proxy.getInterface("vRP")
local vRPclient = Tunnel.getInterface("vRP", "GangMenu")

local Gang_Info_Table = {} -- [gang_name] = {gang_name, gang_funds, gang_leader_name, leader_user_id, gang_members = {[user_id] = {user_id, user_name, gang_name, gang_rank}}}
local Gang_Members_Table = {} -- [user_id] = gang_name
local Gang_Invites_Table = {} -- [user_id] = {gang_name, gang_leader_name, invited_by_name}

local function Get_Gang_Info_From_Name(gang_name)
    return Gang_Info_Table[gang_name]
end

local function Get_Member_Gang_Name_From_User_ID(client_user_id)
    return Gang_Members_Table[client_user_id]
end

local function Does_User_ID_Have_Gang(client_user_id)
    local is_gang_member = Gang_Members_Table[client_user_id]
    if is_gang_member then
        return true
    else
        return false
    end
end

RegisterNetEvent('Nova:GangMenu:Server:CheckHasGangLicense')
AddEventHandler('Nova:GangMenu:Server:CheckHasGangLicense', function(player_server_id)
    local source = source
    if player_server_id then
        source = player_server_id
    end

    local user_id = vRP.getUserId({source})
    print(string.format('Source ID: %s, requested Gang License Check', source))
    TriggerClientEvent('Nova:GangMenu:Client:CheckHasGangLicense', source, vRP.hasGroup({user_id, 'Gang'}))
end)

RegisterNetEvent('Nova:GangMenu:Server:CheckHasGang')
AddEventHandler('Nova:GangMenu:Server:CheckHasGang', function(player_server_id)
    local source = source
    if player_server_id then
        source = player_server_id
    end

    local user_id = vRP.getUserId({source})
    local client_in_gang = Does_User_ID_Have_Gang(user_id)
   
    TriggerClientEvent('Nova:GangMenu:Client:CheckHasGang', source, client_in_gang)
    print(string.format('Source ID: %s, requested Gang Check', source))
end)

RegisterNetEvent("Nova:GangMenu:Server:GetGangInfo")
AddEventHandler("Nova:GangMenu:Server:GetGangInfo", function(player_server_id)
    local source = source
    if player_server_id then
        source = player_server_id
    end
    local user_id = vRP.getUserId({source})
    
    local client_gang_name = Get_Member_Gang_Name_From_User_ID(user_id)
    local gang_info = Get_Gang_Info_From_Name(client_gang_name)

    local gang_members = nil
    local my_info = nil
    if gang_info then
        gang_members = gang_info.gang_members
        if gang_members then
            my_info = gang_members[user_id]
            --print(json.encode(my_info))
        end
    end

    local user_gang_invites = Gang_Invites_Table[user_id]
    local has_gang = Does_User_ID_Have_Gang(user_id)
    
    TriggerClientEvent("Nova:GangMenu:Client:RecieveGangInfo", source, gang_info, gang_members, my_info, propganglogs, user_gang_invites, has_gang)
end)


RegisterNetEvent("Nova:GangMenu:Server:WithdrawGangFunds")
AddEventHandler("Nova:GangMenu:Server:WithdrawGangFunds", function(amount)
    local amount = tonumber(amount)
    local source = source
    local user_id = vRP.getUserId({source})
    local coords = GetEntityCoords(GetPlayerPed(source))
    local bank = vector3(148.94, -1040.05, 29.38)
    if #(coords - bank) < 15 then
        if amount >= 0 then
            MySQL.query(string.format("select * FROM ganginfo where userid = %s", user_id), {}, function(result)
                local funds = result
                for k, v in pairs(funds) do 
                    local AvailableGangFunds = tonumber(v.gangfunds)
                    if AvailableGangFunds < amount then
                        vRPclient.notify(source, {"Not enough money"})
                    else
                        local moneyleft = AvailableGangFunds - amount
                        MySQL.update(string.format("update ganginfo set gangfunds = %s where userid = %s", moneyleft, user_id))
                        vRP.giveBankMoney({user_id, amount})
                        vRPclient.notify(source, {"You have withdrew £" .. shared_functions.Get_Formatted_Money(amount) .. " from gang funds"})

                        local gang_name = Get_Member_Gang_Name_From_User_ID(user_id)
                        Gang_Info_Table[gang_name].gang_funds = moneyleft
                        TriggerClientEvent('Nova:GangMenu:Client:UpdatedGangFunds', source, moneyleft)
                    end
                end
            end)
        end
    else 
        print("UserID:" .. user_id .. " Is Probably Cheating | Doing Withdraw from an unsafe distance")
    end
end)

RegisterNetEvent("Nova:GangMenu:Server:DepositGangFunds")
AddEventHandler("Nova:GangMenu:Server:DepositGangFunds", function(amount)
    local amount = tonumber(amount)
    local source = source
    local user_id = vRP.getUserId({source})
    local coords = GetEntityCoords(GetPlayerPed(source))
    local bank = vector3(148.94, -1040.05, 29.38)
    if #(coords - bank) < 15 then
        local AvailableMoney = vRP.getBankMoney({user_id})
        MySQL.query(string.format("select * from ganginfo where userid = %s", user_id), {}, function(result)
            local fundsavailable = result
            for k, v in pairs(fundsavailable) do 
                local AvailableGangFunds = tonumber(v.gangfunds)
                if AvailableMoney >= amount then
                    if vRP.tryFullPayment({user_id, amount}) then
                        local moneyleft = AvailableGangFunds + amount
                        MySQL.update(string.format("update ganginfo set gangfunds = %s where userid = %s",  moneyleft, user_id))
                        vRPclient.notify(source, {"Deposited: £" .. shared_functions.Get_Formatted_Money(amount)})

                        local gang_name = Get_Member_Gang_Name_From_User_ID(user_id)
                        Gang_Info_Table[gang_name].gang_funds = moneyleft
                        TriggerClientEvent('Nova:GangMenu:Client:UpdatedGangFunds', source, moneyleft)
                    else 
                        vRPclient.notify(source, {"You do not have enough money to deposit"})
                    end
                else 
                    vRPclient.notify(source,{"You do not have enough money to deposit"})
                end
            end
        end)
    else 
        print("UserID:" ..user_id.. " Is Probably Cheating | Doing Withdraw from an unsafe distance")
    end
end)

RegisterNetEvent("Nova:GangMenu:Server:UpdateGangRank")
AddEventHandler("Nova:GangMenu:Server:UpdateGangRank", function(MemberName, OldRank, NewRank, UserID)
    local source = source
    local user_id = vRP.getUserId({source})
    if source ~= nil and MemberName ~= nil and OldRank ~= nil and NewRank ~= nil and UserID ~= nil then
        MySQL.query(string.format("select * from gangmembers where userid = %s", UserID), {}, function(result)
            for k, v in pairs(result) do 
                if v.name == MemberName and v.rank == OldRank then 
                    MySQL.update(string.format("update gangmembers set rank = %s WHERE userid = %s", NewRank, UserID))
                    vRPclient.notify(source, {"Updated " .. MemberName .."'s rank to: " .. NewRank})

                    local gang_name = Get_Member_Gang_Name_From_User_ID(UserID)
                    Gang_Info_Table[gang_name].gang_members[UserID] = NewRank

                    if NewRank == 'Owner' then
                        Gang_Info_Table[gang_name].gang_leader_name = MemberName
                        Gang_Info_Table[gang_name].leader_user_id = UserID
                    end
                end
            end
        end)
    else 
        vRPclient.notify(source, {"Error: One field is nil!"})
    end
end)

RegisterNetEvent("Nova:GangMenu:Server:KickPlayer")
AddEventHandler("Nova:GangMenu:Server:KickPlayer", function(Name, UserID, Rank)
    local source = source
    local user_id = vRP.getUserId({source})
    if source ~= nil and Name ~= nil and Rank ~= nil and UserID ~= nil then
        MySQL.query(string.format("select * from gangmembers where userid = %s", UserID), {}, function(result)
            for k,v in pairs(result) do 
                if user_id == UserID then 
                    vRPclient.notify(source, {"Cannot Kick yourself!"})
                else
                    if v.name == Name and v.rank == Rank then 
                        MySQL.update(string.format("delete from gangmembers where userid = %s", UserID))
                        vRPclient.notify(source, {"Kicked " .. Name})

                        local gang_name = Get_Member_Gang_Name_From_User_ID(UserID)
                        table.remove(Gang_Info_Table[gang_name].members, UserID)
                        table.remove(Gang_Members_Table, UserID)
                        TriggerEvent('Nova:GangMenu:Server:CheckHasGang', vRP.getUserSource({UserID}))
                    end
                end
            end
        end)
    else 
        vRPclient.notify(source, {"Error: One field is nil!"})
    end
end)

RegisterNetEvent("Nova:GangMenu:Server:LeaveGang")
AddEventHandler("Nova:GangMenu:Server:LeaveGang", function(MemberName, MemberRank, MemberUserID)
    local source = source
    local user_id = vRP.getUserId({source})
    if user_id == MemberUserID and MemberName ~= nil and MemberRank ~= nil then 
        MySQL.query(string.format("select * from gangmembers where userid = %s", MemberUserID), {}, function(result)
            for k, v in pairs(result) do 
                if v.userid == MemberUserID and MemberRank == v.rank then
                    MySQL.update(string.format("delete from gangmembers where userid = %s", v.userid))
                    vRPclient.notify(source, {"Gang successfully left"})

                    local gang_name = Get_Member_Gang_Name_From_User_ID(user_id)
                    if gang_name then
                        Gang_Info_Table[gang_name].gang_members[user_id] = nil
                        Gang_Members_Table[user_id] = nil

                        for member_user_id, member_table in pairs(Gang_Info_Table[gang_name].gang_members) do
                            TriggerEvent('Nova:GangMenu:Server:GetGangInfo', vRP.getUserSource({member_user_id}))
                        end
                    end
                    TriggerClientEvent('Nova:GangMenu:Client:CloseAllMenus', source)
                    TriggerEvent('Nova:GangMenu:Server:CheckHasGang', source)
                end
            end
        end)
    end
end)

RegisterNetEvent("Nova:GangMenu:Server:DisbandGang")
AddEventHandler("Nova:GangMenu:Server:DisbandGang", function(GangName, GangLeader, GangFunds, MemberName, MemberUserID)
    local source = source
    local user_id = vRP.getUserId({source})
    MySQL.query(string.format('select * from ganginfo where gangname = "%s"', GangName), {}, function(result)
        for k, v in pairs(result) do 
            if GangName == v.gangname and GangFunds == v.gangfunds then 
                MySQL.update(string.format('delete from ganginfo where gangname = "%s"', v.gangname))
                MySQL.query(string.format("select * from gangmembers where userid = %s", MemberUserID), {}, function(result)
                    for k, v in pairs(result) do 
                        if v.name == MemberName and v.userid == MemberUserID then 
                            MySQL.update(string.format("delete from gangmembers where userid = %s", v.userid))
                            vRPclient.notify(source, {"Disbanded Gang"})
                            TriggerClientEvent('Nova:GangMenu:Client:CloseAllMenus', source)

                            local gang_info = Get_Gang_Info_From_Name(GangName)
                            if gang_info then
                                local gang_members = gang_info.gang_members
                                for member_user_id, member_table in pairs(gang_members) do
                                    --print(member_user_id, json.encode(member_table))
                                    if Gang_Members_Table[member_user_id] then
                                        Gang_Members_Table[member_user_id] = nil
                                        TriggerEvent('Nova:GangMenu:Server:CheckHasGang', vRP.getUserSource({member_user_id}))
                                    end
                                end
                                Gang_Info_Table[GangName] = nil
                            end
                            TriggerEvent('Nova:GangMenu:Server:CheckHasGang', vRP.getUserSource({source}))
                        end
                    end
                end)
            end
        end
    end)
end)


RegisterNetEvent("Nova:GangMenu:Server:CreateGang")
AddEventHandler("Nova:GangMenu:Server:CreateGang", function(name, leader)
    local source = source 
    local user_id = vRP.getUserId({source})
    if vRP.hasGroup({user_id, 'Gang'}) then
        MySQL.query(string.format("select * from gangmembers where userid = %s", user_id), {}, function(result)
            local gang = json.encode(result)
            if gang == "[]" then 
                MySQL.query(string.format('select * from ganginfo where gangname = "%s"', name), {}, function(result)
                    local gang = json.encode(result)
                    if gang == "[]" then 
                        MySQL.insert(string.format(
                            "insert into ganginfo (userid, gangname, gangfunds, gangleader) values (%s, \"%s\", %s, \"%s\")",
                            user_id, name, 0, leader
                        ))
                        MySQL.insert(string.format(
                            "insert into gangmembers (userid, gangname, name, rank) values (%s, \"%s\", \"%s\", \"%s\")",
                            user_id, name, leader, "Owner"
                        ))

                        TriggerClientEvent("Nova:GangMenu:Client:CloseAllMenus", source)
                        vRPclient.notify(source, {"Created Gang!"})
                        
                        Gang_Info_Table[name] = {
                            ['gang_name'] = name,
                            ['gang_funds'] = 0,
                            ['gang_leader_name'] = leader,
                            ['leader_user_id'] = user_id,
                            ['gang_members'] = {
                                [user_id] = {
                                    ['user_id'] = user_id,
                                    ['user_name'] = leader,
                                    ['gang_name'] = name,
                                    ['gang_rank'] = 'Owner',
                                },
                            }
                        }

                        Gang_Members_Table[user_id] = name
                        TriggerEvent('Nova:GangMenu:Server:CheckHasGang', source)
                        TriggerEvent('Nova:GangMenu:Server:GetGangInfo', source)
                    else 
                        vRPclient.notify(source, {"Error: Gang Name/Leader is already taken"})
                    end
                end)
            else
                vRPclient.notify(source, {"You are already in a gang!"})
            end
        end)
    else
        vRPclient.notify(source, {'~r~You need a gang license to create a gang.'})
    end
end)

RegisterNetEvent("Nova:GangMenu:Server:JoinGang")
AddEventHandler("Nova:GangMenu:Server:JoinGang", function(GangNameToJoin, GangLeaderToJoin, GangPersonInvitedBy, IDToConfirm)
    local source = source 
    local PlayerName = GetPlayerName(source)
    local userid = tonumber(vRP.getUserId({source}))
    local IDToConfirm = tonumber(IDToConfirm)
    if userid ~= IDToConfirm then 
        print('Perm IDS dont match, hacker maybe?')
    end

    if GangNameToJoin ~= nil and GangLeaderToJoin ~= nil and GangPersonInvitedBy ~= nil and PlayerName ~= nil and userid ~= nil then
        MySQL.query(string.format("select * from gangmembers where userid = %s", userid), {}, function(result)
            local gang = json.encode(result)
            if gang == "[]" then 
                MySQL.query(string.format('select * from ganginfo where gangname = "%s"', GangNameToJoin), {}, function(result)
                    local ganginfo = json.encode(result)
                    if ganginfo == "[]" then 
                        vRPclient.notify(source, {"That gang does not exist, invite has expired!"})
                    else
                        MySQL.insert(string.format(
                            "insert into gangmembers (userid, gangname, name, rank) values (%s, \"%s\", \"%s\", \"%s\");",
                            userid, GangNameToJoin, PlayerName, "Recruit"
                        ))
                        
                        MySQL.update(string.format("delete from ganginvites where userid = %s", userid))
                        vRPclient.notify(source, {"You have joined the gang: " .. GangNameToJoin .. " !"})

                        local gang_info = Get_Gang_Info_From_Name(GangNameToJoin)
                        if gang_info then
                            Gang_Info_Table[GangNameToJoin].gang_members[userid] = {
                                ['user_id'] = userid,
                                ['user_name'] = PlayerName,
                                ['gang_name'] = GangNameToJoin,
                                ['gang_rank'] = 'Recruit',
                            }
                            Gang_Members_Table[userid] = GangNameToJoin
                        end
                        Gang_Invites_Table[userid] = nil

                        TriggerEvent('Nova:GangMenu:Server:CheckHasGang', source)
                        for member_user_id, member_table in pairs(Gang_Info_Table[GangNameToJoin].gang_members) do
                            TriggerEvent('Nova:GangMenu:Server:GetGangInfo', vRP.getUserSource({member_user_id}))
                        end
                    end
                end)
            else
                vRPclient.notify(source, {"You are already in a gang!"})
            end
        end)
    end
end)


RegisterNetEvent("Nova:GangMenu:Server:InviteMember")
AddEventHandler("Nova:GangMenu:Server:InviteMember", function(PermToInv, GangName, GangLeader)
    local src = source
    local MyName = GetPlayerName(src)
    local MyPermID = tonumber(vRP.getUserId({src}))
    local PermToInv = tonumber(PermToInv)

    if PermToInv == MyPermID then 
        return vRPclient.notify(src, {"Error: You cannot invite yourself!"})
    end

    if GangName ~= nil and GangLeader ~= nil and MyName ~= nil and MyPermID ~= nil and src ~= nil then
        MySQL.query(string.format("select * from gangmembers where userid = %s", PermToInv), {}, function(result)
            gang = json.encode(result)
            if gang == "[]" then 
                MySQL.insert(string.format(
                    "insert into ganginvites (userid, gangname, gangleader, personinvitedby) values (%s, \"%s\", \"%s\", \"%s\")",
                    PermToInv, GangName, GangLeader, MyName
                ))
                message = 'Successfully invited Perm ID: ' .. PermToInv .. ' to the gang: ' .. GangName .. ' !'
                vRPclient.notify(src, {message})

                local user_gang_invite_table = {
                    ['user_id'] = PermToInv,
                    ['gang_name'] = GangName,
                    ['gang_leader_name'] = GangLeader,
                    ['invited_by_name'] = MyName,
                }

                local existing_invites_table = Gang_Invites_Table[PermToInv]
                if existing_invites_table then
                    table.insert(existing_invites_table, user_gang_invite_table)
                else
                    Gang_Invites_Table[PermToInv] = {
                        user_gang_invite_table
                    }
                end
                TriggerEvent('Nova:GangMenu:Server:GetGangInfo', vRP.getUserSource({PermToInv}))
            else
                message = "Error: That perm id is already in a gang!"
                vRPclient.notify(src, {message})
            end
        end)
    end
end)

local function Gang_Menu_Server_Setup()
    Citizen.CreateThread(function()
        --MySQL.update('delete from ganginfo where userid = 6')
        --MySQL.update('delete from gangmembers where userid = 6')

        local gang_info_result = MySQL.query.await('select * from ganginfo')
        if gang_info_result then 
            for table_id, gang_info in pairs(gang_info_result) do 
                local gang_name = gang_info.gangname
                local gang_funds = gang_info.gangfunds
                local gang_leader_name = gang_info.gangleader
                local gang_leader_user_id = gang_info.userid

                Gang_Info_Table[gang_name] = {
                    ['gang_name'] = gang_name,
                    ['gang_funds'] = gang_funds,
                    ['gang_leader_name'] = gang_leader_name,
                    ['leader_user_id'] = gang_leader_user_id,
                    ['gang_members'] = {},
                }

                --print(json.encode(Gang_Info_Table[gang_name]))
            end
        end

        local gang_members_result = MySQL.query.await("select * from gangmembers")
        if gang_members_result then 
            for table_id, gang_info in pairs(gang_members_result) do 
                local user_id = gang_info.userid
                local user_name = gang_info.name
                local gang_name = gang_info.gangname
                local gang_rank = gang_info.rank
                
                local existing_gang_table = Gang_Info_Table[gang_name]
                if existing_gang_table then
                    Gang_Members_Table[user_id] = gang_name
                    existing_gang_table.gang_members[user_id] = {
                        ['user_id'] = user_id,
                        ['user_name'] = user_name,
                        ['gang_name'] = gang_name,
                        ['gang_rank'] = gang_rank,
                    }
                else
                    MySQL.update(string.format('delete from gangmembers where gangname = "%s"', gang_name))
                end

                --print(json.encode(gang_info))
                --print(json.encode(Gang_Info_Table[gang_name]))
            end
        end
        
        local gang_invites_result = MySQL.query.await('select * from ganginvites')
        if gang_invites_result then
            for table_id, invite_info in pairs(gang_invites_result) do
                local user_id = invite_info.userid
                local gang_name = invite_info.gangname
                local gang_leader_name = invite_info.gangleader
                local invited_by_name = invite_info.personinvitedby

                local user_gang_invite_table = {
                    ['user_id'] = user_id,
                    ['gang_name'] = gang_name,
                    ['gang_leader_name'] = gang_leader_name,
                    ['invited_by_name'] = invited_by_name,
                }

                local existing_invites_table = Gang_Invites_Table[user_id]
                if existing_invites_table then
                    table.insert(existing_invites_table, user_gang_invite_table)
                else
                    Gang_Invites_Table[user_id] = {
                        user_gang_invite_table
                    }
                end
                print(json.encode(Gang_Invites_Table[user_id]))
            end
        end
        print('Gang tables initialised')
    end)
end

Gang_Menu_Server_Setup()