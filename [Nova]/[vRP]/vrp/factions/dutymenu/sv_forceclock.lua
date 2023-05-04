local config = module('vrp', 'factions/dutymenu/cfg_dutymenu')

local function Clock_Off_All_Ranks(user_temp_id, exempt_rank, specific_faction)
    local user_perm_id = vRP.getUserId(user_temp_id)
    local user_clocked_ranks = exports.vrp:Get_User_Clocked_Ranks(user_perm_id)
    local clocked_off_ranks = {}

    if user_clocked_ranks then
        for rank_name, faction_name in pairs(user_clocked_ranks) do
            local remove_group = true
            if exempt_rank and exempt_rank == rank_name then
                remove_group = false
            end

            if specific_faction and specific_faction ~= faction_name then
                remove_group = false
            end

            if remove_group then
                if vRP.hasGroup(user_perm_id, rank_name) then
                    vRP.removeUserGroup(user_perm_id, rank_name)
                    table.insert(clocked_off_ranks, rank_name)

                    local user_discord_id = exports['Discord-Groups']:Get_Client_Discord_ID(user_temp_id)
                    exports.vrp:Save_Faction_Hours(user_perm_id, GetPlayerName(user_temp_id), user_discord_id)
                end
            end
        end
    end

    return clocked_off_ranks
end
exports('Clock_Off_All_Ranks', Clock_Off_All_Ranks)