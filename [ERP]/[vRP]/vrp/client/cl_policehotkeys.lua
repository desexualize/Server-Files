-- Drag Hot Key
Citizen.CreateThread(function()
  while true do
  	Citizen.Wait(0)
	    if IsControlPressed(1, 19) and IsControlJustPressed(1,90) then -- LEFTALT + D
		    TriggerServerEvent('Element:Drag')
		end
	end
end)

-- Cuff Hot Key
Citizen.CreateThread(function()
  while true do
  	Citizen.Wait(0)
	    if IsControlPressed(1, 344) then -- F11
		    TriggerServerEvent('ERP:Handcuff')
		end
	end
end)