local CompassConfig = {}
CompassConfig.compass = { cardinal={}, intercardinal={}, needle={} }
CompassConfig.compass.show = true
CompassConfig.compass.position = {x = 0.375, y = 0.035, centered = true}
CompassConfig.compass.width = 0.25
CompassConfig.compass.fov = 180
CompassConfig.compass.followGameplayCam = true

CompassConfig.compass.ticksBetweenCardinals = 9.0
CompassConfig.compass.tickColour = {r = 255, g = 255, b = 255, a = 255}
CompassConfig.compass.tickSize = {w = 0.001, h = 0.003}

CompassConfig.compass.cardinal.textSize = 0.15
CompassConfig.compass.cardinal.textOffset = 0.01
CompassConfig.compass.cardinal.textColour = {r = 255, g = 255, b = 255, a = 255}

CompassConfig.compass.cardinal.tickShow = true
CompassConfig.compass.cardinal.tickSize = {w = 0.001, h = 0.012}
CompassConfig.compass.cardinal.tickColour = {r = 255, g = 255, b = 255, a = 255}

CompassConfig.compass.intercardinal.show = true
CompassConfig.compass.intercardinal.textShow = true
CompassConfig.compass.intercardinal.textSize = 0.2
CompassConfig.compass.intercardinal.textOffset = 0.01
CompassConfig.compass.intercardinal.textColour = {r = 255, g = 255, b = 255, a = 255}

CompassConfig.compass.intercardinal.tickShow = true
CompassConfig.compass.intercardinal.tickSize = {w = 0.001, h = 0.006}
CompassConfig.compass.intercardinal.tickColour = {r = 255, g = 255, b = 255, a = 255}

CompassConfig.compass.needle.show = true
CompassConfig.compass.needle.textSize = 0.20
CompassConfig.compass.needle.textOffset = 0.03
CompassConfig.compass.needle.textColour = {r = 255, g = 255, b = 255, a = 255}
CompassConfig.compass.needle.needleSize = {w = 0.0015, h = 0.018}
CompassConfig.compass.needle.needleColour ={r = 255, g = 255, b = 255, a = 255}

CompassConfig.streetName = {}

-- Configuration. Please be careful when editing. It does not check for errors.
CompassConfig.streetName.show = false
CompassConfig.streetName.position = {x = 0.5, y = 0.015, centered = true}
CompassConfig.streetName.textSize = 0.35
CompassConfig.streetName.textColour = {r = 255, g = 255, b = 255, a = 255}


-- DrawText method wrapper, draws text to the screen.
-- @param1	string	The text to draw
-- @param2	float	Screen x-axis coordinate
-- @param3	float	Screen y-axis coordinate
-- @param4	table	Optional. Styles to apply to the text
-- @return  void
function drawStyledText(str, x, y, style)
    if style == nil then
        style = {}
    end

    SetTextFont((style.font ~= nil) and style.font or 0)
    SetTextScale(0.0, (style.size ~= nil) and style.size or 1.0)
    SetTextProportional(1)

    if style.colour ~= nil then
        SetTextColour(style.colour.r ~= nil and style.colour.r or 255, style.colour.g ~= nil and style.colour.g or 255, style.colour.b ~= nil and style.colour.b or 255, style.colour.a ~= nil and style.colour.a or 255)
    else
        SetTextColour(255, 255, 255, 255)
    end

    if style.shadow ~= nil then
        SetTextDropShadow(style.shadow.distance ~= nil and style.shadow.distance or 0, style.shadow.r ~= nil and style.shadow.r or 0, style.shadow.g ~= nil and style.shadow.g or 0, style.shadow.b ~= nil and style.shadow.b or 0, style.shadow.a ~= nil and style.shadow.a or 255)
    else
        SetTextDropShadow(0, 0, 0, 0, 255)
    end

    if style.border ~= nil then
        SetTextEdge(style.border.size ~= nil and style.border.size or 1, style.border.r ~= nil and style.border.r or 0, style.border.g ~= nil and style.border.g or 0, style.border.b ~= nil and style.border.b or 0, style.border.a ~= nil and style.shadow.a or 255)
    end

    if style.centered ~= nil and style.centered == true then
        SetTextCentre(true)
    end

    if style.outline ~= nil and style.outline == true then
        SetTextOutline()
    end

    SetTextEntry("STRING")
    AddTextComponentString(str)

    DrawText(x, y)
end

-- Converts degrees to (inter)cardinal directions.
-- @param1	float	Degrees. Expects EAST to be 90° and WEST to be 270°.
-- 					In GTA, WEST is usually 90°, EAST is usually 270°. To convert, subtract that value from 360.
--
-- @return			The converted (inter)cardinal direction.
function degreesToIntercardinalDirection( dgr )
    dgr = dgr % 360.0

    if (dgr >= 0.0 and dgr < 22.5) or dgr >= 337.5 then
        return "N "
    elseif dgr >= 22.5 and dgr < 67.5 then
        return "NE"
    elseif dgr >= 67.5 and dgr < 112.5 then
        return "E"
    elseif dgr >= 112.5 and dgr < 157.5 then
        return "SE"
    elseif dgr >= 157.5 and dgr < 202.5 then
        return "S"
    elseif dgr >= 202.5 and dgr < 247.5 then
        return "SW"
    elseif dgr >= 247.5 and dgr < 292.5 then
        return "W"
    elseif dgr >= 292.5 and dgr < 337.5 then
        return "NW"
    end
