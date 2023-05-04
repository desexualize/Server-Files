RMenu.Add("NovaMenu", "main", RageUI.CreateMenu("", "~r~Rebel Trader", 1300, 50, "rebel", "rebel"))
RMenu.Add("NovaMenu", "confirm", RageUI.CreateSubMenu(RMenu:Get("NovaMenu", "main", 1300, 50)))
RMenu.Add("NovaMenu", "confirmA", RageUI.CreateSubMenu(RMenu:Get("NovaMenu", "main", 1300, 50)))

local isToggle = false
RageUI.CreateWhile(
    1.0,
    RMenu:Get("NovaMenu", "main"),
    nil,
    function()
        RageUI.IsVisible(
            RMenu:Get("NovaMenu", "main"),
            true,
            false,
            true,
            function()
                for i, p in pairs(large.guns) do
                    RageUI.Button(
                        p.name,
                        nil,
                        {RightLabel = "£" .. getMoneyStringFormatted(p.price) .. ""},
                        true,
                        function(Hovered, Active, Selected)
                            if Selected then
                                cPrice = p.price
                                cHash = p.hash
                            end
                        end,
                        RMenu:Get("NovaMenu", "confirm")
                    )
                end
                RageUI.Button(
                    "Level 4 Armour ~r~[100%]",
                    nil,
                    {RightLabel = "£100,000"},
                    true,
                    function(Hovered, Active, Selected)
                        if Selected then
                        end
                    end,
                    RMenu:Get("NovaMenu", "confirmA")
                )
            end,
            function()
            end
        )
    end
)

RegisterNetEvent("isToggleT")
AddEventHandler(
    "isToggleT",
    function(bool2)
        isToggle = bool2
    end
)

vRPclient = Proxy.getInterface("vRP")
RegisterNetEvent("rebel:givegun")
AddEventHandler(
    "rebel:givegun",
    function(hash)
        local coords = GetEntityCoords(PlayerPedId())
        local comparison = vector3(1544.7969970703, 6331.2475585938, 24.077945709229)
        local shopname = "Rebel"
        print(coords)
        if #(coords - comparison) > 10 then
            Wait(5000)
            TriggerServerEvent("Nova:anticheatBan", "Cheating/ Triggering Events")
            return
        else
            vRPclient.allowWeapon({hash, "-1"})
            GiveWeaponToPed(PlayerPedId(), hash, 250, false, false, 0)
        end
    end
)

RageUI.CreateWhile(
    1.0,
    RMenu:Get("NovaMenu", "confirm"),
    nil,
    function()
        RageUI.IsVisible(
            RMenu:Get("NovaMenu", "confirm"),
            true,
            false,
            true,
            function()
                RMenu:Get("NovaMenu", "confirm"):SetSubtitle("Are you sure?")
                RageUI.Button(
                    "Confirm",
                    nil,
                    {RightLabel = ""},
                    true,
                    function(Hovered, Active, Selected)
                        if Selected then
                            TriggerServerEvent("Nova:BuyGun", cPrice, cHash, isToggle)
                        end
                    end,
                    RMenu:Get("NovaMenu", "main")
                )
                RageUI.Button(
                    "Decline",
                    nil,
                    {RightLabel = ""},
                    true,
                    function(Hovered, Active, Selected)
                        if Selected then
                        end
                    end,
                    RMenu:Get("NovaMenu", "main")
                )
            end
        )
    end
)

RageUI.CreateWhile(
    1.0,
    RMenu:Get("NovaMenu", "confirmA"),
    nil,
    function()
        RageUI.IsVisible(
            RMenu:Get("NovaMenu", "confirmA"),
            true,
            false,
            true,
            function()
                RMenu:Get("NovaMenu", "confirmA"):SetSubtitle("Are you sure?")
                RageUI.Button(
                    "Confirm",
                    nil,
                    {RightLabel = ""},
                    true,
                    function(Hovered, Active, Selected)
                        if Selected then
                            if GetPedArmour(PlayerPedId()) <= 90 then
                                TriggerServerEvent("Nova:BuyArmour", isToggle)
                            else
                                notify("~r~You already have Max armour.")
                            end
                        end
                    end,
                    RMenu:Get("NovaMenu", "main")
                )
                RageUI.Button(
                    "Decline",
                    nil,
                    {RightLabel = ""},
                    true,
                    function(Hovered, Active, Selected)
                        if Selected then
                        end
                    end,
                    RMenu:Get("NovaMenu", "main")
                )
            end
        )
    end
)

isInLarge = false
currentAmmunition = nil
Citizen.CreateThread(
    function()
        while true do
            for k, v in pairs(large.gunshops) do
                local x, y, z = table.unpack(v.marker)
                local v1 = vector3(x, y, z)

                if isInArea(v1, 100.0) then
                    DrawMarker(
                        27,
                        1545.2042236328,
                        6332.3295898438,
                        24.078683853149 - 0.999999,
                        0.0,
                        0.0,
                        0.0,
                        0.0,
                        0.0,
                        1.0,
                        1.0,
                        1.0,
                        2.5,
                        255,
                        0,
                        0,
                        250,
                        0,
                        0,
                        2,
                        0,
                        0,
                        0,
                        false
                    )
                end
                if isInLarge == false then
                    if isInArea(v1, 1.4) then
                        alert("Press ~INPUT_VEH_HORN~ to access Rebel")
                        if IsControlJustPressed(0, 51) then
                            currentAmmunition = k
                            RageUI.Visible(RMenu:Get("NovaMenu", "main"), true)
                            isInLarge = true
                            currentAmmunition = k
                        end
                    end
                end
                if isInArea(v1, 1.4) == false and isInLarge and k == currentAmmunition then
                    RageUI.CloseAll()
                    isInLarge = false
                    currentAmmunition = nil
                end
            end
            Citizen.Wait(0)
        end
    end
)

function isInArea(v, dis)
    if #(GetEntityCoords(PlayerPedId(-1)) - v) <= dis then
        return true
    else
        return false
    end
end

function alert(msg)
    SetTextComponentFormat("STRING")
    AddTextComponentSubstringPlayerName(msg)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

Citizen.CreateThread(
    function()
        blip = AddBlipForCoord(1545.2042236328, 6332.3295898438, 24.078683853149)
        SetBlipSprite(blip, 310)
        SetBlipScale(blip, 0.6)
        SetBlipDisplay(blip, 2)
        SetBlipColour(blip, 1)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName("Rebel")
        EndTextCommandSetBlipName(blip)
    end
)

function notify(string)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(string)
    EndTextCommandThefeedPostTicker(true, false)
end
