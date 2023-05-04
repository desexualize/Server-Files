vip = {}
vip.perm = "player.phone" -- player.phone is default for everyone
vip.currency = "£"

-- This is very important. The gunshops must go in order!
-- {x,y,z, heading}
vip.gunshops = {
    [0] = { -- 939.33740234375,2973.0231933594,39.329936981201
        ped = {-2166.4768066406,5198.3999023438,16.880395889282},
        marker = {-2166.4768066406,5198.3999023438,16.880395889282-1}, 
    },
} 

vip.guns = {
    {name = "AK-74 Kashnar  ", price = 550000, hash = "WEAPON_AK74KASHNAR"},
    {name = "Mosin Nagant  ", price = 800000, hash = "WEAPON_MOSIN"},
}

return large