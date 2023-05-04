
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
    ["kick"] = {true, "admin.kick"},
    ["nof10kick"] = {true, "admin.nof10kick"},
    ["revive"] = {true, "admin.revive"},
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

RegisterServerEvent('Galaxy:OpenSettings')
AddEventHandler('Galaxy:OpenSettings', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id ~= nil and vRP.hasPermission(user_id, "admin.menu") then
        TriggerClientEvent("Galaxy:OpenSettingsMenu", source, true)
    else
        TriggerClientEvent("Galaxy:OpenSettingsMenu", source, false)
    end
end)

RegisterServerEvent("Galaxy:GetPlayerData")
AddEventHandler("Galaxy:GetPlayerData",function()
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
            players_table[user_idz] = {name, p, user_idz}
            table.insert (useridz, user_idz)
            else
                DropPlayer(p, "[Galaxy] You Were Kicked")
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
        TriggerClientEvent("Galaxy:SendPlayersInfo", source, players_table, menu_btns_table)
    end
end)

RegisterServerEvent("Galaxy:getGroups")
AddEventHandler("Galaxy:getGroups",function(temp, perm)
    local user_groups = vRP.getUserGroups(perm)
    TriggerClientEvent("Galaxy:gotgroups", source, user_groups)
end)

RegisterServerEvent("Galaxy:CheckPOV")
AddEventHandler("Galaxy:CheckPOV",function(userperm)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "admin.menu") then
        if vRP.hasGroup(userperm, 'pov') then
            TriggerClientEvent('Galaxy:ReturnPOV', source, true)
        elseif not vRP.hasGroup(userperm, 'pov') then
            TriggerClientEvent('Galaxy:ReturnPOV', source, false)
        end
    else 
        print(GetPlayerName(source) .. ' is cheating! He\'s triggering events without permission')
    end
end)

local onesync = GetConvar('onesync', nil)
RegisterNetEvent('vRPAdmin:SpectatePlr')
AddEventHandler('vRPAdmin:SpectatePlr', function(id)
    local source = source 
    local SelectedPlrSource = vRP.getUserSource(id) 
    local userid = vRP.getUserId(source)
 
        if SelectedPlrSource then  
            if onesync ~= "off" then 
                local ped = GetPlayerPed(SelectedPlrSource)
                local pedCoords = GetEntityCoords(ped)
                print(pedCoords)
                TriggerClientEvent('vRPAdmin:Spectate', source, SelectedPlrSource, pedCoords)
            else 
                TriggerClientEvent('vRPAdmin:Spectate', source, SelectedPlrSource)  
            end
        else 
            vRPclient.notify(source,{"~r~This player may have left the game."})
        end

end)

RegisterServerEvent("Galaxy:addGroup")
AddEventHandler("Galaxy:addGroup",function(perm, selgroup)
    local admin_temp = source
    local admin_perm = vRP.getUserId(admin_temp)
    local user_id = vRP.getUserId(source)
    local permsource = vRP.getUserSource(perm)
    local playerName = GetPlayerName(source)
    local povName = GetPlayerName(permsource)
    if vRP.hasPermission(user_id, "group.add") then
        if selgroup == "founder" and not vRP.hasPermission(admin_perm, "group.add.founder") then
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
        elseif selgroup == "moderator" and not vRP.hasPermission(admin_perm, "group.add.moderator") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "trialstaff" and not vRP.hasPermission(admin_perm, "group.add.trial") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "vip" and not vRP.hasPermission(admin_perm, "group.add.vip") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "pov" and not vRP.hasGroup(perm, "pov") then
            webhook = "https://discord.com/api/webhooks/938625778520825856/KDktXzFuUR7S_Bquao43t-cxRiavpzGtFsK5M-yNOhKeVvT3Q_COBnbMvL4SbO4uz-gW"
            PerformHttpRequest(webhook, function(err, text, headers) 
            end, "POST", json.encode({username = "Galaxy Roleplay", embeds = {
                {
                    ["color"] = "15158332",
                    ["title"] = playerName.." put "..povName.." onto the POV List.",
                    ["description"] = "Admin Name: **"..playerName.."** \nAdmin ID: **"..admin_perm.."** \nPlayer ID: **"..perm.."** \nPlayer Name: **"..povName.."**",
                    ["footer"] = {
                        ["text"] = "Time - "..os.date("%x %X %p"),
                    }
            }
            }}), { ["Content-Type"] = "application/json" })
            vRP.addUserGroup(perm, "pov")
        else
            vRP.addUserGroup(perm, selgroup)
        end
    else
        print("Stop trying to add a group u fucking cheater")
    end
end)

