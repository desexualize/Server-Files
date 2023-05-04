local admincfg = module('vrp', 'cfg/admin_menu')

local group_logs_webhook = 'https://discord.com/api/webhooks/1022587114283614259/vrMsfuDvGJQ10HQoffbbXi4EhWJpSenY4BKvpDlBA2VcCWVPht-c76fGIoMPm4iHUBEv'
local revive_logs_webhook = "https://discord.com/api/webhooks/1012504906764128256/qQXAKtnrD9wCNEtwmTizvCKctFHw0bWgbC7TD-Z2VS1DPDGuBP2wxABFnDXvjYn8Gwhl"
local Before_Admin_Island_Coords = {} -- Temp ID - Position

RegisterServerEvent("Nova:OpenSettings")
AddEventHandler("Nova:OpenSettings", function()
    local source = source
    local user_id = vRP.getUserId(source)
    TriggerClientEvent("Nova:OpenSettingsMenu", source, vRP.hasPermission(user_id, "admin.menu"))
end)

RegisterServerEvent("Nova:GetPlayerData")
AddEventHandler("Nova:GetPlayerData", function()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, admincfg.perm) then
        players = GetPlayers()
        players_table = {}
        menu_btns_table = {}
        useridz = {}
        for i, p in pairs(players) do
            if vRP.getUserId(p) ~= nil then
                name = GetPlayerName(p)
                user_idz = vRP.getUserId(p)
                data = vRP.getUserDataTable(user_idz)
                playtime = data.PlayerTime or 0
                PlayerTimeInHours = playtime / 60
                if PlayerTimeInHours < 1 then
                    PlayerTimeInHours = 0
                end
                players_table[user_idz] = {name, p, user_idz, math.ceil(PlayerTimeInHours)}
                table.insert(useridz, user_idz)
            else
                DropPlayer(p, "Nova - The server was unable to cache your ID, please rejoin")
            end
        end

        if admincfg.IgnoreButtonPerms == false then
            for i, b in pairs(admincfg.buttonsEnabled) do
                if b[1] and vRP.hasPermission(user_id, b[2]) then
                    menu_btns_table[i] = true
                else
                    menu_btns_table[i] = false
                end
            end
        else
            for j, t in pairs(admincfg.buttonsEnabled) do
                menu_btns_table[j] = true
            end
        end
        TriggerClientEvent("Nova:SendPlayerInfo", source, players_table, menu_btns_table)
    end
end)

RegisterNetEvent("Nova:GetNearbyPlayers")
AddEventHandler("Nova:GetNearbyPlayers", function(dist)
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, admincfg.perm) then
        local plrTable = {}
        vRPclient.getNearestPlayers(source, {dist}, function(nearbyPlayers)
            for k, v in pairs(nearbyPlayers) do
                data = vRP.getUserDataTable(vRP.getUserId(k))
                playtime = data.PlayerTime or 0
                PlayerTimeInHours = playtime / 60
                if PlayerTimeInHours < 1 then
                    PlayerTimeInHours = 0
                end
                plrTable[vRP.getUserId(k)] = {
                    GetPlayerName(k),
                    k,
                    vRP.getUserId(k),
                    math.ceil(PlayerTimeInHours)
                }
            end
            TriggerClientEvent("Jud:ReturnNearbyPlayers", source, plrTable)
        end)
    end
end)    

RegisterNetEvent('Nova:Server:ForceClockOff')
AddEventHandler('Nova:Server:ForceClockOff', function(user_temp_id)
    local source = source
    local admin_user_id = vRP.getUserId(source)
    if vRP.hasPermission(admin_user_id, 'admin.forceclockoff') then
        local clocked_off_ranks = exports.vrp:Clock_Off_All_Ranks(user_temp_id)
        if #clocked_off_ranks > 0 then
            if tonumber(source) ~= tonumber(user_temp_id) then
                vRPclient.notify(source, {'~g~User has been clocked off'})
            end
            vRPclient.notify(user_temp_id, {'~r~You have been force clocked off'})
        else
            vRPclient.notify(source, {'~r~User is not clocked on any faction'})
        end
    else
        vRPclient.notify(source, {'~r~You do not have permission to force clock off'})
    end
end)

local Source_Viewing_Groups = {} -- Source: Perm ID
RegisterServerEvent("Nova:GetGroups")
AddEventHandler("Nova:GetGroups", function(perm)
    local user_groups = vRP.getUserGroups(perm)
    Source_Viewing_Groups[source] = perm
    TriggerClientEvent("Nova:GotGroups", source, user_groups)
end)

RegisterNetEvent('Nova:Server:GroupsUpdated')
AddEventHandler('Nova:Server:GroupsUpdated', function(user_id)
    local Sources_Watching = {}
    for source_id, perm_id in pairs(Source_Viewing_Groups) do
        if user_id == perm_id then
            table.insert(Sources_Watching, source_id)
        end
    end

    if #Sources_Watching > 0 then
        local user_groups = vRP.getUserGroups(user_id)
        for table_id, source_id in pairs(Sources_Watching) do
            TriggerClientEvent("Nova:GotGroups", source_id, user_groups)
        end
    end
end)

RegisterServerEvent("Nova:CheckPov")
AddEventHandler("Nova:CheckPov", function(userperm)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "admin.menu") then
        TriggerClientEvent("Nova:ReturnPov", source, vRP.hasGroup(userperm, "pov"))
    end
end)

RegisterServerEvent("Nova:fixVehicle")
AddEventHandler("Nova:fixVehicle", function()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "admin.noclip") then
        TriggerClientEvent("Nova:fixVehicle", source)
    end
end)

local onesync = GetConvar("onesync", nil)
RegisterNetEvent("Nova:SpectatePlayer")
AddEventHandler("Nova:SpectatePlayer", function(id)
    local source = source
    local userid = vRP.getUserId(source)
    if vRP.hasPermission(userid, "admin.spectate") then
        local SelectedPlrSource = vRP.getUserSource(id)
        if SelectedPlrSource then
            if onesync ~= "off" then
                local ped = GetPlayerPed(SelectedPlrSource)
                local pedCoords = GetEntityCoords(ped)
                TriggerClientEvent("Nova:Spectate", source, SelectedPlrSource, pedCoords)
            else
                TriggerClientEvent("Nova:Spectate", source, SelectedPlrSource)
            end
        else
            vRPclient.notify(source, {"~r~This player may have left the game"})
        end
    end
end)

RegisterServerEvent("Nova:Giveweapon")
AddEventHandler("Nova:Giveweapon", function()
    local source = source
    local userid = vRP.getUserId(source)
    if vRP.hasPermission(userid, "developer.menu") then
        vRP.prompt(source, "Weapon Name:", "", function(source, hash)
            GiveWeaponToPed(source, "weapon_" .. hash, 9999, false, true)
            vRPclient.notify(source, {"~g~Successfully spawned ~b~" .. hash})
        end)
    end
end)

RegisterServerEvent("Nova:GiveWeaponToPlayer")
AddEventHandler("Nova:GiveWeaponToPlayer", function()
    local source = source
    local userid = vRP.getUserId(source)
    if vRP.hasPermission(userid, "developer.menu") then
        vRP.prompt(source, "Perm ID:", "", function(source, permid)
            local permid = tonumber(permid)
            local permsource = vRP.getUserSource(permid)
            if permsource then
                vRP.prompt(source, "Weapon Name:", "", function(source, hash)
                    GiveWeaponToPed(permsource, "weapon_" .. hash, 250, false, true)
                    vRPclient.notify(source, {"~g~Successfully gave ~b~" .. hash .. " ~g~to " .. GetPlayerName(permsource)})
                end)
            else
                vRPclient.notify(source, {string.format("~r~Perm ID: (%s), is not currently online", permid)})
            end
        end)
    end
end)

