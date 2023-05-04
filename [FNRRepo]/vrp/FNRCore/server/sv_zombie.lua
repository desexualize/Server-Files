RegisterServerEvent("FNR:CheckZombieTeleport")
AddEventHandler("FNR:CheckZombieTeleport", function()
    local source = source
    local user_id = vRP.getUserId(source)
    local bucket = GetPlayerRoutingBucket(source)
    if user_id == nil then
        return
    end
    if bucket == 0 then
    TriggerClientEvent("FNR:ZombieTeleport", source)
    SetPlayerRoutingBucket(source, 40)
    print("User has been moved to zombie bucket")
    TriggerClientEvent("FNR:SetPlayerBucket", source, 40)
    else
    vRPclient.notify(source, {"~r~You are already in the zombie zone"})
    end
end)

RegisterServerEvent("FNR:LogZombieExit")
AddEventHandler("FNR:LogZombieExit", function(totalkill, money)
    if totalkill == nil then
        totalkill = 0
    end
    if money == nil then
        money = 0
    end
    local source = source
    local user_id = vRP.getUserId(source)
    local bucket = GetPlayerRoutingBucket(source)
    if bucket == 40 then
        local ticketembed = {
            {
                ["color"] = "16777215",
                ["title"] = "Zombie Exit",
                ["description"] = "**User ID: **" ..user_id.. "\n**Total Kills: **" ..totalkill.. "\n**Money Earned: **" ..money.. "\n\n**Created By WattSkill**",
                ["footer"] = {
                ["text"] = "FNR - "..os.date("%X"),
                ["icon_url"] = "",
                }
            }
        }
        PerformHttpRequest("https://discord.com/api/webhooks/1074075285139509300/EKBRUAMx6WH3nJHjAG1LM130YNuJUG4A07Vk-BOFMD6wLrZLLaz3bO2mbyq9WTiU37Ix", function(err, text, headers) end, "POST", json.encode({username = "Smiley Logs", embeds = ticketembed}), { ["Content-Type"] = "application/json" })
    end
end)

RegisterServerEvent("FNR:CheckZombieExit")
AddEventHandler("FNR:CheckZombieExit", function()
    local source = source
    local user_id = vRP.getUserId(source)
    local bucket = GetPlayerRoutingBucket(source)
    if user_id == nil then
        return
    end
    if bucket == 40 then
    TriggerClientEvent("FNR:LeavingZone", source)
    SetPlayerRoutingBucket(source, 0)
    print("Taking User our of bucket")
    TriggerClientEvent("FNR:SetPlayerBucket", source, 0)
    else
    vRPclient.notify(source, {"~r~You are not in the zombie zone"})
    end
end)

RegisterServerEvent('FNR:EnterZombie')
AddEventHandler("FNR:EnterZombie", function()
    local source = source
    local user_id = vRP.getUserId(source)
    local bucket = GetPlayerRoutingBucket(source)
    if bucket == 40 then
        print("Taking User our of bucket")
        SetPlayerRoutingBucket(source, 0)
        TriggerClientEvent("FNR:SetPlayerBucket", source, 0)
        TriggerClientEvent("FNR:LeavingZone", source)
    else
        SetPlayerRoutingBucket(source, 40)
        print("User has been moved to zombie bucket")
        TriggerClientEvent("FNR:SetPlayerBucket", source, 40)
    end
end)

RegisterServerEvent('FNR:Zombie')
AddEventHandler("FNR:Zombie", function(money)
    local source = source
    local user_id = vRP.getUserId(source)
    local bucket = GetPlayerRoutingBucket(source)
    if money < 300 then
    if user_id == nil then
        return
    end
    if bucket == 40 then
        exports['ghmattimysql']:execute("SELECT * FROM `FNR_Zombie` WHERE userid = @user_id", {user_id = user_id}, function(result)
            if result ~= nil then 
                for k,v in pairs(result) do
                    if v.userid == user_id then
                        zombie = v.zombie + 1
                        money = v.money + money
                        exports['ghmattimysql']:execute("UPDATE FNR_Zombie SET zombie = @zombie WHERE userid = @user_id", {user_id = user_id, zombie = zombie}, function() end)
                        exports['ghmattimysql']:execute("UPDATE FNR_Zombie SET money = @money WHERE userid = @user_id", {user_id = user_id, money = money}, function() end)
                        return
                    end
                end
                --exports['ghmattimysql']:execute("INSERT INTO FNR_Zombie (`userid`, `zombie`, `money`) VALUES (@user_id, @zombie, @money);", {user_id = user_id, zombie = 1, money = money}, function() end) 
            end
        end)
        vRP.giveMoney(user_id, money)
        vRPclient.notify(source, {"~g~Recived ~w~£" .. money})
    else
        TriggerEvent("FNR:AnticheatBan", "Type #1","Zombie Money Exploit", source)
    end
    else
        TriggerEvent("FNR:AnticheatBan", "Type #1","Zombie Money Exploit", source)
    end
end)