RegisterServerEvent("Galaxy:removeGroup")
AddEventHandler("Galaxy:removeGroup",function(perm, selgroup)
    local user_id = vRP.getUserId(source)
    local admin_temp = source
    local permsource = vRP.getUserSource(perm)
    local playerName = GetPlayerName(source)
    local povName = GetPlayerName(permsource)
    if vRP.hasPermission(user_id, "group.remove") then
        if selgroup == "founder" and not vRP.hasPermission(user_id, "group.remove.founder") then
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
        elseif selgroup == "moderator" and not vRP.hasPermission(user_id, "group.remove.moderator") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "trialstaff" and not vRP.hasPermission(user_id, "group.remove.trial") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "vipgarage" and not vRP.hasPermission(user_id, "group.remove.vipgarage") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "pov" and vRP.hasGroup(perm, "pov") then
            webhook = "https://discord.com/api/webhooks/938625778520825856/KDktXzFuUR7S_Bquao43t-cxRiavpzGtFsK5M-yNOhKeVvT3Q_COBnbMvL4SbO4uz-gW"
            PerformHttpRequest(webhook, function(err, text, headers) 
            end, "POST", json.encode({username = "Galaxy Roleplay", embeds = {
                {
                    ["color"] = "15158332",
                    ["title"] = playerName.." removed "..povName.." from the POV List.",
                    ["description"] = "Admin Name: **"..playerName.."** \nAdmin ID: **"..user_id.."** \nPlayer ID: **"..perm.."** \nPlayer Name: **"..povName.."**",
                    ["footer"] = {
                        ["text"] = "Time - "..os.date("%x %X %p"),
                    }
            }
            }}), { ["Content-Type"] = "application/json" })
            vRP.removeUserGroup(perm, "pov")
        else
            vRP.removeUserGroup(perm, selgroup)
        end
    else 
        print("Stop trying to add a group u fucking cheater")
    end
end)

RegisterServerEvent('Galaxy:BanPlayer')
AddEventHandler('Galaxy:BanPlayer', function(admin, target, reason, duration)
    local target = target
    local target_id = vRP.getUserSource(target)
    local admin_id = vRP.getUserId(admin)
    if vRP.hasPermission(user_id, "admin.ban") then
        if tonumber(duration) then 
            local playerName = GetPlayerName(source)
            local playerOtherName = GetPlayerName(target)
            if tonumber(duration) == -1 then
                vRP.ban(source,target,"perm",reason or "No reason given")
                saveBanLog(target_id, GetPlayerName(admin), reason, duration)
            else
                vRP.ban(source,target,duration,reason or "No reason given")
                saveBanLog(target_id, GetPlayerName(admin), reason, duration)
                print(admin, target_id)
                TriggerEvent('Galaxy:BanPlayerLog', target, GetPlayerName(admin), reason, duration)
                webhook = "https://discord.com/api/webhooks/933909048074592287/eK5eZKraSOjavdagmkMkL8Fb0tp0Ok8ILJmMiLooztThUNoJo-APjwoqsp7D3sp49hXY"
                PerformHttpRequest(webhook, function(err, text, headers) 
                end, "POST", json.encode({username = "Galaxy Roleplay", embeds = {
                    {
                        ["color"] = "15158332",
                        ["title"] = "Banned ID: "..target .." out of the server. Reason: "..reason,
                        ["description"] = "Admin Name: **"..GetPlayerName(admin).."** \nAdmin ID: **"..vRP.getUserId(admin).."** \nPlayer ID: **"..target.."** \nDescription: **Banned ID: "..target.." out of the server. Reason: "..reason.."**",
                        ["footer"] = {
                            ["text"] = "Time - "..os.date("%x %X %p"),
                        }
                }
                }}), { ["Content-Type"] = "application/json" })
                TriggerClientEvent('Galaxy:Notify', admin, 'Banned Player')
            end
        end
    end
end)

