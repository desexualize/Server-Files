
local items = {}



-- money
items["money"] = {"Money","Packed money.",function(args)
  local choices = {}
  local idname = args[1]

  choices["Unpack"] = {function(player,choice,mod)
    -- local user_id = AQUA.getUserId(player)
    -- if user_id ~= nil then
    --   local amount = AQUA.getInventoryItemAmount(user_id, idname)
    --   AQUA.prompt(player, "How much to unpack ? (max "..amount..")", "", function(player,ramount)
    --     ramount = parseInt(ramount)
    --     if AQUA.tryGetInventoryItem(user_id, idname, ramount, true) then -- unpack the money
    --       AQUA.giveMoney(user_id, ramount)
    --       AQUA.closeMenu(player)
    --     end
    --   end)
    -- end
  end}

  return choices
end,0}

-- money binder
items["money_binder"] = {"Money binder","Used to bind £1000 of money.",function(args)
  local choices = {}
  local idname = args[1]

  choices["Bind money"] = {function(player,choice,mod) -- bind the money
    -- local user_id = AQUA.getUserId(player)
    -- if user_id ~= nil then
    --   local money = AQUA.getMoney(user_id)
    --   if money >= 1000 then
    --     if AQUA.tryGetInventoryItem(user_id, idname, 1, true) and AQUA.tryPayment(user_id,1000) then
    --       AQUA.giveInventoryItem(user_id, "money", 1000, true)
    --       AQUA.closeMenu(player)
    --     end
    --   else
    --     AQUAclient.notify(player,{AQUA.lang.money.not_enough()})
    --   end
    -- end
  end}

  return choices
end,0}

-- parametric weapon items
-- give "wbody|WEAPON_PISTOL" and "wammo|WEAPON_PISTOL" to have pistol body and pistol bullets

local get_wname = function(weapon_id)
  local name = string.gsub(weapon_id,"WEAPON_","")
  name = string.upper(string.sub(name,1,1))..string.lower(string.sub(name,2))
  return name
end

--- weapon body
-- local wbody_name = function(args)
--   return get_wname(args[2]).." body"
-- end
local a = module("cfg/cfg_weapons")


local wbody_name = function(args)
  -- Large Arms -- 
  if args[2] == "WEAPON_WINCHESTER" then 
      return "Winchester"
  elseif args[2] == "WEAPON_VESPER" then 
      return "Vesper"
    elseif args[2] == "WEAPON_MP7" then 
      return "MP7"
    elseif args[2] == "WEAPON_MP40" then 
      return "MP-40"
    elseif args[2] == "WEAPON_akm" then 
      return "AKM"
    elseif args[2] == "WEAPON_MOSIN" then 
      return "Mosin Nagant"
   -- VIP Gunstore -- 
  elseif args[2] == "WEAPON_GOLDAK" then 
    return "AK-47 Gold"
  elseif args[2] == "WEAPON_SPAR16" then 
    return "SPAR-16"
  elseif args[2] == "WEAPON_AK74" then 
    return "AK-74"
    
    -- Small Arms
  elseif args[2] == "WEAPON_M1911" then 
    return "M1911"
  elseif args[2] == "WEAPON_BERETTA" then 
    return "Beretta"
  elseif args[2] == "WEAPON_PYTHON" then 
    return "Python"
  elseif args[2] == "WEAPON_UMP45" then 
    return "UMP45"
  elseif args[2] == "WEAPON_HG" then 
    return "Hush Ghost"
    
    -- Rebel -- 
  elseif args[2] == "WEAPON_AK200" then 
    return "AK-200"
  elseif args[2] == "WEAPON_MXM" then 
    return "MXM"
    -- Advanced Rebel -- 
  elseif args[2] == "WEAPON_MXC" then 
    return "MXM"
  elseif args[2] == "WEAPON_MK1EMR" then 
    return "MK1 EMR"
  elseif args[2] == "WEAPON_SVD" then 
    return "Dragunov SVD"
    -- Police Small Arms -- 
  elseif args[2] == "WEAPON_NIGHTSTICK" then 
    return "Police issued Baton"
  elseif args[2] == "WEAPON_FLASHLIGHT" then 
    return "Police issued Flashlight"
  elseif args[2] == "WEAPON_GLOCK" then 
    return "Police issued Glock"
  elseif args[2] == "WEAPON_STUNGUN" then 
    return "Police issued Tazer"
  elseif args[2] == "WEAPON_REMINGTON870" then 
    return "Police issued Reminton 870"
  elseif args[2] == "WEAPON_SPEEDGUN" then 
    return "Police issued Speed Gun"
    -- Police Large Arms -- 
  elseif args[2] == "WEAPON_MP5" then 
    return "Police issued MP5"
  elseif args[2] == "WEAPON_REMINGTON700" then 
    return "Police issued Remington 700"
  elseif args[2] == "WEAPON_AX50" then 
    return "Police issued AX-50 Sniper Rifle"
  elseif args[2] == "WEAPON_PDMCX" then 
    return "Police issued SIG MCX"
  elseif args[2] == "WEAPON_SPAR17" then 
    return "Police issued SPAR-17"
  elseif args[2] == "WEAPON_PDHK416" then 
    return "Police issued HK-416"
  elseif args[2] == "WEAPON_CQ300" then 
    return "Police issued CQ-300"
