rebel = {}
adrebel = {}

rebel.perm = "rebel.guns"
rebel.fullarmourprice = 100000

rebel.gunshops = {
    vector3(1544.6004638672,6331.302734375,24.07769203186),
    vector3(4924.8603515625,-5243.7426757813,2.5237331390381),
}


rebel.guns = {
    {name = "AK200", price = 700000, hash = "WEAPON_AK200"},
    -- {name = "M16A1", price = 750000, hash = "WEAPON_M16A1"},
    {name = "MXM", price = 750000, hash = "WEAPON_MXM"}, 
    {name = "Parachute", price = 25000, hash = "GADGET_PARACHUTE"},
    -- {name = "M4A1", price = 800000, hash = "WEAPON_M4A1"},
    {name = "MXC", price = 750000, hash = "WEAPON_MXC"},  
    
}

adrebel.guns = {
    
    {name = "Spar-16", price = 750000, hash = "WEAPON_SPAR16"}, 
    {name = "MK1-EMR", price = 750000, hash = "WEAPON_MK1EMR"},
    {name = "Dragunov SVD", price = 4000000, hash = "WEAPON_SVD"},
}

rebel.items = {

    {name = "Heavy Armour Plate", price = 100000, itemID = "heavyarmour"},
   
}
return rebel