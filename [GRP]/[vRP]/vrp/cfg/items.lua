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
  ["scrap"] = {"Fixed Scrap", "", nil, 5}, -- no choices
  ["acid"] = {"Lysergic Acid", "", nil, 1}, -- no choices
  ["ironore"] = {"Iron Ore", "", nil, 1}, -- no choices
  ["iron"] = {"Iron", "", nil, 5}, -- no choices
  ["body_armor"] = {"1Level 4 Armour Plate", "", nil, 5}, -- no choices
  ["body_armor2"] = {"Level 2 Armour Plate", "", nil, 5}, -- no choices
  ["body_armor3"] = {"Level 1 Armour Plate", "", nil, 5}, -- no choices

  -- [Drops]
  ["drop1"] = {"Common Drop", "", nil, 5}, -- [Common Drop]
  ["drop2"] = {"Rare Drop", "", nil, 5}, -- [Rare Drop]
  ["drop3"] = {"Epic Drop", "", nil, 5}, -- [Epic Drop]
  ["drop4"] = {"Unique Drop", "", nil, 5}, -- [Unique Drop]
  ["drop5"] = {"Legendary Drop", "", nil, 5}, -- [Legendary Drop]

  ["morphine"] = {"Morphine", "", nil, 5}, -- [Morphine]
  ["lockpick"] = {"Lockpick", "", nil, 5}, -- [Morphine]
  
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
