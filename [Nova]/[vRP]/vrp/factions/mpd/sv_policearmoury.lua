local shared_config = module('vrp', "factions/mpd/cfg_mpd")

local function Can_Use_Weapon(user_id, requested_weapon_hash)
    local has_any_group = false
    for group_name, allow_listed_weapons in pairs(shared_config.rank_allow_listed_weapons) do
        if vRP.hasGroup(user_id, group_name) then
            has_any_group = true
            for i, weapon_hash in pairs(allow_listed_weapons) do
                if weapon_hash == requested_weapon_hash then
                    return true
                end
            end
            break
        end
    end

    if not has_any_group then
        return true
    end
    return false
end

local function Give_Client_Police_Weapon(client_source, user_id, client_ped, weapon_hash)
    local weapon_details = shared_config.small_arms_weapons[weapon_hash]
    if not weapon_details then
        if vRP.hasGroup(user_id, 'SCO-19') then
            weapon_details = shared_config.large_arms_weapons[weapon_hash]
        else
            return vRPclient.notify(client_source, {'~r~You do not have access to these weapons'})
        end
    end

    local requested_weapon_hash = weapon_details.hash
    local can_use_weapon = Can_Use_Weapon(user_id, requested_weapon_hash)
    if not can_use_weapon then
        TriggerClientEvent("Nova:PlaySound", client_source, 2)
        return vRPclient.notify(client_source, {'~r~You may not use this weapon'})
    end

    GiveWeaponToPed(client_ped, requested_weapon_hash, shared_config.police_ammo_count, false, true)
    TriggerClientEvent("Nova:PlaySound", client_source, 1)
    vRPclient.notify(client_source, {('~g~Received %s'):format(weapon_details.name)})
end

local function Check_Weapon_Shop_Distance(client_coords, item_details)
    local place_coords = vector3(item_details.x, item_details.y, item_details.z)
    if #(client_coords - place_coords) <= item_details.range then
        return true
    else
        return false
    end
end

RegisterServerEvent("Police:Server:GetWeapon")
AddEventHandler("Police:Server:GetWeapon", function(hash)  
    local source = source
    local user_id = vRP.getUserId(source)

    if vRP.hasPermission(user_id, "police.menu") then
        local client_ped = GetPlayerPed(source)
        local client_coords = GetEntityCoords(client_ped)

        for place_name, item_details in pairs(shared_config.item_shop.small_arms) do
            if Check_Weapon_Shop_Distance(client_coords, item_details) then
                Give_Client_Police_Weapon(source, user_id, client_ped, hash)
            end
        end

        for place_name, item_details in pairs(shared_config.item_shop.large_arms) do
            if Check_Weapon_Shop_Distance(client_coords, item_details) then
                Give_Client_Police_Weapon(source, user_id, client_ped, hash)
            end
        end
    else
        vRP.banConsole(user_id, "perm", "Cheating/ Triggering Events")
    end
end)

local function Client_Has_Any_Group(user_id, group_table)
    for i, group_name in pairs(group_table) do
        if vRP.hasGroup(user_id, group_name) then
            return true
        end
    end
    return false
end

RegisterServerEvent("Police:Server:GetArmour")
AddEventHandler("Police:Server:GetArmour", function()
    local source = source
    local user_id = vRP.getUserId(source)

    if vRP.hasPermission(user_id, 'police.menu') then
        local client_ped = GetPlayerPed(source)
        local client_coords = GetEntityCoords(client_ped)

        for place_name, item_details in pairs(shared_config.item_shop.armour_locker) do
            local place_coords = vector3(item_details.x, item_details.y, item_details.z)
            if #(client_coords - place_coords) <= item_details.range then
                for armour_amount, armour_group_table in pairs(shared_config.armour_by_rank) do
                    if Client_Has_Any_Group(user_id, armour_group_table) then
                        if GetPedArmour(client_ped) < armour_amount then
                            SetPedArmour(client_ped, armour_amount)
                        end

                        TriggerClientEvent("Nova:PlaySound", source, 1)
                        return vRPclient.notify(source, {shared_config.armour_purchased_message[armour_amount]})
                    end
                end
            end
        end

        --vRP.banConsole(user_id, "perm", "Cheating/ Triggering Events")
    else
        vRP.banConsole(user_id, "perm", "Cheating/ Triggering Events")
    end
end)