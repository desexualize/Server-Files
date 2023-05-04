knife = {}
knife.blipsenabled = false
knife.perm = "player.phone" -- player.phone is default for everyone
knife.currency = "£"

-- This is very important. The gunshops must go in order!
-- {x,y,z, heading}
knife.coords = vector3(711.10620117188,-964.30639648438,30.39533996582)
knife.marker = vector3(711.10620117188,-964.30639648438,30.39533996582-1)

knife.knives = {
    {name = "Knife", price = 200, hash = "WEAPON_KNIFE"},
    --{name = "Bat", price = 200, hash = "WEAPON_BAT"},
   -- {name = "Hatchet", price = 500, hash = "WEAPON_Hatchet"},
    --{name = "Hammer", price = 100, hash = "WEAPON_Hammer"},
}

return knife