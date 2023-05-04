local lang = vRP.lang
local cfg = module("cfg/police")

RegisterServerEvent('GMT:OpenPoliceMenu')
AddEventHandler('GMT:OpenPoliceMenu', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id ~= nil and vRP.hasPermission(user_id, "police.armoury") then
        TriggerClientEvent("GMT:PoliceMenuOpened", source)
    elseif user_id ~= nil and vRP.hasPermission(user_id, "clockon.menu") then
      vRPclient.notify(source,{"You are not on duty"})
    end
end)

RegisterServerEvent('GMT:ActivateZone')
AddEventHandler('GMT:ActivateZone', function(message, speed, radius, x, y, z)
    TriggerClientEvent('chatMessage', -1, "" , { 128, 128, 128 }, message, "alert")
    TriggerClientEvent('GMT:ZoneCreated', -1, speed, radius, x, y, z)
end)

RegisterServerEvent('GMT:RemoveZone')
AddEventHandler('GMT:RemoveZone', function(blip)
    TriggerClientEvent('GMT:RemovedBlip', -1)
end)

RegisterServerEvent('GMT:Drag')
AddEventHandler('GMT:Drag', function()
    player = source
    local user_id = vRP.getUserId(player)
    if user_id ~= nil and vRP.hasPermission(user_id, "police.armoury") then
        vRPclient.getNearestPlayer(player,{10},function(nplayer)
        if nplayer ~= nil then
            local nuser_id = vRP.getUserId(nplayer)
            if nuser_id ~= nil then
            vRPclient.isHandcuffed(nplayer,{},function(handcuffed)
                if handcuffed then
                    TriggerClientEvent("GMT:DragPlayer", nplayer, player)
                else
                    vRPclient.notify(player,{"~r~Player is not handcuffed."})
                end
            end)
            else
                vRPclient.notify(player,{"~r~There is no player nearby"})
            end
            else
                vRPclient.notify(player,{"~r~There is no player nearby"})
            end
        end)
    end
end)

local cuff = false

RegisterServerEvent('GMT:Handcuff')
AddEventHandler('GMT:Handcuff', function()
    player = source
    local user_id = vRP.getUserId(player)
    if user_id ~= nil and vRP.hasPermission(user_id, "pd.armory") then
      vRPclient.getNearestPlayer(player,{20},function(nplayer)
          local nuser_id = vRP.getUserId(nplayer)
          if nuser_id ~= nil then
         
            vRPclient.isHandcuffed(nplayer,{}, function(handcuffed)  -- check handcuffed
              if not handcuffed then
                  vRPclient.setHandcuffed(nplayer, {true})
              else
                  vRPclient.setHandcuffed(nplayer, {false})
              end
            end)

           
           
            vRP.closeMenu(nplayer)
          else
            vRPclient.notify(player,{"~r~There is no player nearby"})
          end
      end)
    end
end)

local unjailed = {}
function jail_clock(target_id,timer)
  local target = vRP.getUserSource(tonumber(target_id))
  local users = vRP.getUsers()
  local online = false
  for k,v in pairs(users) do
	if tonumber(k) == tonumber(target_id) then
	  online = true
	end
  end
  if online then
    if timer>0 then
	  vRPclient.notify(target, {"~r~Remaining time: " .. timer .. " minute(s)."})
      vRP.setUData(tonumber(target_id),"vRP:jail:time",json.encode(timer))
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
	  vRPclient.teleport(target,{1854.2919921875,2586.1066894531,45.672054290771}) -- teleport to outside jail
	  vRPclient.setHandcuffed(target,{false})
      vRPclient.notify(target,{"~b~You have been set free."})
      
	  vRP.setUData({tonumber(target_id),"vRP:jail:time",json.encode(-1)})
    end
  end
end

