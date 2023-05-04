local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp","lib/Tunnel")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_policeradial")

local Lang = module("vrp", "lib/Lang")
local cfg = module("vrp", "cfg/base")
local lang = Lang.new(module("vrp", "cfg/lang/"..cfg.lang) or {})

RegisterNetEvent('ERP:policeDrag')
AddEventHandler('ERP:policeDrag', function()
    
    local source = source
    Citizen.Wait(0)
    local user_id = vRP.getUserId({source})
    
    if user_id ~= nil and vRP.hasPermission({user_id, "police.menu"}) then
        
        vRPclient.getNearestPlayer(source,{2},function(nplayer)
            local nplayer = nplayer
            
            if nplayer ~= nil then
                local nuser_id = vRP.getUserId({nplayer})
            if nuser_id ~= nil then
                vRPclient.isHandcuffed(nplayer,{},function(handcuffed)
                if handcuffed then
                    TriggerClientEvent("ERP:drag2", nplayer, source)
                else
                    vRPclient.notify(source,{"Player is not handcuffed."})
                end
                end)
            else
                vRPclient.notify(source,{lang.common.no_player_near()})
                
            end
            else
            vRPclient.notify(source,{lang.common.no_player_near()})
            
            end
        end)
    end
end)

local crookanim = {

    {"mp_arrest_paired","crook_p2_back_left",1},
}

local policeanim = {

    {"mp_arrest_paired","cop_p2_back_left",1},
}
local policeuncuff = {

    {"mp_arresting", "a_uncuff", 1},

}
local crookuncuff = {

    {"mp_arresting", "b_uncuff", 1},

}
local playerHandcuffed = false

RegisterNetEvent("ERP:policeCuff")
AddEventHandler("ERP:policeCuff", function()
    local player = source
    local user_id = vRP.getUserId({source})
    handcuffed = nil
    if user_id ~= nil and vRP.hasPermission({user_id, "police.menu"}) then
        vRPclient.getNearestPlayer(player,{2},function(nplayer)
            nplayer = nplayer
            local nuser_id = vRP.getUserId({nplayer})

            vRPclient.isHandcuffed(nplayer,{},function(handcuffed)
                local nplayer = nplayer
                local nuser_id = vRP.getUserId({nplayer})
                local handcuffed = handcuffed
                print(handcuffed)

                
                if nuser_id ~= nil then
                    if handcuffed == false then
                        vRPclient.playAnim(nplayer,{true,crookanim,false})
                        vRPclient.playAnim(player,{true,policeanim,false})
                        vRPclient.toggleHandcuff(nplayer,{})
                        TriggerClientEvent("ERP:cuffAnimPolice", player, nplayer, player)
                        TriggerClientEvent("ERP:cuffAnimPerp", nplayer, nplayer, player)
                    elseif handcuffed == true then
                        vRPclient.playAnim(nplayer,{true,crookuncuff,false})
                        vRPclient.playAnim(player,{true,policeuncuff,false})
                        vRPclient.toggleHandcuff(nplayer,{})
                        TriggerClientEvent("ERP:cuffAnimPolice", player, nplayer, player)
                        TriggerClientEvent("ERP:cuffAnimPerp", nplayer, nplayer, player)
                    end
                else
                    vRPclient.notify(player,"No player near you")
                end

            end)
        end)
    end
    


end)

Tunnel.bindInterface("vrp_basic_menu",vRPbm)
BMclient = Tunnel.getInterface("vRP_basic_menu","vRP_basic_menu")
RegisterServerEvent('ERP:toggleTrafficMenu')
AddEventHandler('ERP:toggleTrafficMenu', function()
    local source = source
    local user_id = vRP.getUserId({source})
    if user_id ~= nil and vRP.hasPermission({user_id, "police.menu"}) then
        print("vRP Identification Accepted") 
        TriggerClientEvent("ERP:openTrafficMenu", source)
    end
end)

RegisterServerEvent('ERP:zoneActivated')
AddEventHandler('ERP:zoneActivated', function(message, speed, radius, x, y, z)
    TriggerClientEvent('chatMessage', -1, message)
    TriggerClientEvent('ERP:createZone', -1, speed, radius, x, y, z)
end)

RegisterServerEvent('ERP:disableZone')
AddEventHandler('ERP:disableZone', function(blip)
    TriggerClientEvent('ERP:removeBlip', -1)
end)


