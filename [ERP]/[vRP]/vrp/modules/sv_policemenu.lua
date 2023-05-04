local lang = vRP.lang
local cfg = module("cfg/police")
local crookanim = {{"mp_arrest_paired","crook_p2_back_left",1}}
local policeanim = {{"mp_arrest_paired","cop_p2_back_left",1}}
local policeuncuff = {{"mp_arresting", "a_uncuff", 1}}
local crookuncuff = {{"mp_arresting", "b_uncuff", 1}}

RegisterServerEvent('Element:OpenPoliceMenu')
AddEventHandler('Element:OpenPoliceMenu', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id ~= nil and vRP.hasPermission(user_id, "police.menu") then
        TriggerClientEvent("Element:PoliceMenuOpened", source)
    elseif user_id ~= nil and vRP.hasPermission(user_id, "clockon.menu") then
      vRPclient.notify(source,{"You are not on duty"})
    else
      print("You are not a part of the MET Police")
    end
end)

RegisterServerEvent('Element:ActivateZone')
AddEventHandler('Element:ActivateZone', function(message, speed, radius, x, y, z)
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(171, 7, 7, 0.6); border-radius: 7px;"><i class="fas fa-exclamation-triangle"></i> MET Police: {0}</div>',
        args = { message }
    })
    TriggerClientEvent('Element:ZoneCreated', -1, speed, radius, x, y, z)
end)

RegisterServerEvent('Element:RemoveZone')
AddEventHandler('Element:RemoveZone', function(blip)
    TriggerClientEvent('Element:RemovedBlip', -1)
end)

