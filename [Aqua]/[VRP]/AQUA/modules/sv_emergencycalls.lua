local tickets = {}

local d=0

RegisterCommand('calladmin', function(source)
    local source = source
    local a = GetPlayerName(source)
    local b = AQUA.getUserId(source)
    local c = GetEntityCoords(GetPlayerPed(source))
    AQUA.prompt(source,"Reason: ","",function(source,reason)
        if reason ~= "" then
            d=d+1
            tickets[d] = {
                type = "admin",
                permID = b,
                tempID = source
            }
            for k,v in pairs(AQUA.getUsers({})) do
                TriggerClientEvent("AQUA:AddCall",v,d,a,b,c,reason,"admin")
            end
        else
            AQUAclient.notify(source,{"Please enter a reason."})
        end
    end)
end)

RegisterNetEvent("AQUA:AcceptCall")
AddEventHandler("AQUA:AcceptCall", function(ticketID)
    local admin_id = AQUA.getUserId(source)
    local admin = AQUA.getUserSource(admin_id)
    if tickets[ticketID] ~= nil then
        for k,v in pairs(tickets) do
            if ticketID == k then
                if tickets[ticketID].type == "admin" and AQUA.hasPermission(admin_id, "admin.OpenMenu") then
                    if AQUA.getUserSource(v.permID) ~= nil then
                        if admin_id ~= v.permID then
                            local adminbucket = GetPlayerRoutingBucket(admin)
                            local playerbucket = GetPlayerRoutingBucket(v.tempID)
                            if adminbucket ~= playerbucket then
                                SetPlayerRoutingBucket(admin, playerbucket)
                                AQUAclient.notify(admin, {"~g~You have been sent to bucket ID: "..playerbucket})
                            end
                            AQUAclient.getPosition(v.tempID, {}, function(x,y,z)
                                AQUA.giveBankMoney(admin_id, 50000)
                                AQUAclient.notify(admin,{"~g~You have recived £50,000 for taking an admin ticket.❤️"})
                                AQUAclient.notify(v.tempID,{"~g~Your admin ticket has been taken!"})
                                AQUAclient.teleport(admin, {x,y,z})
                                tickets[ticketID] = nil
                                TriggerClientEvent("AQUA:RemoveCall", -1, ticketID)
                                TriggerClientEvent("AQUA:StartAdminTicket",admin,true,GetPlayerName(v.tempID),AQUA.getUserId(v.tempID))
                            end)
                        else
                            AQUAclient.notify(admin,{"~d~You can't take your own ticket."})
                            TriggerClientEvent("AQUA:RemoveCall", -1, ticketID)
                        end
                    else
                        AQUAclient.notify(admin,{"~d~Player is offline."})
                        TriggerClientEvent("AQUA:RemoveCall", -1, ticketID)
                    end
                else
                    AQUAclient.notify(admin,{"~d~For some reason you've got perms on the client but not on the server... weird."})
                end
            end
        end
    else
        AQUAclient.notify(admin,{"~d~Big boi error."})
    end
end)

