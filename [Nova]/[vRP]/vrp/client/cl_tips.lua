Nova_Tips = {
    "Watch out, there is more recoil than usual in this city",
    "Press L to open your inventory",
    "KOS is only allowed at redzones!",
    "You can point with B",
    "You can make your minimap bigger with Z",
    "You can perform CPR on your dead friends, with a small chance of resuscitation using /cpr",
    "You sell all legal goods (Copper,Gold etc..) at the Trader which is south of the map near the docks",
    "You can get your GP to take a look at you and restore your health at any Hospital",
    "Check out our Website for whitelisted faction applications, https://discord.gg/YxCcxY6bYF",
    "Want to join the PD? Apply at https://discord.gg/YxCcxY6bYF",
    "Use /ooc or // to ask out of character questions",
    "To call an admin, type /calladmin",
    "To report a player you can create a player report at https://discord.gg/YxCcxY6bYF",
    "You can lock your car with the comma key [,]",
    "If you are experiencing texture loss set your Texture Quality to Normal in graphics settings!",
    "F6 to see your licenses",
    "F5 to see your gang menu",
    "F10 to see your past warnings/kicks/bans",
    "M for vehicle functions/control",
    "Join our discord for discussion & development news https://discord.gg/YxCcxY6bYF",
    "Press F1 for help on getting started, controls & rules",
    "Remember, selling or advertising the sale of anything in out of character chat is not allowed!",
}

local previous_num = nil
Citizen.CreateThread(function()
    Citizen.Wait(100000) -- Wait  100 seconds before first tip
    while true do
        local random_num = math.random(1, #Nova_Tips)
        while random_num == previous_num do
            random_num = math.random(1, #Nova_Tips)
        end
        
        TriggerEvent("chatMessage", "[Nova Tips]", {255, 0, 0}, '^5' .. Nova_Tips[random_num], 'ooc')
        previous_num = random_num

        Citizen.Wait(600000) -- Wait 10 Minutes Before sending another tip
    end
end)