RegisterServerEvent('Galaxy:KickPlayer')
AddEventHandler('Galaxy:KickPlayer', function(admin, target, reason, tempid)
    local target_id = vRP.getUserSource(target)
    local target_permid = target
    local playerName = GetPlayerName(source)
    local playerOtherName = GetPlayerName(tempid)
    local perm = admincfg.buttonsEnabled["kick"][2]
    local admin_id = vRP.getUserId(admin)
    if vRP.hasPermission(admin_id, perm) then
        webhook = "https://discord.com/api/webhooks/938118443239112735/KBDXMwBxB8CKN2Gp2WAViFLnN8Hzk-URFZidMT367rqvLyL9NDjbxBv1Pl56Y2TA1Ts9"
        PerformHttpRequest(webhook, function(err, text, headers) 
        end, "POST", json.encode({username = "Galaxy Roleplay", embeds = {
            {
                ["color"] = "15158332",
                ["title"] = "Kicked "..playerOtherName.." out of the server. Reason: "..reason,
                ["description"] = "Admin Name: **"..playerName.."** \nAdmin ID: **"..admin_id.."** \nPlayer ID: **"..target_permid.."** \nReason:" ..reason,
                ["footer"] = {
                    ["text"] = "Time - "..os.date("%x %X %p"),
                }
        }
        }}), { ["Content-Type"] = "application/json" })
        vRP.kick(target_id, "[Galaxy] You have been kicked | Your ID is: "..target.." | Reason: "..reason.." | Kicked by "..GetPlayerName(admin) or "No reason specified")
        TriggerEvent("Galaxy:saveKickLog",target,GetPlayerName(admin),reason)
        TriggerClientEvent('Galaxy:Notify', admin, 'Kicked Player')
    end
end)

RegisterServerEvent('Galaxy:KickPlayerNoF10')
AddEventHandler('Galaxy:KickPlayerNoF10', function(admin, target, reason)
    local target_id = vRP.getUserSource(target)
    local target_permid = vRP.getUserId(target)
    local perm = admincfg.buttonsEnabled["kick"][2]
    local admin_id = vRP.getUserId(admin)
    if vRP.hasPermission(admin_id, perm) then
        local playerName = GetPlayerName(source)
        local playerOtherName = GetPlayerName(target)
        webhook = "https://discord.com/api/webhooks/938118443239112735/KBDXMwBxB8CKN2Gp2WAViFLnN8Hzk-URFZidMT367rqvLyL9NDjbxBv1Pl56Y2TA1Ts9"
        PerformHttpRequest(webhook, function(err, text, headers) 
        end, "POST", json.encode({username = "Galaxy Roleplay", embeds = {
            {
                ["color"] = "15158332",
                ["title"] = "No F10 Kicked "..playerOtherName.." out of the server. Reason: "..reason,
                ["description"] = "Admin Name: **"..playerName.."** \nAdmin ID: **"..admin_id.."** \nPlayer ID: **"..target_permid.."** \nDescription: **No F10 Kicked "..playerOtherName.." out of the server. Reason: "..reason.."**",
                ["footer"] = {
                    ["text"] = "Time - "..os.date("%x %X %p"),
                }
        }
        }}), { ["Content-Type"] = "application/json" })
        vRP.kick(target_id, "[Galaxy] You have been kicked | Your ID is: "..target.." | Reason: "..reason.." | Kicked by "..GetPlayerName(admin) or "No reason specified")
        TriggerClientEvent('Galaxy:Notify', admin, 'Kicked Player')
    end
end)

RegisterServerEvent('Galaxy:RemoveWarning')
AddEventHandler('Galaxy:RemoveWarning', function(admin, warningid)
    local admin_id = vRP.getUserId(admin)
    local perm = admincfg.buttonsEnabled["removewarn"][2]
    if vRP.hasPermission(admin_id, perm) then
        exports['ghmattimysql']:execute("DELETE FROM vrp_warnings WHERE warning_id = @uid", {uid = warningid})
        TriggerClientEvent('Galaxy:Notify', admin, 'Removed #'..warningid..' Warning ID')
    end
end)

RegisterServerEvent("Galaxy:Unban")
AddEventHandler("Galaxy:Unban",function(perm1)
    local admin_id = vRP.getUserId(source)
    local perm2 = admincfg.buttonsEnabled["ban"][2]
    playerName = GetPlayerName(source)
    if vRP.hasPermission(admin_id, perm2) then

        ExecuteCommand('unban ' .. perm2)
        vRPclient.notify(source,{'~g~Unbanned ID: ' .. perm2})
        webhook = "https://discord.com/api/webhooks/933909048074592287/eK5eZKraSOjavdagmkMkL8Fb0tp0Ok8ILJmMiLooztThUNoJo-APjwoqsp7D3sp49hXY"
        PerformHttpRequest(webhook, function(err, text, headers) 
        end, "POST", json.encode({username = "Galaxy Roleplay", embeds = {
            {
                ["color"] = "15158332",
                ["title"] = "Unbanned ID: "..perm2,
                ["description"] = "Admin Name: **"..playerName.."** \nPermID: **"..admin_id.."** \nDescription: **Unbanned ID: "..perm2.."**",
                ["footer"] = {
                    ["text"] = "Time - "..os.date("%x %X %p"),
                }
        }
        }}), { ["Content-Type"] = "application/json" })
    else
        print("Cheater tried fucking unbanning, the nerd")
    end
end)

