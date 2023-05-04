local Proxy = module("AQUA", "lib/Proxy")
local Tunnel = module("AQUA","lib/Tunnel")
AQUA = Proxy.getInterface("AQUA")
AQUAclient = Tunnel.getInterface("AQUA","AQUA_policeradial")

local Lang = module("AQUA", "lib/Lang")
local cfg = module("AQUA", "cfg/base")
local lang = Lang.new(module("AQUA", "cfg/lang/"..cfg.lang) or {})

RegisterNetEvent('AQUA:policeDrag')
AddEventHandler('AQUA:policeDrag', function()
    
    local source = source
    Citizen.Wait(0)
    local user_id = AQUA.getUserId({source})
    
    if user_id ~= nil and AQUA.hasPermission({user_id, "police.menu"}) then
        
        AQUAclient.getNearestPlayer(source,{2},function(nplayer)
            local nplayer = nplayer
            
            if nplayer ~= nil then
                local nuser_id = AQUA.getUserId({nplayer})
            if nuser_id ~= nil then
                AQUAclient.isHandcuffed(nplayer,{},function(handcuffed)
                if handcuffed then
                    TriggerClientEvent("AQUA:drag2", nplayer, source)
                else
                    AQUAclient.notify(source,{"Player is not handcuffed."})
                end
                end)
            else
                AQUAclient.notify(source,{lang.common.no_player_near()})
                
            end
            else
            AQUAclient.notify(source,{lang.common.no_player_near()})
            
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

 RegisterNetEvent("AQUA:policeCuff")
 AddEventHandler("AQUA:policeCuff", function()
     local player = source
     local user_id = AQUA.getUserId({source})
     handcuffed = nil
     if user_id ~= nil and AQUA.hasPermission({user_id, "pd.armory"}) then
         AQUAclient.getNearestPlayer(player,{2},function(nplayer)
             nplayer = nplayer
             local nuser_id = AQUA.getUserId({nplayer})
             AQUAclient.isHandcuffed(nplayer,{},function(handcuffed)
                 local nplayer = nplayer
                 local nuser_id = AQUA.getUserId({nplayer})
                 local handcuffed = handcuffed
                 if nuser_id ~= nil then
                     if handcuffed == false then
                         AQUAclient.playAnim(nplayer,{true,crookanim,false})
                         AQUAclient.playAnim(player,{true,policeanim,false})
                         AQUAclient.toggleHandcuff(nplayer,{})
                    elseif handcuffed == true then
                         AQUAclient.playAnim(nplayer,{true,crookuncuff,false})
                         AQUAclient.playAnim(player,{true,policeuncuff,false})
                         AQUAclient.toggleHandcuff(nplayer,{})
                     end
                     TriggerClientEvent("AQUA:PlaySound", source, "handcuff")
                 else
                     AQUAclient.notify(player,"No player near you")
                 end

             end)
         end)
     end

TriggerClientEvent('chat:addSuggestion', '/uncuffme', 'Uncuff yourself.')
RegisterCommand("uncuffme", function(source, args, rawCommand)
  local user_id = AQUA.getUserId({source})
  AQUAclient.isHandcuffed(source,{},function(handcuffed)
    if handcuffed == true then
      if AQUA.hasPermission({user_id, 'admin.noclip'}) then
        AQUAclient.toggleHandcuff(source,{})
      end
    end
  end)
end)


 end)

RegisterNetEvent('AQUA:policeCuffStaff')
AddEventHandler('AQUA:policeCuffStaff', function(staffmode)
  local player = source
  local user_id = AQUA.getUserId({source})
  handcuffed = nil
  if AQUA.hasPermission({user_id, 'admin.tickets'}) then
    if AQUA.hasPermission({user_id, "pd.armory"}) then return end
    if user_id ~= nil and staffmode == true then
        AQUAclient.getNearestPlayer(player,{2},function(nplayer)
            nplayer = nplayer
            local nuser_id = AQUA.getUserId({nplayer})
            AQUAclient.isHandcuffed(nplayer,{},function(handcuffed)
                local nplayer = nplayer
                local nuser_id = AQUA.getUserId({nplayer})
                local handcuffed = handcuffed
                if nuser_id ~= nil then
                    if handcuffed == false then
                        AQUAclient.playAnim(nplayer,{true,crookanim,false})
                        AQUAclient.playAnim(player,{true,policeanim,false})
                        AQUAclient.toggleHandcuff(nplayer,{})
                  elseif handcuffed == true then
                        AQUAclient.playAnim(nplayer,{true,crookuncuff,false})
                        AQUAclient.playAnim(player,{true,policeuncuff,false})
                        AQUAclient.toggleHandcuff(nplayer,{})
                    end
                    TriggerClientEvent("AQUA:PlaySound", source, "handcuff")
                else
                    AQUAclient.notify(player,"No player near you")
                end

            end)
        end)
      end
    end
end)


Tunnel.bindInterface("AQUA_basic_menu",AQUAbm)
BMclient = Tunnel.getInterface("AQUA_basic_menu","AQUA_basic_menu")
RegisterServerEvent('AQUA:toggleTrafficMenu')
AddEventHandler('AQUA:toggleTrafficMenu', function()
    local source = source
    local user_id = AQUA.getUserId({source})
    if user_id ~= nil and AQUA.hasPermission({user_id, "police.menu"}) then
        print("AQUA Identification Accepted") 
        TriggerClientEvent("AQUA:openTrafficMenu", source)
    end
end)

RegisterServerEvent('AQUA:zoneActivated')
AddEventHandler('AQUA:zoneActivated', function(message, speed, radius, x, y, z)
    TriggerClientEvent('chatMessage', -1, message)
    TriggerClientEvent('AQUA:createZone', -1, speed, radius, x, y, z)
end)

RegisterServerEvent('AQUA:disableZone')
AddEventHandler('AQUA:disableZone', function(blip)
    TriggerClientEvent('AQUA:removeBlip', -1)
end)


local unjailed = {}
function jail_clock(target_id,timer)
  local target = AQUA.getUserSource({tonumber(target_id)})
  local users = AQUA.getUsers({})
  local online = false
  for k,v in pairs(users) do
	if tonumber(k) == tonumber(target_id) then
	  online = true
	end
  end
  if online then
    if timer>0 then
	  AQUAclient.notify(target, {"~d~Remaining time: " .. timer .. " minute(s)."})
      AQUA.setUData({tonumber(target_id),"AQUA:jail:time",json.encode(timer)})
	  SetTimeout(60*1000, function()
		for k,v in pairs(unjailed) do -- check if player has been unjailed by cop or admin
		  if v == tonumber(target_id) then
	        unjailed[v] = nil
		    timer = 0
		  end
		end
		AQUA.setHunger({tonumber(target_id), 0})
		AQUA.setThirst({tonumber(target_id), 0})
	    jail_clock(tonumber(target_id),timer-1)
	  end) 
    else 
	  BMclient.loadFreeze(target,{false,true,true})
	  SetTimeout(15000,function()
		BMclient.loadFreeze(target,{false,false,false})
	  end)
	  AQUAclient.teleport(target,{1846.4332275391,2585.7666015625,45.671997070313}) -- teleport to outside jail
	  AQUAclient.setHandcuffed(target,{false})
      AQUAclient.notify(target,{"~d~You have been set free."})
	  AQUA.setUData({tonumber(target_id),"AQUA:jail:time",json.encode(-1)})
    end
  end
end

RegisterServerEvent('AQUA:Fine')
AddEventHandler('AQUA:Fine', function() 
    player = source
    local user_id = AQUA.getUserId({player})
    if user_id ~= nil and AQUA.hasPermission({user_id, "police.menu"}) then
    AQUAclient.getNearestPlayers(player,{15},function(nplayers) 
      local user_list = ""
      for k,v in pairs(nplayers) do
        user_list = user_list .. "[" .. AQUA.getUserId({k}) .. "]" .. GetPlayerName(k) .. " | "
      end 
      if user_list ~= "" then
        AQUA.prompt({player,"Players Nearby:" .. user_list,"",function(player,target_id) 
          if target_id ~= nil and target_id ~= "" then 
            AQUA.prompt({player,"Fine amount:","100",function(player,fine)
              if fine ~= nil and fine ~= "" then 
                AQUA.prompt({player,"Fine reason:","",function(player,reason)
                  if reason ~= nil and reason ~= "" then 
                    local target = AQUA.getUserSource({tonumber(target_id)})
                    if target ~= nil then
                      if tonumber(fine) > 250000 then
                          fine = 250000
                      end
                      if tonumber(fine) < 1 then
                        fine = 1
                      end
                
                      if AQUA.tryFullPayment({tonumber(target_id), tonumber(fine)}) then
                        AQUA.insertPoliceRecord({tonumber(target_id), lang.police.menu.fine.record({reason,fine})})
                        --AQUAclient.notify(player,{lang.police.menu.fine.fined({reason,fine})})
                        AQUAclient.notify(target,{lang.police.menu.fine.notify_fined({reason,fine})})
                        AQUA.giveBankMoney({player, tonumber(fine)/10})
                        AQUAclient.notify(player,{'~g~You have received £'.. tonumber(fine)/10 ..' as you '..lang.police.menu.fine.fined({reason,fine})})
                        local user_id = AQUA.getUserId({player})
                        AQUA.closeMenu({player})
                      else
                        AQUAclient.notify(player,{lang.money.not_enough()})
                      end
                    else
                      AQUAclient.notify(player,{"~d~That ID seems invalid."})
                    end
                  else
                    AQUAclient.notify(player,{"~d~You can't fine for no reason."})
                  end
                end})
              else
                AQUAclient.notify(player,{"~d~Your fine has to have a value."})
              end
            end})
          else
            AQUAclient.notify(player,{"~d~No player ID selected."})
          end 
        end})
      else
        AQUAclient.notify(player,{"~d~No player nearby."})
      end 
    end)
  else
    print(user_id.." Could be modder")
  end
end)


RegisterServerEvent('AQUA:Drag')
AddEventHandler('AQUA:Drag', function() 
      -- get nearest player
      local user_id = AQUA.getUserId({player})
      if user_id ~= nil then
        AQUAclient.getNearestPlayer(player,{10},function(nplayer)
          if nplayer ~= nil then
            local nuser_id = AQUA.getUserId({nplayer})
            if nuser_id ~= nil then
          AQUAclient.isHandcuffed(nplayer,{},function(handcuffed)
          if handcuffed then
            TriggerClientEvent("dr:drag", nplayer, player)
          else
            AQUAclient.notify(player,{"Player is not handcuffed."})
          end
          end)
            else
              AQUAclient.notify(player,{"no one near"})
            end
          else
            AQUAclient.notify(player,{"Player is not handcuffed."})
          end
        end)
      end
end)

RegisterServerEvent('AQUA:TrafficMenuLogs')
AddEventHandler('AQUA:TrafficMenuLogs', function(objspawned) 
  local player = source
  local admin_id = AQUA.getUserId({player})
  local admin_name = GetPlayerName(player)
  local logs = ""
  local communityname = " Staff Logs"
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
  PerformHttpRequest(logs, function(err, text, headers) end, 'POST', json.encode({username = " Staff Logs", embeds = command}), { ['Content-Type'] = 'application/json' })
end)