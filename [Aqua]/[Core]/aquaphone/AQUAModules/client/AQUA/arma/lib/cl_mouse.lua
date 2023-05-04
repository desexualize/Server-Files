-- simple_cursor_driver_for_FiveReborn
mousedrw = 0				-- mousedrw-is_mouse_drawing 
mousex, mousey = 0.0,0.0	-- default_position (the_left-top_corner_of_the_screen)

function CursorInZone(zonex, zoney, zonex1, zoney1) -- made_it_bitch xD
	if mousedrw == 1 and mousex > zonex and mousex < zonex1 and mousey > zoney and mousey < zoney1 then
		return true
	else
		return false
	end
end

function setCursor(show) 
	mousedrw = show
	--print("Cursor changed to " .. tostring(show))
end

function CursorInArea(x, x2, y, y2) -- left, right, top, bottom
	if mousex > x and mousex < x2 and mousey > y and mousey < y2 then
		return true
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if mousedrw == 1 then
			mousex = GetControlNormal(2,239)
			mousey = GetControlNormal(2,240)
			-- hotfix_for_disabled_ctrl
			mousex_d = GetDisabledControlNormal(2,239)
			mousey_d = GetDisabledControlNormal(2,240)
			-- draw_the_cursor
			ShowCursorThisFrame()
			-- debugging_you_can_uncomment_this
			-- local mouse_txt = string.format("X:~b~ %f~n~~w~Y:~b~ %f",mousex, mousey)
			-- drawTxt(0.89, 0.065, 0, 0, 0.40,mouse_txt,255,255,255,255)
			-- print("x: " .. tostring(mousex) .. " y: " .. tostring(mousey))
		end
	end
end)

function drawTxt(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

Citizen.CreateThread(function()
    while not createThreadOnTick do
        Wait(0)
    end
    createThreadOnTick(func_disableGuiControls)
end)


function func_disableGuiControls()
    if inGUIARMA then
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
Citizen.CreateThread(function()
    while not tARMA.createThreadOnTick do
        Wait(0)
    end
    tARMA.createThreadOnTick(func_disableGuiControls)
end)
function GetArea(f, h, j, k)
    local l = f - j / 2
    local g = f + j / 2
    local m = h - k / 2
    local i = h + k / 2
    return l, g, m, i
end
