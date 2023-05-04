police = {}
police.blipsenabled = false
police.perm = "police.armoury" -- player.phone is default for everyone
police.currency = "£"


police.guns = {
    {name = "Baton", price = 0, hash = "WEAPON_NIGHTSTICK"},
    {name = "Flashlight", price = 0, hash = "WEAPON_FLASHLIGHT"},
    {name = "Glock", price = 0, hash = "WEAPON_GLOCK"},
    {name = "Tazer", price = 0, hash = "WEAPON_STUNGUN"},
    {name = "Remington870", price = 0, hash = "WEAPON_REMINGTON870"},
    {name = "Speed Gun", price = 0, hash = "WEAPON_SPEEDGUN"},
}

police.gunshops = {
    vector3(461.52438354492,-979.44854736328,30.689321517944),
    vector3(1841.013671875,3691.3830566406,34.258209228516),
    vector3(-436.56024169922,5990.1010742188,31.716201782227),
    
} 
police.armourshops = {
    vector3(457.97039794922,-979.43762207031,30.68932723999),
    vector3(1844.5076904297,3691.4855957031,34.261531829834),
    vector3(-439.83660888672,5991.7954101563,31.716152191162),
} 

return police