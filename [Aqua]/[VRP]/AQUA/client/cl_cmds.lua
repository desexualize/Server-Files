RegisterNetEvent("SendToStaffClient")
AddEventHandler("SendToStaffClient", function(staffmessage, src, ifMessage)
	TriggerServerEvent("SendToStaff", staffmessage, src, ifMessage)
end)