RegisterServerEvent("Nova:AddGroup")
AddEventHandler("Nova:AddGroup", function(player_temp_id, selgroup, player_user_id)
    local admin_temp_id = source

    local check_permissions = true
    if player_user_id then
        if admin_temp_id == '' or admin_temp_id == 0 or admin_temp_id == nil then
            check_permissions = false
        end
    end

    if check_permissions then
        local admin_user_id = vRP.getUserId(admin_temp_id)
        
        if vRP.hasPermission(admin_user_id, "group.add") then
            if selgroup == "founder" and not vRP.hasPermission(admin_user_id, "group.add.founder") then
                return vRPclient.notify(admin_temp_id, {"~r~You don't have permission to do that"})

            elseif selgroup == "cofounder" and not vRP.hasPermission(admin_user_id, "group.add.cofounder") then
                return vRPclient.notify(admin_temp_id, {"~r~You don't have permission to do that"})

            elseif selgroup == 'developer' and not vRP.hasPermission(admin_user_id, 'group.add.developer') then
                return vRPclient.notify(admin_temp_id, {"~r~You don't have permission to do that"})

            elseif selgroup == 'cardeveloper' and not vRP.hasPermission(admin_user_id, 'group.add.cardeveloper') then
                return vRPclient.notify(admin_temp_id, {"~r~You don't have permission to do that"})

            elseif selgroup == "staffmanager" and not vRP.hasPermission(admin_user_id, "group.add.staffmanager") then
                return vRPclient.notify(admin_temp_id, {"~r~You don't have permission to do that"})

            elseif selgroup == "commanager" and not vRP.hasPermission(admin_user_id, "group.add.commanager") then
                return vRPclient.notify(admin_temp_id, {"~r~You don't have permission to do that"})

            elseif selgroup == "headadmin" and not vRP.hasPermission(admin_user_id, "group.add.headadmin") then
                return vRPclient.notify(admin_temp_id, {"~r~You don't have permission to do that"})
                    
            elseif selgroup == "senioradmin" and not vRP.hasPermission(admin_user_id, "group.add.senioradmin") then
                return vRPclient.notify(admin_temp_id, {"~r~You don't have permission to do that"})

            elseif selgroup == "administrator" and not vRP.hasPermission(admin_user_id, "group.add.administrator") then
                return vRPclient.notify(admin_temp_id, {"~r~You don't have permission to do that"})

            elseif selgroup == "srmoderator" and not vRP.hasPermission(admin_user_id, "group.add.srmoderator") then
                return vRPclient.notify(admin_temp_id, {"~r~You don't have permission to do that"})

            elseif selgroup == "moderator" and not vRP.hasPermission(admin_user_id, "group.add.moderator") then
                return vRPclient.notify(admin_temp_id, {"~r~You don't have permission to do that"})

            elseif selgroup == "supportteam" and not vRP.hasPermission(admin_user_id, "group.add.supportteam") then
                return vRPclient.notify(admin_temp_id, {"~r~You don't have permission to do that"})

            elseif selgroup == "trialstaff" and not vRP.hasPermission(admin_user_id, "group.add.trial") then
                return vRPclient.notify(admin_temp_id, {"~r~You don't have permission to do that"})

            elseif selgroup == "vip" and not vRP.hasPermission(admin_user_id, "group.add.vip") then
                return vRPclient.notify(admin_temp_id, {"~r~You don't have permission to do that"})

            elseif selgroup == "pov" and not vRP.hasPermission(admin_user_id, "group.add.pov") then
                return vRPclient.notify(admin_temp_id, {"~r~You don't have permission to do that"})
            end
        else
            --print("Stop trying to add a group u fucking cheater")
            return
        end
    end

    local player_perm_id
    if player_user_id then
        player_perm_id = player_user_id
    else
        player_perm_id = vRP.getUserId(player_temp_id)
    end
    
    vRP.addUserGroup(player_perm_id, selgroup)
    TriggerEvent('Nova:Server:GroupsUpdated', player_perm_id)

    -- Trigger Events to check if any faction group was addded
    TriggerEvent('Nova:Server:DutyMenu:GetWhitelistedFactions', player_temp_id)

    if selgroup == 'pov' then
        local playerName = GetPlayerName(source)
        local povName = GetPlayerName(player_temp_id)

        PerformHttpRequest(group_logs_webhook, function(err, text, headers)
        end, "POST", json.encode(
            {
                embeds = {
                    {
                        ["color"] = "15158332",
                        ["title"] = "Added to Pov List",
                        ["description"] = (
                            "**Admin Name:** " .. playerName ..
                            "\n**Admin ID:** " .. admin_user_id ..
                            "\n**Player Name:** " .. povName ..
                            "\n**Player ID:** " .. player_perm_id
                            
                        ),
                        ["footer"] = {
                            ["text"] = "Time - " .. os.date("%x %X %p")
                        }
                    }
                }
            }
        ),
            {["Content-Type"] = "application/json"}
        )
    end
end)

RegisterServerEvent("Nova:RemoveGroup")
AddEventHandler("Nova:RemoveGroup", function(player_temp_id, selgroup, player_user_id)
    local admin_temp_id = source

    local check_permissions = true
    if player_user_id then
        if admin_temp_id == '' or admin_temp_id == 0 or admin_temp_id == nil then
            check_permissions = false
        end
    end

    if check_permissions then
        local admin_user_id = vRP.getUserId(admin_temp_id)

        if vRP.hasPermission(admin_user_id, "group.remove") then
            if selgroup == "founder" and not vRP.hasPermission(admin_user_id, "group.remove.founder") then
                return vRPclient.notify(admin_temp_id, {"~r~You don't have permission to do that"})

            elseif selgroup == "cofounder" and not vRP.hasPermission(admin_user_id, "group.remove.cofounder") then
                return vRPclient.notify(admin_temp_id, {"~r~You don't have permission to do that"})

            elseif selgroup == "staffmanager" and not vRP.hasPermission(admin_user_id, "group.remove.staffmanager") then
                return vRPclient.notify(admin_temp_id, {"~r~You don't have permission to do that"})

            elseif selgroup == "commanager" and not vRP.hasPermission(admin_user_id, "group.remove.commanager") then
                return vRPclient.notify(admin_temp_id, {"~r~You don't have permission to do that"})

            elseif selgroup == "headadmin" and not vRP.hasPermission(admin_user_id, "group.remove.headadmin") then
                return vRPclient.notify(admin_temp_id, {"~r~You don't have permission to do that"})

            elseif selgroup == "senioradmin" and not vRP.hasPermission(admin_user_id, "group.remove.senioradmin") then
                return vRPclient.notify(admin_temp_id, {"~r~You don't have permission to do that"})

            elseif selgroup == "administrator" and not vRP.hasPermission(admin_user_id, "group.remove.administrator") then
                return vRPclient.notify(admin_temp_id, {"~r~You don't have permission to do that"})

            elseif selgroup == "srmoderator" and not vRP.hasPermission(admin_user_id, "group.remove.srmoderator") then
                return vRPclient.notify(admin_temp_id, {"~r~You don't have permission to do that"})

            elseif selgroup == "moderator" and not vRP.hasPermission(admin_user_id, "group.remove.moderator") then
                return vRPclient.notify(admin_temp_id, {"~r~You don't have permission to do that"})

            elseif selgroup == "supportteam" and not vRP.hasPermission(admin_user_id, "group.remove.supportteam") then
                return vRPclient.notify(admin_temp_id, {"~r~You don't have permission to do that"})

            elseif selgroup == "trialstaff" and not vRP.hasPermission(admin_user_id, "group.remove.trial") then
                return vRPclient.notify(admin_temp_id, {"~r~You don't have permission to do that"})

            elseif selgroup == "vip" and not vRP.hasPermission(admin_user_id, "group.remove.vip") then
                return vRPclient.notify(admin_temp_id, {"~r~You don't have permission to do that"})
                    
            elseif selgroup == "pov" and not vRP.hasPermission(admin_user_id, "group.add.pov") then
                return vRPclient.notify(admin_temp_id, {"~r~You don't have permission to do that"})
            end
        else
            --print("Stop trying to add a group u fucking cheater")
            return
        end
    end


    local player_perm_id
    if player_user_id then
        player_perm_id = player_user_id
    else
        player_perm_id = vRP.getUserId(player_temp_id)
    end

    vRP.removeUserGroup(player_perm_id, selgroup)
    TriggerEvent('Nova:Server:GroupsUpdated', player_perm_id)

        -- Trigger Events to check if any faction group was removed
    TriggerEvent('Nova:Server:DutyMenu:GetWhitelistedFactions', player_temp_id, selgroup)

    if selgroup == 'pov' then
        local playerName = GetPlayerName(admin_temp_id)
        local povName = GetPlayerName(player_temp_id)

        PerformHttpRequest(group_logs_webhook, function(err, text, headers)
            end, "POST", json.encode(
                {
                    embeds = {
                        {
                            ["color"] = "15158332",
                            ["title"] = "Removed from POV List",
                            ["description"] = (
                                "**Admin Name:** " .. playerName ..
                                "\n**Admin ID:** " .. admin_user_id ..
                                "\n**Player Name:** " .. povName ..
                                "\n**Player ID:** " .. player_perm_id
                            ),
                            ["footer"] = {
                                ["text"] = "Time - " .. os.date("%x %X %p")
                            }
                        }
                    }
                }
            ),
            {["Content-Type"] = "application/json"}
        )
    end
end)

