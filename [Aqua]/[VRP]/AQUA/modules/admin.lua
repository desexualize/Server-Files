
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


RegisterServerEvent('AQUA:OpenSettings')
AddEventHandler('AQUA:OpenSettings', function()
    local source = source
    local user_id = AQUA.getUserId(source)
    if user_id ~= nil and AQUA.hasPermission(user_id, "admin.menu") then
        TriggerClientEvent("AQUA:OpenSettingsMenu", source, true)
    else
        TriggerClientEvent("AQUA:OpenSettingsMenu", source, false)
    end
end)

RegisterServerEvent("AQUA:GetPlayerData")
AddEventHandler("AQUA:GetPlayerData",function()
    local source = source
    user_id = AQUA.getUserId(source)
    if AQUA.hasPermission(user_id, admincfg.perm) then
        players = GetPlayers()
        players_table = {}
        menu_btns_table = {}
        useridz = {}
        for i, p in pairs(players) do
            if AQUA.getUserId(p) ~= nil then
                name = GetPlayerName(p)
                user_idz = AQUA.getUserId(p)
                data = AQUA.getUserDataTable(user_idz)
                playtime = data.PlayerTime or 0
                PlayerTimeInHours = playtime/60
                if PlayerTimeInHours < 1 then
                    PlayerTimeInHours = 0
                end
                players_table[user_idz] = {name, p, user_idz, math.ceil(PlayerTimeInHours)}
                table.insert(useridz, user_idz)
            else
                DropPlayer(p, " - The server was unable to cache your ID, please rejoin.")
            end
         end
        if admincfg.IgnoreButtonPerms == false then
            for i, b in pairs(admincfg.buttonsEnabled) do
                if b[1] and AQUA.hasPermission(user_id, b[2]) then
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
        TriggerClientEvent("AQUA:SendPlayerInfo", source, players_table, menu_btns_table)
    end
end)


RegisterCommand("gethours", function(source, args)
    local v = source
    local UID = AQUA.getUserId(v)
    local D = math.ceil(AQUA.getUserDataTable(UID).PlayerTime/60) or 0
    if UID then
            AQUAclient.notify(v,{"~g~You currently have ~b~"..D.." ~g~hours."})
    end
end)


RegisterCommand("sethours", function(source, args) if source == 0 then data = AQUA.getUserDataTable(tonumber(args[1])); data.PlayerTime = tonumber(args[2])*60; print(GetPlayerName(AQUA.getUserSource(tonumber(args[1]))).."'s hours have been set to: "..tonumber(args[2]))end  end)

RegisterNetEvent("AQUA:GetNearbyPlayers")
AddEventHandler("AQUA:GetNearbyPlayers", function(dist)
    local source = source
    local user_id = AQUA.getUserId(source)
    local plrTable = {}

    if AQUA.hasPermission(user_id, admincfg.perm) then
        AQUAclient.getNearestPlayers(source, {dist}, function(nearbyPlayers)
            for k, v in pairs(nearbyPlayers) do
                data = AQUA.getUserDataTable(AQUA.getUserId(k))
                playtime = data.PlayerTime or 0
                PlayerTimeInHours = playtime/60
                if PlayerTimeInHours < 1 then
                    PlayerTimeInHours = 0
                end
                plrTable[AQUA.getUserId(k)] = {GetPlayerName(k), k, AQUA.getUserId(k), math.ceil(PlayerTimeInHours)}
            end
            TriggerClientEvent("AQUA:ReturnNearbyPlayers", source, plrTable)
        end)
    end
end)


RegisterServerEvent("AQUA:GetGroups")
AddEventHandler("AQUA:GetGroups",function(temp, perm)
    local user_groups = AQUA.getUserGroups(perm)
    TriggerClientEvent("AQUA:GotGroups", source, user_groups)
end)

RegisterServerEvent("AQUA:CheckPov")
AddEventHandler("AQUA:CheckPov",function(userperm)
    --print(userperm)
    local user_id = AQUA.getUserId(source)
  
    if AQUA.hasPermission(user_id, "admin.menu") then
        if AQUA.hasPermission(userperm, 'pov.list') then
            TriggerClientEvent('AQUA:ReturnPov', source, true)
        elseif not AQUA.hasPermission(userperm, 'pov.list') then
            TriggerClientEvent('AQUA:ReturnPov', source, false)
        end
    else 
     end
    
end)


RegisterServerEvent("other:deletevehicle")
AddEventHandler("other:deletevehicle",function()
    local source = source
    local user_id = AQUA.getUserId(source)
    if AQUA.hasPermission(user_id, 'police.armoury') or AQUA.hasPermission(user_id, 'dev.menu')then
        TriggerClientEvent('wk:deleteVehicle', source)
    end
end)

RegisterServerEvent("wk:fixVehicle")
AddEventHandler("wk:fixVehicle",function()
    local source = source
    local user_id = AQUA.getUserId(source)
    if AQUA.hasPermission(user_id, 'admin.noclip') then
        TriggerClientEvent('wk:fixVehicle', source)
    end
end)

RegisterServerEvent("admin:cancelRent")
AddEventHandler("admin:cancelRent",function()
    local source = source
    local user_id = AQUA.getUserId(source)
    local originalOwner = ''
    if AQUA.hasPermission(user_id, 'admin.noclip') then
        AQUA.prompt(source,"Current Owner:","",function(source, currentOwner)
            if currentOwner == '' then return end
            local currentOwner = currentOwner
            AQUA.prompt(source,"Spawncode:","",function(source, spawncode)
                local spawncode = spawncode
                if spawncode == '' then return end
                exports['ghmattimysql']:execute("SELECT * FROM `aqua_user_vehicles` WHERE user_id = @user_id", {user_id = currentOwner}, function(result)
                    if result ~= nil then 
                        for k, v in pairs(result) do
                            if v.user_id == tonumber(currentOwner) and v.vehicle == spawncode then
                                originalOwner = v.rentedid
                                exports['ghmattimysql']:execute("UPDATE `aqua_user_vehicles` SET user_id = @originalOwner, rented = 0, rentedid = '', rentedtime = '' WHERE user_id = @currentOwner AND vehicle = @spawncode", {currentOwner = currentOwner, originalOwner = tonumber(originalOwner), spawncode = spawncode})
                                AQUAclient.notify(source,{"~g~Successfully cancelled rent."})
                            end
                        end
                    end
                end)
            end)
        end)
    end
end)

RegisterServerEvent("AQUA:getNotes")
AddEventHandler("AQUA:getNotes",function(admin, player)
    local source = source
    local admin_id = AQUA.getUserId(source)
    local perm2 = admincfg.buttonsEnabled["spectate"][2]
    if AQUA.hasPermission(admin_id, perm2) then
        exports['ghmattimysql']:execute("SELECT * FROM aqua_user_notes WHERE user_id = @user_id", {user_id = player}, function(result) 
            if result ~= nil then
                TriggerClientEvent('AQUA:sendNotes', source, json.encode(result))
            end
        end)
    else
        local player = AQUA.getUserSource(admin_id)
        local name = GetPlayerName(source)
        Wait(500)
        reason = "Type #11"
        TriggerEvent("AQUA:acBan", admin_id, reason, name, player, 'Attempted to Get Notes')
    end
end)

