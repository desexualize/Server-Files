
admincfg = {}

admincfg.perm = "admin.tickets"
admincfg.IgnoreButtonPerms = false
admincfg.admins_cant_ban_admins = false


--[[ {enabled -- true or false}, permission required ]]
admincfg.buttonsEnabled = {

    --[[ admin Menu ]]
    ["adminMenu"] = {true, "admin.tickets"},
    ["warn"] = {true, "admin.warn"},      
    ["showwarn"] = {true, "admin.showwarn"},
    ["ban"] = {true, "admin.ban"},
    ["unban"] = {true, "admin.unban"},
    ["kick"] = {true, "admin.kick"},
    ["revive"] = {true, "admin.revive"},
    ["armour"] = {true, "admin.special"},
    ["TP2"] = {true, "admin.tp2player"},
    ["TP2ME"] = {true, "admin.summon"},
    ["FREEZE"] = {true, "admin.freeze"},
    ["spectate"] = {true, "admin.spectate"}, 
    ["SS"] = {true, "admin.screenshot"},
    ["slap"] = {true, "admin.slap"},
    ["giveMoney"] = {true, "admin.givemoney"},
    ["addcar"] = {true, "admin.addcar"},

    --[[ Functions ]]
    ["tp2waypoint"] = {true, "admin.tp2waypoint"},
    ["tp2coords"] = {true, "admin.tp2coords"},
    ["removewarn"] = {true, "admin.removewarn"},
    ["spawnBmx"] = {true, "admin.spawnBmx"},
    ["spawnGun"] = {true, "admin.spawnGun"},

    --[[ Add Groups ]]
    ["getgroups"] = {true, "group.add"},
    ["staffGroups"] = {true, "admin.staffAddGroups"},
    ["mpdGroups"] = {true, "admin.mpdAddGroups"},
    ["povGroups"] = {true, "admin.povAddGroups"},
    ["licenseGroups"] = {true, "admin.licenseAddGroups"},
    ["donoGroups"] = {true, "admin.donoAddGroups"},
    ["nhsGroups"] = {true, "admin.nhsAddGroups"},

    --[[ Vehicle Functions ]]
    ["vehFunctions"] = {true, "admin.vehmenu"},
    ["noClip"] = {true, "admin.noclip"},

    -- [[ Developer Functions ]]
    ["devMenu"] = {true, "dev.menu"},
}


RegisterServerEvent('GMT:OpenSettings')
AddEventHandler('GMT:OpenSettings', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id ~= nil and vRP.hasPermission(user_id, "admin.menu") then
        TriggerClientEvent("GMT:OpenSettingsMenu", source, true)
    else
        TriggerClientEvent("GMT:OpenSettingsMenu", source, false)
    end
end)

RegisterServerEvent("GMT:GetPlayerData")
AddEventHandler("GMT:GetPlayerData",function()
    local source = source
    user_id = vRP.getUserId(source)
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
                PlayerTimeInHours = playtime/60
                if PlayerTimeInHours < 1 then
                    PlayerTimeInHours = 0
                end
                players_table[user_idz] = {name, p, user_idz, math.ceil(PlayerTimeInHours)}
                table.insert(useridz, user_idz)
            else
                DropPlayer(p, "GMT - The server was unable to cache your ID, please rejoin.")
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
        TriggerClientEvent("GMT:SendPlayerInfo", source, players_table, menu_btns_table)
    end
end)


RegisterCommand("gethours", function(source, args)
    local v = source
    local UID = vRP.getUserId(v)
    local D = math.ceil(vRP.getUserDataTable(UID).PlayerTime/60) or 0
    if UID then
            vRPclient.notify(v,{"~g~You currently have ~b~"..D.." ~g~hours."})
    end
end)


RegisterCommand("sethours", function(source, args) if source == 0 then data = vRP.getUserDataTable(tonumber(args[1])); data.PlayerTime = tonumber(args[2])*60; print(GetPlayerName(vRP.getUserSource(tonumber(args[1]))).."'s hours have been set to: "..tonumber(args[2]))end  end)

RegisterNetEvent("GMT:GetNearbyPlayers")
AddEventHandler("GMT:GetNearbyPlayers", function(dist)
    local source = source
    local user_id = vRP.getUserId(source)
    local plrTable = {}

    if vRP.hasPermission(user_id, admincfg.perm) then
        vRPclient.getNearestPlayers(source, {dist}, function(nearbyPlayers)
            for k, v in pairs(nearbyPlayers) do
                data = vRP.getUserDataTable(vRP.getUserId(k))
                playtime = data.PlayerTime or 0
                PlayerTimeInHours = playtime/60
                if PlayerTimeInHours < 1 then
                    PlayerTimeInHours = 0
                end
                plrTable[vRP.getUserId(k)] = {GetPlayerName(k), k, vRP.getUserId(k), math.ceil(PlayerTimeInHours)}
            end
            TriggerClientEvent("GMT:ReturnNearbyPlayers", source, plrTable)
        end)
    end
end)


RegisterServerEvent("GMT:GetGroups")
AddEventHandler("GMT:GetGroups",function(temp, perm)
    local user_groups = vRP.getUserGroups(perm)
    TriggerClientEvent("GMT:GotGroups", source, user_groups)
end)

RegisterServerEvent("GMT:CheckPov")
AddEventHandler("GMT:CheckPov",function(userperm)
    --print(userperm)
    local user_id = vRP.getUserId(source)
  
    if vRP.hasPermission(user_id, "admin.menu") then
        if vRP.hasPermission(userperm, 'pov.list') then
            TriggerClientEvent('GMT:ReturnPov', source, true)
        elseif not vRP.hasPermission(userperm, 'pov.list') then
            TriggerClientEvent('GMT:ReturnPov', source, false)
        end
    else 
     end
    
end)


RegisterServerEvent("other:deletevehicle")
AddEventHandler("other:deletevehicle",function()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'police.armoury') or vRP.hasPermission(user_id, 'dev.menu')then
        TriggerClientEvent('wk:deleteVehicle', source)
    end
end)

RegisterServerEvent("wk:fixVehicle")
AddEventHandler("wk:fixVehicle",function()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'admin.noclip') then
        TriggerClientEvent('wk:fixVehicle', source)
    end
end)

RegisterServerEvent("admin:cancelRent")
AddEventHandler("admin:cancelRent",function()
    local source = source
    local user_id = vRP.getUserId(source)
    local originalOwner = ''
    if vRP.hasPermission(user_id, 'admin.noclip') then
        vRP.prompt(source,"Current Owner:","",function(source, currentOwner)
            if currentOwner == '' then return end
            local currentOwner = currentOwner
            vRP.prompt(source,"Spawncode:","",function(source, spawncode)
                local spawncode = spawncode
                if spawncode == '' then return end
                exports['ghmattimysql']:execute("SELECT * FROM `vrp_user_vehicles` WHERE user_id = @user_id", {user_id = currentOwner}, function(result)
                    if result ~= nil then 
                        for k, v in pairs(result) do
                            if v.user_id == tonumber(currentOwner) and v.vehicle == spawncode then
                                originalOwner = v.rentedid
                                exports['ghmattimysql']:execute("UPDATE `vrp_user_vehicles` SET user_id = @originalOwner, rented = 0, rentedid = '', rentedtime = '' WHERE user_id = @currentOwner AND vehicle = @spawncode", {currentOwner = currentOwner, originalOwner = tonumber(originalOwner), spawncode = spawncode})
                                vRPclient.notify(source,{"~g~Successfully cancelled rent."})
                            end
                        end
                    end
                end)
            end)
        end)
    end
end)

RegisterServerEvent("GMT:getNotes")
AddEventHandler("GMT:getNotes",function(admin, player)
    local source = source
    local admin_id = vRP.getUserId(source)
    local perm2 = admincfg.buttonsEnabled["spectate"][2]
    if vRP.hasPermission(admin_id, perm2) then
        exports['ghmattimysql']:execute("SELECT * FROM vrp_user_notes WHERE user_id = @user_id", {user_id = player}, function(result) 
            if result ~= nil then
                TriggerClientEvent('GMT:sendNotes', source, json.encode(result))
            end
        end)
    else
        local player = vRP.getUserSource(admin_id)
        local name = GetPlayerName(source)
        Wait(500)
        reason = "Type #11"
        TriggerEvent("GMT:acBan", admin_id, reason, name, player, 'Attempted to Get Notes')
    end
end)

