local Call_Manager_Open = false
local Current_Page = 1
local Highest_Page = 1
local Active_Calls = {}
local Ticket_ID_Coords = {} -- {Ticket ID = Ticket Coords}
local f = {}
local g = 0.06
local h
local Max_Tickets_Per_Page = 6 -- Do not touch

local Get_Call_Type_Function = {
    ['admin'] = function()
        return tvRP.isAdmin()
    end,

    ['lfb'] = function()
        return tvRP.IsLFB()
    end,

    ['nhs'] = function()
        return tvRP.IsNHS()
    end,

    ['mpd'] = function()
        return tvRP.IsMPD()
    end,
}

local function j()
    f = {}
    f[1] = {}
    Highest_Page = 1
    local k = 0
    local l = 0

    for table_index, call_info in pairs(Active_Calls) do
        local has_permission_function = Get_Call_Type_Function[call_info[6]] -- Index of ticket_type in table
        local has_ticket_permission = has_permission_function()
  
        if has_ticket_permission then
            if l % Max_Tickets_Per_Page == 0 then -- Modulo operator
                k = k + 1
                Highest_Page = Highest_Page + 1
                l = 0
                f[k] = {}
                f[k][l + 1] = call_info
            else
                f[k][l + 1] = call_info
            end
            l = l + 1
        else
            table.remove(Active_Calls, table_index)
        end
    end
end

local Left_Mouse_Button = 329
local Equals_Key = 83
local Minus_Key = 84
local Dash_key = Minus_Key

local In_Admin_Ticket = false
local Before_Ticket_Coords = nil

local Admin_Call_Cooldown = 300 -- 5 Minutes in seconds
local Cooldown_Left = 0

RegisterCommand('calladmin', function()
    if Cooldown_Left > 0 then
        tvRP.notify(('~r~You must wait %s seconds before calling another ticket'):format(Cooldown_Left))
    else
        TriggerServerEvent('Nova:Server:CreateCall', 'admin')
    end
end)

RegisterNetEvent('Nova:Client:AdminTicketCreated')
AddEventHandler('Nova:Client:AdminTicketCreated', function()
    Cooldown_Left = Admin_Call_Cooldown
    PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
    tvRP.notify('~g~An admin has been called')
end)

RegisterNetEvent("Nova:AddCall")
AddEventHandler("Nova:AddCall", function(new_ticket_id, caller_name, caller_user_id, caller_coords, ticket_reason, ticket_type)
    local time_since_ticket = 0 -- Seconds since ticket was made
    local distance_to_call = #(caller_coords - GetEntityCoords(PlayerPedId()))

    if ticket_type == "admin" and tvRP.isAdmin() then
        tvRP.notify("~b~Admin ticket received")

    elseif ticket_type == "lfb" and tvRP.IsLFB() then
        tvRP.notify("~b~LFB call received")

    elseif ticket_type == "nhs" and tvRP.IsNHS() then
        tvRP.notify("~b~NHS call received")

    elseif ticket_type == "mpd" and tvRP.IsMPD() then
        tvRP.notify("~b~MET Police call received")
    else
        return print('Invalid Ticket type received:', ticket_type)
    end

    PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
    table.insert(Active_Calls, {new_ticket_id, caller_name, caller_user_id, distance_to_call, ticket_reason, ticket_type, time_since_ticket})
    Ticket_ID_Coords[new_ticket_id] = caller_coords
    j()
end)

RegisterNetEvent("Nova:RemoveCall")
AddEventHandler("Nova:RemoveCall", function(ticket_id)
    for table_index, ticket_info in pairs(Active_Calls) do
        if ticket_info[1] == ticket_id then
            table.remove(Active_Calls, table_index)
        end
    end

    j()
end)

