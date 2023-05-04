
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
    ["spawntaxi"] = {true, "admin.spawntaxi"},
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

RegisterServerEvent('ERP:OpenSettings')
AddEventHandler('ERP:OpenSettings', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id ~= nil and vRP.hasPermission(user_id, "admin.menu") then
        TriggerClientEvent("ERP:OpenSettingsMenu", source, true)
    else
        TriggerClientEvent("ERP:OpenSettingsMenu", source, false)
    end
end)


RegisterServerEvent("ERP:GetPlayerData")
AddEventHandler("ERP:GetPlayerData",function()
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
                DropPlayer(p, "[ERP] You Were Kicked")
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
        TriggerClientEvent("ERP:SendPlayersInfo", source, players_table, menu_btns_table)
    end
end)

RegisterServerEvent("ERP:getGroups")
AddEventHandler("ERP:getGroups",function(temp, perm)
    local user_groups = vRP.getUserGroups(perm)
    TriggerClientEvent("ERP:gotgroups", source, user_groups)
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
                TriggerClientEvent('vRPAdmin:Spectate', source, SelectedPlrSource, pedCoords)
            else 
                TriggerClientEvent('vRPAdmin:Spectate', source, SelectedPlrSource)  
            end
        else 
            vRPclient.notify(source,{"~r~This player may have left the game."})
        end

end)