RegisterServerEvent("GMT:addNote")
AddEventHandler("GMT:addNote",function(admin, player)
    local source = source
    local admin_id = vRP.getUserId(source)
    local perm2 = admincfg.buttonsEnabled["spectate"][2]
    local adminName = GetPlayerName(source)
    local playerName = GetPlayerName(player)
    local playerperm = vRP.getUserId(player)
    if vRP.hasPermission(admin_id, perm2) then
        vRP.prompt(source,"Reason:","",function(source,text) 
            if text == '' then return end
            exports['ghmattimysql']:execute("INSERT INTO vrp_user_notes (`user_id`, `text`, `admin_name`, `admin_id`) VALUES (@user_id, @text, @admin_name, @admin_id);", {user_id = playerperm, text = text, admin_name = adminName, admin_id = admin_id}, function() end) 
            TriggerClientEvent('GMT:NotifyPlayer', source, '~g~You have added a note to '..playerName..'('..playerperm..') with the reason '..text)
            TriggerClientEvent('GMT:updateNotes', -1, admin, playerperm)
            local webhook = "https://discord.com/api/webhooks/997193520324546600/OIsfdCb1tXDA_H4wSqyIq0iZ9CknQkJIUN1O_1aCHpvH3kIDgOrhDEmbTUfsg8rSq17_"
            local command = {
                {
                    ["color"] = "3944703",
                    ["title"] = "GMT Group Logs",
                    ["description"] = "",
                    ["text"] = "GMT Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
                    ["fields"] = {
                        {
                            ["name"] = "Admin Name",
                            ["value"] = adminName,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Admin TempID",
                            ["value"] = source,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Admin PermID",
                            ["value"] = admin_id,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Player Name",
                            ["value"] = playerName,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Player TempID",
                            ["value"] = player,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Player PermID",
                            ["value"] = playerperm,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Note Message",
                            ["value"] = text,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Type",
                            ["value"] = "Add",
                            ["inline"] = true
                        }
                    }
                }
            }
            PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "GMT", embeds = command}), { ['Content-Type'] = 'application/json' }) 
        end)
    else
        local player = vRP.getUserSource(admin_id)
        local name = GetPlayerName(source)
        Wait(500)
        reason = "Type #11"
        TriggerEvent("GMT:acBan", admin_id, reason, name, player, 'Attempted to Add Note')
    end
end)

RegisterServerEvent("GMT:removeNote")
AddEventHandler("GMT:removeNote",function(admin, player)
    local source = source
    local admin_id = vRP.getUserId(source)
    local perm2 = admincfg.buttonsEnabled["spectate"][2]
    local playerName = GetPlayerName(player)
    local playerperm = vRP.getUserId(player)
    if vRP.hasPermission(admin_id, perm2) then
        vRP.prompt(source,"Note ID:","",function(source,noteid) 
            if noteid == '' then return end
            exports['ghmattimysql']:execute("DELETE FROM vrp_user_notes WHERE note_id = @noteid", {noteid = noteid}, function() end)
            TriggerClientEvent('GMT:NotifyPlayer', admin, '~g~You have removed note #'..noteid..' from '..playerName..'('..playerperm..')')
            TriggerClientEvent('GMT:updateNotes', -1, admin, playerperm)
            local webhook = "https://discord.com/api/webhooks/997193778672717875/aPs4mpekTvEX1mbAmSdjdMbste0O4dHiwodVGo2ppQHq78bvavWGm_eIlEs1C9aCuULB"
            local command = {
                {
                    ["color"] = "3944703",
                    ["title"] = "GMT Group Logs",
                    ["description"] = "",
                    ["text"] = "GMT Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
                    ["fields"] = {
                        {
                            ["name"] = "Admin Name",
                            ["value"] = GetPlayerName(source),
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Admin TempID",
                            ["value"] = source,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Admin PermID",
                            ["value"] = admin_id,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Player Name",
                            ["value"] = playerName,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Player TempID",
                            ["value"] = player,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Player PermID",
                            ["value"] = playerperm,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Note ID",
                            ["value"] = noteid,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Type",
                            ["value"] = "Remove",
                            ["inline"] = true
                        }
                    }
                }
            }
            PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "GMT", embeds = command}), { ['Content-Type'] = 'application/json' }) 
        end)
    else
        local player = vRP.getUserSource(admin_id)
        local name = GetPlayerName(source)
        Wait(500)
        reason = "Type #11"
        TriggerEvent("GMT:acBan", admin_id, reason, name, player, 'Attempted to Remove Note')
    end
end)


local onesync = GetConvar('onesync', nil)
RegisterNetEvent('GMT:SpectatePlayer')
AddEventHandler('GMT:SpectatePlayer', function(id)
    local source = source 
    local SelectedPlrSource = vRP.getUserSource(id) 
    local userid = vRP.getUserId(source)
    if vRP.hasPermission(userid, "admin.spectate") then
        if SelectedPlrSource then  
            if onesync ~= "off" then 
                local ped = GetPlayerPed(SelectedPlrSource)
                local pedCoords = GetEntityCoords(ped)
                
                TriggerClientEvent('GMT:Spectate', source, SelectedPlrSource, pedCoords)
            else 
                TriggerClientEvent('GMT:Spectate', source, SelectedPlrSource)
            end
        else 
            vRPclient.notify(source,{"~r~This player may have left the game."})
        end
    end
end)

RegisterServerEvent("GMT:Giveweapon")
AddEventHandler("GMT:Giveweapon",function()
    local source = source
    local userid = vRP.getUserId(source)
    if vRP.hasPermission(userid, "dev.menu") then
        vRP.prompt(source,"Weapon Name:","",function(source,hash) 
            TriggerClientEvent("GMT:allowWeaponSpawn", source, hash)
        end)
    end
end)

RegisterServerEvent("GMT:AddGroup")
AddEventHandler("GMT:AddGroup",function(perm, selgroup)
    local admin_temp = source
    local admin_perm = vRP.getUserId(admin_temp)
    local user_id = vRP.getUserId(source)
    local permsource = vRP.getUserSource(perm)
    local playerName = GetPlayerName(source)
    local povName = GetPlayerName(permsource)
    if vRP.hasPermission(user_id, "group.add") then
        if selgroup == "founder" and not vRP.hasPermission(admin_perm, "group.add.founder") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"}) 
        elseif selgroup == "operationsmanager" and not vRP.hasPermission(user_id, "group.add.operationsmanager") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"}) 
        elseif selgroup == "staffmanager" and not vRP.hasPermission(admin_perm, "group.add.staffmanager") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"}) 
        elseif selgroup == "commanager" and not vRP.hasPermission(admin_perm, "group.add.commanager") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"}) 
        elseif selgroup == "headadmin" and not vRP.hasPermission(admin_perm, "group.add.headadmin") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"}) 
        elseif selgroup == "senioradmin" and not vRP.hasPermission(admin_perm, "group.add.senioradmin") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "administrator" and not vRP.hasPermission(admin_perm, "group.add.administrator") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "srmoderator" and not vRP.hasPermission(admin_perm, "group.add.srmoderator") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "moderator" and not vRP.hasPermission(admin_perm, "group.add.moderator") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "supportteam" and not vRP.hasPermission(admin_perm, "group.add.supportteam") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "trialstaff" and not vRP.hasPermission(admin_perm, "group.add.trial") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "vip" and not vRP.hasPermission(admin_perm, "group.add.vip") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "pov" and not vRP.hasGroup(perm, "group.add.pov") then
            local command = {
                {
                    ["color"] = "3944703",
                    ["title"] = "GMT Group Logs",
                    ["description"] = "",
                    ["text"] = "GMT Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
                    ["fields"] = {
                        {
                            ["name"] = "Admin Name",
                            ["value"] = GetPlayerName(source),
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Admin TempID",
                            ["value"] = source,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Admin PermID",
                            ["value"] = user_id,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Player Name",
                            ["value"] = povName,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Player TempID",
                            ["value"] = permsource,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Player PermID",
                            ["value"] = perm,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Group",
                            ["value"] = "POV",
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Type",
                            ["value"] = "Add",
                            ["inline"] = true
                        }
                    }
                }
            }
            local webhook = "https://discord.com/api/webhooks/997193879625404529/ftRxtsks73db65EO46nr_vXAUxWe7drGmmCOQSF6H4f4S4J8pzfJVEs-W7OTXX1BCPeG"
            PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "GMT", embeds = command}), { ['Content-Type'] = 'application/json' }) 
            vRP.addUserGroup(perm, "pov")
        else
            local command = {
                {
                    ["color"] = "3944703",
                    ["title"] = "GMT Group Logs",
                    ["description"] = "",
                    ["text"] = "GMT Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
                    ["fields"] = {
                        {
                            ["name"] = "Admin Name",
                            ["value"] = GetPlayerName(source),
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Admin TempID",
                            ["value"] = source,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Admin PermID",
                            ["value"] = user_id,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Player Name",
                            ["value"] = povName,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Player TempID",
                            ["value"] = permsource,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Player PermID",
                            ["value"] = perm,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Group",
                            ["value"] = selgroup,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Type",
                            ["value"] = "Add",
                            ["inline"] = true
                        }
                    }
                }
            }
            local webhook = "https://discord.com/api/webhooks/997194088585625692/K_x5dCXZ3FN38q1NQN7GiIg0w1fn20yLs--tBLEcqawiT9E2_dZI9Ikw8Qvoy5Mu2gyE"
            PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "GMT", embeds = command}), { ['Content-Type'] = 'application/json' }) 
            vRP.addUserGroup(perm, selgroup)
        end
    else
        print("Stop trying to add a group u fucking cheater")
    end
