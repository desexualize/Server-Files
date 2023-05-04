VIP = {}
VIP.blipsenabled = false
VIP.perm = "vip.guns" -- player.phone is default for everyone
VIP.currency = "£"

-- This is very important. The gunshops must go in order!
-- {x,y,z, heading}
VIP.coords = vector3(-2166.4768066406,5198.3999023438,16.880395889282)
VIP.marker = vector3(-2166.4768066406,5198.3999023438,16.880395889282-1)

VIP.guns = {
    VIP = {

        {name = "Assault Rifle  ~y~[Rifle]", price = 400000, hash = "WEAPON_ASSAULTRIFLE"},
        {name = "Snow Ball ~y~[x10]", price = 2000, hash = "WEAPON_SNOWBALL"},


    }
}

return VIP