local lang = AQUA.lang
local cfg = module("cfg/police")

RegisterServerEvent('AQUA:OpenPoliceMenu')
AddEventHandler('AQUA:OpenPoliceMenu', function()
    local source = source
    local user_id = AQUA.getUserId(source)
    if user_id ~= nil and AQUA.hasPermission(user_id, "police.armoury") then
        TriggerClientEvent("AQUA:PoliceMenuOpened", source)
    elseif user_id ~= nil and AQUA.hasPermission(user_id, "clockon.menu") then
      AQUAclient.notify(source,{"You are not on duty"})
    end
end)

RegisterServerEvent('AQUA:ActivateZone')
AddEventHandler('AQUA:ActivateZone', function(message, speed, radius, x, y, z)
    TriggerClientEvent('chatMessage', -1, "" , { 128, 128, 128 }, message, "alert")
    TriggerClientEvent('AQUA:ZoneCreated', -1, speed, radius, x, y, z)
end)

RegisterServerEvent('AQUA:RemoveZone')
AddEventHandler('AQUA:RemoveZone', function(blip)
    TriggerClientEvent('AQUA:RemovedBlip', -1)
end)

RegisterServerEvent('AQUA:Drag')
AddEventHandler('AQUA:Drag', function()
    player = source
    local user_id = AQUA.getUserId(player)
    if user_id ~= nil and AQUA.hasPermission(user_id, "police.armoury") then
        AQUAclient.getNearestPlayer(player,{10},function(nplayer)
        if nplayer ~= nil then
            local nuser_id = AQUA.getUserId(nplayer)
            if nuser_id ~= nil then
            AQUAclient.isHandcuffed(nplayer,{},function(handcuffed)
                if handcuffed then
                    TriggerClientEvent("AQUA:DragPlayer", nplayer, player)
                else
                    AQUAclient.notify(player,{"~d~Player is not handcuffed."})
                end
            end)
            else
                AQUAclient.notify(player,{"~d~There is no player nearby"})
            end
            else
                AQUAclient.notify(player,{"~d~There is no player nearby"})
            end
        end)
    end
end)

local cuff = false

RegisterServerEvent('AQUA:Handcuff')
AddEventHandler('AQUA:Handcuff', function()
    player = source
    local user_id = AQUA.getUserId(player)
    if user_id ~= nil and AQUA.hasPermission(user_id, "pd.armory") then
      AQUAclient.getNearestPlayer(player,{20},function(nplayer)
          local nuser_id = AQUA.getUserId(nplayer)
          if nuser_id ~= nil then
         
            AQUAclient.isHandcuffed(nplayer,{}, function(handcuffed)  -- check handcuffed
              if not handcuffed then
                  AQUAclient.setHandcuffed(nplayer, {true})
              else
                  AQUAclient.setHandcuffed(nplayer, {false})
              end
            end)

           
           
            AQUA.closeMenu(nplayer)
          else
            AQUAclient.notify(player,{"~d~There is no player nearby"})
          end
      end)
    end
end)

local unjailed = {}
function jail_clock(target_id,timer)
  local target = AQUA.getUserSource(tonumber(target_id))
  local users = AQUA.getUsers()
  local online = false
  for k,v in pairs(users) do
	if tonumber(k) == tonumber(target_id) then
	  online = true
	end
  end
  if online then
    if timer>0 then
	  AQUAclient.notify(target, {"~d~Remaining time: " .. timer .. " minute(s)."})
      AQUA.setUData(tonumber(target_id),"AQUA:jail:time",json.encode(timer))
	  SetTimeout(60*1000, function()
		for k,v in pairs(unjailed) do -- check if player has been unjailed by cop or admin
		  if v == tonumber(target_id) then
	        unjailed[v] = nil
		    timer = 0
		  end
		end
	    jail_clock(tonumber(target_id),timer-1)
	  end) 
    else 
    TriggerClientEvent("returnFalse", target)
	  AQUAclient.teleport(target,{1854.2919921875,2586.1066894531,45.672054290771}) -- teleport to outside jail
	  AQUAclient.setHandcuffed(target,{false})
      AQUAclient.notify(target,{"~d~You have been set free."})
      
	  AQUA.setUData({tonumber(target_id),"AQUA:jail:time",json.encode(-1)})
    end
  end
