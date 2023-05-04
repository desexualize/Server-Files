local Tunnel = module("AQUA", "lib/Tunnel")
local Proxy = module("AQUA", "lib/Proxy")
ownedGaffs = {}
AQUA = Proxy.getInterface("AQUA")
AQUAclient = Tunnel.getInterface("AQUA","JudHousing")

--SQL

MySQL = module("aqua_mysql", "MySQL")

MySQL.createCommand("AQUA/get_address","SELECT home, number FROM aqua_user_homes WHERE user_id = @user_id")
MySQL.createCommand("AQUA/get_home_owner","SELECT user_id FROM aqua_user_homes WHERE home = @home AND number = @number")
MySQL.createCommand("AQUA/rm_address","DELETE FROM aqua_user_homes WHERE user_id = @user_id AND home = @home")
MySQL.createCommand("AQUA/set_address","REPLACE INTO aqua_user_homes(user_id,home,number) VALUES(@user_id,@home,@number)")

RegisterNetEvent('AQUA:getHouses')
AddEventHandler('AQUA:getHouses', function()
    local houses = {}
    local source = source
    local user_id = AQUA.getUserId({source})
    exports['ghmattimysql']:execute("SELECT * FROM `aqua_user_homes` WHERE user_id = @user_id", {user_id = user_id}, function(result)
        if result ~= nil then 
            for k,v in pairs(result) do
                if v.user_id == user_id then
                    --print(user_id..' '..v.home)
                    table.insert(houses, v.home)
                end
            end
            TriggerClientEvent('AQUA:HousingTable', source, houses)
        end
    end)
end)

function getUserAddress(user_id, cbr)
    local task = Task(cbr)
  
    MySQL.query("AQUA/get_address", {user_id = user_id}, function(rows, affected)
        task({rows[1]})
    end)
end
  
function setUserAddress(user_id, home, number)
    MySQL.execute("AQUA/set_address", {user_id = user_id, home = home, number = number})
end
  
function removeUserAddress(user_id, home)
    MySQL.execute("AQUA/rm_address", {user_id = user_id, home = home})
end

function getUserByAddress(home, number, cbr)
    local task = Task(cbr)
  
    MySQL.query("AQUA/get_home_owner", {home = home, number = number}, function(rows, affected)
        if #rows > 0 then
            task({rows[1].user_id})
        else
            task()
        end
    end)
end

function leaveHome(user_id, home, number, cbr)
    local task = Task(cbr)
  
    local player = AQUA.getUserSource({user_id})

    TriggerClientEvent("JudHousing:UpdateInHome", player, false)
  
    for k, v in pairs(cfghomes.homes) do
        if k == home then
            local x,y,z = table.unpack(v.entry_point)
            AQUAclient.teleport(player, {x,y,z})
            task({true})
        end
    end
end

function accessHome(user_id, home, number, cbr)
    local task = Task(cbr)
  
    local player = AQUA.getUserSource({user_id})

    TriggerClientEvent("JudHousing:UpdateInHome", player, true)
  
    for k, v in pairs(cfghomes.homes) do
        if k == home then
            local x,y,z = table.unpack(v.leave_point)
            AQUAclient.teleport(player, {x,y,z})
            task({true})
        end
    end
end

--Main Events

