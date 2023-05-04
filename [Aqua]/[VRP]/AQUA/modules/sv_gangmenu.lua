RegisterServerEvent("AQUA:GetGangData")
AddEventHandler("AQUA:GetGangData", function()
    local source=source
    local newarray = nil
    local peoplesids = {}
    local user_id=AQUA.getUserId(source)
    local gangmembers ={}
    local gangpermission
    exports['ghmattimysql']:execute('SELECT * FROM AQUA_gangs', function(gotGangs)
        for K,V in pairs(gotGangs) do
            local array = json.decode(V.gangmembers)
            for I,L in pairs(array) do
                if tostring(user_id) == I then
                    newarray={}
                    newarray["money"] = V.funds
                    isingang = true
                    newarray["id"] = V.gangname
                    gangpermission = L.gangPermission
                    for U,D in pairs(array) do
                        peoplesids[tostring(U)] = tostring(D.gangPermission)
                    end
                    exports['ghmattimysql']:execute('SELECT * FROM aqua_users', function(gotUser)
                        for J,G in pairs(gotUser) do
                            if peoplesids[tostring(G.id)] ~= nil then
                                table.insert(gangmembers,{G.username,tonumber(G.id),peoplesids[tostring(G.id)]})
                            end
                        end
                        TriggerClientEvent('AQUA:GotGangData', source,newarray,gangmembers,gangpermission)
                    end)
                    break
                end
            end
        end
    end)
end)
RegisterServerEvent("AQUA:CreateGang")
AddEventHandler("AQUA:CreateGang", function(gangname)
    local source=source
    local user_id=AQUA.getUserId(source)
    local user_name = GetPlayerName(source)
    local funds = 0 
    local logs = "NOTHING"
    exports['ghmattimysql']:execute('SELECT gangname FROM AQUA_gangs WHERE gangname = @gangname', {gangname = gangname}, function(gotGang)
        if not AQUA.hasGroup(user_id,"Gang") then
            AQUAclient.notify(source,{"~d~You do not have gang licence."})
            return
        end
        if json.encode(gotGang) ~= "[]" and gotGang ~= nil and json.encode(gotGang) ~= nil then
            AQUAclient.notify(source,{"~d~Gang name is already in use."})
            return
        end
        local gangmembers = {
            [tostring(user_id)] = {
                ["rank"] = 4,
                ["gangPermission"] = 4,
            },
        }
        gangmembers = json.encode(gangmembers)
        AQUAclient.notify(source,{"~g~"..gangname.." created."})
        exports['ghmattimysql']:execute("INSERT INTO AQUA_gangs (gangname,gangmembers,funds,logs) VALUES(@gangname,@gangmembers,@funds,@logs)", {gangname=gangname,gangmembers=gangmembers,funds=funds,logs=logs}, function() end)
        TriggerClientEvent('AQUA:gangNameNotTaken', source)
        TriggerClientEvent('AQUA:ForceRefreshData', -1)
    end)
end)
RegisterServerEvent("AQUA:addUserToGang")
AddEventHandler("AQUA:addUserToGang", function(ganginvite,playerid)
    local source=source
    local user_id=AQUA.getUserId(source)
    local playersource = AQUA.getUserSource(playerid)
    exports['ghmattimysql']:execute('SELECT * FROM AQUA_gangs WHERE gangname = @gangname', {gangname = ganginvite}, function(G)
        if json.encode(G) == "[]" and G == nil and json.encode(G) == nil then
            AQUAclient.notify(playersource,{"~d~Gang no longer exists."})
            return
        end
        for K,V in pairs(G) do
            local array = json.decode(V.gangmembers)
            array[tostring(playerid)] = {["rank"] = 1,["gangPermission"] = 1}
            exports['ghmattimysql']:execute("UPDATE AQUA_gangs SET gangmembers = @gangmembers WHERE gangname=@gangname", {gangmembers = json.encode(array), gangname = ganginvite}, function()
                TriggerClientEvent('AQUA:ForceRefreshData', -1)
            end)
        end
    end)
end)
RegisterServerEvent("AQUA:depositGangBalance")
AddEventHandler("AQUA:depositGangBalance", function(amount)
    local source = source
    local user_id = AQUA.getUserId(source)
    local name = GetPlayerName(source)
    local date = os.date("%d/%m/%Y at %X")
    exports['ghmattimysql']:execute('SELECT * FROM AQUA_gangs', function(gotGangs)
        for K,V in pairs(gotGangs) do
            local array = json.decode(V.gangmembers)
            for I,L in pairs(array) do
                if tostring(user_id) == I then
                    local funds = V.funds
                    local gangname = V.gangname
                    if tonumber(amount) < 0 then
                        AQUAclient.notify(source,{"~d~Invalid Amount"})
                        return
                    end
                    if tonumber(AQUA.getMoney(user_id)) < tonumber(amount) then
                        AQUAclient.notify(source,{"~d~Not enough cash."})
                    else
                        AQUA.setMoney(user_id,tonumber(AQUA.getMoney(user_id))-tonumber(amount))
                        AQUAclient.notify(source,{"~g~Deposited £"..amount})
                        local newamount = tonumber(amount)+tonumber(funds)
                        local tax = tonumber(amount)*0.01
                        local webhook = 'webhook need done'
                        local embed = {
                            {
                                ["color"] = "16777215",
                                ["title"] = "Gang Funds",
                                ["description"] = "**User Name:** "..GetPlayerName(source).."\n**User ID:** "..AQUA.getUserId(source).."\n**Deposit:** £"..getMoneyStringFormatted(amount).."\n**Gang Name:** "..gangname,
                                ["footer"] = {
                                    ["text"] = " - "..os.date("%X"),
                                },
                            }
                        }
                        PerformHttpRequest(webhook, function (err, text, headers) end, 'POST', json.encode({username = 'AQUA', embeds = embed}), { ['Content-Type'] = 'application/json' })
                        exports['ghmattimysql']:execute("UPDATE AQUA_gangs SET funds = @funds WHERE gangname=@gangname", {funds = tostring(newamount)-tostring(tax), gangname = gangname}, function()
                            TriggerClientEvent('AQUA:ForceRefreshData', -1)
                        end)
                    end
                end
            end
        end
    end)
    TriggerClientEvent('AQUA:ForceRefreshData', source)
end)
RegisterServerEvent("AQUA:withdrawGangBalance")
AddEventHandler("AQUA:withdrawGangBalance", function(amount)
    local source = source
    local user_id = AQUA.getUserId(source)
    local name = GetPlayerName(source)
    local date = os.date("%d/%m/%Y at %X")
    exports['ghmattimysql']:execute('SELECT * FROM AQUA_gangs', function(gotGangs)
        for K,V in pairs(gotGangs) do
            local array = json.decode(V.gangmembers)
            for I,L in pairs(array) do
                if tostring(user_id) == I then
                    local funds = V.funds
                    local gangname = V.gangname
                    if tonumber(amount) < 0 then
                        AQUAclient.notify(source,{"~d~Invalid Amount"})
                        return
                    end
                    if tonumber(funds) < tonumber(amount) then
                        AQUAclient.notify(source,{"~d~Invalid Amount."})
                    else
                        AQUA.setMoney(user_id,tonumber(AQUA.getMoney(user_id))+tonumber(amount))
                        AQUAclient.notify(source,{"~g~Withdrew £"..amount})
                        local newamount = tonumber(funds)-tonumber(amount)
                        local webhook = 'webhook need done'
                        local embed = {
                            {
                                ["color"] = "16777215",
                                ["title"] = "Gang Funds",
                                ["description"] = "**User Name:** "..GetPlayerName(source).."\n**User ID:** "..AQUA.getUserId(source).."\n**Withdrew:** £"..getMoneyStringFormatted(amount).."\n**Gang Name:** "..gangname,
                                ["footer"] = {
                                    ["text"] = " - "..os.date("%X"),
                                },
                            }
                        }
                        PerformHttpRequest(webhook, function (err, text, headers) end, 'POST', json.encode({username = 'AQUA', embeds = embed}), { ['Content-Type'] = 'application/json' })
                        exports['ghmattimysql']:execute("UPDATE AQUA_gangs SET funds = @funds WHERE gangname=@gangname", {funds = tostring(newamount), gangname = gangname}, function()
                            TriggerClientEvent('AQUA:ForceRefreshData', -1)
                        end)
                    end
                end
            end
        end
    end)
    TriggerClientEvent('AQUA:ForceRefreshData', source)
end)
RegisterServerEvent("AQUA:PromoteUser")
AddEventHandler("AQUA:PromoteUser", function(gangid,memberid)
    local source = source
    local user_id=AQUA.getUserId(source)
    exports['ghmattimysql']:execute('SELECT * FROM AQUA_gangs', function(gotGangs)
        for K,V in pairs(gotGangs) do
            local array = json.decode(V.gangmembers)
            for I,L in pairs(array) do
                if tostring(user_id) == I then
                    if L.rank >= 4 then
                        local rank = array[tostring(memberid)].rank
                        local gangpermission = array[tostring(memberid)].gangPermission
                        if rank < 4 and gangpermission < 4 and tostring(user_id) ~= I then
                            AQUAclient.notify(source,{"~d~Only can Leader can promote."})
                            return
                        end
                        if array[tostring(memberid)].rank == 3 and gangpermission == 3 and tostring(user_id) == I then
                            AQUAclient.notify(source,{"~d~There can only be 1 leader in each gang."})
                            return
                        end
                        if tonumber(memberid) == tonumber(user_id) and rank == 4 and gangpermission == 4 then
                            AQUAclient.notify(source,{"~d~You are the highest rank."})
                            return
                        end 
                        array[tostring(memberid)].gangPermission = tonumber(gangpermission)+1
                        array[tostring(memberid)].rank = tonumber(rank)+1
                        array = json.encode(array)
                        exports['ghmattimysql']:execute("UPDATE AQUA_gangs SET gangmembers = @gangmembers WHERE gangname=@gangname", {gangmembers=array, gangname = gangid}, function()
                            TriggerClientEvent('AQUA:ForceRefreshData', -1)
                        end)
                    end
                end
            end
        end
    end)
end)
RegisterServerEvent("AQUA:DemoteUser")
AddEventHandler("AQUA:DemoteUser", function(gangid,memberid)
    local source = source
    local user_id=AQUA.getUserId(source)
    exports['ghmattimysql']:execute('SELECT * FROM AQUA_gangs', function(gotGangs)
        for K,V in pairs(gotGangs) do
            local array = json.decode(V.gangmembers)
            for I,L in pairs(array) do
                if tostring(user_id) == I then
                    if L.rank >= 4 then
                        local rank = array[tostring(memberid)].rank
                        local gangpermission = array[tostring(memberid)].gangPermission
                        if rank == 4 or gangpermission == 4 then
                            AQUAclient.notify(source,{"~d~Cannot demote the leader"})
                            return
                        end
                        if rank == 1 and gangpermission == 1 then
                            AQUAclient.notify(source,{"~d~Member is already the lowest rank."})
                            return
                        end
                        array[tostring(memberid)].rank = tonumber(rank)-1
                        array[tostring(memberid)].gangPermission = tonumber(gangpermission)-1
                        array = json.encode(array)
                        exports['ghmattimysql']:execute("UPDATE AQUA_gangs SET gangmembers = @gangmembers WHERE gangname=@gangname", {gangmembers=array, gangname = gangid}, function()
                            TriggerClientEvent('AQUA:ForceRefreshData', -1)
                        end)
                    end
                end
            end
        end
    end)
end)
RegisterServerEvent("AQUA:kickMemberFromGang")
AddEventHandler("AQUA:kickMemberFromGang", function(gangid,member)
    local source = source
    local user_id = AQUA.getUserId(source)
    local membersource = AQUA.getUserSource(member)
    if membersource == nil then
        membersource = 0
    end
    local membergang = ""
    exports['ghmattimysql']:execute('SELECT * FROM AQUA_gangs', function(gotGangs)
        for K,V in pairs(gotGangs) do
            local array = json.decode(V.gangmembers)
            for I,L in pairs(array) do
                if tostring(user_id) == I then
                    local memberrank = array[tostring(member)].rank
                    local rank = array[tostring(user_id)].rank
                    if tonumber(member) == tonumber(user_id) then
                        AQUAclient.notify(source,{"~d~You cannot kick yourself!"})
                        return
                    end
                    if tonumber(memberrank) >= 3 then
                        AQUAclient.notify(source,{"~d~You do not have permission to kick another Lieutenant!"})
                        return
                    end
                    array[tostring(member)] = nil
                    array = json.encode(array)
                    AQUAclient.notify(source,{"~d~Successfully kicked member from gang"})
                    exports['ghmattimysql']:execute("UPDATE AQUA_gangs SET gangmembers = @gangmembers WHERE gangname=@gangname", {gangmembers=array, gangname = gangid}, function()
                        TriggerClientEvent('AQUA:ForceRefreshData', source)
                        if tonumber(membersource) > 0 then
                            AQUAclient.notify(source,{"~d~You have been kicked from the gang."})
                            TriggerClientEvent('AQUA:disbandedGang', membersource)
                        end
                    end)
                end
            end
        end
    end)
end)
RegisterServerEvent("AQUA:memberLeaveGang")
AddEventHandler("AQUA:memberLeaveGang", function(gangid)
    local source = source
    local user_id = AQUA.getUserId(source)
    local membersource = AQUA.getUserSource(user_id)
    if membersource == nil then
        membersource = 0
    end
    local membergang = ""
    exports['ghmattimysql']:execute('SELECT * FROM AQUA_gangs', function(gotGangs)
        for K,V in pairs(gotGangs) do
            local array = json.decode(V.gangmembers)
            for I,L in pairs(array) do
                if tostring(user_id) == I then
                    local memberrank = array[tostring(user_id)].rank
                    local rank = array[tostring(user_id)].rank
                    array[tostring(user_id)] = nil
                    array = json.encode(array)
                    exports['ghmattimysql']:execute("UPDATE AQUA_gangs SET gangmembers = @gangmembers WHERE gangname=@gangname", {gangmembers=array, gangname = gangid}, function()
                        TriggerClientEvent('AQUA:ForceRefreshData', source)
                        if tonumber(membersource) > 0 then
                            AQUAclient.notify(source,{"~g~Successfully left gang."})
                            TriggerClientEvent('AQUA:disbandedGang', membersource)
                        end
                    end)
                end
            end
        end
    end)
end)
RegisterServerEvent("AQUA:InviteUserToGang")
AddEventHandler("AQUA:InviteUserToGang", function(gangid,playerid)
    local source = source
    playerid = tonumber(playerid)
    local user_id=AQUA.getUserId(source)
    local name = GetPlayerName(source)
    local message = "~g~Gang invite recieved from "..name
    local playersource = AQUA.getUserSource(playerid)
    if playersource == nil then
        AQUAclient.notify(source,{"~d~Player is not online."})
        return
    end
    local playername = GetPlayerName(playersource)
    TriggerClientEvent('AQUA:InviteRecieved', playersource,message,gangid)
end)
RegisterServerEvent("AQUA:DeleteGang")
AddEventHandler("AQUA:DeleteGang", function(gangid)
    local source=source
    local user_id=AQUA.getUserId(source)
    exports['ghmattimysql']:execute('SELECT * FROM AQUA_gangs WHERE gangname = @gangname',{gangname = gangid}, function(G)
        for K,V in pairs(G) do
            local array = json.decode(V.gangmembers)
            for I,L in pairs(array) do
                if tostring(user_id) == I then
                    exports['ghmattimysql']:execute("DELETE FROM AQUA_gangs WHERE gangname = @gangname", {gangname = gangid}, function() end)
                    AQUAclient.notify(source,{"~g~Disbanded "..gangid})
                    TriggerClientEvent('AQUA:disbandedGang', source)
                    TriggerClientEvent('AQUA:ForceRefreshData', -1)
                end
            end
        end
    end)
end)