bronze = {}
bronze.perm = "player.phone" -- player.phone is default for everyone
bronze.currency = "£"

-- This is very important. The gunshops must go in order!
-- {x,y,z, heading}
bronze.gunshops = {
    [0] = { -- 939.33740234375,2973.0231933594,39.329936981201
        ped = {-1111.2548828125,4937.345703125,218.38697814941},
        marker = {-1111.2548828125,4937.345703125,218.38697814941}, 
    },
} 

bronze.guns = {
    {name = "Winchester", price = 400000, hash = "WEAPON_WINCHESTER12"},
    {name = "SCAR-H", price = 800000, hash = "WEAPON_SCAR"},
    {name = "AK-KAL", price = 700000, hash = "WEAPON_akkal"},
    {name = "PPSH", price = 400000, hash = "WEAPON_PPSH"},
    {name = "Mosin Nagant", price = 900000, hash = "WEAPON_MOSIN"},
    {name = "SVD Sniper", price = 3000000, hash = "WEAPON_SNIPERRIFLE"},
    {name = "Assult Rifle", price = 1000000, hash = "WEAPON_ASSAULTRIFLE_MK2"},
}

return bronze