RegisterServerEvent('GMT:SeizeWeapons2')
AddEventHandler('GMT:SeizeWeapons2', function()
  local source = source
    player = source
    local user_id = vRP.getUserId(player)
    if user_id ~= nil and vRP.hasPermission(user_id, "police.menu") then
            vRPclient.getNearestPlayer(player,{10},function(nplayer)
              vRPclient.isHandcuffed(nplayer,{}, function(handcuffed)  -- check handcuffed
                if handcuffed then 
            if nplayer ~= nil then
                local nuser_id = vRP.getUserId(nplayer)
                if nuser_id ~= nil then
                  RemoveAllPedWeapons(nplayer, true)
                  vRP.clearInventory(nuser_id) 
                  vRPclient.notify(player, {'~g~Seized players weapons'})
                  vRPclient.notify(nplayer, {'~r~Your weapons were seized'})
                else
                    vRPclient.notify(player,{"~r~There is no player nearby"})
                end
                else
                    vRPclient.notify(player,{"~r~There is no player nearby"})
                end
              else
                vRPclient.notify(player, {'~r~Player has to be cuffed.'})
              end
            end)
            end)
    end
end)

RegisterServerEvent('GMT:JailPlayer')
AddEventHandler('GMT:JailPlayer', function()
    player = source
    local user_id = vRP.getUserId(player)
    if user_id ~= nil and vRP.hasPermission(user_id, "police.armoury") then
    vRPclient.getNearestPlayers(player,{15},function(nplayers) 
      local user_list = ""
      for k,v in pairs(nplayers) do
        user_list = user_list .. "[" .. vRP.getUserId(k) .. "]" .. GetPlayerName(k) .. " | "
      end 
        vRP.prompt(player,"Players Nearby:" .. user_list,"",function(player,target_id) 
          if target_id ~= nil and target_id ~= "" then 
            if not target_id and nplayers then return end
            vRP.prompt(player,"Jail Time in minutes:","1",function(player,jail_time)
              if jail_time ~= nil and jail_time ~= "" then 
                local target = vRP.getUserSource(tonumber(target_id))
                if target ~= nil then
                  if tonumber(jail_time) > 60 then
                      jail_time = 60
                  end
                  if tonumber(jail_time) < 1 then
                    jail_time = 1
                  end
            
                  vRPclient.isHandcuffed(target,{}, function(handcuffed)  
                        vRPclient.loadFreeze(target,{false,true,true})
                      SetTimeout(15000,function()
                        vRPclient.loadFreeze(target,{false,false,false})
                      end)
                      vRPclient.teleport(target,{1779.8850097656,2584.3186035156,45.797779083252}) -- teleport to inside jail
                      vRPclient.notify(target,{"~r~You have been sent to jail."})
                      vRPclient.notify(player,{"~b~You sent a player to jail."})
                      vRPclient.setHandcuffed(target, {false})
                      jail_clock(tonumber(target_id),tonumber(jail_time))
                      TriggerClientEvent("returnTrue", target)
                      TriggerClientEvent("stopjail", target)
                      local user_id = vRP.getUserId(player)
                      local jaillogs = {
                        {
                            ["color"] = "16777215",
                            ["description"] = "**ID:** " .. user_id .. " **jailed **" .. target_id .. "** for **" .. jail_time .. " **minutes**",
                            ["footer"] = {
                              ["text"] = "GMT - "..os.date("%X"),
                              ["icon_url"] = "https://cdn.discordapp.com/attachments/994763707487887500/995420091338465280/unknown.png",
                            }
                        }
                    }
                    PerformHttpRequest("https://discord.com/api/webhooks/1006119777263161375/eSD04QoRRatBZxl143_y94tRp7Nw0cnpXqABcQ7JGT29wumLI6YLpp4KKkj2cQUJ0dw1", function(err, text, headers) 
                    end, "POST", json.encode({username = "Jail Logs", embeds = jaillogs}), { ["Content-Type"] = "application/json" })
                  end)
                else
                  vRPclient.notify(player,{"~r~That ID seems invalid."})
                end
              else
                vRPclient.notify(player,{"~r~The jail time can't be empty."})
              end
            end)
          else
            vRPclient.notify(player,{"~r~No player ID selected."})
          end 
        end)
    end)
    else
        print(user_id.." could be modding")
    end
end)

