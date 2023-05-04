
local cfg = {}

cfg.inventory_weight_per_strength = 50 -- weight for an user inventory per strength level (no unit, but thinking in "kg" is a good norm)

-- default chest weight for vehicle trunks
cfg.default_vehicle_chest_weight = 30

-- define vehicle chest weight by model in lower case
cfg.vehicle_chest_weights = {

  ["sly"] = 300,
  ["pony2"] = 200,
  ["h2010"] = 300,
  ["hilux1"] = 300,
  ["snowhawk"] = 125,
  ["polar06seirra"] = 175,
  ["eurocargo"] = 300,
  ["speedo2"] = 300,
  ["camper"] = 300,
  ["royalmail"] = 300,
  ["bison3"] = 300,
  ["journey"] = 300,
  ["burrito"] = 300,
  ["taco"] = 300,
  ["silv86"] = 200,
  ["che1950ez"] = 300,
  ["f350offroadspec"] = 300


}

return cfg

