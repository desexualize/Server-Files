RegisterNetEvent("AQUA:buildAnnounceMenu")
AddEventHandler("AQUA:buildAnnounceMenu", function(i)
    local a = i
    RMenu.Add(
        "AQUAannouncements",
        "main",
        RageUI.CreateMenu(
            "",
            "~b~Announcement Menu",
            tAQUA.getRageUIMenuWidth(),
            tAQUA.getRageUIMenuHeight(),
            "banners",
            "announcement"
        )
    )
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            if RageUI.Visible(RMenu:Get("AQUAannouncements", "main")) then
                RageUI.DrawContent(
                    {header = true, glare = false, instructionalButton = false},
                    function()
                        for b, c in pairs(a) do
                            RageUI.Button(
                                c.name,
                                string.format("%s Price: £%s", c.desc, getMoneyStringFormatted(c.price)),
                                {RightLabel = "→→→"},
                                true,
                                function(d, e, f)
                                    if f then
                                        TriggerServerEvent("AQUA:serviceAnnounce", c.name)
                                    end
                                end
                            )
                        end
                    end
                )
            end
        end
    end)
end)

RegisterNetEvent("AQUA:serviceAnnounceCl")
AddEventHandler("AQUA:serviceAnnounceCl", function(g, h)
    tAQUA.announce(g, h)
end)

RegisterCommand("announcemenu", function()
    TriggerServerEvent("AQUA:getAnnounceMenu")
end)