RegisterServerEvent('GMT:UnJailPlayer')
AddEventHandler('GMT:UnJailPlayer', function()
    player = source
    local user_id = vRP.getUserId(player)
    if user_id ~= nil and vRP.hasPermission(user_id, "admin.noclip") then
	  vRP.prompt(player,"Player ID:","",function(player,target_id) 
	  if target_id ~= nil and target_id ~= "" then 
      vRP.getUData(tonumber(target_id),"vRP:jail:time",function(value)
        if value ~= nil then
        custom = json.decode(value)
        if custom ~= nil then
          local user_id = vRP.getUserId(player)
          if tonumber(custom) > 0 or vRP.hasPermission(user_id,"admin.noclip") then
                local target = vRP.getUserSource(tonumber(target_id))
          if target ~= nil then
            unjailed[target] = tonumber(target_id)
            vRP.setUData(tonumber(target_id),"vRP:jail:time",json.encode(-1))
            vRPclient.notify(player,{"~g~Target will be released soon."})
            vRPclient.notify(target,{"~g~Someone lowered your sentence."})
            local unjaillogs = {
              {
                  ["color"] = "16777215",
                  ["description"] = "**ID:** " .. user_id .. " **unjailed** " .. target_id,
                  ["footer"] = {
                    ["text"] = "GMT - "..os.date("%X"),
                    ["icon_url"] = "https://cdn.discordapp.com/attachments/994763707487887500/995420091338465280/unknown.png",
                  }
              }
          }
          PerformHttpRequest("", function(err, text, headers) 
          end, "POST", json.encode({username = "Unjail Logs", embeds = unjaillogs}), { ["Content-Type"] = "application/json" })
          else
            vRPclient.notify(player,{"~r~That ID seems invalid."})
          end
          else
          vRPclient.notify(player,{"~r~Target is not jailed."})
          end
        end
		  end
		end)
      else
        vRPclient.notify(player,{"~r~No player ID selected."})
      end 
  end)
  else
    print(user_id.." Could be modder")
  end
end)

RegisterServerEvent('GMT:sendFine')
AddEventHandler('GMT:sendFine', function()
    player = source
    local user_id = vRP.getUserId(player)
    if user_id ~= nil and vRP.hasPermission(user_id, "police.group") then
      vRPclient.getNearestPlayers(player,{15},function(nplayers) 
      local user_list = ""
      for k,v in pairs(nplayers) do
        user_list = user_list .. "[" .. vRP.getUserId(k) .. "]" .. GetPlayerName(k) .. " | "
      end 
      if user_list ~= "" then
        vRP.prompt(player,"Players Nearby:" .. user_list,"",function(player,target_id) 
          if target_id ~= nil and target_id ~= "" then 
            vRP.prompt(player,"Fine amount:","100",function(player,fine)
              if fine ~= nil and fine ~= "" then 
                vRP.prompt(player,"Fine reason:","",function(player,reason)
                  if reason ~= nil and reason ~= "" then 
                    local target = vRP.getUserSource(tonumber(target_id))
                    if target ~= nil then
                      if tonumber(fine) > 100000 then
                          fine = 100000
                      end
                      if tonumber(fine) < 100 then
                        fine = 100
                      end
                
                      if vRP.tryFullPayment(tonumber(target_id), tonumber(fine)) then
                        vRP.insertPoliceRecord(tonumber(target_id), lang.police.menu.fine.record({reason,fine}))
                        vRPclient.notify(player,{lang.police.menu.fine.fined({reason,fine})})
                        vRPclient.notify(target,{lang.police.menu.fine.notify_fined({reason,fine})})
                        local user_id = vRP.getUserId(player)
                        vRP.closeMenu(player)
                      else
                        vRPclient.notify(player,{lang.money.not_enough()})
                      end
                    else
                      vRPclient.notify(player,{"~r~That ID seems invalid."})
                    end
                  else
                    vRPclient.notify(player,{"~r~You can't fine for no reason."})
                  end
                end)
              else
                vRPclient.notify(player,{"~r~Your fine has to have a value."})
              end
            end)
          else
            vRPclient.notify(player,{"~r~No player ID selected."})
          end 
        end)
      else
        vRPclient.notify(player,{"~r~No player nearby."})
      end 
    end)
  else
    print(user_id.." Could be modder")
  end
end)
RegisterNetEvent("GMT:PutPlrInVeh")
AddEventHandler("GMT:PutPlrInVeh", function()
    player = source
    local user_id = vRP.getUserId(player)
    if user_id ~= nil and vRP.hasPermission(user_id, "police.armoury") then
    vRPclient.getNearestPlayer(player,{10},function(nplayer)
      local nuser_id = vRP.getUserId(nplayer)
      if nuser_id ~= nil then
        vRPclient.isHandcuffed(nplayer,{}, function(handcuffed)  -- check handcuffed
          if handcuffed then
            vRPclient.putInNearestVehicleAsPassenger(nplayer, {5})
          else
            vRPclient.notify(player,{"~r~Player is not not cuffed."})
          end
        end)
      else
        vRPclient.notify(player,{"~r~No player nearby."})
      end
    end)
  else
    print(user_id.." Could be modder")
  end
end)