-- Poilce Custom Imports -- 
elseif args[2] == "WEAPON_M4SANDSTORM" then 
  return "Police issued M4 Sandstorm"
elseif args[2] == "WEAPON_L96A3" then 
  return "Police issued L96A3"

  -- Large Arms Custom Imports -- 
elseif args[2] == "WEAPON_scorpianblue" then 
  return "Scorpion Blue"
elseif args[2] == "WEAPON_blackicepeacekeeper" then 
  return "Black Ice Peacekeeper"
elseif args[2] == "WEAPON_SAGIRI" then 
  return "M4A4 SAGIRI"
elseif args[2] == "WEAPON_DIAMONDMP5" then 
  return "Diamond MP5"
elseif args[2] == "WEAPON_NERFMOSIN" then 
  return "Nerf Mosin"
elseif args[2] == "WEAPON_NEONOIRMAC10" then 
  return "Neo Noir Mac 10"
elseif args[2] == "WEAPON_BLASTXPHANTOM" then 
  return "BLAST-X Phantom"
  elseif args[2] == "WEAPON_GRAU556" then 
  return "Purple Nike Grau"
  elseif args[2] == "WEAPON_CHERRYMOSIN" then 
  return "Cherry Blossom Mosin"
elseif args[2] == "WEAPON_NOVMOSIN" then 
  return "No Vantiy Mosin"
  elseif args[2] == "WEAPON_M4A4FIRE" then 
  return "M4A4 Fire"
elseif args[2] == "WEAPON_PURPLEVANDAL" then 
  return "Purple Vandal"
  
elseif args[2] == "WEAPON_FNTACSHOTGUN" then 
  return "Fortnite Tactical Shotgun"
elseif args[2] == "WEAPON_RUSTAK" then 
  return "Rust AK"
elseif args[2] == "WEAPON_REAVEROP" then 
  return "Reaver Operator"
elseif args[2] == "WEAPON_HKJAMO" then 
  return "HK416 EFT"
elseif args[2] == "WEAPON_ICEVECTOR" then 
  return "Black Ice Vector"
elseif args[2] == "WEAPON_PRIMEVANDAL" then 
  return "Prime Vandal"
elseif args[2] == "WEAPON_UMPV2NEONOIR" then 
  return "UMP Neo Noir"
elseif args[2] == "WEAPON_RGXVANDAL" then 
  return "RGX Vandal"
elseif args[2] == "WEAPON_M16A1PD" then 
  return "Police issued M16A1"
elseif args[2] == "WEAPON_SA80" then 
  return "Police issued SA80"
elseif args[2] == "WEAPON_MP9PD" then 
  return "Police issued MP9"
  
  -- Custom Import Meleess
elseif args[2] == "WEAPON_MEDSWORD" then 
  return "Medieval Sword"
elseif args[2] == "WEAPON_SABERVADER" then 
  return "Darth Vader Light Saber"
  
    else 
        return get_wname(args[2]).." body" -- keep
    end
  end
  
  
local wbody_desc = function(args)
  return ""
end

local wbody_choices = function(args)
  local choices = {}
  local fullidname = joinStrings(args,"|")

  choices["Equip"] = {function(player,choice)
    local user_id = AQUA.getUserId(player)
    if user_id ~= nil then
      if AQUA.tryGetInventoryItem(user_id, fullidname, 1, true) then -- give weapon body
        local weapons = {}
        weapons[args[2]] = {ammo = 0}
        AQUAclient.giveWeapons(player, {weapons})

        AQUA.closeMenu(player)
      end
    end
  end}

  return choices
end

local wbody_weight = function(args)
  if args[2] == "WEAPON_WINCHESTER" then 
    return 7.5