exports('Admin_Add_Group', function(player_temp_id, selgroup, player_user_id)
    TriggerEvent('Nova:AddGroup', player_temp_id, selgroup, player_user_id)
end)

exports('Admin_Remove_Group', function(player_temp_id, selgroup, player_user_id)
    TriggerEvent('Nova:RemoveGroup', player_temp_id, selgroup, player_user_id)
end)

RegisterServerEvent("Nova:CreateBanData")
AddEventHandler("Nova:CreateBanData", function(admin, target)
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "admin.ban") then
        local targetsource = vRP.getUserSource(target)
        local name = GetPlayerName(targetsource)
        TriggerClientEvent("Nova:openConfirmBan", source, target, name)
    else
        -- put anticheat ban here
    end
end)

RegisterServerEvent("Nova:BanPlayerConfirm")
AddEventHandler("Nova:BanPlayerConfirm", function(admin, target_id, reasons, duration)
    local source = source
    local user_id = vRP.getUserId(source)
    local target = vRP.getUserSource(target_id)
    local admin_id = vRP.getUserId(admin)
    local adminName = GetPlayerName(source)
    warningDate = getCurrentDate()
    if vRP.hasPermission(user_id, "admin.ban") then
        local webhook = "https://discord.com/api/webhooks/1022588463607976047/sX9l5lBQ5Xd6mPyTheV0P1bk022BFAG1jt9ETeGXlbsyB7PdBiLVGQ1Yu6oAsWzUNqHy"
        PerformHttpRequest(
            webhook,
            function(err, text, headers)
            end,
            "POST",
            json.encode(
                {
                    embeds = {
                        {
                            ["color"] = "15158332",
                            ["title"] = "Player Banned: ",
                            ["description"] = "**Admin Name: **" ..
                                GetPlayerName(admin) ..
                                    "\n**Admin ID: **" ..
                                        vRP.getUserId(admin) ..
                                            " \n**Player ID: **" ..
                                                target_id ..
                                                    " \n**Reason(s):** " ..
                                                        reasons .. "\n **Duration: ** " .. duration,
                            ["footer"] = {
                                ["text"] = "Time - " .. os.date("%x %X %p")
                            }
                        }
                    }
                }
            ),
            {["Content-Type"] = "application/json"}
        )
        TriggerClientEvent(
            "Nova:NotifyPlayer",
            admin,
            "You have banned " .. GetPlayerName(target) .. "[" .. target_id .. "]" .. " for " .. reasons
        )
        if tonumber(duration) == -1 then
            vRP.ban(source, target_id, "perm", reasons)
            f10Ban(target_id, adminName, reasons, "-1")
        else
            vRP.ban(source, target_id, duration, reasons)
            f10Ban(target_id, adminName, reasons, duration)
        end
    else
        -- put anticheat ban here
    end
end)

RegisterServerEvent("Nova:CustomBan")
AddEventHandler("Nova:CustomBan", function(admin, target)
    local source = source
    local user_id = vRP.getUserId(source)
    local target = target
    local target_id = vRP.getUserSource(target)
    local admin_id = vRP.getUserId(admin)
    local adminName = GetPlayerName(source)
    warningDate = getCurrentDate()
    if vRP.hasPermission(user_id, "admin.ban") then
        vRP.prompt(
            source,
            "Reason:",
            "",
            function(source, Reason)
                if Reason == "" then
                    return
                end
                vRP.prompt(
                    source,
                    "Duration:",
                    "",
                    function(source, Duration)
                        if Duration == "" then
                            return
                        end
                        Duration = parseInt(Duration)
                        vRP.prompt(
                            source,
                            "Evidence:",
                            "",
                            function(source, Evidence)
                                if Evidence == "" then
                                    return
                                end
                                videoclip = Evidence
                                local webhook =
                                    "https://discord.com/api/webhooks/1022588463607976047/sX9l5lBQ5Xd6mPyTheV0P1bk022BFAG1jt9ETeGXlbsyB7PdBiLVGQ1Yu6oAsWzUNqHy"
                                PerformHttpRequest(
                                    webhook,
                                    function(err, text, headers)
                                    end,
                                    "POST",
                                    json.encode(
                                        {
                                            embeds = {
                                                {
                                                    ["color"] = "15158332",
                                                    ["title"] = "Player Custom Banned: ",
                                                    ["description"] = "**Admin Name: **" ..
                                                        GetPlayerName(admin) ..
                                                            "\n**Admin ID: **" ..
                                                                vRP.getUserId(admin) ..
                                                                    " \n**Player ID: **" ..
                                                                        target ..
                                                                            " \n**Reason:** " ..
                                                                                Reason ..
                                                                                    "\n **Duration: ** " ..
                                                                                        Duration ..
                                                                                            " \n **Evidence: **" ..
                                                                                                videoclip .. "",
                                                    ["footer"] = {
                                                        ["text"] = "Time - " .. os.date("%x %X %p")
                                                    }
                                                }
                                            }
                                        }
                                    ),
                                    {["Content-Type"] = "application/json"}
                                )
                                TriggerClientEvent(
                                    "Nova:NotifyPlayer",
                                    admin,
                                    "You have banned " ..
                                        GetPlayerName(target_id) .. "[" .. target .. "]" .. " for " .. Reason
                                )
                                if tonumber(Duration) == -1 then
                                    vRP.ban(source, target, "perm", Reason)
                                    f10Ban(target, adminName, Reason, "-1")
                                else
                                    vRP.ban(source, target, Duration, Reason)
                                    f10Ban(target, adminName, Reason, Duration)
                                end
                            end
                        )
                    end
                )
            end
        )
    else
        -- put anticheat ban here
    end
end)

