local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_chief")

vRPSbc = {}
Tunnel.bindInterface("vrp_chief",vRPSbc)
Proxy.addInterface("vrp_chief",vRPSbc)
vRPCbc = Tunnel.getInterface("vrp_chief","vrp_chief")


local menus = {
    [1] = {
        menu = "Menu Burger & Cola",
        items = {"meat", "fries", "fruitsandvegetabels", "coke"},
        yougot = "menuburger",
        description = "Ingradients: <br>Meat <br>Fries <br>Fruits and Vegetables <br>Coke",
        total_ingredients = 4
    },
    [2] = {
        menu = "you can add more menus here.",
        items = {"meat", "fries", "fruitsandvegetabels", "coke"},
        yougot = "menuburger",
        description = "server.lua",
        total_ingredients = 5
    }
}

local necesaryitems = 0
local yougotmenu = nil

local function openMenu(player)
  local user_id = vRP.getUserId({player})
  if user_id ~= nil then
    local menuschief = {}
    for k, v in pairs(menus) do
      menuschief[v.menu] = {function(player, choice)
        for i, untable in pairs(v.items) do
          local have1 = vRP.getInventoryItemAmount({user_id,untable})
          if have1 > 0 then
            vRP.tryGetInventoryItem({user_id,untable,1,false})
            necesaryitems = necesaryitems + 1
          end
        end
        if necesaryitems == v.total_ingredients then
          vRP.giveInventoryItem({user_id,v.yougot,1,true})
          vRPCbc.startMissionbook(player,{})
          vRPclient.notify(player,{"Order the table!"})
          yougotmenu = v.yougot
          necesaryitems = 0
        else
          vRPclient.notify(player,{"You lack ingredients."})
          vRPclient.notify(player,{"You have: ~g~"..necesaryitems.." / "..v.total_ingredients})
          necesaryitems = 0
        end
        vRP.closeMenu({player})
      end,v.description}
    end
    vRP.openMenu({player, menuschief})
  end
end

function vRPSbc.openchiefmenu()
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    if user_id then
        openMenu(player)
    end
end

function vRPSbc.getfood(bool)
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    if user_id then
        if bool == 1 then
            vRP.giveInventoryItem({user_id, "meat", 1, 1})
        elseif bool == 2 then
            vRP.giveInventoryItem({user_id, "fries", 1, 1})
        elseif bool == 3 then
            vRP.giveInventoryItem({user_id, "fruitsandvegetabels", 1, 1})
        elseif bool == 4 then
            vRP.giveInventoryItem({user_id, "coke", 1, 1})
        end
    end
end

function vRPSbc.paychief()
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    if user_id then
        for i,v in pairs(menus) do
            if v.yougot == yougotmenu then
                if vRP.tryGetInventoryItem({user_id, v.yougot, 1, false}) then
                   local randommoney = math.random(150, 1000)
                   yougotmenu = nil
                   vRP.giveMoney({user_id, randommoney})
                   vRPclient.notify(player,{"~w~You got ~g~"..randommoney.."$"})
                else
                   vRPclient.notify(player,{"~w~Go and work for money"})
                end
            end
        end
    end
end
