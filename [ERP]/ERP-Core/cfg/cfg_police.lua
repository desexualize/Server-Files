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
}

police.gunshops = {
    vector3(442.40029907227,-987.96990966797,34.297336578369), -- mission row
    vector3(-448.63012695312,6021.5864257812,31.755352020264), -- paleto
--  vector3(), -- sandy
} 

return police