local function a()
    local b = GetResourceKvpString("arma_scope_horizontal")
    if b == nil or b == "" then
        return 50
    else
        return tonumber(b)
    end
end
local c = {}
local d = a()
for e = 1, 100 do
    table.insert(c, string.format("%d%%", e))
end
local function f()
    local b = GetResourceKvpString("arma_scope_vertical")
    if b == nil or b == "" then
        return 30
    else
        return tonumber(b)
    end
end
local g = {}
local h = f()
for e = 1, 100 do
    table.insert(g, string.format("%d%%", e))
end
local i = GetResourceKvpString("arma_scope_enabled") == "true"
local j = false

RMenu.Add("scope","main",RageUI.CreateMenu("", "Scope Settings", tARMA.getRageUIMenuWidth(),tARMA.getRageUIMenuHeight(),"banners","scope"))

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('scope', 'main')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            j = true
            RageUI.List("Horizontal Position",c,d,"The horizontal position of the distance text",{},true,function(k, l, m, n)
                d = n
                if l then
                    SetResourceKvp("arma_scope_horizontal", tostring(n))
                end
            end)
            RageUI.List("Vertical Position",g,h,"The vertical position of the distance text",{},true,function(k, l, m, n)
                h = n
                if l then
                    SetResourceKvp("arma_scope_vertical", tostring(n))
                end
            end)
            RageUI.Checkbox("Enabled","Whether the distance should be shown when using a weapon scope",i,{},function(k, m, l, o)
                i = o
                if l then
                    SetResourceKvp("arma_scope_enabled", tostring(o))
                end
            end) 
        end)
    end
end)

RegisterCommand("scope",function()
    RageUI.ActuallyCloseAll()
    RageUI.Visible(RMenu:Get("SettingsMenu", "MainMenu"), false)
    RageUI.Visible(RMenu:Get("scope", "main"), true)
end)

function tARMA.doesCurrentWeaponHaveScope()
    local p = PlayerPedId()
    local q = GetCurrentPedWeaponEntityIndex(p)
    if q == 0 then
        return false
    end
    local r = {
        "component_at_scope_large",
        "component_at_scope_large_mk2",
        "component_at_scope_max",
        "component_at_scope_large_fixed_zoom",
        "component_at_scope_large_fixed_zoom_mk2"
    }
    for s, t in ipairs(r) do
        if HasWeaponGotWeaponComponent(q, t) then
            return true
        end
    end
    local u = GetSelectedPedWeapon(p)
    local v = GetWeapontypeGroup(u)
    local w = GetPedAmmoTypeFromWeapon(p, u)
    if v == -1212426201 then
        return true
    end
    return false
end
local function x(y)
    local z = vector3(math.pi / 180 * y.x, math.pi / 180 * y.y, math.pi / 180 * y.z)
    local A = vector3(-math.sin(z.z) * math.abs(math.cos(z.x)), math.cos(z.z) * math.abs(math.cos(z.x)), math.sin(z.x))
    return A
end
local function B()
    local C = GetGameplayCamCoord()
    local D = GetGameplayCamRot(2)
    local E = x(D)
    local F = C + E * 500.0
    local G = StartExpensiveSynchronousShapeTestLosProbe(C.x, C.y, C.z, F.x, F.y, F.z, -1, PlayerPedId(), 4)
    local s, s, H, s, s = GetShapeTestResult(G)
    return #(C - H)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if i and (j or tARMA.doesCurrentWeaponHaveScope()) then
            if j then
                j = RageUI.Visible(RMenu:Get("scope", "main"))
            end
            local J = math.round(B(), 0)
            DrawAdvancedText(d / 100.0, 1.0 - h / 100.0, 0.1, 0.002, 0.4, string.format("%dm", J), 255, 255, 255, 255, 0, 0)
        end
    end
end)