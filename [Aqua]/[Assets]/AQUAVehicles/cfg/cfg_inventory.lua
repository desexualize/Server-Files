
local cfg = {}

cfg.inventory_weight_per_strength = 30 -- weight for an user inventory per strength level (no unit, but thinking in "kg" is a good norm)

-- default chest weight for vehicle trunks
cfg.default_vehicle_chest_weight = 50

-- define vehicle chest weight by model in lower case
cfg.vehicle_chest_weights = {
  ["nissantitan17"] = 200,
  ["expertpeug"] = 300,
  ["vito"] = 300,
  ["sprinter2019"] = 300,
  ["polisheli"] = 200,
  ["nh90"] = 200,
  ["fordrat"] = 300,
  ["Z1000"] = 300,
  ["harleybobber"] = 300,
  ["harleyfatboy"] = 300,
  ["mache"] = 150,
  ["sprinter2020"] =200,
 
--{{founders/Management}}


--{{end of founders/Management}}
--{{dealership}}
["xgcp"] = 75,
["rrs08"] = 75,
["cayenneturbo"] = 75,
["03ramk"] = 100,
["issio"] = 100,
["dongfeng140"] = 100,


--{{end of dealership}}

--{{VIP}}  
["littlebird"] = 200,


--{{END OF VIP}}
--{{LOCKS}}
["ccgt"] = 50000,

--{{END OF LOCKS}}

--{{rewards/jobs}}



--{{END OF rewards/jobs}}
}
return cfg
