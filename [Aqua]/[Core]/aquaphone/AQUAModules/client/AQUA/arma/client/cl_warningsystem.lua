local a = {}
local b = 0
local c = false
function func_f10warnings()
	if not recordingMode then
		if IsControlJustPressed(0, 57) then
			if IsUsingKeyboard(2) then
				if not c then
					TriggerServerEvent("arma:refreshWarningSystem")
					SendNUIMessage({type = "showF10"})
					c = not c
					SetNuiFocus(true, true)
				else
					SendNUIMessage({type = "hideF10"})
					c = not c
					SetNuiFocus(false, false)
				end
			end
		end
	end
end
tARMA.createThreadOnTick(func_f10warnings)
RegisterNetEvent("arma:recievedRefreshedWarningData",function(d, e)
	a = d
	SendNUIMessage({type = "sendWarnings", warnings = json.encode(a), points = e})
end)

RegisterNetEvent("arma:showWarningsOfUser",function(d, e)
	a = d
	SendNUIMessage({type = "sendWarnings", warnings = json.encode(a), points = e})
	SendNUIMessage({type = "showF10"})
	c = true
	SetNuiFocus(true, true)
end)