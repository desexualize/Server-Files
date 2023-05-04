local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "GangMenu")


RegisterNetEvent("GetGangInfo")
AddEventHandler("GetGangInfo", function()
    local source = source
    local user_id = vRP.getUserId({source})
    exports['ghmattimysql']:execute("SELECT * FROM gangmembers WHERE userid = @userid", {userid = user_id}, function(result)
        if result ~= nil then 
            gangmemberme = result
            for k,v in pairs(gangmemberme) do 
                gangnamelol = v.gangname
            end
        end
        exports['ghmattimysql']:execute("SELECT * FROM ganginfo WHERE gangname = @gangname", {gangname = gangnamelol}, function(result)
            ganginfo = result
                for k,v in pairs(ganginfo) do 
                    GangName = v.gangname
                    GangFunds = v.gangfunds
                    GangLeader = v.gangleader
                end
                exports['ghmattimysql']:execute("SELECT * FROM gangmembers WHERE gangname = @gangname", {gangname = gangnamelol}, function(result)
                    if result ~= nil then 
                        gangmembers = result
                    end
                exports['ghmattimysql']:execute("SELECT * FROM gangmembers WHERE userid = @userid", {userid = user_id}, function(myinfo)
                    if myinfo ~= nil then 
                        myinfo = myinfo 
                    end
                    exports['ghmattimysql']:execute("SELECT * FROM ganglogs WHERE gangname = @gangname", {gangname = GangName}, function(ganglogs)
                        if ganglogs ~= nil then 
                            propganglogs = ganglogs 
                        end
                        exports['ghmattimysql']:execute("SELECT * FROM ganginvites WHERE userid = @userid", {userid = user_id}, function(ganginvites)
                            if ganginvites ~= nil then 
                                exports['ghmattimysql']:execute("SELECT * FROM gangmembers WHERE userid = @userid", {userid = user_id}, function(ganginfolollol)
                                    if ganginfolollol ~= nil then 
                                        ganginfolollolswag = json.encode(ganginfolollol)
                                        if ganginfolollolswag == '[]' then
                                            InGang = false 
                                        else 
                                            InGang = true
                                        end
                                        TriggerClientEvent("RecieveGangInfo", source, ganginfo, gangmembers, myinfo, propganglogs, ganginvites, InGang)
                                    end
                                end)
                            end
                        end)
                    end)
                end)
            end)
        end)
    end)
	-- -- exports['ghmattimysql']:execute("SELECT * FROM ganginfo WHERE userid = @uid", {uid = user_id}, function(result)
    -- --     if result ~= nil then 
    -- --         ganginfo = result
    -- --         for k,v in pairs(ganginfo) do 
    -- --             GangName = v.gangname
    -- --             GangFunds = v.gangfunds
    -- --             GangLeader = v.gangleader
    -- --         end
    --         exports['ghmattimysql']:execute("SELECT * FROM gangmembers WHERE userid = @userid", {userid = user_id}, function(result)
    --             if result ~= nil then 
    --                 gangmembers = result
    --             end
    --             exports['ghmattimysql']:execute("SELECT * FROM gangmembers WHERE userid = @userid", {userid = user_id}, function(myinfo)
    --                 if myinfo ~= nil then 
    --                     myinfo = myinfo 
    --                 end
    --                 exports['ghmattimysql']:execute("SELECT * FROM ganglogs WHERE gangname = @gangname", {gangname = GangName}, function(ganglogs)
    --                     if ganglogs ~= nil then 
    --                         propganglogs = ganglogs 
    --                     end
    --                     exports['ghmattimysql']:execute("SELECT * FROM ganginvites WHERE userid = @userid", {userid = user_id}, function(ganginvites)
    --                         TriggerClientEvent("RecieveGangInfo", source, ganginfo, gangmembers, myinfo, propganglogs, ganginvites)
    --                     end)
    --                 end)
    --             end)
    --         end)
    -- --     end
	-- -- end)
end)


