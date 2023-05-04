local Active_Tickets = {}
local Responded_Tickets = {} -- Ticket ID = Boolean
local Current_Ticket_ID = 0
local Admin_Ticket_Reward = 10000 -- Reward for taking an admin ticket

local Previous_Player_Buckets = {} -- Store Previous Bucket in case admin get's bucket changed on ticket

local function Get_Money_Formatted(amount)
	local formatted = amount
	while true do
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", "%1,%2")
		if (k == 0) then
			break
		end
	end
	return formatted
end

local Permission_Types = {
    ['admin'] = 'admin.tickets',
    ['lfb'] = 'lfb.menu',
    ['nhs'] = 'nhs.menu',
    ['mpd'] = 'police.menu',
}

local Confirmation_Messages = {
    ['admin'] = '~g~An admin has been called',
    ['lfb'] = '~g~The London Fire Brigade have been notified',
    ['nhs'] = '~g~The NHS have been notified',
    ['mpd'] = '~g~Met Police have been called',
}

local Call_Accepted_Messages = {
    ['admin'] = '~g~An admin has taken your ticket!',
    ['lfb'] = '~g~LFB are on their way!',
    ['nhs'] = '~g~NHS is on the way!',
    ['mpd'] = '~g~Police are on their way!',
}

local function Get_Permission_Name(ticket_type)
    return Permission_Types[ticket_type]
end

local function New_Call_Created(source, ticket_reason, ticket_type)
    local permission_name = Get_Permission_Name(ticket_type)

    local user_id = vRP.getUserId(source)
    local user_name = GetPlayerName(source)
    local user_coords = GetEntityCoords(GetPlayerPed(source))

    Current_Ticket_ID = Current_Ticket_ID + 1
    Active_Tickets[Current_Ticket_ID] = {
        type = ticket_type,
        perm_id = user_id,
        temp_id = source
    }

    for player_user_id, player_temp_id in pairs(vRP.getUsers()) do
        if player_temp_id ~= source then
            if vRP.hasPermission(player_user_id, permission_name) then
                TriggerClientEvent("Nova:AddCall", player_temp_id, Current_Ticket_ID, user_name, user_id, user_coords, ticket_reason, ticket_type)
            end
        end
    end

    if ticket_type == 'admin' then
        TriggerClientEvent('Nova:Client:AdminTicketCreated', source)
    else
        vRPclient.notify(source, {Confirmation_Messages[ticket_type]})
    end
end

RegisterNetEvent('Nova:Server:CreateCall')
AddEventHandler('Nova:Server:CreateCall', function(ticket_type)
    local source = source
    local permission_type = Get_Permission_Name(ticket_type)
    if permission_type then
        vRP.prompt(source, "Enter Call Reason: ", "", function(player_source, ticket_reason)
            if ticket_reason ~= '' then
                New_Call_Created(source, ticket_reason, ticket_type)
            else
                vRPclient.notify(source, {"~r~Please enter a reason"})
            end
        end)
    else
        vRPclient.notify(source, {'~r~Invalid ticket type'})
    end
end)

local function Get_Ticket_Info(ticket_id)
    return Active_Tickets[ticket_id]
end

RegisterNetEvent("Nova:Server:AcceptCall")
AddEventHandler("Nova:Server:AcceptCall", function(selected_ticket_id)
    local source = source
    local user_id = vRP.getUserId(source)

    local ticket_info = Get_Ticket_Info(selected_ticket_id)
    if ticket_info then
        local ticket_type = ticket_info.type
        local player_perm_id = ticket_info.perm_id
        local player_temp_id = ticket_info.temp_id

        if ticket_type == "admin" and vRP.hasPermission(user_id, Get_Permission_Name('admin')) then
            if user_id ~= player_perm_id then
                if vRP.getUserSource(player_perm_id) ~= nil then
                    local admin_bucket = GetPlayerRoutingBucket(source)
                    local player_bucket = GetPlayerRoutingBucket(player_temp_id)

                    if admin_bucket ~= player_bucket then
                        SetPlayerRoutingBucket(source, player_bucket)
                        Previous_Player_Buckets[source] = admin_bucket
                        vRPclient.notify(source, {"~g~You have been sent to bucket ID: " .. player_bucket})
                    end

                    vRPclient.getPosition(player_temp_id, {}, function(x, y, z)
                        vRP.giveBankMoney(user_id, Admin_Ticket_Reward)
                        vRPclient.notify(source, {("~g~You have recived £%s for taking an admin ticket"):format(Get_Money_Formatted(Admin_Ticket_Reward))})
                        
                        vRPclient.teleport(source, {x, y, z})
                        vRPclient.notify(player_temp_id, {Call_Accepted_Messages[ticket_type]})
                        
                        Active_Tickets[selected_ticket_id] = nil
                        TriggerClientEvent("Nova:RemoveCall", -1, selected_ticket_id)
                        TriggerClientEvent("Nova:ToggleAdminTicket", source, true, GetPlayerName(player_temp_id), vRP.getUserId(player_temp_id))
                    end)
                else
                    vRPclient.notify(source, {"~r~Player is offline"})
                    TriggerClientEvent("Nova:RemoveCall", -1, selected_ticket_id)
                end
            else
                vRPclient.notify(source, {"~r~You can't take your own ticket"})
                TriggerClientEvent("Nova:RemoveCall", source, selected_ticket_id)
            end

        elseif vRP.hasPermission(user_id, Get_Permission_Name(ticket_type)) then
            if not Responded_Tickets[selected_ticket_id] then
                Responded_Tickets[selected_ticket_id] = true

                local call_response_message = Call_Accepted_Messages[ticket_type]
                vRPclient.notify(player_temp_id, {call_response_message})
            end

            if ticket_type == 'nhs' then
                TriggerClientEvent("Nova:RemoveCall", -1, selected_ticket_id) -- Remove Call For Everyone if NHS Call
            else
                TriggerClientEvent("Nova:RemoveCall", source, selected_ticket_id) -- Only Removed For Person who accepted if call is LFB or MPD
            end
        else
            vRPclient.notify(source, {"~r~Big boi error 2 - Not ticket / No permissions"})
        end
    else
        vRPclient.notify(source, {"~r~Big boi error - Ticket Not found"})
    end
end)

RegisterNetEvent('Nova:Server:ReturnFromAdminTicket')
AddEventHandler('Nova:Server:ReturnFromAdminTicket', function()
    local source = source
    local previous_bucket = Previous_Player_Buckets[source]
    if previous_bucket then
        SetPlayerRoutingBucket(source, previous_bucket)
        vRPclient.notify(source, {('~g~Your bucket has been reverted to ID: %s'):format(previous_bucket)})
    end
    TriggerClientEvent('Nova:ToggleAdminTicket', source, false)
end)