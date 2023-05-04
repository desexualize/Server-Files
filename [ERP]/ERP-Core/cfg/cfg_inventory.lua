
local cfg = {}

cfg.inventory_weight_per_strength = 50 -- weight for an user inventory per strength level (no unit, but thinking in "kg" is a good norm)

-- default chest weight for vehicle trunks
cfg.default_vehicle_chest_weight = 30

-- define vehicle chest weight by model in lower case
cfg.vehicle_chest_weights = {
  ["octane"] = 200,
}

return cfg