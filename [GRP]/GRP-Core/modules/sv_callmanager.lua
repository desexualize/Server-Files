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

    if vRP.hasPermission({user_id, "police.call"}) then
        pdPerm = true;
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

local AdminCooldown = {}

RegisterCommand("calladmin", function(source, args, rawCommand)
    
    vRP.prompt({source, "Reason:", "", function(player, Reason)
        if Reason == "" then return end
        local index = #adminTickets + 1
        adminTickets[index] = {GetPlayerName(source), source, Reason}
        AdminCooldown[source] = os.time() + tonumber(30)
        TriggerClientEvent('CallManager:Table', -1, adminTickets, nhsCalls, pdCalls)
    end})
end)

RegisterCommand("999", function(source, args, rawCommand)
    vRP.prompt({source, "Reason:", "", function(player, Reason)
        if Reason == "" then return end
        local index = #pdCalls + 1
        pdCalls[index] = {GetPlayerName(source), source, Reason}
        TriggerClientEvent('CallManager:Table', -1, adminTickets, nhsCalls, pdCalls)
    end})
end)


RegisterNetEvent('CallManager:AddNHSCalls')
AddEventHandler('CallManager:AddNHSCalls', function(Reason)
    local source = source
    local index = #nhsCalls + 1
    nhsCalls[index] = {GetPlayerName(source), source, Reason}
    TriggerClientEvent('CallManager:Table', -1, adminTickets, nhsCalls, pdCalls)
end)

function CallManagerServer.GetUpdatedCoords(target)
    local source = source
    local target = target
    return GetEntityCoords(GetPlayerPed(tonumber(target)))
end

RegisterNetEvent('GRP:returnMe')
AddEventHandler('GRP:returnMe', function(admin, ticket, reason)
    local source = source
    local name = GetPlayerName(source)
    userid = vRP.getUserId({source})

    local name = GetPlayerName(source)
    local tuserid = vRP.getUserId({ticket})
    local tname = GetPlayerName(ticket)

    vRP.giveBankMoney({userid, 3000})
    vRPclient.notify(ticket,{'~g~An Admin has Taken your Ticket!'})
    TriggerClientEvent("TRP:OMioDioMode",source,true)

    webhook = "https://discord.com/api/webhooks/934160221725655090/nT_hHMKFaxEghmClufUkPfXdVUMIwUVX_njavtzFNgQO_hVnRc1vzswKcwxM9mS0kYJP"
    PerformHttpRequest(webhook, function(err, text, headers) 
    end, "POST", json.encode({username = "Galaxy Roleplay", embeds = {
        {
            ["color"] = "16777215",
            ["title"] = ""..name.." has Taken a ticket!",
            ["description"] = "Admin Name: **"..name.."** \nAdmin PermID: **"..userid.."**\nUser Name: **"..tname.."**\nUser PermID: **"..tuserid.."**\nReason: **" .. reason.."**\n\n**[Perm ID: " .. userid .. " Ticket Count]**",
            ["footer"] = {
              ["text"] = "Galaxy RP - "..os.date("%X"),
              ["icon_url"] = "https://discord.com/api/webhooks/934160221725655090/nT_hHMKFaxEghmClufUkPfXdVUMIwUVX_njavtzFNgQO_hVnRc1vzswKcwxM9mS0kYJP",
            }
    }
    }}), { ["Content-Type"] = "application/json" })

    


end)

RegisterCommand("staffon", function(source)
    user_id = vRP.getUserId({source})
    if vRP.hasPermission({user_id, "admin.tickets"}) then
        TriggerClientEvent("staffon", source)
        vRPclient.notify(source,{"~g~You are now on Duty!"})
    else
        vRPclient.notify(source,{"~r~You do not have permissions to do this!"})
    end
end)

RegisterCommand("staffoff", function(source)
    user_id = vRP.getUserId({source})
    if vRP.hasPermission({user_id, "admin.tickets"}) then
        TriggerClientEvent("staffoff", source)
        vRPclient.notify(source,{"~r~You are now off Duty!"})
    else
        vRPclient.notify(source,{"~r~You do not have permissions to do this!"})
    end
end)