RegisterServerEvent("Nova:offlineban")
AddEventHandler("Nova:offlineban", function(admin)
    local source = source
    local user_id = vRP.getUserId(source)
    local admin_id = vRP.getUserId(admin)
    local adminName = GetPlayerName(admin)
    warningDate = getCurrentDate()
    if vRP.hasPermission(user_id, "admin.ban") then
        vRP.prompt(
            source,
            "Perm ID:",
            "",
            function(source, permid)
                if permid == "" then
                    return
                end
                permid = parseInt(permid)
                vRP.prompt(
                    source,
                    "Duration:",
                    "",
                    function(source, Duration)
                        if Duration == "" then
                            return
                        end
                        Duration = parseInt(Duration)
                        vRP.prompt(
                            source,
                            "Reason:",
                            "",
                            function(source, Reason)
                                if Reason == "" then
                                    return
                                end
                                vRP.prompt(
                                    source,
                                    "Evidence:",
                                    "",
                                    function(source, Evidence)
                                        if Evidence == "" then
                                            return
                                        end
                                        videoclip = Evidence
                                        local target = permid
                                        local target_id = vRP.getUserSource(target)
                                        local webhook = "https://discord.com/api/webhooks/1022588463607976047/sX9l5lBQ5Xd6mPyTheV0P1bk022BFAG1jt9ETeGXlbsyB7PdBiLVGQ1Yu6oAsWzUNqHy"
                                        PerformHttpRequest(
                                            webhook,
                                            function(err, text, headers)
                                            end,
                                            "POST",
                                            json.encode(
                                                {
                                                    embeds = {
                                                        {
                                                            ["color"] = "15158332",
                                                            ["title"] = "Player Offline Banned: ",
                                                            ["description"] = "**Admin Name: **" ..
                                                                GetPlayerName(admin) ..
                                                                    "\n**Admin ID: **" ..
                                                                        vRP.getUserId(admin) ..
                                                                            " \n**Player ID: **" ..
                                                                                target ..
                                                                                    " \n**Reason:** " ..
                                                                                        Reason ..
                                                                                            "\n **Duration: ** " ..
                                                                                                Duration ..
                                                                                                    " \n **Evidence: **" ..
                                                                                                        videoclip ..
                                                                                                            "",
                                                            ["footer"] = {
                                                                ["text"] = "Time - " .. os.date("%x %X %p")
                                                            }
                                                        }
                                                    }
                                                }
                                            ),
                                            {["Content-Type"] = "application/json"}
                                        )
                                        TriggerClientEvent(
                                            "Nova:NotifyPlayer",
                                            admin,
                                            "You have offline banned " .. permid .. " for " .. Reason
                                        )
                                        if tonumber(Duration) == -1 then
                                            vRP.ban(source, target, "perm", Reason)
                                            f10Ban(target, adminName, Reason, "-1")
                                        else
                                            vRP.ban(source, target, Duration, Reason)
                                            f10Ban(target, adminName, Reason, Duration)
                                        end
                                    end
                                )
                            end
                        )
                    end
                )
            end
        )
    else
        -- put anticheat ban here
    end
end)

RegisterServerEvent("Nova:RequestScreenshot")
AddEventHandler("Nova:RequestScreenshot", function(admin, target)
    local target_id = vRP.getUserId(target)
    local target_name = GetPlayerName(target)
    local admin_id = vRP.getUserId(admin)
    local admin_name = GetPlayerName(source)
    local perm = admincfg.buttonsEnabled["SS"][2]
    if vRP.hasPermission(admin_id, perm) then
        exports["discord-screenshot"]:requestClientScreenshotUploadToDiscord(
            target,
            {
                username = "Nova Screenshot Logs",
                avatar_url = "",
                embeds = {
                    {
                        color = 11111111,
                        title = admin_name .. "[" .. admin_id .. "] Took a screenshot",
                        description = "**Admin Name:** " ..
                            admin_name ..
                                "\n**Admin ID:** " ..
                                    admin_id ..
                                        "\n**Player Name:** " .. target_name .. "\n**Player ID:** " .. target_id,
                        footer = {
                            text = "" .. os.date("%x %X %p")
                        }
                    }
                }
            },
            30000,
            function(error)
                if error then
                    return print("^1ERROR: " .. error)
                end
                print("Sent screenshot successfully")
                TriggerClientEvent(
                    "Nova:NotifyPlayer",
                    admin,
                    "Successfully took a screenshot of " .. target_name .. "'s screen"
                )
            end
        )
    else
        -- put anticheat ban here
    end
end)

RegisterServerEvent("Nova:noF10Kick")
AddEventHandler("Nova:noF10Kick", function()
    local admin_id = vRP.getUserId(source)
    local perm2 = admincfg.buttonsEnabled["kick"][2]
    playerName = GetPlayerName(source)
    if vRP.hasPermission(admin_id, perm2) then
        vRP.prompt(
            source,
            "Perm ID:",
            "",
            function(source, permid)
                if permid == "" then
                    return
                end
                permid = parseInt(permid)
                vRP.prompt(
                    source,
                    "Reason:",
                    "",
                    function(source, reason)
                        if reason == "" then
                            return
                        end
                        local reason = reason
                        vRPclient.notify(source, {"~g~Kicked ID: " .. permid})
                        webhook = "https://discord.com/api/webhooks/1012504328138936360/ByvwOSkFL6DZKKubcKd0gWVBYflH0byxdurRMcsNyZq-3rpRCO4viiq0xxHqniObsT2P"
                        PerformHttpRequest(
                            webhook,
                            function(err, text, headers)
                            end,
                            "POST",
                            json.encode(
                                {
                                    embeds = {
                                        {
                                            ["color"] = "15158332",
                                            ["title"] = "Kicked Player (No F10)",
                                            ["description"] = "**Admin Name: **" ..
                                                playerName ..
                                                    "\n**Admin ID: **" .. admin_id .. "\n**Player ID:** " .. permid,
                                            ["footer"] = {
                                                ["text"] = "Time - " .. os.date("%x %X %p")
                                            }
                                        }
                                    }
                                }
                            ),
                            {["Content-Type"] = "application/json"}
                        )
                        DropPlayer(vRP.getUserSource(permid), reason)
                    end
                )
            end
        )
    else
        -- put anticheat ban here
    end
end)

RegisterServerEvent("Nova:KickPlayer")
AddEventHandler("Nova:KickPlayer", function(admin, target, reason, tempid)
    local source = source
    local target_id = vRP.getUserSource(target)
    local target_permid = target
    local playerName = GetPlayerName(source)
    local playerOtherName = GetPlayerName(tempid)
    local perm = admincfg.buttonsEnabled["kick"][2]
    local admin_id = vRP.getUserId(admin)
    local adminName = GetPlayerName(admin)
    local webhook = "https://discord.com/api/webhooks/1012504328138936360/ByvwOSkFL6DZKKubcKd0gWVBYflH0byxdurRMcsNyZq-3rpRCO4viiq0xxHqniObsT2P"
    if vRP.hasPermission(admin_id, perm) then
        vRP.prompt(
            source,
            "Reason:",
            "",
            function(source, Reason)
                if Reason == "" then
                    return
                end
                PerformHttpRequest(
                    webhook,
                    function(err, text, headers)
                    end,
                    "POST",
                    json.encode(
                        {
                            embeds = {
                                {
                                    ["color"] = "15158332",
                                    ["title"] = "Player Kicked",
                                    ["description"] = "**Admin Name:** " ..
                                        playerName ..
                                            "\n**Admin ID:** " ..
                                                admin_id ..
                                                    "\n**Player ID:** " ..
                                                        target_permid .. "\n**Reason:** " .. Reason,
                                    ["footer"] = {
                                        ["text"] = "Time - " .. os.date("%x %X %p")
                                    }
                                }
                            }
                        }
                    ),
                    {["Content-Type"] = "application/json"}
                )
                vRP.kick(
                    target_id,
                    "Nova You have been kicked | Your ID is: " ..
                        target .. " | Reason: " .. Reason .. " | Kicked by " .. GetPlayerName(admin) or
                        "No reason specified"
                )
                f10Kick(target_permid, adminName, Reason)
                TriggerClientEvent("Nova:NotifyPlayer", admin, "Kicked Player")
            end
        )
    else
        -- put anticheat ban here
    end
end)