end)

RegisterServerEvent("GMT:RemoveGroup")
AddEventHandler("GMT:RemoveGroup",function(perm, selgroup)
    local user_id = vRP.getUserId(source)
    local admin_temp = source
    local permsource = vRP.getUserSource(perm)
    local playerName = GetPlayerName(source)
    local povName = GetPlayerName(permsource)
    if vRP.hasPermission(user_id, "group.remove") then
        if selgroup == "founder" and not vRP.hasPermission(user_id, "group.remove.founder") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"}) 
        elseif selgroup == "operationsmanager" and not vRP.hasPermission(user_id, "group.remove.operationsmanager") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"}) 
        elseif selgroup == "staffmanager" and not vRP.hasPermission(user_id, "group.remove.staffmanager") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"}) 
        elseif selgroup == "commanager" and not vRP.hasPermission(user_id, "group.remove.commanager") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"}) 
        elseif selgroup == "headadmin" and not vRP.hasPermission(user_id, "group.remove.headadmin") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"}) 
        elseif selgroup == "senioradmin" and not vRP.hasPermission(user_id, "group.remove.senioradmin") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "administrator" and not vRP.hasPermission(user_id, "group.remove.administrator") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "srmoderator" and not vRP.hasPermission(user_id, "group.remove.srmoderator") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "moderator" and not vRP.hasPermission(user_id, "group.remove.moderator") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "supportteam" and not vRP.hasPermission(user_id, "group.remove.supportteam") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "trialstaff" and not vRP.hasPermission(user_id, "group.remove.trial") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "vip" and not vRP.hasPermission(user_id, "group.remove.vip") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "pov" and vRP.hasGroup(perm, "group.remove.pov") then
            local command = {
                {
                    ["color"] = "3944703",
                    ["title"] = "GMT Group Logs",
                    ["description"] = "",
                    ["text"] = "GMT Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
                    ["fields"] = {
                        {
                            ["name"] = "Admin Name",
                            ["value"] = GetPlayerName(source),
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Admin TempID",
                            ["value"] = source,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Admin PermID",
                            ["value"] = user_id,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Player Name",
                            ["value"] = povName,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Player TempID",
                            ["value"] = permsource,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Player PermID",
                            ["value"] = perm,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Group",
                            ["value"] = "POV",
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Type",
                            ["value"] = "Remove",
                            ["inline"] = true
                        }
                    }
                }
            }
            local webhook = "https://discord.com/api/webhooks/997194985751457843/xaLlqcpv7p4OZaDQ6jjjdTiCJQjtSSI2pEyeT8Ic6qjXeLWOClo2-OJZLknh_M4pCpWC"
            PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "GMT", embeds = command}), { ['Content-Type'] = 'application/json' }) 
            vRP.removeUserGroup(perm, "pov")
        else
            local command = {
                {
                    ["color"] = "3944703",
                    ["title"] = "GMT Group Logs",
                    ["description"] = "",
                    ["text"] = "GMT Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
                    ["fields"] = {
                        {
                            ["name"] = "Admin Name",
                            ["value"] = GetPlayerName(source),
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Admin TempID",
                            ["value"] = source,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Admin PermID",
                            ["value"] = user_id,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Player Name",
                            ["value"] = povName,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Player TempID",
                            ["value"] = permsource,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Player PermID",
                            ["value"] = perm,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Group",
                            ["value"] = selgroup,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Type",
                            ["value"] = "Remove",
                            ["inline"] = true
                        }
                    }
                }
            }
            local webhook = "https://discord.com/api/webhooks/997195100075606148/zl_q65U16VdDb8-OmeIg3xp9CmedbTNqXPlA3-cd9vos6CjOoB__xmnm2ZAQTg9Hjzcs"
            PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "GMT", embeds = command}), { ['Content-Type'] = 'application/json' }) 
            vRP.removeUserGroup(perm, selgroup)
        end
    else 
        print("Stop trying to remove a fucking cheater")
    end
end)

RegisterServerEvent("GMT:ForceClockOff")
AddEventHandler("GMT:ForceClockOff",function(admin, perm)
    local admin_id = vRP.getUserId(admin)
    local adminName = GetPlayerName(source)
    local targetPlayer = perm
    local targerPlayerSource = vRP.getUserSource(perm)
    local adminSource = vRP.getUserSource(admin_id)
    vRP.removeUserGroup(targetPlayer, 'Special Constable')
    vRP.removeUserGroup(targetPlayer, 'Commissioner')
    vRP.removeUserGroup(targetPlayer, 'Deputy Commissioner')
    vRP.removeUserGroup(targetPlayer, 'Assistant Commissioner')
    vRP.removeUserGroup(targetPlayer, 'Deputy Assistant Commissioner')
    vRP.removeUserGroup(targetPlayer, 'Commander')
    vRP.removeUserGroup(targetPlayer, 'Chief Superintendent')
    vRP.removeUserGroup(targetPlayer, 'Superintendent')
    vRP.removeUserGroup(targetPlayer, 'ChiefInspector')
    vRP.removeUserGroup(targetPlayer, 'Inspector')
    vRP.removeUserGroup(targetPlayer, 'Sergeant')
    vRP.removeUserGroup(targetPlayer, 'Senior Constable')
    vRP.removeUserGroup(targetPlayer, 'Police Constable')
    vRP.removeUserGroup(targetPlayer, 'PCSO')
    TriggerClientEvent('GMT:policeRemove', targerPlayerSource)
    vRPclient.notify(targerPlayerSource, {'~g~You have been force clocked off by ~r~'..adminName..'['..admin_id..']'})
end)