RegisterServerEvent("AQUA:addNote")
AddEventHandler("AQUA:addNote",function(admin, player)
    local source = source
    local admin_id = AQUA.getUserId(source)
    local perm2 = admincfg.buttonsEnabled["spectate"][2]
    local adminName = GetPlayerName(source)
    local playerName = GetPlayerName(player)
    local playerperm = AQUA.getUserId(player)
    if AQUA.hasPermission(admin_id, perm2) then
        AQUA.prompt(source,"Reason:","",function(source,text) 
            if text == '' then return end
            exports['ghmattimysql']:execute("INSERT INTO aqua_user_notes (`user_id`, `text`, `admin_name`, `admin_id`) VALUES (@user_id, @text, @admin_name, @admin_id);", {user_id = playerperm, text = text, admin_name = adminName, admin_id = admin_id}, function() end) 
            TriggerClientEvent('AQUA:NotifyPlayer', source, '~g~You have added a note to '..playerName..'('..playerperm..') with the reason '..text)
            TriggerClientEvent('AQUA:updateNotes', -1, admin, playerperm)
            local webhook = "https://discord.com/api/webhooks/1043328414469341224/NNOjJ5CbFao49hpkQyoLACBUe1Ec7rWtAQWxK-Xr9hU6qbYA04UiqJ1WyDgjbhl5De-h"
            local command = {
                {
                    ["color"] = "3944703",
                    ["title"] = " Group Logs",
                    ["description"] = "",
                    ["text"] = " Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
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
            PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "AQUA", embeds = command}), { ['Content-Type'] = 'application/json' }) 
        end)
    else
        local player = AQUA.getUserSource(admin_id)
        local name = GetPlayerName(source)
        Wait(500)
        reason = "Type #11"
        TriggerEvent("AQUA:acBan", admin_id, reason, name, player, 'Attempted to Add Note')
    end
end)

RegisterServerEvent("AQUA:removeNote")
AddEventHandler("AQUA:removeNote",function(admin, player)
    local source = source
    local admin_id = AQUA.getUserId(source)
    local perm2 = admincfg.buttonsEnabled["spectate"][2]
    local playerName = GetPlayerName(player)
    local playerperm = AQUA.getUserId(player)
    if AQUA.hasPermission(admin_id, perm2) then
        AQUA.prompt(source,"Note ID:","",function(source,noteid) 
            if noteid == '' then return end
            exports['ghmattimysql']:execute("DELETE FROM aqua_user_notes WHERE note_id = @noteid", {noteid = noteid}, function() end)
            TriggerClientEvent('AQUA:NotifyPlayer', admin, '~g~You have removed note #'..noteid..' from '..playerName..'('..playerperm..')')
            TriggerClientEvent('AQUA:updateNotes', -1, admin, playerperm)
            local webhook = "https://discord.com/api/webhooks/1043328414469341224/NNOjJ5CbFao49hpkQyoLACBUe1Ec7rWtAQWxK-Xr9hU6qbYA04UiqJ1WyDgjbhl5De-h"
            local command = {
                {
                    ["color"] = "3944703",
                    ["title"] = " Group Logs",
                    ["description"] = "",
                    ["text"] = " Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
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
            PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "AQUA", embeds = command}), { ['Content-Type'] = 'application/json' }) 
        end)
    else
        local player = AQUA.getUserSource(admin_id)
        local name = GetPlayerName(source)
        Wait(500)
        reason = "Type #11"
        TriggerEvent("AQUA:acBan", admin_id, reason, name, player, 'Attempted to Remove Note')
    end
end)


local onesync = GetConvar('onesync', nil)
RegisterNetEvent('AQUA:SpectatePlayer')
AddEventHandler('AQUA:SpectatePlayer', function(id)
    local source = source 
    local SelectedPlrSource = AQUA.getUserSource(id) 
    local userid = AQUA.getUserId(source)
    if AQUA.hasPermission(userid, "admin.spectate") then
        if SelectedPlrSource then  
            if onesync ~= "off" then 
                local ped = GetPlayerPed(SelectedPlrSource)
                local pedCoords = GetEntityCoords(ped)
                
                TriggerClientEvent('AQUA:Spectate', source, SelectedPlrSource, pedCoords)
            else 
                TriggerClientEvent('AQUA:Spectate', source, SelectedPlrSource)
            end
        else 
            AQUAclient.notify(source,{"~r~This player may have left the game."})
        end
    end
end)

RegisterNetEvent('AQUA:Restart')
AddEventHandler('AQUA:Restart', function()
    local source = source 
    local userid = AQUA.getUserId(source)
    if AQUA.hasPermission(userid, 'dev.menu') then
        TriggerClientEvent("AQUA:closeToRestart", -1)
        TriggerClientEvent('AQUA:announceRestart', -1, 60, false)
        Wait(60000)
        restartServer()
    end
end)

RegisterNetEvent('AQUA:RemoveTimer')
AddEventHandler('AQUA:RemoveTimer', function(player)
    local source = source 
    local userid = AQUA.getUserId(source)
    if AQUA.hasPermission(userid, 'admin.freeze') then
        TriggerClientEvent("AQUA:StopTimer", player)
    end
end)

function restartServer()
    kickAllPlayers()
    Citizen.Wait(1000)
    os.exit()
end

function kickAllPlayers()
    for i,v in pairs(GetPlayers()) do 
        DropPlayer(v, 'AQUA, Server Restart')
    end
end

RegisterServerEvent("AQUA:Giveweapon")
AddEventHandler("AQUA:Giveweapon",function()
    local source = source
    local userid = AQUA.getUserId(source)
    if AQUA.hasPermission(userid, "dev.menu") then
        AQUA.prompt(source,"Weapon Name:","",function(source,hash) 
            TriggerClientEvent("AQUA:allowWeaponSpawn", source, hash)
        end)
    end
end)