RegisterServerEvent("Nova:RemoveWarning")
AddEventHandler("Nova:RemoveWarning", function(admin, warningid)
    local admin_id = vRP.getUserId(admin)
    local perm = admincfg.buttonsEnabled["removewarn"][2]
    if vRP.hasPermission(admin_id, perm) then
        vRP.prompt(
            source,
            "Warning ID:",
            "",
            function(source, warningid)
                if warningid == "" then
                    return
                end
                exports["oxmysql"]:query(
                    "DELETE FROM vrp_warnings WHERE warning_id = @uid",
                    {uid = warningid}
                )
                TriggerClientEvent("Nova:NotifyPlayer", admin, "Removed warning #" .. warningid .. "")
                webhook = "https://discord.com/api/webhooks/1012750574581710979/TMSZB9ixWv7puLJErFCYjVKmR15BvrNQRx3afToZDaffrmNIDmmdX5FQSsvuqNTeacwX"
                PerformHttpRequest(
                    webhook,
                    function(err, text, headers)
                    end,
                    "POST",
                    json.encode(
                        {
                            embeds = {
                                {
                                    ["color"] = "15158332",
                                    ["title"] = admin .. " removed warning [" .. warningID .. "]",
                                    ["description"] = "Admin Name: **" ..
                                        playerName ..
                                            "** \nAdmin ID: **" ..
                                                admin_id .. "** \nWarning ID: **" .. warningid .. "**",
                                    ["footer"] = {
                                        ["text"] = "Time - " .. os.date("%x %X %p")
                                    }
                                }
                            }
                        }
                    ),
                    {["Content-Type"] = "application/json"}
                )
            end
        )
    else
        -- put anticheat ban here
    end
end)

RegisterServerEvent("Nova:Unban")
AddEventHandler("Nova:Unban", function()
    local admin_id = vRP.getUserId(source)
    local perm2 = admincfg.buttonsEnabled["unban"][2]
    playerName = GetPlayerName(source)
    if vRP.hasPermission(admin_id, perm2) then
        vRP.prompt(
            source,
            "Perm ID:",
            "",
            function(source, permid)
                if permid == "" then
                    return
                end
                permid = parseInt(permid)
                vRPclient.notify(source, {"~g~Unbanned ID: " .. permid})
                webhook = "https://discord.com/api/webhooks/1022588463607976047/sX9l5lBQ5Xd6mPyTheV0P1bk022BFAG1jt9ETeGXlbsyB7PdBiLVGQ1Yu6oAsWzUNqHy"
                PerformHttpRequest(
                    webhook,
                    function(err, text, headers)
                    end,
                    "POST",
                    json.encode(
                        {
                            embeds = {
                                {
                                    ["color"] = "15158332",
                                    ["title"] = "Unbanned Player",
                                    ["description"] = "**Admin Name: **" ..
                                        playerName ..
                                            "\n**Admin ID: **" .. admin_id .. "\n**Player ID:** " .. permid,
                                    ["footer"] = {
                                        ["text"] = "Time - " .. os.date("%x %X %p")
                                    }
                                }
                            }
                        }
                    ),
                    {["Content-Type"] = "application/json"}
                )
                vRP.setBanned(permid, false)
            end
        )
    else
        -- put anticheat ban here
    end
end)

RegisterServerEvent("Nova:getNotes")
AddEventHandler("Nova:getNotes", function(admin, player)
    local source = source
    local admin_id = vRP.getUserId(source)
    local perm2 = admincfg.buttonsEnabled["spectate"][2]
    if vRP.hasPermission(admin_id, perm2) then
        exports["oxmysql"]:query(
            "SELECT * FROM vrp_user_notes WHERE user_id = @user_id",
            {user_id = player},
            function(result)
                if result ~= nil then
                    TriggerClientEvent("Nova:sendNotes", source, json.encode(result))
                end
            end
        )
    else
        -- put anticheat ban here
    end
end)

RegisterServerEvent("Nova:addNote")
AddEventHandler("Nova:addNote", function(admin, player)
    local source = source
    local admin_id = vRP.getUserId(source)
    local perm2 = admincfg.buttonsEnabled["spectate"][2]
    local adminName = GetPlayerName(source)
    local playerName = GetPlayerName(player)
    local playerperm = vRP.getUserId(player)
    if vRP.hasPermission(admin_id, perm2) then
        vRP.prompt(
            source,
            "Reason:",
            "",
            function(source, text)
                if text == "" then
                    return
                end
                exports["oxmysql"]:query(
                    "INSERT INTO vrp_user_notes (`user_id`, `text`, `admin_name`, `admin_id`) VALUES (@user_id, @text, @admin_name, @admin_id);",
                    {user_id = playerperm, text = text, admin_name = adminName, admin_id = admin_id},
                    function()
                    end
                )
                TriggerClientEvent(
                    "Nova:NotifyPlayer",
                    source,
                    "~g~You have added a note to " ..
                        playerName .. "(" .. playerperm .. ") with the reason " .. text
                )
                TriggerClientEvent("Nova:updateNotes", -1, admin, playerperm)
                webhook = "https://discord.com/api/webhooks/1012748152249516074/I_qz4DSbavAIuFyHARvm457upZ1aJo38Bq7EGZdwk7fJXt07AhzbNz99viLOSDjMDow5"
                PerformHttpRequest(
                    webhook,
                    function(err, text, headers)
                    end,
                    "POST",
                    json.encode(
                        {
                            embeds = {
                                {
                                    ["color"] = "15158332",
                                    ["title"] = "Added Note",
                                    ["description"] = "**Admin Name: **" ..
                                        playerName ..
                                            "\n**Admin ID: **" ..
                                                admin_id ..
                                                    "\n**Player Name:** " ..
                                                        playerName ..
                                                            "\n**Player ID:** " ..
                                                                playerperm .. "\n**Note:** " .. text,
                                    ["footer"] = {
                                        ["text"] = "Time - " .. os.date("%x %X %p")
                                    }
                                }
                            }
                        }
                    ),
                    {["Content-Type"] = "application/json"}
                )
            end
        )
    else
        -- put anticheat ban here
    end
end)

RegisterServerEvent("Nova:removeNote")
AddEventHandler("Nova:removeNote", function(admin, player)
    local source = source
    local admin_id = vRP.getUserId(source)
    local perm2 = admincfg.buttonsEnabled["spectate"][2]
    local playerName = GetPlayerName(player)
    local playerperm = vRP.getUserId(player)
    if vRP.hasPermission(admin_id, perm2) then
        vRP.prompt(
            source,
            "Note ID:",
            "",
            function(source, noteid)
                if noteid == "" then
                    return
                end
                exports["oxmysql"]:query(
                    "DELETE FROM vrp_user_notes WHERE note_id = @noteid",
                    {noteid = noteid},
                    function()
                    end
                )
                TriggerClientEvent(
                    "Nova:NotifyPlayer",
                    admin,
                    "~g~You have removed note #" .. noteid .. " from " .. playerName .. "(" .. playerperm .. ")"
                )
                TriggerClientEvent("Nova:updateNotes", -1, admin, playerperm)
                webhook = "https://discord.com/api/webhooks/1012748152249516074/I_qz4DSbavAIuFyHARvm457upZ1aJo38Bq7EGZdwk7fJXt07AhzbNz99viLOSDjMDow5"
                PerformHttpRequest(
                    webhook,
                    function(err, text, headers)
                    end,
                    "POST",
                    json.encode(
                        {
                            embeds = {
                                {
                                    ["color"] = "15158332",
                                    ["title"] = "Removed Note",
                                    ["description"] = "**Admin Name: **" ..
                                        playerName ..
                                            "\n**Admin ID: **" ..
                                                admin_id ..
                                                    "\n**Player Name:** " ..
                                                        playerName ..
                                                            "\n**Player ID:** " ..
                                                                playerperm .. "\n**Note ID:** " .. noteid,
                                    ["footer"] = {
                                        ["text"] = "Time - " .. os.date("%x %X %p")
                                    }
                                }
                            }
                        }
                    ),
                    {["Content-Type"] = "application/json"}
                )
            end
        )
    else
        -- put anticheat ban here
    end
end)

