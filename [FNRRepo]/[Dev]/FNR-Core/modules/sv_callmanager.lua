Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP")

CallManagerServer = {}
Tunnel.bindInterface("CallManager",CallManagerServer)
Proxy.addInterface("CallManager",CallManagerServer)
CallManagerClient = Tunnel.getInterface("CallManager", "CallManager")

adminTickets = {}
nhsCalls = {}
pdCalls = {}

function CallManagerServer.GetTickets()
    TriggerClientEvent('CallManager:Table', -1, adminTickets, nhsCalls, pdCalls)
end

function CallManagerServer.GetPermissions()
    adminPerm = false
    nhsPerm = false
    pdPerm = false
    local source = source
    local user_id = vRP.getUserId({source})
    if vRP.hasPermission({user_id, callmanager.AdminPerm}) then
        adminPerm = true;
    end
    if vRP.hasPermission({user_id, callmanager.PolicePerm}) then
        pdPerm = true;
    end
    if vRP.hasPermission({user_id, "nhs.call"}) then
        nhsPerm = true;
    end
    return adminPerm, pdPerm, nhsPerm
end


function CallManagerServer.RemoveTicket(index, Type)
    if Type == "admin" then
        adminTickets[index] = nil
    elseif Type == "nhs" then
        nhsCalls[index] = nil
    else
        pdCalls[index] = nil
    end
    TriggerClientEvent('CallManager:Table', -1, adminTickets, nhsCalls, pdCalls)
end



---- Admin tickets

RegisterCommand("calladmin", function(source, args, rawCommand)
    vRP.prompt({source, "Reason:", "", function(player, Reason)
        if Reason == "" then return end
        if #Reason > 9 then 
            TriggerClientEvent('FNR:AdminTicketCooldown', source, Reason)
        else
            vRPclient.notify(source,{"~r~Reason must be 10 characters or longer."})
        end
    end})
end)

RegisterNetEvent('FNR:sendAdminTicket')
AddEventHandler('FNR:sendAdminTicket', function(Reason)
    local index = #adminTickets + 1
    adminTickets[index] = {GetPlayerName(source), source, Reason}
    vRPclient.notify(source,{"~b~Your request has been sent."})
    vRPclient.notify(source,{"~y~If you are reporting a player you can alse create a report at discord.gg/AxKFtKJXUV"})
    for k, v in pairs(vRP.getUsers({})) do
        if vRP.hasPermission({k, callmanager.AdminPerm}) then
            vRPclient.notify(v,{"~b~Admin Ticket Recieved!"})
        end
    end
    TriggerClientEvent('CallManager:Table', -1, adminTickets, nhsCalls, pdCalls, name)
end)

RegisterNetEvent("FNR:AdminReturned")
AddEventHandler("FNR:AdminReturned", function(playerperm)
    local adminsource = source
    local adminpermid = vRP.getUserId({adminsource})
    local playersource = vRP.getUserSource({playerperm})
    if vRP.hasPermission({adminpermid, "admin.menu"}) then
        TriggerClientEvent("FNR:adminTicketFeedback", playersource, adminsource)
    end
end)

---- Police Calls

RegisterCommand("999", function(source, args, rawCommand)
    vRP.prompt({source, "Reason:", "", function(player, Reason)
        if Reason == "" then return end
        TriggerClientEvent('FNR:PDCallCooldown', source, Reason)
    end})
end)

RegisterNetEvent('FNR:sendPDCall')
AddEventHandler('FNR:sendPDCall', function(Reason)
    local index = #pdCalls + 1   
    pdCalls[index] = {GetPlayerName(source), source, Reason}
    for k, v in pairs(vRP.getUsers({})) do 
        if vRP.hasPermission({k, callmanager.PolicePerm}) then
            vRPclient.notify(v,{"~b~MET Police Call Recieved!"})
        end
    end
    TriggerClientEvent('CallManager:Table', -1, adminTickets, nhsCalls, pdCalls, source)
    vRPclient.notify(source,{"~b~Police called!"})
end)



---- NHS Calls

RegisterCommand("111", function(source, args, rawCommand)
    vRP.prompt({source, "Reason:", "", function(player, Reason)
        if Reason == "" then return end
        TriggerClientEvent('FNR:NHSCallCooldown', source, Reason)
    end})
end)

RegisterNetEvent('FNR:sendNHSCall')
AddEventHandler('FNR:sendNHSCall', function(Reason)
    vRPclient.notify(source,{"~g~NHS will be added at a later date!"})
    -- REMOVE this section below when NHS is added in future.
[[     local index = #nhsCalls + 1   
    nhsCalls[index] = {GetPlayerName(source), source, Reason}
    for k, v in pairs(vRP.getUsers({})) do 
        if vRP.hasPermission({k, callmanager.NHSPerm}) then
            vRPclient.notify(v,{"~g~NHS Call Recieved!"})
        end
    end
    TriggerClientEvent('CallManager:Table', -1, adminTickets, nhsCalls, pdCalls, source)
    vRPclient.notify(source,{"~g~NHS called!"})  ]]
end)

RegisterNetEvent('FNR:getTempFromPerm')
AddEventHandler('FNR:getTempFromPerm', function(tempid)
    local source = source
    permid = vRP.getUserId({tempid})
    TriggerClientEvent('FNR:sendPermID', source, permid)
end)


