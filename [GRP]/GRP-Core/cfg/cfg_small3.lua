small3 = {}
small3.blipsenabled = false
small3.perm = "player.phone" -- player.phone is default for everyone
small3.currency = "£"

-- This is very important. The gunshops must go in order!
-- {x,y,z, heading}
small3.gunshops = {
    [0] = { -- Paleto Bay
        ped = {-594.43292236328,225.74891662598,74.150489807129},
        marker = {-594.43292236328,225.74891662598,74.150489807129},
    },
} 

small3.guns = {
    smallarms = {
        {name = "M1911", price = 60000, hash = "WEAPON_M1911"},
        {name = "FNP", price = 70000, hash = "WEAPON_FNP"},
        {name = "Glock 17", price = 150000, hash = "WEAPON_Glock17"},


    }
}

return small3