end

RegisterServerEvent('AQUA:SeizeWeapons2')
AddEventHandler('AQUA:SeizeWeapons2', function()
  local source = source
    player = source
    local user_id = AQUA.getUserId(player)
    if user_id ~= nil and AQUA.hasPermission(user_id, "police.menu") then
            AQUAclient.getNearestPlayer(player,{10},function(nplayer)
              AQUAclient.isHandcuffed(nplayer,{}, function(handcuffed)  -- check handcuffed
                if handcuffed then 
            if nplayer ~= nil then
                local nuser_id = AQUA.getUserId(nplayer)
                if nuser_id ~= nil then
                  RemoveAllPedWeapons(nplayer, true)
                  AQUA.clearInventory(nuser_id) 
                  AQUAclient.notify(player, {'~g~Seized players weapons'})
                  AQUAclient.notify(nplayer, {'~d~Your weapons were seized'})
                else
                    AQUAclient.notify(player,{"~d~There is no player nearby"})
                end
                else
                    AQUAclient.notify(player,{"~d~There is no player nearby"})
                end
              else
                AQUAclient.notify(player, {'~d~Player has to be cuffed.'})
              end
            end)
            end)
    end
end)

RegisterServerEvent('AQUA:JailPlayer')
AddEventHandler('AQUA:JailPlayer', function()
    player = source
    local user_id = AQUA.getUserId(player)
    if user_id ~= nil and AQUA.hasPermission(user_id, "police.armoury") then
    AQUAclient.getNearestPlayers(player,{15},function(nplayers) 
      local user_list = ""
      for k,v in pairs(nplayers) do
        user_list = user_list .. "[" .. AQUA.getUserId(k) .. "]" .. GetPlayerName(k) .. " | "
      end 
        AQUA.prompt(player,"Players Nearby:" .. user_list,"",function(player,target_id) 
          if target_id ~= nil and target_id ~= "" then 
            if not target_id and nplayers then return end
            AQUA.prompt(player,"Jail Time in minutes:","1",function(player,jail_time)
              if jail_time ~= nil and jail_time ~= "" then 
                local target = AQUA.getUserSource(tonumber(target_id))
                if target ~= nil then
                  if tonumber(jail_time) > 60 then
                      jail_time = 60
                  end
                  if tonumber(jail_time) < 1 then
                    jail_time = 1
                  end
            
                  AQUAclient.isHandcuffed(target,{}, function(handcuffed)  
                        AQUAclient.loadFreeze(target,{false,true,true})
                      SetTimeout(15000,function()
                        AQUAclient.loadFreeze(target,{false,false,false})
                      end)
                      AQUAclient.teleport(target,{1779.8850097656,2584.3186035156,45.797779083252}) -- teleport to inside jail
                      AQUAclient.notify(target,{"~d~You have been sent to jail."})
                      AQUAclient.notify(player,{"~d~You sent a player to jail."})
                      AQUAclient.setHandcuffed(target, {false})
                      jail_clock(tonumber(target_id),tonumber(jail_time))
                      TriggerClientEvent("returnTrue", target)
                      TriggerClientEvent("stopjail", target)
                      local user_id = AQUA.getUserId(player)
                      local jaillogs = {
                        {
                            ["color"] = "16777215",
                            ["description"] = "**ID:** " .. user_id .. " **jailed **" .. target_id .. "** for **" .. jail_time .. " **minutes**",
                            ["footer"] = {
                              ["text"] = " - "..os.date("%X"),
                              ["icon_url"] = "https://media.discordapp.net/attachments/1014165521563914311/1038550242116784268/unknown.png",
                            }
                        }
                    }
                    PerformHttpRequest("https://discord.com/api/webhooks/1038909072184975450/ZITMWPZksHHzGnDkWK-dnh_xb5R1Kwrwz822P6R4lRNlM0JMc5VYct07BaBx06e6f8O4", function(err, text, headers) 
                    end, "POST", json.encode({username = "Jail Logs", embeds = jaillogs}), { ["Content-Type"] = "application/json" })
                  end)
                else
                  AQUAclient.notify(player,{"~d~That ID seems invalid."})
                end
              else
                AQUAclient.notify(player,{"~d~The jail time can't be empty."})
              end
            end)
          else
            AQUAclient.notify(player,{"~d~No player ID selected."})
          end 
        end)
    end)
    else
        print(user_id.." could be modding")
    end
end)

