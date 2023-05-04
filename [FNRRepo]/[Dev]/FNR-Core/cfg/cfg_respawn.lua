respawn = {}

respawn.freeze = true -- [Freeze when Menu is Opened]
respawn.close = false -- [When Pressing Back Space it closes menu and unfreezes player]

respawn.coords = vector3(341.83953857422,-1397.6486816406,32.509239196777) -- [Coordinate of were you pull out the menu]
 
respawn.hospitals = {
    ["St Thomas Hospital"] = {
        location = vector3(360.82, -591.43, 28.66),
    },
    ["Paleto Hospital"] = {
        location = vector3(-244.62612915039, 6328.8041992188, 32.426197052002),
    },
    ["Royal London Hospital"] = {
        location = vector3(338.02813720703,-1393.8375244141,32.509239196777),
    },
    ["Sandy Hospital"] = {
        location = vector3(1841.5405273438, 3668.8037109375, 33.679920196533),
    },
}

respawn.rebel = {
    ["~r~[Rebel Diner]"] = {
        location = vector3(1572.0604248047,6444.8408203125,24.445825576782),
    },
}
respawn.vip = {
    ["~y~[VIP Island]"] = {
        location = vector3(-2167.3876953125,5180.6889648438,15.467968940735),
    },
}
respawn.pd = {
    ["~b~[Mission Row PD]"] = {
        location = vector3(446.32061767578,-982.93200683594,30.689336776733),
    },
}
respawn.pd1 = {
    ["~b~[Paleto PD]"] = {
        location = vector3(-436.24124145508,6022.7788085938,31.490102767944),
    },
}
respawn.pd2 = {
    ["~b~[Sandy PD]"] = {
        location = vector3(1853.2856445313,3686.7746582031,34.2594871521),
    },
}


return respawn