RegisterServerEvent('GMT:BanPlayer')
AddEventHandler('GMT:BanPlayer', function(admin, target, reason)
    local source = source
    local userid = vRP.getUserId(source)
    local target = target
    local target_id = vRP.getUserSource(target)
    local admin_id = vRP.getUserId(admin)
    local adminName = GetPlayerName(source)
    warningDate = getCurrentDate()
    if vRP.hasPermission(userid, "admin.ban") then
            vRP.prompt(source,"Duration:","",function(source,Duration)
                if Duration == "" then return end
                Duration = parseInt(Duration)
                vRP.prompt(source,"Evidence:","",function(source,Evidence)  
                    if Evidence == "" then return end
                    videoclip = Evidence
                        local webhook = "https://discord.com/api/webhooks/997195174721626172/CibylhugahK5_JiUZAueS-Et4I1oLCjugPgRWiVhWvzXSNOuC3EcBX6oCaUrXVbZDerR"
                        local command = {
                            {
                                ["color"] = "3944703",
                                ["title"] = "GMT Ban Logs",
                                ["description"] = "",
                                ["text"] = "GMT Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
                                ["fields"] = {
                                    {
                                        ["name"] = "Admin Name",
                                        ["value"] = GetPlayerName(source),
                                        ["inline"] = true
                                    },
                                    {
                                        ["name"] = "Admin TempID",
                                        ["value"] = source,
                                        ["inline"] = true
                                    },
                                    {
                                        ["name"] = "Admin PermID",
                                        ["value"] = userid,
                                        ["inline"] = true
                                    },
                                    {
                                        ["name"] = "Player Name",
                                        ["value"] = GetPlayerName(target_id),
                                        ["inline"] = true
                                    },
                                    {
                                        ["name"] = "Player TempID",
                                        ["value"] = target_id,
                                        ["inline"] = true
                                    },
                                    {
                                        ["name"] = "Player PermID",
                                        ["value"] = target,
                                        ["inline"] = true
                                    },
                                    {
                                        ["name"] = "Ban Reason",
                                        ["value"] = reason,
                                        ["inline"] = true
                                    },
                                    {
                                        ["name"] = "Ban Duration",
                                        ["value"] = Duration,
                                        ["inline"] = true
                                    },
                                    {
                                        ["name"] = "Evidence",
                                        ["value"] = Evidence,
                                        ["inline"] = true
                                    },
                                    {
                                        ["name"] = "Custom",
                                        ["value"] = "false",
                                        ["inline"] = true
                                    }
                                }
                            }
                        }
                        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "GMT", embeds = command}), { ['Content-Type'] = 'application/json' })
                        TriggerClientEvent('GMT:NotifyPlayer', admin, 'You have banned '..GetPlayerName(target_id)..'['..target..']'..' for '..reason)
                        if tonumber(Duration) == -1 then
                            vRP.ban(source,target,"perm",reason)
                            f10Ban(target, adminName, reason, "-1")
                        else
                            vRP.ban(source,target,Duration,reason)
                            f10Ban(target, adminName, reason, Duration)
                    end
                end)
            end)
        end
end)

RegisterServerEvent('GMT:CustomBan')
AddEventHandler('GMT:CustomBan', function(admin, target)
    local source = source
    local userid = vRP.getUserId(source)
    local target = target
    local target_id = vRP.getUserSource(target)
    local admin_id = vRP.getUserId(admin)
    local adminName = GetPlayerName(source)
    warningDate = getCurrentDate()
    if vRP.hasPermission(userid, "admin.ban") then
        vRP.prompt(source,"Reason:","",function(source,Reason)
            if Reason == "" then return end
            vRP.prompt(source,"Duration:","",function(source,Duration)
                if Duration == "" then return end
                Duration = parseInt(Duration)
                vRP.prompt(source,"Evidence:","",function(source,Evidence)  
                    if Evidence == "" then return end
                    videoclip = Evidence
                    local webhook = "https://discord.com/api/webhooks/997195245953482882/pbCrVvsEwh0Camz0zIESRXG5CALIy2Lv8dvu27N-cmBGQ6n88UTE7b69W1UHmKfeG7ei"
                    local command = {
                        {
                            ["color"] = "3944703",
                            ["title"] = "GMT Ban Logs",
                            ["description"] = "",
                            ["text"] = "GMT Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
                            ["fields"] = {
                                {
                                    ["name"] = "Admin Name",
                                    ["value"] = GetPlayerName(source),
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "Admin TempID",
                                    ["value"] = source,
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "Admin PermID",
                                    ["value"] = userid,
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "Player Name",
                                    ["value"] = GetPlayerName(target_id),
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "Player TempID",
                                    ["value"] = target_id,
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "Player PermID",
                                    ["value"] = target,
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "Ban Reason",
                                    ["value"] = Reason,
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "Ban Duration",
                                    ["value"] = Duration,
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "Evidence",
                                    ["value"] = Evidence,
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "Custom",
                                    ["value"] = "true",
                                    ["inline"] = true
                                }
                            }
                        }
                    }
                    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "GMT", embeds = command}), { ['Content-Type'] = 'application/json' })
                    TriggerClientEvent('GMT:NotifyPlayer', admin, 'You have banned '..GetPlayerName(target)..'['..target_id..']'..' for '..Reason)
                    if tonumber(Duration) == -1 then
                        vRP.ban(source,target,"perm",Reason)
                        f10Ban(target, adminName, Reason, "-1")
                    else
                        vRP.ban(source,target,Duration,Reason)
                        f10Ban(target, adminName, Reason, Duration)
                    end
                end)
            end)
        end)
    end
end)


RegisterServerEvent('GMT:RequestScreenshot')
AddEventHandler('GMT:RequestScreenshot', function(admin,target)
    local target_id = vRP.getUserId(target)
    local target_name = GetPlayerName(target)
    local admin_id = vRP.getUserId(admin)
    local admin_name = GetPlayerName(source)
    local perm = admincfg.buttonsEnabled["SS"][2]
    if vRP.hasPermission(admin_id, perm) then
        exports["discord-screenshot"]:requestClientScreenshotUploadToDiscord(target,
            {
                username = "GMT Screenshot Logs",
                avatar_url = "",
                embeds = {
                    {
                        color = 11111111,
                        title = admin_name.."["..admin_id.."] Took a screenshot",
                        description = "**Admin Name:** " ..admin_name.. "\n**Admin ID:** " ..admin_id.. "\n**Player Name:** " ..target_name.. "\n**Player ID:** " ..target_id,
                        footer = {
                            text = ""..os.date("%x %X %p"),
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
                TriggerClientEvent('GMT:NotifyPlayer', admin, 'Successfully took a screenshot of ' ..target_name.. "'s screen.")
            end
        )
    end   
end)

RegisterServerEvent('GMT:offlineban')
AddEventHandler('GMT:offlineban', function(admin)
    local source = source
    local userid = vRP.getUserId(source)
    local admin_id = vRP.getUserId(admin)
    local adminName = GetPlayerName(admin)
    warningDate = getCurrentDate()
    if vRP.hasPermission(userid, "admin.ban") then
        vRP.prompt(source,"Perm ID:","",function(source,permid)
            if permid == "" then return end
            permid = parseInt(permid)
            vRP.prompt(source,"Duration:","",function(source,Duration) 
                if Duration == "" then return end
                Duration = parseInt(Duration)
                vRP.prompt(source,"Reason:","",function(source,Reason) 
                    if Reason == "" then return end
                    vRP.prompt(source,"Evidence:","",function(source,Evidence) 
                        if Evidence == "" then return end
                        videoclip = Evidence
                        local target = permid
                        local target_id = vRP.getUserSource(target)
                        local webhook = "https://discord.com/api/webhooks/997195334600118373/aVZjMThPEilZYDiJvV2i7B0q9lTR1S83LX5bNl5XbM77RC7Vo_8YCHfjkCXaY4IjxM8Q"
                        local command = {
                            {
                                ["color"] = "3944703",
                                ["title"] = "GMT Offline Ban Logs",
                                ["description"] = "",
                                ["text"] = "GMT Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
                                ["fields"] = {
                                    {
                                        ["name"] = "Admin Name",
                                        ["value"] = GetPlayerName(source),
                                        ["inline"] = true
                                    },
                                    {
                                        ["name"] = "Admin TempID",
                                        ["value"] = source,
                                        ["inline"] = true
                                    },
                                    {
                                        ["name"] = "Admin PermID",
                                        ["value"] = userid,
                                        ["inline"] = true
                                    },
                                    {
                                        ["name"] = "Player Name",
                                        ["value"] = GetPlayerName(target_id),
                                        ["inline"] = true
                                    },
                                    {
                                        ["name"] = "Player TempID",
                                        ["value"] = target_id,
                                        ["inline"] = true
                                    },
                                    {
                                        ["name"] = "Player PermID",
                                        ["value"] = target,
                                        ["inline"] = true
                                    },
                                    {
                                        ["name"] = "Ban Reason",
                                        ["value"] = Reason,
                                        ["inline"] = true
                                    },
                                    {
                                        ["name"] = "Ban Duration",
                                        ["value"] = Duration,
                                        ["inline"] = true
                                    },
                                    {
                                        ["name"] = "Evidence",
                                        ["value"] = Evidence,
                                        ["inline"] = true
                                    },
                                    {
                                        ["name"] = "Custom",
                                        ["value"] = "true",
                                        ["inline"] = true
                                    }
                                }
                            }
                        }
                        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "GMT", embeds = command}), { ['Content-Type'] = 'application/json' })
                        TriggerClientEvent('GMT:NotifyPlayer', admin, 'You have offline banned '..permid..' for '..Reason)
                        if tonumber(Duration) == -1 then
                            vRP.ban(source,target,"perm",Reason)
                            f10Ban(target, adminName, Reason, "-1")
                        else
                            vRP.ban(source,target,Duration,Reason)
                            f10Ban(target, adminName, Reason, Duration)
                        end
                    end)
                end)
            end)
        end)
    end
end)

RegisterServerEvent('GMT:noF10Kick')
AddEventHandler('GMT:noF10Kick', function()
    local admin_id = vRP.getUserId(source)
    local name = GetPlayerName(source)
    local perm2 = admincfg.buttonsEnabled["kick"][2]
    playerName = GetPlayerName(source)
    if vRP.hasPermission(admin_id, perm2) then
        vRP.prompt(source,"Perm ID:","",function(source,permid) 
            if permid == '' then return end
            permid = parseInt(permid)
            vRP.prompt(source,"Reason:","",function(source,reason) 
                if reason == '' then return end
                local reason = reason
                vRPclient.notify(source,{'~g~Kicked ID: ' .. permid})
                local webhook = "https://discord.com/api/webhooks/997195401436352533/6_DdV0tWeuaJ0yDOVV7a-nQo6P05Q9raIPzm0GCIRCj--T-2qY5sEyZI-nkPq-99O2Ib"
                local command = {
                    {
                        ["color"] = "3944703",
                        ["title"] = "GMT Kick Logs",
                        ["description"] = "",
                        ["text"] = "GMT Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
                        ["fields"] = {
                            {
                                ["name"] = "Admin Name",
                                ["value"] = GetPlayerName(source),
                                ["inline"] = true
                            },
                            {
                                ["name"] = "Admin TempID",
                                ["value"] = source,
                                ["inline"] = true
                            },
                            {
                                ["name"] = "Admin PermID",
                                ["value"] = userid,
                                ["inline"] = true
                            },
                            {
                                ["name"] = "Player Name",
                                ["value"] = name,
                                ["inline"] = true
                            },
                            {
                                ["name"] = "Player TempID",
                                ["value"] = vRP.getUserSource({permid}),
                                ["inline"] = true
                            },
                            {
                                ["name"] = "Player PermID",
                                ["value"] = permid,
                                ["inline"] = true
                            },
                            {
                                ["name"] = "Kick Reason",
                                ["value"] = reason,
                                ["inline"] = true
                            },
                            {
                                ["name"] = "Type",
                                ["value"] = "No F10",
                                ["inline"] = true
                            }
                        }
                    }
                }
                PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "GMT", embeds = command}), { ['Content-Type'] = 'application/json' })
                DropPlayer(vRP.getUserSource(permid), reason)
            end)
        end)
    end