RegisterServerEvent('AQUA:UnJailPlayer')
AddEventHandler('AQUA:UnJailPlayer', function()
    player = source
    local user_id = AQUA.getUserId(player)
    if user_id ~= nil and AQUA.hasPermission(user_id, "admin.noclip") then
	  AQUA.prompt(player,"Player ID:","",function(player,target_id) 
	  if target_id ~= nil and target_id ~= "" then 
      AQUA.getUData(tonumber(target_id),"AQUA:jail:time",function(value)
        if value ~= nil then
        custom = json.decode(value)
        if custom ~= nil then
          local user_id = AQUA.getUserId(player)
          if tonumber(custom) > 0 or AQUA.hasPermission(user_id,"admin.noclip") then
                local target = AQUA.getUserSource(tonumber(target_id))
          if target ~= nil then
            unjailed[target] = tonumber(target_id)
            AQUA.setUData(tonumber(target_id),"AQUA:jail:time",json.encode(-1))
            AQUAclient.notify(player,{"~g~Target will be released soon."})
            AQUAclient.notify(target,{"~g~Someone lowered your sentence."})
            local unjaillogs = {
              {
                  ["color"] = "16777215",
                  ["description"] = "**ID:** " .. user_id .. " **unjailed** " .. target_id,
                  ["footer"] = {
                    ["text"] = " - "..os.date("%X"),
                    ["icon_url"] = "https://media.discordapp.net/attachments/1014165521563914311/1038550242116784268/unknown.png",
                  }
              }
          }
          PerformHttpRequest("", function(err, text, headers) 
          end, "POST", json.encode({username = "Unjail Logs", embeds = unjaillogs}), { ["Content-Type"] = "application/json" })
          else
            AQUAclient.notify(player,{"~d~That ID seems invalid."})
          end
          else
          AQUAclient.notify(player,{"~d~Target is not jailed."})
          end
        end
		  end
		end)
      else
        AQUAclient.notify(player,{"~d~No player ID selected."})
      end 
  end)
  else
    print(user_id.." Could be modder")
  end
end)

RegisterServerEvent('AQUA:sendFine')
AddEventHandler('AQUA:sendFine', function()
    player = source
    local user_id = AQUA.getUserId(player)
    if user_id ~= nil and AQUA.hasPermission(user_id, "police.group") then
      AQUAclient.getNearestPlayers(player,{15},function(nplayers) 
      local user_list = ""
      for k,v in pairs(nplayers) do
        user_list = user_list .. "[" .. AQUA.getUserId(k) .. "]" .. GetPlayerName(k) .. " | "
      end 
      if user_list ~= "" then
        AQUA.prompt(player,"Players Nearby:" .. user_list,"",function(player,target_id) 
          if target_id ~= nil and target_id ~= "" then 
            AQUA.prompt(player,"Fine amount:","100",function(player,fine)
              if fine ~= nil and fine ~= "" then 
                AQUA.prompt(player,"Fine reason:","",function(player,reason)
                  if reason ~= nil and reason ~= "" then 
                    local target = AQUA.getUserSource(tonumber(target_id))
                    if target ~= nil then
                      if tonumber(fine) > 100000 then
                          fine = 100000
                      end
                      if tonumber(fine) < 100 then
                        fine = 100
                      end
                
                      if AQUA.tryFullPayment(tonumber(target_id), tonumber(fine)) then
                        AQUA.insertPoliceRecord(tonumber(target_id), lang.police.menu.fine.record({reason,fine}))
                        AQUAclient.notify(player,{lang.police.menu.fine.fined({reason,fine})})
                        AQUAclient.notify(target,{lang.police.menu.fine.notify_fined({reason,fine})})
                        local user_id = AQUA.getUserId(player)
                        AQUA.closeMenu(player)
                      else
                        AQUAclient.notify(player,{lang.money.not_enough()})
                      end
                    else
                      AQUAclient.notify(player,{"~d~That ID seems invalid."})
                    end
                  else
                    AQUAclient.notify(player,{"~d~You can't fine for no reason."})
                  end
                end)
              else
                AQUAclient.notify(player,{"~d~Your fine has to have a value."})
              end
            end)
          else
            AQUAclient.notify(player,{"~d~No player ID selected."})
          end 
        end)
      else
        AQUAclient.notify(player,{"~d~No player nearby."})
      end 
    end)
  else
    print(user_id.." Could be modder")
  end
end)
RegisterNetEvent("AQUA:PutPlrInVeh")
AddEventHandler("AQUA:PutPlrInVeh", function()
    player = source
    local user_id = AQUA.getUserId(player)
    if user_id ~= nil and AQUA.hasPermission(user_id, "police.armoury") then
    AQUAclient.getNearestPlayer(player,{10},function(nplayer)
      local nuser_id = AQUA.getUserId(nplayer)
      if nuser_id ~= nil then
        AQUAclient.isHandcuffed(nplayer,{}, function(handcuffed)  -- check handcuffed
          if handcuffed then
            AQUAclient.putInNearestVehicleAsPassenger(nplayer, {5})
          else
            AQUAclient.notify(player,{"~d~Player is not not cuffed."})
          end
        end)
      else
        AQUAclient.notify(player,{"~d~No player nearby."})
      end
    end)
  else
    print(user_id.." Could be modder")
  end
end)

