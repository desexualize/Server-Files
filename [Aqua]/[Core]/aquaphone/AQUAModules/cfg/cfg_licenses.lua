local cfg = {}

cfg.licenseShopLocation = vector3(-551.29016113281,-191.68428039551,38.223087310791)
cfg.casinolicenseShopLocation = vector3(1088.1428222656,218.88032531738,-49.200359344482)

cfg.licenses = {
    {name = "Scrap Job", group = "Scrap Job", price = 250000, type = "grinding", profit = 2000},
    {name = "Iron", group = "Iron", price = 1000000, type = "grinding", profit = 3000},
    {name = "Gold", group = "GoldJob", price = 5000000, type = "grinding", profit = 10000},
    {name = "Diamond", group = "DiamondJob", price = 10000000, type = "grinding", profit = 20000},
    {name = "High Roller", group = "HighRoller", price = 10000000, type = "casino", profit = 0},
}
cfg.ilegallicenses = {
    {name = "Weed", group = "Weed", price = 500000, type = "grinding", profit = 5000},
    {name = "Cocaine", group = "Cocaine", price = 2500000, type = "grinding", profit = 3000}, 
    {name = "Heroin", group = "Heroin", price = 7000000, type = "grinding", profit = 25000}, 
    {name = "LSD", group = "LSD", price = 50000000, type = "grinding", profit = 130000},
}
    cfg.illegal = {
    {name = "Gang License", group = "Gang", price = 750000, type = "other"},      
    {name = "Advanced Rebel", group = "AdvancedRebel", price  = 10000000, type = "other"},   
    {name = "Rebel License", group = "Rebel", price = 15000000, type = "other"}, -- 15000000
}
    cfg.refundlicenese = {
        {name = "Scrap Job", group = "Scrap Job", price = 250000, type = "grinding", refund = 65000},
        {name = "Iron", group = "Iron", price = 1000000, type = "grinding", refund = 250000},
        {name = "Gold", group = "GoldJob", price = 5000000, type = "grinding", refund = 1250000},
        {name = "Diamond", group = "DiamondJob", price = 10000000, type = "grinding", refund = 2500000},
        {name = "Weed", group = "Weed", price = 500000, type = "grinding", refund = 125000},
        {name = "Cocaine", group = "Cocaine", price = 2500000, type = "grinding", refund = 650000}, 
        {name = "Heroin", group = "Heroin", price = 7000000, type = "grinding", refund = 1750000}, 
        {name = "LSD", group = "LSD", price = 50000000, type = "grinding", refund = 12500000},
    }
return cfg