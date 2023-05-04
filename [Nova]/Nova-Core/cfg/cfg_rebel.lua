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
    {name = "AK-74U", price = 700000, hash = "WEAPON_CHUCKY"},
    {name = "AUG", price = 825000, hash = "WEAPON_AUG"},
    {name = "Carbine Mk3", price = 825000, hash = "WEAPON_CarbineMk3"},
    {name = "Mosin Nagant", price = 900000, hash = "WEAPON_MOSIN"},
    {name = "Sniper", price = 3000000, hash = "WEAPON_SNIPERRIFLE"},
}

return large