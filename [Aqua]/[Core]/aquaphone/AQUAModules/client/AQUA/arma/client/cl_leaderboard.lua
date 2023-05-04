local a = {
    columns = {"Name", "Kills", "Deaths", "Killstreak", "KDR"},
    rows = {
        {"Robbster", "~b~BLUE TEAM", "", false, 5, 2, 0, "1.4"},
        {"Thomas", "~b~BLUE TEAM", "", false, 7, 5, 0, "0.5"},
        {"Arthur", "~r~RED TEAM", "", false, 5, 0, 2, "0.5"},
        {"Robbster", "~b~BLUE TEAM", "", false, 5, 0, 2, "1.4"},
        {"Thomas", "~b~BLUE TEAM", "", false, 7, 5, 0, "0.5"},
        {"Arthur", "~r~RED TEAM", "", false, 5, 2, 0, "0.5"},
        {"Robbster", "~b~BLUE TEAM", "", false, 5, 2, 0, "1.4"},
        {"Thomas", "~b~BLUE TEAM", "", false, 7, 5, 0, "0.5"},
        {"Arthur", "~r~RED TEAM", "", false, 5, 2, 0, "0.5"}
    }
}
RegisterCommand("leaderboardtest",function()
    if tARMA.isDev() then
        local b = tARMA.createLeaderboard(a)
        Wait(1000)
        tARMA.closeLeaderboard(b)
    end
end,false)
local b = 1
local c = {}
local d = {columns = {}, rows = {}}
local e = false
local function f(g)
    local h = math.floor(g / 1000)
    g = g - h * 1000
    local i = math.floor(h / 60)
    h = h - i * 60
    return string.format("%02d:%02d:%04d", i, h, g)
end
local function j(k)
    local l = "th"
    if k == 1 then
        l = "st"
    end
    if k == 2 then
        l = "nd"
    end
    if k == 3 then
        l = "rd"
    end
    return tostring(k) .. l
end
function tARMA.closeLeaderboard(b)
    c[b] = false
end
function tARMA.createLeaderboard(m)
    local n = Scaleform("SC_LEADERBOARD")
    n.RunFunction("SET_DISPLAY_TYPE", {1})
    n.RunFunction("SET_MULTIPLAYER_TITLE", {"ARMA RP Event"})
    n.RunFunction("SET_TITLE", m.columns)
    for o, p in ipairs(m.rows) do
        local q = p[3]
        if q ~= "" then
            q = "XXX" .. q
        end
        if m.formatTime then
            local r = f(p[8])
            n.RunFunction("SET_SLOT", {o - 1, 1, p[1], p[2], q, p[5], p[6], p[7], r})
        else
            n.RunFunction("SET_SLOT", {o - 1, 1, p[1], p[2], q, p[5], p[6], p[7], p[8]})
        end
        if p[4] then
            n.RunFunction("SET_SLOT_STATE", {o - 1, 2, 1})
        else
            n.RunFunction("SET_SLOT_STATE", {o - 1, 0, 1})
        end
    end
    b = b + 1
    CreateThread(
        function()
            c[b] = true
            while c[b] do
                local s = table.count(d.rows)
                for o = 1, s, 1 do
                    local p = d.rows[o]
                    local q = p[3]
                    if q ~= "" then
                        q = "XXX" .. q
                    end
                    local k = p[1]
                    if d.formatPlace then
                        k = j(k)
                    end
                    local r = p[8]
                    if d.formatTime then
                        r = f(r)
                    end
                    n.RunFunction("SET_SLOT", {o - 1, 1, k, p[2], q, p[5], p[6], p[7], r})
                    if p[4] then
                        n.RunFunction("SET_SLOT_STATE", {o - 1, 2, 1})
                    else
                        n.RunFunction("SET_SLOT_STATE", {o - 1, 0, 1})
                    end
                end
                n.Render2D()
                Wait(0)
            end
        end
    )
    return b
end
RegisterNetEvent(
    "ARMA:initScoreboard",
    function(t)
        d = t
    end
)
function tARMA.updateScoreboard(u, v, w)
    local x
    for y, z in pairs(d.rows) do
        if z.playerSrc == u then
            x = y
        end
    end
    if u == -1 then
        for x, A in pairs(d.rows) do
            d.rows[x][v] = w
        end
    else
        if x then
            if w == "+1" then
                d.rows[x][v] = d.rows[x][v] + 1
                if v == 6 or v == 5 then
                    local B = d.rows[x][6]
                    if type(B) == "string" then
                        print(
                            "[Error:updateScoreboard] Death is somehow a string, value is",
                            B,
                            "playerSrc,column,value =",
                            u,
                            v,
                            w
                        )
                        print("leaderboard dump", dump(d))
                    end
                    if B == 0 then
                        B = 1
                    end
                    local C = tostring(math.floor(d.rows[x][5] / B * 100) / 100)
                    if d.columns[4] == "KDR" then
                        d.rows[x][7] = C
                    elseif d.columns[5] == "KDR" then
                        d.rows[x][8] = C
                    end
                end
            else
                d.rows[x][v] = w
            end
            if d.sortAscending then
                table.sort(
                    d.rows,
                    function(D, E)
                        return D[d.sortColumn or 5] < E[d.sortColumn or 5]
                    end
                )
            else
                table.sort(
                    d.rows,
                    function(D, E)
                        return D[d.sortColumn or 5] > E[d.sortColumn or 5]
                    end
                )
            end
        else
            print("error: ARMA:updateScoreboard couldn't find row with values", u, v, w)
        end
    end
end
RegisterNetEvent(
    "ARMA:updateScoreboard",
    function(u, v, w)
        tARMA.updateScoreboard(u, v, w)
    end
)
function tARMA.setPlayerCanOpenLeaderboard(F)
    e = F
end
function tARMA.clearLeaderboardData()
    d = {columns = {}, rows = {}}
end
function tARMA.isLeaderboardSetup()
    return table.count(d.rows) > 0
end
function tARMA.removePlayerFromLeaderboard(u)
    for G, x in pairs(d.rows) do
        if x.playerSrc == u then
            table.remove(d.rows, G)
            break
        end
    end
end
CreateThread(
    function()
        while true do
            if e then
                if IsControlJustPressed(0, 212) then
                    tARMA.createLeaderboard(d)
                    while IsControlPressed(0, 212) do
                        Wait(0)
                    end
                    tARMA.closeLeaderboard(b)
                end
            end
            Wait(0)
        end
    end
)
