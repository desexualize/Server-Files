local weather = {"EXTRASUNNY","CLEAR","NEUTRAL","SMOG","FOGGY","OVERCAST","CLOUDS","CLEARING","THUNDER","SNOW","BLIZZARD","SNOWLIGHT","XMAS","HALLOWEEN" }
local weatherindex = 1
local Time1 = {}
local Time2 = 0
local HasCinematic = false
for i = 0, 23 do
    Time1[i] = i
end

RMenu.Add('CinematicMenu', 'MainMenu', RageUI.CreateMenu("", "FNR Cinematic", 1300,100,"settings","settings")) 

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('CinematicMenu', 'MainMenu')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
        if HasCinematic then
            RageUI.List("Time", Time1, Time2, "~g~Press enter to select Weather", {}, true, function(a,b,Selected, Idex)
                if Selected then
                    overrideTime(Time1[Time2], 0, 0)
                end
                Time2 = Idex
            end)

            RageUI.List("Weather", weather, weatherindex, "~g~Press enter to select Weather", {}, true, function(a,b,Selected, Idex)
                if Selected then
                    setWeather(weather[weatherindex])
                end
                weatherindex = Idex
            end)
        else
            RageUI.Separator("You don't have the cinematic permission")
            RageUI.Button("Get Permission", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SendNUIMessage({act="openurl",url="https://discord.gg/fnruk"})
                end
            end)
        end
       end)
    end
end)

RegisterCommand("cinematic", function()
    TriggerServerEvent("FNR:RequestCinematic")
    RageUI.Visible(RMenu:Get('CinematicMenu', 'MainMenu'), not RageUI.Visible(RMenu:Get('CinematicMenu', 'MainMenu')))
end)


function tvRP.hasCinematicPermission()
    HasCinematic = true
end

-- Probs not best way todo it but fuck it :)
local a = "EXTRASUNNY"
local b = {h = 12, m = 0, s = 0}

local function weather(e)
    a = e
    ClearOverrideWeather()
    ClearWeatherTypePersist()
    SetWeatherTypePersist(a)
    SetWeatherTypeNow(a)
    SetWeatherTypeNowPersist(a)
    if a == "XMAS" then
        SetForceVehicleTrails(true)
        SetForcePedFootstepsTracks(true)
    else
        SetForceVehicleTrails(false)
        SetForcePedFootstepsTracks(false)
    end
end

function overrideTime(f, g, h)
    b.h = f
    b.m = g
    b.s = h
end

function setWeather(i)
    a = i
end

function func_manageTimeAndWeather()
    NetworkOverrideClockTime(b.h, b.m, b.s)
    weather(a)
end
Citizen.CreateThread(function()
    while true do
        func_manageTimeAndWeather()
        Wait(0)
    end
end)