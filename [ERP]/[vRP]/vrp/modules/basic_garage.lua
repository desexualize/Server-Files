-- -- a basic garage implementation
-- -- vehicle db
local lang = vRP.lang
local cfg = module("ERP-Veh", "cfg/cfg_garages")
local cfg_inventory = module("ERP-Veh", "cfg/cfg_inventory")
local vehicle_groups = cfg.garage_types
local limit = 500000000
MySQL.createCommand("vRP/add_vehicle","INSERT IGNORE INTO vRP_user_vehicles(user_id,vehicle,vehicle_plate) VALUES(@user_id,@vehicle,@registration)")
MySQL.createCommand("vRP/remove_vehicle","DELETE FROM vRP_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle")
MySQL.createCommand("vRP/get_vehicles", "SELECT vehicle, rentedtime, vehicle_plate FROM vRP_user_vehicles WHERE user_id = @user_id AND rented = 0")
MySQL.createCommand("vRP/get_rented_vehicles_in", "SELECT vehicle, rentedtime, user_id FROM vRP_user_vehicles WHERE user_id = @user_id AND rented = 1")
MySQL.createCommand("vRP/get_rented_vehicles_out", "SELECT vehicle, rentedtime, user_id FROM vRP_user_vehicles WHERE rentedid = @user_id AND rented = 1")
MySQL.createCommand("vRP/get_vehicle","SELECT vehicle FROM vRP_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle")
MySQL.createCommand("vRP/check_rented","SELECT * FROM vRP_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle AND rented = 1")
MySQL.createCommand("vRP/sell_vehicle_player","UPDATE vRP_user_vehicles SET user_id = @user_id, vehicle_plate = @registration WHERE user_id = @oldUser AND vehicle = @vehicle")
MySQL.createCommand("vRP/rentedupdate", "UPDATE vRP_user_vehicles SET user_id = @id, rented = @rented, rentedid = @rentedid, rentedtime = @rentedunix WHERE user_id = @user_id AND vehicle = @veh")
MySQL.createCommand("vRP/fetch_rented_vehs", "SELECT * FROM vRP_user_vehicles WHERE rented = 1")


Citizen.CreateThread(function()
    while true do
        Wait(300000)
        MySQL.query('vRP/fetch_rented_vehs', {}, function(pvehicles)
            for i,v in pairs(pvehicles) do 
               if os.time() > tonumber(v.rentedtime) then
                  MySQL.execute('vRP/rentedupdate', {id = v.rentedid, rented = 0, rentedid = "", rentedunix = "", user_id = v.user_id, veh = v.vehicle})
               end
            end
        end)
        print('[ERG] Vehicle Rent Check | Successful')
    end
end)

RegisterNetEvent('vRP:FetchCars')
AddEventHandler('vRP:FetchCars', function(owned, type)
    local source = source
    local user_id = vRP.getUserId(source)
    local returned_table = {}
    if user_id then
        if not owned then
            for i, v in pairs(vehicle_groups) do
                local noperms = false;
                local config = vehicle_groups[i]._config
                if config.vtype == type or config.vtype2 == type or config.vtype3 == type then 
                    local perm = config.permissions or nil
                    if perm then
                        for i, v in pairs(perm) do
                            if not vRP.hasPermission(user_id, v) then
                                noperms = true;
                            end
                        end
                    end
                    if not noperms then 
                        returned_table[i] = {
                            ["config"] = config
                        }
                        returned_table[i].vehicles = {}
                        for a, z in pairs(v) do
                            if a ~= "_config" then
                                returned_table[i].vehicles[a] = {z[1], z[2]}
                            end
                        end
                    end
                end 
            end
            TriggerClientEvent('vRP:ReturnFetchedCars', source, returned_table)
        else
            MySQL.query("vRP/get_vehicles", {
                user_id = user_id
            }, function(pvehicles, affected, plate)
                for _, veh in pairs(pvehicles) do
                    for i, v in pairs(vehicle_groups) do
                        local noperms = false;
                        local config = vehicle_groups[i]._config
                        if config.vtype == type or config.vtype2 == type or config.vtype3 == type then 
                            local perm = config.permissions or nil
                            if perm then
                                for i, v in pairs(perm) do
                                    if not vRP.hasPermission(user_id, v) then
                                        noperms = true;
                                    end
                                end
                            end
                            if not noperms then 
                                for a, z in pairs(v) do
                                    if a ~= "_config" and veh.vehicle == a then
                                        if not returned_table[i] then 
                                            returned_table[i] = {
                                                ["config"] = config
                                            }
                                        end
                                        if not returned_table[i].vehicles then 
                                            returned_table[i].vehicles = {}
                                        end
                                        returned_table[i].vehicles[a] = {z[1], z[2], veh.vehicle_plate} -- plate from vRP/get_vehicles
                                    end
                                end
                            end
                        end
                    end
                end
                TriggerClientEvent('vRP:ReturnFetchedCars', source, returned_table)
            end)
        end
    end
end)

