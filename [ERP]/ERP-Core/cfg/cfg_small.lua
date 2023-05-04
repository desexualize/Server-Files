smallarms = {}
smallarms.blipsenabled = false
smallarms.perm = "player.phone" -- player.phone is default for everyone
smallarms.currency = "£"

-- This is very important. The gunshops must go in order!
-- {x,y,z, heading}
smallarms.gunshops = {
    [0] = { -- Casino Small
        ped = {1242.8059082031,-426.96542358398,68.91535949707},
        marker = {1242.8059082031,-426.96542358398,68.91535949707},
    },
} 

smallarms.guns = {
    smallarms = {
        {name = "M1911", price = 70000, hash = "WEAPON_M1911"},
        {name = "Rook 40", price = 70000, hash = "WEAPON_ROOK"},
        {name = "Revolver 357", price = 60000, hash = "WEAPON_REVOLVER357"},
        {name = "Tec-9", price = 50000, hash = "WEAPON_TEC9"},
        {name = "UMP45", price = 150000, hash = "WEAPON_UMP45"},
    }
}

return smallarms