elseif args[2] == "WEAPON_VESPER" then 
    return 7.5
  elseif args[2] == "WEAPON_MP7" then 
    return 7.5
  elseif args[2] == "WEAPON_MP40" then 
    return 7.5
  elseif args[2] == "WEAPON_akm" then 
    return 10
  elseif args[2] == "WEAPON_MOSIN" then 
    return 7.5
 -- VIP Gunstore -- 
elseif args[2] == "WEAPON_GOLDAK" then 
  return 10
elseif args[2] == "WEAPON_SPAR16" then 
  return 10
elseif args[2] == "WEAPON_AK74" then 
  return 10
  
  -- Small Arms
elseif args[2] == "WEAPON_UMP45" then 
  return 7.5
  -- Rebel -- 
elseif args[2] == "WEAPON_AK200" then 
  return 10
elseif args[2] == "WEAPON_MXM" then 
  return 10
  -- Advanced Rebel -- 
elseif args[2] == "WEAPON_MXC" then 
  return 10
elseif args[2] == "WEAPON_MK1EMR" then 
  return 10
elseif args[2] == "WEAPON_SVD" then 
  return 15
  -- Police Small Arms -- 
-- elseif args[2] == "WEAPON_NIGHTSTICK" then 
--   return 5
-- elseif args[2] == "WEAPON_FLASHLIGHT" then 
--   return 5
-- elseif args[2] == "WEAPON_GLOCK" then 
--   return 5
-- elseif args[2] == "WEAPON_STUNGUN" then 
--   return 5
elseif args[2] == "WEAPON_REMINGTON870" then 
  return 7.5
-- elseif args[2] == "WEAPON_SPEEDGUN" then 
--   return 5
  -- Police Large Arms -- 
elseif args[2] == "WEAPON_MP5" then 
  return 7.5
elseif args[2] == "WEAPON_REMINGTON700" then 
  return 15
elseif args[2] == "WEAPON_AX50" then 
  return 15
elseif args[2] == "WEAPON_PDMCX" then 
  return 10
elseif args[2] == "WEAPON_SPAR17" then 
  return 10
elseif args[2] == "WEAPON_PDHK416" then 
  return 10
elseif args[2] == "WEAPON_CQ300" then 
  return 7.5
-- Poilce Custom Imports -- 
elseif args[2] == "WEAPON_M4SANDSTORM" then 
return 10
elseif args[2] == "WEAPON_L96A3" then 
  return 15
-- Large Arms Custom Imports -- 
elseif args[2] == "WEAPON_scorpianblue" then 
return 7.5
elseif args[2] == "WEAPON_blackicepeacekeeper" then 
return 7.5
elseif args[2] == "WEAPON_SAGIRI" then 
return 10
elseif args[2] == "WEAPON_DIAMONDMP5" then 
return 7.5
elseif args[2] == "WEAPON_NERFMOSIN" then 
return 7.5
elseif args[2] == "WEAPON_NEONOIRMAC10" then 
return 7.5
elseif args[2] == "WEAPON_BLASTXPHANTOM" then 
return 10
elseif args[2] == "WEAPON_GRAU556" then 
return 10
elseif args[2] == "WEAPON_CHERRYMOSIN" then 
return 7.5
elseif args[2] == "WEAPON_NOVMOSIN" then 
  return 7.5

elseif args[2] == "WEAPON_M4A4FIRE" then 
return 10
elseif args[2] == "WEAPON_PURPLEVANDAL" then 
  return 10
elseif args[2] == "WEAPON_FNTACSHOTGUN" then 
  return 7.5
elseif args[2] == "WEAPON_RUSTAK" then 
  return 10
elseif args[2] == "WEAPON_REAVEROP" then 
  return 15
elseif args[2] == "WEAPON_HKJAMO" then 
  return 10
elseif args[2] == "WEAPON_ICEVECTOR" then 
  return 7.5
elseif args[2] == "WEAPON_PRIMEVANDAL" then 
  return 10
elseif args[2] == "WEAPON_UMPV2NEONOIR" then 
  return 7.5
elseif args[2] == "WEAPON_RGXVANDAL" then 
  return 10
elseif args[2] == "WEAPON_M16A1PD" then 
  return 10
elseif args[2] == "WEAPON_SA80" then 
  return 10
elseif args[2] == "WEAPON_MP9PD" then 
  return 7.5
elseif args[2] == "WEAPON_SABERVADER" then 
  return 2
  
else    
    return 5.0
  end                
end

items["wbody"] = {wbody_name,wbody_desc,wbody_choices,wbody_weight}

