
local cfg = {}

-- define market types like garages and weapons
-- _config: blipid, blipcolor, permissions (optional, only users with the permission will have access to the market)

cfg.market_types = {
  ["food"] = {
    _config = {blipid=52, blipcolor=2},

    -- list itemid => price
    -- Drinks
    ["bag"] = 30,
    ["milk"] = 20,
    ["water"] = 20,
    ["coffee"] = 40,
    ["tea"] = 40,
    ["icetea"] = 80,
    ["orangejuice"] = 80,
    ["cocacola"] = 120,
    ["redbull"] = 120,
    ["lemonade"] = 140,
    ["vodka"] = 300,

    --Food
    ["bread"] = 20,
    ["donut"] = 20,
    ["tacos"] = 80,
    ["sandwich"] = 200,
    ["kebab"] = 200,
    ["pdonut"] = 650,
  },
  --["drugstore"] = {
  --  _config = {blipid=51, blipcolor=2},
  --  ["pills"] = 500
  --},
  ["emergencyloadout"] = {
    _config = {blipid=51, blipcolor=68, permissions={"emergency.market"}},
    ["medkit"] = 0,
    ["pills"] = 0
  },
  ["plantation"] = {
    _config = {blipid=473, blipcolor=4, permissions={"drugseller.market"}},
--    ["seeds"] = 500,
	["benzoilmetilecgonina"] = 800,
	["harness"] = 1000
  },
  ["tools"] = {
    _config = {blipid=402, blipcolor=47, permissions={"repair.market"}},
    ["repairkit"] = 50
  }
}

-- list of markets {type,x,y,z}

cfg.markets = {

}

return cfg
