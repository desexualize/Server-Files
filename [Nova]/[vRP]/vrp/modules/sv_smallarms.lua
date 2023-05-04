local config = module('vrp', 'sharedcfg/cfg_smallarms')

local weapon_purchased_webhook = 'https://discord.com/api/webhooks/1012748524112318535/T213lyQjgo9zusN5CJYRApT2NR314L3jbEgVX5bCVh2wtzCtSlRjfg3Z8eIPjBPuivJN'
local armour_purchased_webhook = 'https://discord.com/api/webhooks/1021765881665159260/zOKUHUWF4jiyovxz0pewib3Vc0ODB4cg1CHHHrcdJF-GRBiW55cFdDPxWlICZlYnAEUr'

RegisterNetEvent('Nova:Smallarms:Server:PurchaseWeapon')
AddEventHandler('Nova:Smallarms:Server:PurchaseWeapon', function(location_name, weapon_hash, has_weapon)
    local source = source
    local client_ped = GetPlayerPed(source)
    local client_coords = GetEntityCoords(client_ped)

    local location_info = config.locations[location_name]
    if location_info then
        local user_id = vRP.getUserId(source)

        local position = location_info.position
        if #(client_coords - position) <= config.menu_range then
            local weapon_info = config.Get_Weapon_Info(weapon_hash)
            if weapon_info then
                local weapon_price = weapon_info.price
                if has_weapon then
                    weapon_price = weapon_price / 2
                end

                if vRP.tryPayment(user_id, weapon_price) then
                    local weapon_price = shared_functions.Get_Formatted_Money(weapon_price)
                    local weapon_hash = weapon_info.hash

                    local embed_description
                    if has_weapon then
                        SetPedAmmo(client_ped, weapon_hash, 250)
                        vRPclient.notify(source, {"~g~Ammo Purchased\nPaid £" .. weapon_price})
                        embed_description = 'User has purchased weapon ammo'
                    else
                        GiveWeaponToPed(client_ped, weapon_hash, 250, false, true)
                        vRPclient.notify(source, {"~g~Weapon Purchased\nPaid £" .. weapon_price})
                        embed_description = 'User has purchased a weapon'
                    end

                    TriggerClientEvent("Nova:PlaySound", source, 1) 

                    local weapon_purchased_embed = {
                        ["color"] = "15158332",
                        ['description'] = embed_description,
                        ['fields'] = {
                            {
                                ['name'] = 'User ID',
                                ['value'] = user_id,
                                ['inline'] = true
                            },
                            {
                                ['name'] = 'User Name',
                                ['value'] = GetPlayerName(source),
                                ['inline'] = true
                            },
                            {
                                ['name'] = 'Weapon Name',
                                ['value'] = weapon_info.name,
                                ['inline'] = true
                            },
                            {
                                ['name'] = 'Weapon Hash',
                                ['value'] = weapon_hash,
                                ['inline'] = true
                            },
                            {
                                ['name'] = 'Price Paid',
                                ['value'] = '£' .. weapon_price,
                                ['inline'] = true
                            },
                        },
                        ["footer"] = {
                            ["text"] = os.date('%d/%m/%Y - %H:%M:%S'),
                        }
                    }

                    PerformHttpRequest(weapon_purchased_webhook, function(err, text, headers)
                    end, "POST", json.encode({embeds = {weapon_purchased_embed}}), {["Content-Type"] = "application/json"})              
                else
                    vRPclient.notify(source, {"~r~Insufficient funds"})
                    TriggerClientEvent("Nova:PlaySound", source, 2)
                end
            else
                vRPclient.notify(source, {'~r~Invalid Weapon Selected'})
            end
        else
            vRP.banConsole({user_id, "perm", "Cheating / Triggering Events"})
        end
    else
        vRPclient.notify(source, {'~r~Invalid Small Arms Location'})
    end
end)

RegisterServerEvent("Nova:Smallarms:Server:PurchaseArmour")
AddEventHandler('Nova:Smallarms:Server:PurchaseArmour', function(location_name, armour_name)
    local source = source
    local client_ped = GetPlayerPed(source)
    local client_coords = GetEntityCoords(client_ped)

    local location_info = config.locations[location_name]
    if location_info then
        local user_id = vRP.getUserId(source)

        local position = location_info.position
        if #(client_coords - position) <= config.menu_range then
            local armour_info = config.Get_Armour_Info(armour_name)
            if armour_info then
                local armour_price = armour_info.price
                if vRP.tryPayment(user_id, armour_price) then
                    local armour_amount = armour_info.value
                    SetPedArmour(client_ped, armour_amount)

                    local armour_price = shared_functions.Get_Formatted_Money(armour_price)
                    vRPclient.notify(source, {"~g~Armour Purchased\nPaid £" .. armour_price})
                    TriggerClientEvent("Nova:PlaySound", source, 1) 

                    local armour_purchased_embed = {
                        ["color"] = "15158332",
                        ['description'] = 'User has purchased armour',
                        ['fields'] = {
                            {
                                ['name'] = 'User ID',
                                ['value'] = user_id,
                                ['inline'] = true
                            },
                            {
                                ['name'] = 'User Name',
                                ['value'] = GetPlayerName(source),
                                ['inline'] = true
                            },
                            {
                                ['name'] = 'Armour Amount',
                                ['value'] = armour_info.name,
                                ['inline'] = true
                            },
                            {
                                ['name'] = 'Price Paid',
                                ['value'] = '£' .. armour_price,
                                ['inline'] = true
                            },
                        },
                        ["footer"] = {
                            ["text"] = os.date('%d/%m/%Y - %H:%M:%S'),
                        }
                    }

                    PerformHttpRequest(armour_purchased_webhook, function(err, text, headers)
                    end, "POST", json.encode({embeds = {armour_purchased_embed}}), {["Content-Type"] = "application/json"})              
                else
                    vRPclient.notify(source, {"~r~Insufficient funds"})
                    TriggerClientEvent("Nova:PlaySound", source, 2)
                end
            else
                vRPclient.notify(source, {'~r~Invalid Armour Selected'})
            end
        else
            vRP.banConsole({user_id, "perm", "Cheating / Triggering Events"})
        end
    else
        vRPclient.notify(source, {'~r~Invalid Small Arms Location'})
    end
end)