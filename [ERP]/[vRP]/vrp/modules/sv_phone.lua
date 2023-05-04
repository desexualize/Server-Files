local cfg_inventory = module("cfg/inventory")
local lang = vRP.lang

RegisterServerEvent("ERP:AskID")
AddEventHandler("ERP:AskID",function()
  local player = source

  vRPclient.getNearestPlayer(player,{10},function(nplayer)
    local nuser_id = vRP.getUserId(nplayer)
    if nuser_id ~= nil then
      vRPclient.notify(player,{lang.police.menu.askid.asked()})
      vRP.request(nplayer,lang.police.menu.askid.request(),15,function(nplayer,ok)
        if ok then
          vRP.getUserIdentity(nuser_id, function(identity)
            if identity then
              -- display identity and business
              local name = identity.name
              local firstname = identity.firstname
              local age = identity.age
              local phone = identity.phone
              local registration = identity.registration
              local bname = ""
              local bcapital = 0
              local home = ""
              local number = ""

              vRP.getUserBusiness(nuser_id, function(business)
                if business then
                  bname = business.name
                  bcapital = business.capital
                end

                vRP.getUserAddress(nuser_id, function(address)
                  if address then
                    home = address.home
                    number = address.number
                  end

                  local content = lang.police.identity.info({name,firstname,age,registration,phone,bname,bcapital,home,number})
                  vRPclient.setDiv(player,{"police_identity",".div_police_identity{ background-color: rgba(0,0,0,0.75); color: white; font-weight: bold; width: 500px; padding: 10px; margin: auto; margin-top: 150px; }",content})
                  -- request to hide div
                  vRP.request(player, lang.police.menu.askid.request_hide(), 1000, function(player,ok)
                    vRPclient.removeDiv(player,{"police_identity"})
                  end)
                end)
              end)
            end
          end)
        else
          vRPclient.notify(player,{lang.common.request_refused()})
        end
      end)
    else
      vRPclient.notify(player,{lang.common.no_player_near()})
    end
  end)
end)

RegisterServerEvent("ERP:GiveMoney")
AddEventHandler("ERP:GiveMoney",function(amount)
  local player = source
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    vRPclient.getNearestPlayer(player,{10},function(nplayer)
      if nplayer ~= nil then
      local nuser_id = vRP.getUserId(nplayer)
      if nuser_id ~= nil then
          vRP.prompt(player,lang.money.give.prompt(),"",function(player,amount)
          local amount = parseInt(amount)
          if amount > 0 and vRP.tryPayment(user_id,amount) then
              vRP.giveMoney(nuser_id,amount)
              vRPclient.notify(player,{lang.money.given({amount})})
              vRPclient.notify(nplayer,{lang.money.received({amount})})
          else
              vRPclient.notify(player,{lang.money.not_enough()})
              end
          end)
          else
              vRPclient.notify(player,{lang.common.no_player_near()})
          end
          else
              vRPclient.notify(player,{lang.common.no_player_near()})
          end
      end)
  end
end)

local function ch_vehicle(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    -- check vehicle
    vRPclient.getNearestOwnedVehicle(player,{7},function(ok,vtype,name)
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
        vRPclient.notify(player,{lang.vehicle.no_owned_near()})
      end
    end)
  end
end

RegisterNetEvent('ERP:TrunkOpened')
AddEventHandler('ERP:TrunkOpened', function()
  local user_id = vRP.getUserId(source)
  vRPclient.getNearestOwnedVehicle(source,{7},function(ok,vtype,name)
    if ok then 
      local chestname = "u"..user_id.."veh_"..string.lower(name)
      local max_weight = cfg_inventory.vehicle_chest_weights[string.lower(name)] or cfg_inventory.default_vehicle_chest_weight

      vRPclient.vc_openDoor(source, {vtype,5})
      vRP.openChest(source, chestname, max_weight, function()
        vRPclient.vc_closeDoor(source, {vtype,5})
      end)
    end
  end)
end)

RegisterNetEvent('ERP:SearchPlr')
AddEventHandler("ERP:SearchPlr", function()
  player = source
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
            local item_name = vRP.getItemName(k)
            if item_name then
              items = items.."<br />"..item_name.." ("..v.amount..")"
            end
          end
        end

        local weapons_info = ""
        for k,v in pairs(weapons) do
          weapons_info = weapons_info.."<br />"..k.." ("..v.ammo..")"
        end

        vRPclient.setDiv(player,{"police_check",".div_police_check{ background-color: rgba(0,0,0,0.75); color: white; font-weight: bold; width: 500px; padding: 10px; margin: auto; margin-top: 150px; }",lang.police.menu.check.info({money,items,weapons_info})})
        -- request to hide div
        vRP.request({player, lang.police.menu.check.request_hide(), 1000, function(player,ok)
          vRPclient.removeDiv(player,{"police_check"})
        end})
      end)
    else
      vRPclient.notify(player,{lang.common.no_player_near()})
    end
  end)
end)

RegisterServerEvent("ERP:SendPayment")
AddEventHandler('ERP:SendPayment', function(playerid, price)
    local source = source
    userid = vRP.getUserId(source)
    reciever = vRP.getUserSource(tonumber(playerid))
    recieverid = vRP.getUserId(reciever)
    
    if recieverid == nil then
        vRPclient.notify(source, {"~r~This ID does not exist/ is offline!"})
        TriggerClientEvent("ERP:PlaySound", source, 2)
    else

        if userid == recieverid then 
            vRPclient.notify(source, {"~r~Unable to send money to yourself!"})
            TriggerClientEvent("ERP:PlaySound", source, 2)
        else
    
            if vRP.tryBankPayment(userid, tonumber(price)) then 

                vRPclient.notify(source, {"~g~Successfully transfered: ~w~" .. price .. " Token(s) ~g~to ~w~" .. vRP.getPlayerName(reciever) .. " ~r~ ~n~ ~n~[ID: ~w~" .. playerid .. " ~r~]"})
                TriggerClientEvent("ERP:PlaySound", source, 1)
                vRP.giveBankMoney(tonumber(playerid), tonumber(price))

                vRPclient.notify(reciever, {"~g~You have recieved: ~w~" .. price .. " Token(s)~g~ from ~w~".. vRP.getPlayerName(source) .. " ~r~ ~n~ ~n~[ID: ~w~" .. userid .. " ~r~]"})
                TriggerClientEvent("ERP:PlaySound", reciever, 1)

                webhook = "https://discord.com/api/webhooks/930536791369474069/TBx4EgRkg_19gIJlfe0l6YGwkcSaX5O61wsBpfj2v0PluxklOTwEAQbaSKr3ueJE0Z3r"
                PerformHttpRequest(webhook, function(err, text, headers) 
                end, "POST", json.encode({username = "ERP Roleplay", embeds = {
                    {
                        ["color"] = "15158332",
                        ["title"] = "",
                        ["description"] = "**'" .. GetPlayerName(source) .. "' [" .. vRP.getUserId(source) .. "] **MPayed **" .. vRP.getPlayerName(reciever) .. '[ ' ..  vRP.getUserId(reciever) .. ']**',
                        ["footer"] = {
                            ["text"] = "Time - "..os.date("%x %X %p"),
                        }
                }
             }}), { ["Content-Type"] = "application/json" })
                else 
                vRPclient.notify(source, {"~r~You do not have enough money complete transaction!"})
                TriggerClientEvent("ERP:PlaySound", source, 2)
            end
        end
    end
end)