function tARMA.add3DTextForCoord(a, b, c, d, e)
    local function f(g)
        tARMA.DrawText3D(g.coords, g.text, 0.2)
    end
    local h = tARMA.generateUUID("3dtext", 8, "alphanumeric")
    tARMA.createArea("3dtext_" .. h,vector3(b, c, d),e,6.0,function()end,function()end,f,{coords = vector3(b, c, d), text = a})
end
function tARMA.drawFloatingHelpText(a, i)
    AddTextEntry("instructionalText", a)
    SetFloatingHelpTextWorldPosition(1, i.x, i.y, i.z)
    SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
    BeginTextCommandDisplayHelp("instructionalText")
    AddTextComponentSubstringPlayerName(a)
    EndTextCommandDisplayHelp(2, false, false, -1)
end
function tARMA.DrawText3D(i, a, j, k, l, m)
    local n, b, c = GetScreenCoordFromWorldCoord(i.x, i.y, i.z, 0.0, 0.0)
    if not n then
        return
    end
    SetTextScale(j, j)
    SetTextFont(k or 0)
    if m then
        SetTextColour(m[1], m[2], m[3], m[4])
    else
        SetTextColour(255, 255, 255, 255)
    end
    SetTextCentre(true)
    SetTextDropshadow(0, 0, 0, 0, 55)
    SetTextDropShadow()
    SetTextOutline()
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(a)
    EndTextCommandDisplayText(b, c)
    if l then
        local o = #a / 370
        DrawRect(b, c + 0.0125, 0.015 + o, 0.03, 41, 41, 41, 125)
    end
end
function tARMA.DrawText(b, c, a, j, k, p, m, q)
    SetTextScale(j, j)
    SetTextFont(k or 0)
    if p then
        SetTextJustification(p)
    end
    if m then
        SetTextColour(m[1], m[2], m[3], m[4])
    else
        SetTextColour(255, 255, 255, 255)
    end
    if q then
        SetTextDropshadow(0, 0, 0, 0, 55)
        SetTextDropShadow()
        SetTextOutline()
    end
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(a)
    EndTextCommandDisplayText(b, c)
end
function DrawAdvancedText(b, c, r, s, t, a, u, v, w, x, k, y)
    SetTextFont(k)
    SetTextScale(t, t)
    SetTextJustification(y)
    SetTextColour(u, v, w, x)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(a)
    EndTextCommandDisplayText(b - 0.1 + r, c - 0.02 + s)
end
function DrawAdvancedTextNoOutline(b, c, r, s, t, a, u, v, w, x, k, y)
    SetTextFont(k)
    SetTextScale(t, t)
    SetTextJustification(y)
    SetTextColour(u, v, w, x)
    SetTextDropShadow()
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(a)
    EndTextCommandDisplayText(b - 0.1 + r, c - 0.02 + s)
end
function DrawGTAText(a, b, c, j, z, A)
    SetTextFont(0)
    SetTextScale(j, j)
    SetTextColour(254, 254, 254, 255)
    if z then
        SetTextWrap(b - A, b)
        SetTextRightJustify(true)
    end
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(a)
    EndTextCommandDisplayText(b, c)
end