RegisterServerEvent('Galaxy:SlapPlayer')
AddEventHandler('Galaxy:SlapPlayer', function(admin, target)
    local admin_id = vRP.getUserId(admin)
    if vRP.hasPermission(admin_id, "admin.slap") then
        local playerName = GetPlayerName(source)
        local playerOtherName = GetPlayerName(target)
        webhook = "https://discord.com/api/webhooks/938626351039127594/PEqupdFAqyYOzvk0KaA28qfF1xhAGcqaHNywBGdv31UufqAl-JcIg0DXRQ8RuAjB9ArN"
        PerformHttpRequest(webhook, function(err, text, headers) 
        end, "POST", json.encode({username = "Galaxy Roleplay", embeds = {
            {
                ["color"] = "15158332",
                ["title"] = "Slapped "..playerOtherName,
                ["description"] = "Admin Name: **"..playerName.."** \nPermID: **"..user_id.."** \nDescription: **Slapped "..playerOtherName.."**",
                ["footer"] = {
                    ["text"] = "Time - "..os.date("%x %X %p"),
                }
        }
        }}), { ["Content-Type"] = "application/json" })
        TriggerClientEvent('Galaxy:SlapPlayer', target)
        TriggerClientEvent('Galaxy:Notify', admin, 'Slapped Player')
    end
end)

RegisterServerEvent('Galaxy:RevivePlayer')
AddEventHandler('Galaxy:RevivePlayer', function(admin, target)
    local admin_id = vRP.getUserId(admin)
    if vRP.hasPermission(admin_id, "admin.revive") then
        local playerName = GetPlayerName(source)
        local playerOtherName = GetPlayerName(target)
        webhook = "https://discord.com/api/webhooks/938117862499942401/RzjozFs9s8EDCP-6aRsjlelFbrbzc9sW0IBibPim-1mRamypLmGB3A_GzuTxemmiGUxD"
        PerformHttpRequest(webhook, function(err, text, headers) 
        end, "POST", json.encode({username = "Galaxy Roleplay", embeds = {
            {
                ["color"] = "15158332",
                ["title"] = "Revived "..playerOtherName,
                ["description"] = "Admin Name: **"..playerName.."** \nPermID: **"..user_id.."** \nDescription: **Revived "..playerOtherName.."**",
                ["footer"] = {
                    ["text"] = "Time - "..os.date("%x %X %p"),
                }
        }
        }}), { ["Content-Type"] = "application/json" })
        TriggerClientEvent('GRP:FixClient',target)
        TriggerClientEvent('Galaxy:Notify', admin, 'Revived Player')
    end
end)

RegisterServerEvent('Galaxy:FreezeSV')
AddEventHandler('Galaxy:FreezeSV', function(admin, newtarget, isFrozen)
    local admin_id = vRP.getUserId(admin)
    local perm = admincfg.buttonsEnabled["FREEZE"][2]
    if vRP.hasPermission(admin_id, perm) then
        local playerName = GetPlayerName(source)
        local playerOtherName = GetPlayerName(newtarget)
        if isFrozen then
            webhook = "https://discord.com/api/webhooks/933909317873197077/YY7GsQXhfpboWM_n23VGefKRGQatDvoCKmYSM2pdi1lwKsV7Ez88rYVFIQobKWyt-dEU"
            PerformHttpRequest(webhook, function(err, text, headers) 
            end, "POST", json.encode({username = "Galaxy Roleplay", embeds = {
                {
                    ["color"] = "15158332",
                    ["title"] = "Froze "..playerOtherName,
                    ["description"] = "Admin Name: **"..playerName.."** \nPermID: **"..user_id.."** \nDescription: **Froze "..playerOtherName.."**",
                    ["footer"] = {
                        ["text"] = "Time - "..os.date("%x %X %p"),
                    }
            }
            }}), { ["Content-Type"] = "application/json" })
        else
            webhook = "https://discord.com/api/webhooks/933909317873197077/YY7GsQXhfpboWM_n23VGefKRGQatDvoCKmYSM2pdi1lwKsV7Ez88rYVFIQobKWyt-dEU"
            PerformHttpRequest(webhook, function(err, text, headers) 
            end, "POST", json.encode({username = "Galaxy Roleplay", embeds = {
                {
                    ["color"] = "15158332",
                    ["title"] = "Unfroze "..playerOtherName,
                    ["description"] = "Admin Name: **"..playerName.."** \nPermID: **"..user_id.."** \nDescription: **Unfroze "..playerOtherName.."**",
                    ["footer"] = {
                        ["text"] = "Time - "..os.date("%x %X %p"),
                    }
            }
            }}), { ["Content-Type"] = "application/json" })
        end
        TriggerClientEvent('Galaxy:Freeze', newtarget, isFrozen)
        TriggerClientEvent('Galaxy:Notify', admin, 'Froze Player')
    end
end)