RegisterNetEvent("WithdrawFunds")
AddEventHandler("WithdrawFunds", function(amount)
    local source = source
    local user_id = vRP.getUserId({source})
    local coords = GetEntityCoords(GetPlayerPed(source))
    local bank = vector3(148.94, -1040.05, 29.38)
    if #(coords - bank) < 15 then
        if tonumber(amount) >= 0 then
            exports['ghmattimysql']:execute("SELECT * FROM ganginfo WHERE userid = @uid", {uid = user_id}, function(result)
                funds = result
                for k,v in pairs(funds) do 
                    AvailableGangFunds = v.gangfunds
                        if tonumber(AvailableGangFunds) < tonumber(amount) then
                            vRPclient.notify(source,{"Not enough money"})
                        else
                            local moneyleft = AvailableGangFunds-tonumber(amount)
                            exports.ghmattimysql:execute("UPDATE ganginfo SET gangfunds = @money WHERE userid = @userid", {money = moneyleft, userid = user_id})
                            vRP.giveBankMoney({user_id, tonumber(amount)})
                            vRPclient.notify(source,{"You have withdrew £" ..Comma(tonumber(amount)).. " from gang funds"})
                        end
                end
            end)
        end
    else 
        print("UserID:" ..user_id.. " Is Probably Cheating | Doing Withdraw from an unsafe distance")
    end
end)

