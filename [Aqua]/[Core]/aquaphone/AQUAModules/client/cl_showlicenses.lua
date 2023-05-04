local showMenu = false
local licenses = {}
local rowCounter = 0

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(0, 167) then
            showMenu = not showMenu
            if showMenu then
                TriggerServerEvent("AQUA:RequestLicenses")
            end
        end
        if showMenu then
            DrawRect(0.50, 0.222, 0.223, 0.075, 16, 86, 229, 255)
            DrawAdvancedText(0.595, 0.217, 0.005, 0.0028, 0.7, " Licenses", 255, 255, 255, 255, 6, 0)
            DrawAdvancedText(0.595, 0.275, 0.005, 0.0028, 0.4, "Licenses Owned", 0, 255, 50, 255, 6, 0)
            DrawRect(0.50, 0.272, 0.223, 0.026, 0, 0, 0, 222)
            for k, v in pairs(licenses) do
                DrawAdvancedText(0.595,0.306+(rowCounter * 0.033), 0.005,0.0028,0.4, v, 255,255,255,255,6,0)
                DrawRect(0.50, 0.301+(rowCounter * 0.033), 0.223, 0.033, 0, 0, 0, 120)
                rowCounter = rowCounter + 1
            end
            rowCounter = 0
        end
    end
end)

RegisterNetEvent("AQUA:RecieveLicenses")
AddEventHandler("AQUA:RecieveLicenses", function(table)
    licenses = table
end)

function DrawAdvancedText(x, y, w, h, sc, text, r, g, b, a, font, jus)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(sc, sc)
	N_0x4e096588b13ffeca(jus)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextEntry("STRING")
    AddTextComponentString(text)
	DrawText(x - 0.1+w, y - 0.02+h)
end