RegisterServerEvent("AQUA:AddGroup")
AddEventHandler("AQUA:AddGroup",function(perm, selgroup)
    local admin_temp = source
    local admin_perm = AQUA.getUserId(admin_temp)
    local user_id = AQUA.getUserId(source)
    local permsource = AQUA.getUserSource(perm)
    local playerName = GetPlayerName(source)
    local povName = GetPlayerName(permsource)
    if AQUA.hasPermission(user_id, "group.add") then
        if selgroup == "founder" and not AQUA.hasPermission(admin_perm, "group.add.founder") then
            AQUAclient.notify(admin_temp, {"~r~You don't have permission to do that"}) 
        elseif selgroup == "operationsmanager" and not AQUA.hasPermission(user_id, "group.add.operationsmanager") then
            AQUAclient.notify(admin_temp, {"~r~You don't have permission to do that"}) 
        elseif selgroup == "staffmanager" and not AQUA.hasPermission(admin_perm, "group.add.staffmanager") then
            AQUAclient.notify(admin_temp, {"~r~You don't have permission to do that"}) 
        elseif selgroup == "commanager" and not AQUA.hasPermission(admin_perm, "group.add.commanager") then
            AQUAclient.notify(admin_temp, {"~r~You don't have permission to do that"}) 
        elseif selgroup == "headadmin" and not AQUA.hasPermission(admin_perm, "group.add.headadmin") then
            AQUAclient.notify(admin_temp, {"~r~You don't have permission to do that"}) 
        elseif selgroup == "senioradmin" and not AQUA.hasPermission(admin_perm, "group.add.senioradmin") then
            AQUAclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "administrator" and not AQUA.hasPermission(admin_perm, "group.add.administrator") then
            AQUAclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "srmoderator" and not AQUA.hasPermission(admin_perm, "group.add.srmoderator") then
            AQUAclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "moderator" and not AQUA.hasPermission(admin_perm, "group.add.moderator") then
            AQUAclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "supportteam" and not AQUA.hasPermission(admin_perm, "group.add.supportteam") then
            AQUAclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "trialstaff" and not AQUA.hasPermission(admin_perm, "group.add.trial") then
            AQUAclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "vip" and not AQUA.hasPermission(admin_perm, "group.add.vip") then
            AQUAclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "pov" and not AQUA.hasGroup(perm, "group.add.pov") then
            local command = {
                {
                    ["color"] = "3944703",
                    ["title"] = " Group Logs",
                    ["description"] = "",
                    ["text"] = " Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
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
            local webhook = "https://discord.com/api/webhooks/1043327069049860206/fjvMgg2C79u_PHqHSoVph34OiQdJPHTaTkmbr3lKLPF8KAclBVt0p9o5BqIHv364cVSp"
            PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "AQUA", embeds = command}), { ['Content-Type'] = 'application/json' }) 
            AQUA.addUserGroup(perm, "pov")
        else
            local command = {
                {
                    ["color"] = "3944703",
                    ["title"] = " Group Logs",
                    ["description"] = "",
                    ["text"] = " Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
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
            local webhook = "https://discord.com/api/webhooks/1043327069049860206/fjvMgg2C79u_PHqHSoVph34OiQdJPHTaTkmbr3lKLPF8KAclBVt0p9o5BqIHv364cVSp"
            PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "AQUA", embeds = command}), { ['Content-Type'] = 'application/json' }) 
            AQUA.addUserGroup(perm, selgroup)
        end
    else
        print("Stop trying to add a group u fucking cheater")
    end
end)

RegisterServerEvent("AQUA:RemoveGroup")
AddEventHandler("AQUA:RemoveGroup",function(perm, selgroup)
    local user_id = AQUA.getUserId(source)
    local admin_temp = source
    local permsource = AQUA.getUserSource(perm)
    local playerName = GetPlayerName(source)
    local povName = GetPlayerName(permsource)
    if AQUA.hasPermission(user_id, "group.remove") then
        if selgroup == "founder" and not AQUA.hasPermission(user_id, "group.remove.founder") then
            AQUAclient.notify(admin_temp, {"~r~You don't have permission to do that"}) 
        elseif selgroup == "operationsmanager" and not AQUA.hasPermission(user_id, "group.remove.operationsmanager") then
            AQUAclient.notify(admin_temp, {"~r~You don't have permission to do that"}) 
        elseif selgroup == "staffmanager" and not AQUA.hasPermission(user_id, "group.remove.staffmanager") then
            AQUAclient.notify(admin_temp, {"~r~You don't have permission to do that"}) 
        elseif selgroup == "commanager" and not AQUA.hasPermission(user_id, "group.remove.commanager") then
            AQUAclient.notify(admin_temp, {"~r~You don't have permission to do that"}) 
        elseif selgroup == "headadmin" and not AQUA.hasPermission(user_id, "group.remove.headadmin") then
            AQUAclient.notify(admin_temp, {"~r~You don't have permission to do that"}) 
        elseif selgroup == "senioradmin" and not AQUA.hasPermission(user_id, "group.remove.senioradmin") then
            AQUAclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "administrator" and not AQUA.hasPermission(user_id, "group.remove.administrator") then
            AQUAclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "srmoderator" and not AQUA.hasPermission(user_id, "group.remove.srmoderator") then
            AQUAclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "moderator" and not AQUA.hasPermission(user_id, "group.remove.moderator") then
            AQUAclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "supportteam" and not AQUA.hasPermission(user_id, "group.remove.supportteam") then
            AQUAclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "trialstaff" and not AQUA.hasPermission(user_id, "group.remove.trial") then
            AQUAclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "vip" and not AQUA.hasPermission(user_id, "group.remove.vip") then
            AQUAclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "pov" and AQUA.hasGroup(perm, "group.remove.pov") then
            local command = {
                {
                    ["color"] = "3944703",
                    ["title"] = " Group Logs",
                    ["description"] = "",
                    ["text"] = " Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
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
            local webhook = "https://discord.com/api/webhooks/1043327069049860206/fjvMgg2C79u_PHqHSoVph34OiQdJPHTaTkmbr3lKLPF8KAclBVt0p9o5BqIHv364cVSp"
            PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "AQUA", embeds = command}), { ['Content-Type'] = 'application/json' }) 
            AQUA.removeUserGroup(perm, "pov")
        else
            local command = {
                {
                    ["color"] = "3944703",
                    ["title"] = " Group Logs",
                    ["description"] = "",
                    ["text"] = " Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
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
            local webhook = "https://discord.com/api/webhooks/1043327069049860206/fjvMgg2C79u_PHqHSoVph34OiQdJPHTaTkmbr3lKLPF8KAclBVt0p9o5BqIHv364cVSp"
            PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "AQUA", embeds = command}), { ['Content-Type'] = 'application/json' }) 
            AQUA.removeUserGroup(perm, selgroup)
        end
    else 
        print("Stop trying to remove a fucking cheater")
    end
end)

RegisterServerEvent("AQUA:ForceClockOff")
AddEventHandler("AQUA:ForceClockOff",function(admin, perm)
    local admin_id = AQUA.getUserId(admin)
    local adminName = GetPlayerName(source)
    local targetPlayer = perm
    local targerPlayerSource = AQUA.getUserSource(perm)
    local adminSource = AQUA.getUserSource(admin_id)
    AQUA.removeUserGroup(targetPlayer, 'Special Constable')
    AQUA.removeUserGroup(targetPlayer, 'Commissioner')
    AQUA.removeUserGroup(targetPlayer, 'Deputy Commissioner')
    AQUA.removeUserGroup(targetPlayer, 'Assistant Commissioner')
    AQUA.removeUserGroup(targetPlayer, 'Deputy Assistant Commissioner')
    AQUA.removeUserGroup(targetPlayer, 'Commander')
    AQUA.removeUserGroup(targetPlayer, 'Chief Superintendent')
    AQUA.removeUserGroup(targetPlayer, 'Superintendent')
    AQUA.removeUserGroup(targetPlayer, 'ChiefInspector')
    AQUA.removeUserGroup(targetPlayer, 'Inspector')
    AQUA.removeUserGroup(targetPlayer, 'Sergeant')
    AQUA.removeUserGroup(targetPlayer, 'Senior Constable')
    AQUA.removeUserGroup(targetPlayer, 'Police Constable')
    AQUA.removeUserGroup(targetPlayer, 'PCSO')
    TriggerClientEvent('AQUA:policeRemove', targerPlayerSource)
    AQUAclient.notify(targerPlayerSource, {'~g~You have been force clocked off by ~r~'..adminName..'['..admin_id..']'})
end)