RegisterServerEvent("ERP:addGroup")
AddEventHandler("ERP:addGroup",function(perm, selgroup)
    local admin_temp = source
    local admin_perm = vRP.getUserId(admin_temp)
    local user_id = vRP.getUserId(source)
    local permsource = vRP.getUserSource(perm)
    local playerName = GetPlayerName(source)
    local povName = GetPlayerName(permsource)
    if vRP.hasPermission(user_id, "group.add") then
        if selgroup == "founder" and not vRP.hasPermission(admin_perm, "group.add.founder") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"}) 
        elseif selgroup == "opmanager" and not vRP.hasPermission(admin_perm, "group.add.opmanager") then
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
        elseif selgroup == "trialstaff" and not vRP.hasPermission(admin_perm, "group.add.trialstaff") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "vip" and not vRP.hasPermission(admin_perm, "group.add.vip") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "pov" and not vRP.hasGroup(perm, "pov") then
            webhook = "https://discord.com/api/webhooks/1001553962304032840/KijzbtprqsJ0KOKwLlINHw76o5KZpiXL0Dxh1XHYu1pkR4TAvVGHGTKBIsFpaxiNK4TN"
            PerformHttpRequest(webhook, function(err, text, headers) 
            end, "POST", json.encode({username = "ERP Roleplay", embeds = {
                {
                    ["color"] = "808080",
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

RegisterServerEvent("ERP:removeGroup")
AddEventHandler("ERP:removeGroup",function(perm, selgroup)
    local user_id = vRP.getUserId(source)
    local admin_temp = source
    local permsource = vRP.getUserSource(perm)
    local playerName = GetPlayerName(source)
    local povName = GetPlayerName(permsource)
    if vRP.hasPermission(user_id, "group.remove") then
        if selgroup == "founder" and not vRP.hasPermission(user_id, "group.remove.founder") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"}) 
        elseif selgroup == "opmanager" and not vRP.hasPermission(user_id, "group.remove.opmanager") then
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
        elseif selgroup == "vip" and not vRP.hasPermission(user_id, "group.remove.vip") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "pov" and vRP.hasGroup(perm, "pov") then
            webhook = "https://discord.com/api/webhooks/1001553921426337822/6ylxYOyCzlOOvx6bYNrbYDMQTMKHaSHsVB-rWDFF_RvV7EBtSYLKj1-oMenCONpnmRtv"
            PerformHttpRequest(webhook, function(err, text, headers) 
            end, "POST", json.encode({username = "ERP Roleplay", embeds = {
                {
                    ["color"] = "808080",
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

RegisterServerEvent('ERP:BanPlayer')
AddEventHandler('ERP:BanPlayer', function(admin, target, reason, duration)
    local target = target
    local target_id = vRP.getUserSource(target)
    local admin_id = vRP.getUserId(admin)
    local reason = reason
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
                TriggerEvent('ERP:BanPlayerLog', target, GetPlayerName(admin), reason, duration)
                webhook = "https://discord.com/api/webhooks/1001553696078962769/kBCUqfEV2wUG7orUZ3sfReWa88EPzHH1fh5XJ0v9qjtLYpZsKY0nONPhskTpoY10rS5W"
                PerformHttpRequest(webhook, function(err, text, headers) 
                end, "POST", json.encode({username = "ERP Roleplay", embeds = {
                    {
                        ["color"] = "808080",
                        ["title"] = "Banned ID: "..target .." out of the server. Reason: "..reason,
                        ["description"] = "Admin Name: **"..GetPlayerName(admin).."** \nAdmin ID: **"..vRP.getUserId(admin).."** \nPlayer ID: **"..target.."** \nDescription: **Banned ID: "..target.." out of the server. Reason: "..reason.."**",
                        ["footer"] = {
                            ["text"] = "Time - "..os.date("%x %X %p"),
                        }
                }
                }}), { ["Content-Type"] = "application/json" })
                vRPclient.notify(admin, {'~g~Banned Player'})
            end
        end
    end
end)

RegisterServerEvent('ERP:KickPlayer')
AddEventHandler('ERP:KickPlayer', function(admin, target, reason, tempid)
    local target_id = vRP.getUserSource(target)
    local target_permid = target
    local reason = reason
    local playerName = GetPlayerName(source)
    local playerOtherName = GetPlayerName(tempid)
    local perm = admincfg.buttonsEnabled["kick"][2]
    local admin_id = vRP.getUserId(admin)
    if vRP.hasPermission(admin_id, perm) then
        webhook = "https://discord.com/api/webhooks/1001553650113576990/LQJRksa6XSixXJEnS0JJdcpimZtglS1j13LbNTFtNF3lp1E6a2sRKj20jG956KsP2OXi"
        PerformHttpRequest(webhook, function(err, text, headers) 
        end, "POST", json.encode({username = "ERP Roleplay", embeds = {
            {
                ["color"] = "808080",
                ["title"] = "Kicked "..playerOtherName.." out of the server. Reason: "..reason,
                ["description"] = "Admin Name: **"..playerName.."** \nAdmin ID: **"..admin_id.."** \nPlayer ID: **"..target_permid.."** \nReason:" ..reason,
                ["footer"] = {
                    ["text"] = "Time - "..os.date("%x %X %p"),
                }
        }
        }}), { ["Content-Type"] = "application/json" })
        vRP.kick(target_id, "[ERP] You have been kicked | Your ID is: "..target.." | Reason: "..reason.." | Kicked by "..GetPlayerName(admin) or "No reason specified")
        TriggerEvent("ERP:saveKickLog",target,GetPlayerName(admin),reason)
        vRPclient.notify(admin, {'~g~Kicked Player'})
    end
end)

RegisterServerEvent('ERP:KickPlayerNoF10')
AddEventHandler('ERP:KickPlayerNoF10', function(admin, target, reason)
    local target_id = vRP.getUserSource(target)
    local target_permid = vRP.getUserId(target)
    local perm = admincfg.buttonsEnabled["kick"][2]
    local admin_id = vRP.getUserId(admin)
    if vRP.hasPermission(admin_id, perm) then
        local playerName = GetPlayerName(source)
        local playerOtherName = GetPlayerName(target)
        webhook = "https://discord.com/api/webhooks/1001554939505553428/XYcOrfKDE56GTXqE3T-Ae-n0U4G4DLJxWRiI1T8Z7a3xui0GUmGi9vQtPbAPcAu5T8C3"
        PerformHttpRequest(webhook, function(err, text, headers) 
        end, "POST", json.encode({username = "ERP Roleplay", embeds = {
            {
                ["color"] = "808080",
                ["title"] = "No F10 Kicked "..playerOtherName.." out of the server. Reason: "..reason,
                ["description"] = "Admin Name: **"..playerName.."** \nAdmin ID: **"..admin_id.."** \nPlayer ID: **"..target_permid.."** \nDescription: **No F10 Kicked "..playerOtherName.." out of the server. Reason: "..reason.."**",
                ["footer"] = {
                    ["text"] = "Time - "..os.date("%x %X %p"),
                }
        }
        }}), { ["Content-Type"] = "application/json" })
        vRP.kick(target_id, "[ERP] You have been kicked | Your ID is: "..target.." | Reason: "..reason.." | Kicked by "..GetPlayerName(admin) or "No reason specified")
        vRPclient.notify(admin, {'~g~Kicked Player'})
    end
end)

RegisterServerEvent('ERP:RemoveWarning')
AddEventHandler('ERP:RemoveWarning', function(admin, warningid)
    local admin_id = vRP.getUserId(admin)
    local perm = admincfg.buttonsEnabled["removewarn"][2]
    if vRP.hasPermission(admin_id, perm) then
        exports['ghmattimysql']:execute("DELETE FROM vrp_warnings WHERE warning_id = @uid", {uid = warningid})
        vRPclient.notify(admin, {'~g~Removed #'..warningid..' Warning ID'})
    end
end)

RegisterServerEvent("ERP:Unban")
AddEventHandler("ERP:Unban",function(perm1)
    local admin_id = vRP.getUserId(source)
    local perm2 = admincfg.buttonsEnabled["ban"][2]
    playerName = GetPlayerName(source)
    if vRP.hasPermission(admin_id, perm2) then

        ExecuteCommand('unban ' .. perm1)
        vRPclient.notify(source,{'~g~Unbanned ID: ' .. perm1})
        webhook = "https://discord.com/api/webhooks/1001553737652908042/W9KB_wZKEfAkihC_nxg-Btn-BfBixlcTTIGc7VXxcpDK1MA9BI61pCsj82P28Yygvcuq"
        PerformHttpRequest(webhook, function(err, text, headers) 
        end, "POST", json.encode({username = "ERP Roleplay", embeds = {
            {
                ["color"] = "808080",
                ["title"] = "Unbanned ID: "..perm1,
                ["description"] = "Admin Name: **"..playerName.."** \nPermID: **"..admin_id.."** \nDescription: **Unbanned ID: "..perm1.."**",
                ["footer"] = {
                    ["text"] = "Time - "..os.date("%x %X %p"),
                }
        }
        }}), { ["Content-Type"] = "application/json" })
    else
        print("Cheater tried fucking unbanning, the nerd")
    end
end)

RegisterServerEvent('ERP:SlapPlayer')
AddEventHandler('ERP:SlapPlayer', function(admin, target)
    local admin_id = vRP.getUserId(admin)
    if vRP.hasPermission(admin_id, "admin.slap") then
        local playerName = GetPlayerName(source)
        local playerOtherName = GetPlayerName(target)
        webhook = "https://discord.com/api/webhooks/1001553577640206416/ze87TqREMa_KJ-wXRXgl8QsvkxZzQNBNEJabGHQ9mm5LZjqfQWltAe7rgas-opUunLKC"
        PerformHttpRequest(webhook, function(err, text, headers) 
        end, "POST", json.encode({username = "ERP Roleplay", embeds = {
            {
                ["color"] = "808080",
                ["title"] = "Slapped "..playerOtherName,
                ["description"] = "Admin Name: **"..playerName.."** \nPermID: **"..user_id.."** \nDescription: **Slapped "..playerOtherName.."**",
                ["footer"] = {
                    ["text"] = "Time - "..os.date("%x %X %p"),
                }
        }
        }}), { ["Content-Type"] = "application/json" })
        TriggerClientEvent('ERP:SlapPlayer', target)
        vRPclient.notify(admin, {'~g~Slapped Player'})
    end
end)

RegisterServerEvent('ERP:RevivePlayer')
AddEventHandler('ERP:RevivePlayer', function(admin, target)
    local admin_id = vRP.getUserId(admin)
    if vRP.hasPermission(admin_id, "admin.revive") then
        local playerName = GetPlayerName(source)
        local playerOtherName = GetPlayerName(target)
        webhook = "https://discord.com/api/webhooks/1001553480911175782/OcRLmUUtYnsyTbyVwKfNPO6cWiReqkGueLsCuMvy-RdY_UfdN0nxSpRbVrlOSWsqyI8E"
        PerformHttpRequest(webhook, function(err, text, headers) 
        end, "POST", json.encode({username = "ERP Roleplay", embeds = {
            {
                ["color"] = "808080",
                ["title"] = "Revived "..playerOtherName,
                ["description"] = "Admin Name: **"..playerName.."** \nPermID: **"..user_id.."** \nDescription: **Revived "..playerOtherName.."**",
                ["footer"] = {
                    ["text"] = "Time - "..os.date("%x %X %p"),
                }
        }
        }}), { ["Content-Type"] = "application/json" })
        TriggerClientEvent('Element:FixClient',target)
        vRPclient.notify(admin, {'~g~Revived Player'})
    end
end)

RegisterServerEvent('ERP:FreezeSV')
AddEventHandler('ERP:FreezeSV', function(admin, newtarget, isFrozen)
    local admin_id = vRP.getUserId(admin)
    local perm = admincfg.buttonsEnabled["FREEZE"][2]
    if vRP.hasPermission(admin_id, perm) then
        local playerName = GetPlayerName(source)
        local playerOtherName = GetPlayerName(newtarget)
        if isFrozen then
            webhook = "https://discord.com/api/webhooks/1001553783727337583/rZk9gstjIKu4OyMFWndf1c4_rbddl6BV01ToKd2zCIQFk9JQPeAyKlJ-tcg_x2Nmk4WS"
            PerformHttpRequest(webhook, function(err, text, headers) 
            end, "POST", json.encode({username = "ERP Roleplay", embeds = {
                {
                    ["color"] = "808080",
                    ["title"] = "Froze "..playerOtherName,
                    ["description"] = "Admin Name: **"..playerName.."** \nPermID: **"..user_id.."** \nDescription: **Froze "..playerOtherName.."**",
                    ["footer"] = {
                        ["text"] = "Time - "..os.date("%x %X %p"),
                    }
            }
            }}), { ["Content-Type"] = "application/json" })
        else
            webhook = "https://discord.com/api/webhooks/1001553836068065401/R83XowEL4cZ8lEn6RlRRrGqA1hplYNMdialB5WQhyIJk52Ob6HEn89dmKkw1w6MYTTAk"
            PerformHttpRequest(webhook, function(err, text, headers) 
            end, "POST", json.encode({username = "ERP Roleplay", embeds = {
                {
                    ["color"] = "808080",
                    ["title"] = "Unfroze "..playerOtherName,
                    ["description"] = "Admin Name: **"..playerName.."** \nPermID: **"..user_id.."** \nDescription: **Unfroze "..playerOtherName.."**",
                    ["footer"] = {
                        ["text"] = "Time - "..os.date("%x %X %p"),
                    }
            }
            }}), { ["Content-Type"] = "application/json" })
        end
        TriggerClientEvent('ERP:Freeze', newtarget, isFrozen)
        vRPclient.notify(admin, {'~g~Froze Player'})
    end
end)

RegisterServerEvent('ERP:TeleportToPlayer')
AddEventHandler('ERP:TeleportToPlayer', function(source, newtarget)
    local coords = GetEntityCoords(GetPlayerPed(newtarget))
    local user_id = vRP.getUserId(source)
    local perm = admincfg.buttonsEnabled["TP2"][2]
    if vRP.hasPermission(user_id, perm) then
        local playerName = GetPlayerName(source)
        local playerOtherName = GetPlayerName(newtarget)
        webhook = "https://discord.com/api/webhooks/1001554151236452533/xTVVZ5NZzRKpAOjQ3slPQESXn7uIceRrJk9-7LCYebyn8l63ULJD9GeMuBZDefe5gMS_"
        PerformHttpRequest(webhook, function(err, text, headers) 
        end, "POST", json.encode({username = "ERP Roleplay", embeds = {
            {
                ["color"] = "808080",
                ["title"] = "Teleported to "..playerOtherName,
                ["description"] = "Admin Name: **"..playerName.."** \nPermID: **"..user_id.."** \nDescription: **Teleported to "..playerOtherName.."**",
                ["footer"] = {
                    ["text"] = "Time - "..os.date("%x %X %p"),
                }
        }
        }}), { ["Content-Type"] = "application/json" })
        TriggerClientEvent('ERP:Teleport', source, coords)
    end
end)

RegisterServerEvent('ERP:TeleportToMe')
AddEventHandler('ERP:TeleportToMe', function(source, newtarget)
    local user_id = vRP.getUserId(source)
    local perm = admincfg.buttonsEnabled["TP2ME"][2]
    if vRP.hasPermission(user_id, perm) then
        local playerName = GetPlayerName(source)
        local playerOtherName = GetPlayerName(newtarget)
        webhook = "https://discord.com/api/webhooks/1001554043593834526/Hjz69nCrzNQMR0Mbp-90KbNtwM9WYxkonLRUVXQo2lJM74hMkwKOpTlWm0iCcFJSmg9G"
        PerformHttpRequest(webhook, function(err, text, headers) 
        end, "POST", json.encode({username = "ERP Roleplay", embeds = {
            {
                ["color"] = "808080",
                ["title"] = "Brang "..playerOtherName,
                ["description"] = "Admin Name: **"..playerName.."** \nPermID: **"..user_id.."** \nDescription: **Brang "..playerOtherName.."**",
                ["footer"] = {
                    ["text"] = "Time - "..os.date("%x %X %p"),
                }
        }
    }}), { ["Content-Type"] = "application/json" })
        TriggerClientEvent('ERP:Teleport2Me2', newtarget, source)
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

                webhook = "https://discord.com/api/webhooks/1001554075353088000/vuC6H-nDHkdZDPt4qLvgJLRXYyKZ9l1ZXs1Dt1c08369UGpxk_O014Di70k61cYQIaPy"
                PerformHttpRequest(webhook, function(err, text, headers) 
                end, "POST", json.encode({username = "ERP Roleplay", embeds = {
                    {
                        ["color"] = "808080",
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

RegisterServerEvent('ERP:SpectateCheck')
AddEventHandler('ERP:SpectateCheck', function(newtarget)
    local admin_id = source
    local user_id = vRP.getUserId(source)
    local perm = admincfg.buttonsEnabled["spectate"][2]
    if vRP.hasPermission(user_id, perm) then
        local playerName = GetPlayerName(source)
        local playerOtherName = GetPlayerName(newtarget)
        webhook = "https://discord.com/api/webhooks/1001553881442037991/lwreoriUJNzGwFtR48TR39vY_Uda30DmvCe5FEfcMtMoMZuDjIRK29P23P3SbmpqoUFC"
        PerformHttpRequest(webhook, function(err, text, headers) 
        end, "POST", json.encode({username = "ERP Roleplay", embeds = {
            {
                ["color"] = "808080",
                ["title"] = "Started spectating "..playerOtherName,
                ["description"] = "Admin Name: **"..playerName.."** \nPermID: **"..user_id.."** \nDescription: **Started spectating "..playerOtherName.."**",
                ["footer"] = {
                    ["text"] = "Time - "..os.date("%x %X %p"),
                }
        }
    }}), { ["Content-Type"] = "application/json" })

        TriggerClientEvent('ERP:SpectateClient', source, newtarget)
        
    end
end)

RegisterServerEvent('ERP:Prompt')
AddEventHandler('ERP:Prompt', function(shit)
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

RegisterServerEvent('ERP:Tp2Coords')
AddEventHandler('ERP:Tp2Coords', function()
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

RegisterServerEvent('ERP:GiveMoney2')
AddEventHandler('ERP:GiveMoney2', function()
    local source = source
    local userid = vRP.getUserId(source)
    if vRP.hasGroup(userid, "dev") then
        if user_id ~= nil then
            vRP.prompt(source,"Amount:","",function(source,amount) 
                amount = parseInt(amount)
                local playerName = GetPlayerName(source)
                webhook = "https://discord.com/api/webhooks/1006362159120396298/NEcI9C41NqTSAJHZD5A6IxEqt_2ItPbjtQxZyDNyVOVOvbmyI_KQmNCNt77RdEMSDDs9"
                PerformHttpRequest(webhook, function(err, text, headers) 
                end, "POST", json.encode({username = "ERP Roleplay", embeds = {
                    {
                        ["color"] = "808080",
                        ["title"] = "" .. playerName .. " Has Spawned in cash",
                        ["description"] = "PermID: **"..user_id.."** \nAmount:" ..amount.."",
                        ["footer"] = {
                            ["text"] = "Time - "..os.date("%x %X %p"),
                        }
                }
            }}), { ["Content-Type"] = "application/json" })
                vRP.giveMoney(user_id, amount)
                vRPclient.notify(source,{"You have gave youself ~g~£" .. amount})
            end)
        end

    end
end)

RegisterNetEvent('VRP:noClip')
AddEventHandler('VRP:noClip', function()
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'admin.noclip') then 
        TriggerClientEvent('TAC',source)
    end
end)

RegisterServerEvent("ERP:Teleport2AdminIsland")
AddEventHandler("ERP:Teleport2AdminIsland",function(id)
    local admin = source
    local admin_id = vRP.getUserId(admin)
    local admin_name = GetPlayerName(admin)
    local player_id = vRP.getUserId(id)
    local player_name = GetPlayerName(id)
    local perm = admincfg.buttonsEnabled["TP2"][2]
    if vRP.hasPermission(admin_id, perm) then
        local playerName = GetPlayerName(source)
        local playerOtherName = GetPlayerName(id)
        webhook = "https://discord.com/api/webhooks/1001554198078423140/tWPl8njqTQoD2bt8qM7-R3INDV6OKBp7qlfpbkU-CW1t3otcmJ_C3kzc9OenCfoWGf-r"
        PerformHttpRequest(webhook, function(err, text, headers) 
        end, "POST", json.encode({username = "ERP Roleplay", embeds = {
            {
                ["color"] = "808080",
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
        SetEntityCoords(ped2, 3478.5485839844,2581.0539550781,14.81595993042)
    end
end)

RegisterServerEvent("ERP:Teleport")
AddEventHandler("ERP:Teleport",function(id, coords)
    local admin = source
    local admin_id = vRP.getUserId(admin)

    local perm = admincfg.buttonsEnabled["TP2"][2]
    if vRP.hasPermission(admin_id, perm) then

        local ped = GetPlayerPed(source)
        local ped2 = GetPlayerPed(id)
        SetEntityCoords(ped2, coords)
    end
end)


RegisterServerEvent("ERP:Telepor2")
AddEventHandler("ERP:Telepor2",function(id)
    local ped2 = GetPlayerPed(id)
    SetEntityCoords(ped2, 3490.0769042969,2585.4392089844,14.149716377258)
end)

RegisterServerEvent("ERP:returnplayer")
AddEventHandler("ERP:returnplayer",function(id)
    local admin = source
    local admin_id = vRP.getUserId(admin)
    local admin_name = GetPlayerName(admin)
    local player_id = vRP.getUserId(id)
    local player_name = GetPlayerName(id)
    local perm = admincfg.buttonsEnabled["TP2"][2]
    if vRP.hasPermission(admin_id, perm) then
        local playerName = GetPlayerName(source)
        local playerOtherName = GetPlayerName(id)
        webhook = "https://discord.com/api/webhooks/1001554109159178441/8JiG6l5FoNxByS-8FLr3eA44poIZs5DEVj1ybTuyFTZ274b3VpQgd7vlpmQXxM2B4hZg"
        PerformHttpRequest(webhook, function(err, text, headers) 
        end, "POST", json.encode({username = "ERP Roleplay", embeds = {
            {
                ["color"] = "808080",
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
            TriggerClientEvent("ERP:TPCoords", id, coords)
        end)
        exports['ghmattimysql']:execute("DELETE FROM vrp_tp_data WHERE `user_id` = @user_id", {user_id = id}, function() end)        
    end
end)

RegisterNetEvent('ERP:AddCar')
AddEventHandler('ERP:AddCar', function()
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
                                exports.ghmattimysql:execute("INSERT IGNORE INTO vrp_user_vehicles(user_id,vehicle,vehicle_plate) VALUES(@user_id,@vehicle,@vehicle_plate)", {
                                    ['@user_id'] = permid,
                                    ['@vehicle'] = car,
                                    ["@vehicle_plate"] = "P "..math.random(10000,99999), 
                                }, function (rows) end)  	
                            end)
                            vRPclient.notify(source,{'~g~Successfully added Player\'s car'})
                            webhook = ""
                            PerformHttpRequest(webhook, function(err, text, headers) 
                            end, "POST", json.encode({username = "ERG", embeds = {
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

RegisterNetEvent('ERP:PropCleanup')
AddEventHandler('ERP:PropCleanup', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'admin.menu') then
        TriggerClientEvent('chat:addMessage', -1, {
            color = { 255, 0, 0},
            multiline = true,
            args = {"[ERP]", 'A Entity cleanup has been triggered!'}
          })
          Wait(0)
          for i,v in pairs(GetAllObjects()) do 
             DeleteEntity(v)
          end
          TriggerClientEvent('chat:addMessage', -1, {
            color = { 255, 0, 0},
            multiline = true,
            args = {"[ERP]", "Entity Cleanup Completed! ^1( " .. GetPlayerName(source) .. " )"}
          })
        else 
        print(GetPlayerName(source) .. ' is cheating! He\'s triggering events without permission')
        vRPclient.notify(source,{"~r~You can not perform this action!"})
    end
end)

RegisterNetEvent('ERP:DeAttachEntity')
AddEventHandler('ERP:DeAttachEntity', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'admin.menu') then
        TriggerClientEvent('chat:addMessage', -1, {
            color = { 255, 0, 0},
            multiline = true,
            args = {"[ERP]", 'A Deattach cleanup has been triggered!'}
          })
          TriggerClientEvent("vRPAdmin:EntityWipe", -1)
          TriggerClientEvent('chat:addMessage', -1, {
            color = { 255, 0, 0},
            multiline = true,
            args = {"[ERP]", " Deattach Cleanup Completed ^1( " .. GetPlayerName(source) .. " )"}
          })
        else 
        print(GetPlayerName(source) .. ' is cheating! He\'s triggering events without permission')
        vRPclient.notify(source,{"~r~You can not perform this action!"})
    end
end)

RegisterNetEvent('ERP:PedCleanup')
AddEventHandler('ERP:PedCleanup', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'admin.menu') then
          for i,v in pairs(GetAllPeds()) do 
             DeleteEntity(v)
          end
          TriggerClientEvent('chat:addMessage', -1, {
            color = { 255, 0, 0},
            multiline = true,
            args = {"[ERP]", "Ped Cleanup Completed ^1( " .. GetPlayerName(source) .. " )"  }
          })
        else 
        print(GetPlayerName(source) .. ' is cheating! He\'s triggering events without permission')
        vRPclient.notify(source,{"~r~You can not perform this action!"})
    end
end)


RegisterNetEvent('ERP:VehCleanup')
AddEventHandler('ERP:VehCleanup', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'admin.menu') then
          TriggerClientEvent('chat:addMessage', -1, {
            color = { 255, 0, 0},
            multiline = true,
            args = {"[ERP]", "A Vehicle Cleanup has been Triggered, please wait 30 seconds!"}
          })
          Wait(30000)
          for i,v in pairs(GetAllVehicles()) do 
             DeleteEntity(v)
          end
          TriggerClientEvent('chat:addMessage', -1, {
            color = { 255, 0, 0},
            multiline = true,
            args = {"[ERP]", "Vehicle Cleanup Completed! ^1(" .. GetPlayerName(source) .. " )"}
          })
        else 
        print(GetPlayerName(source) .. ' is cheating! He\'s triggering events without permission')
        vRPclient.notify(source,{"~r~You can not perform this action!"})
    end
end)

RegisterNetEvent('ERP:CleanAll')
AddEventHandler('ERP:CleanAll', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'admin.menu') then
          TriggerClientEvent('chat:addMessage', -1, {
            color = { 255, 0, 0},
            multiline = true,
            args = {"[ERP]", "A Vehicle, Ped, Enitity cleanup has been triggered!"}
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
            args = {"[ERP]", "Vehicle, Ped, Entity Cleanup Completed ^1( " .. GetPlayerName(source) .. " )"}
          })
        else 
        print(GetPlayerName(source) .. ' is cheating! He\'s triggering events without permission')
        vRPclient.notify(source,{"~r~You can not perform this action!"})
    end
end)

RegisterCommand("staffon", function(source)
    local user_id = vRP.getUserId(source)
    local player = vRP.getUserSource(user_id)
    if vRP.hasPermission(user_id, "admin.menu") then
        vRPclient.staffmode(source, {true})
    else
        vRPclient.notify(player, {"~r~You do not have permissions for this."})
    end
end)

RegisterCommand("staffoff", function(source)
    local user_id = vRP.getUserId(source)
    local player = vRP.getUserSource(user_id)
    if vRP.hasPermission(user_id, "admin.menu") then
        vRPclient.staffmode(source, {false})
    else
        vRPclient.notify(player, {"~r~You do not have permissions for this."})
    end
end)