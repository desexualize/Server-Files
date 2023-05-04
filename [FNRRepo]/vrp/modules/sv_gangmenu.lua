RegisterServerEvent("FNR:GetGangData")
AddEventHandler("FNR:GetGangData", function()
    local source=source
    local newarray = nil
    local peoplesids = {}
    local user_id=vRP.getUserId(source)
    local gangmembers ={}
    local gangpermission
    exports['ghmattimysql']:execute('SELECT * FROM FNR_gangs', function(gotGangs)
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
                    exports['ghmattimysql']:execute('SELECT * FROM vrp_users', function(gotUser)
                        for J,G in pairs(gotUser) do
                            if peoplesids[tostring(G.id)] ~= nil then
                                table.insert(gangmembers,{G.username,tonumber(G.id),peoplesids[tostring(G.id)]})
                            end
                        end
                        TriggerClientEvent('FNR:GotGangData', source,newarray,gangmembers,gangpermission)
                    end)
                    break
                end
            end
        end
    end)
end)
RegisterServerEvent("FNR:CreateGang")
AddEventHandler("FNR:CreateGang", function(gangname)
    local source=source
    local user_id=vRP.getUserId(source)
    local user_name = GetPlayerName(source)
    local funds = 0 
    local logs = "NOTHING"
    exports['ghmattimysql']:execute('SELECT gangname FROM FNR_gangs WHERE gangname = @gangname', {gangname = gangname}, function(gotGang)
        if not vRP.hasGroup(user_id,"Gang") then
            vRPclient.notify(source,{"~r~You do not have gang licence."})
            return
        end
        if json.encode(gotGang) ~= "[]" and gotGang ~= nil and json.encode(gotGang) ~= nil then
            vRPclient.notify(source,{"~r~Gang name is already in use."})
            return
        end
        local gangmembers = {
            [tostring(user_id)] = {
                ["rank"] = 4,
                ["gangPermission"] = 4,
            },
        }
        gangmembers = json.encode(gangmembers)
        vRPclient.notify(source,{"~g~"..gangname.." created."})
        exports['ghmattimysql']:execute("INSERT INTO FNR_gangs (gangname,gangmembers,funds,logs) VALUES(@gangname,@gangmembers,@funds,@logs)", {gangname=gangname,gangmembers=gangmembers,funds=funds,logs=logs}, function() end)
        TriggerClientEvent('FNR:gangNameNotTaken', source)
        TriggerClientEvent('FNR:ForceRefreshData', -1)
    end)
end)
RegisterServerEvent("FNR:addUserToGang")
AddEventHandler("FNR:addUserToGang", function(ganginvite,playerid)
    local source=source
    local user_id=vRP.getUserId(source)
    local playersource = vRP.getUserSource(playerid)
    exports['ghmattimysql']:execute('SELECT * FROM FNR_gangs WHERE gangname = @gangname', {gangname = ganginvite}, function(G)
        if json.encode(G) == "[]" and G == nil and json.encode(G) == nil then
            vRPclient.notify(playersource,{"~r~Gang no longer exists."})
            return
        end
        for K,V in pairs(G) do
            local array = json.decode(V.gangmembers)
            array[tostring(playerid)] = {["rank"] = 1,["gangPermission"] = 1}
            exports['ghmattimysql']:execute("UPDATE FNR_gangs SET gangmembers = @gangmembers WHERE gangname=@gangname", {gangmembers = json.encode(array), gangname = ganginvite}, function()
                TriggerClientEvent('FNR:ForceRefreshData', -1)
            end)
        end
    end)
end)
RegisterServerEvent("FNR:depositGangBalance")
AddEventHandler("FNR:depositGangBalance", function(amount)
    local source = source
    local user_id = vRP.getUserId(source)
    local name = GetPlayerName(source)
    local date = os.date("%d/%m/%Y at %X")
    exports['ghmattimysql']:execute('SELECT * FROM FNR_gangs', function(gotGangs)
        for K,V in pairs(gotGangs) do
            local array = json.decode(V.gangmembers)
            for I,L in pairs(array) do
                if tostring(user_id) == I then
                    local funds = V.funds
                    local gangname = V.gangname
                    if tonumber(amount) < 0 then
                        vRPclient.notify(source,{"~r~Invalid Amount"})
                        return
                    end
                    if tonumber(vRP.getMoney(user_id)) < tonumber(amount) then
                        vRPclient.notify(source,{"~r~Not enough cash."})
                    else
                        vRP.setMoney(user_id,tonumber(vRP.getMoney(user_id))-tonumber(amount))
                        vRPclient.notify(source,{"~g~Deposited £"..amount})
                        local newamount = tonumber(amount)+tonumber(funds)
                        local tax = tonumber(amount)*0.01
                        local webhook = 'https://discord.com/api/webhooks/1003729724222214290/h5UqwxFvnLElRbIoXqIvVrnh9RZPl5oyTucRkIk_qiHZPyo1T4TyxJnkI9bdPYKCvKnI'
                        local embed = {
                            {
                                ["color"] = "16777215",
                                ["title"] = "Gang Funds",
                                ["description"] = "**User Name:** "..GetPlayerName(source).."\n**User ID:** "..vRP.getUserId(source).."\n**Deposit:** £"..getMoneyStringFormatted(amount).."\n**Gang Name:** "..gangname,
                                ["footer"] = {
                                    ["text"] = "FNR - "..os.date("%X"),
                                },
                            }
                        }
                        PerformHttpRequest(webhook, function (err, text, headers) end, 'POST', json.encode({username = 'FNR', embeds = embed}), { ['Content-Type'] = 'application/json' })
                        exports['ghmattimysql']:execute("UPDATE FNR_gangs SET funds = @funds WHERE gangname=@gangname", {funds = tostring(newamount)-tostring(tax), gangname = gangname}, function()
                            TriggerClientEvent('FNR:ForceRefreshData', -1)
                        end)
                    end
                end
            end
        end
    end)
    TriggerClientEvent('FNR:ForceRefreshData', source)
end)
RegisterServerEvent("FNR:withdrawGangBalance")
AddEventHandler("FNR:withdrawGangBalance", function(amount)
    local source = source
    local user_id = vRP.getUserId(source)
    local name = GetPlayerName(source)
    local date = os.date("%d/%m/%Y at %X")
    exports['ghmattimysql']:execute('SELECT * FROM FNR_gangs', function(gotGangs)
        for K,V in pairs(gotGangs) do
            local array = json.decode(V.gangmembers)
            for I,L in pairs(array) do
                if tostring(user_id) == I then
                    local funds = V.funds
                    local gangname = V.gangname
                    if tonumber(amount) < 0 then
                        vRPclient.notify(source,{"~r~Invalid Amount"})
                        return
                    end
                    if tonumber(funds) < tonumber(amount) then
                        vRPclient.notify(source,{"~r~Invalid Amount."})
                    else
                        vRP.setMoney(user_id,tonumber(vRP.getMoney(user_id))+tonumber(amount))
                        vRPclient.notify(source,{"~g~Withdrew £"..amount})
                        local newamount = tonumber(funds)-tonumber(amount)
                        local webhook = 'https://discord.com/api/webhooks/1003729724222214290/h5UqwxFvnLElRbIoXqIvVrnh9RZPl5oyTucRkIk_qiHZPyo1T4TyxJnkI9bdPYKCvKnI'
                        local embed = {
                            {
                                ["color"] = "16777215",
                                ["title"] = "Gang Funds",
                                ["description"] = "**User Name:** "..GetPlayerName(source).."\n**User ID:** "..vRP.getUserId(source).."\n**Withdrew:** £"..getMoneyStringFormatted(amount).."\n**Gang Name:** "..gangname,
                                ["footer"] = {
                                    ["text"] = "FNR - "..os.date("%X"),
                                },
                            }
                        }
                        PerformHttpRequest(webhook, function (err, text, headers) end, 'POST', json.encode({username = 'FNR', embeds = embed}), { ['Content-Type'] = 'application/json' })
                        exports['ghmattimysql']:execute("UPDATE FNR_gangs SET funds = @funds WHERE gangname=@gangname", {funds = tostring(newamount), gangname = gangname}, function()
                            TriggerClientEvent('FNR:ForceRefreshData', -1)
                        end)
                    end
                end
            end
        end
    end)
    TriggerClientEvent('FNR:ForceRefreshData', source)
end)
RegisterServerEvent("FNR:PromoteUser")
AddEventHandler("FNR:PromoteUser", function(gangid,memberid)
    local source = source
    local user_id=vRP.getUserId(source)
    exports['ghmattimysql']:execute('SELECT * FROM FNR_gangs', function(gotGangs)
        for K,V in pairs(gotGangs) do
            local array = json.decode(V.gangmembers)
            for I,L in pairs(array) do
                if tostring(user_id) == I then
                    if L.rank >= 4 then
                        local rank = array[tostring(memberid)].rank
                        local gangpermission = array[tostring(memberid)].gangPermission
                        if rank < 4 and gangpermission < 4 and tostring(user_id) ~= I then
                            vRPclient.notify(source,{"~r~Only can Leader can promote."})
                            return
                        end
                        if array[tostring(memberid)].rank == 3 and gangpermission == 3 and tostring(user_id) == I then
                            vRPclient.notify(source,{"~r~There can only be 1 leader in each gang."})
                            return
                        end
                        if tonumber(memberid) == tonumber(user_id) and rank == 4 and gangpermission == 4 then
                            vRPclient.notify(source,{"~r~You are the highest rank."})
                            return
                        end 
                        array[tostring(memberid)].gangPermission = tonumber(gangpermission)+1
                        array[tostring(memberid)].rank = tonumber(rank)+1
                        array = json.encode(array)
                        exports['ghmattimysql']:execute("UPDATE FNR_gangs SET gangmembers = @gangmembers WHERE gangname=@gangname", {gangmembers=array, gangname = gangid}, function()
                            TriggerClientEvent('FNR:ForceRefreshData', -1)
                        end)
                    end
                end
            end
        end
    end)
end)
RegisterServerEvent("FNR:DemoteUser")
AddEventHandler("FNR:DemoteUser", function(gangid,memberid)
    local source = source
    local user_id=vRP.getUserId(source)
    exports['ghmattimysql']:execute('SELECT * FROM FNR_gangs', function(gotGangs)
        for K,V in pairs(gotGangs) do
            local array = json.decode(V.gangmembers)
            for I,L in pairs(array) do
                if tostring(user_id) == I then
                    if L.rank >= 4 then
                        local rank = array[tostring(memberid)].rank
                        local gangpermission = array[tostring(memberid)].gangPermission
                        if rank == 4 or gangpermission == 4 then
                            vRPclient.notify(source,{"~r~Cannot demote the leader"})
                            return
                        end
                        if rank == 1 and gangpermission == 1 then
                            vRPclient.notify(source,{"~r~Member is already the lowest rank."})
                            return
                        end
                        array[tostring(memberid)].rank = tonumber(rank)-1
                        array[tostring(memberid)].gangPermission = tonumber(gangpermission)-1
                        array = json.encode(array)
                        exports['ghmattimysql']:execute("UPDATE FNR_gangs SET gangmembers = @gangmembers WHERE gangname=@gangname", {gangmembers=array, gangname = gangid}, function()
                            TriggerClientEvent('FNR:ForceRefreshData', -1)
                        end)
                    end
                end
            end
        end
    end)
end)
RegisterServerEvent("FNR:kickMemberFromGang")
AddEventHandler("FNR:kickMemberFromGang", function(gangid,member)
    local source = source
    local user_id = vRP.getUserId(source)
    local membersource = vRP.getUserSource(member)
    if membersource == nil then
        membersource = 0
    end
    local membergang = ""
    exports['ghmattimysql']:execute('SELECT * FROM FNR_gangs', function(gotGangs)
        for K,V in pairs(gotGangs) do
            local array = json.decode(V.gangmembers)
            for I,L in pairs(array) do
                if tostring(user_id) == I then
                    local memberrank = array[tostring(member)].rank
                    local rank = array[tostring(user_id)].rank
                    if tonumber(member) == tonumber(user_id) then
                        vRPclient.notify(source,{"~r~You cannot kick yourself!"})
                        return
                    end
                    if tonumber(memberrank) >= 3 then
                        vRPclient.notify(source,{"~r~You do not have permission to kick another Lieutenant!"})
                        return
                    end
                    array[tostring(member)] = nil
                    array = json.encode(array)
                    vRPclient.notify(source,{"~r~Successfully kicked member from gang"})
                    exports['ghmattimysql']:execute("UPDATE FNR_gangs SET gangmembers = @gangmembers WHERE gangname=@gangname", {gangmembers=array, gangname = gangid}, function()
                        TriggerClientEvent('FNR:ForceRefreshData', source)
                        if tonumber(membersource) > 0 then
                            vRPclient.notify(source,{"~r~You have been kicked from the gang."})
                            TriggerClientEvent('FNR:disbandedGang', membersource)
                        end
                    end)
                end
            end
        end
    end)
end)
RegisterServerEvent("FNR:memberLeaveGang")
AddEventHandler("FNR:memberLeaveGang", function(gangid)
    local source = source
    local user_id = vRP.getUserId(source)
    local membersource = vRP.getUserSource(user_id)
    if membersource == nil then
        membersource = 0
    end
    local membergang = ""
    exports['ghmattimysql']:execute('SELECT * FROM FNR_gangs', function(gotGangs)
        for K,V in pairs(gotGangs) do
            local array = json.decode(V.gangmembers)
            for I,L in pairs(array) do
                if tostring(user_id) == I then
                    local memberrank = array[tostring(user_id)].rank
                    local rank = array[tostring(user_id)].rank
                    array[tostring(user_id)] = nil
                    array = json.encode(array)
                    exports['ghmattimysql']:execute("UPDATE FNR_gangs SET gangmembers = @gangmembers WHERE gangname=@gangname", {gangmembers=array, gangname = gangid}, function()
                        TriggerClientEvent('FNR:ForceRefreshData', source)
                        if tonumber(membersource) > 0 then
                            vRPclient.notify(source,{"~g~Successfully left gang."})
                            TriggerClientEvent('FNR:disbandedGang', membersource)
                        end
                    end)
                end
            end
        end
    end)
end)
RegisterServerEvent("FNR:InviteUserToGang")
AddEventHandler("FNR:InviteUserToGang", function(gangid,playerid)
    local source = source
    playerid = tonumber(playerid)
    local user_id=vRP.getUserId(source)
    local name = GetPlayerName(source)
    local message = "~g~Gang invite recieved from "..name
    local playersource = vRP.getUserSource(playerid)
    if playersource == nil then
        vRPclient.notify(source,{"~r~Player is not online."})
        return
    end
    local playername = GetPlayerName(playersource)
    TriggerClientEvent('FNR:InviteRecieved', playersource,message,gangid)
end)
RegisterServerEvent("FNR:DeleteGang")
AddEventHandler("FNR:DeleteGang", function(gangid)
    local source=source
    local user_id=vRP.getUserId(source)
    exports['ghmattimysql']:execute('SELECT * FROM FNR_gangs WHERE gangname = @gangname',{gangname = gangid}, function(G)
        for K,V in pairs(G) do
            local array = json.decode(V.gangmembers)
            for I,L in pairs(array) do
                if tostring(user_id) == I then
                    exports['ghmattimysql']:execute("DELETE FROM FNR_gangs WHERE gangname = @gangname", {gangname = gangid}, function() end)
                    vRPclient.notify(source,{"~g~Disbanded "..gangid})
                    TriggerClientEvent('FNR:disbandedGang', source)
                    TriggerClientEvent('FNR:ForceRefreshData', -1)
                end
            end
        end
    end)
end)