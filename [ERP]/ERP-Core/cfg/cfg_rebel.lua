large = {}
large.perm = "player.phone" -- player.phone is default for everyone
large.currency = "£"

-- This is very important. The gunshops must go in order!
-- {x,y,z, heading}
large.gunshops = {
    [0] = { -- 939.33740234375,2973.0231933594,39.329936981201
        ped = {1545.2042236328,6332.3295898438,24.078683853149},
        marker = {1545.2042236328,6332.3295898438,24.078683853149}, 
    },
} 

large.guns = {
    {name = "AK200", price = 550000, hash = "WEAPON_AK200"},
    {name = "M4A1", price = 700000, hash = "WEAPON_M4A1"},
    {name = "Spar16", price = 750000, hash = "WEAPON_SPAR16"},
    {name = "SVD", price = 1500000, hash = "WEAPON_SVD"},
    {name = "Mosin Nagant", price = 800000, hash = "WEAPON_MOSIN"},
}

return large