local unjailed = {}
function jail_clock(target_id,timer)
  local target = vRP.getUserSource({tonumber(target_id)})
  local users = vRP.getUsers({})
  local online = false
  for k,v in pairs(users) do
	if tonumber(k) == tonumber(target_id) then
	  online = true
	end
  end
  if online then
    if timer>0 then
	  vRPclient.notify(target, {"~r~Remaining time: " .. timer .. " minute(s)."})
      vRP.setUData({tonumber(target_id),"vRP:jail:time",json.encode(timer)})
	  SetTimeout(60*1000, function()
		for k,v in pairs(unjailed) do -- check if player has been unjailed by cop or admin
		  if v == tonumber(target_id) then
	        unjailed[v] = nil
		    timer = 0
		  end
		end
		vRP.setHunger({tonumber(target_id), 0})
		vRP.setThirst({tonumber(target_id), 0})
	    jail_clock(tonumber(target_id),timer-1)
	  end) 
    else 
	  BMclient.loadFreeze(target,{false,true,true})
	  SetTimeout(15000,function()
		BMclient.loadFreeze(target,{false,false,false})
	  end)
	  vRPclient.teleport(target,{1846.4332275391,2585.7666015625,45.671997070313}) -- teleport to outside jail
	  vRPclient.setHandcuffed(target,{false})
      vRPclient.notify(target,{"~b~You have been set free."})
	  vRP.setUData({tonumber(target_id),"vRP:jail:time",json.encode(-1)})
    end
  end
end

RegisterServerEvent('ERP:Jail')
AddEventHandler('ERP:Jail', function() 
    player = source
    local user_id = vRP.getUserId({player})
    if user_id ~= nil and vRP.hasPermission({user_id, "police.menu"}) then
    vRPclient.getNearestPlayers(player,{15},function(nplayers) 
      local user_list = ""
      for k,v in pairs(nplayers) do
        user_list = user_list .. "[" .. vRP.getUserId({k}) .. "]" .. GetPlayerName(k) .. " | "
      end 
      if user_list ~= "" then
        vRP.prompt({player,"Players Nearby:" .. user_list,"",function(player,target_id) 
          if target_id ~= nil and target_id ~= "" then 
            vRP.prompt({player,"Jail Time in minutes:","1",function(player,jail_time)
              if jail_time ~= nil and jail_time ~= "" then 
                local target = vRP.getUserSource({tonumber(target_id)})
                if target ~= nil then
                  if tonumber(jail_time) > 60 then
                      jail_time = 60
                  end
                  if tonumber(jail_time) < 1 then
                    jail_time = 1
                  end
            
                  vRPclient.isHandcuffed(target,{}, function(handcuffed)  
                    if handcuffed then 
                      BMclient.loadFreeze(target,{false,true,true})
                      SetTimeout(15000,function()
                        BMclient.loadFreeze(target,{false,false,false})
                      end)
                      vRPclient.teleport(target,{1779.7868652344,2583.9130859375,45.797805786133}) -- teleport to inside jail
                      vRPclient.notify(target,{"~r~You have been sent to jail."})
                      vRPclient.notify(player,{"~b~You sent a player to jail."})
                      jail_clock(tonumber(target_id),tonumber(jail_time))
                      local user_id = vRP.getUserId({player})
                      --vRPbm.logInfoToFile("jailLog.txt",user_id .. " jailed "..target_id.." for " .. jail_time .. " minutes")
                    else
                      vRPclient.notify(player,{"~r~That player is not handcuffed."})
                    end
                  end)
                else
                  vRPclient.notify(player,{"~r~That ID seems invalid."})
                end
              else
                vRPclient.notify(player,{"~r~The jail time can't be empty."})
              end
            end})
          else
            vRPclient.notify(player,{"~r~No player ID selected."})
          end 
        end})
      else
        vRPclient.notify(player,{"~r~No player nearby."})
      end 
    end)
    else
        print(user_id.." could be modding")
    end
  end)

