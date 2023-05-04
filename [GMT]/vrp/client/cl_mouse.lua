mousedrw = 0
mousex, mousey = 0.0, 0.0
inGUIGMT = false --barnsy
function CursorInZone(a, b, c, d)
    if mousedrw == 1 and mousex > a and mousex < c and mousey > b and mousey < d then
        return true
    else
        return false
    end
end
function setCursor(e)
    mousedrw = e
end
function CursorInArea(f, g, h, i)
    if mousex > f and mousex < g and mousey > h and mousey < i then
        return true
    end
end
Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            if mousedrw == 1 then
                mousex = GetControlNormal(2, 239)
                mousey = GetControlNormal(2, 240)
                mousex_d = GetDisabledControlNormal(2, 239)
                mousey_d = GetDisabledControlNormal(2, 240)
                SetMouseCursorActiveThisFrame()
            end
        end
    end
)
function func_disableGuiControls()
    if inGUIGMT then
        DisableControlAction(0, 1, true)
        DisableControlAction(0, 2, true)
        DisableControlAction(0, 25, true)
        DisableControlAction(0, 106, true)
        DisableControlAction(0, 24, true)
        DisableControlAction(0, 140, true)
        DisableControlAction(0, 141, true)
        DisableControlAction(0, 142, true)
        DisableControlAction(0, 257, true)
        DisableControlAction(0, 263, true)
        DisableControlAction(0, 264, true)
        DisableControlAction(0, 12, true)
        DisableControlAction(0, 14, true)
        DisableControlAction(0, 15, true)
        DisableControlAction(0, 16, true)
        DisableControlAction(0, 17, true)
    end
end
function GetArea(f, h, j, k)
    local l = f - j / 2
    local g = f + j / 2
    local m = h - k / 2
    local i = h + k / 2
    return l, g, m, i
end
Citizen.CreateThread(
    function()
        while not GMT.createThreadOnTick do
            Wait(0)
        end
        GMT.createThreadOnTick(func_disableGuiControls)
    end
)
function GetArea(f, h, j, k)
    local l = f - j / 2
    local g = f + j / 2
    local m = h - k / 2
    local i = h + k / 2
    return l, g, m, i
end