--- weapon ammo
local wammo_name = function(args)
  if args[1] == ".308 Bullets" then 
    return ".308 Sniper Rounds"

  elseif args[1] == "12 Gauge" then 
      return "12 Gauge Pellets"

  elseif args[1] == "7.62 Bullets" then 
        return "7.62mm Bullets"

  elseif args[1] == "5.56 NATO" then 
          return "5.56mm NATO Bullets"



  else
  return args[1]
  end
end

local wammo_desc = function(args)
  return ""
end

local hasWep = false
local wammo_choices = function(args)
  local choices = {}
  local fullidname = joinStrings(args,"|")
  local ammotype = nil;
  ammotype = args[1]

  choices["Load"] = {function(player,choice)
    local user_id = AQUA.getUserId(player)
    if user_id ~= nil then
      local amount = AQUA.getInventoryItemAmount(user_id, fullidname)
      TriggerClientEvent('checkAmmo', player)
      AQUA.prompt(player, "Amount to load ? (max "..amount..")", "", function(player,ramount)
        ramount = parseInt(ramount)

        AQUAclient.getWeapons(player, {}, function(uweapons)
            for i,v in pairs(AQUAAmmoTypes[ammotype]) do
               if uweapons[v] ~= nil then -- check if the weapon is equiped
                      if AQUA.tryGetInventoryItem(user_id, fullidname, ramount, true) then -- give weapon ammo
                        local weapons = {}
                        weapons[v] = {ammo = ramount}
                        AQUAclient.giveWeapons(player, {weapons,false})
                        AQUA.closeMenu(player)
                        TriggerEvent('AQUA:RefreshInventory', player)
                        return
                      end
                    --end
                 end 
            end
          
        end)
      end)
    end
  end}

  return choices
end

-- lightarmour
-- heavyarmour

local armour_seq = {{"oddjobs@basejump@ig_15","puton_parachute", 1}} 
local Cooldown = {}
items["heavyarmour"] = {"Heavy Armour Plate","Armour",function(args)
  local choices = {}
  choices['Equip'] = {function(player,choice)
    local PermID = AQUA.getUserId(player)
    local Ped = GetPlayerPed(player)
    local PedArmour = GetPedArmour(Ped)
    if Cooldown[player] then
      return AQUAclient.notify(player,{"~d~Server is still proccesing your request."})
    else
      if PermID ~= nil then
        if PedArmour > 95 then
          AQUAclient.notify(player,{"~d~You already have armour."})
        else
          if AQUA.hasPermission(PermID, "rebel.guns") then
            if AQUA.tryGetInventoryItem(PermID, "heavyarmour", 1, false) then
              Cooldown[player] = true;
              AQUAclient.playAnim(player, {false, armour_seq, false}) -- anim
              Wait(2500)
              AQUAclient.setArmour(player,{100})
              AQUAclient.notify(player,{"~g~Applied Armour Plate"})
              Cooldown[player] = false;
            end
          else
            AQUAclient.notify(player,{"~d~Missing Rebel License."})
          end
        end
      end
    end
  end}
  return choices
end,15}


local function play_morphine(player)
  local morphine_seq = {
    {"mp_player_intdrink","intro_bottle",1},
    {"mp_player_intdrink","loop_bottle",1},
    {"mp_player_intdrink","outro_bottle",1}
  }

  AQUAclient.playAnim(player,{true,morphine_seq,false})
end
items["morphine"] = {"Morphine", "morphine",function(args)
local choices = {}
choices['Equip'] = {function(player,choice)
  local PermID = AQUA.getUserId(player)
  if PermID ~= nil then 
  if AQUA.tryGetInventoryItem(PermID, "morphine", 1, false) then 
          play_morphine(player)
          wait(2500)
          TriggerClientEvent('Health:Morphine', player)
          end
       end
    end}
  return choices
end,5}


RegisterNetEvent('sendAmmo')
AddEventHandler('sendAmmo', function(bool)
  hasWep = bool 
end)

local wammo_weight = function(args)
  return 0.01
end


for i,v in pairs(AQUAAmmoTypes) do
  -- print(i)
  
  items[i] = {wammo_name,wammo_desc,wammo_choices,wammo_weight}
  
end

--local wammo_name = function(args)
--  for i,v in pairs(AQUAAmmoTypes) do
--     for a,d in pairs(v) do 
--        if d == args[2] then
--          return i
--        end
--     end
--  end
--  return args[1]
--end

items["wammo"] = {wammo_name,wammo_desc,wammo_choices,wammo_weight}

return items