RegisterServerEvent('Element:Drag')
AddEventHandler('Element:Drag', function()
    player = source
    local user_id = vRP.getUserId(player)
    if user_id ~= nil and vRP.hasPermission(user_id, "police.menu") then
        vRPclient.getNearestPlayer(player,{10},function(nplayer)
        if nplayer ~= nil then
            local nuser_id = vRP.getUserId(nplayer)
            if nuser_id ~= nil then
            vRPclient.isHandcuffed(nplayer,{},function(handcuffed)
                if handcuffed then
                    TriggerClientEvent("Element:DragPlayer", nplayer, player)
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

RegisterServerEvent('Element:Handcuff')
AddEventHandler('Element:Handcuff', function()
    player = source
    if user_id ~= nil and vRP.hasPermission(user_id, "police.menu") then
      vRPclient.getNearestPlayer(player,{10},function(nplayer)
          local nuser_id = vRP.getUserId(nplayer)
          if nuser_id ~= nil then
            vRPclient.toggleHandcuff(nplayer,{})
            local user_id = vRP.getUserId(player)
            vRP.closeMenu(nplayer)
          else
            vRPclient.notify(player,{"~r~There is no player nearby"})
          end
      end)
    end
end)

RegisterServerEvent('ERP:Handcuff')
AddEventHandler('ERP:Handcuff', function()
    local player = source
    local user_id = vRP.getUserId(source)
    handcuffed = nil
    if user_id ~= nil and vRP.hasPermission(user_id, "police.menu") then
        vRPclient.getNearestPlayer(player,{2},function(nplayer)
            nplayer = nplayer
            local nuser_id = vRP.getUserId(nplayer)
            vRPclient.isHandcuffed(nplayer,{},function(handcuffed)
                local nplayer = nplayer
                local nuser_id = vRP.getUserId(nplayer)
                local handcuffed = handcuffed
                if nuser_id ~= nil then
                    if handcuffed == false then
                        vRPclient.playAnim(nplayer,{true,crookanim,false})
                        vRPclient.playAnim(player,{true,policeanim,false})
                        vRPclient.toggleHandcuff(nplayer,{})
                  elseif handcuffed == true then
                        vRPclient.playAnim(nplayer,{true,crookuncuff,false})
                        vRPclient.playAnim(player,{true,policeuncuff,false})
                        vRPclient.toggleHandcuff(nplayer,{})
                    end
                    TriggerClientEvent("vrp:PlaySound", player, "handcuff")
                    TriggerClientEvent("vrp:PlaySound", nplayer, "handcuff")
                else
                    vRPclient.notify(player,"No player near you")
                end

            end)
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
	 -- BMclient.loadFreeze(target,{false,true,true})
	 -- SetTimeout(15000,function()
	-- BMclient.loadFreeze(target,{false,false,false})
	 -- end)
    TriggerClientEvent("returnFalse", target)
	  vRPclient.teleport(target,{425.7607421875,-978.73425292969,30.709615707397}) -- teleport to outside jail
	  vRPclient.setHandcuffed(target,{false})
      vRPclient.notify(target,{"~b~You have been set free."})
      
	  vRP.setUData({tonumber(target_id),"vRP:jail:time",json.encode(-1)})
    end
  end
end

RegisterServerEvent('Element:JailPlayer')
AddEventHandler('Element:JailPlayer', function()
    player = source
    local user_id = vRP.getUserId(player)
    if user_id ~= nil and vRP.hasPermission(user_id, "police.menu") then
    vRPclient.getNearestPlayers(player,{15},function(nplayers) 
      local user_list = ""
      for k,v in pairs(nplayers) do
        user_list = user_list .. "[" .. vRP.getUserId(k) .. "]" .. GetPlayerName(k) .. " | "
      end 
     -- if user_list ~= "" then
        vRP.prompt(player,"Players Nearby:" .. user_list,"",function(player,target_id) 
          if target_id ~= nil and target_id ~= "" then 
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
                  --  if handcuffed then 
                        vRPclient.loadFreeze(target,{false,true,true})
                      SetTimeout(15000,function()
                        vRPclient.loadFreeze(target,{false,false,false})
                      end)
                      RemoveAllPedWeapons(target,true)
                      vRPclient.teleport(target,{1779.7868652344,2583.9130859375,45.79776763916}) -- teleport to inside jail
                      vRPclient.notify(target,{"~r~You have been sent to jail."})
                      vRPclient.notify(player,{"~b~You sent a player to jail."})
                      jail_clock(tonumber(target_id),tonumber(jail_time))
                      TriggerClientEvent("returnTrue", target)
                      TriggerClientEvent("stopjail", target)
                      local user_id = vRP.getUserId(player)
                --    else
                    --  vRPclient.notify(player,{"~r~That player is not handcuffed."})
                  --  end
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
     -- else
       -- vRPclient.notify(player,{"~r~No player nearby."})
     -- end 
    end)
    else
        print(user_id.." could be modding")
    end
end)

RegisterServerEvent('Element:UnJailPlayer')
AddEventHandler('Element:UnJailPlayer', function()
    player = source
    local user_id = vRP.getUserId(player)
    if user_id ~= nil and vRP.hasPermission(user_id, "police.menu") then
	vRP.prompt(player,"Player ID:","",function(player,target_id) 
	  if target_id ~= nil and target_id ~= "" then 
		vRP.getUData(tonumber(target_id),"vRP:jail:time",function(value)
		  if value ~= nil then
		  custom = json.decode(value)
			if custom ~= nil then
			  local user_id = vRP.getUserId(player)
			  if tonumber(custom) > 0 or vRP.hasPermission(user_id,"admin.easy_unjail") then
	            local target = vRP.getUserSource(tonumber(target_id))
				if target ~= nil then
	              unjailed[target] = tonumber(target_id)
				  vRPclient.notify(player,{"~g~Target will be released soon."})
				  vRPclient.notify(target,{"~g~Someone lowered your sentence."})
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

RegisterServerEvent('Element:Fine')
AddEventHandler('Element:Fine', function()
    player = source
    local user_id = vRP.getUserId(player)
    if user_id ~= nil and vRP.hasPermission(user_id, "police.menu") then
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

RegisterNetEvent("Element:PutPlrInVeh")
AddEventHandler("Element:PutPlrInVeh", function()
    player = source
    local user_id = vRP.getUserId(player)
    if user_id ~= nil and vRP.hasPermission(user_id, "police.menu") then
    vRPclient.getNearestPlayer(player,{10},function(nplayer)
      local nuser_id = vRP.getUserId(nplayer)
      if nuser_id ~= nil then
        vRPclient.isHandcuffed(nplayer,{}, function(handcuffed)  -- check handcuffed
          if handcuffed then
            vRPclient.putInNearestVehicleAsPassenger(nplayer, {5})
          else
            vRPclient.notify(player,{"person not cuffed"})
          end
        end)
      else
        vRPclient.notify(player,{"no one near"})
      end
    end)
  else
    print(user_id.." Could be modder")
  end
end)

RegisterNetEvent("Element:TakeOutOfVehicle")
AddEventHandler("Element:TakeOutOfVehicle", function()
    player = source
    local user_id = vRP.getUserId(player)
    if user_id ~= nil and vRP.hasPermission(user_id, "police.menu") then
    vRPclient.getNearestPlayer(player,{10},function(nplayer)
        local nuser_id = vRP.getUserId(nplayer)
        if nuser_id ~= nil then
        vRPclient.isHandcuffed(nplayer,{}, function(handcuffed)  -- check handcuffed
            if handcuffed then
            vRPclient.ejectVehicle(nplayer, {})
            else
            vRPclient.notify(player,{"person not cuffed"})
            end
        end)
        else
        vRPclient.notify(player,{"no one near"})
        end
    end)
    else
        print(user_id.." Could be modder")
    end
end)

RegisterNetEvent("Element:SearchPlayer")
AddEventHandler("Element:SearchPlayer", function()
    player = source
    if user_id ~= nil and vRP.hasPermission(user_id, "police.menu") then
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