RegisterNetEvent('vRP:ScrapVehicle')
AddEventHandler('vRP:ScrapVehicle', function(vehicle)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then 
        MySQL.query("vRP/check_rented", {user_id = user_id, vehicle = vehicle}, function(pvehicles)
            MySQL.query("vRP/get_vehicle", {user_id = user_id, vehicle = vehicle}, function(pveh)
                if #pveh < 0 then 
                    ERGclient.notify(source,{"~r~You cannot destroy a vehicle you do not own"})
                    return
                end
                if #pvehicles > 0 then 
                    ERGclient.notify(source,{"~r~You cannot destroy a rented vehicle!"})
                    return
                end
                MySQL.execute('vRP/remove_vehicle', {user_id = user_id, vehicle = vehicle})
                TriggerClientEvent('vRP:CloseGarage', source)
            end)
        end)
    end
end)

RegisterNetEvent('vRP:SellVehicle')
AddEventHandler('vRP:SellVehicle', function(veh)
    local name = veh
    local player = source 
    local playerID = vRP.getUserId(source)
    if playerID ~= nil then
		ERGclient.getNearestPlayers(player,{15},function(nplayers)
			usrList = ""
			for k,v in pairs(nplayers) do
				usrList = usrList .. "[" .. vRP.getUserId(k) .. "]" .. GetPlayerName(k) .. " | "
			end
			if usrList ~= "" then
				vRP.prompt(player,"Players Nearby: " .. usrList .. "","",function(player,user_id) 
					user_id = user_id
					if user_id ~= nil and user_id ~= "" then 
						local target = vRP.getUserSource(tonumber(user_id))
						if target ~= nil then
							vRP.prompt(player,"Price £: ","",function(player,amount)
								if tonumber(amount) and tonumber(amount) > 0 and tonumber(amount) < limit then
									MySQL.query("vRP/get_vehicle", {user_id = user_id, vehicle = name}, function(pvehicle, affected)
										if #pvehicle > 0 then
											ERGclient.notify(player,{"~r~The player already has this vehicle type."})
										else
											local tmpdata = vRP.getUserTmpTable(playerID)
											MySQL.query("vRP/check_rented", {user_id = playerID, vehicle = veh}, function(pvehicles)
                                                if #pvehicles > 0 then 
                                                    ERGclient.notify(player,{"~r~You cannot sell a rented vehicle!"})
                                                    return
                                                else
                                                    vRP.request(target,GetPlayerName(player).." wants to sell: " ..name.. " Price: £"..amount, 10, function(target,ok)
                                                        if ok then
                                                            local pID = vRP.getUserId(target)
                                                            amount = tonumber(amount)
                                                            if vRP.tryFullPayment(pID,amount) then
                                                                ERGclient.despawnGarageVehicle(player,{'car',15}) 
                                                                vRP.getUserIdentity(pID, function(identity)
                                                                    MySQL.execute("vRP/sell_vehicle_player", {user_id = user_id, registration = "P "..identity.registration, oldUser = playerID, vehicle = name}) 
                                                                end)
                                                                vRP.giveBankMoney(playerID, amount)
                                                                ERGclient.notify(player,{"~g~You have successfully sold the vehicle to ".. GetPlayerName(target).." for £"..amount.."!"})
                                                                ERGclient.notify(target,{"~g~"..GetPlayerName(player).." has successfully sold you the car for £"..amount.."!"})
                                                                TriggerClientEvent('vRP:CloseGarage', player)
                                                                webhook = "WEBHOOK_HERE"
       
                                                                PerformHttpRequest(webhook, function(err, text, headers) 
                                                                end, "POST", json.encode({username = "ERG", embeds = {
                                                                    {
                                                                        ["color"] = "15158332",
                                                                        ["title"] = "Car Sale",
                                                                        ["description"] = "**Seller Name: **" .. GetPlayerName(player) .. "** \nUser ID: **" .. playerID.. "** \nPrice: **£" .. amount .. '**\nReciever ID: **' ..pID..'**\nSpawncode:** '..name,
                                                                        ["footer"] = {
                                                                            ["text"] = "Time - "..os.date("%x %X %p"),
                                                                        }
                                                                }
                                                            }}), { ["Content-Type"] = "application/json" })
                                                            else
                                                                ERGclient.notify(player,{"~r~".. GetPlayerName(target).." doesn't have enough money!"})
                                                                ERGclient.notify(target,{"~r~You don't have enough money!"})
                                                            end
                                                        else
                                                            ERGclient.notify(player,{"~r~"..GetPlayerName(target).." has refused to buy the car."})
                                                            ERGclient.notify(target,{"~r~You have refused to buy "..GetPlayerName(player).."'s car."})
                                                        end
                                                    end)
                                                end
                                            end)
										end
									end) 
								else
									ERGclient.notify(player,{"~r~The price of the car has to be a number."})
								end
							end)
						else
							ERGclient.notify(player,{"~r~That ID seems invalid."})
						end
					else
						ERGclient.notify(player,{"~r~No player ID selected."})
					end
				end)
			else
				ERGclient.notify(player,{"~r~No players nearby."})
			end
		end)
    end
end)