RegisterServerEvent('ERP:Fine')
AddEventHandler('ERP:Fine', function() 
    player = source
    local user_id = vRP.getUserId({player})
    if user_id ~= nil and vRP.hasPermission({user_id, "police.menu"}) then
    vRPclient.getNearestPlayers(player,{15},function(nplayers) 
      local user_list = ""
      for k,v in pairs(nplayers) do
        user_list = user_list .. "[" .. vRP.getUserId({k}) .. "]" .. GetPlayerName(k) .. " | "
      end 
      if user_list ~= "" then
        vRP.prompt({player,"Players Nearby:" .. user_list,"",function(player,target_id) 
          if target_id ~= nil and target_id ~= "" then 
            vRP.prompt({player,"Fine amount:","100",function(player,fine)
              if fine ~= nil and fine ~= "" then 
                vRP.prompt({player,"Fine reason:","",function(player,reason)
                  if reason ~= nil and reason ~= "" then 
                    local target = vRP.getUserSource({tonumber(target_id)})
                    if target ~= nil then
                      if tonumber(fine) > 100000 then
                          fine = 100000
                      end
                      if tonumber(fine) < 100 then
                        fine = 100
                      end
                
                      if vRP.tryFullPayment({tonumber(target_id), tonumber(fine)}) then
                        vRP.insertPoliceRecord({tonumber(target_id), lang.police.menu.fine.record({reason,fine})})
                        vRPclient.notify(player,{lang.police.menu.fine.fined({reason,fine})})
                        vRPclient.notify(target,{lang.police.menu.fine.notify_fined({reason,fine})})
                        local user_id = vRP.getUserId({player})
                        --vRPbm.logInfoToFile("fineLog.txt",user_id .. " fined "..target_id.." the amount of " .. fine .. " for ".. reason)
                        vRP.closeMenu({player})
                      else
                        vRPclient.notify(player,{lang.money.not_enough()})
                      end
                    else
                      vRPclient.notify(player,{"~r~That ID seems invalid."})
                    end
                  else
                    vRPclient.notify(player,{"~r~You can't fine for no reason."})
                  end
                end})
              else
                vRPclient.notify(player,{"~r~Your fine has to have a value."})
              end
            end})
          else
            vRPclient.notify(player,{"~r~No player ID selected."})
          end 
        end})
      else
        vRPclient.notify(player,{"~r~No player nearby."})
      end 
    end)
  else
    print(user_id.." Could be modder")
  end
end)

RegisterNetEvent("ERP:Unjail")
AddEventHandler("ERP:Unjail", function()
    player = source
    local user_id = vRP.getUserId({player})
    if user_id ~= nil and vRP.hasPermission({user_id, "police.menu"}) then
	vRP.prompt({player,"Player ID:","",function(player,target_id) 
	  if target_id ~= nil and target_id ~= "" then 
		vRP.getUData({tonumber(target_id),"vRP:jail:time",function(value)
		  if value ~= nil then
		  custom = json.decode(value)
			if custom ~= nil then
			  local user_id = vRP.getUserId({player})
			  if tonumber(custom) > 0 or vRP.hasPermission({user_id,"admin.easy_unjail"}) then
	            local target = vRP.getUserSource({tonumber(target_id)})
				if target ~= nil then
	              unjailed[target] = tonumber(target_id)
				  vRPclient.notify(player,{"~g~Target will be released soon."})
				  vRPclient.notify(target,{"~g~Someone lowered your sentence."})
				  vRPbm.logInfoToFile("jailLog.txt",user_id .. " freed "..target_id.." from a " .. custom .. " minutes sentence")
				else
				  vRPclient.notify(player,{"~r~That ID seems invalid."})
				end
			  else
				vRPclient.notify(player,{"~r~Target is not jailed."})
			  end
			end
		  end
		end})
      else
        vRPclient.notify(player,{"~r~No player ID selected."})
      end 
  end})
  else
    print(user_id.." Could be modder")
  end
end)

