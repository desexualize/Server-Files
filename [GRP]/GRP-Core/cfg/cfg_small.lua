smallarms = {}
smallarms.blipsenabled = false
smallarms.perm = "player.phone" -- player.phone is default for everyone
smallarms.currency = "£"

-- This is very important. The gunshops must go in order!
-- {x,y,z, heading}
smallarms.gunshops = {
    [0] = { -- Paleto Bay
        ped = {1129.5141601562,-2004.74609375,36.19766998291},
        marker = {1129.5141601562,-2004.74609375,36.19766998291},
    },
} 

smallarms.guns = {
    smallarms = {
        {name = "M1911", price = 60000, hash = "WEAPON_M1911"},
        {name = "FNP", price = 70000, hash = "WEAPON_FNP"},
        {name = "Glock 17", price = 150000, hash = "WEAPON_Glock17"},

    }
}

return smallarms