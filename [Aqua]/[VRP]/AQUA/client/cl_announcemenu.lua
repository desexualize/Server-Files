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
local a = {}
RageUI.CreateWhile(
    1.0,
    true,
    function()
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
)
RegisterNetEvent(
    "AQUA:serviceAnnounceCl",
    function(g, h)
        tAQUA.announce(g, h)
    end
)
RegisterNetEvent(
    "AQUA:buildAnnounceMenu",
    function(i)
        a = i
        RageUI.Visible(
            RMenu:Get("AQUAannouncements", "main"),
            not RageUI.Visible(RMenu:Get("AQUAannouncements", "main"))
        )
    end
)
RegisterCommand(
    "announcemenu",
    function()
        TriggerServerEvent("AQUA:getAnnounceMenu")
    end
)