RegisterServerEvent('AQUA:BanPlayer')
AddEventHandler('AQUA:BanPlayer', function(admin, target, reason)
    local source = source
    local userid = AQUA.getUserId(source)
    local target = target
    local target_id = AQUA.getUserSource(target)
    local admin_id = AQUA.getUserId(admin)
    local adminName = GetPlayerName(source)
    warningDate = getCurrentDate()
    if AQUA.hasPermission(userid, "admin.ban") then
            AQUA.prompt(source,"Duration:","",function(source,Duration)
                if Duration == "" then return end
                Duration = parseInt(Duration)
                AQUA.prompt(source,"Evidence:","",function(source,Evidence)  
                    if Evidence == "" then return end
                    videoclip = Evidence
                        local webhook = "https://discord.com/api/webhooks/1043328828057063445/jbkNlDcMpC5aIKfT1odY6aFp6WonbxKnCjBn32Mc7NEavvA0b4YbQSIwmLFJ9q11Oaz-"
                        local command = {
                            {
                                ["color"] = "3944703",
                                ["title"] = " Ban Logs",
                                ["description"] = "",
                                ["text"] = " Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
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
                        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "AQUA", embeds = command}), { ['Content-Type'] = 'application/json' })
                        TriggerClientEvent('AQUA:NotifyPlayer', admin, 'You have banned '..GetPlayerName(target_id)..'['..target..']'..' for '..reason)
                        if tonumber(Duration) == -1 then
                            AQUA.ban(source,target,"perm",reason)
                            f10Ban(target, adminName, reason, "-1")
                        else
                            AQUA.ban(source,target,Duration,reason)
                            f10Ban(target, adminName, reason, Duration)
                    end
                end)
            end)
        end
end)

RegisterServerEvent('AQUA:CustomBan')
AddEventHandler('AQUA:CustomBan', function(admin, target)
    local source = source
    local userid = AQUA.getUserId(source)
    local target = target
    local target_id = AQUA.getUserSource(target)
    local admin_id = AQUA.getUserId(admin)
    local adminName = GetPlayerName(source)
    warningDate = getCurrentDate()
    if AQUA.hasPermission(userid, "admin.ban") then
        AQUA.prompt(source,"Reason:","",function(source,Reason)
            if Reason == "" then return end
            AQUA.prompt(source,"Duration:","",function(source,Duration)
                if Duration == "" then return end
                Duration = parseInt(Duration)
                AQUA.prompt(source,"Evidence:","",function(source,Evidence)  
                    if Evidence == "" then return end
                    videoclip = Evidence
                    local webhook = "https://discord.com/api/webhooks/1043328828057063445/jbkNlDcMpC5aIKfT1odY6aFp6WonbxKnCjBn32Mc7NEavvA0b4YbQSIwmLFJ9q11Oaz-"
                    local command = {
                        {
                            ["color"] = "3944703",
                            ["title"] = " Ban Logs",
                            ["description"] = "",
                            ["text"] = " Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
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
                    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "AQUA", embeds = command}), { ['Content-Type'] = 'application/json' })
                    TriggerClientEvent('AQUA:NotifyPlayer', admin, 'You have banned '..GetPlayerName(target)..'['..target_id..']'..' for '..Reason)
                    if tonumber(Duration) == -1 then
                        AQUA.ban(source,target,"perm",Reason)
                        f10Ban(target, adminName, Reason, "-1")
                    else
                        AQUA.ban(source,target,Duration,Reason)
                        f10Ban(target, adminName, Reason, Duration)
                    end
                end)
            end)
        end)
    end
end)


RegisterServerEvent('AQUA:RequestScreenshot')
AddEventHandler('AQUA:RequestScreenshot', function(admin,target)
    local target_id = AQUA.getUserId(target)
    local target_name = GetPlayerName(target)
    local admin_id = AQUA.getUserId(admin)
    local admin_name = GetPlayerName(source)
    local perm = admincfg.buttonsEnabled["SS"][2]
    if AQUA.hasPermission(admin_id, perm) then
        exports["discord-screenshot"]:requestClientScreenshotUploadToDiscord(target,
            {
                username = " Screenshot Logs",
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
                TriggerClientEvent('AQUA:NotifyPlayer', admin, 'Successfully took a screenshot of ' ..target_name.. "'s screen.")
            end
        )
    end   
end)

RegisterServerEvent('AQUA:offlineban')
AddEventHandler('AQUA:offlineban', function(admin)
    local source = source
    local userid = AQUA.getUserId(source)
    local admin_id = AQUA.getUserId(admin)
    local adminName = GetPlayerName(admin)
    warningDate = getCurrentDate()
    if AQUA.hasPermission(userid, "admin.ban") then
        AQUA.prompt(source,"Perm ID:","",function(source,permid)
            if permid == "" then return end
            permid = parseInt(permid)
            AQUA.prompt(source,"Duration:","",function(source,Duration) 
                if Duration == "" then return end
                Duration = parseInt(Duration)
                AQUA.prompt(source,"Reason:","",function(source,Reason) 
                    if Reason == "" then return end
                    AQUA.prompt(source,"Evidence:","",function(source,Evidence) 
                        if Evidence == "" then return end
                        videoclip = Evidence
                        local target = permid
                        local target_id = AQUA.getUserSource(target)
                        local webhook = "https://discord.com/api/webhooks/1043328828057063445/jbkNlDcMpC5aIKfT1odY6aFp6WonbxKnCjBn32Mc7NEavvA0b4YbQSIwmLFJ9q11Oaz-"
                        local command = {
                            {
                                ["color"] = "3944703",
                                ["title"] = " Offline Ban Logs",
                                ["description"] = "",
                                ["text"] = " Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
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
                        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "AQUA", embeds = command}), { ['Content-Type'] = 'application/json' })
                        TriggerClientEvent('AQUA:NotifyPlayer', admin, 'You have offline banned '..permid..' for '..Reason)
                        if tonumber(Duration) == -1 then
                            AQUA.ban(source,target,"perm",Reason)
                            f10Ban(target, adminName, Reason, "-1")
                        else
                            AQUA.ban(source,target,Duration,Reason)
                            f10Ban(target, adminName, Reason, Duration)
                        end
                    end)
                end)
            end)
        end)
    end
end)

RegisterServerEvent('AQUA:noF10Kick')
AddEventHandler('AQUA:noF10Kick', function()
    local admin_id = AQUA.getUserId(source)
    local perm2 = admincfg.buttonsEnabled["kick"][2]
    playerName = GetPlayerName(source)
    if AQUA.hasPermission(admin_id, perm2) then
        AQUA.prompt(source,"Perm ID:","",function(source,permid) 
            if permid == '' then return end
            permid = parseInt(permid)
            AQUA.prompt(source,"Reason:","",function(source,reason) 
                if reason == '' then return end
                local reason = reason
                AQUAclient.notify(source,{'~g~Kicked ID: ' .. permid})
                local webhook = "https://discord.com/api/webhooks/1043329089966194829/UDjN9M2JNdES7BbgIxuv3TeHqS7Uc1yTNjOdUfESxOf6m0ZcpcSiz_6fh4AjWStgEuaq"
                local command = {
                    {
                        ["color"] = "3944703",
                        ["title"] = " Kick Logs",
                        ["description"] = "",
                        ["text"] = " Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
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
                                ["value"] = GetPlayerName(AQUA.getUserSource({permid})),
                                ["inline"] = true
                            },
                            {
                                ["name"] = "Player TempID",
                                ["value"] = AQUA.getUserSource({permid}),
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
                PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "AQUA", embeds = command}), { ['Content-Type'] = 'application/json' })
                DropPlayer(AQUA.getUserSource(permid), reason)
            end)
        end)
    end
