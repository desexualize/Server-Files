main = {
    commandName = "watermonitor",
    acePermissionsEnabled = false,
    monitorModel = `prop_water_monitor`,
    usageDistance = 5.0, -- Distance to turn it on/off
    pitchDistance = 5.0, -- Must be 2m away to adjust the pitch (leave this recommended)
    toggleKey = {0, 38}, -- https://docs.fivem.net/docs/game-references/controls/
    cooldown = 3, -- 3 seconds between turning on/off to prevent spam
    defaultHasPermission = true, -- Determines whether someone can toggle on/off a water monitor and adjust pitch by default. See server event to trigger if false.
    upKey = {0, 172},
    downKey = {0, 173},
}

translations = {
    setup = "setup",
    remove = "remove",
    commandSuggestion = "Setup or remove a water monitor",
    commandHelp = "Setup or remove",
    outsideVehicle = "~r~Error~w~: You must not be inside a vehicle",
    monitorRemoved = "~g~Success~w~: Water monitor removed",
    monitorSetup = "~g~Success~w~: Water monitor setup",
    noMonitorFound = "~r~Error~w~: No water monitor found",
    press = "Press",
    toUse = "to toggle this ~b~water monitor",
    keyHelp = "INPUT_PICKUP",
    monitorToggled = "~g~Success~w~: Water monitor toggled",
    commandError = "~r~Error~w~: Use /watermonitor setup or /watermonitor remove",
    monitorActive = "~r~Error~w~: This monitor is active and cannot be removed",
    noSupplyLineFound = "~r~Error~w~: No active supply line found to enable this water monitor", -- Only works if you have the supply line resource
}