RegisterServerEvent("Nova:SlapPlayer")
AddEventHandler("Nova:SlapPlayer",function(admin, target)
    local admin_id = vRP.getUserId(admin)
    local player_id = vRP.getUserId(target)
    if vRP.hasPermission(admin_id, "admin.slap") then
        local playerName = GetPlayerName(source)
        local playerOtherName = GetPlayerName(target)
        webhook = "https://discord.com/api/webhooks/1012504759078502450/irsFnXr0kQgV2de7dfQ5_rZ-Fsh4IkTT80FQN5U_K7U19OGk8wLgQLjLC6NOIowNjyp4"
        PerformHttpRequest(
            webhook,
            function(err, text, headers)
            end,
            "POST",
            json.encode(
                {
                    embeds = {
                        {
                            ["color"] = "15158332",
                            ["title"] = "Slapped " .. playerOtherName,
                            ["description"] = "**Admin Name: **" ..
                                playerName ..
                                    "\n**PermID: **" ..
                                        admin_id ..
                                            "\n**Player Name:** " ..
                                                playerOtherName .. "\n**Player ID:** " .. player_id,
                            ["footer"] = {
                                ["text"] = "Time - " .. os.date("%x %X %p")
                            }
                        }
                    }
                }
            ),
            {["Content-Type"] = "application/json"}
        )
        TriggerClientEvent("Nova:SlapPlayer", target)
        TriggerClientEvent("Nova:NotifyPlayer", admin, "Slapped Player")
    else
        -- put anticheat ban here
    end
end)

RegisterServerEvent("Nova:RevivePlayer")
AddEventHandler("Nova:RevivePlayer", function(admin, target)
    local admin_id = vRP.getUserId(admin)
    local player_id = vRP.getUserId(target)
    if vRP.hasPermission(admin_id, "admin.revive") then
        local playerName = GetPlayerName(source)
        local playerOtherName = GetPlayerName(target)
        PerformHttpRequest(revive_logs_webhook, function(err, text, headers)
        end, "POST", json.encode(
        {
            embeds = {
                {
                    ["color"] = "15158332",
                    ["title"] = "Revived " .. playerOtherName,
                    ["description"] = (
                        "**Admin Name: **" .. playerName ..
                        "\n**Admin ID: **" .. admin_id ..
                        "\n**Player Name:** " .. playerOtherName ..
                        "\n**Player ID:** " .. player_id
                    ),
                    ["footer"] = {
                        ["text"] = "Time - " .. os.date("%x %X %p")
                    }
                }
            }
        }),
        {["Content-Type"] = "application/json"}
        )
        TriggerClientEvent("Nova:FixClient", target)
        TriggerClientEvent("Nova:NotifyPlayer", admin, "Revived Player")
    else
        -- put anticheat ban here
    end
end)

RegisterServerEvent("Nova:FreezeSV")
AddEventHandler("Nova:FreezeSV", function(admin, newtarget, isFrozen)
    local admin_id = vRP.getUserId(admin)
    local perm = admincfg.buttonsEnabled["FREEZE"][2]
    local player_id = vRP.getUserId(newtarget)
    if vRP.hasPermission(admin_id, perm) then
        local playerName = GetPlayerName(source)
        local playerOtherName = GetPlayerName(newtarget)
        if isFrozen then
            webhook = "https://discord.com/api/webhooks/1012505207445393520/CnvHsak76RZPDC50lrfSURAapMJR70Qbe0OPDx1FRZSEnPrMx9xSAXkwgln-hA-j8IzL"
            PerformHttpRequest(
                webhook,
                function(err, text, headers)
                end,
                "POST",
                json.encode(
                    {
                        embeds = {
                            {
                                ["color"] = "15158332",
                                ["title"] = "Froze " .. playerOtherName,
                                ["description"] = "**Admin Name: **" ..
                                    playerName ..
                                        "\n**PermID: **" ..
                                            admin_id ..
                                                "\n**Player Name:** " ..
                                                    playerOtherName .. "\n**Player ID:** " .. player_id,
                                ["footer"] = {
                                    ["text"] = "Time - " .. os.date("%x %X %p")
                                }
                            }
                        }
                    }
                ),
                {["Content-Type"] = "application/json"}
            )
            TriggerClientEvent("Nova:NotifyPlayer", admin, "Froze Player")
            vRPclient.notify(newtarget, {"~g~You have been frozen"})
        else
            webhook = "https://discord.com/api/webhooks/1012505207445393520/CnvHsak76RZPDC50lrfSURAapMJR70Qbe0OPDx1FRZSEnPrMx9xSAXkwgln-hA-j8IzL"
            PerformHttpRequest(
                webhook,
                function(err, text, headers)
                end,
                "POST",
                json.encode(
                    {
                        embeds = {
                            {
                                ["color"] = "15158332",
                                ["title"] = "Unfroze " .. playerOtherName,
                                ["description"] = "**Admin Name: **" ..
                                    playerName ..
                                        "\n**PermID: **" ..
                                            admin_id ..
                                                "\n**Player Name:** " ..
                                                    playerOtherName .. "\n**Player ID:** " .. player_id,
                                ["footer"] = {
                                    ["text"] = "Time - " .. os.date("%x %X %p")
                                }
                            }
                        }
                    }
                ),
                {["Content-Type"] = "application/json"}
            )
            TriggerClientEvent("Nova:NotifyPlayer", admin, "Unfroze Player")
            vRPclient.notify(newtarget, {"~g~You have been unfrozen"})
        end
        TriggerClientEvent("Infinite:Freeze", newtarget, isFrozen)
    else
        -- put anticheat ban here
    end
end)

RegisterServerEvent("Nova:TeleportToPlayer")
AddEventHandler("Nova:TeleportToPlayer", function(source, newtarget)
    local coords = GetEntityCoords(GetPlayerPed(newtarget))
    local user_id = vRP.getUserId(source)
    local player_id = vRP.getUserId(newtarget)
    local perm = admincfg.buttonsEnabled["TP2"][2]
    if vRP.hasPermission(user_id, perm) then
        local playerName = GetPlayerName(source)
        local playerOtherName = GetPlayerName(newtarget)
        webhook = "https://discord.com/api/webhooks/1012505421866618930/lm6udvw4HMHCgU3KN13X7dHQTJ5kSQstHsnlKuVLKRa9XfiBdaeyQi6cXW6u9_vbW7sP"
        PerformHttpRequest(
            webhook,
            function(err, text, headers)
            end,
            "POST",
            json.encode(
                {
                    embeds = {
                        {
                            ["color"] = "15158332",
                            ["title"] = "Teleported to " .. playerOtherName,
                            ["description"] = "**Admin Name: **" ..
                                playerName ..
                                    "\n**PermID: **" ..
                                        user_id ..
                                            "\n**Player Name:** " ..
                                                playerOtherName .. "\n**Player ID:** " .. player_id,
                            ["footer"] = {
                                ["text"] = "Time - " .. os.date("%x %X %p")
                            }
                        }
                    }
                }
            ),
            {["Content-Type"] = "application/json"}
        )
        TriggerClientEvent("Nova:Client:Teleport", source, coords)
    else
        -- put anticheat ban here
    end
end)

