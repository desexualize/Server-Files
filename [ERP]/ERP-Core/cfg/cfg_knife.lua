knife = {}
knife.blipsenabled = false
knife.perm = "player.phone" -- player.phone is default for everyone
knife.currency = "£"

-- This is very important. The gunshops must go in order!
-- {x,y,z, heading}
knife.coords = vector3(711.10620117188,-964.30639648438,30.39533996582)
knife.marker = vector3(711.10620117188,-964.30639648438,30.39533996582-1)

knife.knives = {
    {name = "Axe", price = 2000, hash = "WEAPON_AXE"},
    {name = "Baseball Bat", price = 2000, hash = "WEAPON_BASEBALLBAT"},
    {name = "Broom", price = 5000, hash = "WEAPON_BROOM"},
    {name = "Diamond Sword", price = 8000, hash = "WEAPON_DIAMONDSWORD"},
    {name = "Shank", price = 500, hash = "WEAPON_SHANK"},
    {name = "Dildo", price = 10000, hash = "WEAPON_DILDO"},
    {name = "Shovel", price = 1000, hash = "WEAPON_SHOVEL"},
}

return knife