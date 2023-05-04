-- basic AQUA food.lua with tacos which give health.

local items = {}

local function play_eat(player)
  local seq = {
    {"mp_player_inteat@burger", "mp_player_int_eat_burger_enter",1},
    {"mp_player_inteat@burger", "mp_player_int_eat_burger",1},
    {"mp_player_inteat@burger", "mp_player_int_eat_burger_fp",1},
    {"mp_player_inteat@burger", "mp_player_int_eat_exit_burger",1}
  }

  AQUAclient.playAnim(player,{true,seq,false})
end

local function play_drink(player)
  local seq = {
    {"mp_player_intdrink","intro_bottle",1},
    {"mp_player_intdrink","loop_bottle",1},
    {"mp_player_intdrink","outro_bottle",1}
  }

  AQUAclient.playAnim(player,{true,seq,false})
end

-- gen food choices as genfunc
-- idname
-- ftype: eat or drink
-- health
local function gen(ftype, health)
    local fgen = function(args)
    local idname = args[1]
    local choices = {}
    local act = "Unknown"
    if ftype == "eat" then act = "Eat" elseif ftype == "drink" then act = "Drink" end
    local name = AQUA.getItemName(idname)

    choices[act] = {function(player,choice)
      local user_id = AQUA.getUserId(player)
      if user_id ~= nil then
        if AQUA.tryGetInventoryItem(user_id,idname,1,false) then

          if idname == "Taco" then 
            TriggerClientEvent("Taco:Health", player)
          end
          
          if idname == "Morphine" then 
            TriggerClientEvent("Morphine", player)
          end

          if ftype == "drink" then
            AQUAclient.notify(player,{"~d~Drinking "..name.."."})
            play_drink(player)
          elseif ftype == "eat" then
            AQUAclient.notify(player,{"~o~Eating "..name.."."})
            play_eat(player)
          end

          AQUA.closeMenu(player)
        end
      end
    end}

    return choices
  end
  return fgen
end

--FOOD

items["Taco"] = {"Taco","", gen("eat",50),0.2}
items["Morphine"] = {"Morphine","", gen("eat",200),0.2}

return items