RegisterNetEvent("JudHousing:Buy")
AddEventHandler("JudHousing:Buy", function(house)
    local user_id = AQUA.getUserId({source})
    local player = AQUA.getUserSource({user_id})

    for k, v in pairs(cfghomes.homes) do
        if house == k then
            getUserByAddress(house,1,function(noowner) --check if house already has a owner
                if noowner == nil then
                    getUserAddress(user_id, function(address) -- check if user already has a home
                            if AQUA.tryFullPayment({user_id,v.buy_price}) then --try payment
                                local price = v.buy_price
                                setUserAddress(user_id,house,1) --set address
                                AQUAclient.notify(player,{"~g~You bought "..k.."!"}) --notify
                                local command = {
                                    {
                                        ["color"] = "3944703",
                                        ["title"] = " Housing Logs",
                                        ["description"] = "",
                                        ["text"] = " Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
                                        ["fields"] = {
                                            {
                                                ["name"] = "Player Name",
                                                ["value"] = GetPlayerName(source),
                                                ["inline"] = true
                                            },
                                            {
                                                ["name"] = "Player TempID",
                                                ["value"] = source,
                                                ["inline"] = true
                                            },
                                            {
                                                ["name"] = "Player PermID",
                                                ["value"] = user_id,
                                                ["inline"] = true
                                            },
                                            {
                                                ["name"] = "House",
                                                ["value"] = k,
                                                ["inline"] = true
                                            },
                                            {
                                                ["name"] = "House Price",
                                                ["value"] = price,
                                                ["inline"] = true
                                            }
                                        }
                                    }
                                }
                                local webhook = "https://discord.com/api/webhooks/1059082813682483280/wEgmhVWJUNxuN54PwK5e1B5j30PvziPz4EI9tTBbBsKL2tM90fyFiYWeTXOSE0VIs3z4"
                                PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "AQUA", embeds = command}), { ['Content-Type'] = 'application/json' })
                            else
                                AQUAclient.notify(player,{"~d~You do not have enough money to buy "..k}) --not enough money
                            end
                    end)
                else
                    AQUAclient.notify(player,{"~d~Someone already owns "..k})
                end
                if noowner ~= nil then
                    TriggerClientEvent('HouseOwned', player)
                end
            end)
        end
    end
end)

RegisterNetEvent("JudHousing:Enter")
AddEventHandler("JudHousing:Enter", function(house)
    local user_id = AQUA.getUserId({source})
    local player = AQUA.getUserSource({user_id})
    local name = GetPlayerName(source)

    getUserByAddress(house, 1, function(huser_id) --check if player owns home
        local hplayer = AQUA.getUserSource({huser_id}) --temp id of home owner

        if huser_id ~= nil then
            if huser_id == user_id then
                accessHome(user_id, house, 1, function(ok) --enter home
                    if not ok then
                        AQUAclient.notify(player,{"~d~Unable to enter home"}) --notify unable to enter home for whatever reason
                    end
                end)
            else
                if hplayer ~= nil then --check if home owner is online
                    AQUAclient.notify(player,{"~d~You do not own this home, Knocked on door!"})
                    AQUA.request({hplayer,name.." knocked on your door!", 30, function(v,ok) --knock on door
                        if ok then
                            AQUAclient.notify(player,{"~g~Doorbell Accepted"}) --doorbell accepted
                            accessHome(user_id, house, 1, function(ok) --enter home
                                if not ok then
                                    AQUAclient.notify(player,{"~d~Unable to enter home!"}) --notify unable to enter home for whatever reason
                                end
                            end)
                        end
                        if not ok then
                            AQUAclient.notify(player,{"~d~Doorbell Refused "}) -- doorbell refused
                        end
                    end})
                else
                    AQUAclient.notify(player,{"~d~Home owner not online!"}) -- home owner not online
                end
            end
        else
            AQUAclient.notify(player,{"~d~Nobody owns "..house..""}) --no home owner & user_id already doesn't have a house
        end
    end)
end)

RegisterNetEvent("JudHousing:Leave")
AddEventHandler("JudHousing:Leave", function(house)
    local user_id = AQUA.getUserId({source})
    local player = AQUA.getUserSource({user_id})

    leaveHome(user_id, house, 1, function(ok) --leave home
        if not ok then
            AQUAclient.notify(player,{"~d~Unable to leave home!"}) --notify if some error
        end
    end)
end)

