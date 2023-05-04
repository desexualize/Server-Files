local Faction_Colours = {
	['LFB'] = 6,
	['NHS'] = 121,
	['HMP'] = 136,
	['MPD'] = 175,
}

exports('Get_Faction_Notification_Colour', function(faction_name)
	return Faction_Colours[faction_name]
end)