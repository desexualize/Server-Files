small2 = {}
small2.blipsenabled = false
small2.perm = "player.phone" -- player.phone is default for everyone
small2.currency = "£"

-- This is very important. The gunshops must go in order!
-- {x,y,z, heading}
small2.gunshops = {
    [0] = { -- Sandy Small
        ped = {2434.2419433594,4968.484375,42.347618103027},
        marker = {2434.2419433594,4968.484375,42.347618103027},
    },
} 

small2.guns = {
    smallarms = {
        {name = "M1911", price = 70000, hash = "WEAPON_M1911"},
        {name = "Rook 40", price = 70000, hash = "WEAPON_ROOK"},
        {name = "Revolver 357", price = 60000, hash = "WEAPON_REVOLVER357"},
        {name = "Tec-9", price = 50000, hash = "WEAPON_TEC9"},
        {name = "UMP45", price = 150000, hash = "WEAPON_UMP45"},
    }
}

return small2