RegisterNetEvent("GMT:TakeOutOfVehicle")
AddEventHandler("GMT:TakeOutOfVehicle", function()
    player = source
    local user_id = vRP.getUserId(player)
    if user_id ~= nil and vRP.hasPermission(user_id, "police.armoury") then
    vRPclient.getNearestPlayer(player,{10},function(nplayer)
        local nuser_id = vRP.getUserId(nplayer)
        if nuser_id ~= nil then
        vRPclient.isHandcuffed(nplayer,{}, function(handcuffed)  -- check handcuffed
            if handcuffed then
            vRPclient.ejectVehicle(nplayer, {})
            else
              vRPclient.notify(player,{"~r~Player is not not cuffed."})
            end
        end)
        else
          vRPclient.notify(player,{"~r~No player nearby."})
        end
    end)
    else
        print(user_id.." Could be modder")
    end
end)

RegisterNetEvent("GMT:SearchPlayer")
AddEventHandler("GMT:SearchPlayer", function()
    player = source
    if user_id ~= nil and vRP.hasPermission(user_id, "police.armoury") then
      vRPclient.getNearestPlayer(player,{5},function(nplayer)
          local nuser_id = vRP.getUserId(nplayer)
          if nuser_id ~= nil then
            vRPclient.notify(nplayer,{lang.police.menu.check.checked()})
            vRPclient.getWeapons(nplayer,{},function(weapons)
              -- prepare display data (money, items, weapons)
              local money = vRP.getMoney(nuser_id)
              local items = ""
              local data = vRP.getUserDataTable(nuser_id)
              if data and data.inventory then
                for k,v in pairs(data.inventory) do
                  local item = vRP.items[k]
                  if item then
                    items = items.."<br />"..item.name.." ("..v.amount..")"
                  end
                end
              end
      
              local weapons_info = ""
              for k,v in pairs(weapons) do
                weapons_info = weapons_info.."<br />"..k.." ("..v.ammo..")"
              end
      
              vRPclient.setDiv(player,{"police_check",".div_police_check{ background-color: rgba(0,0,0,0.75); color: white; font-weight: bold; width: 500px; padding: 10px; margin: auto; margin-top: 150px; }",lang.police.menu.check.info({money,items,weapons_info})})
              -- request to hide div
              vRP.request(player, lang.police.menu.check.request_hide(), 1000, function(player,ok)
                vRPclient.removeDiv(player,{"police_check"})
              end)
            end)
          else
            vRPclient.notify(player,{lang.common.no_player_near()})
          end
        end)
      end
end)