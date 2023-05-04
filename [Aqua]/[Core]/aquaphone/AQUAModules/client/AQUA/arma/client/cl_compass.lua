local a = {}
a.compass = {cardinal = {}, intercardinal = {}, needle = {}}
a.compass.show = true
a.compass.position = {x = 0.375, y = 0.035, centered = true}
a.compass.width = 0.25
a.compass.fov = 180
a.compass.followGameplayCam = true
a.compass.ticksBetweenCardinals = 9.0
a.compass.tickColour = {r = 255, g = 255, b = 255, a = 255}
a.compass.tickSize = {w = 0.001, h = 0.003}
a.compass.cardinal.textSize = 0.15
a.compass.cardinal.textOffset = 0.01
a.compass.cardinal.textColour = {r = 255, g = 255, b = 255, a = 255}
a.compass.cardinal.tickShow = true
a.compass.cardinal.tickSize = {w = 0.001, h = 0.012}
a.compass.cardinal.tickColour = {r = 0, g = 168, b = 255, a = 255}
a.compass.intercardinal.show = true
a.compass.intercardinal.textShow = true
a.compass.intercardinal.textSize = 0.2
a.compass.intercardinal.textOffset = 0.01
a.compass.intercardinal.textColour = {r = 255, g = 255, b = 255, a = 255}
a.compass.intercardinal.tickShow = true
a.compass.intercardinal.tickSize = {w = 0.001, h = 0.006}
a.compass.intercardinal.tickColour = {r = 255, g = 255, b = 255, a = 255}
a.compass.needle.show = true
a.compass.needle.textSize = 0.20
a.compass.needle.textOffset = 0.03
a.compass.needle.textColour = {r = 255, g = 255, b = 255, a = 255}
a.compass.needle.needleSize = {w = 0.0015, h = 0.018}
a.compass.needle.needleColour = {r = 0, g = 168, b = 255, a = 255}
a.streetName = {}
a.streetName.show = false
a.streetName.position = {x = 0.5, y = 0.015, centered = true}
a.streetName.textSize = 0.35
a.streetName.textColour = {r = 255, g = 255, b = 255, a = 255}
function degreesToIntercardinalDirection(b)
    b = b % 360.0
    if b >= 0.0 and b < 22.5 or b >= 337.5 then
        return "N "
    elseif b >= 22.5 and b < 67.5 then
        return "NE"
    elseif b >= 67.5 and b < 112.5 then
        return "E"
    elseif b >= 112.5 and b < 157.5 then
        return "SE"
    elseif b >= 157.5 and b < 202.5 then
        return "S"
    elseif b >= 202.5 and b < 247.5 then
        return "SW"
    elseif b >= 247.5 and b < 292.5 then
        return "W"
    elseif b >= 292.5 and b < 337.5 then
        return "NW"
    end
end
function round(c, d)
    local e = 10 ^ (d or 0)
    return math.floor(c + 0.5 * e)
end
RegisterCommand("showcompass",function()
	showCompass = not showCompass
end)
function tARMA.isCompassEnabled()
    return showCompass
end
function tARMA.setCompassEnabled(f)
    showCompass = f
    SetResourceKvp("arma_compass", tostring(f))
end
Citizen.CreateThread(function()
	local g = GetResourceKvpString("arma_compass") or "false"
	if g == "false" then
		showCompass = false
	else
		showCompass = true
	end
end)
local function h(i, j, k, l)
    tARMA.DrawText(j, k, i, l.size, 0, 0, {l.colour.r, l.colour.g, l.colour.b, l.colour.a}, true)
end
local function m()
    if showCompass then
        local n = a.compass.width / a.compass.fov
        local o = 0
        if a.compass.followGameplayCam then
            local p = GetGameplayCamRot(0)
            o = 360.0 - (p.z + 360.0) % 360.0
        else
            o = 360.0 - GetEntityHeading(tARMA.getPlayerPed())
        end
        local q = o - a.compass.fov / 2
        local r = a.compass.ticksBetweenCardinals - q % a.compass.ticksBetweenCardinals
        local s = a.compass.position.x + r * n
        q = q + r
        while s < a.compass.position.x + a.compass.width do
            if q % 90.0 == 0 then
                if a.compass.cardinal.tickShow then
                    DrawRect(
                        s,
                        a.compass.position.y,
                        a.compass.cardinal.tickSize.w,
                        a.compass.cardinal.tickSize.h,
                        a.compass.cardinal.tickColour.r,
                        a.compass.cardinal.tickColour.g,
                        a.compass.cardinal.tickColour.b,
                        a.compass.cardinal.tickColour.a
                    )
                end
                h(
                    degreesToIntercardinalDirection(q),
                    s,
                    a.compass.position.y + a.compass.cardinal.textOffset,
                    {
                        size = a.compass.cardinal.textSize,
                        colour = a.compass.cardinal.textColour,
                        outline = true,
                        centered = true
                    }
                )
            elseif q % 45.0 == 0 and a.compass.intercardinal.show then
                if a.compass.intercardinal.tickShow then
                    DrawRect(
                        s,
                        a.compass.position.y,
                        a.compass.intercardinal.tickSize.w,
                        a.compass.intercardinal.tickSize.h,
                        a.compass.intercardinal.tickColour.r,
                        a.compass.intercardinal.tickColour.g,
                        a.compass.intercardinal.tickColour.b,
                        a.compass.intercardinal.tickColour.a
                    )
                end
                if a.compass.intercardinal.textShow then
                    h(
                        degreesToIntercardinalDirection(q),
                        s,
                        a.compass.position.y + a.compass.intercardinal.textOffset,
                        {
                            size = a.compass.intercardinal.textSize,
                            colour = a.compass.intercardinal.textColour,
                            outline = true,
                            centered = true
                        }
                    )
                end
            else
                DrawRect(
                    s,
                    a.compass.position.y,
                    a.compass.tickSize.w,
                    a.compass.tickSize.h,
                    a.compass.tickColour.r,
                    a.compass.tickColour.g,
                    a.compass.tickColour.b,
                    a.compass.tickColour.a
                )
            end
            q = q + a.compass.ticksBetweenCardinals
            s = s + n * a.compass.ticksBetweenCardinals
        end
        if showCompass then
            h(
                tostring(round(o)),
                a.compass.position.x + a.compass.width / 2,
                a.compass.position.y - a.compass.needle.textOffset,
                {
                    size = a.compass.needle.textSize,
                    colour = a.compass.needle.textColour,
                    outline = true,
                    centered = true
                }
            )
            DrawRect(
                a.compass.position.x + a.compass.width / 2,
                a.compass.position.y,
                a.compass.needle.needleSize.w,
                a.compass.needle.needleSize.h,
                a.compass.needle.needleColour.r,
                a.compass.needle.needleColour.g,
                a.compass.needle.needleColour.b,
                a.compass.needle.needleColour.a
            )
        end
    end
end
tARMA.createThreadOnTick(m)
