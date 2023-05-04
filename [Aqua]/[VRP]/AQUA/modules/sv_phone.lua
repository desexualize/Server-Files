local cfg_inventory = module("AQUAVehicles", "cfg/cfg_inventory")
local lang = AQUA.lang

RegisterServerEvent("AQUA:AskID")
AddEventHandler("AQUA:AskID",function()
    local player = source

    AQUAclient.getNearestPlayer(player,{10},function(nplayer)
      local nuser_id = AQUA.getUserId(nplayer)
      if nuser_id ~= nil then
        AQUAclient.notify(player,{lang.police.menu.askid.asked()})
        AQUA.request(nplayer,lang.police.menu.askid.request(),15,function(nplayer,ok)
          if ok then
            AQUA.getUserIdentity(nuser_id, function(identity)
              if identity then
                -- display identity and business
                local name = identity.name
                local firstname = identity.firstname
                local age = identity.age
                local phone = identity.phone
                local registration = identity.registration
                local home = ""
                local number = ""
  
  
                  AQUA.getUserAddress(nuser_id, function(address)
                    if address then
                      home = address.home
                      number = address.number
                    end
  
                    local content = lang.police.identity.info({name,firstname,age,registration,phone,home,number})
                    AQUAclient.setDiv(player,{"police_identity",".div_police_identity{ background-color: rgba(0,0,0,0.75); color: white; font-weight: bold; width: 500px; padding: 10px; margin: auto; margin-top: 150px; }",content})
                    -- request to hide div
                    AQUA.request(player, lang.police.menu.askid.request_hide(), 1000, function(player,ok)
                      AQUAclient.removeDiv(player,{"police_identity"})
                    end)
                  end)
              
              end
            end)
          else
            AQUAclient.notify(player,{lang.common.request_refused()})
          end
        end)
      else
        AQUAclient.notify(player,{lang.common.no_player_near()})
      end
    end)
end)

RegisterServerEvent("AQUA:GiveMoney2")
AddEventHandler("AQUA:GiveMoney2",function()
    local player = source
    local user_id = AQUA.getUserId(player)
    if user_id ~= nil then
      AQUAclient.getNearestPlayer(player,{10},function(nplayer)
        if nplayer ~= nil then
        local nuser_id = AQUA.getUserId(nplayer)
        if nuser_id ~= nil then
            AQUA.prompt(player,lang.money.give.prompt(),"",function(player,amount)
            local amount = parseInt(amount)
            if amount > 0 and AQUA.tryPayment(user_id,amount) then
                AQUA.giveMoney(nuser_id,amount)
                AQUAclient.notify(player,{"~d~You have gave ~w~" .. amount .. " ~d~Cash(s)" })
                AQUAclient.notify(nplayer,{"~g~You have recieved ~w~" .. amount .. " ~g~Cash(s)"})
            else
                AQUAclient.notify(player,{lang.money.not_enough()})
                end
            end)
            else
                AQUAclient.notify(player,{lang.common.no_player_near()})
            end
            else
                AQUAclient.notify(player,{lang.common.no_player_near()})
            end
        end)
    end
end)

local function ch_vehicle(player,choice)
  local user_id = AQUA.getUserId(player)
  if user_id ~= nil then
    -- check vehicle
    AQUAclient.getNearestOwnedVehicle(player,{7},function(ok,vtype,name)
      if ok then
        -- build vehicle menu
        AQUA.buildMenu("vehicle", {user_id = user_id, player = player, vtype = vtype, vname = name}, function(menu)
          menu.name=lang.vehicle.title()
          menu.css={top="75px",header_color="rgba(255,125,0,0.75)"}

          for k,v in pairs(veh_actions) do
            menu[k] = {function(player,choice) v[1](user_id,player,vtype,name) end, v[2]}
          end

          AQUA.openMenu(player,menu)
        end)
      else
        AQUAclient.notify(player,{lang.vehicle.no_owned_near()})
      end
    end)
  end
end