RegisterNetEvent("JudHousing:Sell")
AddEventHandler("JudHousing:Sell", function(house)
    local user_id = AQUA.getUserId({source})
    local player = AQUA.getUserSource({user_id})

    getUserByAddress(house, 1, function(huser_id)
        if huser_id == user_id then
            AQUAclient.getNearestPlayers(player,{15},function(nplayers) --get nearest players
                usrList = ""
                for k, v in pairs(nplayers) do
                    usrList = usrList .. "[" .. AQUA.getUserId({k}) .. "]" .. GetPlayerName(k) .. " | " --add ids to usrList
                end
                if usrList ~= "" then
                    AQUA.prompt({player,"Players Nearby: " .. usrList .. "","",function(player, target_id) --ask for id
                        target_id = target_id
                        if target_id ~= nil and target_id ~= "" then --validation
                            local target = AQUA.getUserSource({tonumber(target_id)}) --get source of the new owner id
                            if target ~= nil then
                                AQUA.prompt({player,"Price £: ","",function(player, amount) --ask for price
                                    if tonumber(amount) and tonumber(amount) > 0 then
                                        AQUA.request({target,GetPlayerName(player).." wants to sell: " ..house.. " Price: £"..amount, 30, function(target,ok) --request new owner if they want to buy
                                            if ok then --bought
                                                local buyer_id = AQUA.getUserId({target}) --get perm id of new owner
                                                amount = tonumber(amount) --convert amount str to int
                                                if AQUA.tryFullPayment({buyer_id,amount}) then
                                                    setUserAddress(buyer_id, house, 1) --give house
                                                    removeUserAddress(user_id, house) -- remove house
                                                    AQUA.giveBankMoney({user_id, amount}) --give money to original owner
                                                    AQUAclient.notify(player,{"~g~You have successfully sold "..house.." to ".. GetPlayerName(target).." for £"..amount.."!"}) --notify original owner
                                                    AQUAclient.notify(target,{"~g~"..GetPlayerName(player).." has successfully sold you "..house.." for £"..amount.."!"}) --notify new owner
                                                    local command = {
                                                        {
                                                            ["color"] = "3944703",
                                                            ["title"] = " Housing Logs",
                                                            ["description"] = "",
                                                            ["text"] = " Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
                                                            ["fields"] = {
                                                                {
                                                                    ["name"] = "Player Name",
                                                                    ["value"] = GetPlayerName(source),
                                                                    ["inline"] = true
                                                                },
                                                                {
                                                                    ["name"] = "Player TempID",
                                                                    ["value"] = source,
                                                                    ["inline"] = true
                                                                },
                                                                {
                                                                    ["name"] = "Player PermID",
                                                                    ["value"] = user_id,
                                                                    ["inline"] = true
                                                                },
                                                                {
                                                                    ["name"] = "Buyer Name",
                                                                    ["value"] = GetPlayerName(target),
                                                                    ["inline"] = true
                                                                },
                                                                {
                                                                    ["name"] = "Buyer TempID",
                                                                    ["value"] = target,
                                                                    ["inline"] = true
                                                                },
                                                                {
                                                                    ["name"] = "Buyer PermID",
                                                                    ["value"] = AQUA.getUserId({target}),
                                                                    ["inline"] = true
                                                                },
                                                                {
                                                                    ["name"] = "House",
                                                                    ["value"] = house,
                                                                    ["inline"] = true
                                                                },
                                                                {
                                                                    ["name"] = "Price",
                                                                    ["value"] = amount,
                                                                    ["inline"] = true
                                                                }
                                                            }
                                                        }
                                                    }
                                                    local webhook = "https://discord.com/api/webhooks/1059082813682483280/wEgmhVWJUNxuN54PwK5e1B5j30PvziPz4EI9tTBbBsKL2tM90fyFiYWeTXOSE0VIs3z4"
                                                    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "AQUA", embeds = command}), { ['Content-Type'] = 'application/json' })           
                                                else
                                                    AQUAclient.notify(player,{"~d~".. GetPlayerName(target).." doesn't have enough money!"}) --notify original owner
                                                    AQUAclient.notify(target,{"~d~You don't have enough money!"}) --notify new owner
                                                end
                                            else
                                                AQUAclient.notify(player,{"~d~"..GetPlayerName(target).." has refused to buy "..house.."!"}) --notify owner that refused
                                                AQUAclient.notify(target,{"~d~You have refused to buy "..house.."!"}) --notify new owner that refused
                                            end
                                        end})
                                    else
                                        AQUAclient.notify(player,{"~d~Price of home needs to be a number!"}) -- if price of home is a string not a int
                                    end
                                end})
                            else
                                AQUAclient.notify(player,{"~d~That Perm ID seems to be invalid!"}) --couldnt find perm id
                            end
                        else
                            AQUAclient.notify(player,{"~d~No Perm ID selected!"}) --no perm id selected
                        end
                    end})
                else
                    AQUAclient.notify(player,{"~d~No players nearby!"}) --no players nearby
                end
            end)
        else
            AQUAclient.notify(player,{"~d~You do not own "..house.."!"})
        end
    end)
