local cfg = {}

cfg.licenseShopLocation = vector3(-550.9577, -192.2513, 38.22311)
cfg.casinolicenseShopLocation = vector3(1088.4821777344,219.38232421875,-49.200370788574)

cfg.licenses = {
    {name = "VIP", group = "VIP"},
 
    {name = "Gang License", group = "Gang", price = 1000000, type = "other"},      
    {name = "Advanced Rebel", group = "AdvancedRebel", price  = 10000000, type = "other"},   
    {name = "High Roller", group = "HighRoller", price  = 10000000, type = "casino"},
    {name = "Rebel License", group = "Rebel", price = 20000000, type = "other"},
    
    {name = "Scrap Job", group = "Scrap Job", price = 50000, type = "grinding"},
    {name = "Weed", group = "Weed", price = 300000, type = "grinding"},
    {name = "Iron Job", group = "Iron", price = 500000, type = "grinding"},
    {name = "Cocaine", group = "Cocaine", price = 750000, type = "grinding"},
    {name = "Heroin", group = "Heroin", price = 10000000, type = "grinding"}, 
    {name = "Diamond", group = "Diamond", price = 15000000, type = "grinding"},
    {name = "LSD", group = "LSD", price = 40000000, type = "grinding"},

}

return cfg