end

-- Rounds a number to the closest integer
-- @param1 number to be rounded
-- @param2 decimal places to round
--
-- @return rounded number
function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num + 0.5 * mult)
end

local showCompass = false
RegisterCommand("compass",function()
	if not showCompass then 
		notify("~g~Compass turned on!")
		showCompass = true
	else
		notify("~r~Compass turned off!")
		showCompass = false
	end
end)

local function func_compass() 
	if showCompass then

		local pxDegree = CompassConfig.compass.width / CompassConfig.compass.fov
		local playerHeadingDegrees = 0

		if CompassConfig.compass.followGameplayCam then
			-- Converts [-180, 180] to [0, 360] where E = 90 and W = 270
			local camRot = Citizen.InvokeNative(0x837765A25378F0BB, 0, Citizen.ResultAsVector())
			playerHeadingDegrees = 360.0 - ((camRot.z + 360.0) % 360.0)
		else
			-- Converts E = 270 to E = 90
			playerHeadingDegrees = 360.0 - GetEntityHeading(GetPlayerPed(-1))
		end

		local tickDegree = playerHeadingDegrees - CompassConfig.compass.fov / 2
		local tickDegreeRemainder = CompassConfig.compass.ticksBetweenCardinals - (tickDegree % CompassConfig.compass.ticksBetweenCardinals)
		local tickPosition = CompassConfig.compass.position.x + tickDegreeRemainder * pxDegree

		tickDegree = tickDegree + tickDegreeRemainder

		while tickPosition < CompassConfig.compass.position.x + CompassConfig.compass.width do
			if (tickDegree % 90.0) == 0 then
				-- Draw cardinal
				if CompassConfig.compass.cardinal.tickShow then
					DrawRect(tickPosition, CompassConfig.compass.position.y, CompassConfig.compass.cardinal.tickSize.w, CompassConfig.compass.cardinal.tickSize.h, CompassConfig.compass.cardinal.tickColour.r, CompassConfig.compass.cardinal.tickColour.g, CompassConfig.compass.cardinal.tickColour.b, CompassConfig.compass.cardinal.tickColour.a)
				end

				drawStyledText(degreesToIntercardinalDirection(tickDegree), tickPosition, CompassConfig.compass.position.y + CompassConfig.compass.cardinal.textOffset, {
					size = CompassConfig.compass.cardinal.textSize,
					colour = CompassConfig.compass.cardinal.textColour,
					outline = true,
					centered = true
				})
			elseif (tickDegree % 45.0) == 0 and CompassConfig.compass.intercardinal.show then
				-- Draw intercardinal
				if CompassConfig.compass.intercardinal.tickShow then
					DrawRect(tickPosition, CompassConfig.compass.position.y, CompassConfig.compass.intercardinal.tickSize.w, CompassConfig.compass.intercardinal.tickSize.h, CompassConfig.compass.intercardinal.tickColour.r, CompassConfig.compass.intercardinal.tickColour.g, CompassConfig.compass.intercardinal.tickColour.b, CompassConfig.compass.intercardinal.tickColour.a)
				end

				if CompassConfig.compass.intercardinal.textShow then
					drawStyledText(degreesToIntercardinalDirection(tickDegree), tickPosition, CompassConfig.compass.position.y + CompassConfig.compass.intercardinal.textOffset, {
						size = CompassConfig.compass.intercardinal.textSize,
						colour = CompassConfig.compass.intercardinal.textColour,
						outline = true,
						centered = true
					})
				end
			else
				-- Draw tick
				DrawRect(tickPosition, CompassConfig.compass.position.y, CompassConfig.compass.tickSize.w, CompassConfig.compass.tickSize.h, CompassConfig.compass.tickColour.r, CompassConfig.compass.tickColour.g, CompassConfig.compass.tickColour.b, CompassConfig.compass.tickColour.a)
			end

			-- Advance to the next tick
			tickDegree = tickDegree + CompassConfig.compass.ticksBetweenCardinals
			tickPosition = tickPosition + pxDegree * CompassConfig.compass.ticksBetweenCardinals
		end

		if showCompass then
			drawStyledText(
				tostring(round(playerHeadingDegrees)),
				CompassConfig.compass.position.x + CompassConfig.compass.width / 2,
				CompassConfig.compass.position.y - CompassConfig.compass.needle.textOffset,
				{
					size = CompassConfig.compass.needle.textSize,
					colour = CompassConfig.compass.needle.textColour,
					outline = true,
					centered = true
				}
			)
			DrawRect(
				CompassConfig.compass.position.x + CompassConfig.compass.width / 2,
				CompassConfig.compass.position.y,
				CompassConfig.compass.needle.needleSize.w,
				CompassConfig.compass.needle.needleSize.h,
				CompassConfig.compass.needle.needleColour.r,
				CompassConfig.compass.needle.needleColour.g,
				CompassConfig.compass.needle.needleColour.b,
				CompassConfig.compass.needle.needleColour.a
			)
		end

	end
end


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		func_compass()
	end
end)

