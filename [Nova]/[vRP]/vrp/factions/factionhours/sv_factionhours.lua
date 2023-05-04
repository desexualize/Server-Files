local config = module('vrp', 'factions/factionhours/cfg_factionhours')
local Clocked_Times = {} -- user_id = {clocked_time, faction_name, 'faction_rank'}

local select_query = 'select discord_id, total_hours, weekly_hours from %s_user_hours where user_id = %s'
local insert_query = 'insert into %s_user_hours (user_id, user_name, discord_id, total_hours, weekly_hours, last_clocked_rank, last_clocked_date) values (%s, "%s", %s, %s, %s, "%s", "%s")'
local update_query = 'update %s_user_hours set user_name = "%s", discord_id = %s, total_hours = %s, weekly_hours = %s, last_clocked_rank = "%s", last_clocked_date = "%s" where user_id = %s'

local function Send_Information_Message(user_id, total_hours, weekly_hours, faction_name)
    local user_source = vRP.getUserSource(user_id)
    if user_source then
        local message_title = ('%s Information'):format(faction_name)
        local message_description = ('Total Hours: %.2f\nWeekly Hours: %.2f'):format(total_hours, weekly_hours)
        local message_colour = exports.vrp:Get_Faction_Notification_Colour(faction_name)
        vRPclient.SendHoursInformation(user_source, {message_colour, message_title, message_description})
    end
end

local function Send_Duty_Log(user_id, user_name, user_discord_id, faction_name, faction_rank, total_minutes)
    local embed_description
    if total_minutes then
        embed_description = 'User has clocked off'
    else
        embed_description = 'User has clocked on'
    end

    local embed_discord
    if user_discord_id then
        embed_discord = ('<@%s>'):format(user_discord_id)
    else
        embed_discord = 'Not Available'
    end

    local embed_colour = config.faction_embed_colours[faction_name]
    local formatted_date = os.date('%d/%m/%Y - %H:%M:%S')

    local duty_embed = {
        ['title'] = 'Nova Hour Logs',
        ['description'] = embed_description,
        ['color'] = embed_colour,
        ['fields'] = {
            {
                ["name"] = "User ID",
                ["value"] = user_id,
                ["inline"] = false
            },
            {
                ['name'] = 'User Name',
                ['value'] = user_name,
                ['inline'] = false
            },
            {
                ['name'] = 'Discord',
                ['value'] = embed_discord,
                ['inline'] = false
            },
            {
                ['name'] = 'User Group',
                ['value'] = faction_rank,
                ['inline'] = false
            },
        },
        ['footer'] = {
            ['text'] = formatted_date
        }
    }

    if total_minutes then
        local total_minutes_field = {
            ['name'] = 'Total Minutes',
            ['value'] = ('%.2f'):format(total_minutes),
            ['inline'] = false
        }
        table.insert(duty_embed.fields, total_minutes_field)
    end

    local duty_webhook = config.faction_duty_logs[faction_name]
    PerformHttpRequest(duty_webhook, function(err, text, headers)
    end, "POST", json.encode({embeds = {duty_embed}}), {["Content-Type"] = "application/json"})

    if total_minutes then
        local hours_done = total_minutes / 60
        local table_name = faction_name:lower()

        exports.oxmysql:single((select_query):format(table_name, user_id), {}, function(result)
            if result then
                local result_discord_id = result.discord_id
                if not user_discord_id and result_discord_id then
                    user_discord_id = result_discord_id
                end

                local total_hours = result.total_hours + hours_done
                local weekly_hours = result.weekly_hours + hours_done
                exports.oxmysql:update((update_query):format(table_name, user_name, user_discord_id, total_hours, weekly_hours, faction_rank, formatted_date, user_id))
                Send_Information_Message(user_id, total_hours, weekly_hours, faction_name)
            else
                exports.oxmysql:insert((insert_query):format(table_name, user_id, user_name, user_discord_id, hours_done, hours_done, faction_rank, formatted_date))
                Send_Information_Message(user_id, hours_done, hours_done, faction_name)
            end
        end)
    end
end

local function Save_User_Hours(user_id, user_name, user_discord_id)
    local user_info = Clocked_Times[user_id]
    if user_info then
        Clocked_Times[user_id] = nil

        local current_time = os.time()
        local previous_time = user_info['clocked_time']

        local clocked_faction = user_info['faction_name']
        local clocked_rank = user_info['faction_rank']

        local total_seconds = current_time - previous_time
        local total_minutes = total_seconds / 60
        Send_Duty_Log(user_id, user_name, user_discord_id, clocked_faction, clocked_rank, total_minutes)
    end
end

local function Start_User_Hours(user_id, user_name, user_discord_id, faction_name, faction_rank)
    local current_time = os.time()
    Clocked_Times[user_id] = {
        ['clocked_time'] = current_time,
        ['faction_name'] = faction_name,
        ['faction_rank'] = faction_rank,
    }
    Send_Duty_Log(user_id, user_name, user_discord_id, faction_name, faction_rank)
end

exports('Save_Faction_Hours', function(user_id, user_name, user_discord_id, faction_name, faction_rank)
    if Clocked_Times[user_id] then
        Save_User_Hours(user_id, user_name, user_discord_id)
    else
        Start_User_Hours(user_id, user_name, user_discord_id, faction_name, faction_rank)
    end
end)

RegisterNetEvent('vRP:playerJoin')
AddEventHandler('vRP:playerJoin', function(user_id, user_source, user_name, last_login)
    local clocked_info = exports.vrp:Get_User_Clocked_Ranks(user_id)
    if clocked_info then
        for rank_name, faction_name in pairs(clocked_info) do
            local user_discord_id = exports['Discord-Groups']:Get_Client_Discord_ID(user_source)
            Start_User_Hours(user_id, user_name, user_discord_id, faction_name, rank_name:gsub(' Clocked', ''))
            break
        end
    end
end)

RegisterNetEvent('vRP:playerLeave')
AddEventHandler('vRP:playerLeave', function(user_id, user_source)
    if Clocked_Times[user_id] then
        local user_discord_id = exports['Discord-Groups']:Get_Client_Discord_ID(user_source)
        Save_User_Hours(user_id, GetPlayerName(user_source), user_discord_id)
    end
end)