local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp","lib/Tunnel")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_policeradial")

local Lang = module("vrp", "lib/Lang")
local cfg = module("vrp", "cfg/base")
local lang = Lang.new(module("vrp", "cfg/lang/"..cfg.lang) or {})

RegisterNetEvent('FNR:policeDrag')
AddEventHandler('FNR:policeDrag', function()
    
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
                    TriggerClientEvent("FNR:drag2", nplayer, source)
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

 RegisterNetEvent("FNR:policeCuff")
 AddEventHandler("FNR:policeCuff", function()
     local player = source
     local user_id = vRP.getUserId({source})
     handcuffed = nil
     if user_id ~= nil and vRP.hasPermission({user_id, "pd.armory"}) then
         vRPclient.getNearestPlayer(player,{2},function(nplayer)
             nplayer = nplayer
             local nuser_id = vRP.getUserId({nplayer})
             vRPclient.isHandcuffed(nplayer,{},function(handcuffed)
                 local nplayer = nplayer
                 local nuser_id = vRP.getUserId({nplayer})
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
                     TriggerClientEvent("vrp:PlaySound", source, "handcuff")
                 else
                     vRPclient.notify(player,"No player near you")
                 end

             end)
         end)
     end

TriggerClientEvent('chat:addSuggestion', '/uncuffme', 'Uncuff yourself.')
RegisterCommand("uncuffme", function(source, args, rawCommand)
  local user_id = vRP.getUserId({source})
  vRPclient.isHandcuffed(source,{},function(handcuffed)
    if handcuffed == true then
      if vRP.hasPermission({user_id, 'admin.noclip'}) then
        vRPclient.toggleHandcuff(source,{})
      end
    end
  end)
end)


 end)

RegisterNetEvent('FNR:policeCuffStaff')
AddEventHandler('FNR:policeCuffStaff', function(staffmode)
  local player = source
  local user_id = vRP.getUserId({source})
  handcuffed = nil
  if vRP.hasPermission({user_id, 'admin.tickets'}) then
    if vRP.hasPermission({user_id, "pd.armory"}) then return end
    if user_id ~= nil and staffmode == true then
        vRPclient.getNearestPlayer(player,{2},function(nplayer)
            nplayer = nplayer
            local nuser_id = vRP.getUserId({nplayer})
            vRPclient.isHandcuffed(nplayer,{},function(handcuffed)
                local nplayer = nplayer
                local nuser_id = vRP.getUserId({nplayer})
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
                    TriggerClientEvent("vrp:PlaySound", source, "handcuff")
                else
                    vRPclient.notify(player,"No player near you")
                end

            end)
        end)
      end
    end
end)


Tunnel.bindInterface("vrp_basic_menu",vRPbm)
BMclient = Tunnel.getInterface("vRP_basic_menu","vRP_basic_menu")
RegisterServerEvent('FNR:toggleTrafficMenu')
AddEventHandler('FNR:toggleTrafficMenu', function()
    local source = source
    local user_id = vRP.getUserId({source})
    if user_id ~= nil and vRP.hasPermission({user_id, "police.menu"}) then
        print("vRP Identification Accepted") 
        TriggerClientEvent("FNR:openTrafficMenu", source)
    end
end)

RegisterServerEvent('FNR:zoneActivated')
AddEventHandler('FNR:zoneActivated', function(message, speed, radius, x, y, z)
    TriggerClientEvent('chatMessage', -1, message)
    TriggerClientEvent('FNR:createZone', -1, speed, radius, x, y, z)
end)

RegisterServerEvent('FNR:disableZone')
AddEventHandler('FNR:disableZone', function(blip)
    TriggerClientEvent('FNR:removeBlip', -1)
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

RegisterServerEvent('FNR:Fine')
AddEventHandler('FNR:Fine', function() 
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
                      if tonumber(fine) > 250000 then
                          fine = 250000
                      end
                      if tonumber(fine) < 1 then
                        fine = 1
                      end
                
                      if vRP.tryFullPayment({tonumber(target_id), tonumber(fine)}) then
                        vRP.insertPoliceRecord({tonumber(target_id), lang.police.menu.fine.record({reason,fine})})
                        --vRPclient.notify(player,{lang.police.menu.fine.fined({reason,fine})})
                        vRPclient.notify(target,{lang.police.menu.fine.notify_fined({reason,fine})})
                        vRP.giveBankMoney({player, tonumber(fine)/10})
                        vRPclient.notify(player,{'~g~You have received £'.. tonumber(fine)/10 ..' as you '..lang.police.menu.fine.fined({reason,fine})})
                        local user_id = vRP.getUserId({player})
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


RegisterServerEvent('FNR:Drag')
AddEventHandler('FNR:Drag', function() 
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

RegisterServerEvent('FNR:TrafficMenuLogs')
AddEventHandler('FNR:TrafficMenuLogs', function(objspawned) 
  local player = source
  local admin_id = vRP.getUserId({player})
  local admin_name = GetPlayerName(player)
  local logs = ""
  local communityname = "FNR Staff Logs"
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
  PerformHttpRequest(logs, function(err, text, headers) end, 'POST', json.encode({username = "FNR Staff Logs", embeds = command}), { ['Content-Type'] = 'application/json' })
end)