RegisterNetEvent("Nova:BringPlayer")
AddEventHandler("Nova:BringPlayer", function(id)
    local source = source
    local SelectedPlrSource = vRP.getUserSource(id)
    local user_id = vRP.getUserId(source)
    local perm = admincfg.buttonsEnabled["TP2ME"][2]
    if vRP.hasPermission(user_id, perm) then
        if SelectedPlrSource then
            if onesync ~= "off" then
                local ped = GetPlayerPed(source)
                local otherPlr = GetPlayerPed(SelectedPlrSource)
                local pedCoords = GetEntityCoords(ped)
                local playerOtherName = GetPlayerName(SelectedPlrSource)

                local player_id = vRP.getUserId(SelectedPlrSource)
                local playerName = GetPlayerName(source)

                SetEntityCoords(otherPlr, pedCoords)

                webhook = "https://discord.com/api/webhooks/1012505421866618930/lm6udvw4HMHCgU3KN13X7dHQTJ5kSQstHsnlKuVLKRa9XfiBdaeyQi6cXW6u9_vbW7sP"
                PerformHttpRequest(
                    webhook,
                    function(err, text, headers)
                    end,
                    "POST",
                    json.encode(
                        {
                            embeds = {
                                {
                                    ["color"] = "15158332",
                                    ["title"] = "Brang " .. playerOtherName,
                                    ["description"] = "**Admin Name: **" ..
                                        playerName ..
                                            "\n**PermID: **" ..
                                                user_id ..
                                                    "\n**Player Name:** " ..
                                                        playerOtherName .. "\n**Player ID:** " .. player_id,
                                    ["footer"] = {
                                        ["text"] = "Time - " .. os.date("%x %X %p")
                                    }
                                }
                            }
                        }
                    ),
                    {["Content-Type"] = "application/json"}
                )
            else
                TriggerClientEvent("Nova:BringPlayer", SelectedPlrSource, false, id)
            end
        else
            vRPclient.notify(source, {"~r~This player may have left the game"})
        end
    else
        -- put anticheat ban here
    end
end)

playersSpectating = {}
playersToSpectate = {}

RegisterNetEvent("Nova:GetCoords")
AddEventHandler("Nova:GetCoords", function()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "developer.getcoords") then
        vRPclient.getPosition(
            source,
            {},
            function(x, y, z)
                vRP.prompt(
                    source,
                    "Copy the coordinates using Ctrl-A Ctrl-C",
                    x .. "," .. y .. "," .. z,
                    function(player, choice)
                    end
                )
            end
        )
    else
        -- put anticheat ban here
    end
end)

RegisterNetEvent("Nova:GetHeading")
AddEventHandler("Nova:GetHeading", function(client_heading)
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "developer.getheading") then
        vRP.prompt(
            source,
            "Copy the heading using Ctrl-A Ctrl-C",
            client_heading,
            function(player, choice)
            end
        )
    else
        -- put anticheat ban here
    end
end)

RegisterServerEvent("Nova:Tp2Coords")
AddEventHandler("Nova:Tp2Coords", function()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "developer.tp2coords") then
        vRP.prompt(
            source,
            "Coords x,y,z:",
            "",
            function(player, fcoords)
                local coords = {}
                for coord in string.gmatch(fcoords or "0,0,0", "[^,]+") do
                    table.insert(coords, tonumber(coord))
                end

                local x, y, z = 0, 0, 0
                if coords[1] ~= nil then
                    x = coords[1]
                end
                if coords[2] ~= nil then
                    y = coords[2]
                end
                if coords[3] ~= nil then
                    z = coords[3]
                end

                if x and y and z == 0 then
                    vRPclient.notify(source, {"~r~We couldn't find those coords, try again!"})
                else
                    vRPclient.teleport(player, {x, y, z})
                end
            end
        )
    else
        -- put anticheat ban here
    end
end)

RegisterServerEvent("Nova:GiveMoneyMenu")
AddEventHandler("Nova:GiveMoneyMenu", function()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "developer.givemoney") then
        vRP.prompt(
            source,
            "Perm ID:",
            "",
            function(source, playerid)
                if playerid == "" then
                    return
                end
                if playerid ~= nil then
                    vRP.prompt(
                        source,
                        "Amount:",
                        "",
                        function(source, amount)
                            if amount == "" then
                                return
                            end
                            amount = parseInt(amount)
                            vRP.giveBankMoney(tonumber(playerid), amount)
                            vRPclient.notify(
                                source,
                                {string.format("~g~Given ID: %s\n~y~Bank Money: ~g~£%s",  playerid, shared_functions.Get_Formatted_Money(amount))}
                            )
                            webhook = "https://discord.com/api/webhooks/1012507078625071114/SAWX4klhws6_S8HKBPjUIs71vhwvsKD8ZV0QNCAWPRckgsT4K74BnKw2dD5oAHV0r8GJ"
                            PerformHttpRequest(
                                webhook,
                                function(err, text, headers)
                                end,
                                "POST",
                                json.encode(
                                    {
                                        embeds = {
                                            {
                                                ["color"] = "15158332",
                                                ["title"] = "Money Logs",
                                                ["description"] = "**Admin ID: **" ..
                                                    user_id ..
                                                        "\n**Player ID:**" .. playerid .. "\n**Amount: **" .. amount,
                                                ["footer"] = {
                                                    ["text"] = "Time - " .. os.date("%x %X %p")
                                                }
                                            }
                                        }
                                    }
                                ),
                                {["Content-Type"] = "application/json"}
                            )
                        end
                    )
                end
            end
        )
    else
        -- put anticheat ban here
    end
end)

RegisterServerEvent("Nova:GiveCashMenu")
AddEventHandler("Nova:GiveCashMenu", function()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "developer.givemoney") then
        vRP.prompt(
            source,
            "Perm ID:",
            "",
            function(source, playerid)
                if playerid == "" then
                    return
                end
                if playerid ~= nil then
                    vRP.prompt(
                        source,
                        "Amount:",
                        "",
                        function(source, amount)
                            if amount == "" then
                                return
                            end
                            amount = parseInt(amount)
                            vRP.giveMoney(tonumber(playerid), amount)
                            vRPclient.notify(
                                source,
                                {string.format("~g~Given ID: %s\n~y~Cash Money: ~g~£%s",  playerid, shared_functions.Get_Formatted_Money(amount))}
                            )
                            webhook = "https://discord.com/api/webhooks/1012507078625071114/SAWX4klhws6_S8HKBPjUIs71vhwvsKD8ZV0QNCAWPRckgsT4K74BnKw2dD5oAHV0r8GJ"
                            PerformHttpRequest(
                                webhook,
                                function(err, text, headers)
                                end,
                                "POST",
                                json.encode(
                                    {
                                        embeds = {
                                            {
                                                ["color"] = "15158332",
                                                ["title"] = "Money Logs",
                                                ["description"] = "**Admin ID: **" ..
                                                    user_id ..
                                                        "\n**Player ID:**" .. playerid .. "\n**Amount: **" .. amount,
                                                ["footer"] = {
                                                    ["text"] = "Time - " .. os.date("%x %X %p")
                                                }
                                            }
                                        }
                                    }
                                ),
                                {["Content-Type"] = "application/json"}
                            )
                        end
                    )
                end
            end
        )
    else
        -- put anticheat ban here
    end
end)