RegisterNetEvent('vRP:RentVehicle')
AddEventHandler('vRP:RentVehicle', function(veh)
    local name = veh
    local player = source 
    local playerID = vRP.getUserId(source)
    if playerID ~= nil then
		ERGclient.getNearestPlayers(player,{15},function(nplayers)
			usrList = ""
			for k,v in pairs(nplayers) do
				usrList = usrList .. "[" .. vRP.getUserId(k) .. "]" .. GetPlayerName(k) .. " | "
			end
			if usrList ~= "" then
				vRP.prompt(player,"Players Nearby: " .. usrList .. "","",function(player,user_id) 
					user_id = user_id
					if user_id ~= nil and user_id ~= "" then 
						local target = vRP.getUserSource(tonumber(user_id))
						if target ~= nil then
							vRP.prompt(player,"Price £: ","",function(player,amount)
                                vRP.prompt(player,"Rent time (in hours): ","",function(player,rent)
                                    if tonumber(rent) and tonumber(rent) >  0 then 
                                        if tonumber(amount) and tonumber(amount) > 0 and tonumber(amount) < limit then
                                            MySQL.query("vRP/get_vehicle", {user_id = user_id, vehicle = name}, function(pvehicle, affected)
                                                if #pvehicle > 0 then
                                                    ERGclient.notify(player,{"~r~The player already has this vehicle type."})
                                                else
                                                    local tmpdata = vRP.getUserTmpTable(playerID)
                                                    MySQL.query("vRP/check_rented", {user_id = playerID, vehicle = veh}, function(pvehicles)
                                                        if #pvehicles > 0 then 
                                                            ERGclient.notify(player,{"~r~You cannot rent a rented vehicle!"})
                                                            return
                                                        else
                                                            vRP.request(target,GetPlayerName(player).." wants to rent: " ..name.. " Price: £"..amount .. ' | for: ' .. rent .. 'hours', 10, function(target,ok)
                                                                if ok then
                                                                    local pID = vRP.getUserId(target)
                                                                    amount = tonumber(amount)
                                                                    if vRP.tryFullPayment(pID,amount) then
                                                                        ERGclient.despawnGarageVehicle(player,{'car',15}) 
                                                                        vRP.getUserIdentity(pID, function(identity)
                                                                            local rentedTime = os.time()
                                                                            rentedTime = rentedTime  + (60 * 60 * tonumber(rent)) 
                                                                            MySQL.execute("vRP/rentedupdate", {user_id = playerID, veh = name, id = pID, rented = 1, rentedid = playerID, rentedunix =  rentedTime }) 
                                                                        end)
                                                                        vRP.giveBankMoney(playerID, amount)
                                                                        ERGclient.notify(player,{"~g~You have successfully rented the vehicle to ".. GetPlayerName(target).." for £"..amount.."!" .. ' | for: ' .. rent .. 'hours'})
                                                                        ERGclient.notify(target,{"~g~"..GetPlayerName(player).." has successfully rented you the car for £"..amount.."!" .. ' | for: ' .. rent .. 'hours'})
                                                                        TriggerClientEvent('vRP:CloseGarage', player)
                                                                    else
                                                                        ERGclient.notify(player,{"~r~".. GetPlayerName(target).." doesn't have enough money!"})
                                                                        ERGclient.notify(target,{"~r~You don't have enough money!"})
                                                                    end
                                                                else
                                                                    ERGclient.notify(player,{"~r~"..GetPlayerName(target).." has refused to rent the car."})
                                                                    ERGclient.notify(target,{"~r~You have refused to rent "..GetPlayerName(player).."'s car."})
                                                                end
                                                            end)
                                                        end
                                                    end)
                                                end
                                            end) 
                                        else
                                            ERGclient.notify(player,{"~r~The price of the car has to be a number."})
                                        end
                                    else 
                                        ERGclient.notify(player,{"~r~The rent time of the car has to be in hours and a number."})
                                    end
                                end)
							end)
						else
							ERGclient.notify(player,{"~r~That ID seems invalid."})
						end
					else
						ERGclient.notify(player,{"~r~No player ID selected."})
					end
				end)
			else
				ERGclient.notify(player,{"~r~No players nearby."})
			end
		end)
    end
end)



