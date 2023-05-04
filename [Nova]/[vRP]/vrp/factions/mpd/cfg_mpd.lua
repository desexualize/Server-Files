local config = {}

config.keep_flash_light_while_moving = true

config.police_ammo_count = 250
config.small_arms_weapons = {
    ['WEAPON_FLASHLIGHT'] = {name = "Flashlight", price = 0, hash = "WEAPON_FLASHLIGHT"},
    ['WEAPON_NIGHTSTICK'] = {name = "Nightstick", price = 0, hash = "WEAPON_NIGHTSTICK"},
    ['WEAPON_STUNGUN'] = {name = "Tazer", price = 0, hash = "WEAPON_STUNGUN"},
    ['WEAPON_GLOCK17'] = {name = "Glock-17", price = 0, hash = "WEAPON_GLOCK17"},
    ['WEAPON_PUMPSHOTGUN'] = {name = "Pump Shotgun", price = 0, hash = "WEAPON_PUMPSHOTGUN"},
}

config.large_arms_weapons = {
    ['WEAPON_SMOKEGRENADE'] = {name = "Tear Gas", price = 0, hash = "WEAPON_SMOKEGRENADE"},
    ['WEAPON_MP5'] = {name = "MP5", price = 0, hash = "WEAPON_MP5"},
    ['WEAPON_M4A1'] = {name = "M4A1", price = 0, hash = "WEAPON_M4A1"},
    ['WEAPON_G36K'] = {name = "G36K", price = 0, hash = "WEAPON_G36K"},
    ['WEAPON_MCX'] = {name = "MCX", price = 0, hash = "WEAPON_MCX"},
    ['WEAPON_REMINGTON_700'] = {name = "Remington 700", price = 0, hash = "WEAPON_REMINGTON_700"},
    
}

config.rank_allow_listed_weapons = {
    ['Police Constable Clocked'] = {
        'WEAPON_FLASHLIGHT',
        'WEAPON_NIGHTSTICK',
        'WEAPON_STUNGUN',
        'WEAPON_GLOCK17',
    },

    ['PCSO Clocked'] = {
        'WEAPON_FLASHLIGHT',
        'WEAPON_NIGHTSTICK',
        'WEAPON_STUNGUN',
    },

    ['MPD Needs Training Clocked'] = {
        'WEAPON_FLASHLIGHT',
        'WEAPON_NIGHTSTICK',
    },
}

config.item_shop = {
    ['armour_locker'] = {
        ['Mission Row'] = {
            x = 458.56655883789, y = -979.75170898438, z = 30.68931388855,
            marker_type = 20, r = 0, g = 50, b = 128, a = 150,
            range = 1.5, item_type = 'armour', --menu_name = 'main', 
        },

        ['Sandy Shores'] = {
            x = 1849.4716796875, y = 3687.1711425781, z = 34.26700592041,
            marker_type = 20, r = 0, g = 50, b = 128, a = 150,
            range = 1.5, item_type = 'armour', --menu_name = 'main', 
        },

        ['Paleto Bay'] = {
            x = -447.47332763672, y = 6014.1723632812, z = 31.716360092163,
            marker_type = 20, r = 0, g = 50, b = 128, a = 150,
            range = 1.5, item_type = 'armour', --menu_name = 'main', 
        },

        ['Vespucci'] = {
            x = -1105.7322998047, y = -822.84399414062, z = 14.282780647278,
            marker_type = 20, r = 0, g = 50, b = 128, a = 150,
            range = 1.5, item_type = 'armour', --menu_name = 'main', 
        }
    },

    ['small_arms'] = {
        ['Mission Row'] = {
            x = 461.54306030273, y = -979.70831298828, z = 30.689298629761 - 0.9,
            marker_type = 27, r = 255, g = 0, b = 0, a = 150,
            range = 1.5, item_type = 'weapon', menu_name = 'small_arms',
        },
        
        ['Sandy Shores'] = {
            x = 1847.68359375, y = 3689.7531738281, z = 34.267009735107 - 0.9,
            marker_type = 27, r = 255, g = 0, b = 0, a = 150,
            range = 1.5, item_type = 'weapon', menu_name = 'small_arms',
        },

        ['Paleto Bay'] = {
            x = -448.99975585938, y = 6015.7416992188, z = 31.716360092163 - 0.9,
            marker_type = 27, r = 255, g = 0, b = 0, a = 150,
            range = 1.5, item_type = 'weapon', menu_name = 'small_arms',
        },

        ['Vespucci'] = {
            x = -1104.3432617188, y = -821.83917236328, z = 14.282788276672 - 0.9,
            marker_type = 27, r = 255, g = 0, b = 0, a = 150,
            range = 1.5, item_type = 'weapon', menu_name = 'small_arms',
        }
    },

    ['large_arms'] = {
        ['Mission Row'] = {
            x = 461.46923828125, y = -982.62707519531, z = 30.68931388855 - 0.9,
            marker_type = 27, r = 255, g = 0, b = 0, a = 150,
            range = 1.5, item_type = 'weapon', menu_name = 'large_arms',
        },

        ['Sandy Shores'] = {
            x = 1849.6092529297, y = 3690.8381347656, z= 34.267013549805 - 0.9,
            marker_type = 27, r = 255, g = 0, b = 0, a = 150,
            range = 1.5, item_type = 'weapon', menu_name = 'large_arms',
        },

        ['Paleto Bay'] = {
            x = -450.45651245117, y = 6017.2182617188, z = 31.716360092163 - 0.9,
            marker_type = 27, r = 255, g = 0, b = 0, a = 150,
            range = 1.5, item_type = 'weapon', menu_name = 'large_arms',
        },

        ['Vespucci'] = {
            x = -1102.8857421875, y = -820.78747558594, z = 14.282781600952 - 0.9,
            marker_type = 27, r = 255, g = 0, b = 0, a = 150,
            range = 1.5, item_type = 'weapon', menu_name = 'large_arms',
        }
    },
}