RegisterServerEvent('Galaxy:TeleportToPlayer')
AddEventHandler('Galaxy:TeleportToPlayer', function(source, newtarget)
    local coords = GetEntityCoords(GetPlayerPed(newtarget))
    local user_id = vRP.getUserId(source)
    local perm = admincfg.buttonsEnabled["TP2"][2]
    if vRP.hasPermission(user_id, perm) then
        local playerName = GetPlayerName(source)
        local playerOtherName = GetPlayerName(newtarget)
        webhook = "https://discord.com/api/webhooks/938604816349933628/Do7ox3pvqk3ZETbBgfrmkk7xoZgPww753zIXWIo3RfjHK7eYHDv4XNjtkw73fWHPoh_e"
        PerformHttpRequest(webhook, function(err, text, headers) 
        end, "POST", json.encode({username = "Galaxy Roleplay", embeds = {
            {
                ["color"] = "15158332",
                ["title"] = "Teleported to "..playerOtherName,
                ["description"] = "Admin Name: **"..playerName.."** \nPermID: **"..user_id.."** \nDescription: **Teleported to "..playerOtherName.."**",
                ["footer"] = {
                    ["text"] = "Time - "..os.date("%x %X %p"),
                }
        }
        }}), { ["Content-Type"] = "application/json" })
        TriggerClientEvent('Galaxy:Teleport', source, coords)
    end
end)

RegisterServerEvent('Galaxy:TeleportToMe')
AddEventHandler('Galaxy:TeleportToMe', function(source, newtarget)
    local user_id = vRP.getUserId(source)
    local perm = admincfg.buttonsEnabled["TP2ME"][2]
    if vRP.hasPermission(user_id, perm) then
        local playerName = GetPlayerName(source)
        local playerOtherName = GetPlayerName(newtarget)
        webhook = "https://discord.com/api/webhooks/938604816349933628/Do7ox3pvqk3ZETbBgfrmkk7xoZgPww753zIXWIo3RfjHK7eYHDv4XNjtkw73fWHPoh_e"
        PerformHttpRequest(webhook, function(err, text, headers) 
        end, "POST", json.encode({username = "Galaxy Roleplay", embeds = {
            {
                ["color"] = "15158332",
                ["title"] = "Brang "..playerOtherName,
                ["description"] = "Admin Name: **"..playerName.."** \nPermID: **"..user_id.."** \nDescription: **Brang "..playerOtherName.."**",
                ["footer"] = {
                    ["text"] = "Time - "..os.date("%x %X %p"),
                }
        }
    }}), { ["Content-Type"] = "application/json" })
        TriggerClientEvent('Galaxy:Teleport2Me2', newtarget, source)
    end
end)


RegisterNetEvent('vRPAdmin:Bring')
AddEventHandler('vRPAdmin:Bring', function(id)
    local source = source 
    local SelectedPlrSource = vRP.getUserSource(id) 
    local userid = vRP.getUserId(source)
  
        if SelectedPlrSource then  
            if onesync ~= "off" then 
                local ped = GetPlayerPed(source)
                local otherPlr = GetPlayerPed(SelectedPlrSource)
                local pedCoords = GetEntityCoords(ped)
                local playerOtherName = GetPlayerName(SelectedPlrSource)
                SetEntityCoords(otherPlr, pedCoords)

                webhook = "https://discord.com/api/webhooks/938604816349933628/Do7ox3pvqk3ZETbBgfrmkk7xoZgPww753zIXWIo3RfjHK7eYHDv4XNjtkw73fWHPoh_e"
                PerformHttpRequest(webhook, function(err, text, headers) 
                end, "POST", json.encode({username = "Galaxy Roleplay", embeds = {
                    {
                        ["color"] = "15158332",
                        ["title"] = "Brang "..playerOtherName,
                        ["description"] = "Admin Name: **"..GetPlayerName(source).."** \nPermID: **"..userid.."** \nDescription: **Brang "..playerOtherName.."**",
                        ["footer"] = {
                            ["text"] = "Time - "..os.date("%x %X %p"),
                        }
                }
            }}), { ["Content-Type"] = "application/json" })
            else 
                TriggerClientEvent('vRPAdmin:Bring', SelectedPlrSource, false, id)  
            end
        else 
            vRPclient.notify(source,{"~r~This player may have left the game."})
        end
 
end)

playersSpectating = {}
playersToSpectate = {}

