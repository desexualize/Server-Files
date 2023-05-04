--[[
    FiveM Scripts
    Copyright C 2018  Sighmir

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published
    by the Free Software Foundation, either version 3 of the License, or
    at your option any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
]]

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local htmlEntities = module("vrp", "lib/htmlEntities")

vRPbm = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_basic_menu")
BMclient = Tunnel.getInterface("vRP_basic_menu","vRP_basic_menu")
vRPbsC = Tunnel.getInterface("vRP_barbershop","vRP_basic_menu")
Tunnel.bindInterface("vrp_basic_menu",vRPbm)

local Lang = module("vrp", "lib/Lang")
local cfg = module("vrp", "cfg/base")
local lang = Lang.new(module("vrp", "cfg/lang/"..cfg.lang) or {})

Citizen.CreateThread(function()
  while true do 
    vRP.defInventoryItem({"body_armor","Level 4 Body Armor","Intact body armor.",
    function(args)
      local choices = {}

      choices["Equip"] = {function(player,choice)
        local user_id = vRP.getUserId({player})
        if user_id ~= nil then
          BMclient.getArmour(player,{},function(armour)
            if armour < 95 then
              if vRP.tryGetInventoryItem({user_id, "body_armor", 1, true}) then
    		        BMclient.setArmour(player,{95,true})
                TriggerEvent('Inventory:RefreshInventory', player)
                vRP.closeMenu({player})
              end
            else
              vRPclient.notify(player,{'~r~You already have Max Armour!'})
            end
          end)
        end
      end}

      return choices
    end,
    5.00})
    Citizen.Wait(3000)
  end
end)



Citizen.CreateThread(function()
  while true do 
    vRP.defInventoryItem({"body_armor2","Level 2 Body Armor","Intact body armor.",
    function(args)
      local choices = {}

      choices["Equip"] = {function(player,choice)
        local user_id = vRP.getUserId({player})
        if user_id ~= nil then
          BMclient.getArmour(player,{},function(armour)
            if armour < 50 then
              if vRP.tryGetInventoryItem({user_id, "body_armor2", 1, true}) then
                TriggerEvent('Inventory:RefreshInventory', player)
    		        BMclient.setArmour(player,{50,true})
                vRP.closeMenu({player})
              end
            else
              vRPclient.notify(player,{'~r~You already have Max Armour!'})
            end
          end)
        end
      end}

      return choices
    end,
    5.00})
    Citizen.Wait(3000)
  end
end)

Citizen.CreateThread(function()
  while true do 
    vRP.defInventoryItem({"body_armor3","Level 1 Body Armor","Intact body armor.",
    function(args)
      local choices = {}

      choices["Equip"] = {function(player,choice)
        local user_id = vRP.getUserId({player})
        if user_id ~= nil then
          BMclient.getArmour(player,{},function(armour)
            if armour < 25 then
              if vRP.tryGetInventoryItem({user_id, "body_armor3", 1, true}) then
    		        BMclient.setArmour(player,{25,true})
                TriggerEvent('Inventory:RefreshInventory', player)
                vRP.closeMenu({player})
              end
            else
              vRPclient.notify(player,{'~r~You already have Max Armour!'})
            end
          end)
        end
      end}

      return choices
    end,
    5.00})
    Citizen.Wait(3000)
  end
end)


local isStoring2 = {}
RegisterCommand("storearmour", function(source)
  local user_id = vRP.getUserId({source})
  BMclient.getArmour(source,{},function(armour)
    if not isStoring2[source] then
      isStoring2[source] = true
      if armour > 90 then
        vRP.giveInventoryItem({user_id, "body_armor", 1, true})
	      BMclient.setArmour(source,{0,false})
        SetTimeout(3000,function()
          isStoring2[source] = nil 
      end)
      else
        if armour > 49 then

          vRP.giveInventoryItem({user_id, "body_armor2", 1, true})
          BMclient.setArmour(source,{0,false})

          SetTimeout(3000,function()
            isStoring2[source] = nil 
        end)
        else
          if armour > 24 then
 
            vRP.giveInventoryItem({user_id, "body_armor3", 1, true})
            BMclient.setArmour(source,{0,false})

            SetTimeout(3000,function()
              isStoring2[source] = nil 
          end)
          else
            vRPclient.notify(source,{'~r~You do not have enough Armour to store!'})
          end
        end
      end
    else
      vRPclient.notify(source,{"~r~Storing Cooldown."})
  end
    
  end)
end)


Citizen.CreateThread(function()
  while true do 
    vRP.defInventoryItem({"morphine","Morphine","",
    function(args)
      local choices = {}

      choices["Equip"] = {function(player,choice)
        local user_id = vRP.getUserId({player})
        if user_id ~= nil then
          BMclient.getHealth(player,{},function(armour)
           
              if vRP.tryGetInventoryItem({user_id, "morphine", 1, true}) then
    		        TriggerClientEvent('morphine', player)
                TriggerEvent('Inventory:RefreshInventory', player)
                vRP.closeMenu({player})
              end
 
          
          end)
        end
      end}

      return choices
    end,
    5.00})
    Citizen.Wait(3000)
  end
end)