end)

--Chest

RegisterNetEvent("JudHousing:OpenChest")
AddEventHandler("JudHousing:OpenChest", function(house)
    local user_id = AQUA.getUserId({source})
    local player = AQUA.getUserSource({user_id})

    getUserByAddress(house, 1, function(huser_id)
        if huser_id == user_id then --check if homeowner is user
            TriggerClientEvent("AQUA:OpenHomeStorage", player, true , house) --JamesUK inventory modified by me
        --print(house)
        else
            AQUAclient.notify(player,{"~d~You do not own this house!"})
        end
    end)
end)

--Wardrobe

RegisterNetEvent("JudHousing:SaveOutfit")
AddEventHandler("JudHousing:SaveOutfit", function(outfitName)
    local user_id = AQUA.getUserId({source})
    local player = AQUA.getUserSource({user_id})

    AQUA.getUData({user_id, "AQUA:home:wardrobe", function(data)
        local sets = json.decode(data)

        if sets == nil then --check if user has no current wardrobe data and creates empty table
            sets = {}
        end

        AQUAclient.getCustomization(player,{},function(custom)
            sets[outfitName] = custom --add outfit to table
            AQUA.setUData({user_id,"AQUA:home:wardrobe",json.encode(sets)}) --add outfit to database
            AQUAclient.notify(player,{"~g~Saved outfit "..outfitName.." to wardrobe!"})
            TriggerClientEvent("JudHousing:UpdateWardrobe", player, sets) --update wardrobe for client
        end)
    end})
end)

RegisterNetEvent("JudHousing:RemoveOutfit")
AddEventHandler("JudHousing:RemoveOutfit", function(outfitName)
    local user_id = AQUA.getUserId({source})
    local player = AQUA.getUserSource({user_id})

    AQUA.getUData({user_id, "AQUA:home:wardrobe", function(data)
        local sets = json.decode(data)

        if sets == nil then --check if user has no current wardrobe data and creates empty table
            sets = {}
        end

        sets[outfitName] = nil --replaces outfit in table with nil

        AQUA.setUData({user_id,"AQUA:home:wardrobe",json.encode(sets)}) --add new table to db
        AQUAclient.notify(player,{"~d~Remove outfit "..outfitName.." from wardrobe!"})
        TriggerClientEvent("JudHousing:UpdateWardrobe", player, sets) --update wardrobe for client
    end})
end)

RegisterNetEvent("JudHousing:LoadWardrobe")
AddEventHandler("JudHousing:LoadWardrobe", function()
    local user_id = AQUA.getUserId({source})
    local player = AQUA.getUserSource({user_id})

    AQUA.getUData({user_id, "AQUA:home:wardrobe", function(data) --get data 
        local sets = json.decode(data)

        if sets == nil then --check if user has no current wardrobe data and creates empty table
            sets = {}
        end

        TriggerClientEvent("JudHousing:UpdateWardrobe", player, sets) --update wardrobe for client
        if AQUA.hasGroup({user_id, 'VIP'}) then
            TriggerClientEvent("clothingMenu:UpdateWardrobe", player, sets) --update wardrobe for client
        else
            TriggerClientEvent('clothingMenu:closeWardrobe')
        end
    end})
end)


--Blips

AddEventHandler("AQUA:playerSpawn",function(user_id, source, first_spawn)
    for k, v in pairs(cfghomes.homes) do
        local x,y,z = table.unpack(v.entry_point)
        getUserByAddress(k,1,function(owner)
            if owner == nil then -- check if house is avaliable to be bought aka no owner of home
                AQUAclient.addBlip(source,{x,y,z,374,2,k}) -- add blip, 374,2 green house symbol
            end

            if owner == user_id then -- check if owner is user
                AQUAclient.addBlip(source,{x,y,z,374,1,k}) -- add blip for owner of home, 374,2 green house symbol
            end
        end)
    end
end)
