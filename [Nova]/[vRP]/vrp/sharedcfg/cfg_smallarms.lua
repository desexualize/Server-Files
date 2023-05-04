local config = {}

config.blip_sprite = 110
config.blip_colour = 1
config.blip_scale = 0.8
config.blip_display = 2
config.blip_short_range = true

config.marker_type = 27
config.marker_range = 40
config.menu_range = 1
config.menu_open_key = 38

config.weapons = {
    ['M1911'] = {name = "M1911", price = 60000, hash = "WEAPON_M1911"},
    ['FNP'] = {name = "FNP", price = 70000, hash = "WEAPON_FNP"},
    ['Glock 17'] =  {name = "Glock 17", price = 150000, hash = "WEAPON_GLOCK17"},
}

config.armour = {
    ['25%'] = {name = '25% Armour', price = 25000, value = 25},
    ['50%'] = {name = '50% Armour', price = 50000, value = 50},
}

config.locations = {
    ['Recycling Plant'] = {
        position = vector3(-612.99401855469, -1624.1273193359, 33.010540008545),
        weapons = {
            config.weapons['M1911'],
            config.weapons['FNP'],
            config.weapons['Glock 17'],
        },
        armour = {
            config.armour['25%'],
            config.armour['50%'],
        }
    },

    ['Meat Factory'] = {
        position = vector3(977.11944580078, -2112.982421875, 30.483768463135),
        weapons = {
            config.weapons['M1911'],
            config.weapons['FNP'],
            config.weapons['Glock 17'],
        },
        armour = {
            config.armour['25%'],
            config.armour['50%'],
        }
    },

    ['Port Rooftop'] = {
        position = vector3(228.10188293457, -3227.2265625, 40.53556060791),
        weapons = {
            config.weapons['M1911'],
            config.weapons['FNP'],
            config.weapons['Glock 17'],
        },
        armour = {
            config.armour['25%'],
            config.armour['50%'],
        }
    },

    ['Cargo Ship'] = {
        position = vector3(-230.9328918457, -2364.3681640625, 25.330350875854),
        weapons = {
            config.weapons['M1911'],
            config.weapons['FNP'],
            config.weapons['Glock 17'],
        },
        armour = {
            config.armour['25%'],
            config.armour['50%'],
        }
    },

    ['Sandy Ranch'] = {
        position = vector3(2432.4233398438, 4966.0546875, 46.821556091309),
        weapons = {
            config.weapons['M1911'],
            config.weapons['FNP'],
            config.weapons['Glock 17'],
        },
        armour = {
            config.armour['25%'],
            config.armour['50%'],
        }
    },
}

config.Get_Weapon_Info = function(weapon_detail)
    for weapon_name, weapon_info in pairs(config.weapons) do
        if weapon_name == weapon_detail or weapon_info.name == weapon_detail or weapon_info.hash == weapon_detail then
            return weapon_info
        end
    end
    return false
end

config.Get_Armour_Info = function(armour_detail)
    for armour_percentage, armour_info in pairs(config.armour) do
        if armour_percentage == armour_detail or armour_info.name == armour_detail then
            return armour_info
        end
    end
    return false
end

return config