RegisterNetEvent("ERP:putinveh")
AddEventHandler("ERP:putinveh", function()
    player = source
    local user_id = vRP.getUserId({player})
    if user_id ~= nil and vRP.hasPermission({user_id, "police.menu"}) then
    vRPclient.getNearestPlayer(player,{10},function(nplayer)
      local nuser_id = vRP.getUserId({nplayer})
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

RegisterNetEvent("ERP:takeoutveh")
AddEventHandler("ERP:takeoutveh", function()
    player = source
    local user_id = vRP.getUserId({player})
    if user_id ~= nil and vRP.hasPermission({user_id, "police.menu"}) then
  vRPclient.getNearestPlayer(player,{10},function(nplayer)
    local nuser_id = vRP.getUserId({nplayer})
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

RegisterServerEvent('ERP:Drag')
AddEventHandler('ERP:Drag', function() 
      -- get nearest player
      local user_id = vRP.getUserId({player})
      if user_id ~= nil then
        vRPclient.getNearestPlayer(player,{10},function(nplayer)
          if nplayer ~= nil then
            local nuser_id = vRP.getUserId({nplayer})
            if nuser_id ~= nil then
          vRPclient.isHandcuffed(nplayer,{},function(handcuffed)
          if handcuffed then
            TriggerClientEvent("dr:drag", nplayer, player)
          else
            vRPclient.notify(player,{"Player is not handcuffed."})
          end
          end)
            else
              vRPclient.notify(player,{"no one near"})
            end
          else
            vRPclient.notify(player,{"Player is not handcuffed."})
          end
        end)
      end
end)

RegisterServerEvent('ERP:SeizeWeapons')
AddEventHandler('ERP:SeizeWeapons', function() 
  local player = source
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    vRPclient.getNearestPlayer(player, {5}, function(nplayer)
      local nuser_id = vRP.getUserId({nplayer})
      if nuser_id ~= nil and vRP.hasPermission(nuser_id, "police.seizable") then
        vRPclient.isHandcuffed(nplayer,{}, function(handcuffed)  -- check handcuffed
          if handcuffed then
            vRPclient.getWeapons(nplayer,{},function(weapons)
              for k,v in pairs(weapons) do
                vRP.giveInventoryItem(user_id, "wbody|"..k, 1, true)
                if v.ammo > 0 then
                  vRP.giveInventoryItem(user_id, "wammo|"..k, v.ammo, true)
                end
              end

              -- clear all weapons
              vRPclient.notify(player,{"Seized Weapons"})
              vRPclient.giveWeapons(nplayer,{{},true})
              vRPclient.removeWeapon(nplayer,{{},true})
              vRPclient.notify(nplayer,{"Seized these weapons:"})
            end)
          else
            vRPclient.notify(player,{"Player is not handcuffed."})
          end
        end)
      else
        vRPclient.notify(player,{"Player is not handcuffed"})
      end
    end)
  end
end)

--[[
RegisterServerEvent('ERP:SeizeItems')
AddEventHandler('ERP:SeizeItems', function()
  local player = source 
  local user_id = vRP.getUserId({player})
  if user_id ~= nil then
    vRPclient.getNearestPlayer(player, {5}, function(nplayer)
      local nuser_id = vRP.getUserId({nplayer})
      if nuser_id ~= nil and vRP.hasPermission(nuser_id, "police.seizable") then
        vRPclient.isHandcuffed(nplayer,{}, function(handcuffed)  -- check handcuffed
          if handcuffed then
            for k,v in pairs(cfg.seizable_items) do -- transfer seizable items
              local amount = vRP.getInventoryItemAmount(nuser_id,v)
              if amount > 0 then
                local item = vRP.items[v]
                if item then -- do transfer
                  if vRP.clearInventory({nuser_id})  then
                    vRP.clearInventory(nuser_id}) 
                    vRPclient.notify(player,{lang.police.menu.seize.seized({item.name,amount})})
                  end
                end
              end
            end

            vRPclient.notify(nplayer,{lang.police.menu.seize.items.seized()})
          else
            vRPclient.notify(player,{"Player is not handcuffed."})
          end
        end)
      else
        vRPclient.notify(player,{"Player is not handcuffed."})
      end
    end)
  end
end)]]

RegisterServerEvent('ERP:TrafficMenuLogs')
AddEventHandler('ERP:TrafficMenuLogs', function(objspawned) 
  local player = source
  local admin_id = vRP.getUserId({player})
  local admin_name = GetPlayerName(player)
  local logs = "https://discord.com/api/webhooks/1006360856797388830/TnEM1Ft3IOApIUCqljjr61vdLNIhqx_QZV3zRNFIG72tbmDTMJNIVBLBqT3n_EQk-KIo"
  local communityname = "ERP RP Staff Logs"
  local communtiylogo = "" --Must end with .png or .jpg
        
  local command = {
    {
      ["color"] = "8663711",
      ["title"] = "Police Menu (Spawn Object)",
      ["description"] = "** Admin Name: **" ..admin_name.. "** Admin ID:  **" ..admin_id.. "** Spawned Objects : **" ..objspawned.. "",
      ["footer"] = {
      ["text"] = communityname,
      ["icon_url"] = communtiylogo,
      },
    }
  }
  PerformHttpRequest(logs, function(err, text, headers) end, 'POST', json.encode({username = "ERP RP Staff Logs", embeds = command}), { ['Content-Type'] = 'application/json' })
end)