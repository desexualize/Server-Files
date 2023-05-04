bronze = {}
bronze.perm = "player.phone" -- player.phone is default for everyone
bronze.currency = "£"

-- This is very important. The gunshops must go in order!
-- {x,y,z, heading}
bronze.gunshops = {
    [0] = {
        ped = {-1111.2548828125,4937.345703125,218.38697814941},
        marker = {-1111.2548828125,4937.345703125,218.38697814941}, 
    },
} 

bronze.guns = {
    {name = "AK47", price = 500000, hash = "WEAPON_AK47"},
    {name = "UZI", price = 300000, hash = "WEAPON_UZI"},
    {name = "WINCHESTER-12", price = 400000, hash = "WEAPON_WINCHESTER12"},
    {name = "Mosin Nagant", price = 800000, hash = "WEAPON_MOSIN"},
}

return bronze