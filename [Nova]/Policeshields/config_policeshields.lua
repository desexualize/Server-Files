main = {
    commandName = "shield",
    commandChatSuggestion = "Use a police shield",
    parameterType = "Shield Type", -- Use this to change to a different language
    acePermissionsEnabled = false, --If true, this enables ace permissions
}

translations = {
    noArguments = "~r~Error~w~: You must specify the shield type",
    invalidShieldType = "~r~Error~w~: You must specify the shield type",
    outsideVehicle = "~r~Error~w~: You must be outside a vehicle",
    shieldRemoved = "~g~Success~w~: Shield removed",
}

-- Shield Names must be one word for command usage
-- eg /shield ballistic

shields = {
    {
        name = "CTSFO",
        model = `prop_shield_one`,
        offSet = {-0.59, 0.29, 0.15},
        rotation = {0.16, 79.04, 41.39},
        boneIndex = 24818,
        collision = true,
        animDict = "combat@combat_reactions@pistol_1h_hillbilly",
        animName = "180",
    },
    {
        name = "Firearms",
        model = `prop_shield_two`,
        offSet = {-0.59, 0.29, 0.15},
        rotation = {0.16, 79.04, 41.39},
        boneIndex = 24818,
        collision = true,
        animDict = "combat@combat_reactions@pistol_1h_hillbilly",
        animName = "180",
    },
    {
        name = "Long",
        model = `prop_shield_three`,
        offSet = {-1.2, 0.31, -0.05},
        rotation = {1.0, 74.39, 41.39},
        boneIndex = 24818,
        collision = true,
        animDict = "combat@combat_reactions@pistol_1h_hillbilly",
        animName = "180",
    },
    {
        name = "Short",
        model = `prop_shield_four`,
        offSet = {-0.68, 0.22, 0.15},
        rotation = {0.52, 79.28, 41.39},
        boneIndex = 24818,
        collision = true,
        animDict = "combat@combat_reactions@pistol_1h_hillbilly",
        animName = "180",
    },
}