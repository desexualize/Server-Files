RMenu.Add("Novaannouncements","main", RageUI.CreateMenu("Announcement Menu", "~b~Announcement Menu", 1250, 100))

local a = {}
RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('Novaannouncements', 'main')) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = true}, function()
            for b, c in pairs(a) do
                RageUI.Button(c.name, c.desc, {RightLabel = "→→→"}, true, function(d, e, f)
                    if f then
                        TriggerServerEvent("Nova:serviceAnnounce", c.name)
                    end
                end)
            end
        end)
    end
end)

RegisterNetEvent("Nova:buildAnnounceMenu", function(g)
    a = g
    RageUI.Visible(RMenu:Get("Novaannouncements", "main"), not RageUI.Visible(RMenu:Get("Novaannouncements", "main")))
end)

RegisterCommand("announcemenu", function()
    TriggerServerEvent('Nova:getAnnounceMenu')
end)