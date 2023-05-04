local backpacksv = {
    ["Legion Store"] = {
        ["_config"] = {130.8708, -1035.0491, 29.4325, 314.9166, 676, 1, "Legion Store Bags", "", true},
        ["Green Hiking Backpack (+40kg)"] = {5, 91, 0, 120000, 40},
        ["Tan Hiking Backpack (+40kg)"] = {5, 87, 0, 120000, 40},
        ["Gucci Bag (+20kg)"] = {5, 86, 0, 60000, 20},
        ["Off White Bag (+15kg)"] = {5, 92, 0, 40000, 15},
        ["Nike Bag (+30kg)"] = {5, 90, 0, 80000, 30},
        ["Hunting Backpack (+35kg)"] = {5, 83, 0, 100000, 35},
        ["Primark Bag (+30kg)"] = {5, 16, 3, 80000, 30}
    },
    ["Rebel"] = {
        ["_config"] = {1540.7928466797, 6332.4702148438, 23.071977615356, 676, 1, "Rebel Backpacks", "rebel.license", true},
        ["Rebel Backpack (+70kg)"] = {5, 90, 0, 250000, 70}
    }
}

AddEventHandler("playerConnecting", function()
    local source = source
    local user_id = AQUA.getUserId(source)
    TriggerClientEvent('AQUA:getBackPacks', source,backpacksv)
end)