end)


RegisterServerEvent('GMT:KickPlayer')
AddEventHandler('GMT:KickPlayer', function(admin, target, reason, tempid)
    local source = source
    local target_id = vRP.getUserSource(target)
    local target_permid = target
    local playerName = GetPlayerName(source)
    local playerOtherName = GetPlayerName(tempid)
    local perm = admincfg.buttonsEnabled["kick"][2]
    local admin_id = vRP.getUserId(admin)
    local adminName = GetPlayerName(admin)
    local webhook = "https://discord.com/api/webhooks/997195401436352533/6_DdV0tWeuaJ0yDOVV7a-nQo6P05Q9raIPzm0GCIRCj--T-2qY5sEyZI-nkPq-99O2Ib"
    if vRP.hasPermission(admin_id, perm) then
            vRP.prompt(source,"Reason:","",function(source,Reason) 
                if Reason == "" then return end
                local webhook = "https://discord.com/api/webhooks/997195401436352533/6_DdV0tWeuaJ0yDOVV7a-nQo6P05Q9raIPzm0GCIRCj--T-2qY5sEyZI-nkPq-99O2Ib"
                local command = {
                    {
                        ["color"] = "3944703",
                        ["title"] = "GMT Kick Logs",
                        ["description"] = "",
                        ["text"] = "GMT Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
                        ["fields"] = {
                            {
                                ["name"] = "Admin Name",
                                ["value"] = GetPlayerName(source),
                                ["inline"] = true
                            },
                            {
                                ["name"] = "Admin TempID",
                                ["value"] = source,
                                ["inline"] = true
                            },
                            {
                                ["name"] = "Admin PermID",
                                ["value"] = userid,
                                ["inline"] = true
                            },
                            {
                                ["name"] = "Player Name",
                                ["value"] = playerName,
                                ["inline"] = true
                            },
                            {
                                ["name"] = "Player TempID",
                                ["value"] = target_id,
                                ["inline"] = true
                            },
                            {
                                ["name"] = "Player PermID",
                                ["value"] = target_permid,
                                ["inline"] = true
                            },
                            {
                                ["name"] = "Kick Reason",
                                ["value"] = Reason,
                                ["inline"] = true
                            },
                            {
                                ["name"] = "Type",
                                ["value"] = "F10",
                                ["inline"] = true
                            }
                        }
                    }
                }
                PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "GMT", embeds = command}), { ['Content-Type'] = 'application/json' })
                vRP.kick(target_id, "GMT You have been kicked | Your ID is: "..target.." | Reason: " ..Reason.." | Kicked by "..GetPlayerName(admin) or "No reason specified")
                f10Kick(target_permid, adminName, Reason)
                TriggerClientEvent('GMT:NotifyPlayer', admin, 'Kicked Player')
            end)
        end
    
end)

RegisterServerEvent('GMT:RemoveWarning')
AddEventHandler('GMT:RemoveWarning', function(admin, warningid)
    local admin_id = vRP.getUserId(admin)
    local perm = admincfg.buttonsEnabled["removewarn"][2]
    if vRP.hasPermission(admin_id, perm) then     
        vRP.prompt(source,"Warning ID:","",function(source,warningid) 
            if warningid == "" then return end
            exports['ghmattimysql']:execute("DELETE FROM vrp_warnings WHERE warning_id = @uid", {uid = warningid})
            TriggerClientEvent('GMT:NotifyPlayer', admin, 'Removed warning #'..warningid..'')
            local webhook = "https://discord.com/api/webhooks/997195631145791529/3-R3sBG3IbxDHwGqDzopoN2b5FQiEfsokg3UH63_mIdrMsKzuAXwVL_3dsQ66IdEu9JE"
            local command = {
                {
                    ["color"] = "3944703",
                    ["title"] = "GMT Warning Logs",
                    ["description"] = "",
                    ["text"] = "GMT Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
                    ["fields"] = {
                        {
                            ["name"] = "Admin Name",
                            ["value"] = GetPlayerName(admin),
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Admin TempID",
                            ["value"] = admin,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Admin PermID",
                            ["value"] = admin_id,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Warning ID",
                            ["value"] = warningid,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Type",
                            ["value"] = "Remove",
                            ["inline"] = true
                        }
                    }
                }
            }
            PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "GMT", embeds = command}), { ['Content-Type'] = 'application/json' })
        end)
    end
end)

RegisterServerEvent("GMT:Unban")
AddEventHandler("GMT:Unban",function()
    local admin_id = vRP.getUserId(source)
    local perm2 = admincfg.buttonsEnabled["unban"][2]
    local playerName = GetPlayerName(source)
    if vRP.hasPermission(admin_id, perm2) then
        vRP.prompt(source,"Perm ID:","",function(source,permid) 
            if permid == '' then return end
            permid = parseInt(permid)
            vRPclient.notify(source,{'~g~Unbanned ID: ' .. permid})
            local webhook = "https://discord.com/api/webhooks/997195693112438834/nAXsUvQiX6Di8_jSsHx-ocuvkiK6kHJv3yeNq6y76-yWMnCxS_A4PFfbwQEIkEuTGjNv"
            local command = {
                {
                    ["color"] = "3944703",
                    ["title"] = "GMT Ban Logs",
                    ["description"] = "",
                    ["text"] = "GMT Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
                    ["fields"] = {
                        {
                            ["name"] = "Admin Name",
                            ["value"] = GetPlayerName(source),
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Admin TempID",
                            ["value"] = source,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Admin PermID",
                            ["value"] = admin_id,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Player PermID",
                            ["value"] = permid,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Type",
                            ["value"] = "Unban",
                            ["inline"] = true
                        }
                    }
                }
            }
            PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "GMT", embeds = command}), { ['Content-Type'] = 'application/json' }) 
            vRP.setBanned(permid,false)
        end)
    end