config.armour_by_rank = {
    [100] = {
        -- Gold Command
        'Commissioner Clocked',
        'Deputy Commissioner Clocked',
        'Assistant Commissioner Clocked',
        'Deputy Assistant Commissioner Clocked',
        'Commander Clocked',

        -- Silver Command
        'Chief Superintendent Clocked',
        'Superintendent Clocked',

        -- Bronze Command
        'Chief Inspector Clocked',

        -- Other Ranks
        'Officer of the week Clocked',
        'Special Constable Clocked',
        'SCO-19',

        -- Normal Ranks
        'Inspector Clocked',
    },

    [75] = {
        'Sergeant Clocked',
    },

    [50] = {
        'Senior Constable Clocked',
    },

    [25] = {
        'Police Constable Clocked',
    },

    [0] = {
        'PCSO Clocked',
        'MPD Needs Training Clocked',
    },
}

config.armour_purchased_message = {
    [0] = '~r~You don\'t get armour lol',
    [25] = '~g~Getting scrapped 25 armour',
    [50] = '~g~Your armour is a decent 50',
    [75] = '~g~Armour is getting better at 75',
    [100] = '~g~Alpha armour here at 100',
}

config.pcs = {
    {1853.21, 3689.51, 34.2671},
    {442.030609130859, -978.72705078125, 30.6896057128906},
    {-448.97076416016, 6012.4208984375, 31.71639251709},
}
  
-- vehicle tracking configuration
config.trackveh = {
    min_time = 300, -- min time in seconds
    max_time = 600, -- max time in seconds
    service = "police",  -- service to alert when the tracking is successful
    "SWAT",
    "sheriff",
    "highway",
    "trafficguard",
    "Chief",
    "Commander",
    "Lieutenant",
    "Detective",
    "Sergeant",
    "Deputy",
    "Bounty",
    "Dispatch",
}
  
-- wanted display
config.wanted = {
    blipid = 458,
    blipcolor = 38,
    service = "police",
    "SWAT",
    "sheriff",
    "highway",
    "trafficguard",
    "Chief",
    "Dispatch",
    "Commander",
    "Lieutenant",
    "Detective",
    "Deputy",
    "Bounty",
    "Sergeant",
}

-- illegal items (seize)
config.seizable_items = {
    "dirty_money",
    "cocaine",
    "lsd",
    "seeds",
    "harness",
    "credit",
    "weed",
    "M4A1",
    "AK47",
    "fake_id",
    "driver",
}

-- jails {x,y,z,radius}
config.jails = {
    {459.485870361328, -1001.61560058594, 24.914867401123, 2.1},
    {459.305603027344, -997.873718261719, 24.914867401123, 2.1},
    {459.999938964844, -994.331298828125, 24.9148578643799, 1.6},
}

-- fines
-- map of name -> money
config.fines = {
    ["Insult"] = 100,
    ["Speeding"] = 250,
    ["Red Light"] = 250,
    ["Stealing"] = 1000,
    ["Credit Cards - Per Card"] = 1000,
    ["Drugs - Per Drug"] = 2000,
    ["Dirty Money - Per $1000"] = 1500,
    ["Organized crime (low)"] = 10000,
    ["Organized crime (medium)"] = 25000,
    ["Organized crime (high)"] = 50000,
}

return config