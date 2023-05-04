RMenu.Add('developermenu', 'main', RageUI.CreateMenu("", "~b~Developer Menu", 1300,100, "banners","adminmenu"))

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('developermenu', 'main')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            RageUI.Button("Give Weapon", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent("FNR:GiveWeapon")
                end
            end)
            RageUI.Button("Give Weapon to Player", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent("FNR:GiveWeaponToPlayer")
                end
            end)
            RageUI.Button("Give Armour", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent("FNR:GiveArmour")
                end
            end)
        end)
    end
end)

RegisterCommand("devmenu",function()
    if tvRP.isDev() then
        RageUI.Visible(RMenu:Get("developermenu", "main"), not RageUI.Visible(RMenu:Get("developermenu", "main")))
    end
end)