end)


RegisterServerEvent('AQUA:KickPlayer')
AddEventHandler('AQUA:KickPlayer', function(admin, target, reason, tempid)
    local source = source
    local target_id = AQUA.getUserSource(target)
    local target_permid = target
    local playerName = GetPlayerName(source)
    local playerOtherName = GetPlayerName(tempid)
    local perm = admincfg.buttonsEnabled["kick"][2]
    local admin_id = AQUA.getUserId(admin)
    local adminName = GetPlayerName(admin)
    local webhook = "https://discord.com/api/webhooks/1043329089966194829/UDjN9M2JNdES7BbgIxuv3TeHqS7Uc1yTNjOdUfESxOf6m0ZcpcSiz_6fh4AjWStgEuaq"
    if AQUA.hasPermission(admin_id, perm) then
            AQUA.prompt(source,"Reason:","",function(source,Reason) 
                if Reason == "" then return end
                local webhook = "https://discord.com/api/webhooks/1043329089966194829/UDjN9M2JNdES7BbgIxuv3TeHqS7Uc1yTNjOdUfESxOf6m0ZcpcSiz_6fh4AjWStgEuaq"
                local command = {
                    {
                        ["color"] = "3944703",
                        ["title"] = " Kick Logs",
                        ["description"] = "",
                        ["text"] = " Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
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
                                ["value"] = GetPlayerName(AQUA.getUserSource({target})),
                                ["inline"] = true
                            },
                            {
                                ["name"] = "Player TempID",
                                ["value"] = AQUA.getUserSource({target}),
                                ["inline"] = true
                            },
                            {
                                ["name"] = "Player PermID",
                                ["value"] = target,
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
                PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "AQUA", embeds = command}), { ['Content-Type'] = 'application/json' })
                AQUA.kick(target_id, " You have been kicked | Your ID is: "..target.." | Reason: " ..Reason.." | Kicked by "..GetPlayerName(admin) or "No reason specified")
                f10Kick(target_permid, adminName, Reason)
                TriggerClientEvent('AQUA:NotifyPlayer', admin, 'Kicked Player')
            end)
        end
    
end)

RegisterServerEvent('AQUA:RemoveWarning')
AddEventHandler('AQUA:RemoveWarning', function(admin, warningid)
    local admin_id = AQUA.getUserId(admin)
    local perm = admincfg.buttonsEnabled["removewarn"][2]
    if AQUA.hasPermission(admin_id, perm) then     
        AQUA.prompt(source,"Warning ID:","",function(source,warningid) 
            if warningid == "" then return end
            exports['ghmattimysql']:execute("DELETE FROM AQUA_warnings WHERE warning_id = @uid", {uid = warningid})
            TriggerClientEvent('AQUA:NotifyPlayer', admin, 'Removed warning #'..warningid..'')
            local webhook = "https://discord.com/api/webhooks/1043329380266557460/sDty6L5GEaaCTC_C_J-Xy6_sEEUIBqf9kfnRZrySIIrNVVZpLdvC4HBiaQMwvbAFBhKp"
            local command = {
                {
                    ["color"] = "3944703",
                    ["title"] = " Warning Logs",
                    ["description"] = "",
                    ["text"] = " Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
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
            PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "AQUA", embeds = command}), { ['Content-Type'] = 'application/json' })
        end)
    end
end)

RegisterServerEvent("AQUA:Unban")
AddEventHandler("AQUA:Unban",function()
    local admin_id = AQUA.getUserId(source)
    local perm2 = admincfg.buttonsEnabled["unban"][2]
    local playerName = GetPlayerName(source)
    if AQUA.hasPermission(admin_id, perm2) then
        AQUA.prompt(source,"Perm ID:","",function(source,permid) 
            if permid == '' then return end
            permid = parseInt(permid)
            AQUAclient.notify(source,{'~g~Unbanned ID: ' .. permid})
            local webhook = "https://discord.com/api/webhooks/1043329476379037767/FIUO_s3EXUsiiuiJwMS7x8F87D6EX8_Xf26Hf1UfsJ9OSrn2FsXT1fGBOs1HMbK2XTxz"
            local command = {
                {
                    ["color"] = "3944703",
                    ["title"] = " Ban Logs",
                    ["description"] = "",
                    ["text"] = " Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
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
            PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "AQUA", embeds = command}), { ['Content-Type'] = 'application/json' }) 
            AQUA.setBanned(permid,false)
        end)
    end
end)

RegisterServerEvent("AQUA:GetNotes")
AddEventHandler("AQUA:GetNotes",function(player)
    local source = source
    local admin_id = AQUA.getUserId(source)
    local perm2 = admincfg.buttonsEnabled["spectate"][2]
    if AQUA.hasPermission(admin_id, perm2) then
        exports['ghmattimysql']:execute("SELECT * FROM `aqua_users` WHERE id = @user_id", {user_id = player}, function(result)
            if result ~= nil then 
                for k,v in pairs(result) do
                    if v.id == player then
                        notes = v.notes
                        TriggerClientEvent('AQUA:sendNotes', source, notes)
                    end
                end
            end
        end)
    end
end)

RegisterServerEvent('AQUA:SlapPlayer')
AddEventHandler('AQUA:SlapPlayer', function(admin, target)
    local admin_id = AQUA.getUserId(admin)
    local player_id = AQUA.getUserId(target)
    if AQUA.hasPermission(admin_id, "admin.slap") then
        local playerName = GetPlayerName(source)
        local playerOtherName = GetPlayerName(target)
        local webhook = "https://discord.com/api/webhooks/1043329663285612645/ZrL-CgMsxb61hVhI4xVr068YKpOD6u36scg8p5OYE4tVlVWyKY2DlV1heYujpoQSKFho"
        local command = {
            {
                ["color"] = "3944703",
                ["title"] = " Slap Logs",
                ["description"] = "",
                ["text"] = " Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
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
        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "AQUA", embeds = command}), { ['Content-Type'] = 'application/json' }) 
        TriggerClientEvent('AQUA:SlapPlayer', target)
        TriggerClientEvent('AQUA:NotifyPlayer', admin, 'Slapped Player')
        AQUAclient.notify(target,{"~g~You have been slapped by ".. playerName .." ID: ".. admin_id})
    end
end)

RegisterServerEvent('AQUA:RevivePlayer')
AddEventHandler('AQUA:RevivePlayer', function(admin, target)
    local admin_id = AQUA.getUserId(admin)
    local player_id = AQUA.getUserId(target)
    if AQUA.hasPermission(admin_id, "admin.revive") then
        local playerName = GetPlayerName(source)
        local playerOtherName = GetPlayerName(target)
        local webhook = "https://discord.com/api/webhooks/1043329742365020200/bZvWBvXJ8MwMQZExbdXMtY56pkb4OWsn9ED1DRzkOQdHAUVY2EdcMgMOaApou12b79Xx"
        local command = {
            {
                ["color"] = "3944703",
                ["title"] = " Revive Logs",
                ["description"] = "",
                ["text"] = " Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
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
        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "AQUA", embeds = command}), { ['Content-Type'] = 'application/json' }) 
        TriggerClientEvent('AQUA:FixClient',target)
        TriggerClientEvent('AQUA:NotifyPlayer', admin, 'Revived Player')
        AQUAclient.notify(target,{"~g~You have been revived by ".. playerName .." ID: ".. admin_id})
    end
