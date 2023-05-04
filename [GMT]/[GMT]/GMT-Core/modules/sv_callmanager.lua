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
            TriggerClientEvent('GMT:AdminTicketCooldown', source, Reason)
        else
            vRPclient.notify(source,{"~r~Reason must be 10 characters or longer."})
        end
    end})
end)

RegisterNetEvent('GMT:sendAdminTicket')
AddEventHandler('GMT:sendAdminTicket', function(Reason)
    local index = #adminTickets + 1
    adminTickets[index] = {GetPlayerName(source), source, Reason}
    for k, v in pairs(vRP.getUsers({})) do 
        if vRP.hasPermission({k, callmanager.AdminPerm}) then
            vRPclient.notify(v,{"~b~Admin Ticket Recieved!"})
        end
    end
    TriggerClientEvent('CallManager:Table', -1, adminTickets, nhsCalls, pdCalls, name)
end)




---- Police Calls

RegisterCommand("999", function(source, args, rawCommand)
    vRP.prompt({source, "Reason:", "", function(player, Reason)
        if Reason == "" then return end
        TriggerClientEvent('GMT:PDCallCooldown', source, Reason)
    end})
end)

RegisterNetEvent('GMT:sendPDCall')
AddEventHandler('GMT:sendPDCall', function(Reason)
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
        TriggerClientEvent('GMT:NHSCallCooldown', source, Reason)
    end})
end)

RegisterNetEvent('GMT:sendNHSCall')
AddEventHandler('GMT:sendNHSCall', function(Reason)
    vRPclient.notify(source,{"~g~NHS will be added at a later date!"})
    -- REMOVE this section below when NHS is added in future.
--[[     local index = #nhsCalls + 1   
    nhsCalls[index] = {GetPlayerName(source), source, Reason}
    for k, v in pairs(vRP.getUsers({})) do 
        if vRP.hasPermission({k, callmanager.NHSPerm}) then
            vRPclient.notify(v,{"~g~NHS Call Recieved!"})
        end
    end
    TriggerClientEvent('CallManager:Table', -1, adminTickets, nhsCalls, pdCalls, source)
    vRPclient.notify(source,{"~g~NHS called!"})  ]]
end)

RegisterNetEvent('GMT:getTempFromPerm')
AddEventHandler('GMT:getTempFromPerm', function(tempid)
    local source = source
    permid = vRP.getUserId({tempid})
    TriggerClientEvent('GMT:sendPermID', source, permid)
end)


function CallManagerServer.GetUpdatedCoords(target)
    local source = source
    local target = target
    return GetEntityCoords(GetPlayerPed(tonumber(target)))
end

RegisterNetEvent('GMT:GiveTicketMoney')
AddEventHandler('GMT:GiveTicketMoney', function(admin, ticket, reason, isInTicket)
    local source = source
    local name = GetPlayerName(source)
    local ticketcount = 0
    local ticketStatus = isInTicket
    local user_id = vRP.getUserId({source})
    userid = vRP.getUserId({source})
    if vRP.hasPermission({user_id, "admin.tickets"}) then
    vRP.giveBankMoney({user_id, 15000})
    vRPclient.notify(ticket,{'~g~'..name..' has taken your ticket!'})
    vRPclient.staffMode(source, {true})
    TriggerEvent('GMT:AddTicketToLB', user_id)
	local name = GetPlayerName(source)

    
    local tsource = vRP.getUsers({ticket})
    local tuserid = vRP.getUserId({ticket})
    local tname = GetPlayerName(ticket)
    local command = {
        {
            ["color"] = "3944703",
            ["title"] = "GMT Ticket Logs",
            ["description"] = "```"..reason.."```",
            ["text"] = "GMT Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
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
        }
    }
    local webhook = "https://discord.com/api/webhooks/997506168085819533/UNrDv474HrmGsThnN6EWEvICKQRZWm6tDFsqFgWdIxTtJvY7ll3aeFcq6a-rx-sA9eGC"
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "GMT", embeds = command}), { ['Content-Type'] = 'application/json' })
    end
end)

RegisterNetEvent('GMT:AddTicketToLB')
AddEventHandler('GMT:AddTicketToLB', function(user_id)
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
