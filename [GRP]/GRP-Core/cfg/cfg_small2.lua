small2 = {}
small2.blipsenabled = false
small2.perm = "player.phone" -- player.phone is default for everyone
small2.currency = "£"

-- This is very important. The gunshops must go in order!
-- {x,y,z, heading}
small2.gunshops = {
    [0] = { -- Paleto Bay
        ped = {1539.0395507812,3594.9516601562,38.766529083252},
        marker = {1539.0395507812,3594.9516601562,38.766529083252},
    },
} 

small2.guns = {
''    smallarms = {
        {name = "M1911", price = 60000, hash = "WEAPON_M1911"},
        {name = "FNP", price = 70000, hash = "WEAPON_FNP"},
        {name = "Glock 17", price = 150000, hash = "WEAPON_Glock17"},


    },
}

return small2