RegisterServerEvent('Galaxy:SpectateCheck')
AddEventHandler('Galaxy:SpectateCheck', function(newtarget)
    local admin_id = source
    local user_id = vRP.getUserId(source)
    local perm = admincfg.buttonsEnabled["spectate"][2]
    if vRP.hasPermission(user_id, perm) then
        local playerName = GetPlayerName(source)
        local playerOtherName = GetPlayerName(newtarget)
        webhook = "https://discord.com/api/webhooks/938117862499942401/RzjozFs9s8EDCP-6aRsjlelFbrbzc9sW0IBibPim-1mRamypLmGB3A_GzuTxemmiGUxD"
        PerformHttpRequest(webhook, function(err, text, headers) 
        end, "POST", json.encode({username = "Galaxy Roleplay", embeds = {
            {
                ["color"] = "15158332",
                ["title"] = "Started spectating "..playerOtherName,
                ["description"] = "Admin Name: **"..playerName.."** \nPermID: **"..user_id.."** \nDescription: **Started spectating "..playerOtherName.."**",
                ["footer"] = {
                    ["text"] = "Time - "..os.date("%x %X %p"),
                }
        }
    }}), { ["Content-Type"] = "application/json" })

        TriggerClientEvent('Galaxy:SpectateClient', source, newtarget)
        
    end
end)

RegisterServerEvent('Galaxy:Prompt')
AddEventHandler('Galaxy:Prompt', function(shit)
    local admin_id = source
    local user_id = vRP.getUserId(admin)
    vRP.prompt(source, "Clothing:", shit, function(player, PermID)
    end)
end)

RegisterNetEvent('VRPDEV:GetCoords')
AddEventHandler('VRPDEV:GetCoords', function()
    local source = source 
    local userid = vRP.getUserId(source)
    if vRP.hasGroup(userid, "dev") then
        vRPclient.getPosition(source,{},function(x,y,z)
            vRP.prompt(source,"Copy the coordinates using Ctrl-A Ctrl-C",x..","..y..","..z,function(player,choice) end)
        end)
    end
end)

