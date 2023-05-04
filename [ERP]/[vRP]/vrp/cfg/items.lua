-- define items, see the Inventory API on github

local cfg = {}
-- see the manual to understand how to create parametric items
-- idname = {name or genfunc, description or genfunc, genfunc choices or nil, weight or genfunc}
-- a good practice is to create your own item pack file instead of adding items here
cfg.items = {

  ["heroin"] = {"Heroin", "", nil, 5}, -- no choices
  ["opium"] = {"Opium", "", nil, 1}, -- no choices
  ["weed2"] = {"Weed", "", nil, 5}, -- no choices
  ["leef"] = {"Cannabis Sativa", "", nil, 1}, -- no choices
  ["crystal"] = {"Diamond Crystal", "", nil, 1}, -- no choices
  ["diamond"] = {"Diamond", "", nil, 5}, -- no choices
  ["LSD"] = {"LSD", "", nil, 5}, -- no choices
  ["Garbage"] = {"Garbage", "", nil, 1}, -- no choices
  ["acid"] = {"Lysergic Acid", "", nil, 1}, -- no choices
  ["litecoin"] = {"Litecoin", "", nil, 1}, -- no choices
  ["bitcoin"] = {"Bitcoin", "", nil, 1}, -- no choices
  ["body_armor"] = {"Level 4 Armour Plate", "", nil, 1}, -- no choices
  ["body_armor2"] = {"Level 2 Armour Plate", "", nil, 1}, -- no choices
  ["body_armor3"] = {"Level 1 Armour Plate", "", nil, 1}, -- no choices
  ["casino_token"] = {"Casino Tokens", "", nil, 0}, -- no choices
  ["morphine"] = {"Morphine", "", nil, 1}, -- [Morphine]
  ["lockpick"] = {"Lockpick", "", nil, 1}, -- [Morphine]
  
}

-- load more items function
local function load_item_pack(name)
  local items = module("cfg/item/"..name)
  if items then
    for k,v in pairs(items) do
      cfg.items[k] = v
    end
  else
    print("[vRP] item pack ["..name.."] not found")
  end
end

-- PACKS
load_item_pack("required")
load_item_pack("food")
load_item_pack("drugs")

return cfg