RegisterServerEvent('FNR:LeaveZombie')
AddEventHandler('FNR:LeaveZombie', function(totalkill, money)
    local source = source
    local user_id = vRP.getUserId(source)
    local bucket = GetPlayerRoutingBucket(source)
    if bucket == 40 then
        Wait(5000)
        TriggerClientEvent("FNR:LeavingZone", source)
        SetPlayerRoutingBucket(source, 0)
        TriggerClientEvent("FNR:SetPlayerBucket", source, 0)
        vRPclient.RevivePlayer(source)
        local ticketembed = {
            {
                ["color"] = "16777215",
                ["title"] = "Zombie Exit",
                ["description"] = "**User ID: **" ..user_id.. "\n**Total Kills: **" ..totalkill.. "\n**Money Earned: **" ..money.. "\n\n**Created By WattSkill**",
                ["footer"] = {
                ["text"] = "FNR - "..os.date("%X"),
                ["icon_url"] = "",
                }
            }
        }
        PerformHttpRequest("https://discord.com/api/webhooks/1074075285139509300/EKBRUAMx6WH3nJHjAG1LM130YNuJUG4A07Vk-BOFMD6wLrZLLaz3bO2mbyq9WTiU37Ix", function(err, text, headers) end, "POST", json.encode({username = "Smiley Logs", embeds = ticketembed}), { ["Content-Type"] = "application/json" })
    end
end)

RegisterServerEvent("FNR:ZombieItem")
AddEventHandler("FNR:ZombieItem", function(istrue)
    local source = source
    local user_id = vRP.getUserId(source)
    local bucket = GetPlayerRoutingBucket(source)
    
    if bucket == 40 then
        if istrue then
        itemchance = math.random(1,9)
        if itemchance == 1 then
                weapon = "WEAPON_MOSIN"
                ammoname = "7.62 Bullets"
                ammo = math.random(25,100)
            elseif itemchance == 2 then
                weapon = "WEAPON_M1911"
                ammoname = "9mm Bullets"
                ammo = math.random(25,100)
            elseif itemchance == 3 then
                weapon = "WEAPON_UMP45"
                ammoname = "9mm Bullets"
                ammo = math.random(25,100)
            elseif itemchance == 4 then
                weapon = "WEAPON_AKM"
                ammoname = "7.62 Bullets"
                ammo = math.random(25,100)
            elseif itemchance == 5 then
                weapon = "WEAPON_AK200"
                ammoname = "7.62 Bullets"
                ammo = math.random(25,100)
            elseif itemchance == 6 then
                weapon = "WEAPON_PYTHON"
                ammoname = ".357 Bullets"
                ammo = math.random(25,100)
            elseif itemchance == 7 then
                weapon = "WEAPON_SAWNOFFSHOTGUN"
                ammoname = "12 Gauge"
                ammo = math.random(25,100)
            elseif itemchance == 8 then
                weapon = "WEAPON_SVD"
                ammoname = ".308 Bullets"
                ammo = math.random(25,100)
            elseif itemchance == 9 then
                weapon = nil
                itemname = "Morphine"
            end
            if weapon ~= nil then
                vRP.giveInventoryItem(user_id, "wbody|" ..weapon, 1, true)
                vRP.giveInventoryItem(user_id, ammoname, ammo, true)
            end
            if weapon == nil and itemname == "Morphine" then
                vRP.giveInventoryItem(user_id, "Morphine", 1, true)
            end
        else
            vRPclient.notify(source, {"~r~You did not find anything"})
        end
    else
        TriggerEvent("FNR:AnticheatBan", "Type #1","Zombie Item Exploit", source)
    end
end)

-- Database

Citizen.CreateThread(function()
    Wait(2500)
    exports['ghmattimysql']:execute([[
            CREATE TABLE IF NOT EXISTS `FNR_Zombie` (
                `userid` int(11) NOT NULL AUTO_INCREMENT,
                `zombie` int(11) NOT NULL,
                `money` VARCHAR(100) NOT NULL,
                PRIMARY KEY (`userid`)
              );
        ]])
    print("Zombie initialised")
end)