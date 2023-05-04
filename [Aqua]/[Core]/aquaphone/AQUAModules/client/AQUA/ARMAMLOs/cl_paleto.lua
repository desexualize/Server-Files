Citizen.CreateThread(function()


RequestIpl("paleto_garage_milo_")

	local interiorID = GetInteriorAtCoords(79.208, 6525.550, 30.227)
	
	
	if IsValidInterior(interiorID) then
	EnableInteriorProp(interiorID, "walls_02")
	SetInteriorPropColor(interiorID, "walls_02", 8)
	EnableInteriorProp(interiorID, "Furnishings_02")
	SetInteriorPropColor(interiorID, "Furnishings_02", 8)
	EnableInteriorProp(interiorID, "decorative_02")
	EnableInteriorProp(interiorID, "mural_03")
	EnableInteriorProp(interiorID, "lower_walls_default")
	SetInteriorPropColor(interiorID, "lower_walls_default", 8)
	EnableInteriorProp(interiorID, "mod_booth")
	EnableInteriorProp(interiorID, "gun_locker")
	EnableInteriorProp(interiorID, "cash_small")
	EnableInteriorProp(interiorID, "id_small")
	EnableInteriorProp(interiorID, "weed_small")
	
	RefreshInterior(interiorID)
	
	end
	
end)
