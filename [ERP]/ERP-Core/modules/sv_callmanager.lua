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
        for k, v in pairs(vRP.getUsers({})) do 
            if vRP.hasPermission({k, 'admin.tickets'}) then
                vRPclient.notify(v,{"~b~Admin Ticket Recieved!"})
            end
        end
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

RegisterNetEvent('ERP:returnMe')
AddEventHandler('ERP:returnMe', function(admin, ticket, reason)
    local source = source
    local name = GetPlayerName(source)
    userid = vRP.getUserId({source})

    local name = GetPlayerName(source)
    local tuserid = vRP.getUserId({ticket})
    local tname = GetPlayerName(ticket)

    vRP.giveBankMoney({userid, 3000})
    vRPclient.notify(ticket,{'~g~An Admin has Taken your Ticket!'})
    TriggerClientEvent("ERP:OMioDioMode",source,true)

    webhook = "https://discord.com/api/webhooks/1001564354593955840/E-96wA5bOpWCi5-IeXK-3sNzjJOusjokGRDzO0MElkgDZrcYgsnLUoB5kkAtOFkCA6-B"
    PerformHttpRequest(webhook, function(err, text, headers) 
    end, "POST", json.encode({username = "ERP Roleplay", embeds = {
        {
            ["color"] = "16777215",
            ["title"] = ""..name.." has Taken a ticket!",
            ["description"] = "Admin Name: **"..name.."** \nAdmin PermID: **"..userid.."**\nUser Name: **"..tname.."**\nUser PermID: **"..tuserid.."**\nReason: **" .. reason.."**\n\n**[Perm ID: " .. userid .. " Ticket Count]**",
            ["footer"] = {
              ["text"] = "ERP RP - "..os.date("%X"),
              ["icon_url"] = "https://cdn.discordapp.com/attachments/848856393012346930/877183938420953118/ERPLogo.png",
            }
    }
    }}), { ["Content-Type"] = "application/json" })

    


end)