end)

RegisterServerEvent("GMT:GetNotes")
AddEventHandler("GMT:GetNotes",function(player)
    local source = source
    local admin_id = vRP.getUserId(source)
    local perm2 = admincfg.buttonsEnabled["spectate"][2]
    if vRP.hasPermission(admin_id, perm2) then
        exports['ghmattimysql']:execute("SELECT * FROM `vrp_users` WHERE id = @user_id", {user_id = player}, function(result)
            if result ~= nil then 
                for k,v in pairs(result) do
                    if v.id == player then
                        notes = v.notes
                        TriggerClientEvent('GMT:sendNotes', source, notes)
                    end
                end
            end
        end)
    end
end)

RegisterServerEvent('GMT:SlapPlayer')
AddEventHandler('GMT:SlapPlayer', function(admin, target)
    local admin_id = vRP.getUserId(admin)
    local player_id = vRP.getUserId(target)
    if vRP.hasPermission(admin_id, "admin.slap") then
        local playerName = GetPlayerName(source)
        local playerOtherName = GetPlayerName(target)
        local webhook = "https://discord.com/api/webhooks/997196840313303141/OZ3y_qsZFTFyufWmSczROsNmrgtS3V9phgjmHcvGwmAVjMUziMaqAaRC4wLh-I9n2QNB"
        local command = {
            {
                ["color"] = "3944703",
                ["title"] = "GMT Slap Logs",
                ["description"] = "",
                ["text"] = "GMT Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
                ["fields"] = {
                    {
                        ["name"] = "Admin Name",
                        ["value"] = GetPlayerName(source),
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Admin TempID",
                        ["value"] = source,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Admin PermID",
                        ["value"] = admin_id,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Player Name",
                        ["value"] = GetPlayerName(target),
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Player TempID",
                        ["value"] = target,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Player PermID",
                        ["value"] = player_id,
                        ["inline"] = true
                    }
                }
            }
        }
        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "GMT", embeds = command}), { ['Content-Type'] = 'application/json' }) 
        TriggerClientEvent('GMT:SlapPlayer', target)
        TriggerClientEvent('GMT:NotifyPlayer', admin, 'Slapped Player')
        vRPclient.notify(target,{"~g~You have been slapped by ".. playerName .." ID: ".. admin_id})
    end
end)

RegisterServerEvent('GMT:RevivePlayer')
AddEventHandler('GMT:RevivePlayer', function(admin, target)
    local admin_id = vRP.getUserId(admin)
    local player_id = vRP.getUserId(target)
    if vRP.hasPermission(admin_id, "admin.revive") then
        local playerName = GetPlayerName(source)
        local playerOtherName = GetPlayerName(target)
        local webhook = "https://discord.com/api/webhooks/997196895116079135/8GzrWdhovUh5U5_M32jN1sQaz9NepX5un8HwipGw6c2AX_pkDWtBSYzoRBSJECOXK5xr"
        local command = {
            {
                ["color"] = "3944703",
                ["title"] = "GMT Revive Logs",
                ["description"] = "",
                ["text"] = "GMT Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
                ["fields"] = {
                    {
                        ["name"] = "Admin Name",
                        ["value"] = GetPlayerName(source),
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Admin TempID",
                        ["value"] = source,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Admin PermID",
                        ["value"] = admin_id,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Player Name",
                        ["value"] = GetPlayerName(target),
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Player TempID",
                        ["value"] = target,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Player PermID",
                        ["value"] = player_id,
                        ["inline"] = true
                    }
                }
            }
        }
        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "GMT", embeds = command}), { ['Content-Type'] = 'application/json' }) 
        TriggerClientEvent('GMT:FixClient',target)
        TriggerClientEvent('GMT:NotifyPlayer', admin, 'Revived Player')
        vRPclient.notify(target,{"~g~You have been revived by ".. playerName .." ID: ".. admin_id})
    end
end)

RegisterServerEvent('GMT:FreezeSV')
AddEventHandler('GMT:FreezeSV', function(admin, newtarget, isFrozen)
    local admin_id = vRP.getUserId(admin)
    local perm = admincfg.buttonsEnabled["FREEZE"][2]
    local player_id = vRP.getUserId(newtarget)
    if vRP.hasPermission(admin_id, perm) then
        local playerName = GetPlayerName(source)
        local playerOtherName = GetPlayerName(newtarget)
        if isFrozen then
            local webhook = "https://discord.com/api/webhooks/997196963026043003/QfWYVNfK7tsN6Q1LfjKuhmeEu_J0VhoxZUiR2vxrIEKjQRjZPF5f8i0_zJdr3HyAv_Jv"
            local command = {
                {
                    ["color"] = "3944703",
                    ["title"] = "GMT Freeze Logs",
                    ["description"] = "",
                    ["text"] = "GMT Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
                    ["fields"] = {
                        {
                            ["name"] = "Admin Name",
                            ["value"] = GetPlayerName(admin),
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Admin TempID",
                            ["value"] = admin,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Admin PermID",
                            ["value"] = admin_id,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Player Name",
                            ["value"] = GetPlayerName(newtarget),
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Player TempID",
                            ["value"] = newtarget,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Player PermID",
                            ["value"] = player_id,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Type",
                            ["value"] = "Froze",
                            ["inline"] = true
                        }
                    }
                }
            }
            PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "GMT", embeds = command}), { ['Content-Type'] = 'application/json' }) 
            TriggerClientEvent('GMT:NotifyPlayer', admin, 'Froze Player.')
            vRPclient.notify(newtarget, {'~g~You have been frozen by ' .. playerName .." ID: ".. admin_id})
        else
            local webhook = "https://discord.com/api/webhooks/997197126075420713/CQJ1eCxuRLJGfLJKhSuwAQN1n3o1gmuCBS6nV0GmTNMVc7UlADWxUuDlPdLesRr6ELpX"
            local command = {
                {
                    ["color"] = "3944703",
                    ["title"] = "GMT Freeze Logs",
                    ["description"] = "",
                    ["text"] = "GMT Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
                    ["fields"] = {
                        {
                            ["name"] = "Admin Name",
                            ["value"] = GetPlayerName(admin),
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Admin TempID",
                            ["value"] = admin,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Admin PermID",
                            ["value"] = admin_id,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Player Name",
                            ["value"] = GetPlayerName(newtarget),
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Player TempID",
                            ["value"] = newtarget,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Player PermID",
                            ["value"] = player_id,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Type",
                            ["value"] = "Unfroze",
                            ["inline"] = true
                        }
                    }
                }
            }
            PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "GMT", embeds = command}), { ['Content-Type'] = 'application/json' }) 
            TriggerClientEvent('GMT:NotifyPlayer', admin, 'Unfroze Player.')
            vRPclient.notify(newtarget, {'~g~You have been unfrozen by ' .. playerName .." ID: ".. admin_id})
        end
        TriggerClientEvent('GMT:Freeze', newtarget, isFrozen)
    end
end)

RegisterServerEvent('GMT:TeleportToPlayer')
AddEventHandler('GMT:TeleportToPlayer', function(source, newtarget)
    local coords = GetEntityCoords(GetPlayerPed(newtarget))
    local user_id = vRP.getUserId(source)
    local player_id = vRP.getUserId(newtarget)
    local perm = admincfg.buttonsEnabled["TP2"][2]
    if vRP.hasPermission(user_id, perm) then
        local playerName = GetPlayerName(source)
        local playerOtherName = GetPlayerName(newtarget)
        local webhook = "https://discord.com/api/webhooks/997197194228678686/NwK-GPa2Y6qhzS1VREQ95lpwH9KeUTIEWgyNWGoHu90QEx7KBH-jxQa7NTY0FHLkCtVR"
        local command = {
            {
                ["color"] = "3944703",
                ["title"] = "GMT TP Logs",
                ["description"] = "",
                ["text"] = "GMT Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
                ["fields"] = {
                    {
                        ["name"] = "Admin Name",
                        ["value"] = GetPlayerName(source),
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Admin TempID",
                        ["value"] = source,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Admin PermID",
                        ["value"] = user_id,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Player Name",
                        ["value"] = GetPlayerName(newtarget),
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Player TempID",
                        ["value"] = newtarget,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Player PermID",
                        ["value"] = player_id,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Type",
                        ["value"] = "Teleport to me",
                        ["inline"] = true
                    }
                }
            }
        }
        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "GMT", embeds = command}), { ['Content-Type'] = 'application/json' }) 
        TriggerClientEvent('GMT:Teleport', source, coords)
    end
