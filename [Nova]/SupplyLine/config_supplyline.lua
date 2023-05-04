-- Open the README.md for assistance on configuring this resource

main = {
    commandName = "supplyline",
    supplyProp = `prop_supplyline`,
    defaultSeconds = 120, -- Before they need to connect to a supply line
    enableAcePermissions = false, -- Enable ace permissions for the supply line command
    supplyLineDistance = 10.0, -- To connect initially
    maximumDistance = 200.0, -- Furthest distance you can get away from a vehicle with a supply line
    connectToSupplyLineKey = {0, 191},
    helpKey = "INPUT_FRONTEND_RDOWN",

}

translations = {
    setup = "setup",
    remove = "remove",
    supplyLineError = "~r~Error~w~: Use /supplyline setup or /supplyline remove",
    outsideVehicle = "~r~Error~w~: You must not be inside a vehicle",
    noVehicleFound = "~r~Error~w~: No vehicle found",
    supplyLineSetupAlready = "~r~Error~w~: A supply line is already setup on this vehicle",
    supplyLineSetup = "~g~Success~w~: Supply line setup",
    invalidVehicle = "~r~Error~w~: You cannot setup a supply line on this vehicle",
    supplyLineRemoved = "~g~Success~w~: Supply line removed",
    noSupplyLineFound = "~g~Success~w~: No supply line found",
    commandSuggestion = "Setup or remove a hose supply line",
    help = "Setup or remove a supply line",
    supplyLineConnected = "~g~Success~w~: You are now connected to this vehicle",
    supplyLineDisconnected = "~r~Notice~w~: You have now been disconnected from the supply line",
    limitedSupply = "~g~Success~w~: You now have a limited supply of water from the nearest vehicle",
    noSupply = "~r~Notice~w~: You have no active supply of water",
    supplyLine = "~b~Supply Line~w~: ",
    alreadySupplied = "~r~Notice~w~: This vehicle has already supplied you with water, setup a supply line for more",
    press = "Press ",
    toConnect = "to connect to this vehicle",
    oneHundred = "100",
}

vehicles = {
    {
        model = `firetruk`,
        bone = "",
        offSet = {2.0, -18.0, -1.2},
        rotation = {0.0, 0.0, 180.0},
    },
}