RegisterNetEvent('vRP:FetchVehiclesIn')
AddEventHandler('vRP:FetchVehiclesIn', function()
    local returned_table = {}
    local source = source
    local user_id = vRP.getUserId(source)
    MySQL.query("vRP/get_rented_vehicles_in", {
        user_id = user_id
    }, function(pvehicles, affected)
        for _, veh in pairs(pvehicles) do
            for i, v in pairs(vehicle_groups) do
                local config = vehicle_groups[i]._config
                local perm = config.permissions or nil
                if perm then
                    for i, v in pairs(perm) do
                        if not vRP.hasPermission(user_id, v) then
                            break
                        end
                    end
                end
                for a, z in pairs(v) do
                    if a ~= "_config" and veh.vehicle == a then
                        if not returned_table[i] then 
                            returned_table[i] = {
                                ["config"] = config
                            }
                        end
                        if not returned_table[i].vehicles then 
                            returned_table[i].vehicles = {}
                        end
                        local time = tonumber(veh.rentedtime) - os.time()
                        local datetime = ""
                        local date = os.date("!*t", time)
                        if date.hour >= 1 and date.min >= 1 then 
                            datetime = date.hour .. " hours and " .. date.min .. " minutes left"
                        elseif date.hour <= 1 and date.min >= 1 then 
                            datetime = date.min .. " minutes left"
                        elseif date.hour >= 1 and date.min <= 1 then 
                            datetime = date.hour .. " hours left"
                        end
                        returned_table[i].vehicles[a] = {z[1], datetime}
                    end
                end
            end
        end
        TriggerClientEvent('vRP:ReturnFetchedCars', source, returned_table)
    end)
end)

RegisterNetEvent('vRP:FetchVehiclesOut')
AddEventHandler('vRP:FetchVehiclesOut', function()
    local returned_table = {}
    local source = source
    local user_id = vRP.getUserId(source)
    MySQL.query("vRP/get_rented_vehicles_out", {
        user_id = user_id
    }, function(pvehicles, affected)
        for _, veh in pairs(pvehicles) do
            for i, v in pairs(vehicle_groups) do
                local config = vehicle_groups[i]._config
                local perm = config.permissions or nil
                if perm then
                    for i, v in pairs(perm) do
                        if not vRP.hasPermission(user_id, v) then
                            break
                        end
                    end
                end
                for a, z in pairs(v) do
                    if a ~= "_config" and veh.vehicle == a then
                        if not returned_table[i] then 
                            returned_table[i] = {
                                ["config"] = config
                            }
                        end
                        if not returned_table[i].vehicles then 
                            returned_table[i].vehicles = {}
                        end
                        local time = tonumber(veh.rentedtime) - os.time()
                        local datetime = ""
                        local date = os.date("!*t", time)
                        if date.hour >= 1 and date.min >= 1 then 
                            datetime = date.hour .. " hours and " .. date.min .. " minutes left."
                        elseif date.hour <= 1 and date.min >= 1 then 
                            datetime = date.min .. " minutes left"
                        elseif date.hour >= 1 and date.min <= 1 then 
                            datetime = date.hour .. " hours left"
                        end
                        returned_table[i].vehicles[a .. ':' .. veh.user_id] = {z[1], datetime, veh.user_id, a}
                    end
                end
            end
        end
        TriggerClientEvent('vRP:ReturnFetchedCars', source, returned_table)
    end)
end)

