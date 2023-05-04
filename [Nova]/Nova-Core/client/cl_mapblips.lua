local map_blips = {
	{name = 'Weed Collect', position = vector3(379.64025878906, -822.19964599609, 29.302747726443), sprite = 496, scale = 0.4, display = 2, colour = 2, short_range = true},
	{name = 'Weed Process', position = vector3(1386.564453125, -2151.8374023438, 58.038352966309), sprite = 496, scale = 0.4, display = 2, colour = 2, short_range = true},
	{name = 'Weed Seller', position = vector3(-1068.9890136719, -1673.1114501953, 4.4917488098145), sprite = 496, scale = 0.5, display = 2, colour = 2, short_range = true},

	{name = 'Heroin Collect', position = vector3(-101.45708465576, 1910.0391845703, 196.92016601562), sprite = 586, scale = 0.6, display = 2, colour = 1, short_range = true},
	{name = 'Heroin Process', position = vector3(57.049602508545, 3715.7570800781, 39.754947662354), sprite = 586, scale = 0.6, display = 2, colour = 1, short_range = true},
	{name = 'Heroin Seller', position = vector3(3587.712890625, 3667.6076660156, 33.878574371338), sprite = 586, scale = 0.8, display = 2, colour = 1, short_range = true},

	{name = 'LSD Collect', position = vector3(2310.61328125, 5132.2709960938, 50.357967376709), sprite = 51, scale = 0.4, display = 2, colour = 7, short_range = true},
	{name = 'LSD Process', position = vector3(1319.6623535156, 4314.6567382812, 38.220794677734), sprite = 51, scale = 0.4, display = 2, colour = 7, short_range = true},
	 {name = 'LSD Seller', position = vector3(2483.0139160156, -417.52142333984, 93.735191345215), sprite = 51, scale = 0.6, display = 2, colour = 7, short_range = true},

	{name = 'Diamond Collect', position = vector3(846.66760253906, 2364.5771484375, 53.344337463379), sprite = 617, scale = 0.5, display = 2, colour = 3, short_range = true},
	{name = 'Diamond Process', position = vector3(2737.0910644531, 1531.8679199219, 31.610555648804), sprite = 617, scale = 0.5, display = 2, colour = 3, short_range = true},
	{name = 'Diamond Seller', position = vector3(2448.0822753906, 4990.8056640625, 46.542667388916), sprite = 617, scale = 0.5, display = 2, colour = 3, short_range = true},

	{name = 'Iron Collect', position = vector3(2378.4382324219, 3075.1950683594, 48.158790588379), sprite = 618, scale = 0.4, display = 2, colour = 39, short_range = true},
	{name = 'Iron Process', position = vector3(286.71951293945, 2861.4287109375, 43.642433166504), sprite = 618, scale = 0.4, display = 2, colour = 39, short_range = true},
	{name = 'Iron Seller', position = vector3(1069.1505126953, -3232.8176269531, 5.8964853286743), sprite = 618, scale = 0.4, display = 2, colour = 39, short_range = true},

	{name = 'Scrap Collect', position = vector3(-484.00527954102, -1737.2058105469, 18.602006912231), sprite = 68, scale = 0.6, display = 2, colour = 31, short_range = true},
	{name = 'Scrap Seller', position = vector3(-321.6184387207, -1545.5262451172, 31.019920349121), sprite = 68, scale = 0.6, display = 2, colour = 31, short_range = true},

	{name = 'License Centre', position = vector3(1701.4835205078, 3783.9167480469, 34.766910552979), sprite = 457, scale = 0.8, display = 2, colour = 2, short_range = true},
	{name = 'License Centre', position = vector3(-533.4521484375, -193.54820251465, 38.22241973877), sprite = 457, scale = 0.8, display = 2, colour = 2, short_range = true},
	--{name = 'Illegal License Centre', position = vector3(2437.3620605469, 4966.5756835938, 42.347606658936), sprite = 457, scale = 0.8, display = 2, colour = 1, short_range = true},

    {name = 'Heroin Turf', position = vector3(3580.8835449219, 3647.9147949219, 33.888610839844), sprite = 466, scale = 0.5, display = 2, colour = 1, short_range = true},
	{name = 'Large Arms Turf', position = vector3(-1101.0473632812, 4940.7080078125, 218.35414123535), sprite = 466, scale = 0.5, display = 2, colour = 1, short_range = true},
	{name = 'LSD Turf', position = vector3(2477.8503417969, -420.83367919922, 93.735191345215), sprite = 466, scale = 0.5, display = 2, colour = 1, short_range = true},

	{name = 'Police Station', position = vector3(447.23001098633, -985.09289550781, 30.689598083496), sprite = 60, scale = 0.6, display = 2, colour = 3, short_range = true},
	--{name = 'Banker Job', position = vector3(132.80426025391, -1028.3409423828, 29.356098175049), sprite = 431, scale = 0.8, display = 2, colour = 5, short_range = true},

	{name = 'City Hospital', position = vector3(308.84286499023, -592.34204101562, 43.284061431885), sprite = 80, scale = 0.6, display = 2, colour = 2, short_range = true},
	{name = 'Sandy Hospital', position = vector3(1832.9547119141, 3682.9191894531, 34.270072937012), sprite = 80, scale = 0.6, display = 2, colour = 2, short_range = true},
	{name = 'Paleto Hospital', position = vector3(-254.43467712402, 6332.3833007812, 32.42724609375), sprite = 80, scale = 0.6, display = 2, colour = 2, short_range = true},

	{name = 'VIP Island Teleport', position = vector3(145.96948242188, -1059.0294189453, 30.186124801636), sprite = 674, scale = 0.5, display = 2, colour = 46, short_range = true},
	{name = 'VIP Island Teleport', position = vector3(2709.0324707031, 3452.2468261719, 55.54606628418), sprite = 674, scale = 0.5, display = 2, colour = 46, short_range = true},
	{name = 'VIP Island Teleport', position = vector3(-229.5897064209, 6332.1860351562, 32.407524108887), sprite = 674, scale = 0.5, display = 2, colour = 46, short_range = true},

	{name = 'Ramps 1v1', position = vector3(-940.94885253906, -791.77227783203, 15.951024055481), sprite = 675, scale = 0.5, display = 2, colour = 47, short_range = true},
	{name = 'Ramps 1v1', position = vector3(685.94305419922, 577.88323974609, 130.46101379395), sprite = 675, scale = 0.5, display = 2, colour = 47, short_range = true},
}

Citizen.CreateThread(function()
	for index, info in pairs(map_blips) do
		local blip = AddBlipForCoord(info.position)
		SetBlipSprite(blip, info.sprite)
		SetBlipScale(blip, info.scale)
		SetBlipDisplay(blip, info.display)
		SetBlipColour(blip, info.colour)
		SetBlipAsShortRange(blip, info.short_range)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentSubstringPlayerName(info.name)
		EndTextCommandSetBlipName(blip)
	end
end)