RegisterServerEvent('Galaxy:Tp2Coords')
AddEventHandler('Galaxy:Tp2Coords', function()
    local source = source
    local userid = vRP.getUserId(source)
    if vRP.hasGroup(userid, "dev") then
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

RegisterServerEvent('Galaxy:GiveMoney2')
AddEventHandler('Galaxy:GiveMoney2', function()
    local source = source
    local userid = vRP.getUserId(source)
    if vRP.hasGroup(userid, "dev") then
        if user_id ~= nil then
            vRP.prompt(source,"Amount:","",function(source,amount) 
                amount = parseInt(amount)
                vRP.giveMoney(user_id, amount)
                vRPclient.notify(source,{"You have gave youself ~g~£" .. amount})
            end)
        end

    end
end)

RegisterServerEvent("Galaxy:Teleport2AdminIsland")
AddEventHandler("Galaxy:Teleport2AdminIsland",function(id)
    local admin = source
    local admin_id = vRP.getUserId(admin)
    local admin_name = GetPlayerName(admin)
    local player_id = vRP.getUserId(id)
    local player_name = GetPlayerName(id)
    local perm = admincfg.buttonsEnabled["TP2"][2]
    if vRP.hasPermission(admin_id, perm) then
        local playerName = GetPlayerName(source)
        local playerOtherName = GetPlayerName(id)
        webhook = "https://discord.com/api/webhooks/938604816349933628/Do7ox3pvqk3ZETbBgfrmkk7xoZgPww753zIXWIo3RfjHK7eYHDv4XNjtkw73fWHPoh_e"
        PerformHttpRequest(webhook, function(err, text, headers) 
        end, "POST", json.encode({username = "Galaxy Roleplay", embeds = {
            {
                ["color"] = "15158332",
                ["title"] = "Teleported "..playerOtherName.." to admin island",
                ["description"] = "Admin Name: **"..playerName.."** \nPermID: **"..user_id.."** \nDescription: **Teleported "..playerOtherName.." to admin island**",
                ["footer"] = {
                    ["text"] = "Time - "..os.date("%x %X %p"),
                }
        }
    }}), { ["Content-Type"] = "application/json" })
        vRPclient.getPosition(id, {}, function(x,y,z)
            local location = tostring(x)..','..tostring(y)..','..tostring(z)
            exports['ghmattimysql']:execute("INSERT INTO vrp_tp_data (user_id, last_location) VALUES( @user_id, @location ) ON DUPLICATE KEY UPDATE `last_location` = @location", {user_id = id, location = location}, function() end)
        end)
        local ped = GetPlayerPed(source)
        local ped2 = GetPlayerPed(id)
        SetEntityCoords(ped2, 3490.0769042969,2585.4392089844,14.149716377258)
    end
end)

RegisterServerEvent("Galaxy:Teleport")
AddEventHandler("Galaxy:Teleport",function(id, coords)
    local admin = source
    local admin_id = vRP.getUserId(admin)

    local perm = admincfg.buttonsEnabled["TP2"][2]
    if vRP.hasPermission(admin_id, perm) then

        local ped = GetPlayerPed(source)
        local ped2 = GetPlayerPed(id)
        SetEntityCoords(ped2, coords)
    end
end)


RegisterServerEvent("Galaxy:Telepor2")
AddEventHandler("Galaxy:Telepor2",function(id)

    local ped2 = GetPlayerPed(id)
    SetEntityCoords(ped2, 3490.0769042969,2585.4392089844,14.149716377258)
   
end)

RegisterServerEvent("Galaxy:returnplayer")
AddEventHandler("Galaxy:returnplayer",function(id)
    local admin = source
    local admin_id = vRP.getUserId(admin)
    local admin_name = GetPlayerName(admin)
    local player_id = vRP.getUserId(id)
    local player_name = GetPlayerName(id)
    local perm = admincfg.buttonsEnabled["TP2"][2]
    if vRP.hasPermission(admin_id, perm) then
        local playerName = GetPlayerName(source)
        local playerOtherName = GetPlayerName(id)
        webhook = "https://discord.com/api/webhooks/938604816349933628/Do7ox3pvqk3ZETbBgfrmkk7xoZgPww753zIXWIo3RfjHK7eYHDv4XNjtkw73fWHPoh_e"
        PerformHttpRequest(webhook, function(err, text, headers) 
        end, "POST", json.encode({username = "Galaxy Roleplay", embeds = {
            {
                ["color"] = "15158332",
                ["title"] = "Returned "..playerOtherName.." to previous location",
                ["description"] = "Admin Name: **"..playerName.."** \nPermID: **"..user_id.."** \nDescription: **Returned "..playerOtherName.." to previous location**",
                ["footer"] = {
                    ["text"] = "Time - "..os.date("%x %X %p"),
                }
        }
    }}), { ["Content-Type"] = "application/json" })
        exports['ghmattimysql']:execute("SELECT last_location FROM vrp_tp_data WHERE user_id = @user_id", {user_id = id}, function(result)
            local t = {}
    
            for i in result[1].last_location:gmatch("([^,%s]+)") do  
                t[#t + 1] = i
            end 
    
            local x = tonumber(t[1])
            local y = tonumber(t[2])
            local z = tonumber(t[3])
            local coords = vector3(x,y,z)
            TriggerClientEvent("Galaxy:TPCoords", id, coords)
        end)
        exports['ghmattimysql']:execute("DELETE FROM vrp_tp_data WHERE `user_id` = @user_id", {user_id = id}, function() end)        
    end
end)

RegisterNetEvent('Galaxy:AddCar')
AddEventHandler('Galaxy:AddCar', function(id, car)
    local source = source 
    local SelectedPlrSource = vRP.getUserSource(id) 
    local userid = vRP.getUserId(source)
    local perm = admincfg.buttonsEnabled["addcar"][2]
    if vRP.hasPermission(userid, perm) then
        local playerName = GetPlayerName(source)
        local playerOtherName = GetPlayerName(SelectedPlrSource)
        webhook = "https://discord.com/api/webhooks/938117862499942401/RzjozFs9s8EDCP-6aRsjlelFbrbzc9sW0IBibPim-1mRamypLmGB3A_GzuTxemmiGUxD"
        PerformHttpRequest(webhook, function(err, text, headers) 
        end, "POST", json.encode({username = "Galaxy Roleplay", embeds = {
            {
                ["color"] = "15158332",
                ["title"] = "Gave "..playerOtherName.." a vehicle: "..car,
                ["description"] = "Admin Name: **"..playerName.."** \nPermID: **"..userid.."** \nDescription: **Gave "..playerOtherName.." a vehicle: "..car.."**",
                ["footer"] = {
                    ["text"] = "Time - "..os.date("%x %X %p"),
                }
        }
    }}), { ["Content-Type"] = "application/json" })
        if SelectedPlrSource and car ~= "" then  
            vRP.getUserIdentity(userid, function(identity)					
                exports['ghmattimysql']:execute("INSERT IGNORE INTO vrp_user_vehicles(user_id,vehicle,vehicle_plate) VALUES(@user_id,@vehicle,@registration)", {user_id = id, vehicle = car, registration = "P "..identity.registration})
            end)
            vRPclient.notify(source,{'~g~Successfully added Player\'s car'})
        else 
            vRPclient.notify(source,{'~r~Failed to add Player\'s car'})
        end
    end
end)

RegisterNetEvent('Galaxy:PropCleanup')
AddEventHandler('Galaxy:PropCleanup', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'admin.menu') then
        TriggerClientEvent('chat:addMessage', -1, {
            color = { 255, 0, 0},
            multiline = true,
            args = {"[Galaxy]", 'A Entity cleanup has been triggered!'}
          })
          Wait(0)
          for i,v in pairs(GetAllObjects()) do 
             DeleteEntity(v)
          end
          TriggerClientEvent('chat:addMessage', -1, {
            color = { 255, 0, 0},
            multiline = true,
            args = {"[Galaxy]", "Entity Cleanup Completed! ^1( " .. GetPlayerName(source) .. " )"}
          })
        else 
        print(GetPlayerName(source) .. ' is cheating! He\'s triggering events without permission')
        vRPclient.notify(source,{"~r~You can not perform this action!"})
    end
end)

RegisterNetEvent('Galaxy:DeAttachEntity')
AddEventHandler('Galaxy:DeAttachEntity', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'admin.menu') then
        TriggerClientEvent('chat:addMessage', -1, {
            color = { 255, 0, 0},
            multiline = true,
            args = {"[Galaxy]", 'A Deattach cleanup has been triggered!'}
          })
          TriggerClientEvent("vRPAdmin:EntityWipe", -1)
          TriggerClientEvent('chat:addMessage', -1, {
            color = { 255, 0, 0},
            multiline = true,
            args = {"[Galaxy]", " Deattach Cleanup Completed ^1( " .. GetPlayerName(source) .. " )"}
          })
        else 
        print(GetPlayerName(source) .. ' is cheating! He\'s triggering events without permission')
        vRPclient.notify(source,{"~r~You can not perform this action!"})
    end
end)