RegisterNetEvent('AQUA:TrunkOpened')
AddEventHandler('AQUA:TrunkOpened', function()
  local user_id = AQUA.getUserId(source)
  AQUAclient.getNearestOwnedVehicle(source,{7},function(ok,vtype,name)
    if ok then 
      local chestname = "u"..user_id.."veh_"..string.lower(name)
      local max_weight = cfg_inventory.vehicle_chest_weights[string.lower(name)] or cfg_inventory.default_vehicle_chest_weight

      AQUAclient.vc_openDoor(source, {vtype,5})
      AQUA.openChest(source, chestname, max_weight, function()
        AQUAclient.vc_closeDoor(source, {vtype,5})
      end)
    end
  end)
end)

RegisterNetEvent('AQUA:SearchPlr')
AddEventHandler("AQUA:SearchPlr", function()
  player = source
  AQUAclient.getNearestPlayer(player,{5},function(nplayer)
    local nuser_id = AQUA.getUserId(nplayer)
    if nuser_id ~= nil then
      -- TriggerClientEvent('AQUA:handsUpNearest', nplayer)
      AQUAclient.notify(nplayer,{lang.police.menu.check.checked()})
      AQUAclient.getWeapons(nplayer,{},function(weapons)
        -- prepare display data (money, items, weapons)
        local money = AQUA.getMoney(nuser_id)
        local items = ""
        local data = AQUA.getUserDataTable(nuser_id)
        if data and data.inventory then
          for k,v in pairs(data.inventory) do
            local item_name = AQUA.getItemName(k)
            if item_name then
              items = items.."<br />"..item_name.." ("..v.amount..")"
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
end)

RegisterServerEvent('AQUA:searchNearestPlayer')
AddEventHandler('AQUA:searchNearestPlayer', function(nplayer)
  AQUAclient.notify(nplayer,{lang.police.menu.check.checked()})
  AQUAclient.getWeapons(nplayer,{},function(weapons)
    -- prepare display data (money, items, weapons)
    local money = AQUA.getMoney(nuser_id)
    local items = ""
    local data = AQUA.getUserDataTable(nuser_id)
    if data and data.inventory then
      for k,v in pairs(data.inventory) do
        local item_name = AQUA.getItemName(k)
        if item_name then
          items = items.."<br />"..item_name.." ("..v.amount..")"
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
end)

RegisterServerEvent("AQUA:SendPayment")
AddEventHandler('AQUA:SendPayment', function(playerid, price)
    local source = source
    userid = AQUA.getUserId(source)
    reciever = AQUA.getUserSource(tonumber(playerid))
    recieverid = AQUA.getUserId(reciever)
    
    if recieverid == nil then
        AQUAclient.notify(source, {"~d~This ID does not exist/ is offline!"})
        TriggerClientEvent("AQUA:PlaySound", source, 2)
    else

        if userid == recieverid then 
            AQUAclient.notify(source, {"~d~Unable to send money to yourself!"})
            TriggerClientEvent("AQUA:PlaySound", source, 2)
        else
    
            if AQUA.tryBankPayment(userid, tonumber(price)) then 

                AQUAclient.notify(source, {"~g~Successfully transfered: ~w~" .. price .. " Token(s) ~g~to ~w~" .. AQUA.getPlayerName(reciever) .. " ~d~ ~n~ ~n~[ID: ~w~" .. playerid .. " ~d~]"})
                TriggerClientEvent("AQUA:PlaySound", source, 1)
                AQUA.giveBankMoney(tonumber(playerid), tonumber(price))

                AQUAclient.notify(reciever, {"~g~You have recieved: ~w~" .. price .. " Token(s)~g~ from ~w~".. AQUA.getPlayerName(source) .. " ~d~ ~n~ ~n~[ID: ~w~" .. userid .. " ~d~]"})
                TriggerClientEvent("AQUA:PlaySound", reciever, 1)

                else 
                AQUAclient.notify(source, {"~d~You do not have enough money complete transaction 🤦‍♂️"})
                TriggerClientEvent("AQUA:PlaySound", source, 2)
            end
        end
    end
end)