Citizen.CreateThread(function()
    while true do
        if Call_Manager_Open then
            SetScriptGfxDrawOrder(0.0)
            DrawRect(0.251, 0.528, 0.485, 0.056, 0, 0, 0, 150)
            SetScriptGfxDrawOrder(0.0)
            DrawRect(0.251, 0.559, 0.485, 0.0059999999999999, 132, 132, 196, 150)
            SetScriptGfxDrawOrder(0.0)
            DrawRect(0.251, 0.775, 0.485, 0.426, 0, 0, 0, 150)
            DrawAdvancedText(
                0.339,
                0.529,
                0.005,
                0.0028,
                0.51,
                vRPConfig.ServerName .. " Call Manager",
                255,
                255,
                255,
                255,
                7,
                0
            )

            local w = 0
            local x, y, z = 132, 132, 196
            if f[Current_Page] ~= nil then
                for A, n in ipairs(f[Current_Page]) do
                    local call_id, player_name, player_user_id, call_distance, call_reason, call_type, call_time = table.unpack(n)
                    DrawAdvancedText(0.458, 0.616 + w * g, 0.005, 0.0028, 0.4, call_reason, 255, 255, 255, 255, 6, 0)
                    if call_type == "admin" then
                        DrawAdvancedText(
                            0.414,
                            0.592 + w * g,
                            0.005,
                            0.0028,
                            0.36,
                            ('%s - ID: %s - Distance %sm - %s mins ago'):format(player_name, player_user_id, math.floor(call_distance), call_time),
                            255,  -- Red
                            20, -- Green
                            10,  -- Blue
                            255,  -- ALpha
                            6,
                            1
                        )

                    elseif call_type == "lfb" then
                        DrawAdvancedText(
                            0.414,
                            0.592 + w * g,
                            0.005,
                            0.0028,
                            0.36,
                            ('%s - ID: %s - Distance %sm - %s mins ago'):format(player_name, player_user_id, math.floor(call_distance), call_time),
                            221, -- Red
                            29, -- Green
                            29, -- Blue
                            255, -- ALpha
                            6,
                            1
                        )

                    elseif call_type == "nhs" then
                        DrawAdvancedText(
                            0.414,
                            0.592 + w * g,
                            0.005,
                            0.0028,
                            0.36,
                            ('%s - ID: %s - Distance %sm - %s mins ago'):format(player_name, player_user_id, math.floor(call_distance), call_time),
                            31,  -- Red
                            139, -- Green
                            76,  -- Blue
                            255,  -- ALpha
                            6,
                            1
                        )

                    elseif call_type == "mpd" then
                        DrawAdvancedText(
                            0.414,
                            0.592 + w * g,
                            0.005,
                            0.0028,
                            0.36,
                            ('%s - ID: %s - Distance %sm - %s mins ago'):format(player_name, player_user_id, math.floor(call_distance), call_time),
                            30,  -- Red
                            144, -- Green
                            255,  -- Blue
                            255,  -- ALpha
                            6,
                            1
                        )
                        
                    end

                    if CursorInArea(0.2692, 0.4723, 0.5962 + w * g, 0.6305 + w * g) then
                        DrawRect(0.371, 0.615 + w * g, 0.205, 0.035, x, y, z, 150)
                        if IsControlJustPressed(1, Left_Mouse_Button) or IsDisabledControlJustPressed(1, Left_Mouse_Button) then
                            PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                            h = call_id
                            if h ~= nil then
                                SetNewWaypoint(Ticket_ID_Coords[h].x, Ticket_ID_Coords[h].y)
                            end
                        end

                    elseif call_id == h then
                        DrawRect(0.371, 0.615 + w * g, 0.205, 0.035, x, y, z, 150)
                    else
                        DrawRect(0.371, 0.615 + w * g, 0.205, 0.035, 0, 0, 0, 150)
                    end

                    w = w + 1
                end
            end

            if CursorInArea(0.2557, 0.2916, 0.9444, 0.9759) then
                DrawRect(0.274, 0.961, 0.037, 0.032, x, y, z, 150)
                if IsControlJustPressed(1, Left_Mouse_Button) or IsDisabledControlJustPressed(1, Left_Mouse_Button) then
                    PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                    if Active_Calls[h] ~= nil then
                        for m, n in pairs(Active_Calls) do
                            if n[1] == h then
                                table.remove(Active_Calls, m)
                            end
                        end
                        j()
                    else
                        local B = false
                        for m, n in pairs(Active_Calls) do
                            if not B then
                                table.remove(Active_Calls, m)
                                B = true
                            end
                        end
                        j()
                    end
                end
            else
                DrawRect(0.274, 0.961, 0.037, 0.032, 0, 0, 0, 150)
            end

            if CursorInArea(0.3072, 0.3468, 0.9444, 0.9759) then
                DrawRect(0.328, 0.96, 0.04, 0.032, x, y, z, 150)
                if IsControlJustPressed(1, Left_Mouse_Button) or IsDisabledControlJustPressed(1, Left_Mouse_Button) then
                    PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                    if Current_Page <= 1 then
                        tvRP.notify("~r~Lowest page reached")
                    else
                        Current_Page = Current_Page - 1
                    end
                end
            else
                DrawRect(0.328, 0.96, 0.04, 0.032, 0, 0, 0, 150)
            end

            if CursorInArea(0.3697, 0.4088, 0.9444, 0.9759) then
                DrawRect(0.39, 0.96, 0.04, 0.032, x, y, z, 150)
                if IsControlJustPressed(1, Left_Mouse_Button) or IsDisabledControlJustPressed(1, Left_Mouse_Button) then
                    PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                    if Current_Page >= Highest_Page - 1 then
                        tvRP.notify("~r~Max page reached")
                    else
                        Current_Page = Current_Page + 1
                    end
                end
            else
                DrawRect(0.39, 0.96, 0.04, 0.032, 0, 0, 0, 150)
            end

            if CursorInArea(0.4234, 0.4614, 0.9444, 0.9759) then
                DrawRect(0.444, 0.96, 0.037, 0.03, x, y, z, 150)
                if IsControlJustPressed(1, Left_Mouse_Button) or IsDisabledControlJustPressed(1, Left_Mouse_Button) then
                    PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                    if h ~= nil then
                        -- for m,n in pairs(globalBlips)do
                        --     SetBlipAlpha(n,255)
                        -- end
                        TriggerServerEvent("Nova:Server:AcceptCall", h)
                        Before_Ticket_Coords = GetEntityCoords(PlayerPedId())
                        Call_Manager_Open = false

                        SetNewWaypoint(Ticket_ID_Coords[h].x, Ticket_ID_Coords[h].y)
                        TriggerEvent("Nova:ToggleMoneyUI", true)
                        SetBigmapActive(false, false)
                        setCursor(0)
                        
                    else
                        local C
                        for m, n in pairs(Active_Calls) do
                            C = n[1]
                            break
                        end

                        if C ~= nil then
                            -- for m,n in pairs(globalBlips)do
                            --     SetBlipAlpha(n,255)
                            -- end
                            TriggerServerEvent("Nova:Server:AcceptCall", C)
                            Before_Ticket_Coords = GetEntityCoords(PlayerPedId())
                            Call_Manager_Open = false
                            
                            SetNewWaypoint(Ticket_ID_Coords[C].x, Ticket_ID_Coords[C].y)
                            TriggerEvent("Nova:ToggleMoneyUI", true)
                            SetBigmapActive(false, false)
                            setCursor(0)
                            
                        else
                            tvRP.notify("~r~No calls available")
                        end
                    end
                end
            else
                DrawRect(0.444, 0.96, 0.037, 0.03, 0, 0, 0, 150)
            end
            
            DrawAdvancedText(0.453, 0.964, 0.005, 0.0028, 0.4, Current_Page .. " / " .. Highest_Page - 1, 255, 255, 255, 255, 6, 0)
            DrawAdvancedText(0.369, 0.963, 0.005, 0.0028, 0.4, "Deny (-)", 255, 0, 0, 255, 4, 0)
            DrawAdvancedText(0.423, 0.963, 0.005, 0.0028, 0.4, "Previous", 255, 255, 255, 255, 4, 0)
            DrawAdvancedText(0.485, 0.963, 0.005, 0.0028, 0.4, "Next", 255, 255, 255, 255, 4, 0)
            DrawAdvancedText(0.539, 0.963, 0.005, 0.0028, 0.4, "Accept (=)", 12, 255, 26, 255, 4, 0)

            if IsDisabledControlJustPressed(1, Minus_Key) then
                PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                if Active_Calls[h] ~= nil then
                    for m, n in pairs(Active_Calls) do
                        if n[1] == h then
                            table.remove(Active_Calls, m)
                            break
                        end
                    end
                    j()
                else
                    for m, n in pairs(Active_Calls) do
                        table.remove(Active_Calls, m)
                        break
                    end
                    j()
                end

            elseif IsDisabledControlJustPressed(1, Equals_Key) then
                PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                if h ~= nil then
                    -- for m,n in pairs(globalBlips)do
                    --     SetBlipAlpha(n,255)
                    -- end
                    TriggerServerEvent("Nova:Server:AcceptCall", h)
                    Before_Ticket_Coords = GetEntityCoords(PlayerPedId())
                    Call_Manager_Open = false

                    SetNewWaypoint(Ticket_ID_Coords[h].x, Ticket_ID_Coords[h].y)
                    TriggerEvent("Nova:ToggleMoneyUI", true)
                    SetBigmapActive(false, false)
                    setCursor(0)

                else
                    local C
                    for m, n in pairs(Active_Calls) do
                        C = n[1]
                        break
                    end

                    if C ~= nil then
                        -- for m,n in pairs(globalBlips)do
                        --     SetBlipAlpha(n,255)
                        -- end
                        TriggerServerEvent("Nova:Server:AcceptCall", C)
                        Before_Ticket_Coords = GetEntityCoords(PlayerPedId())
                        Call_Manager_Open = false

                        SetNewWaypoint(Ticket_ID_Coords[C].x, Ticket_ID_Coords[C].y)
                        TriggerEvent("Nova:ToggleMoneyUI", true)
                        SetBigmapActive(false, false)
                        setCursor(0)
                    else
                        tvRP.notify("~r~No calls available")
                    end
                end
            end
        end

        if Call_Manager_Open then
            DisableControlAction(0, 1, true)
            DisableControlAction(0, 2, true)
            DisableControlAction(0, 25, true)
            DisableControlAction(0, 106, true)
            DisableControlAction(0, 24, true)
            DisableControlAction(0, 140, true)
            DisableControlAction(0, 141, true)
            DisableControlAction(0, 142, true)
            DisableControlAction(0, 257, true)
            DisableControlAction(0, 263, true)
            DisableControlAction(0, 264, true)
            DisableControlAction(0, 12, true)
            DisableControlAction(0, 14, true)
            DisableControlAction(0, 15, true)
            DisableControlAction(0, 16, true)
            DisableControlAction(0, 17, true)
        end

        Citizen.Wait(0)
    end
end)