RegisterServerEvent("vRP:FetchFolders")
AddEventHandler('vRP:FetchFolders', function()
    local source = source
    local PlayerID = vRP.getUserId(source)
    local Folders = {}
    exports["ghmattimysql"]:execute("SELECT * from `custom_garages` WHERE UserID = @ID", {ID = PlayerID}, function(Result)
        if #Result > 0 then
            print(Result[1].Folder)
            TriggerClientEvent("vRP:ReturnFolders", source, json.decode(Result[1].Folder))
        end
    end)
end)


RegisterServerEvent("vRP:UpdateFolders")
AddEventHandler('vRP:UpdateFolders', function(FolderUpdated)
    local source = source
    local PlayerID = vRP.getUserId(source)

    exports["ghmattimysql"]:execute("SELECT * from `custom_garages` WHERE UserID = @ID", {ID = PlayerID}, function(Result)
        if #Result > 0 then
            -- print(Result[1].Folder)
            exports['ghmattimysql']:execute("UPDATE custom_garages SET Folder = @Folder WHERE UserID = @UserID", {Folder = json.encode(FolderUpdated), UserID = PlayerID}, function() end)
        else
            exports['ghmattimysql']:execute("INSERT INTO custom_garages (`UserID`, `Folder`) VALUES (@UserID, @Folder);", {UserID = PlayerID, Folder = json.encode(FolderUpdated)}, function() end)
        end
    end)
end)


local veh_actions = {}

-- open trunk
veh_actions[lang.vehicle.trunk.title()] = {function(user_id,player,vtype,name)
  local chestname = "u"..user_id.."veh_"..string.lower(name)
  local max_weight = cfg_inventory.vehicle_chest_weights[string.lower(name)] or cfg_inventory.default_vehicle_chest_weight

  -- open chest
  ERGclient.vc_openDoor(player, {vtype,5})
  vRP.openChest(player, chestname, max_weight, function()
    ERGclient.vc_closeDoor(player, {vtype,5})
  end)
end, lang.vehicle.trunk.description()}

--sell2
MySQL.createCommand("vRP/sell_vehicle_player","UPDATE vRP_user_vehicles SET user_id = @user_id, vehicle_plate = @registration WHERE user_id = @oldUser AND vehicle = @vehicle")