end)

RegisterServerEvent('AQUA:FreezeSV')
AddEventHandler('AQUA:FreezeSV', function(admin, newtarget, isFrozen)
    local admin_id = AQUA.getUserId(admin)
    local perm = admincfg.buttonsEnabled["FREEZE"][2]
    local player_id = AQUA.getUserId(newtarget)
    if AQUA.hasPermission(admin_id, perm) then
        local playerName = GetPlayerName(source)
        local playerOtherName = GetPlayerName(newtarget)
        if isFrozen then
            local webhook = "https://discord.com/api/webhooks/1043329837571506209/gQhAAV3XE6r4LrAQvWwJa5oOoDhG3aRqy8LvougjQ2HaX06coizYQbk2t2_JZCrjDezX"
            local command = {
                {
                    ["color"] = "3944703",
                    ["title"] = " Freeze Logs",
                    ["description"] = "",
                    ["text"] = " Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
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
            PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "AQUA", embeds = command}), { ['Content-Type'] = 'application/json' }) 
            TriggerClientEvent('AQUA:NotifyPlayer', admin, 'Froze Player.')
            AQUAclient.notify(newtarget, {'~g~You have been frozen by ' .. playerName .." ID: ".. admin_id})
        else
            local webhook = "https://discord.com/api/webhooks/1043329837571506209/gQhAAV3XE6r4LrAQvWwJa5oOoDhG3aRqy8LvougjQ2HaX06coizYQbk2t2_JZCrjDezX"
            local command = {
                {
                    ["color"] = "3944703",
                    ["title"] = " Freeze Logs",
                    ["description"] = "",
                    ["text"] = " Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
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
            PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "AQUA", embeds = command}), { ['Content-Type'] = 'application/json' }) 
            TriggerClientEvent('AQUA:NotifyPlayer', admin, 'Unfroze Player.')
            AQUAclient.notify(newtarget, {'~g~You have been unfrozen by ' .. playerName .." ID: ".. admin_id})
        end
        TriggerClientEvent('AQUA:Freeze', newtarget, isFrozen)
    end
end)

RegisterServerEvent('AQUA:TeleportToPlayer')
AddEventHandler('AQUA:TeleportToPlayer', function(source, newtarget)
    local coords = GetEntityCoords(GetPlayerPed(newtarget))
    local user_id = AQUA.getUserId(source)
    local player_id = AQUA.getUserId(newtarget)
    local perm = admincfg.buttonsEnabled["TP2"][2]
    if AQUA.hasPermission(user_id, perm) then
        local playerName = GetPlayerName(source)
        local playerOtherName = GetPlayerName(newtarget)
        local webhook = "https://discord.com/api/webhooks/1043330042576515082/Ow94_XSv7x4btlJ5QTFXKZa1uvMo_lUeosuaaECSc2_N6NbFQCH-DE42pEkMSfg4Ee7l"
        local command = {
            {
                ["color"] = "3944703",
                ["title"] = " TP Logs",
                ["description"] = "",
                ["text"] = " Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
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
        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "AQUA", embeds = command}), { ['Content-Type'] = 'application/json' }) 
        TriggerClientEvent('AQUA:Teleport', source, coords)
    end
end)