RegisterKeyMapping('togglecall', 'Toggle the call manager', 'keyboard', 'OEM_3')
RegisterCommand('togglecall', function()
    if Call_Manager_Open then
        ExecuteCommand('closecall')
    else
        ExecuteCommand('opencall')
    end
end)

RegisterCommand("opencall", function()
    if Call_Manager_Open then
        tvRP.notify("You are already in the call manager")
    else
        j()
        TriggerEvent("Nova:ToggleMoneyUI", false)
        SetRadarBigmapEnabled(true, true)
        setCursor(1)
        Call_Manager_Open = true
    end
end)

RegisterCommand("closecall", function()
    if Call_Manager_Open then
        TriggerEvent("Nova:ToggleMoneyUI", true)
        SetRadarBigmapEnabled(false, false)
        setCursor(0)
        Call_Manager_Open = false
    else
        tvRP.notify("You are not in the callmanager")
    end
end)

Citizen.CreateThread(function()
    while true do
        for m, n in pairs(f) do
            for D, E in pairs(n) do
                E[7] = E[7] + 1
            end
        end

        Citizen.Wait(60000) -- Wait 1 minute
    end
end)

function tvRP.isInTicket()
    return In_Admin_Ticket
end

RegisterCommand("return", function()
    if tvRP.isInTicket() then
        if Before_Ticket_Coords ~= nil then
            SetEntityCoords(PlayerPedId(), Before_Ticket_Coords)
            Before_Ticket_Coords = nil
        else
            tvRP.notify("~r~Unable to retrieve saved coords")
        end

        TriggerServerEvent('Nova:Server:ReturnFromAdminTicket')
    else
        tvRP.notify("You are not in a ticket.")
    end
end)

RegisterNetEvent("Nova:ToggleAdminTicket") 
AddEventHandler('Nova:ToggleAdminTicket', function(Status, PlayerName, PlayerId)
    TriggerEvent("Nova:OMioDioMode", Status)
    In_Admin_Ticket = Status

    if Status and tvRP.isAdmin() then
        while tvRP.isStaffedOn() and tvRP.isInTicket() do
            if PlayerName ~= nil and PlayerId ~= nil then
                tvRP.drawNativeText(("~y~Taken ticket of %s [Perm ID: %s]\nUse /return to leave ticket"):format(PlayerName, PlayerId))
                Citizen.Wait(0)
            end
        end
    end
end)