RegisterNetEvent("AQUA:TakeOutOfVehicle")
AddEventHandler("AQUA:TakeOutOfVehicle", function()
    player = source
    local user_id = AQUA.getUserId(player)
    if user_id ~= nil and AQUA.hasPermission(user_id, "police.armoury") then
    AQUAclient.getNearestPlayer(player,{10},function(nplayer)
        local nuser_id = AQUA.getUserId(nplayer)
        if nuser_id ~= nil then
        AQUAclient.isHandcuffed(nplayer,{}, function(handcuffed)  -- check handcuffed
            if handcuffed then
            AQUAclient.ejectVehicle(nplayer, {})
            else
              AQUAclient.notify(player,{"~d~Player is not not cuffed."})
            end
        end)
        else
          AQUAclient.notify(player,{"~d~No player nearby."})
        end
    end)
    else
        print(user_id.." Could be modder")
    end
end)

RegisterNetEvent("AQUA:SearchPlayer")
AddEventHandler("AQUA:SearchPlayer", function()
    player = source
    if user_id ~= nil and AQUA.hasPermission(user_id, "police.armoury") then
      AQUAclient.getNearestPlayer(player,{5},function(nplayer)
          local nuser_id = AQUA.getUserId(nplayer)
          if nuser_id ~= nil then
            AQUAclient.notify(nplayer,{lang.police.menu.check.checked()})
            AQUAclient.getWeapons(nplayer,{},function(weapons)
              -- prepare display data (money, items, weapons)
              local money = AQUA.getMoney(nuser_id)
              local items = ""
              local data = AQUA.getUserDataTable(nuser_id)
              if data and data.inventory then
                for k,v in pairs(data.inventory) do
                  local item = AQUA.items[k]
                  if item then
                    items = items.."<br />"..item.name.." ("..v.amount..")"
                  end
                end
              end
      
              local weapons_info = ""
              for k,v in pairs(weapons) do
                weapons_info = weapons_info.."<br />"..k.." ("..v.ammo..")"
              end
      
              AQUAclient.setDiv(player,{"police_check",".div_police_check{ background-color: rgba(0,0,0,0.75); color: white; font-weight: bold; width: 500px; padding: 10px; margin: auto; margin-top: 150px; }",lang.police.menu.check.info({money,items,weapons_info})})
              -- request to hide div
              AQUA.request(player, lang.police.menu.check.request_hide(), 1000, function(player,ok)
                AQUAclient.removeDiv(player,{"police_check"})
              end)
            end)
          else
            AQUAclient.notify(player,{lang.common.no_player_near()})
          end
        end)
      end
end)