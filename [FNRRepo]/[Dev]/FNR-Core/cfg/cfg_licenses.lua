local cfg = {}

cfg.licenseShopLocation = vector3(-551.29016113281,-191.68428039551,38.223087310791)
cfg.casinolicenseShopLocation = vector3(1088.1428222656,218.88032531738,-49.200359344482)

cfg.licenses = {
    {name = "VIP", group = "VIP"},
    {name = "Gang License", group = "Gang", price = 500000, type = "other"},      
    {name = "Advanced Rebel", group = "AdvancedRebel", price  = 10000000, type = "other"},   
    {name = "High Roller", group = "HighRoller", price  = 20000000, type = "casino"},
    {name = "Rebel License", group = "Rebel", price = 5000000 , type = "other"}, -- 15000000
    {name = "Scrap Job", group = "Scrap Job", price = 50000, type = "grinding"},
    {name = "Weed", group = "Weed", price = 300000, type = "grinding"},
    {name = "Iron Job", group = "Iron", price = 500000, type = "grinding"},
    {name = "Cocaine", group = "Cocaine", price = 0, type = "grinding"}, -- 750000
    {name = "Heroin", group = "Heroin", price = 10000000, type = "grinding"}, 
    {name = "Diamond", group = "Diamond", price = 15000000, type = "grinding"},
    {name = "LSD", group = "LSD", price = 50000000, type = "grinding"},

}

return cfg