RegisterNetEvent("DepositFunds")
AddEventHandler("DepositFunds", function(amount)
    local source = source
    local user_id = vRP.getUserId({source})
    local coords = GetEntityCoords(GetPlayerPed(source))
    local bank = vector3(148.94, -1040.05, 29.38)
    if #(coords - bank) < 15 then
        local AvailableMoney = vRP.getBankMoney({user_id})
        exports['ghmattimysql']:execute("SELECT * FROM ganginfo WHERE userid = @uid", {uid = user_id}, function(result)
            fundsavailable = result
            for k,v in pairs(fundsavailable) do 
                AvailableGangFunds = v.gangfunds
                if AvailableMoney >= tonumber(amount) then
                    if vRP.tryFullPayment({user_id, tonumber(amount)}) then
                        local moneyleft = AvailableGangFunds + amount
                        exports.ghmattimysql:execute("UPDATE ganginfo SET gangfunds = @money WHERE userid = @userid", {money = moneyleft, userid = user_id})
                        vRPclient.notify(source,{"Deposited: £ " ..tonumber(amount)})
                    else 
                        vRPclient.notify(source,{"You do not have enough money to deposit"})
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

RegisterNetEvent("UpdateRank")
AddEventHandler("UpdateRank", function(MemberName, OldRank, NewRank, UserID)
    local source = source
    local user_id = vRP.getUserId({source})
    if source ~= nil and MemberName ~= nil and OldRank ~= nil and NewRank ~= nil and UserID ~= nil then
        exports['ghmattimysql']:execute("SELECT * FROM gangmembers WHERE userid = @uid", {uid = UserID}, function(result)
            for k,v in pairs(result) do 
                if v.name == MemberName and v.rank == OldRank then 
                    exports.ghmattimysql:execute("UPDATE gangmembers SET rank = @rank WHERE userid = @userid", {rank = NewRank, userid = UserID})
                    vRPclient.notify(source,{"Updated " ..MemberName.."'s rank to: " ..NewRank})
                end
            end
        end)
    else 
        vRPclient.notify(source,{"Error: One field is nil!"})
    end
end)

RegisterNetEvent("KickPlayer")
AddEventHandler("KickPlayer", function(Name, Rank, UserID)
    local source = source
    local user_id = vRP.getUserId({source})
    if source ~= nil and Name ~= nil and Rank ~= nil and UserID ~= nil then
        exports['ghmattimysql']:execute("SELECT * FROM gangmembers WHERE userid = @uid", {uid = UserID}, function(result)
            for k,v in pairs(result) do 
                if user_id == UserID then 
                    vRPclient.notify(source,{"Cannot Kick yourself!"})
                else
                    if v.name == Name and v.rank == Rank then 
                        exports.ghmattimysql:execute("DELETE FROM gangmembers WHERE userid = @userid", {userid = UserID})
                        vRPclient.notify(source,{"Kicked " ..Name})
                    end
                end
            end
        end)
    else 
        vRPclient.notify(source,{"Error: One field is nil!"})
    end
end)

RegisterNetEvent("LeaveGang")
AddEventHandler("LeaveGang", function(MemberName, MemberRank, MemberUserID)
    local source = source
    local user_id = vRP.getUserId({source})
    if user_id == MemberUserID and MemberName ~= nil and MemberRank ~= nil then 
        exports['ghmattimysql']:execute("SELECT * FROM gangmembers WHERE userid = @uid", {uid = MemberUserID}, function(result)
            for k,v in pairs(result) do 
                if v.userid == MemberUserID and MemberRank == v.rank then
                    exports.ghmattimysql:execute("DELETE FROM gangmembers WHERE userid = @userid", {userid = v.userid})
                    vRPclient.notify(source,{"Left your gang"})
                end
            end
        end)
    end
end)

RegisterNetEvent("DisbandGang")
AddEventHandler("DisbandGang", function(GangName, GangLeader, GangFunds, MemberName, MemberUserID)
    local source = source
    local user_id = vRP.getUserId({source})
    exports['ghmattimysql']:execute("SELECT * FROM ganginfo WHERE gangname = @gangname", {gangname = GangName}, function(result)
        for k,v in pairs(result) do 
            if GangName == v.gangname and GangFunds == v.gangfunds then 
                exports.ghmattimysql:execute("DELETE FROM ganginfo WHERE gangname = '" .. v.gangname .. "'", {})
                exports['ghmattimysql']:execute("SELECT * FROM gangmembers WHERE userid = @uid", {uid = MemberUserID}, function(result)
                    for k,v in pairs(result) do 
                        if v.name == MemberName and v.userid == MemberUserID then 
                            exports.ghmattimysql:execute("DELETE FROM gangmembers WHERE userid = @userid", {userid = v.userid})
                            vRPclient.notify(source,{"Disbanded Gang"})
                        end
                    end
                end)
            end
        end
    end)
end)


RegisterNetEvent("creategang")
AddEventHandler("creategang", function(name, leader)
    local source = source 
    local PlayerName = GetPlayerName(source)
    local userid = vRP.getUserId({source})
    if vRP.hasGroup({userid, 'Gang'}) then
        exports['ghmattimysql']:execute("SELECT * FROM gangmembers WHERE userid = @uid", {uid = userid}, function(result)
            local gang = json.encode(result)
            if gang == "[]" then 
                exports['ghmattimysql']:execute("SELECT * FROM ganginfo WHERE gangname = @gangname", {gangname = name}, function(result)
                    local gang = json.encode(result)
                    if gang == "[]" then 
                        exports['ghmattimysql']:execute("INSERT INTO ganginfo (`userid`, `gangname`, `gangfunds`, `gangleader`) VALUES (@userid, @name, @funds, @leader);", {userid = userid, name = name, funds = 0, leader = leader}, function() end)
                        exports['ghmattimysql']:execute("INSERT INTO gangmembers (`userid`, `gangname`, `name`, `rank`) VALUES (@userid, @gangname, @name, @rank);", {userid = userid, gangname = name, name = PlayerName, rank = "Owner"}, function() end)
                        vRPclient.notify(source,{"Created Gang!"})
                        TriggerClientEvent("closemenu", source)
                    else 
                        vRPclient.notify(source,{"Error: Gang Name/Leader is already taken"})
                    end
                end)
            else
                vRPclient.notify(source,{"You are already in a gang!"})
            end
        end)
    else
        vRPclient.notify(source,{'~r~You need a gang license to create a gang.'})
    end
end)

RegisterNetEvent("joininggang")
AddEventHandler("joininggang", function(GangNameToJoin, GangLeaderToJoin, GangPersonInvitedBy, IDToConfirm)
    local source = source 
    local PlayerName = GetPlayerName(source)
    local userid = vRP.getUserId({source})
    if tonumber(userid) ~= tonumber(IDToConfirm) then 
        print('Perm IDS dont match, hacker maybe?')
    end

    if GangNameToJoin ~= nil and GangLeaderToJoin ~= nil and GangPersonInvitedBy ~= nil and PlayerName ~= nil and userid ~= nil then
        exports['ghmattimysql']:execute("SELECT * FROM gangmembers WHERE userid = @uid", {uid = userid}, function(result)
            local gang = json.encode(result)
            if gang == "[]" then 
                exports['ghmattimysql']:execute("SELECT * FROM ganginfo WHERE gangname = @gangname", {gangname = GangNameToJoin}, function(result)
                    local ganginfo = json.encode(result)
                    if ganginfo == "[]" then 
                        vRPclient.notify(source,{"That gang does not exist, invite has expired!"})
                    else
                        exports['ghmattimysql']:execute("INSERT INTO gangmembers (`userid`, `gangname`, `name`, `rank`) VALUES (@userid, @gangname, @name, @rank);", {userid = userid, gangname = GangNameToJoin, name = PlayerName, rank = "Recruit"}, function() end)
                        exports.ghmattimysql:execute("DELETE FROM ganginvites WHERE userid = @userid", {userid = userid})
                        vRPclient.notify(source,{"You have joined the gang: " ..GangNameToJoin.. " !"})
                    end
                end)
            else
                vRPclient.notify(source,{"You are already in a gang!"})
            end
        end)
    end
end)


RegisterNetEvent("MemberInvites")
AddEventHandler("MemberInvites", function(PermToInv, GangName, GangLeader)
    src = source
    MyName = GetPlayerName(source)
    MyPermID = vRP.getUserId({source})
    if tonumber(PermToInv) == tonumber(MyPermID) then 
        vRPclient.notify(src,{"Error: You cannot invite yourself!"})
        return
    end
    if GangName ~= nil and GangLeader ~= nil and MyName ~= nil and MyPermID ~= nil and src ~= nil then
        exports['ghmattimysql']:execute("SELECT * FROM gangmembers WHERE userid = @uid", {uid = tonumber(PermToInv)}, function(result)
            gang = json.encode(result)
            if gang == "[]" then 
                exports['ghmattimysql']:execute("INSERT INTO ganginvites (`userid`, `gangname`, `gangleader`, `personinvitedby`) VALUES (@userid, @gangname, @gangleader, @personinvitedby);", {userid = PermToInv, gangname = GangName, gangleader = GangLeader, personinvitedby = tostring(MyName)}, function() 
                end)
                message = 'Successfully invited Perm ID: ' ..PermToInv.. ' to the gang: ' ..GangName.. ' !'
                vRPclient.notify(src,{message})
            else
                message = "Error: That perm id is already in a gang!"
                vRPclient.notify(src,{message})
            end
        end)
    end
end)

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

Citizen.CreateThread(function()
    Wait(2500)
    exports['ghmattimysql']:execute([[
            CREATE TABLE IF NOT EXISTS `gangmembers` (
                `userid` int(11) NOT NULL AUTO_INCREMENT,
                `gangname` text NOT NULL,
                `name` text NOT NULL,
                `rank` text NOT NULL,
                PRIMARY KEY (`userid`)
              );
        ]])
    exports['ghmattimysql']:execute(
        [[
            CREATE TABLE IF NOT EXISTS `ganginfo` (
                `userid` int(11) NOT NULL AUTO_INCREMENT,
                `gangname` text NOT NULL,
                `gangfunds` text NOT NULL,
                `gangleader` text NOT NULL,
                PRIMARY KEY (`userid`)
            );
        ]]
    )
    exports['ghmattimysql']:execute(
        [[
            CREATE TABLE IF NOT EXISTS `ganglogs` (
                `userid` int(11) NOT NULL AUTO_INCREMENT,
                `gangname` text NOT NULL,
                `gangleader` text NOT NULL,
                `action` text NOT NULL,
                `description` text NOT NULL,
                PRIMARY KEY (`userid`)
            );
        ]]
    )
    exports['ghmattimysql']:execute(
        [[
            CREATE TABLE IF NOT EXISTS `ganginvites` (
                `userid` int(11) NOT NULL,
                `gangname` text NOT NULL,
                `gangleader` text NOT NULL,
                `personinvitedby` text NOT NULL
            );
        ]]
    )
    print("Gang Menu tables iniatlised")
end)
