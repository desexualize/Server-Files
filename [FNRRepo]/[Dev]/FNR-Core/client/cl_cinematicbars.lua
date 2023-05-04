local a = false
local b = {x = 0.000, y = -0.001}
local function c()
    a = not a
    if a then
        Citizen.CreateThread(
            function()
                while true do
                    Citizen.Wait(0)
                    if a then
                        HideHUDThisFrame()
                        drawRct(b.x + 0.0, b.y + 0.0, 1.0, 0.15, 0, 0, 0, 255)
                        drawRct(b.x + 0.0, b.y + 0.85, 1.0, 0.151, 0, 0, 0, 255)
                    end
                end
            end
        )
    end
end
function toggleBlackBars()
    c()
end
RegisterCommand("cinematicbars",function(d, e, f)
    c()
    end,
false)

function drawRct(g, h, i, j, k, l, m, n)
    DrawRect(g + i / 2, h + j / 2, i, j, k, l, m, n)
end
function HideHUDThisFrame()
    HideHelpTextThisFrame()
    HideHudAndRadarThisFrame()
    HideHudComponentThisFrame(1)
    HideHudComponentThisFrame(2)
    HideHudComponentThisFrame(3)
    HideHudComponentThisFrame(4)
    HideHudComponentThisFrame(6)
    HideHudComponentThisFrame(7)
    HideHudComponentThisFrame(8)
    HideHudComponentThisFrame(9)
    HideHudComponentThisFrame(13)
    HideHudComponentThisFrame(11)
    HideHudComponentThisFrame(12)
    HideHudComponentThisFrame(15)
    HideHudComponentThisFrame(18)
    HideHudComponentThisFrame(19)
end
