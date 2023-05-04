local a = module("cfg/cfg_loginrewards")
RMenu.Add("loginrewards","mainmenu",RageUI.CreateMenu("","Main Menu",tAQUA.getRageUIMenuWidth(),tAQUA.getRageUIMenuHeight(),"banners", "rewards"))
local b = 0
local c = 0
local function d(e)
    local f = "You can claim this reward in"
    if e.months and e.months > 0 then
        f = f .. " " .. tostring(e.months) .. "m"
    end
    if e.days and e.days > 0 then
        f = f .. " " .. tostring(e.days) .. "d"
    end
    if e.hours and e.hours > 0 then
        f = f .. " " .. tostring(e.hours) .. "h"
    end
    if e.minutes and e.minutes > 0 then
        f = f .. " " .. tostring(e.minutes) .. "m"
    end
    if e.seconds and e.seconds > 0 then
        f = f .. " " .. tostring(e.seconds) .. "s"
    end
    f = f .. "."
    return f
end
local function g(h)
    if h then
        return "You can claim this reward now!"
    else
        return "You have claimed this reward!"
    end
end
local function i(j, k)
    local l = j - 1 - b
    local m = c - GetGameTimer() + l * 86400000
    if m <= 0 and b > 0 then
        return "You can claim this reward now!"
    end
    if k then
        return "You must claim the previous reward first."
    end
    local e = formatTime(m / 1000)
    return d(e)
end
local function n(j, o)
    if o then
        return "CLAIMED"
    end
    local f = "N/A"
    for p, q in pairs(a.rewards) do
        if j >= q.day then
            f = getMoneyStringFormatted(q.amount)
        end
    end
    return string.format("£%s", f)
end
local function r()
    return c - GetGameTimer() < 0
end

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('loginrewards', 'mainmenu')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            if b > 0 and c - GetGameTimer() < -86400000 then
                b = 0
                c = 0
            end
            if b == 0 then
                RageUI.Separator("You have no login streak.")
            else
                RageUI.Separator(string.format("Your login streak is %d %s.", b, b > 1 and "days" or "day"))
            end
            local s = r()
            local t = s and b + 1 or b
            RageUI.Button(string.format("Day %d", t),g(s),{RightLabel = n(t, not s)},s,function(p, p, u)
                if u then
                    TriggerServerEvent("AQUA:claimNextLoginReward")
                    b = b + 1
                    c = GetGameTimer() + 86400000
                end
            end,nil)
            RageUI.Separator("Upcoming Rewards")
            local v = t < 7 and 5 or 3
            for j = t + 1, t + v do
                RageUI.Button(string.format("Day %d", j),i(j, s),{RightLabel = n(j, false)},false,function()
                end)
            end
            if t < 55 then
                RageUI.Button("Day 60",i(60, s),{RightLabel = n(60, false)},false,function()
                end)
            end
            if t < 115 then
                RageUI.Button("Day 120",i(120, s),{RightLabel = n(120, false)},false,function()
                end)
            end
        end) 
    end
end)
RegisterNetEvent("AQUA:setDailyRewardInfo",function(w, x, y)
    b = w
    c = GetGameTimer() + (86400 - (y - x)) * 1000
    if w == 0 then
        Citizen.Wait(20000)
        tAQUA.notify("~y~You have not started your daily reward. Do /dailyrewards to start now!")
    end
end)
RegisterCommand("dailyrewards",function()
    RageUI.Visible(RMenu:Get("loginrewards", "mainmenu"), true)
end,false)
Citizen.CreateThread(function()
    Citizen.Wait(20000)
    while true do
        if r() and b > 0 then
            tAQUA.notify("~g~You can claim your next daily reward at /dailyrewards!")
            break
        end
        Citizen.Wait(6000)
    end
end)