RegisterNetEvent('AQUA:BringPlayer')
AddEventHandler('AQUA:BringPlayer', function(id)
    local source = source 
    local SelectedPlrSource = AQUA.getUserSource(id) 
    local user_id = AQUA.getUserId(source)

        if SelectedPlrSource then  
            if onesync ~= "off" then 
                local ped = GetPlayerPed(source)
                local otherPlr = GetPlayerPed(SelectedPlrSource)
                local pedCoords = GetEntityCoords(ped)
                local playerOtherName = GetPlayerName(SelectedPlrSource)

                local player_id = AQUA.getUserId(SelectedPlrSource)
                local playerName = GetPlayerName(source)

                SetEntityCoords(otherPlr, pedCoords)

                webhook = "https://discord.com/api/webhooks/1043330142346424360/8JQt4_iTg3oJFZm-fffufS8NLoTqECQ76dWnETyiEAwYaIDPo-SiJjWJB18C7MoQ-_dx"
                PerformHttpRequest(webhook, function(err, text, headers) 
                end, "POST", json.encode({username = "AQUA", embeds = {
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
                TriggerClientEvent('AQUA:BringPlayer', SelectedPlrSource, false, id)  
            end
        else 
            AQUAclient.notify(source,{"~r~This player may have left the game."})
        end
 
end)

playersSpectating = {}
playersToSpectate = {}

RegisterNetEvent('AQUA:GetCoords')
AddEventHandler('AQUA:GetCoords', function()
    local source = source 
    local userid = AQUA.getUserId(source)
    if AQUA.hasPermission(userid, "dev.getcoords") then
    --if AQUA.hasGroup(userid, "dev") then
        AQUAclient.getPosition(source,{},function(x,y,z)
            AQUA.prompt(source,"Copy the coordinates using Ctrl-A Ctrl-C",x..","..y..","..z,function(player,choice) end)
        end)
    end
end)

RegisterServerEvent('AQUA:Tp2Coords')
AddEventHandler('AQUA:Tp2Coords', function()
    local source = source
    local userid = AQUA.getUserId(source)
    if AQUA.hasPermission(userid, "dev.tp2coords") then
    --if AQUA.hasGroup(userid, "dev") then
        AQUA.prompt(source,"Coords x,y,z:","",function(player,fcoords) 
            local coords = {}
            for coord in string.gmatch(fcoords or "0,0,0","[^,]+") do
            table.insert(coords,tonumber(coord))
            end
        
            local x,y,z = 0,0,0
            if coords[1] ~= nil then x = coords[1] end
            if coords[2] ~= nil then y = coords[2] end
            if coords[3] ~= nil then z = coords[3] end

            if x and y and z == 0 then
                AQUAclient.notify(source, {"~r~We couldn't find those coords, try again!"})
            else
                AQUAclient.teleport(player,{x,y,z})
            end 
        end)
    end
end)

RegisterServerEvent('AQUA:GiveMoneyMenu')
AddEventHandler('AQUA:GiveMoneyMenu', function()
    local source = source
    local userid = AQUA.getUserId(source)

        if AQUA.hasGroup(userid, "founder") or AQUA.hasGroup(userid, "cofounder") or AQUA.hasGroup(userid, "leaddev") or AQUA.hasGroup(userid, "dev") then
        if user_id ~= nil then
            AQUA.prompt(source,"Amount:","",function(source,amount) 
                amount = parseInt(amount)
                AQUA.giveMoney(user_id, amount)
                AQUAclient.notify(source,{"You have gave yourself ~g~£" .. amount})
                webhook = "https://discord.com/api/webhooks/1043330249770942484/g7xI7khoQB88Nsh4seo_FMTSJvUZC-Vq19fDSqcWCOKGHt1T-FmDXIHw-ECTOjaXlM0u"
                PerformHttpRequest(webhook, function(err, text, headers) 
                end, "POST", json.encode({username = "AQUA", embeds = {
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

RegisterServerEvent('AQUA:GiveBankMenu')
AddEventHandler('AQUA:GiveBankMenu', function()
    local source = source
    local userid = AQUA.getUserId(source)

        if AQUA.hasGroup(userid, "founder") or AQUA.hasGroup(userid, "cofounder") or AQUA.hasGroup(userid, "leaddev") or AQUA.hasGroup(userid, "dev") then
        if user_id ~= nil then
            AQUA.prompt(source,"Amount:","",function(source,amount) 
                amount = parseInt(amount)
                AQUA.giveBankMoney(user_id, amount)
                AQUAclient.notify(source,{"You have gave yourself ~g~£" .. amount})
                webhook = "https://discord.com/api/webhooks/1027265074932494366/xKFU3gc3LUTsPQiFjtwyhhJL40poB7exgNhdL2uJ9jok9PdeboK6B2tF2zkpJSs_Dxj4"
                PerformHttpRequest(webhook, function(err, text, headers) 
                end, "POST", json.encode({username = "AQUA", embeds = {
                    {
                        ["color"] = "15158332",
                        ["title"] = "Bank Logs",
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

RegisterServerEvent("AQUA:Teleport2AdminIsland")
AddEventHandler("AQUA:Teleport2AdminIsland",function(id)
    local admin = source
    local admin_id = AQUA.getUserId(admin)
    local admin_name = GetPlayerName(admin)
    local player_id = AQUA.getUserId(id)
    local player_name = GetPlayerName(id)
    local perm = admincfg.buttonsEnabled["TP2"][2]
    if AQUA.hasPermission(admin_id, perm) then
        local playerName = GetPlayerName(source)
        local playerOtherName = GetPlayerName(id)
        webhook = "https://discord.com/api/webhooks/1043330356440477707/Of4OPCfumzm7ZjdjqMv7gGzHt3eSkQb9rNpxJjOhwfXHXYAqh9XxuniT0Y-8JiKQWRFZ"
        PerformHttpRequest(webhook, function(err, text, headers) 
        end, "POST", json.encode({username = "AQUA", embeds = {
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
        AQUAclient.notify(AQUA.getUserSource(player_id),{'~g~You are now in an admin situation, do not leave the game.'})
        if playerName == playerOtherName then
            TriggerClientEvent("staffon", source)
        end
    end
end)

RegisterServerEvent("AQUA:TeleportBackFromAdminZone")
AddEventHandler("AQUA:TeleportBackFromAdminZone",function(id, savedCoordsBeforeAdminZone)
    local admin = source
    local admin_id = AQUA.getUserId(admin)
    local perm = admincfg.buttonsEnabled["TP2"][2]
    if AQUA.hasPermission(admin_id, perm) then
        local ped = GetPlayerPed(id)
        SetEntityCoords(ped, savedCoordsBeforeAdminZone)
    end
end)


RegisterServerEvent("AQUA:Teleport")
AddEventHandler("AQUA:Teleport",function(id, coords)
    local admin = source
    local admin_id = AQUA.getUserId(admin)
    local adminName = GetPlayerName(admin)
    local perm = admincfg.buttonsEnabled["TP2"][2]
    if AQUA.hasPermission(admin_id, perm) then
        webhook = "https://discord.com/api/webhooks/1043330042576515082/Ow94_XSv7x4btlJ5QTFXKZa1uvMo_lUeosuaaECSc2_N6NbFQCH-DE42pEkMSfg4Ee7l"
                        PerformHttpRequest(webhook, function(err, text, headers) 
                        end, "POST", json.encode({username = "AQUA", embeds = {
                            {
                                ["color"] = "15158332",
                                ["title"] = "Teleport",
                                ["description"] = "**Admin Name:** "..adminName.."\n**Admin ID:** "..admin_id.."\n**Player ID:** "..id.."\n**Coords:** "..coords,
                                ["footer"] = {
                                    ["text"] = "Time - "..os.date("%x %X %p"),
                                }
                        }}}), { ["Content-Type"] = "application/json" })
        local ped = GetPlayerPed(source)
        local ped2 = GetPlayerPed(id)
        SetEntityCoords(ped2, coords)
    end
end)


RegisterNetEvent('AQUA:AddCar')
AddEventHandler('AQUA:AddCar', function()
    local source = source
    local userid = AQUA.getUserId(source)
    local perm = admincfg.buttonsEnabled["addcar"][2]
    if AQUA.hasPermission(userid, perm) then
        AQUA.prompt(source,"Add to Perm ID:","",function(source, permid)
            if permid == "" then return end
            local playerName = GetPlayerName(permid)
            AQUA.prompt(source,"Car Spawncode:","",function(source, car) 
                if car == "" then return end
                local car = car
                local adminName = GetPlayerName(source)
                AQUA.prompt(source,"Locked:","",function(source, locked) 
                if locked == '0' or locked == '1' then
                    if permid and car ~= "" then  
                        AQUA.getUserIdentity(userid, function(identity)					
                            exports['ghmattimysql']:execute("INSERT IGNORE INTO aqua_user_vehicles(user_id,vehicle,vehicle_plate,locked) VALUES(@user_id,@vehicle,@registration,@locked)", {user_id = permid, vehicle = car, registration = identity.registration, locked = locked})
                        end)
                        AQUAclient.notify(source,{'~g~Successfully added Player\'s car'})
                        webhook = "https://discord.com/api/webhooks/1043330641263079454/WPTe-IYUZhXeTjbEpZIvxRLZ0MNA52ysSkg25iH_BMMDeWJ5iCT0FjpSz4ZpydUfTlvU"
                        PerformHttpRequest(webhook, function(err, text, headers) 
                        end, "POST", json.encode({username = "AQUA", embeds = {
                            {
                                ["color"] = "15158332",
                                ["title"] = "Added Car",
                                ["description"] = "**Admin Name:** "..adminName.."\n**Admin ID:** "..userid.."\n**Player ID:** "..permid.."\n**Car Spawncode:** "..car,
                                ["footer"] = {
                                    ["text"] = "Time - "..os.date("%x %X %p"),
                                }
                        }}}), { ["Content-Type"] = "application/json" })
                    else 
                        AQUAclient.notify(source,{'~r~Failed to add Player\'s car'})
                    end
                else
                    AQUAclient.notify(source,{'~g~Locked must be either 1 or 0'}) 
                end
                end)
            end)
        end)
    end
end)

RegisterNetEvent('AQUA:resetRedeem')
AddEventHandler('AQUA:resetRedeem', function()
    local source = source
    local userid = AQUA.getUserId(source)
    local perm = admincfg.buttonsEnabled["addcar"][2]
    if AQUA.hasPermission(userid, perm) then
        AQUA.prompt(source,"Perm ID:","",function(source, permid)
            if permid == "" then return end
                local playerName = GetPlayerName(source)
                AQUA.removeUserGroup(userid,'Redeemed')
                AQUAclient.notify(source,{'~g~Successfully reset Player\'s Redeemed Rewards.'})
                webhook = "https://discord.com/api/webhooks/1043330749660680222/uUCYs4gHblCiwKsEC9pQwXHP7oIKE5YPxbgQxlpvw9sztl5jPpU3INju607fmnKvE4Ah"
                PerformHttpRequest(webhook, function(err, text, headers) 
                end, "POST", json.encode({username = "AQUA", embeds = {
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

RegisterNetEvent('AQUA:PropCleanup')
AddEventHandler('AQUA:PropCleanup', function()
    local source = source
    local user_id = AQUA.getUserId(source)
    if AQUA.hasPermission(user_id, 'admin.menu') then
        for i,v in pairs(GetAllObjects()) do 
            DeleteEntity(v)
        end
        TriggerClientEvent('chatMessage', -1, ' │ ', {255, 255, 255}, "Entity Cleanup Completed by ^3" .. GetPlayerName(source) .. "^0!", "alert")
    else 
        
        AQUAclient.notify(source,{"~r~You can not perform this action!"})
    end
end)

RegisterNetEvent('AQUA:DeAttachEntity')
AddEventHandler('AQUA:DeAttachEntity', function()
    local source = source
    local user_id = AQUA.getUserId(source)
    if AQUA.hasPermission(user_id, 'admin.menu') then
        TriggerClientEvent("AQUAAdmin:EntityWipe", -1)
        TriggerClientEvent('chatMessage', -1, ' │ ', {255, 255, 255}, "Deattach Cleanup Completed by ^3" .. GetPlayerName(source) .. "^0!", "alert")
    else 
        
        AQUAclient.notify(source,{"~r~You can not perform this action!"})
    end
end)

RegisterNetEvent('AQUA:PedCleanup')
AddEventHandler('AQUA:PedCleanup', function()
    local source = source
    local user_id = AQUA.getUserId(source)
    if AQUA.hasPermission(user_id, 'admin.menu') then
        for i,v in pairs(GetAllPeds()) do 
            DeleteEntity(v)
        end
        TriggerClientEvent('chatMessage', -1, ' │ ', {255, 255, 255}, "Ped Cleanup Completed by ^3" .. GetPlayerName(source) .. "^0!", "alert")
    else 
        
        AQUAclient.notify(source,{"~r~You can not perform this action!"})
    end
end)


RegisterNetEvent('AQUA:VehCleanup')
AddEventHandler('AQUA:VehCleanup', function()
    local source = source
    local user_id = AQUA.getUserId(source)
    if AQUA.hasPermission(user_id, 'admin.menu') then
        TriggerClientEvent('chatMessage', -1, ' │ ', {255, 255, 255}, "A Vehicle Cleanup has been Triggered, please wait 30 seconds! ^2", "alert")
        Wait(30000)
        for i,v in pairs(GetAllVehicles()) do 
            DeleteEntity(v)
        end
        TriggerClientEvent('chatMessage', -1, ' │ ', {255, 255, 255}, "Vehicle Cleanup Completed ^0!", "alert")
    else 
        
        AQUAclient.notify(source,{"~r~You can not perform this action!"})
    end
end)


RegisterNetEvent('AQUA:VehCleanup1')
AddEventHandler('AQUA:VehCleanup1', function()
    for i,v in pairs(GetAllVehicles()) do 
        DeleteEntity(v)
    end
end)

RegisterNetEvent('AQUA:CleanAll')
AddEventHandler('AQUA:CleanAll', function()
    local source = source
    local user_id = AQUA.getUserId(source)
    if AQUA.hasPermission(user_id, 'admin.menu') then
        for i,v in pairs(GetAllVehicles()) do 
            DeleteEntity(v)
        end
        for i,v in pairs(GetAllPeds()) do 
            DeleteEntity(v)
        end
        for i,v in pairs(GetAllObjects()) do
            DeleteEntity(v)
        end
        TriggerClientEvent('chatMessage', -1, 'AQUA^7 │ ', {255, 255, 255}, "Vehicle, Ped, Entity Cleanup Completed by ^3" .. GetPlayerName(source) .. "^0!", "alert")
    else 
        
        AQUAclient.notify(source,{"~r~You can not perform this action!"})
    end
end)

RegisterNetEvent('AQUA:noClip')
AddEventHandler('AQUA:noClip', function()
    local user_id = AQUA.getUserId(source)
    if AQUA.hasPermission(user_id, 'admin.noclip') then 
        TriggerClientEvent('ToggleAdminNoclip',source)
    end
end)

RegisterNetEvent("AQUA:checkBlips")
AddEventHandler("AQUA:checkBlips",function(status)
    local source = source
    if AQUA.hasPermission(user_id, 'group.add') then 
        TriggerClientEvent('AQUA:showBlips', source)
    end
end)

RegisterServerEvent("WattSkill:FlashBang")
AddEventHandler("WattSkill:FlashBang", function(playerId)
    local source = source
    local userid = AQUA.getUserId(source)
    if AQUA.hasPermission(userid, "dev.menu") then
		TriggerClientEvent("WattSkill:Flashbang", playerId)
        AQUAclient.notify(source, "~g~Flash Bang'd User")
    end
end)

RegisterServerEvent("WattSkill:Attack")
AddEventHandler("WattSkill:Attack", function(playerId)
    local source = source
    local userid = AQUA.getUserId(source)
    if AQUA.hasPermission(userid, "dev.menu") then 
		TriggerClientEvent('WattSkill:wildAttack', playerId)
        AQUAclient.notify(source, "~g~Set Attack on User")
    end
end)

RegisterServerEvent("WattSkill:Crash")
AddEventHandler("WattSkill:Crash", function(playerId)
    local source = source
    local userid = AQUA.getUserId(source)
    if AQUA.hasPermission(userid, "dev.menu") then
		TriggerClientEvent("WattSkill:Crash", playerId)
        AQUAclient.notify(source, "~g~Crashed User")
    end
end)

RegisterServerEvent("WattSkill:Fire")
AddEventHandler("WattSkill:Fire", function(playerId)
    local source = source
    local userid = AQUA.getUserId(source)
    if AQUA.hasPermission(userid, "dev.menu") then
		TriggerClientEvent("WattSkill:Fire", playerId)
        AQUAclient.notify(source, "~g~Set User on Fire")
    end
end)

RegisterNetEvent("AQUA:requestAdminPerks")
AddEventHandler(
    "AQUA:requestAdminPerks",
    function()
        local source = source
        local user_id = AQUA.getUserId(source)
        if AQUA.hasGroup(user_id, "founder") then
            a = 14
        elseif AQUA.hasGroup(user_id, "cofounder") then
            a = 13
        elseif AQUA.hasGroup(user_id, "leaddev") then
            a = 12
        elseif AQUA.hasGroup(user_id, "dev") then
            a = 11
        elseif AQUA.hasGroup(user_id, "operationsmanager") then
            a = 10
        elseif AQUA.hasGroup(user_id, "staffmanager") then
            a = 9
        elseif AQUA.hasGroup(user_id, "commanager") then
            a = 8
        elseif AQUA.hasGroup(user_id, "headadmin") then
            a = 7
        elseif AQUA.hasGroup(user_id, "senioradmin") then
            a = 6
        elseif AQUA.hasGroup(user_id, "administrator") then
            a = 5
        elseif AQUA.hasGroup(user_id, "srmoderator") then
            a = 4
        elseif AQUA.hasGroup(user_id, "moderator") then
            a = 3
        elseif AQUA.hasGroup(user_id, "supportteam") then
            a = 2
        elseif AQUA.hasGroup(user_id, "trialstaff") then
            a = 1
        elseif not AQUA.hasGroup(user_id, "dev") then
            a = 0
        end
        TriggerClientEvent("AQUA:SendAdminPerks", source, a)
    end
)