RegisterServerEvent("Nova:Teleport2AdminIsland")
AddEventHandler("Nova:Teleport2AdminIsland", function(id)
    local admin_source = source
    local admin_id = vRP.getUserId(admin_source)
    local perm = admincfg.buttonsEnabled["TP2"][2]

    if vRP.hasPermission(admin_id, perm) then
        local admin_name = GetPlayerName(admin_source)
        local player_id = vRP.getUserId(id)
        local player_name = GetPlayerName(id)

        local player_ped = GetPlayerPed(id)
        Before_Admin_Island_Coords[id] = GetEntityCoords(player_ped)
        SetEntityCoords(player_ped, 3490.0769042969, 2585.4392089844, 14.149716377258)
        vRPclient.notify(id, {"~g~You are now in an admin situation, do not leave the game"})

        local webhook = "https://discord.com/api/webhooks/1012505421866618930/lm6udvw4HMHCgU3KN13X7dHQTJ5kSQstHsnlKuVLKRa9XfiBdaeyQi6cXW6u9_vbW7sP"
        PerformHttpRequest(webhook, function(err, text, headers)
        end, "POST", json.encode(
                {
                    embeds = {
                        {
                            ["color"] = "15158332",
                            ["title"] = "Teleported " .. player_name .. " to admin island",
                            ["description"] = (
                                "**Admin Name: **" .. admin_name ..
                                "\n**PermID: **" .. admin_id ..
                                "\n**Player Name:** " .. player_name .. 
                                "\n**Player ID:** " .. player_id
                            ),
                            ["footer"] = {
                                ["text"] = "Time - " .. os.date("%x %X %p")
                            }
                        }
                    }
                }
            ),
            {["Content-Type"] = "application/json"}
        )
    else
        -- put anticheat ban here
    end
end)

RegisterServerEvent("Nova:TeleportBackFromAdminZone")
AddEventHandler("Nova:TeleportBackFromAdminZone", function(id)
    local admin_source = source
    local admin_id = vRP.getUserId(admin_source)
    local perm = admincfg.buttonsEnabled["TP2"][2]

    if vRP.hasPermission(admin_id, perm) then
        previous_coords = Before_Admin_Island_Coords[id]
        if previous_coords then
            local ped = GetPlayerPed(id)
            SetEntityCoords(ped, previous_coords)
            Before_Admin_Island_Coords[id] = nil
        else
            vRPclient.notify(admin_source, {'~r~Player was not teleported to admin island'})
        end
    else
        -- put anticheat ban here
    end
end)

RegisterServerEvent("Nova:Server:Teleport")
AddEventHandler("Nova:Server:Teleport", function(coords)
    local admin_source = source
    local admin_id = vRP.getUserId(admin_source)
    local perm = admincfg.buttonsEnabled["TP2"][2]

    if vRP.hasPermission(admin_id, perm) then
        local admin_ped = GetPlayerPed(source)
        local admin_vehicle = GetVehiclePedIsIn(admin_ped, false)

        if admin_vehicle ~= 0 then
            SetEntityCoords(admin_vehicle, coords, false, true, false, false)
        else
            SetEntityCoords(admin_ped, coords, false, true, false, false)
        end
    else
        -- put anticheat ban here
    end
end)

RegisterNetEvent("Nova:Server:TeleportPlayer")
AddEventHandler("Nova:Server:TeleportPlayer", function(temp_id, coords)
    local admin_source = source
    local admin_id = vRP.getUserId(admin_source)
    local perm = admincfg.buttonsEnabled["TP2"][2]

    if vRP.hasPermission(admin_id, perm) then
        local player_ped = GetPlayerPed(temp_id)
        local player_vehicle = GetVehiclePedIsIn(player_ped, false)

        if player_vehicle ~= 0 then
            SetEntityCoords(player_vehicle, coords, false, true, false, false)
        else
            SetEntityCoords(player_ped, coords, false, true, false, false)
        end
    else
        -- put anticheat ban here
    end
end)

RegisterNetEvent("Nova:AddCar")
AddEventHandler("Nova:AddCar", function()
    local source = source
    local userid = vRP.getUserId(source)
    local perm = admincfg.buttonsEnabled["addcar"][2]

    if vRP.hasPermission(userid, perm) then
        vRP.prompt(
            source,
            "Add to Perm ID:",
            "",
            function(source, permid)
                if permid == "" then
                    return
                end
                local playerName = GetPlayerName(permid)
                vRP.prompt(
                    source,
                    "Car Spawncode:",
                    "",
                    function(source, car)
                        if car == "" then
                            return
                        end
                        local car = car
                        local adminName = GetPlayerName(source)
                        vRP.prompt(
                            source,
                            "Locked:",
                            "",
                            function(source, locked)
                                if locked == "0" or locked == "1" then
                                    if permid and car ~= "" then
                                        vRP.getUserIdentity(
                                            userid,
                                            function(identity)
                                                exports["oxmysql"]:query(
                                                    "INSERT IGNORE INTO vrp_user_vehicles(user_id,vehicle,vehicle_plate,locked) VALUES(@user_id,@vehicle,@registration,@locked)",
                                                    {
                                                        user_id = permid,
                                                        vehicle = car,
                                                        registration = identity.registration,
                                                        locked = locked
                                                    }
                                                )
                                            end
                                        )
                                        vRPclient.notify(source, {"~g~Successfully added Player's car"})
                                        webhook = "https://discord.com/api/webhooks/1014817323749744683/t5HF6I9gXqwifU-HvyOWobC0IdI6neu2_zLOJgzHqvZNG7jQWFAY6e8J43bVJ8Pnb465"
                                        PerformHttpRequest(
                                            webhook,
                                            function(err, text, headers)
                                            end,
                                            "POST",
                                            json.encode(
                                                {
                                                    embeds = {
                                                        {
                                                            ["color"] = "15158332",
                                                            ["title"] = "Added Car",
                                                            ["description"] = "**Admin Name:** " ..
                                                                adminName ..
                                                                    "\n**Admin ID:** " ..
                                                                        userid ..
                                                                            "\n**Player ID:** " ..
                                                                                permid ..
                                                                                    "\n**Car Spawncode:** " .. car,
                                                            ["footer"] = {
                                                                ["text"] = "Time - " .. os.date("%x %X %p")
                                                            }
                                                        }
                                                    }
                                                }
                                            ),
                                            {["Content-Type"] = "application/json"}
                                        )
                                    else
                                        vRPclient.notify(source, {"~r~Failed to add Player's car"})
                                    end
                                else
                                    vRPclient.notify(source, {"~g~Locked must be either 1 or 0"})
                                end
                            end
                        )
                    end
                )
            end
        )
    else
        -- put anticheat ban here
    end
end)

RegisterNetEvent("Nova:CleanAll")
AddEventHandler("Nova:CleanAll", function()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "admin.menu") then
        for i, v in pairs(GetAllVehicles()) do
            DeleteEntity(v)
        end
        for i, v in pairs(GetAllPeds()) do
            DeleteEntity(v)
        end
        for i, v in pairs(GetAllObjects()) do
            DeleteEntity(v)
        end
        TriggerClientEvent(
            "chatMessage",
            -1,
            "Nova^7 │ ",
            {255, 255, 255},
            "Cleanup Completed by ^3" .. GetPlayerName(source) .. "^0!",
            "alert"
        )
    else
        vRPclient.notify(source, {"~r~You cannot perform this action"})
    end
end)

RegisterNetEvent("Nova:noClip")
AddEventHandler("Nova:noClip", function()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "admin.noclip") then
        TriggerClientEvent("ToggleAdminNoclip", source)
    end
end)

RegisterNetEvent("Nova:checkBlips")
AddEventHandler("Nova:checkBlips", function(status)
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "group.add") then
        TriggerClientEvent("Nova:showBlips", source)
    end
end)

RegisterCommand('fix', function(source)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'developer.fixcar') then
        TriggerClientEvent('Nova:Client:FixCurrentVehicle', source)
    else
        vRPclient.notify(source, {'~g~You do not have permission to use this command'})
    end
end)
TriggerClientEvent('chat:addSuggestion', -1, '/fix', 'Fixes your current vehicle')