RegisterNetEvent('Galaxy:PedCleanup')
AddEventHandler('Galaxy:PedCleanup', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'admin.menu') then
          for i,v in pairs(GetAllPeds()) do 
             DeleteEntity(v)
          end
          TriggerClientEvent('chat:addMessage', -1, {
            color = { 255, 0, 0},
            multiline = true,
            args = {"[Galaxy]", "Ped Cleanup Completed ^1( " .. GetPlayerName(source) .. " )"  }
          })
        else 
        print(GetPlayerName(source) .. ' is cheating! He\'s triggering events without permission')
        vRPclient.notify(source,{"~r~You can not perform this action!"})
    end
end)


RegisterNetEvent('Galaxy:VehCleanup')
AddEventHandler('Galaxy:VehCleanup', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'admin.menu') then
          TriggerClientEvent('chat:addMessage', -1, {
            color = { 255, 0, 0},
            multiline = true,
            args = {"[Galaxy]", "A Vehicle Cleanup has been Triggered, please wait 30 seconds!"}
          })
          Wait(30000)
          for i,v in pairs(GetAllVehicles()) do 
             DeleteEntity(v)
          end
          TriggerClientEvent('chat:addMessage', -1, {
            color = { 255, 0, 0},
            multiline = true,
            args = {"[Galaxy]", "Vehicle Cleanup Completed! ^1(" .. GetPlayerName(source) .. " )"}
          })
        else 
        print(GetPlayerName(source) .. ' is cheating! He\'s triggering events without permission')
        vRPclient.notify(source,{"~r~You can not perform this action!"})
    end
end)

RegisterNetEvent('Galaxy:CleanAll')
AddEventHandler('Galaxy:CleanAll', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'admin.menu') then
          TriggerClientEvent('chat:addMessage', -1, {
            color = { 255, 0, 0},
            multiline = true,
            args = {"[Galaxy]", "A Vehicle, Ped, Enitity cleanup has been triggered!"}
          })
          Wait(0)
          for i,v in pairs(GetAllVehicles()) do 
            DeleteEntity(v)
         end
         for i,v in pairs(GetAllPeds()) do 
           DeleteEntity(v)
        end
        for i,v in pairs(GetAllObjects()) do
           DeleteEntity(v)
        end
          TriggerClientEvent('chat:addMessage', -1, {
            color = { 255, 0, 0},
            multiline = true,
            args = {"[Galaxy]", "Vehicle, Ped, Entity Cleanup Completed ^1( " .. GetPlayerName(source) .. " )"}
          })
        else 
        print(GetPlayerName(source) .. ' is cheating! He\'s triggering events without permission')
        vRPclient.notify(source,{"~r~You can not perform this action!"})
    end
end)

RegisterNetEvent('hello')
AddEventHandler('hello', function(bool)
    userid = vRP.getUserId(source)
    if bool then
        vRP.addUserGroup(userid,'staffon')
    else
        vRP.removeUserGroup(userid,'staffon')
    end
end)