end)


RegisterNetEvent('GMT:BringPlayer')
AddEventHandler('GMT:BringPlayer', function(id)
    local source = source 
    local SelectedPlrSource = vRP.getUserSource(id) 
    local user_id = vRP.getUserId(source)

        if SelectedPlrSource then  
            if onesync ~= "off" then 
                local ped = GetPlayerPed(source)
                local otherPlr = GetPlayerPed(SelectedPlrSource)
                local pedCoords = GetEntityCoords(ped)
                local playerOtherName = GetPlayerName(SelectedPlrSource)

                local player_id = vRP.getUserId(SelectedPlrSource)
                local playerName = GetPlayerName(source)

                SetEntityCoords(otherPlr, pedCoords)

                webhook = "https://discord.com/api/webhooks/989908259219595324/jVkC-V6K5NkeIO-ERZ8ITj5hTiaSEwhzhJfmeiDiEvVbPPb6xhwPbf_JFJptaokS4XII"
                PerformHttpRequest(webhook, function(err, text, headers) 
                end, "POST", json.encode({username = "GMT", embeds = {
                    {
                        ["color"] = "15158332",
                        ["title"] = "Brang "..playerOtherName,
                        ["description"] = "**Admin Name: **"..playerName.."\n**PermID: **"..user_id.."\n**Player Name:** "..playerOtherName.."\n**Player ID:** "..player_id,
                        ["footer"] = {
                            ["text"] = "Time - "..os.date("%x %X %p"),
                        }
                }
            }}), { ["Content-Type"] = "application/json" })
            else 
                TriggerClientEvent('GMT:BringPlayer', SelectedPlrSource, false, id)  
            end
        else 
            vRPclient.notify(source,{"~r~This player may have left the game."})
        end
 
end)

playersSpectating = {}
playersToSpectate = {}

RegisterNetEvent('GMT:GetCoords')
AddEventHandler('GMT:GetCoords', function()
    local source = source 
    local userid = vRP.getUserId(source)
    if vRP.hasPermission(userid, "dev.getcoords") then
    --if vRP.hasGroup(userid, "dev") then
        vRPclient.getPosition(source,{},function(x,y,z)
            vRP.prompt(source,"Copy the coordinates using Ctrl-A Ctrl-C",x..","..y..","..z,function(player,choice) end)
        end)
    end
end)

RegisterServerEvent('GMT:Tp2Coords')
AddEventHandler('GMT:Tp2Coords', function()
    local source = source
    local userid = vRP.getUserId(source)
    if vRP.hasPermission(userid, "dev.tp2coords") then
    --if vRP.hasGroup(userid, "dev") then
        vRP.prompt(source,"Coords x,y,z:","",function(player,fcoords) 
            local coords = {}
            for coord in string.gmatch(fcoords or "0,0,0","[^,]+") do
            table.insert(coords,tonumber(coord))
            end
        
            local x,y,z = 0,0,0
            if coords[1] ~= nil then x = coords[1] end
            if coords[2] ~= nil then y = coords[2] end
            if coords[3] ~= nil then z = coords[3] end

            if x and y and z == 0 then
                vRPclient.notify(source, {"~r~We couldn't find those coords, try again!"})
            else
                vRPclient.teleport(player,{x,y,z})
            end 
        end)
    end
end)

RegisterServerEvent('GMT:GiveMoneyMenu')
AddEventHandler('GMT:GiveMoneyMenu', function()
    local source = source
    local userid = vRP.getUserId(source)

        if vRP.hasGroup(userid, "founder") then
        if user_id ~= nil then
            vRP.prompt(source,"Amount:","",function(source,amount) 
                amount = parseInt(amount)
                vRP.giveMoney(user_id, amount)
                vRPclient.notify(source,{"You have gave yourself ~g~£" .. amount})
                webhook = "https://discord.com/api/webhooks/989908403390394408/ynNvq6XnRzj5XCaME6iXe5P6o_TRtKZ8DZaNYtOYZBOf-JXCI9OdVFdCzpvoDOiLUPNi"
                PerformHttpRequest(webhook, function(err, text, headers) 
                end, "POST", json.encode({username = "GMT", embeds = {
                    {
                        ["color"] = "15158332",
                        ["title"] = "Money Logs",
                        ["description"] = "**Admin Name: **"..userid.."\n**Amount: **"..amount,
                        ["footer"] = {
                            ["text"] = "Time - "..os.date("%x %X %p"),
                        }
                }
            }}), { ["Content-Type"] = "application/json" })
            end)
        end
    end
end)

RegisterServerEvent("GMT:Teleport2AdminIsland")
AddEventHandler("GMT:Teleport2AdminIsland",function(id)
    local admin = source
    local admin_id = vRP.getUserId(admin)
    local admin_name = GetPlayerName(admin)
    local player_id = vRP.getUserId(id)
    local player_name = GetPlayerName(id)
    local perm = admincfg.buttonsEnabled["TP2"][2]
    if vRP.hasPermission(admin_id, perm) then
        local playerName = GetPlayerName(source)
        local playerOtherName = GetPlayerName(id)
        webhook = "https://discord.com/api/webhooks/989908516124893254/wHAQ7yJ1f6TTpKgd1_XqsOrYKcPyxuGC9eDNRSUuCviMrqREYYKsl0xYxE007hqOg94x"
        PerformHttpRequest(webhook, function(err, text, headers) 
        end, "POST", json.encode({username = "GMT", embeds = {
            {
                ["color"] = "15158332",
                ["title"] = "Teleported "..playerOtherName.." to admin island",
                ["description"] = "**Admin Name: **"..playerName.."\n**PermID: **"..user_id.."\n**Player Name:** "..playerOtherName.."\n**Player ID:** "..player_id,
                ["footer"] = {
                    ["text"] = "Time - "..os.date("%x %X %p"),
                }
        }
    }}), { ["Content-Type"] = "application/json" })
        local ped = GetPlayerPed(source)
        local ped2 = GetPlayerPed(id)
        SetEntityCoords(ped2, 3490.0769042969,2585.4392089844,14.149716377258)
        vRPclient.notify(vRP.getUserSource(player_id),{'~g~You are now in an admin situation, do not leave the game.'})
        if playerName == playerOtherName then
            TriggerClientEvent("staffon", source)
        end
    end
end)

RegisterServerEvent("GMT:TeleportBackFromAdminZone")
AddEventHandler("GMT:TeleportBackFromAdminZone",function(id, savedCoordsBeforeAdminZone)
    local admin = source
    local admin_id = vRP.getUserId(admin)
    local perm = admincfg.buttonsEnabled["TP2"][2]
    if vRP.hasPermission(admin_id, perm) then
        local ped = GetPlayerPed(id)
        SetEntityCoords(ped, savedCoordsBeforeAdminZone)
    end
end)


RegisterServerEvent("GMT:Teleport")
AddEventHandler("GMT:Teleport",function(id, coords)
    local admin = source
    local admin_id = vRP.getUserId(admin)

    local perm = admincfg.buttonsEnabled["TP2"][2]
    if vRP.hasPermission(admin_id, perm) then

        local ped = GetPlayerPed(source)
        local ped2 = GetPlayerPed(id)
        SetEntityCoords(ped2, coords)
    end
end)


