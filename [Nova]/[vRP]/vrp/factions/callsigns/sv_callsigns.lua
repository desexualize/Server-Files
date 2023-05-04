local Player_Callsigns = {} -- User ID = {LFB, NHS, HMP, MPD}

RegisterNetEvent('Factions:Server:RequestCallsigns')
AddEventHandler('Factions:Server:RequestCallsigns', function(bool_value)
    local source = source
    local user_callsigns = {
        ['LFB'] = nil,
        ['NHS'] = nil,
        ['HMP'] = nil,
        ['MPD'] = nil,
    }

    local discord_id = exports['Discord-Groups']:Get_Client_Discord_ID(source)
    if discord_id then
        local guilds_info = exports['Discord-Groups']:Get_Guilds()
        for guild_name, guild_id in pairs(guilds_info) do
            if guild_name ~= 'Nova UK' then
                local nick_name = exports['Discord-Groups']:Get_Guild_Nickname(guild_id, discord_id)
                if nick_name then
                    local open_bracket = string.find(nick_name, '[', nil, true) -- Extra Params to toggle pattern matching
                    local closed_bracket = string.find(nick_name, ']', nil, true) -- Extra Params to toggle pattern matching
                    
                    if open_bracket and closed_bracket then
                        local callsign_value = string.sub(nick_name, open_bracket + 1, closed_bracket - 1)
                        user_callsigns[guild_name] = callsign_value
                    end
                end
            end
        end
    end

    Player_Callsigns[source] = user_callsigns
    TriggerClientEvent('Factions:Client:ReceiveCallsigns', source, user_callsigns, bool_value)
end)