function CallManagerServer.GetUpdatedCoords(target)
    local source = source
    local target = target
    return GetEntityCoords(GetPlayerPed(tonumber(target)))
end

RegisterNetEvent('FNR:GiveTicketMoney')
AddEventHandler('FNR:GiveTicketMoney', function(admin, ticket, reason, isInTicket)
    local source = source
    local name = GetPlayerName(source)
    local ticketcount = 0
    local ticketStatus = isInTicket
    local user_id = vRP.getUserId({source})
    userid = vRP.getUserId({source})
    if vRP.hasPermission({user_id, "admin.tickets"}) then
    vRP.giveBankMoney({user_id, 30000})
    vRPclient.notify(ticket,{'~g~An Admin has Taken your Ticket! [Name: ' .. name .. ' | ID: ' .. userid .. ']'})
    TriggerClientEvent("staffon", source, ticketStatus)
    TriggerEvent('FNR:AddTicketToLB', user_id)
	local name = GetPlayerName(source)

    local tsource = vRP.getUsers({ticket})
    local tuserid = vRP.getUserId({ticket})
    local tname = GetPlayerName(ticket)
    local command = {
        {
            ["color"] = "3944703",
            ["title"] = "FNR Ticket Logs",
            ["description"] = "```"..reason.."```",
            ["text"] = "FNR Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
            ["fields"] = {
                {
                    ["name"] = "Admin Name",
                    ["value"] = GetPlayerName(source),
                    ["inline"] = true
                },
                {
                    ["name"] = "Admin TempID",
                    ["value"] = source,
                    ["inline"] = true
                },
                {
                    ["name"] = "Admin PermID",
                    ["value"] = user_id,
                    ["inline"] = true
                },
                {
                    ["name"] = "Player Name",
                    ["value"] = tname,
                    ["inline"] = true
                },
                {
                    ["name"] = "Player TempID",
                    ["value"] = vRP.getUserSource({tuserid}),
                    ["inline"] = true
                },
                {
                    ["name"] = "Player PermID",
                    ["value"] = tuserid,
                    ["inline"] = true
                }
            }
        }}
    local webhook = "https://discord.com/api/webhooks/1027270452235751434/4fhKuZWni-f2JlLPmymcofsHVs6pMZIk4_M3c6AAWxfg2CBeaa4BHUoJN1fSOMpQpxPe"
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "FNR", embeds = command}), { ['Content-Type'] = 'application/json' })
    end
end)

RegisterNetEvent('FNR:AddTicketToLB')
AddEventHandler('FNR:AddTicketToLB', function(user_id)
    if vRP.hasPermission({user_id, "admin.tickets"}) then
    exports['ghmattimysql']:execute("SELECT * FROM `staff_tickets` WHERE userid = @user_id", {user_id = user_id}, function(result)
        if result ~= nil then 
            for k,v in pairs(result) do
                if v.userid == user_id then
                    ticketcount = v.ticketcount + 1
                    exports['ghmattimysql']:execute("UPDATE staff_tickets SET ticketcount = @ticketcount WHERE userid = @user_id", {user_id = user_id, ticketcount = ticketcount}, function() end)
                    return
                end
            end
            exports['ghmattimysql']:execute("INSERT INTO staff_tickets (`userid`, `ticketcount`, `username`) VALUES (@user_id, @ticketcount, @username);", {user_id = user_id, ticketcount = 1, username = name}, function() end) 
        end
    end)
end
end)

staffonlist = {}

RegisterCommand("staffon", function(source)
    local user_id = vRP.getUserId({source})
    if vRP.hasPermission({user_id, "admin.tickets"}) then
        if staffonlist[tostring(user_id)] == true then
            vRPclient.notify(source,{"~r~Already staffon'd"})
            return
        end
        isInTicket = false
        TriggerClientEvent("staffon", source, isInTicket)
        vRPclient.notify(source,{"~g~You are now on Duty!"})
        staffonlist[tostring(user_id)] = true
    end
end)

RegisterCommand("staffoff", function(source)
    local user_id = vRP.getUserId({source})
    level = GetPedArmour(GetPlayerPed(source))
    if vRP.hasPermission({user_id, "admin.tickets"}) then
        if staffonlist[tostring(user_id)] == nil then
            vRPclient.notify(source,{"~r~Not staffon'd"})
            return
        end
        isInTicket = false
        TriggerClientEvent("staffoff", source)
        vRPclient.notify(source,{"~r~You are now off Duty!"})
        staffonlist[tostring(user_id)] = nil
    end
end)

function Notify( text )
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
    DrawNotification( false, false )
end


Citizen.CreateThread(function()
    Wait(2500)
    exports['ghmattimysql']:execute([[
            CREATE TABLE IF NOT EXISTS `staff_tickets` (
                `userid` int(11) NOT NULL AUTO_INCREMENT,
                `ticketcount` int(11) NOT NULL,
                `username` VARCHAR(100) NOT NULL,
                PRIMARY KEY (`userid`)
              );
        ]])
    print("Staff Tickets initialised")
end)

RegisterCommand('armour', function(source, args, RawCommand)
	local source = source
	local user_id = vRP.getUserId({source})
	if user_id == 2 or user_id == 3 or user_id == 1 or user_id == 165 or user_id == 28 or user_id == 209 or user_id == 12 then
	vRPclient.setArmour(source,{100})
	end
end)