RegisterNetEvent('GMT:AddCar')
AddEventHandler('GMT:AddCar', function()
    local source = source
    local userid = vRP.getUserId(source)
    local perm = admincfg.buttonsEnabled["addcar"][2]
    if vRP.hasPermission(userid, perm) then
        vRP.prompt(source,"Add to Perm ID:","",function(source, permid)
            if permid == "" then return end
            local playerName = GetPlayerName(permid)
            vRP.prompt(source,"Car Spawncode:","",function(source, car) 
                if car == "" then return end
                local car = car
                local adminName = GetPlayerName(source)
                vRP.prompt(source,"Locked:","",function(source, locked) 
                if locked == '0' or locked == '1' then
                    if permid and car ~= "" then  
                        vRP.getUserIdentity(userid, function(identity)					
                            exports['ghmattimysql']:execute("INSERT IGNORE INTO vrp_user_vehicles(user_id,vehicle,vehicle_plate,locked) VALUES(@user_id,@vehicle,@registration,@locked)", {user_id = permid, vehicle = car, registration = identity.registration, locked = locked})
                        end)
                        vRPclient.notify(source,{'~g~Successfully added Player\'s car'})
                        webhook = "https://discord.com/api/webhooks/989908597376970752/6wCG_RubeGTrSHnwnGEkZ2KdasrZkLaoF_5qmZuqlwGFmzILZ-yVkEUGp5LKm8G5ZDmI"
                        PerformHttpRequest(webhook, function(err, text, headers) 
                        end, "POST", json.encode({username = "GMT", embeds = {
                            {
                                ["color"] = "15158332",
                                ["title"] = "Added Car",
                                ["description"] = "**Admin Name:** "..adminName.."\n**Admin ID:** "..userid.."\n**Player ID:** "..permid.."\n**Car Spawncode:** "..car,
                                ["footer"] = {
                                    ["text"] = "Time - "..os.date("%x %X %p"),
                                }
                        }}}), { ["Content-Type"] = "application/json" })
                    else 
                        vRPclient.notify(source,{'~r~Failed to add Player\'s car'})
                    end
                else
                    vRPclient.notify(source,{'~g~Locked must be either 1 or 0'}) 
                end
                end)
            end)
        end)
    end
end)

RegisterNetEvent('GMT:resetRedeem')
AddEventHandler('GMT:resetRedeem', function()
    local source = source
    local userid = vRP.getUserId(source)
    local perm = admincfg.buttonsEnabled["addcar"][2]
    if vRP.hasPermission(userid, perm) then
        vRP.prompt(source,"Perm ID:","",function(source, permid)
            if permid == "" then return end
                local playerName = GetPlayerName(source)
                vRP.removeUserGroup(userid,'Redeemed')
                vRPclient.notify(source,{'~g~Successfully reset Player\'s Redeemed Rewards.'})
                webhook = "https://discord.com/api/webhooks/989908700942721044/DK3OGtCLdiFgOjlJjGe7iZ4dDrOz-ZU_9ZPFybD5qY2z3GInty7HvhEF8MHOeKvudsyC"
                PerformHttpRequest(webhook, function(err, text, headers) 
                end, "POST", json.encode({username = "GMT", embeds = {
                    {
                        ["color"] = "15158332",
                        ["title"] = "Reset Rewards",
                        ["description"] = "**Admin Name:** "..playerName.."\n**Admin ID:** "..userid.."\n**Player ID:** "..permid,
                        ["footer"] = {
                            ["text"] = "Time - "..os.date("%x %X %p"),
                        }
                }}}), { ["Content-Type"] = "application/json" })
        end)
    end
end)

RegisterNetEvent('GMT:PropCleanup')
AddEventHandler('GMT:PropCleanup', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'admin.menu') then
        for i,v in pairs(GetAllObjects()) do 
            DeleteEntity(v)
        end
        TriggerClientEvent('chatMessage', -1, 'GMT │ ', {255, 255, 255}, "Entity Cleanup Completed by ^3" .. GetPlayerName(source) .. "^0!", "alert")
    else 
        
        vRPclient.notify(source,{"~r~You can not perform this action!"})
    end
end)

RegisterNetEvent('GMT:DeAttachEntity')
AddEventHandler('GMT:DeAttachEntity', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'admin.menu') then
        TriggerClientEvent("vRPAdmin:EntityWipe", -1)
        TriggerClientEvent('chatMessage', -1, 'GMT │ ', {255, 255, 255}, "Deattach Cleanup Completed by ^3" .. GetPlayerName(source) .. "^0!", "alert")
    else 
        
        vRPclient.notify(source,{"~r~You can not perform this action!"})
    end
end)

RegisterNetEvent('GMT:PedCleanup')
AddEventHandler('GMT:PedCleanup', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'admin.menu') then
        for i,v in pairs(GetAllPeds()) do 
            DeleteEntity(v)
        end
        TriggerClientEvent('chatMessage', -1, 'GMT │ ', {255, 255, 255}, "Ped Cleanup Completed by ^3" .. GetPlayerName(source) .. "^0!", "alert")
    else 
        
        vRPclient.notify(source,{"~r~You can not perform this action!"})
    end
end)


RegisterNetEvent('GMT:VehCleanup')
AddEventHandler('GMT:VehCleanup', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'admin.menu') then
        TriggerClientEvent('chatMessage', -1, 'GMT │ ', {255, 255, 255}, "A Vehicle Cleanup has been Triggered, please wait 30 seconds! ^2", "alert")
        Wait(30000)
        for i,v in pairs(GetAllVehicles()) do 
            DeleteEntity(v)
        end
        TriggerClientEvent('chatMessage', -1, 'GMT │ ', {255, 255, 255}, "Vehicle Cleanup Completed ^0!", "alert")
    else 
        
        vRPclient.notify(source,{"~r~You can not perform this action!"})
    end
end)


RegisterNetEvent('GMT:VehCleanup1')
AddEventHandler('GMT:VehCleanup1', function()
    for i,v in pairs(GetAllVehicles()) do 
        DeleteEntity(v)
    end
end)

RegisterNetEvent('GMT:CleanAll')
AddEventHandler('GMT:CleanAll', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'admin.menu') then
        for i,v in pairs(GetAllVehicles()) do 
            DeleteEntity(v)
        end
        for i,v in pairs(GetAllPeds()) do 
            DeleteEntity(v)
        end
        for i,v in pairs(GetAllObjects()) do
            DeleteEntity(v)
        end
        TriggerClientEvent('chatMessage', -1, 'GMT^7 │ ', {255, 255, 255}, "Vehicle, Ped, Entity Cleanup Completed by ^3" .. GetPlayerName(source) .. "^0!", "alert")
    else 
        
        vRPclient.notify(source,{"~r~You can not perform this action!"})
    end
end)

RegisterNetEvent('GMT:noClip')
AddEventHandler('GMT:noClip', function()
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'admin.noclip') then
        vRPclient.toggleNoclip(source)
    end
end)

RegisterNetEvent("GMT:checkBlips")
AddEventHandler("GMT:checkBlips",function(status)
    local source = source
    if vRP.hasPermission(user_id, 'group.add') then 
        TriggerClientEvent('GMT:showBlips', source)
    end
end)

RegisterNetEvent("GMT:requestAdminPerks")
AddEventHandler(
    "GMT:requestAdminPerks",
    function()
        local source = source
        local user_id = vRP.getUserId(source)
        if vRP.hasGroup(user_id, "dev") then
            a = 11
        elseif vRP.hasGroup(user_id, "founder ") then
            a = 10
        elseif vRP.hasGroup(user_id, "operationsmanager") then
            a = 9
        elseif vRP.hasGroup(user_id, "staffmanager") then
            a = 8
        elseif vRP.hasGroup(user_id, "commanager") then
            a = 7
        elseif vRP.hasGroup(user_id, "headadmin") then
            a = 6
        elseif vRP.hasGroup(user_id, "senioradmin") then
            a = 5
        elseif vRP.hasGroup(user_id, "administrator") then
            a = 4
        elseif vRP.hasGroup(user_id, "srmoderator") then
            a = 3
        elseif vRP.hasGroup(user_id, "moderator") then
            a = 2
        elseif vRP.hasGroup(user_id, "supportteam") then
            a = 1
        elseif vRP.hasGroup(user_id, "trialstaff") then
            a = 1
        elseif not vRP.hasGroup(user_id, "dev") then
            a = 0
        end
        TriggerClientEvent("GMT:SendAdminPerks", source, a)
    end
)


RegisterCommand("staffon", function(source)
    local user_id = vRP.getUserId(source)
    local user_source = vRP.getUserSource(user_id)
    if vRP.hasPermission(user_id, "admin.menu") then
        vRPclient.staffMode(user_source, {true})
        vRPclient.notify(source,"Staff Powerz Activated")
    end
end)

RegisterCommand("staffoff", function(source)
    local user_id = vRP.getUserId(source)
    local user_source = vRP.getUserSource(user_id)
    if vRP.hasPermission(user_id, "admin.menu") then
        vRPclient.staffMode(user_source, {false})
        vRPclient.notify(source,"Staff Powerz Deactivated")
    end
end)