local function ch_vehicle(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    -- check vehicle
    ERGclient.getNearestOwnedVehicle(player,{7},function(ok,vtype,name)
      if ok then
        -- build vehicle menu
        vRP.buildMenu("vehicle", {user_id = user_id, player = player, vtype = vtype, vname = name}, function(menu)
          menu.name=lang.vehicle.title()
          menu.css={top="75px",header_color="rgba(255,125,0,0.75)"}

          for k,v in pairs(veh_actions) do
            menu[k] = {function(player,choice) v[1](user_id,player,vtype,name) end, v[2]}
          end

          vRP.openMenu(player,menu)
        end)
      else
        ERGclient.notify(player,{lang.vehicle.no_owned_near()})
      end
    end)
  end
end

-- ask trunk (open other user car chest)
local function ch_asktrunk(player,choice)
  ERGclient.getNearestPlayer(player,{10},function(nplayer)
    local nuser_id = vRP.getUserId(nplayer)
    if nuser_id ~= nil then
      ERGclient.notify(player,{lang.vehicle.asktrunk.asked()})
      vRP.request(nplayer,lang.vehicle.asktrunk.request(),15,function(nplayer,ok)
        if ok then -- request accepted, open trunk
          ERGclient.getNearestOwnedVehicle(nplayer,{7},function(ok,vtype,name)
            if ok then
              local chestname = "u"..nuser_id.."veh_"..string.lower(name)
              local max_weight = cfg_inventory.vehicle_chest_weights[string.lower(name)] or cfg_inventory.default_vehicle_chest_weight

              -- open chest
              local cb_out = function(idname,amount)
                ERGclient.notify(nplayer,{lang.inventory.give.given({vRP.getItemName(idname),amount})})
              end

              local cb_in = function(idname,amount)
                ERGclient.notify(nplayer,{lang.inventory.give.received({vRP.getItemName(idname),amount})})
              end

              ERGclient.vc_openDoor(nplayer, {vtype,5})
              vRP.openChest(player, chestname, max_weight, function()
                ERGclient.vc_closeDoor(nplayer, {vtype,5})
              end,cb_in,cb_out)
            else
              ERGclient.notify(player,{lang.vehicle.no_owned_near()})
              ERGclient.notify(nplayer,{lang.vehicle.no_owned_near()})
            end
          end)
        else
          ERGclient.notify(player,{lang.common.request_refused()})
        end
      end)
    else
      ERGclient.notify(player,{lang.common.no_player_near()})
    end
  end)
end

-- repair nearest vehicle
local function ch_repair(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    -- anim and repair
    if vRP.tryGetInventoryItem(user_id,"repairkit",1,true) then
      ERGclient.playAnim(player,{false,{task="WORLD_HUMAN_WELDING"},false})
      SetTimeout(15000, function()
        ERGclient.fixeNearestVehicle(player,{7})
        ERGclient.stopAnim(player,{false})
      end)
    end
  end
end

-- replace nearest vehicle
local function ch_replace(player,choice)
  ERGclient.replaceNearestVehicle(player,{7})
end

RegisterNetEvent("returnVIP")
AddEventHandler("returnVIP", function()
    
    local source = source 
    userid = vRP.getUserId(source)
    if vRP.hasGroup(userid, "VIP") then 
        TriggerClientEvent("openVIP", source)
    end
end)
RegisterNetEvent("returnVIPaircraft")
AddEventHandler("returnVIPaircraft", function()
    
    local source = source 
    userid = vRP.getUserId(source)
    if vRP.hasGroup(userid, "VIP") then 
        TriggerClientEvent("openVIPaircraft", source)
    end
end)

RegisterNetEvent("returnpolice")
AddEventHandler("returnpolice", function()
    
    local source = source 
    userid = vRP.getUserId(source)
    if vRP.hasPermission(userid, "police.menu" ) then
        TriggerClientEvent("openPolice", source)
    end
end)

RegisterNetEvent("returnRebel")
AddEventHandler("returnRebel", function()
    
    local source = source 
    userid = vRP.getUserId(source)
   if vRP.hasGroup(userid, "Rebel") then 
        TriggerClientEvent("openRebel", source)
    end
end)

RegisterNetEvent("vRP:PayVehicleTax")
AddEventHandler("vRP:PayVehicleTax", function()
    local user_id = vRP.getUserId(source)

    if user_id ~= nil then
        local bank = vRP.getBankMoney(user_id)
        local payment = bank / 1500
    
       
        if bank == 0 then
            ERGclient.notify(source,{"~r~Its fine... Tax payers will pay your vehicle tax instead."})
        elseif vRP.tryBankPayment(user_id, payment) then
            ERGclient.notify(source,{"~g~Paid £"..getMoneyStringFormatted(roundnumber(payment, 0)).." vehicle tax."})
        end
    end
end)

function getMoneyStringFormatted(cashString)
	local i, j, minus, int, fraction = tostring(cashString):find('([-]?)(%d+)([.]?%d*)')
	int = int:reverse():gsub("(%d%d%d)", "%1,")
	return minus .. int:reverse():gsub("^,", "") .. fraction 
end

function roundnumber(P, Q)
    local R = 10 ^ (Q or 0)
    return math.floor(P * R + 0.5)
end

Citizen.CreateThread(function()
    Wait(1500)
    exports['ghmattimysql']:execute([[
        CREATE TABLE IF NOT EXISTS `custom_garages` (
            `UserID` INT(11) NOT NULL AUTO_INCREMENT,
            `Folder` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
            PRIMARY KEY (`UserID`) USING BTREE
        );
    ]])
    print("[ERG] Custom Garages Initialised!")
end)