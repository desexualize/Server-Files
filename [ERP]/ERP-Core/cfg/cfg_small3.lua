small3 = {}
small3.blipsenabled = false
small3.perm = "player.phone" -- player.phone is default for everyone
small3.currency = "£"

-- This is very important. The gunshops must go in order!
-- {x,y,z, heading}
small3.gunshops = {
    [0] = { -- City Small
        ped = {-1500.0544433594,-216.84588623047,47.889381408691},
        marker = {-1500.0544433594,-216.84588623047,47.889381408691},
    },
} 

small3.guns = {
    smallarms = {
        {name = "M1911", price = 70000, hash = "WEAPON_M1911"},
        {name = "Rook 40", price = 70000, hash = "WEAPON_ROOK"},
        {name = "Revolver 357", price = 60000, hash = "WEAPON_REVOLVER357"},
        {name = "Tec-9", price = 50000, hash = "WEAPON_TEC9"},
        {name = "UMP45", price = 150000, hash = "WEAPON_UMP45"},
    }
}

return small3