local colors = {
	{name = "Black", colorindex = 0},{name = "Carbon Black", colorindex = 147},
	{name = "Hraphite", colorindex = 1},{name = "Anhracite Black", colorindex = 11},
	{name = "Black Steel", colorindex = 2},{name = "Dark Steel", colorindex = 3},
	{name = "Silver", colorindex = 4},{name = "Bluish Silver", colorindex = 5},
	{name = "Rolled Steel", colorindex = 6},{name = "Shadow Silver", colorindex = 7},
	{name = "Stone Silver", colorindex = 8},{name = "Midnight Silver", colorindex = 9},
	{name = "Cast Iron Silver", colorindex = 10},{name = "Red", colorindex = 27},
	{name = "Torino Red", colorindex = 28},{name = "Formula Red", colorindex = 29},
	{name = "Lava Red", colorindex = 150},{name = "Blaze Red", colorindex = 30},
	{name = "Grace Red", colorindex = 31},{name = "Garnet Red", colorindex = 32},
	{name = "Sunset Red", colorindex = 33},{name = "Cabernet Red", colorindex = 34},
	{name = "Wine Red", colorindex = 143},{name = "Candy Red", colorindex = 35},
	{name = "Hot Pink", colorindex = 135},{name = "Pfsiter Pink", colorindex = 137},
	{name = "Salmon Pink", colorindex = 136},{name = "Sunrise Orange", colorindex = 36},
	{name = "Orange", colorindex = 38},{name = "Bright Orange", colorindex = 138},
	{name = "Gold", colorindex = 99},{name = "Bronze", colorindex = 90},
	{name = "Yellow", colorindex = 88},{name = "Race Yellow", colorindex = 89},
	{name = "Dew Yellow", colorindex = 91},{name = "Dark Green", colorindex = 49},
	{name = "Racing Green", colorindex = 50},{name = "Sea Green", colorindex = 51},
	{name = "Olive Green", colorindex = 52},{name = "Bright Green", colorindex = 53},
	{name = "Gasoline Green", colorindex = 54},{name = "Lime Green", colorindex = 92},
	{name = "Midnight Blue", colorindex = 141},
	{name = "Galaxy Blue", colorindex = 61},{name = "Dark Blue", colorindex = 62},
	{name = "Saxon Blue", colorindex = 63},{name = "Blue", colorindex = 64},
	{name = "Mariner Blue", colorindex = 65},{name = "Harbor Blue", colorindex = 66},
	{name = "Diamond Blue", colorindex = 67},{name = "Surf Blue", colorindex = 68},
	{name = "Nautical Blue", colorindex = 69},{name = "Racing Blue", colorindex = 73},
	{name = "Ultra Blue", colorindex = 70},{name = "Light Blue", colorindex = 74},
	{name = "Chocolate Brown", colorindex = 96},{name = "Bison Brown", colorindex = 101},
	{name = "Creeen Brown", colorindex = 95},{name = "Feltzer Brown", colorindex = 94},
	{name = "Maple Brown", colorindex = 97},{name = "Beechwood Brown", colorindex = 103},
	{name = "Sienna Brown", colorindex = 104},{name = "Saddle Brown", colorindex = 98},
	{name = "Moss Brown", colorindex = 100},{name = "Woodbeech Brown", colorindex = 102},
	{name = "Straw Brown", colorindex = 99},{name = "Sandy Brown", colorindex = 105},
	{name = "Bleached Brown", colorindex = 106},{name = "Schafter Purple", colorindex = 71},
	{name = "Spinnaker Purple", colorindex = 72},{name = "Midnight Purple", colorindex = 142},
	{name = "Bright Purple", colorindex = 145},{name = "Cream", colorindex = 107},
	{name = "Ice White", colorindex = 111},{name = "Frost White", colorindex = 112}}
local metalcolors = {
	{name = "Brushed Steel",colorindex = 117},
	{name = "Brushed Black Steel",colorindex = 118},
	{name = "Brushed Aluminum",colorindex = 119},
	{name = "Pure Gold",colorindex = 158},
	{name = "Brushed Gold",colorindex = 159}
}
local mattecolors = {
	{name = "Black", colorindex = 12},
	{name = "Gray", colorindex = 13},
	{name = "Light Gray", colorindex = 14},
	{name = "Ice White", colorindex = 131},
	{name = "Blue", colorindex = 83},
	{name = "Dark Blue", colorindex = 82},
	{name = "Midnight Blue", colorindex = 84},
	{name = "Midnight Purple", colorindex = 149},
	{name = "Schafter Purple", colorindex = 148},
	{name = "Red", colorindex = 39},
	{name = "Dark Red", colorindex = 40},
	{name = "Orange", colorindex = 41},
	{name = "Yellow", colorindex = 42},
	{name = "Lime Green", colorindex = 55},
	{name = "Green", colorindex = 128},
	{name = "Frost Green", colorindex = 151},
	{name = "Foliage Green", colorindex = 155},
	{name = "Olive Darb", colorindex = 152},
	{name = "Dark Earth", colorindex = 153},
	{name = "Desert Tan", colorindex = 154}
}



LSC_Config = {}
LSC_Config.prices = {}

--------Prices---------
LSC_Config.prices = {

------Window tint------
	windowtint = {
		{ name = "Pure Black", tint = 1, price = 10000},
		{ name = "Darksmoke", tint = 2, price = 8000},
		{ name = "Lightsmoke", tint = 3, price = 6000},
		{ name = "Limo", tint = 4, price = 4000},
		{ name = "Green", tint = 5, price = 2000},
	},

-------Respray--------
----Primary color---
	--Chrome 
	chrome = {
		colors = {
			{name = "Chrome Color", colorindex = 120}
		},
		price = 25000
	},
	--Classic 
	classic = {
		colors = colors,
		price = 2000
	},
	--Matte 
	matte = {
		colors = mattecolors,
		price = 5000
	},
	--Metallic 
	metallic = {
		colors = colors,
		price = 3000
	},
	--Metals 
	metal = {
		colors = metalcolors,
		price = 3000
	},

----Secondary color---
	--Chrome 
	chrome2 = {
		colors = {
			{name = "Chrome Color", colorindex = 120}
		},
		price = 10000
	},
	--Classic 
	classic2 = {
		colors = colors,
		price = 200
	},
	--Matte 
	matte2 = {
		colors = mattecolors,
		price = 500
	},
	--Metallic 
	metallic2 = {
		colors = colors,
		price = 300
	},
	--Metals 
	metal2 = {
		colors = metalcolors,
		price = 300
	},

------Neon layout------
	neonlayout = {
		{name = "Front,Back and Sides", price = 5000},
	},
	--Neon color
	neoncolor = {
		{ name = "White", neon = {255,255,255}, price = 1000},
		{ name = "Blue", neon = {0,0,255}, price = 1000},
		{ name = "Electric Blue", neon = {0,150,255}, price = 1000},
		{ name = "Mint Green", neon = {50,255,155}, price = 1000},
		{ name = "Lime Green", neon = {0,255,0}, price = 1000},
		{ name = "Yellow", neon = {255,255,0}, price = 1000},
		{ name = "Golden Shower", neon = {204,204,0}, price = 1000},
		{ name = "Orange", neon = {255,128,0}, price = 1000},
		{ name = "Red", neon = {255,0,0}, price = 1000},
		{ name = "Pony Pink", neon = {255,102,255}, price = 1000},
		{ name = "Hot Pink",neon = {255,0,255}, price = 1000},
		{ name = "Purple", neon = {153,0,153}, price = 1000},
		{ name = "Brown", neon = {139,69,19}, price = 1000},
	},

	xenoncolor = {
		{ name = "White", xenon = 0, price = 1000},
		{ name = "Blue", xenon = 1, price = 1000},
		{ name = "Electric Blue", xenon = 2, price = 1000},
		{ name = "Mint Green", xenon = 3, price = 1000},
		{ name = "Lime Green", xenon = 4, price = 1000},
		{ name = "Yellow", xenon = 5, price = 1000},
		{ name = "Golden Shower", xenon = 6, price = 1000},
		{ name = "Orange", xenon = 7, price = 1000},
		{ name = "Red", xenon = 8, price = 1000},
		{ name = "Pony Pink", xenon = 9, price = 1000},
		{ name = "Hot Pink",xenon = 10, price = 1000},
		{ name = "Purple", xenon = 11, price = 1000},
		{ name = "Blacklight", xenon = 12, price = 1000},
	},

--------Plates---------
	plates = {
		{ name = "Blue on White 1", plateindex = 0, price = 2000},
		{ name = "Blue On White 2", plateindex = 3, price = 2000},
		{ name = "Blue On White 3", plateindex = 4, price = 2000},
		{ name = "Yellow on Blue", plateindex = 2, price = 3000},
		{ name = "Yellow on Black", plateindex = 1, price = 6000},
	},
	
--------Wheels--------
----Wheel accessories----
	wheelaccessories = {
		{ name = "Stock Tires", price = 1000},
		{ name = "Custom Tires", price = 12050},
		{ name = "White Tire Smoke",smokecolor = {254,254,254}, price = 3000},
		{ name = "Black Tire Smoke", smokecolor = {1,1,1}, price = 3000},
		{ name = "Blue Tire Smoke", smokecolor = {0,150,255}, price = 3000},
		{ name = "Yellow Tire Smoke", smokecolor = {255,255,50}, price = 3000},
		{ name = "Orange Tire Smoke", smokecolor = {255,153,51}, price = 3000},
		{ name = "Red Tire Smoke", smokecolor = {255,10,10}, price = 3000},
		{ name = "Green Tire Smoke", smokecolor = {10,255,10}, price = 3000},
		{ name = "Purple Tire Smoke", smokecolor = {153,10,153}, price = 3000},
		{ name = "Pink Tire Smoke", smokecolor = {255,102,178}, price = 3000},
		{ name = "Gray Tire Smoke",smokecolor = {128,128,128}, price = 3000},
	},

----Wheel color----
	wheelcolor = {
		colors = colors,
		price = 1000,
	},

----Front wheel (Bikes)----
	frontwheel = {
		{name = "Stock", wtype = 6, mod = -1, price = 5000},
		{name = "Speedway", wtype = 6, mod = 0, price = 5000},
		{name = "Streetspecial", wtype = 6, mod = 1, price = 5000},
		{name = "Racer", wtype = 6, mod = 2, price = 5000},
		{name = "Trackstar", wtype = 6, mod = 3, price = 5000},
		{name = "Overlord", wtype = 6, mod = 4, price = 5000},
		{name = "Trident", wtype = 6, mod = 5, price = 5000},
		{name = "Triplethreat", wtype = 6, mod = 6, price = 5000},
		{name = "Stilleto", wtype = 6, mod = 7, price = 5000},
		{name = "Wires", wtype = 6, mod = 8, price = 5000},
		{name = "Bobber", wtype = 6, mod = 9, price = 5000},
		{name = "Solidus", wtype = 6, mod = 10, price = 5000},
		{name = "Iceshield", wtype = 6, mod = 11, price = 5000},
		{name = "Loops", wtype = 6, mod = 12, price = 5000},
	},

----Back wheel (Bikes)-----
	backwheel = {
		{name = "Stock", wtype = 6, mod = -1, price = 5000},
		{name = "Speedway", wtype = 6, mod = 0, price = 5000},
		{name = "Streetspecial", wtype = 6, mod = 1, price = 5000},
		{name = "Racer", wtype = 6, mod = 2, price = 5000},
		{name = "Trackstar", wtype = 6, mod = 3, price = 5000},
		{name = "Overlord", wtype = 6, mod = 4, price = 5000},
		{name = "Trident", wtype = 6, mod = 5, price = 5000},
		{name = "Triplethreat", wtype = 6, mod = 6, price = 5000},
		{name = "Stilleto", wtype = 6, mod = 7, price = 5000},
		{name = "Wires", wtype = 6, mod = 8, price = 5000},
		{name = "Bobber", wtype = 6, mod = 9, price = 5000},
		{name = "Solidus", wtype = 6, mod = 10, price = 5000},
		{name = "Iceshield", wtype = 6, mod = 11, price = 5000},
		{name = "Loops", wtype = 6, mod = 12, price = 5000},
	},

----Sport wheels-----
	sportwheels = {
		{name = "Stock", wtype = 0, mod = -1, price = 6000},
		{name = "Inferno", wtype = 0, mod = 0, price = 6000},
		{name = "Deepfive", wtype = 0, mod = 1, price = 6000},
		{name = "Lozspeed", wtype = 0, mod = 2, price = 6000},
		{name = "Diamondcut", wtype = 0, mod = 3, price = 6000},
		{name = "Chrono", wtype = 0, mod = 4, price = 6000},
		{name = "Feroccirr", wtype = 0, mod = 5, price = 6000},
		{name = "Fiftynine", wtype = 0, mod = 6, price = 6000},
		{name = "Mercie", wtype = 0, mod = 7, price = 6000},
		{name = "Syntheticz", wtype = 0, mod = 8, price = 6000},
		{name = "Organictyped", wtype = 0, mod = 9, price = 6000},
		{name = "Endov1", wtype = 0, mod = 10, price = 6000},
		{name = "Duper7", wtype = 0, mod = 11, price = 6000},
		{name = "Uzer", wtype = 0, mod = 12, price = 6000},
		{name = "Groundride", wtype = 0, mod = 13, price = 6000},
		{name = "Spacer", wtype = 0, mod = 14, price = 6000},
		{name = "Venum", wtype = 0, mod = 15, price = 6000},
		{name = "Cosmo", wtype = 0, mod = 16, price = 6000},
		{name = "Dashvip", wtype = 0, mod = 17, price = 6000},
		{name = "Icekid", wtype = 0, mod = 18, price = 6000},
		{name = "Ruffeld", wtype = 0, mod = 19, price = 6000},
		{name = "Wangenmaster", wtype = 0, mod = 20, price = 6000},
		{name = "Superfive", wtype = 0, mod = 21, price = 6000},
		{name = "Endov2", wtype = 0, mod = 22, price = 6000},
		{name = "Slitsix", wtype = 0, mod = 23, price = 6000},
	},
-----Suv wheels------
	suvwheels = {
		{name = "Stock", wtype = 3, mod = -1, price = 5500},
		{name = "Vip", wtype = 3, mod = 0, price = 5500},
		{name = "Benefactor", wtype = 3, mod = 1, price = 5500},
		{name = "Cosmo", wtype = 3, mod = 2, price = 5500},
		{name = "Bippu", wtype = 3, mod = 3, price = 5500},
		{name = "Royalsix", wtype = 3, mod = 4, price = 5500},
		{name = "Fagorme", wtype = 3, mod = 5, price = 5500},
		{name = "Deluxe", wtype = 3, mod = 6, price = 5500},
		{name = "Icedout", wtype = 3, mod = 7, price = 5500},
		{name = "Cognscenti", wtype = 3, mod = 8, price = 5500},
		{name = "Lozspeedten", wtype = 3, mod = 9, price = 5500},
		{name = "Supernova", wtype = 3, mod = 10, price = 5500},
		{name = "Obeyrs", wtype = 3, mod = 11, price = 5500},
		{name = "Lozspeedballer", wtype = 3, mod = 12, price = 5500},
		{name = "Extra vaganzo", wtype = 3, mod = 13, price = 5500},
		{name = "Splitsix", wtype = 3, mod = 14, price = 5500},
		{name = "Empowered", wtype = 3, mod = 15, price = 5500},
		{name = "Sunrise", wtype = 3, mod = 16, price = 5500},
		{name = "Dashvip", wtype = 3, mod = 17, price = 5500},
		{name = "Cutter", wtype = 3, mod = 18, price = 5500},
	},
-----Offroad wheels-----
	offroadwheels = {
		{name = "Stock", wtype = 4, mod = -1, price = 5000},
		{name = "Raider", wtype = 4, mod = 0, price = 5000},
		{name = "Mudslinger", wtype = 4, modtype = 23, wtype = 4, mod = 1, price = 5000},
		{name = "Nevis", wtype = 4, mod = 2, price = 5000},
		{name = "Cairngorm", wtype = 4, mod = 3, price = 5000},
		{name = "Amazon", wtype = 4, mod = 4, price = 5000},
		{name = "Challenger", wtype = 4, mod = 5, price = 5000},
		{name = "Dunebasher", wtype = 4, mod = 6, price = 5000},
		{name = "Fivestar", wtype = 4, mod = 7, price = 5000},
		{name = "Rockcrawler", wtype = 4, mod = 8, price = 5000},
		{name = "Milspecsteelie", wtype = 4, mod = 9, price = 5000},
	},
-----Tuner wheels------
	tunerwheels = {
		{name = "Stock", wtype = 5, mod = -1, price = 5000},
		{name = "Cosmo", wtype = 5, mod = 0, price = 5000},
		{name = "Supermesh", wtype = 5, mod = 1, price = 5000},
		{name = "Outsider", wtype = 5, mod = 2, price = 5000},
		{name = "Rollas", wtype = 5, mod = 3, price = 5000},
		{name = "Driffmeister", wtype = 5, mod = 4, price = 5000},
		{name = "Slicer", wtype = 5, mod = 5, price = 5000},
		{name = "Elquatro", wtype = 5, mod = 6, price = 5000},
		{name = "Dubbed", wtype = 5, mod = 7, price = 5000},
		{name = "Fivestar", wtype = 5, mod = 8, price = 5000},
		{name = "Slideways", wtype = 5, mod = 9, price = 5000},
		{name = "Apex", wtype = 5, mod = 10, price = 5000},
		{name = "Stancedeg", wtype = 5, mod = 11, price = 5000},
		{name = "Countersteer", wtype = 5, mod = 12, price = 5000},
		{name = "Endov1", wtype = 5, mod = 13, price = 5000},
		{name = "Endov2dish", wtype = 5, mod = 14, price = 5000},
		{name = "Guppez", wtype = 5, mod = 15, price = 5000},
		{name = "Chokadori", wtype = 5, mod = 16, price = 5000},
		{name = "Chicane", wtype = 5, mod = 17, price = 5000},
		{name = "Saisoku", wtype = 5, mod = 18, price = 5000},
		{name = "Dishedeight", wtype = 5, mod = 19, price = 5000},
		{name = "Fujiwara", wtype = 5, mod = 20, price = 5000},
		{name = "Zokusha", wtype = 5, mod = 21, price = 5000},
		{name = "Battlevill", wtype = 5, mod = 22, price = 5000},
		{name = "Rallymaster", wtype = 5, mod = 23, price = 5000},
	},
-----Highend wheels------
	highendwheels = {
		{name = "Stock", wtype = 7, mod = -1, price = 5000},
		{name = "Shadow", wtype = 7, mod = 0, price = 7500},
		{name = "Hyper", wtype = 7, mod = 1, price = 7500},
		{name = "Blade", wtype = 7, mod = 2, price = 7500},
		{name = "Diamond", wtype = 7, mod = 3, price = 7500},
		{name = "Supagee", wtype = 7, mod = 4, price = 7500},
		{name = "Chromaticz", wtype = 7, mod = 5, price = 7500},
		{name = "Merciechlip", wtype = 7, mod = 6, price = 7500},
		{name = "Obeyrs", wtype = 7, mod = 7, price = 7500},
		{name = "Gtchrome", wtype = 7, mod = 8, price = 7500},
		{name = "Cheetahr", wtype = 7, mod = 9, price = 7500},
		{name = "Solar", wtype = 7, mod = 10, price = 7500},
		{name = "Splitten", wtype = 7, mod = 11, price = 7500},
		{name = "Dashvip", wtype = 7, mod = 12, price = 7500},
		{name = "Lozspeedten", wtype = 7, mod = 13, price = 7500},
		{name = "Carboninferno", wtype = 7, mod = 14, price = 7500},
		{name = "Carbonshadow", wtype = 7, mod = 15, price = 7500},
		{name = "Carbonz", wtype = 7, mod = 16, price = 7500},
		{name = "Carbonsolar", wtype = 7, mod = 17, price = 7500},
		{name = "Carboncheetahr", wtype = 7, mod = 18, price = 7500},
		{name = "Carbonsracer", wtype = 7, mod = 19, price = 7500},
	},
-----Lowrider wheels------
	lowriderwheels = {
		{name = "Stock", wtype = 2, mod = -1, price = 6000},
		{name = "Flare", wtype = 2, mod = 0, price = 6000},
		{name = "Wired", wtype = 2, mod = 1, price = 6000},
		{name = "Triplegolds", wtype = 2, mod = 2, price = 6000},
		{name = "Bigworm", wtype = 2, mod = 3, price = 6000},
		{name = "Sevenfives", wtype = 2, mod = 4, price = 6000},
		{name = "Splitsix", wtype = 2, mod = 5, price = 6000},
		{name = "Freshmesh", wtype = 2, mod = 6, price = 6000},
		{name = "Leadsled", wtype = 2, mod = 7, price = 6000},
		{name = "Turbine", wtype = 2, mod = 8, price = 6000},
		{name = "Superfin", wtype = 2, mod = 9, price = 6000},
		{name = "Classicrod", wtype = 2, mod = 10, price = 6000},
		{name = "Dollar", wtype = 2, mod = 11, price = 6000},
		{name = "Dukes", wtype = 2, mod = 12, price = 6000},
		{name = "Lowfive", wtype = 2, mod = 13, price = 6000},
		{name = "Gooch", wtype = 2, mod = 14, price = 6000},
	},
-----Muscle wheels-----
	musclewheels = {
		{name = "Stock", wtype = 1, mod = -1, price = 5500},
		{name = "Classicfive", wtype = 1, mod = 0, price = 5500},
		{name = "Dukes", wtype = 1, mod = 1, price = 5500},
		{name = "Musclefreak", wtype = 1, mod = 2, price = 5500},
		{name = "Kracka", wtype = 1, mod = 3, price = 5500},
		{name = "Azrea", wtype = 1, mod = 4, price = 5500},
		{name = "Mecha", wtype = 1, mod = 5, price = 5500},
		{name = "Blacktop", wtype = 1, mod = 6, price = 5500},
		{name = "Dragspl", wtype = 1, mod = 7, price = 5500},
		{name = "Revolver", wtype = 1, mod = 8, price = 5500},
		{name = "Classicrod", wtype = 1, mod = 9, price = 5500},
		{name = "Spooner", wtype = 1, mod = 10, price = 5500},
		{name = "Fivestar", wtype = 1, mod = 11, price = 5500},
		{name = "Oldschool", wtype = 1, mod = 12, price = 5500},
		{name = "Eljefe", wtype = 1, mod = 13, price = 5500},
		{name = "Dodman", wtype = 1, mod = 14, price = 5500},
		{name = "Sixgun", wtype = 1, mod = 15, price = 5500},
		{name = "Mercenary", wtype = 1, mod = 16, price = 5500},
	},
	
---------Trim color--------
	trim = {
		colors = colors,
		price = 1000
	},
	
----------Mods-----------
	mods = {
	
----------Liveries--------
	[48] = {
		startprice = 15000,
		increaseby = 2500
	},
	
----------Windows--------
	[46] = {
		startprice = 5000,
		increaseby = 1250
	},
	
----------Tank--------
	[45] = {
		startprice = 5000,
		increaseby = 1250
	},
	
----------Trim--------
	[44] = {
		startprice = 5000,
		increaseby = 1250
	},
	
----------Aerials--------
	[43] = {
		startprice = 5000,
		increaseby = 1250
	},

----------Arch cover--------
	[42] = {
		startprice = 5000,
		increaseby = 1250
	},

----------Struts--------
	[41] = {
		startprice = 5000,
		increaseby = 1250
	},
	
----------Air filter--------
	[40] = {
		startprice = 5000,
		increaseby = 1250
	},
	
----------Engine block--------
	[39] = {
		startprice = 5000,
		increaseby = 1250
	},

----------Hydraulics--------
	[38] = {
		startprice = 15000,
		increaseby = 2500
	},
	
----------Trunk--------
	[37] = {
		startprice = 5000,
		increaseby = 1250
	},

----------Speakers--------
	[36] = {
		startprice = 5000,
		increaseby = 1250
	},

----------Plaques--------
	[35] = {
		startprice = 5000,
		increaseby = 1250
	},
	
----------Shift leavers--------
	[34] = {
		startprice = 5000,
		increaseby = 1250
	},
	
----------Steeringwheel--------
	[33] = {
		startprice = 5000,
		increaseby = 1250
	},
	
----------Seats--------
	[32] = {
		startprice = 5000,
		increaseby = 1250
	},
	
----------Door speaker--------
	[31] = {
		startprice = 5000,
		increaseby = 1250
	},

----------Dial--------
	[30] = {
		startprice = 5000,
		increaseby = 1250
	},
----------Dashboard--------
	[29] = {
		startprice = 5000,
		increaseby = 1250
	},
	
----------Ornaments--------
	[28] = {
		startprice = 5000,
		increaseby = 1250
	},
	
----------Trim--------
	[27] = {
		startprice = 5000,
		increaseby = 1250
	},
	
----------Vanity plates--------
	[26] = {
		startprice = 5000,
		increaseby = 1250
	},
	
----------Plate holder--------
	[25] = {
		startprice = 5000,
		increaseby = 1250
	},
	
---------Headlights---------
	[22] = {
		{name = "Stock Lights", mod = 0, price = 0},
		{name = "Xenon Lights", mod = 1, price = 7500},
	},
	
----------Turbo---------
	[18] = {
		{ name = "None", mod = 0, price = 0},
		{ name = "Turbo Tuning", mod = 1, price = 250000},
	},
	
-----------Armor-------------
	[16] = {
		{name = "Armor Upgrade 20%",modtype = 16, mod = 0, price =  75000},
		{name = "Armor Upgrade 40%",modtype = 16, mod = 1, price =  150000},
		{name = "Armor Upgrade 60%",modtype = 16, mod = 2, price =  225000},
		{name = "Armor Upgrade 80%",modtype = 16, mod = 3, price =  300000},
		{name = "Armor Upgrade 100%",modtype = 16, mod = 4, price = 350000},
	},

---------Suspension-----------
	[15] = {
		{name = "Lowered Suspension",mod = 0, price = 100000},
		{name = "Street Suspension",mod = 1, price = 200000},
		{name = "Sport Suspension",mod = 2, price = 350000},
		{name = "Competition Suspension",mod = 3, price = 400000},
	},

-----------Horn----------
	[14] = {
		{name = "Truck Horn", mod = 0, price = 1234},
	},

----------Transmission---------
	[13] = {
		{name = "Street Transmission", mod = 0, price = 100000},
		{name = "Sports Transmission", mod = 1, price = 120000},
		{name = "Race Transmission", mod = 2, price = 150000},
	},
	
-----------Brakes-------------
	[12] = {
		{name = "Street Brakes", mod = 0, price = 	75000},
		{name = "Sport Brakes", mod = 1, price = 	175000},
		{name = "Race Brakes", mod = 2, price = 	275000},
	},
	
------------Engine----------
	[11] = {
		{name = "EMS Upgrade, Level 2", mod = 0, price = 75000},
		{name = "EMS Upgrade, Level 3", mod = 1, price = 200000},
		{name = "EMS Upgrade, Level 4", mod = 2, price = 250000},
	},
	
-------------Roof----------
	[10] = {
		startprice = 1250,
		increaseby = 400
	},
	
------------Fenders---------
	[8] = {
		startprice = 1500,
		increaseby = 400
	},
	
------------Hood----------
	[7] = {
		startprice = 1500,
		increaseby = 400
	},
	
----------Grille----------
	[6] = {
		startprice = 1250,
		increaseby = 400
	},
	
----------Roll cage----------
	[5] = {
		startprice = 1250,
		increaseby = 400
	},
	
----------Exhaust----------
	[4] = {
		startprice = 1000,
		increaseby = 400
	},
	
----------Skirts----------
	[3] = {
		startprice = 1250,
		increaseby = 400
	},
	
-----------Rear bumpers----------
	[2] = {
		startprice = 2500,
		increaseby = 500
	},
	
----------Front bumpers----------
	[1] = {
		startprice = 2500,
		increaseby = 500
	},
	
----------Spoiler----------
	[0] = {
		startprice = 2500,
		increaseby = 400
	},
	}
	
}

------Model Blacklist--------
--Does'nt allow specific vehicles to be upgraded
LSC_Config.ModelBlacklist = {
	"police",
}

--Sets if garage will be locked if someone is inside it already
LSC_Config.lock = true

-- Enable/disable using vRP_adv_garages
LSC_Config.vRP_adv_garages = false

--Enable/disable old entering way
LSC_Config.oldenter = true

--Menu settings
LSC_Config.menu = {

-------Controls--------
	controls = {
		menu_up = 27,
		menu_down = 173,
		menu_left = 174,
		menu_right = 175,
		menu_select = 201,
		menu_back = 177
	},

-------Menu position-----
	--Possible positions:
	--Left
	--Right
	--Custom position, example: position = {x = 0.2, y = 0.2}
	position = "left",

-------Menu theme--------
	--Possible themes: light, darkred, bluish, greenish
	--Custom example:
	--[[theme = {
		text_color = { r = 255,g = 255, b = 255, a = 255},
		bg_color = { r = 0,g = 0, b = 0, a = 155},
		--Colors when button is selected
		stext_color = { r = 0,g = 0, b = 0, a = 255},
		sbg_color = { r = 255,g = 255, b = 0, a = 200},
	},]]
	theme = "light",
	
--------Max buttons------
	--Default: 10
	maxbuttons = 10,

-------Size---------
	--[[
	Default:
	width = 0.24
	height = 0.36
	]]
	width = 0.24,
	height = 0.36

}








local Menu = setmetatable({}, Menu)
Menu.__index = Menu
function Menu.new(title,header,x,y,width,height,font)
	local newmenu = {
		visible = false,
		currentmenu = "main",
		lastmenu = {},
		selected = 1,
		from = 1,
		to = 10,
		maxbuttons = 10,
		title = title,
		title_sprite = nil,
		header = header,
		name = "main",
		buttons = {},
		config = {
			position = { x = x, y = y}, 
			size = {width = width, height = height},
			font = font,
			pcontrol = false,
			text_color = { r = 255,g = 255, b = 255, a = 255},
			bg_color = { r = 0,g = 0, b = 0, a = 155},
			stext_color = { r = 0,g = 0, b = 0, a = 255},
			sbg_color = { r = 255,g = 255, b = 255, a = 200},
			menu_name = true,
			controls = {
				menu_up = 27,
				menu_down = 173,
				menu_left = 174,
				menu_right = 175,
				menu_select = 201,
				menu_back = 177,
			}
		}
	}
	return setmetatable(newmenu,Menu)
end

function Menu:showNotification(txt)
	self.notification = nil
	Citizen.CreateThread(function()
		while self.notification ~= nil do
			Citizen.Wait(10)
		end
		self.notification = txt
		Citizen.Wait(1250)
		self.notification = nil
	end)
end

function Menu:setMaxButtons(n)
	self.to = n
	self.maxbuttons = n
end

function Menu:setColors(t_c,st_c,b_c,sb_c)
	self.config.text_color = t_c
	self.config.bg_color = b_c
	self.config.stext_color = st_c
	self.config.sbg_color = sb_c
end

function Menu:isVisible()
	return self.visible
end

function drawMenuText(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	--SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	--SetTextDropShadow()
	--SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x , y)	
end

function drawInfo(text,font,x,y,width,height,scale,r,g,b,a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextWrap(x - width/2.2,x+ width/2.2)
	l = GetLineCount(text,x - width/2.2, y - height/2.8)
	local lx, ly = x,y
	DrawRect(lx,  ly + 0.0025, width, height, 0,  0,  0,  180 ,0)	
	ly = ly+(scale/10)/2 + 0.011
	if l >1 then
		for i = 1,l do
			DrawRect(lx,  ly, width, (scale/10)/2, 0,  0,  0,  180,0)	
			ly = ly+(scale/10)/2
		end
	end
	SetTextColour(r, g, b, a)
	--SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	--SetTextDropShadow()
	--SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x - width/2.2, y - height/2.8)	
end

function drawRightMenuText(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextRightJustify(1)
	SetTextWrap(0.0,x)
	SetTextColour(r, g, b, a)
	--SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	--SetTextDropShadow()
	--SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x , y)	
	--ScreenDrawPositionEnd()
end

function Menu:config(t)
	if t then
		if t.pcontrol then
			self.config.pcontrol = t.pcontrol
		end
	end
end

function Menu:Open(name)
	if name ~=nil then
		if self.name ~= name then
			self.currentmenu = self[name]
		else
			self.currentmenu = name
		end
	end
	if self.OnMenuOpen ~= nil then
		self:OnMenuOpen(self)
	end
	self.visible = true
	self:draw()
	if not self.config.pcontrol then
		SetPlayerControl(PlayerId(), false,260)
	end
	Citizen.CreateThread(function()
		if not HasStreamedTextureDictLoaded("commonmenu") then
			RequestStreamedTextureDict("commonmenu")
			while not HasStreamedTextureDictLoaded("commonmenu") do
				Citizen.Wait(0)
			end
		end
		if not HasStreamedTextureDictLoaded("commonmenutu") then
			RequestStreamedTextureDict("commonmenutu")
			while not HasStreamedTextureDictLoaded("commonmenutu") do
				Citizen.Wait(0)
			end
		end
		if self.title_sprite then
			if not HasStreamedTextureDictLoaded(self.title_sprite) then
				RequestStreamedTextureDict(self.title_sprite)
				while not HasStreamedTextureDictLoaded(self.title_sprite) do
					Citizen.Wait(0)
				end
			end
		end
		--[[if not HasStreamedTextureDictLoaded("") then
			RequestStreamedTextureDict("")
			while not HasStreamedTextureDictLoaded("") do
				Citizen.Wait(0)
			end
		end]]
	end)
end

function Menu:ChangeMenu(name)
	if name ~= self.name then
		name = self[name]
	else
		name = self
	end
	if self.OnMenuChange ~= nil then
		self:OnMenuChange(self.currentmenu,name)
	end
	self.lastmenu[#self.lastmenu+1] = self.currentmenu
	self.currentmenu = name
end

function Menu:Close()
	if self.OnMenuClose ~= nil then
		self:OnMenuClose(self)
	end
	self.visible = false
	self.currentmenu = "main"
	self.selected = 1
	self.lastmenu = {}
	self.from = 1
	self.to = self.maxbuttons
	if not self.config.pcontrol then
		SetPlayerControl(PlayerId(), true)
	end
	if HasStreamedTextureDictLoaded("commonmenu") then
		SetStreamedTextureDictAsNoLongerNeeded("commonmenu")
	end
	if HasStreamedTextureDictLoaded("commonmenutu") then
		SetStreamedTextureDictAsNoLongerNeeded("commonmenutu")
	end
end

function Menu:addButton(name, args)
	local button = {}
	button.name = name 
	button.selected = false
	button.sprite = nil
	if args ~= nil then
		if not type(args) == 'table' then
			args = {args}
		end
		button.args = args
	end
	table.insert(self.buttons, button)
	return self.buttons[#self.buttons]
end

function Menu:addPurchase(name,price,info,args)
	local button = {}
	button.name = name 
	button.selected = false
	if args ~= nil then
		if not type(args) == 'table' then
			args = {args}
		end
		button.args = args
	end
	button.price = price or 0
	button.purchased = false
	button.sprite = nil
	button.info = info
	table.insert(self.buttons, button)
	return self.buttons[#self.buttons]
end


function Menu:addList(name, list)
	local button = {}
	button.name = name 
	button.selected = false
	button.list = list
	button.sprite = nil
	button.listindex = 1
	table.insert(self.buttons, button)
	return self.buttons[#self.buttons]
end

function Menu:addCheckbox(name, b)
	local button = {}
	button.name = name 
	button.selected = false
	button.sprite = nil
	button.checkbox = b
	table.insert(self.buttons, button)
	return self.buttons[#self.buttons]
end

function Menu:removeButton(button)
	for i,btn in pairs(self.buttons) do
		if btn == button then
			buttons[i] = nil
			break
		end
	end
end



function Menu:OnButtonListChange(button)
	if button then

	end
end

function Menu:addSubMenu(header,name,info,addbtn)
	if self[name] ~= nil then
	setmetatable(getmetatable(self[name]),nil)
	self[name] = nil
	end
	local submenu = {
		buttons = {},
		header = header,
		name = name,
		parent = self.name,
		selected = 1,
		from = 1,
		to = self.maxbuttons,
		maxbuttons = self.maxbuttons
	}
	if info then
		submenu.info = info
	end
	self[name] = submenu
	for i,btn in pairs(self.buttons) do
		if btn.menu and btn.menu.name == name then
			addbtn = false
		end
	end
	if addbtn then
		table.insert(self.buttons, { name = name, selected = false, menu = self[name], info = info })
	end
	return setmetatable(self[name],Menu)
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function Menu:draw()
	Citizen.CreateThread(function()
	local menu
	local buttons
	local lastselect = nil
		while self.visible do
			Citizen.Wait(0)
	
			local cfg = self.config
			local size = cfg.size
			local width = size.width 
			local height = size.height 
			height = height/self.maxbuttons
			local scale = cfg.scale
			scale = height/0.1
			local x = cfg.position.x
			local y = cfg.position.y
			local tx = x
			local ty = y
			--tx = tx - 
			--Title
			if self.title_sprite then
				DrawSprite(self.title_sprite, self.title_sprite, x,  y - 0.039, width, height + 0.08, 0.00,255,255,255,255)
			else
				drawMenuText(self.title,1,1,tx,ty - height -0.009,scale*2.4,cfg.stext_color.r,cfg.stext_color.g,cfg.stext_color.b,cfg.stext_color.a)
				DrawRect(x,  y - 0.019, width, height + 0.04,cfg.sbg_color.r,cfg.sbg_color.g,cfg.sbg_color.b,cfg.sbg_color.a,0)
			end
			y = y + height
			ty = y - height/2.8
			tx = tx - (width/2.2)
				
			--Buttons
			if self.currentmenu == "main" then
				menu = self
			else
				menu = self.currentmenu
			end
			if menu == nil then
				return
			end
			buttons = menu.buttons
			--menu info
			if self.header then
				drawMenuText(menu.header:upper(),cfg.font,0,tx,ty,scale,cfg.text_color.r,cfg.text_color.g,cfg.text_color.b,cfg.text_color.a)
			end
			drawRightMenuText(menu.selected..'/'..tablelength(menu.buttons),cfg.font,0,x + (width/2.1),ty,scale,cfg.text_color.r,cfg.text_color.g,cfg.text_color.b,cfg.text_color.a)
			DrawRect(x,  y, width, height,cfg.bg_color.r,cfg.bg_color.g,cfg.bg_color.b,255,0)
			y = y + height
			ty = y - height/2.8
			
				for i,btn in pairs(buttons) do
					if i >= menu.from and i <= menu.to then
						if menu.selected == i then
							if lastselect ~= menu.selected then
								lastselect = menu.selected
								if self.onSelectedIndexChanged ~= nil then
									self:onSelectedIndexChanged(btn.name,btn)
								end
							end
							drawMenuText(btn.name,cfg.font,0,tx,ty,scale,cfg.stext_color.r,cfg.stext_color.g,cfg.stext_color.b,cfg.stext_color.a)
							DrawRect(x,  y, width, height,cfg.sbg_color.r,cfg.sbg_color.g,cfg.sbg_color.b,cfg.sbg_color.a,0)
							if btn.sprite ~= nil then
								if btn.sprite == "garage" then
									DrawSprite("commonmenu", "shop_garage_icon_b", x + (width/2.4), y, scale/10 -0.01, scale/10 +0.01, 0.00,cfg.text_color.r,cfg.text_color.g,cfg.text_color.b,cfg.text_color.a)
								end
							elseif btn.price ~= nil then	
								if btn.price == 0 then
									drawRightMenuText("",cfg.font,0,x + (width/2.1),ty,scale,cfg.stext_color.r,cfg.stext_color.g,cfg.stext_color.b,cfg.stext_color.a)
								else
									if not btn.purchased then
										drawRightMenuText("£"..btn.price,cfg.font,0,x + (width/2.1),ty,scale,cfg.stext_color.r,cfg.stext_color.g,cfg.stext_color.b,cfg.stext_color.a)
									else
										drawRightMenuText("OWNED",cfg.font,0,x + (width/2.1),ty,scale,cfg.stext_color.r,cfg.stext_color.g,cfg.stext_color.b,cfg.stext_color.a)
									end
								end
							elseif btn.menu ~= nil then
									DrawSprite("commonmenutu", "arrowright", x + (width/2.2), y, scale/14 -0.01, scale/19 +0.01, 0.00,cfg.stext_color.r,cfg.stext_color.g,cfg.stext_color.b,cfg.stext_color.a)
							end
							if  IsControlJustReleased(1,self.config.controls.menu_select, true) or IsDisabledControlJustReleased(1,self.config.controls.menu_select, true) then
								if self.onButtonSelected ~= nil then
										self:onButtonSelected(btn.name,btn)
								end
								if btn.menu ~= nil then
									if self.OnMenuChange ~= nil then
										self:OnMenuChange(menu,btn.menu)
									end
									self.lastmenu[#self.lastmenu+1] = self.currentmenu
									self.currentmenu = btn.menu
									lastselect = nil
								end
								if btn.checkbox ~= nil then
									btn.checkbox = not btn.checkbox
									if self.onCheckboxChange ~= nil then
										self:onCheckboxChange(btn.name,btn.checkbox)
									end
								end
							end
							if btn.checkbox ~= nil then
								if btn.checkbox then
									DrawSprite("commonmenu", "shop_box_tickb", x + (width/2.3), y, scale/10, scale/10, 0.00,cfg.stext_color.r,cfg.stext_color.g,cfg.stext_color.b,cfg.stext_color.a)
								else
									DrawSprite("commonmenu", "shop_box_blankb",  x + (width/2.3), y, scale/10, scale/10, 0.00,cfg.stext_color.r,cfg.stext_color.g,cfg.stext_color.b,cfg.stext_color.a)
								end
							end
							if btn.list then
								drawRightMenuText('< '..btn.list[btn.listindex]..' >',cfg.font,0,x + (width/2.1),ty,scale,cfg.stext_color.r,cfg.stext_color.g,cfg.stext_color.b,cfg.stext_color.a)
								if IsControlJustPressed(1,self.config.controls.menu_left,true) or IsDisabledControlJustPressed(1,self.config.controls.menu_left,true)then
									if btn.listindex > 1 then
										btn.listindex = btn.listindex - 1
									else
										btn.listindex = #btn.list
									end
									if self.OnButtonListChange ~= nil then
										self:OnButtonListChange(btn)
									end
								end
								if IsControlJustPressed(1,self.config.controls.menu_right,true) or IsDisabledControlJustPressed(1,self.config.controls.menu_right,true) then
									if btn.listindex < #btn.list then
										btn.listindex = btn.listindex + 1
									else
										btn.listindex = 1
									end
									if self.OnButtonListChange ~= nil then
										self:OnButtonListChange(btn)
									end
								end
							end
						else
							drawMenuText(btn.name,cfg.font,0,tx,ty,scale,cfg.text_color.r,cfg.text_color.g,cfg.text_color.b,cfg.text_color.a)
							if btn.list then
								drawRightMenuText('< '..btn.list[btn.listindex]..' >',cfg.font,0,x + (width/2.1),ty,scale,cfg.text_color.r,cfg.text_color.g,cfg.text_color.b,cfg.text_color.a)
							end
							DrawRect(x,  y, width, height,cfg.bg_color.r,cfg.bg_color.g,cfg.bg_color.b,cfg.bg_color.a,0)
							if btn.sprite ~= nil then
								if btn.sprite == "garage" then
									DrawSprite("commonmenu", "shop_garage_icon_a", x + (width/2.4), y, scale/10 -0.01, scale/10 +0.01, 0.00,cfg.text_color.r,cfg.text_color.g,cfg.text_color.b,cfg.text_color.a)
								end
							elseif btn.price ~= nil then
								if btn.price ~= 0 then
									if not btn.purchased then
										drawRightMenuText("£"..btn.price,cfg.font,0,x + (width/2.1),ty,scale,cfg.text_color.r,cfg.text_color.g,cfg.text_color.b,cfg.text_color.a)
									else
										drawRightMenuText("OWNED",cfg.font,0,x + (width/2.1),ty,scale,cfg.text_color.r,cfg.text_color.g,cfg.text_color.b,cfg.text_color.a)
									end
								end
							elseif btn.menu ~= nil then
									DrawSprite("commonmenu", "arrowright", x + (width/2.2), y, scale/14 -0.01, scale/19 +0.01, 0.00,cfg.text_color.r,cfg.text_color.g,cfg.text_color.b,cfg.text_color.a)
							end
							if btn.checkbox ~= nil then
								if btn.checkbox then
									DrawSprite("commonmenu", "shop_box_tick", x + (width/2.3), y, scale/10, scale/10, 0.00,cfg.text_color.r,cfg.text_color.g,cfg.text_color.b,cfg.text_color.a)
								else
									DrawSprite("commonmenu", "shop_box_blank",  x + (width/2.3), y, scale/10, scale/10, 0.00,cfg.text_color.r,cfg.text_color.g,cfg.text_color.b,cfg.text_color.a)
								end
							end
						end
						
						y = y + height
						ty = y - height/2.8
					end
				end
				if tablelength(buttons) > menu.maxbuttons then
					DrawRect(x,  y, width, height,cfg.bg_color.r,cfg.bg_color.g,cfg.bg_color.b,255,0)
					DrawSprite("commonmenu", "shop_arrows_upanddown", x , y, scale/13, scale/9, 0.00,cfg.text_color.r,cfg.text_color.g,cfg.text_color.b,cfg.text_color.a)
					y = y + height
					ty = y - height/2.8
				end
				if self.notification ~= nil then
					DrawRect(x,  y-height + y-ty + 0.0055, width, 0.0035,cfg.sbg_color.r,cfg.sbg_color.g,cfg.sbg_color.b,255,0)
					drawInfo(self.notification,cfg.font,x,y,width,height,scale,cfg.text_color.r,cfg.text_color.g,cfg.text_color.b,cfg.text_color.a)
				elseif menu.buttons[menu.selected] and menu.buttons[menu.selected].info ~= nil then
					DrawRect(x,  y-height + y-ty + 0.0055, width, 0.0035,cfg.sbg_color.r,cfg.sbg_color.g,cfg.sbg_color.b,255,0)
					drawInfo(menu.buttons[menu.selected].info,cfg.font,x,y,width,height,scale,cfg.text_color.r,cfg.text_color.g,cfg.text_color.b,cfg.text_color.a)
				end
				if IsControlJustPressed(1,self.config.controls.menu_up,true) or IsDisabledControlJustPressed(1,self.config.controls.menu_up,true)then
					if menu.selected > 1 then
						menu.selected = menu.selected - 1
					else
						menu.selected = #buttons
						menu.from = #buttons - menu.maxbuttons+1
						menu.to = #buttons
					end
					if tablelength(buttons) > menu.maxbuttons and menu.selected < menu.from then
						menu.from = menu.from -1
						menu.to = menu.to - 1
					end
				end
				if IsControlJustPressed(1,self.config.controls.menu_down,true) or IsDisabledControlJustPressed(1,self.config.controls.menu_down,true) then
					if menu.selected < #buttons then
						menu.selected = menu.selected + 1
					else
						menu.selected = 1
						menu.from = 1
						menu.to = menu.maxbuttons
					end
					if tablelength(buttons) > menu.maxbuttons and menu.selected > menu.to then
						menu.from = menu.from +1
						menu.to = menu.to + 1
					end
				end
				if IsControlJustReleased(1,  self.config.controls.menu_back, true) or IsDisabledControlJustReleased(1,  self.config.controls.menu_back, true) then
					if #self.lastmenu < 1 or self.currentmenu == self.lastmenu[1] then
						self:Close()
					else
						if self.OnMenuChange ~= nil then
							if self.lastmenu[#self.lastmenu] == 'main' then
								self:OnMenuChange(menu,self)
							else
								self:OnMenuChange(menu,self.lastmenu[#self.lastmenu])
							end
						end
						self.currentmenu = self.lastmenu[#self.lastmenu]
						self.lastmenu[#self.lastmenu] = nil
					end
				end
		end
	end)
end

function GetLineCount(text,x,y)
	BeginTextCommandLineCount("STRING")
	AddTextComponentString(text)
	return EndTextCommandGetLineCount(x,y)
end

function Menu:getTitle()
	return self.title
end

function Menu:setTitle(txt)
	self.title = txt
end

function Menu:getName()
	return self.name
end

function Menu:getHeader()
	return self.header
end

function SetMenu()
	return Menu
end


local inside = false
local currentpos = nil
local currentgarage = 0

local garages = { 
	[1] = { locked = false, camera = {x = -330.945, y = -135.471, z = 39.01, heading = 102.213}, driveout = {x = -350.376,y = -136.76, z = 38.294, heading = 70.226}, drivein = {x = -350.655,y = -136.55, z = 38.295, heading = 249.532}, outside = { x = -362.7962, y = -132.4005, z = 38.25239, heading = 71.187133}, inside = {x = -337.3863,y = -136.9247,z = 38.5737, heading = 269.455}},
	[2] = { locked = false, camera = {x = 737.09, y = -1085.721, z = 22.169, heading = 114.86}, driveout = {x = 725.46,y = -1088.822, z = 21.455, heading = 89.395}, drivein = {x = 726.157, y = -1088.768, z = 22.169, heading = 270.288}, outside = {x = 716.54,y = -1088.757, z = 21.651, heading = 89.248}, inside = {x = 733.69,y = -1088.74, z = 21.733, heading = 270.528}},
	[3] = { locked = false, camera = {x = -1154.902, y = -2011.438, z = 13.18, heading = 95.49}, driveout = {x = -1150.379,y = -1995.845, z = 12.465, heading = 313.594}, drivein = {x = -1150.26,y = -1995.642, z = 12.466, heading = 136.859}, outside = {x = -1140.352,y = -1985.89, z = 12.45, heading = 314.406}, inside = {x = -1155.077,y = -2006.61, z = 12.465, heading = 162.58}},
	[4] = { locked = false, camera = {x = 1177.98, y = 2636.059, z = 37.754, heading = 37.082}, driveout = {x = 1175.003,y = 2642.175, z = 37.045, heading = 0.759}, drivein = {x = 1174.701,y = 2643.764, z = 37.048, heading = 178.119}, outside = {x = 1175.565,y = 2652.819, z = 37.941, heading = 351.579}, inside = {x = 1174.823,y = 2637.807, z = 37.045, heading = 181.19}},
	[5] = { locked = false, camera = {x = 105.825, y = 6627.562, z = 31.787, heading = 266.692}, driveout = {x = 112.326,y = 6625.148, z = 31.073, heading = 224.641}, drivein = {x = 112.738,y = 6624.644, z = 31.072, heading = 44.262}, outside = {x = 118.493,y = 6618.897, z = 31.13, heading = 224.701}, inside = {x = 108.842,y = 6628.447, z = 31.072, heading = 45.504}},
	[6] = { locked = false, camera = {x = -215.518, y = -1329.135, z = 30.89, heading = 329.092}, driveout = {x = -205.935,y = -1316.642, z = 30.176, heading = 356.495}, drivein = {x = -205.626,y = -1314.99, z = 30.247, heading = 179.395}, outside = {x = -205.594,y = -1304.085, z = 30.614, heading = 359.792}, inside = {x = -212.368,y = -1325.486, z = 30.176, heading = 141.107}},
	[7] = { locked = false, camera = {x = -585.24, y = -927.49, z = 23.89, heading = 330}, driveout = {x = -580.83,y = -924.59, z = 23.45, heading = 270.45}, drivein = {x = -583.03,y = -924.66, z = 23.48, heading = 89.28}, outside = {x = -583.03,y = -924.66, z = 23.48, heading = 89.28}, inside = {x = -583.03,y = -924.66, z = 23.48, heading = 89.28}},
	[8] = { locked = false, camera = {x = 917.50732421875, y = 1249.8843994141, z = 362.10931396484, heading = 102.213}, driveout = {x = 937.50732421875,y = 1249.8843994141, z = 362.10931396484, heading = 70.226}, drivein = {x = 937.50732421875,y = 1249.8843994141, z = 362.10931396484, heading = 249.532}, outside = { x = 937.50732421875, y = 1249.8843994141, z = 362.10931396484, heading = 71.187133}, inside = {x = 937.50732421875,y = 1249.8843994141,z = 362.10931396484, heading = 269.455}},
}


local Menu = SetMenu()
local myveh = {}

local gameplaycam = nil
local cam = nil

local function Notify(text)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(text)
	DrawNotification(false, false)
end

local function f(n)
	return (n + 0.00001)
end



function myveh.repair()
	SetVehicleFixed(myveh.vehicle)
end

local function round(num, idp)
  if idp and idp>0 then
    local mult = 10^idp
    return math.floor(num * mult + 0.5) / mult
  end
  return math.floor(num + 0.5)
end

local function StartFade()
	Citizen.CreateThread(function()
		DoScreenFadeOut(0)
		while IsScreenFadingOut() do
			Citizen.Wait(0)
		end
	end)
end
local function EndFade()
	Citizen.CreateThread(function()
		ShutdownLoadingScreen()

        DoScreenFadeIn(500)

        while IsScreenFadingIn() do
            Citizen.Wait(0)
        end
	end)
end

--Setup main menu
local LSCMenu = Menu.new("Los Santos Customs","CATEGORIES", 0.16,0.13,0.24,0.36,0,{255,255,255,255})
LSCMenu.config.pcontrol = false

--Add mod to menu
local function AddMod(mod,parent,header,name,info,stock)
	local veh = myveh.vehicle
	SetVehicleModKit(veh,0)	
	if (GetNumVehicleMods(veh,mod) ~= nil and GetNumVehicleMods(veh,mod) > 0) or mod == 18 or mod == 22 then
		local m = parent:addSubMenu(header, name, info,true)
		if stock then
			local btn = m:addPurchase("Stock")
			btn.modtype = mod
			btn.mod = -1
		end
		if LSC_Config.prices.mods[mod].startprice then
			local price = LSC_Config.prices.mods[mod].startprice
			for i = 0,   tonumber(GetNumVehicleMods(veh,mod)) -1 do
				local lbl = GetModTextLabel(veh,mod,i)
				if lbl ~= nil then
					local mname = tostring(GetLabelText(lbl))
					if mname == "NULL" then
						local btn = m:addPurchase("Custom Part",price)
						btn.modtype = mod
						btn.mod = i
						price = price + LSC_Config.prices.mods[mod].increaseby
					else
						local btn = m:addPurchase(mname,price)
						btn.modtype = mod
						btn.mod = i
						price = price + LSC_Config.prices.mods[mod].increaseby
					end
				end
			end		
		else
			for n, v in pairs(LSC_Config.prices.mods[mod]) do
				btn = m:addPurchase(v.name,v.price)btn.modtype = mod
				btn.mod = v.mod
			end
		end
	end
end

--Set up inside camera
local function SetupInsideCam()
	local coords = currentpos.camera
	cam = CreateCam("DEFAULT_SCRIPTED_CAMERA",true,2)
	SetCamCoord(cam, coords.x, coords.y, coords.z + 1.0)
	coords = currentpos.inside
	PointCamAtCoord(cam, coords.x, coords.y, coords.z)
	--PointCamAtEntity(cam, GetVehiclePedIsUsing(ped), p2, p3, p4, 1)
	SetCamActive(cam, true)
	RenderScriptCams( 1, 0, cam, 0, 0)
end

--So we can actually enter it?
local function DriveInGarage()

	--Lock the garage
	TriggerServerEvent('lockGarage',true,currentgarage)
	SetPlayerControl(PlayerId(), false,256)
	StartFade()
	
	local pos = currentpos
	local ped = PlayerPedId()
	local veh = GetVehiclePedIsUsing(ped)
	LSCMenu.buttons = {}

	DisplayRadar(false)
	if DoesEntityExist(veh) then
		--Set menu title
		if currentgarage == 4 or currentgarage == 5 then
			LSCMenu:setTitle("Beeker's Garage")
			LSCMenu.title_sprite = "shopui_title_carmod2"
		elseif currentgarage == 6 then
			LSCMenu:setTitle("Benny's Motorworks")
			LSCMenu.title_sprite = "shopui_title_supermod"
		else
			LSCMenu:setTitle("Los Santos Customs")
			LSCMenu.title_sprite = "shopui_title_carmod"
		end

		-------------------------------Load some settings-----------------------------------

		--Controls
		LSCMenu.config.controls = LSC_Config.menu.controls
		SetIbuttons({
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_back, 0),"Back"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_select, 0),"Select"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_up, 0),"Up"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_down, 0),"Down"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_left, 0),"Left"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_right, 0),"Right"},
		 },0)

		 --Max buttons
		LSCMenu:setMaxButtons(LSC_Config.menu.maxbuttons)

		--Width, height of menu
		LSCMenu.config.size.width = f(LSC_Config.menu.width) or 0.24;
		LSCMenu.config.size.height = f(LSC_Config.menu.height) or 0.36;

		--Position
		if type(LSC_Config.menu.position) == 'table' then
			LSCMenu.config.position = { x = LSC_Config.menu.position.x, y = LSC_Config.menu.position.y}
		elseif type(LSC_Config.menu.position) == 'string' then
			if LSC_Config.menu.position == "left" then
				LSCMenu.config.position = { x = 0.16, y = 0.13}
			elseif  LSC_Config.menu.position == "right" then
				LSCMenu.config.position = { x = 1-0.16, y = 0.13}
			end
		end

		--Theme
		if type(LSC_Config.menu.theme) == "table" then
			LSCMenu:setColors(LSC_Config.menu.theme.text_color,LSC_Config.menu.theme.stext_color,LSC_Config.menu.theme.bg_color,LSC_Config.menu.theme.sbg_color)
		elseif	type(LSC_Config.menu.theme) == "string" then
			if LSC_Config.menu.theme == "light" then
				--text_color,stext_color,bg_color,sbg_color
				LSCMenu:setColors({ r = 255,g = 255, b = 255, a = 255},{ r = 0,g = 0, b = 0, a = 255},{ r = 0,g = 0, b = 0, a = 155},{ r = 255,g = 255, b = 255, a = 255})
			elseif LSC_Config.menu.theme == "darkred" then
				LSCMenu:setColors({ r = 255,g = 255, b = 255, a = 255},{ r = 0,g = 0, b = 0, a = 255},{ r = 0,g = 0, b = 0, a = 155},{ r = 200,g = 15, b = 15, a = 200})
			elseif LSC_Config.menu.theme == "bluish" then
				LSCMenu:setColors({ r = 255,g = 255, b = 255, a = 255},{ r = 255,g = 255, b = 255, a = 255},{ r = 0,g = 0, b = 0, a = 100},{ r = 0,g = 100, b = 255, a = 200})
			elseif LSC_Config.menu.theme == "greenish" then
				LSCMenu:setColors({ r = 255,g = 255, b = 255, a = 255},{ r = 0,g = 0, b = 0, a = 255},{ r = 0,g = 0, b = 0, a = 100},{ r = 0,g = 200, b = 0, a = 200})
			end
		end

		LSCMenu:addSubMenu("CATEGORIES", "categories",nil, false)
		LSCMenu.categories.buttons = {}
		--Calculate price for vehicle repair and add repair  button
		local maxvehhp = 1000
		local damage = 0
		damage = (maxvehhp - GetVehicleBodyHealth(veh))/100
		LSCMenu:addPurchase("Repair vehicle",round(250+150*damage,0), "Full body repair and engine service.")

		--Setup table for vehicle with all mods, colors etc.
		SetVehicleModKit(veh,0)
		myveh.vehicle = veh
		myveh.color =  table.pack(GetVehicleColours(veh))
		myveh.extracolor = table.pack(GetVehicleExtraColours(veh))
		myveh.neon = IsVehicleNeonLightEnabled(veh, 0)
		myveh.neoncolor = table.pack(GetVehicleNeonLightsColour(veh))
		myveh.xenoncolor = GetVehicleHeadlightsColour(veh)
		myveh.smokecolor = table.pack(GetVehicleTyreSmokeColor(veh))
		myveh.plateindex = GetVehicleNumberPlateTextIndex(veh)
		myveh.mods = {}
		for i = 0, 48 do
			myveh.mods[i] = {mod = nil}
		end
		for i, t in pairs(myveh.mods) do
			if i == 22 or i == 18 then
				if IsToggleModOn(veh,i) then
				t.mod = 1
				else
				t.mod = 0
				end
			elseif i == 23 or i == 24 then
				t.mod = GetVehicleMod(veh,i)
				t.variation = GetVehicleModVariation(veh, i)
			else
				t.mod = GetVehicleMod(veh,i)
			end
		end
		if GetVehicleWindowTint(veh) == -1 or GetVehicleWindowTint(veh) == 0 then
			myveh.windowtint = false
		else
			myveh.windowtint = GetVehicleWindowTint(veh)
		end
		if myveh.xenoncolor > 12 or myveh.xenoncolor < -1 then
			myveh.xenoncolor = -1
		end
		myveh.wheeltype = GetVehicleWheelType(veh)
		myveh.bulletProofTyres = GetVehicleTyresCanBurst(veh)

		--Menu stuff 
		local chassis,interior,bumper,fbumper,rbumper = false,false,false,false

		for i = 0,48 do
			if GetNumVehicleMods(veh,i) ~= nil and GetNumVehicleMods(veh,i) ~= false and GetNumVehicleMods(veh,i) > 0 then
				if i == 1 then
					bumper = true
					fbumper = true
				elseif i == 2 then
					bumper = true
					rbumper = true
				elseif (i >= 42 and i <= 46) or i == 5 then --If any chassis mod exist then add chassis menu
					chassis = true
				elseif i >= 27 and i <= 37 then --If any interior mod exist then add interior menu
					interior = true
				end
			end
		end

		AddMod(0,LSCMenu.categories,"SPOILER", "Spoiler", "Increase downforce.",true)
		AddMod(3,LSCMenu.categories,"SKIRTS", "Skirts", "Enhance your vehicle's look with custom side skirts.",true)
		AddMod(4,LSCMenu.categories,"EXHAUST", "Exhausts", "Customized sports exhausts.",true)
		AddMod(6,LSCMenu.categories,"GRILLE", "Grille", "Improved engine cooling.",true)
		AddMod(7,LSCMenu.categories,"HOOD", "Hood", "Enhance car engine cooling.",true)
		AddMod(8,LSCMenu.categories,"FENDERS", "Fenders", "Enhance body paneling with custom fenders.",true)
		AddMod(10,LSCMenu.categories,"ROOF", "Roof", "Lower your center of gravity with lightweight roof panels.",true)
		AddMod(12,LSCMenu.categories,"BRAKES", "Brakes", "Increase stopping power and eliminate brake fade.",true)
		AddMod(13,LSCMenu.categories,"TRANSMISSION", "Transmission", "Improved acceleration with close ratio transmission.",true)
		AddMod(14,LSCMenu.categories,"HORN", "Horn", "Custom air horns.",true)
		AddMod(15,LSCMenu.categories,"SUSPENSION","Suspension","Upgrade to a sports oriented suspension setup.",true)
		AddMod(16,LSCMenu.categories,"ARMOR","Armor","Protect your car's occupants with military spec composite body panels.",true)
		AddMod(18, LSCMenu.categories, "TURBO", "Turbo", "Reduced lag turbocharger.",false)

		if chassis then
			LSCMenu.categories:addSubMenu("CHASSIS", "Chassis",nil, true)
			AddMod(42, LSCMenu.categories.Chassis, "ARCH COVER", "Arch cover", "",true) --headlight trim
			AddMod(43, LSCMenu.categories.Chassis, "AERIALS", "Aerials", "",true) --foglights
			AddMod(44, LSCMenu.categories.Chassis, "ROOF SCOOPS", "Roof Scoops", "",true) --roof scoops
			AddMod(45, LSCMenu.categories.Chassis, "Tank", "Tank", "",true)
			AddMod(46, LSCMenu.categories.Chassis, "DOORS", "Doors", "",true)-- windows
			AddMod(5,LSCMenu.categories.Chassis,"ROLL CAGE", "Roll cage", "Stiffen your chassis with a rollcage.",true)
		end

		LSCMenu.categories:addSubMenu("ENGINE", "Engine",nil, true)
		AddMod(39, LSCMenu.categories.Engine, "ENGINE BLOCK", "Engine Block", "Custom engine block casings.",true)
		AddMod(40, LSCMenu.categories.Engine, "CAM COVER", "Cam Cover", "Optional cam covers.",true)
		AddMod(41, LSCMenu.categories.Engine, "STRUT BRACE", "Strut Brace", "A selection of support struts.",true)
		AddMod(11,LSCMenu.categories.Engine,"ENGINE TUNES", "Engine Tunes", "Increases horsepower.",true)

		if interior then
			LSCMenu.categories:addSubMenu("INTERIOR", "Interior","Products for maximum style and comfort.", true)
			--LSCMenu.categories.Interior:addSubMenu("TRIM", "Trim","A selection of interior designs.", true)
			AddMod(27, LSCMenu.categories.Interior, "TRIM DESIGN", "Trim Design", "",true)
			--There are'nt any working natives that could change interior color :(
			--LSCMenu.categories.Interior.Trim:addSubMenu("TRIM COLOR", "Trim Color","", true)
			AddMod(28, LSCMenu.categories.Interior, "ORNAMENTS", "Ornaments", "Add decorative items to your dash.",true)
			AddMod(29, LSCMenu.categories.Interior, "DASHBOARD", "Dashboard", "Custom control panel designs.",true)
			AddMod(30, LSCMenu.categories.Interior, "DIAL DESIGN", "Dials", "Customize the look of your dials.",true)
			AddMod(31, LSCMenu.categories.Interior, "DOORS", "Doors", "Install door upgrades.",true)
			AddMod(32, LSCMenu.categories.Interior, "SEATS", "Seats", "Options where style meets comfort.",true)
			AddMod(33, LSCMenu.categories.Interior, "STEERING WHEELS", "Steering Wheels", "Customize the link between you and your vehicle.",true)
			AddMod(34, LSCMenu.categories.Interior, "Shifter leavers", "Shifter leavers", "",true)
			AddMod(35, LSCMenu.categories.Interior, "Plaques", "Plaques", "",true)
			AddMod(36, LSCMenu.categories.Interior, "Speakers", "Speakers", "",true)
			AddMod(37, LSCMenu.categories.Interior, "Trunk", "Trunk", "",true)
		end

		LSCMenu.categories:addSubMenu("PLATES", "Plates","Decorative identification.", true)
		LSCMenu.categories.Plates:addSubMenu("LICENSE", "License", "",true)
		for n, mod in pairs(LSC_Config.prices.plates) do
			local btn = LSCMenu.categories.Plates.License:addPurchase(mod.name,mod.price)btn.plateindex = mod.plateindex
		end
		--Customize license plates
		AddMod(25, LSCMenu.categories.Plates, "Plate holder", "Plate holder", "",true) --
		AddMod(26, LSCMenu.categories.Plates, "Vanity plates", "Vanity plates", "",true) --
		--AddMod(47, LSCMenu.categories, "UNK47", "unk47", "",true)
		--AddMod(49, LSCMenu.categories, "UNK49", "unk49", "",true)
		AddMod(38,LSCMenu.categories,"HYDRAULICS","Hydraulics","",true)
		AddMod(48,LSCMenu.categories,"Liveries", "Liveries", "A selection of decals for your vehicle.",true)

		if bumper then
			LSCMenu.categories:addSubMenu("BUMPERS", "Bumpers", "Custom front and rear bumpers.",true)
			if fbumper then
				AddMod(1,LSCMenu.categories.Bumpers,"FRONT BUMPERS", "Front bumpers", "Custom front bumpers.",true)
			end
			if rbumper then
				AddMod(2,LSCMenu.categories.Bumpers,"REAR BUMPERS", "Rear bumpers", "Custom rear bumpers.",true)
			end
		end

		local m = LSCMenu.categories:addSubMenu("LIGHTS", "Lights", "Improved night time visibility.",true)
		AddMod(22,LSCMenu.categories.Lights,"HEADLIGHTS", "Headlights", nil, false)
		if not IsThisModelABike(GetEntityModel(veh)) then
			neon = m:addSubMenu("NEON KITS", "Neon kits", nil, true)
			neon:addSubMenu("NEON LAYOUT", "Neon layout", nil, true)
					local btn = neon["Neon layout"]:addPurchase("None")
					for n, mod in pairs(LSC_Config.prices.neonlayout) do
						btn = neon["Neon layout"]:addPurchase(mod.name,mod.price)
					end

			neon = neon:addSubMenu("NEON COLOR", "Neon color", nil, true)
				for n, mod in pairs(LSC_Config.prices.neoncolor) do
					local btn = neon:addPurchase(mod.name,mod.price)
					btn.neon = mod.neon
				end

			m = m:addSubMenu("XENON COLOR", "Xenon color", nil, true)
			local btn = m:addPurchase("Stock")
			btn.xenon = -1
			for n, mod in pairs(LSC_Config.prices.xenoncolor) do
				btn = m:addPurchase(mod.name, mod.price)
				btn.xenon = mod.xenon
			end
		end


		respray = LSCMenu.categories:addSubMenu("RESPRAY", "Respray", "Transforms vehicle appearance.",true)
			pcol = respray:addSubMenu("PRIMARY COLORS", "Primary color",  nil,true)
				pcol:addSubMenu("CHROME", "Chrome", nil,true)
				for n, c in pairs(LSC_Config.prices.chrome.colors) do
					local btn = pcol.Chrome:addPurchase(c.name,LSC_Config.prices.chrome.price)btn.colorindex = c.colorindex
					if btn.colorindex == myveh.color[1] then
						btn.purchased = true
					end
				end
				pcol:addSubMenu("CLASSIC", "Classic", nil,true)
				for n, c in pairs(LSC_Config.prices.classic.colors) do
					local btn = pcol.Classic:addPurchase(c.name,LSC_Config.prices.classic.price)btn.colorindex = c.colorindex
					if btn.colorindex == myveh.color[1] then
						btn.purchased = true
					end
				end
				pcol:addSubMenu("MATTE", "Matte", nil,true)
				for n, c in pairs(LSC_Config.prices.matte.colors) do
					local btn = pcol.Matte:addPurchase(c.name,LSC_Config.prices.matte.price)
					btn.colorindex = c.colorindex
					if btn.colorindex == myveh.color[1] then
						btn.purchased = true
					end
				end
				pcol:addSubMenu("METALLIC", "Metallic", nil,true)
				for n, c in pairs(LSC_Config.prices.metallic.colors) do
					local btn = pcol.Metallic:addPurchase(c.name,LSC_Config.prices.metallic.price)btn.colorindex = c.colorindex
					if btn.colorindex == myveh.color[1] and myveh.extracolor[1] == myveh.color[2] then
						btn.purchased = true
					end
				end
				pcol:addSubMenu("METALS", "Metals", nil,true)
				for n, c in pairs(LSC_Config.prices.metal.colors) do
					local btn = pcol.Metals:addPurchase(c.name,LSC_Config.prices.metal.price)btn.colorindex = c.colorindex
					if btn.colorindex == myveh.color[1] then
						btn.purchased = true
					end
				end
			scol = respray:addSubMenu("SECONDARY COLORS", "Secondary color", nil,true)
				scol:addSubMenu("CHROME", "Chrome", nil,true)
				for n, c in pairs(LSC_Config.prices.chrome2.colors) do
					local btn = scol.Chrome:addPurchase(c.name,LSC_Config.prices.chrome2.price)btn.colorindex = c.colorindex
					if btn.colorindex == myveh.color[2] then
						btn.purchased = true
					end
				end
				scol:addSubMenu("CLASSIC", "Classic", nil,true)
				for n, c in pairs(LSC_Config.prices.classic2.colors) do
					local btn = scol.Classic:addPurchase(c.name,LSC_Config.prices.classic2.price)btn.colorindex = c.colorindex
					if btn.colorindex == myveh.color[2] then
						btn.purchased = true
					end
				end
				scol:addSubMenu("MATTE", "Matte", nil,true)
				for n, c in pairs(LSC_Config.prices.chrome2.colors) do
					local btn = scol.Matte:addPurchase(c.name,LSC_Config.prices.matte2.price)btn.colorindex = c.colorindex
					if btn.colorindex == myveh.color[1] then
						btn.purchased = true
					end
				end
				scol:addSubMenu("METALLIC", "Metallic", nil,true)
				for n, c in pairs(LSC_Config.prices.metallic2.colors) do
					local btn = scol.Metallic:addPurchase(c.name,LSC_Config.prices.metallic2.price)
					btn.colorindex = c.colorindex
					if btn.colorindex == myveh.color[2] and myveh.extracolor[1] == btn.colorindex then
						btn.purchased = true
					end
				end
				scol:addSubMenu("METALS", "Metals", nil,true)
				for n, c in pairs(LSC_Config.prices.metal2.colors) do
					local btn = scol.Metals:addPurchase(c.name,LSC_Config.prices.metal2.price)btn.colorindex = c.colorindex
					if btn.colorindex == myveh.color[2] then
						btn.purchased = true
					end
				end


		LSCMenu.categories:addSubMenu("WHEELS", "Wheels", "Custom rims, tires and colors.",true)
			wtype = LSCMenu.categories.Wheels:addSubMenu("WHEEL TYPE", "Wheel type", "Custom rims in all styles and sizes.",true)
				if IsThisModelABike(GetEntityModel(veh)) then
					fwheels = wtype:addSubMenu("FRONT WHEEL", "Front wheel", nil,true)
						for n, w in pairs(LSC_Config.prices.frontwheel) do
							btn = fwheels:addPurchase(w.name,w.price)btn.wtype = w.wtype btn.modtype = 23 btn.mod = w.mod
						end
					bwheels = wtype:addSubMenu("BACK WHEEL", "Back wheel", nil,true)
						for n, w in pairs(LSC_Config.prices.backwheel) do
							btn = bwheels:addPurchase(w.name,w.price)btn.wtype = w.wtype btn.modtype = 24 btn.mod = w.mod
						end
				else
					sportw = wtype:addSubMenu("SPORT WHEELS", "Sport", nil,true)
						for n, w in pairs(LSC_Config.prices.sportwheels) do
							local btn = sportw:addPurchase(w.name,w.price)btn.wtype = w.wtype btn.modtype = 23 btn.mod = w.mod
						end
					musclew = wtype:addSubMenu("MUSCLE WHEELS", "Muscle", nil,true)
						for n, w in pairs(LSC_Config.prices.musclewheels) do
							local btn = musclew:addPurchase(w.name,w.price)btn.wtype =  w.wtype btn.modtype = 23 btn.mod = w.mod
						end
					lowriderw = wtype:addSubMenu("LOWRIDER WHEELS", "Lowrider", nil,true)
						for n, w in pairs(LSC_Config.prices.lowriderwheels) do
							local btn = lowriderw:addPurchase(w.name,w.price)btn.wtype =  w.wtype btn.modtype = 23 btn.mod = w.mod
						end
					suvw = wtype:addSubMenu("SUV WHEELS", "Suv", nil,true)
						for n, w in pairs(LSC_Config.prices.suvwheels) do
							local btn = suvw:addPurchase(w.name,w.price)btn.wtype = w.wtype btn.modtype = 23 btn.mod = w.mod
						end
					offroadw = wtype:addSubMenu("OFFROAD WHEELS", "Offroad", nil,true)
						for n, w in pairs(LSC_Config.prices.offroadwheels) do
							local btn = offroadw:addPurchase(w.name,w.price)btn.wtype = w.wtype btn.modtype = 23 btn.mod = w.mod
						end
					tunerw = wtype:addSubMenu("TUNER WHEELS", "Tuner", nil,true)
						for n, w in pairs(LSC_Config.prices.tunerwheels) do
							local btn = tunerw:addPurchase(w.name,w.price)btn.wtype = w.wtype btn.modtype = 23 btn.mod = w.mod
						end
					hughendw = wtype:addSubMenu("HIGHEND WHEELS", "Highend", nil,true)
						for n, w in pairs(LSC_Config.prices.highendwheels) do
							local btn = hughendw:addPurchase(w.name,w.price)btn.wtype = w.wtype btn.modtype = 23 btn.mod = w.mod
						end
				end

		m = LSCMenu.categories.Wheels:addSubMenu("WHEEL COLOR", "Wheel color", "Custom wheel colors.",true)
			for n, c in pairs(LSC_Config.prices.wheelcolor.colors) do
				local btn = m:addPurchase(c.name,LSC_Config.prices.wheelcolor.price)btn.colorindex = c.colorindex
			end

		m = LSCMenu.categories.Wheels:addSubMenu("WHEEL ACCESSORIES", "Wheel accessories", "Bulletproof tires and custom burnout smoke.",true)
			for n, mod in pairs(LSC_Config.prices.wheelaccessories) do
				local btn = m:addPurchase(mod.name,mod.price)btn.smokecolor = mod.smokecolor
			end

		m = LSCMenu.categories:addSubMenu("WINDOWS", "Windows", "A selection of tinted windows.",true)
			btn = m:addPurchase("None")btn.tint = false
			for n, tint in pairs(LSC_Config.prices.windowtint) do
				btn = m:addPurchase(tint.name,tint.price)btn.tint = tint.tint
			end

		Citizen.CreateThread(function()
			--NetworkSetEntityVisibleToNetwork(entity, toggle)
			--NetworkFadeOutEntity(veh, true, true)
			FadeOutLocalPlayer(1)
			--NetworkUnregisterNetworkedEntity(veh)
			--NetworkSetEntityVisibleToNetwork(veh, true)
			--SetEntityVisible(veh, true, 0)
			--SetNetworkIdExistsOnAllMachines(NetworkGetNetworkIdFromEntity(veh), false)
			--SetEntityLocallyVisible(veh,true)
			--SetEntityLocallyInvisible(veh,false)
			SetEntityCoordsNoOffset(veh,pos.drivein.x,pos.drivein.y,pos.drivein.z)
			SetEntityHeading(veh,pos.drivein.heading)
			SetVehicleOnGroundProperly(veh)
			SetVehicleLights(veh, 2)
			SetVehicleInteriorlight(veh, true)
			SetVehicleDoorsLocked(veh,4)
		--	SetPlayerInvincible(GetPlayerIndex(),true)
	--	SetEntityInvincible(veh,true)
			SetVehRadioStation(veh, 255)

			gameplaycam = GetRenderingCam()
			SetupInsideCam()
			Citizen.Wait(50)

			TaskVehicleDriveToCoord(ped, veh, pos.inside.x, pos.inside.y, pos.inside.z, f(3), f(1), GetEntityModel(veh), 16777216, f(0.1), true)
			EndFade()Citizen.Wait(3000)

			local c = 0
			while not IsVehicleStopped(veh) do
				Citizen.Wait(0)
				c = c + 1
				if c > 5000 then
					ClearPedTasks(ped)
					break
				end
			end
			Citizen.Wait(100)
			SetCamCoord(cam,GetGameplayCamCoords())
			SetCamRot(cam, GetGameplayCamRot(2), 2)
			RenderScriptCams( 1, 1, 0, 0, 0)
			RenderScriptCams( 0, 1, 1000, 0, 0)
			SetCamActive(gameplaycam, true)
			EnableGameplayCam(true)
			SetCamActive(cam, false)

			--If vehicle is damaged then it will open repair menu
			if IsVehicleDamaged(veh) then
				LSCMenu:Open("main")
			else
				LSCMenu:Open("categories")
			end

			FreezeEntityPosition(veh, true)
			SetEntityCollision(veh,false,false)
			SetPlayerControl(PlayerId(), true)
		end)
	end
end

--We actually need to get out of garage? o_O
local function DriveOutOfGarage(pos)
	Citizen.CreateThread(function()
	
		local ped = PlayerPedId()
		local veh = GetVehiclePedIsUsing(ped)
		
		pos = currentpos
		TaskVehicleDriveToCoord(ped, veh, pos.outside.x, pos.outside.y, pos.outside.z, f(5), f(0.1), GetEntityModel(veh), 16777216, f(0.1), true)
		
		pos = currentpos.driveout
		
		--The vehicle customization is finished, so we send to server our vehicle data
		local ok, veh_type, model = tvRP.getNearestOwnedVehicle(3.8)
		if not ok then
			ok, veh_type, model = tvRP.getNearestOwnedVehicle(1)
		end
		myveh.model = model

		if ok then
			TriggerServerEvent("LSC:finished", myveh)
		end
		
		StartFade()
		Citizen.Wait(500)
		SetEntityCollision(veh,true,true)
		FreezeEntityPosition(ped, false)
		FreezeEntityPosition(veh, false)
		SetEntityCoords(veh,pos.x,pos.y,pos.z)
		SetEntityHeading(veh,pos.heading)
		SetVehicleOnGroundProperly(veh)
		SetVehicleDoorsLocked(veh,0)
		SetPlayerInvincible(GetPlayerIndex(),false)
		SetEntityInvincible(veh,false, 0)
		SetVehicleLights(veh, 0)
		NetworkLeaveTransition()
		EndFade()
		
		NetworkFadeInEntity(veh, 1)	
		Citizen.Wait(3000)
		NetworkRegisterEntityAsNetworked(veh)
		SetEntityVisible(ped, true,0)
		ClearPedTasks(ped)
		inside = false
		
		--Unlock the garage
		TriggerServerEvent('lockGarage',false,currentgarage)
		
		currentgarage = 0
		
		DisplayRadar(true)
		SetPlayerControl(PlayerId(), true)
		
	end)
end

--Draw text on screen
local function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x , y)	
end

--Get the length of table
local function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

--Check if table contains value
local function tableContains(t,val)
	for k,v in pairs(t) do
		if v == val then
			return true
		end
	end
	return false
end

--Magical loop that allows you to  drive in garage if you successfully go through checks
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		--If you are not already in garage
		if inside == false then
			local ped = PlayerPedId()
			--Well... yes... we actually need a car to do something
			if IsPedSittingInAnyVehicle(ped) then
				local veh = GetVehiclePedIsUsing(ped)
				--If the vehicle exist, player is in driver seat and if this vehicle is a car or bike then we are good to go
				if DoesEntityExist(veh) and GetPedInVehicleSeat(veh, -1) == ped and (IsThisModelACar(GetEntityModel(veh)) or IsThisModelABike(GetEntityModel(veh)))  then
					--So lets go through every garage
					for i,pos in ipairs(garages) do
						--Lets take the outside coords of garage
						outside = pos.drivein	
						--Old enter:If vehicle is close enough, then text will be displayed - Press ENTER to enter garage
						if LSC_Config.oldenter then			
							--So, if vehicle is close enough then we can continue
							if GetDistanceBetweenCoords(outside.x,outside.y,outside.z,GetEntityCoords(ped)) <= f(5) then
								--print("Within Garage Distance")
								--Lets check if our vehicle is not in the model black list, and if it is not then we can go further
								if not tableContains(LSC_Config.ModelBlacklist,GetDisplayNameFromVehicleModel(GetEntityModel(veh)):lower()) then
									--If the garage is locked
									if pos.locked then
										--If the config lock system is not enabled then we can go traight in garage, but if it is enabled then not
										if not LSC_Config.lock then
											if IsControlJustPressed(1,201,true) then
												inside = true
												currentpos = pos
												currentgarage = i
												DriveInGarage()
											else
												drawTxt("Press ~b~ENTER~w~ to enter ~b~Los Santos Customs ",4,1,0.5,0.8,1.0,255,255,255,255)
											end
										else
											drawTxt("~r~Locked, please wait",4,1,0.5,0.8,1.0,255,255,255,255)
										end
									else
										if IsControlJustPressed(1,201,true) then
											inside = true
											currentpos = pos
											currentgarage = i
											DriveInGarage()
										else
											drawTxt("Press ~b~ENTER~w~ to enter ~b~Los Santos Customs ",4,1,0.5,0.8,1.0,255,255,255,255)
										end
									end
								else
									drawTxt("~r~This vehicle can't be upgraded",4,1,0.5,0.8,1.0,255,255,255,255)
								end
							end
						else
							--So, if vehicle is close enough and it's facing the garage then we can continue
							if math.abs(GetEntityHeading(veh)-outside.heading) <= 90 and IsVehicleStopped(veh) and GetDistanceBetweenCoords(outside.x,outside.y,outside.z,GetEntityCoords(ped)) <= f(5) then
								--Lets check if our vehicle is not in the model black list, and if it is not then we can go further
								if not tableContains(LSC_Config.ModelBlacklist,GetDisplayNameFromVehicleModel(GetEntityModel(veh)):lower()) then
									--If the garage is locked
									if pos.locked then
										--If the config lock system is not enabled then we can go traight in garage, but if it is enabled then not
										if not LSC_Config.lock then
											inside = true
											currentpos = pos
											currentgarage = i
											DriveInGarage()
										else
											drawTxt("~r~Locked, please wait",4,1,0.5,0.8,1.0,255,255,255,255)
										end
									else
										inside = true
										currentpos = pos
										currentgarage = i
										DriveInGarage()
									end
								else
									drawTxt("~r~This vehicle can't be upgraded",4,1,0.5,0.8,1.0,255,255,255,255)
								end
							end
						end
					end
				end
			end
		end
	end
end)

--Lets drive out of the garage 
function LSCMenu:OnMenuClose(m)
	DriveOutOfGarage(currentpos.outside)
end

function LSCMenu:onSelectedIndexChanged(name, button)
	name = name:lower()
	local m = LSCMenu.currentmenu
	local price = button.price or 0
	local veh = myveh.vehicle
	p = m.parent or self.name
	if m == "main" then
		m = self
	end
	CheckPurchases(m)
	m = m.name:lower()
	p = p:lower()
	--set up temporary shitt, or in other words show preview of selected mod
	if m == "chrome" or m ==  "classic" or m ==  "matte" or m ==  "metals" then
		if p == "primary color" then
			SetVehicleColours(veh,button.colorindex,myveh.color[2])
		else
			SetVehicleColours(veh,myveh.color[1],button.colorindex)	
		end
		
	elseif m == "metallic" then
		if p == "primary color" then
			SetVehicleColours(veh,button.colorindex,myveh.color[2])
			SetVehicleExtraColours(veh, myveh.color[2], myveh.extracolor[2])
		else
			SetVehicleColours(veh,myveh.color[1],button.colorindex)
			SetVehicleExtraColours(veh, button.colorindex, myveh.extracolor[2])				
		end
	elseif m == "wheel color" then
		SetVehicleExtraColours(veh,myveh.extracolor[1], button.colorindex)
	elseif button.modtype and button.mod then
		if button.modtype ~= 18 and button.modtype ~= 22 then
			if button.wtype then
				SetVehicleWheelType(veh,button.wtype)
			end
			SetVehicleMod(veh,button.modtype, button.mod)	
		elseif button.modtype == 22 then
			ToggleVehicleMod(veh,button.modtype, button.mod)
		elseif button.modtype == 18 then
		end
	elseif m == "license" then
		SetVehicleNumberPlateTextIndex(veh,button.plateindex)
	elseif m == "neon color" then
		if myveh.neon then
			SetVehicleNeonLightsColour(veh,button.neon[1], button.neon[2], button.neon[3])
		else
			LSCMenu:showNotification("~r~You don't have neon lights installed.")
		end
	elseif m == "xenon color" then
		if myveh.mods[22].mod == 1 then
			SetVehicleHeadlightsColour(veh, button.xenon)
		else
			LSCMenu:showNotification("~r~You don't have xenon headlights installed.")
		end
	elseif m == "windows" then
		SetVehicleWindowTint(veh, button.tint)
	else
	end
	if m == "horn" then
		--Maybe some way of playing the horn?
		OverrideVehHorn(veh,false,0)
		if IsHornActive(veh) or IsControlPressed(1,86, true) then
			StartVehicleHorn(veh, 10000, "HELDDOWN", 1)
		end
	end
end

function LSCMenu:onButtonSelected(name, button)
	--Send the selected button to server
	local m = LSCMenu.currentmenu
	if m == "main" then
		m = LSCMenu
	end
	local mname = m.name:lower()
	if mname == "neon color" then
		if not myveh.neon then
			LSCMenu:showNotification("~r~You don't have neon lights installed.")
			return
		end
	elseif mname == "xenon color" then
		if myveh.mods[22].mod ~= 1 then
			LSCMenu:showNotification("~r~You don't have xenon headlights installed.")
			return
		end
	end
	TriggerServerEvent("LSC:buttonSelected", name, button)
end

--So we get the button back from server +  bool that determines if we can prchase specific item or not
RegisterNetEvent("LSC:buttonSelected")
AddEventHandler("LSC:buttonSelected", function(name, button, canpurchase)
	name = name:lower()
	local m = LSCMenu.currentmenu
	local price = button.price or 0
	local veh = myveh.vehicle
	if m == "main" then
		m = LSCMenu
	end


	mname = m.name:lower()

	if button.name:lower() == mname then
		return
	end
		--Bunch of button shitt, that gets executed if button is selected + goes through checks
	if mname == "chrome" or mname ==  "classic" or mname ==  "matte" or mname ==  "metals" then
		if m.parent == "Primary color" then
			if button.name == "Stock" or button.purchased or CanPurchase(price, canpurchase) then
				myveh.color[1] = button.colorindex
			end
		else
			if button.name == "Stock" or button.purchased or CanPurchase(price, canpurchase) then
				myveh.color[2] = button.colorindex
			end
		end
	elseif mname == "metallic" then
		if m.parent == "Primary color" then
			if button.name == "Stock" or button.purchased or CanPurchase(price, canpurchase)then
				myveh.color[1] = button.colorindex
				myveh.extracolor[1] = myveh.color[2]
			end
		else
			if button.name == "Stock" or button.purchased or CanPurchase(price, canpurchase)then
				myveh.extracolor[1] = button.colorindex
				myveh.color[2] = button.colorindex
			end
		end
	end
	if mname == "liveries" or mname == "hydraulics" or mname == "horn" or mname == "tank" or mname == "ornaments" or  mname == "arch cover" or mname == "aerials" or mname == "roof scoops" or mname == "doors" or mname == "roll cage" or mname == "engine block" or mname == "cam cover" or mname == "strut brace" or mname == "trim design" or mname == "ormnametns" or mname == "dashboard" or mname == "dials" or mname == "seats" or mname == "steering wheels" or mname == "plate holder" or mname == "vanity plates" or mname == "shifter leavers" or mname == "plaques" or mname == "speakers" or mname == "trunk" or mname == "armor" or mname == "suspension" or mname == "transmission" or mname == "brakes" or mname == "engine tunes" or mname == "roof" or mname == "hood" or mname == "grille" or mname == "roll cage" or mname == "exhausts" or mname == "skirts" or mname == "rear bumpers" or mname == "front bumpers" or mname == "spoiler" then
		if button.name == "Stock" or button.purchased or CanPurchase(price, canpurchase)then
			myveh.mods[button.modtype].mod = button.mod
			SetVehicleMod(veh,button.modtype,button.mod)
		end
	elseif mname == "fenders" then
		if button.name == "Stock" or button.purchased or CanPurchase(price, canpurchase)then
			if button.name == "Stock" then
				myveh.mods[8].mod = button.mod
				myveh.mods[9].mod = button.mod
				SetVehicleMod(veh,9,button.mod)
				SetVehicleMod(veh,8,button.mod)
			else
				myveh.mods[button.modtype].mod = button.mod
				SetVehicleMod(veh,button.modtype,button.mod)
			end
		end
	elseif mname == "turbo" or mname == "headlights" then
		if button.name == "None" or button.name == "Stock Lights" or button.purchased or CanPurchase(price, canpurchase) then
			myveh.mods[button.modtype].mod = button.mod
			ToggleVehicleMod(veh, button.modtype, button.mod)
			if mname == "headlights" then
				myveh.xenoncolor = -1
			end
		end
	elseif mname == "neon layout" then
		if button.name == "None"  then
			SetVehicleNeonLightEnabled(veh,0,false)
			SetVehicleNeonLightEnabled(veh,1,false)
			SetVehicleNeonLightEnabled(veh,2,false)
			SetVehicleNeonLightEnabled(veh,3,false)
			myveh.neon = false
			myveh.neoncolor[1] = 255
			myveh.neoncolor[2] = 255
			myveh.neoncolor[3] = 255
			SetVehicleNeonLightsColour(veh,255,255,255)
		elseif button.purchased or CanPurchase(price, canpurchase) then
			if not myveh.neoncolor[1] then
				myveh.neoncolor[1] = 255
				myveh.neoncolor[2] = 255
				myveh.neoncolor[3] = 255
			end
			SetVehicleNeonLightsColour(veh,myveh.neoncolor[1],myveh.neoncolor[2],myveh.neoncolor[3])
			SetVehicleNeonLightEnabled(veh,0,true)
			SetVehicleNeonLightEnabled(veh,1,true)
			SetVehicleNeonLightEnabled(veh,2,true)
			SetVehicleNeonLightEnabled(veh,3,true)
			myveh.neon = true
		end
	elseif mname == "neon color" then
		if button.purchased or CanPurchase(price, canpurchase) then
			myveh.neoncolor[1] = button.neon[1]
			myveh.neoncolor[2] = button.neon[2]
			myveh.neoncolor[3] = button.neon[3]
			SetVehicleNeonLightsColour(veh,button.neon[1],button.neon[2],button.neon[3])
		end
	elseif mname == "xenon color" then
		if button.purchased or CanPurchase(price, canpurchase) then
			myveh.xenoncolor = button.xenon
			SetVehicleHeadlightsColour(veh, button.xenon)
		end
	elseif mname == "windows" then
		if button.name == "None" or button.purchased or CanPurchase(price, canpurchase) then
			myveh.windowtint = button.tint
			SetVehicleWindowTint(veh, button.tint)
		end
	elseif mname == "sport" or mname == "muscle" or mname == "lowrider" or mname == "back wheel" or mname == "front wheel" or mname == "highend" or mname == "suv" or mname == "offroad" or mname == "tuner" then
		if button.purchased or CanPurchase(price, canpurchase) then
			myveh.wheeltype = button.wtype
			myveh.mods[button.modtype].mod = button.mod
			SetVehicleWheelType(veh,button.wtype)
			SetVehicleMod(veh,button.modtype,button.mod)
		end
	elseif mname == "wheel color" then
		if button.purchased or CanPurchase(price, canpurchase) then
			myveh.extracolor[2] = button.colorindex
			SetVehicleExtraColours(veh, myveh.extracolor[1], button.colorindex)
		end
	elseif mname == "wheel accessories" then
		if button.name == "Stock Tires" then
			SetVehicleModKit(veh,0)
			SetVehicleMod(veh,23,myveh.mods[23].mod,false)
			myveh.mods[23].variation = false
			if IsThisModelABike(GetEntityModel(veh)) then
				SetVehicleModKit(veh,0)
				SetVehicleMod(veh,24,myveh.mods[24].mod,false)
				myveh.mods[24].variation = false
			end
		elseif button.name == "Custom Tires" and  (button.purchased or CanPurchase(price, canpurchase)) then
			SetVehicleModKit(veh,0)
			SetVehicleMod(veh,23,myveh.mods[23].mod,true)
			myveh.mods[23].variation = true
			if IsThisModelABike(GetEntityModel(veh)) then
				SetVehicleModKit(veh,0)
				SetVehicleMod(veh,24,myveh.mods[24].mod,true)
				myveh.mods[24].variation = true
			end
		elseif button.name == "Bulletproof Tires" and  (button.purchased or CanPurchase(price, canpurchase)) then
			if GetVehicleTyresCanBurst(myveh.vehicle) then
				myveh.bulletProofTyres = false
				SetVehicleTyresCanBurst(veh,false)
			else
				myveh.bulletProofTyres = true
				SetVehicleTyresCanBurst(veh,true)
			end
		elseif button.smokecolor ~= nil  and  (button.purchased or CanPurchase(price, canpurchase)) then
			SetVehicleModKit(veh,0)
			myveh.mods[20].mod = true
			ToggleVehicleMod(veh,20,true)
			myveh.smokecolor = button.smokecolor
			SetVehicleTyreSmokeColor(veh,button.smokecolor[1],button.smokecolor[2],button.smokecolor[3])
		end
	elseif mname == "license" then
		if button.purchased or CanPurchase(price, canpurchase) then
			myveh.plateindex = button.plateindex
			SetVehicleNumberPlateTextIndex(veh,button.plateindex)
		end
	elseif mname == "main" then
		if name == "repair vehicle" then
			if CanPurchase(price, canpurchase) then
				myveh.repair()
				LSCMenu:ChangeMenu("categories")
			end
		end
		end
	CheckPurchases(m)
end)

RegisterNetEvent("LSC:applyModifications")
AddEventHandler("LSC:applyModifications", function (vehicle, modifications)
	if vehicle and modifications then
		SetVehicleModKit(vehicle, 0)
		SetVehicleColours(vehicle, modifications.color[1], modifications.color[2])
		SetVehicleExtraColours(vehicle, modifications.extraColor[1], modifications.extraColor[2])
		SetVehicleNeonLightEnabled(vehicle, 0, modifications.neon)
		SetVehicleNeonLightEnabled(vehicle, 1, modifications.neon)
		SetVehicleNeonLightEnabled(vehicle, 2, modifications.neon)
		SetVehicleNeonLightEnabled(vehicle, 3, modifications.neon)
		SetVehicleNeonLightsColour(vehicle, modifications.neonColor[1], modifications.neonColor[2], modifications.neonColor[3])
		SetVehicleHeadlightsColour(vehicle, modifications.xenonColor)
		SetVehicleTyreSmokeColor(vehicle, modifications.smokeColor[1], modifications.smokeColor[2], modifications.smokeColor[3])
		SetVehicleWheelType(vehicle, modifications.wheelType)
		SetVehicleTyresCanBurst(vehicle, modifications.bulletProofTyres)
		SetVehicleWindowTint(vehicle, modifications.windowTint)
		SetVehicleNumberPlateTextIndex(vehicle, modifications.plateIndex)
		for k, v in pairs(modifications.mods) do
			k = tonumber(k)
			if k == 18 or k == 22 then
				ToggleVehicleMod(vehicle, k, v.mod)
			elseif k == 23 or k == 24 then
				SetVehicleMod(vehicle, k, v.mod, v.variation)
			else
				SetVehicleMod(vehicle, k, v.mod)
			end
		end
	end
end)

--This was perfect until I tried different vehicles
local function PointCamAtBone(bone,ox,oy,oz)
	SetIbuttons({
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_back, 0),"Back"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_select, 0),"Select"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_up, 0),"Up"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_down, 0),"Down"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_left, 0),"Left"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_right, 0),"Right"},
			{GetControlInstructionalButton(1,0, 0),"Free camera"}
	 },0)
	SetCamActive(cam, true)
	local veh = myveh.vehicle
	local b = GetEntityBoneIndexByName(veh, bone)
	local bx,by,bz = table.unpack(GetWorldPositionOfEntityBone(veh, b))
	local ox2,oy2,oz2 = table.unpack(GetOffsetFromEntityGivenWorldCoords(veh, bx, by, bz))
	local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(veh, ox2 + f(ox), oy2 + f(oy), oz2 +f(oz)))
	SetCamCoord(cam, x, y, z)
	PointCamAtCoord(cam,GetOffsetFromEntityInWorldCoords(veh, 0, oy2, oz2))
	RenderScriptCams( 1, 1, 1000, 0, 0)
end

local function MoveVehCam(pos,x,y,z)
	SetIbuttons({
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_back, 0),"Back"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_select, 0),"Select"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_up, 0),"Up"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_down, 0),"Down"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_left, 0),"Left"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_right, 0),"Right"},
			{GetControlInstructionalButton(1,0, 0),"Free camera"}
	 },0)
	SetCamActive(cam, true)
	local veh = myveh.vehicle
	local vx,vy,vz = table.unpack(GetEntityCoords(veh))
	local d = GetModelDimensions(GetEntityModel(veh))
	local length,width,height = d.y*-2, d.x*-2, d.z*-2
	local ox,oy,oz
	if pos == 'front' then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh, f(x), (length/2)+ f(y), f(z)))
	elseif pos == "front-top" then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh, f(x), (length/2) + f(y),(height) + f(z)))
	elseif pos == "back" then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh, f(x), -(length/2) + f(y),f(z)))
	elseif pos == "back-top" then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh, f(x), -(length/2) + f(y),(height/2) + f(z)))
	elseif pos == "left" then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh, -(width/2) + f(x), f(y), f(z)))
	elseif pos == "right" then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh, (width/2) + f(x), f(y), f(z)))
	elseif pos == "middle" then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh, f(x), f(y), (height/2) + f(z)))
	end
	SetCamCoord(cam, ox, oy, oz)
	PointCamAtCoord(cam,GetOffsetFromEntityInWorldCoords(veh, 0, 0, f(0)))
	RenderScriptCams( 1, 1, 1000, 0, 0)
end

function LSCMenu:OnMenuChange(last,current)
	UnfakeVeh()
	if last == "main" then
		last = self
	end
	if last.name == "categories" and current.name == "main" then
		LSCMenu:Close()
	end	
	c = current.name:lower()
	--Camera,door stuff 
	if c == "front bumpers" then
		MoveVehCam('front',-0.6,1.5,0.4)
	elseif  c == "rear bumpers" then
		MoveVehCam('back',-0.5,-1.5,0.2)
	elseif c == "Engine Tunes" then
		--PointCamAtBone('engine',0,-1.5,1.5)
	elseif c == "exhausts" then
		--PointCamAtBone("exhaust",0,-1.5,0)
	elseif c == "hood" then
		MoveVehCam('front-top',-0.5,1.3,1.0)
	elseif c == "headlights" then
		MoveVehCam('front',-0.6,1.3,0.6)
	elseif c == "license" or c == "plate holder" then
		MoveVehCam('back',0,-1,0.2)
	elseif c == "vanity plates" then
		MoveVehCam('front',-0.3,0.8,0.3)
	elseif c == "roof" then
		--MoveVehCam('middle',-1.2,2,1.5)
	elseif c == "fenders" then
		MoveVehCam('left',-1.8,-1.3,0.7)
	elseif c == "grille" then
		--MoveVehCam('front',-0.3,0.8,0.6)
	elseif c == "skirts" then
		MoveVehCam('left',-1.8,-1.3,0.7)
	elseif c == "spoiler" then
		MoveVehCam('back',0.5,-1.6,1.3)
	elseif c == "back wheel" then
		PointCamAtBone("wheel_lr",-1.4,0,0.3)
	elseif c == "front wheel" or c == "wheel accessories" or  c == "wheel color" or c == "sport" or c == "muscle" or c == "lowrider"  or c == "highend" or c == "suv" or c == "offroad" or c == "tuner" then
		PointCamAtBone("wheel_lf",-1.4,0,0.3)
	--[[elseif c == "windows" then
		if not IsThisModelABike(GetEntityModel(myveh.vehicle)) then
		PointCamAtBone("window_lf",-2.0,0,0.3)
		end]]
	elseif c == "neon color" then
		PointCamAtBone("neon_l",-2.0,2.0,0.4)
	elseif c == "shifter leavers" or c == "trim design" or c == "ornaments" or c == "dashboard" or c == "dials" or c == "seats" or c =="steering wheels" then
		--Set view mode to first person
		SetFollowVehicleCamViewMode(4)
	elseif c == "doors" and last.name:lower() == "interior" then
		--Open both front doors
		SetVehicleDoorOpen(myveh.vehicle, 0, 0, 0)
		SetVehicleDoorOpen(myveh.vehicle, 1, 0, 0)
	elseif c == "trunk" then
		--- doorIndex:
		-- 0 = Front Left Door
		-- 1 = Front Right Door
		-- 2 = Back Left Door
		-- 3 = Back Right Door
		-- 4 = Hood
		-- 5 = Trunk
		-- 6 = Back
		-- 7 = Back2
		SetVehicleDoorOpen(myveh.vehicle, 5, 0, 0)
	elseif c == "speakers" or  c == "engine block" or c == "air filter" or c == "strut brace" or c == "cam cover" then
		--Open hood and trunk
		SetVehicleDoorOpen(myveh.vehicle, 5, 0, 0)
		SetVehicleDoorOpen(myveh.vehicle, 4, 0, 0)
	elseif IsCamActive(cam) then
		--Go back to gameplaycam
		SetCamCoord(cam,GetGameplayCamCoords())
		SetCamRot(cam, GetGameplayCamRot(2), 2)
		RenderScriptCams( 1, 1, 0, 0, 0)
		RenderScriptCams( 0, 1, 1000, 0, 0)
		SetCamActive(gameplaycam, true)
		EnableGameplayCam(true)
		SetCamActive(cam, false)
		SetIbuttons({
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_back, 0),"Back"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_select, 0),"Select"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_up, 0),"Up"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_down, 0),"Down"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_left, 0),"Left"},
			{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_right, 0),"Right"}
		},0)
	else
		--Close all doors
		SetVehicleDoorShut(myveh.vehicle, 0, 0)
		SetVehicleDoorShut(myveh.vehicle, 1, 0)
		SetVehicleDoorShut(myveh.vehicle, 4, 0)
		SetVehicleDoorShut(myveh.vehicle, 5, 0)
		SetFollowVehicleCamViewMode(0)
	end
end


--Bunch of checks
function CheckPurchases(m)
	name = m.name:lower()
	if name == "chrome" or name ==  "classic" or name ==  "matte" or name ==  "metals" or name == "metallic" then
		if m.parent == "Primary color" then
			for i,b in pairs(m.buttons) do
				if myveh.color[1] ~= nil then
					if b.colorindex == myveh.color[1] then
						b.purchased = true
						b.sprite = "garage"
					else
						b.purchased = false
						b.sprite = nil
					end
				end
			end
		else
			for i,b in pairs(m.buttons) do
				if myveh.color[2] ~= nil then
					if b.colorindex == myveh.color[2] then
						b.purchased = true
						b.sprite = "garage"
					else
						b.purchased = false
						b.sprite = nil
					end
				end
			end
		end
	elseif name == "armor" or name == "suspension" or name == "transmission" or name == "brakes" or name == "engine tunes" or name == "roof" or name == "fenders" or name == "hood" or name == "grille" or name == "roll cage" or name == "exhausts" or name == "skirts" or name == "rear bumpers" or name == "front bumpers" or name == "spoiler" then
		for i,b in pairs(m.buttons) do
			if b.mod == -1  then
				if myveh.mods[b.modtype].mod == -1 then
					if b.purchased ~= nil then b.purchased = true end
					b.sprite = "garage"
				else
					if b.purchased ~= nil then b.purchased = false end
					b.sprite = nil
				end
			elseif b.mod == 0 or b.mod == false then
				if myveh.mods[b.modtype].mod == false or myveh.mods[b.modtype].mod == 0 then
					if b.purchased ~= nil then b.purchased = true end
					b.sprite = "garage"
				else
					if b.purchased ~= nil then b.purchased = false end
					b.sprite = nil
				end
			else
				if myveh.mods[b.modtype].mod == b.mod then
					if b.purchased ~= nil then b.purchased = true end
					b.sprite = "garage"
				else
					if b.purchased ~= nil then b.purchased = false end
					b.sprite = nil
				end
			end
		end
	elseif name == "neon layout" then
		for i,b in pairs(m.buttons) do
			if b.name == "None" then
				if IsVehicleNeonLightEnabled(myveh.vehicle, 0) == false and IsVehicleNeonLightEnabled(myveh.vehicle, 1) == false  and IsVehicleNeonLightEnabled(myveh.vehicle, 2) == false and IsVehicleNeonLightEnabled(myveh.vehicle, 3) == false then
					b.sprite = "garage"
				else
					b.sprite =  nil
				end
			elseif b.name == "Front,Back and Sides" then
				if IsVehicleNeonLightEnabled(myveh.vehicle, 0)  and IsVehicleNeonLightEnabled(myveh.vehicle, 1)  and IsVehicleNeonLightEnabled(myveh.vehicle, 2)  and IsVehicleNeonLightEnabled(myveh.vehicle, 3)  then
					b.sprite = "garage"
				else
					b.sprite =  nil
				end
			end		
		end
	elseif name == "neon color" then
		for i,b in pairs(m.buttons) do
			if b.neon[1] == myveh.neoncolor[1] and b.neon[2] == myveh.neoncolor[2] and b.neon[3] == myveh.neoncolor[3] then
				b.sprite = "garage"
			else
				b.sprite = nil
			end
		end
	elseif name == "xenon color" then
		for i,b in pairs(m.buttons) do
			if myveh.xenoncolor ~= nil then
				if b.xenon == myveh.xenoncolor then
					b.purchased = true
					b.sprite = "garage"
				else
					b.purchased = false
					b.sprite = nil
				end
			end
		end
	elseif name == "windows" then
		for i,b in pairs(m.buttons) do
			if myveh.windowtint ~= nil then
				if myveh.windowtint == b.tint then
					purchased = true
					b.sprite = "garage"
				else
					purchased = false
					b.sprite = nil
				end
			end
		end
	elseif name == "sport" or name == "muscle" or name == "lowrider" or name == "back wheel" or name == "front wheel" or name == "highend" or name == "suv" or name == "offroad" or name == "tuner" then
		for i,b in pairs(m.buttons) do
			if myveh.mods[b.modtype].mod == b.mod and myveh.wheeltype == b.wtype then
				b.sprite = "garage"
			else
				b.sprite = nil
			end
		end
	elseif name == "wheel color" then
		for i,b in pairs(m.buttons) do
			if myveh.extracolor[2] ~= nil then
				if b.colorindex == myveh.extracolor[2] then
					b.purchased = true
					b.sprite = "garage"
				else
					b.purchased = false
					b.sprite = nil
				end
			end
		end
	elseif name == "wheel accessories" then
		for i,b in pairs(m.buttons) do
			if b.name == "Stock Tires" then
				if GetVehicleModVariation(myveh.vehicle,23) == false then
					b.sprite = "garage"
				else
					b.sprite = nil
				end
			elseif b.name == "Custom Tires" then
				if GetVehicleModVariation(myveh.vehicle,23) then
					b.sprite = "garage"
				else
					b.sprite = nil
				end
			elseif b.name == "Bulletproof Tires" then
				if GetVehicleTyresCanBurst(myveh.vehicle) == false then
					b.sprite = "garage"
				else
					b.sprite = nil
				end
			elseif b.smokecolor ~= nil then
				local col = table.pack(GetVehicleTyreSmokeColor(myveh.vehicle))
				if col[1] == b.smokecolor[1] and col[2] == b.smokecolor[2] and col[3] == b.smokecolor[3] then
					b.sprite = "garage"
				else
					b.sprite = nil
				end
			end
		end
	elseif name == "license" then
		for i,b in pairs(m.buttons) do
			if myveh.plateindex == b.plateindex then
				b.sprite = "garage"
			else
				b.sprite = nil
			end
		end
	elseif name == "tank" or name == "ornaments" or name == "arch cover" or name == "aerials" or name == "roof scoops" or name == "doors" or name == "roll cage" or name == "engine block" or name == "cam cover" or name == "strut brace" or name == "trim design" or name == "ornametns" or name == "dashboard" or name == "dials" or name == "seats" or name == "steering wheels" or name == "plate holder" or name == "vanity plates" or name == "shifter leavers" or name == "plaques" or name == "speakers" or name == "trunk" or name == "headlights" or name == "turbo" or  name == "hydraulics" or name == "liveries" or name == "horn" then
		for i,b in pairs(m.buttons) do
			if myveh.mods[b.modtype].mod == b.mod then
				b.sprite = "garage"
			else
				b.sprite = nil
			end
		end
	end
end

--Show notifications and return if item can be purchased
function CanPurchase(price, canpurchase)
	if canpurchase then
		if LSCMenu.currentmenu == "main" then
			LSCMenu:showNotification("Your vehicle has been repaired.")
		else
			LSCMenu:showNotification("Item purchased.")
		end
		return true
	else
		LSCMenu:showNotification("~r~You cannot afford this purchase.")
		return false
	end
end

--Unfake vehicle, or in other words reset vehicle stuff to real so all the preview stuff would be gone
function UnfakeVeh()
	local veh = myveh.vehicle
	SetVehicleModKit(veh,0)
	SetVehicleWheelType(veh, myveh.wheeltype)
	for i,m in pairs(myveh.mods) do
		if i == 22 or i == 18 then
			ToggleVehicleMod(veh,i,m.mod)
		elseif i == 23 or i == 24 then
			SetVehicleMod(veh,i,m.mod,m.variation)
		else
			SetVehicleMod(veh,i,m.mod)
		end
	end
	SetVehicleColours(veh, myveh.color[1], myveh.color[2])
	SetVehicleExtraColours(veh, myveh.extracolor[1], myveh.extracolor[2])
	SetVehicleNeonLightsColour(veh, myveh.neoncolor[1], myveh.neoncolor[2], myveh.neoncolor[3])
	SetVehicleHeadlightsColour(veh, myveh.xenoncolor)
	SetVehicleNumberPlateTextIndex(veh, myveh.plateindex)
	SetVehicleWindowTint(veh, myveh.windowtint)
end

--Still the good old way of adding blips
local function AddBlips()
	for i,pos in ipairs(garages) do
		local blip = AddBlipForCoord(pos.inside.x,pos.inside.y,pos.inside.z)
		SetBlipSprite(blip, 72)
		SetBlipAsShortRange(blip,true)
		if i == 5 then
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Beeker's Garage")
			EndTextCommandSetBlipName(blip)
		elseif i == 6 then
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Benny's Motorworks")
			EndTextCommandSetBlipName(blip)
		end
	end
end

--Adding all blips on first spawn
local firstspawn = 0
AddEventHandler('playerSpawned', function(spawn)
	if firstspawn == 0 then
		AddBlips()
		TriggerServerEvent('getGarageInfo')
		firstspawn = 1
	end
end)

--Locks the garage if someone enters it
RegisterNetEvent('lockGarage')
AddEventHandler('lockGarage', function(tbl)
	for i,garage in ipairs(tbl) do
		garages[i].locked = garage.locked
	end
end)

--This is something new o_O, just some things to draw instructional buttons 
local Ibuttons = nil
--Set up scaleform
function SetIbuttons(buttons, layout)
	Citizen.CreateThread(function()
		if not HasScaleformMovieLoaded(Ibuttons) then
			Ibuttons = RequestScaleformMovie("INSTRUCTIONAL_BUTTONS")
			while not HasScaleformMovieLoaded(Ibuttons) do
				Citizen.Wait(0)
			end
		else
			Ibuttons = RequestScaleformMovie("INSTRUCTIONAL_BUTTONS")
			while not HasScaleformMovieLoaded(Ibuttons) do
				Citizen.Wait(0)
			end
		end
		local sf = Ibuttons
		local w,h = GetScreenResolution()
		PushScaleformMovieFunction(sf,"CLEAR_ALL")
		PopScaleformMovieFunction()
		PushScaleformMovieFunction(sf,"SET_DISPLAY_CONFIG")
		PushScaleformMovieFunctionParameterInt(w)
		PushScaleformMovieFunctionParameterInt(h)
		PushScaleformMovieFunctionParameterFloat(0.03)
		PushScaleformMovieFunctionParameterFloat(0.98)
		PushScaleformMovieFunctionParameterFloat(0.01)
		PushScaleformMovieFunctionParameterFloat(0.95)
		PushScaleformMovieFunctionParameterBool(true)
		PushScaleformMovieFunctionParameterBool(false)
		PushScaleformMovieFunctionParameterBool(false)
		PushScaleformMovieFunctionParameterInt(w)
		PushScaleformMovieFunctionParameterInt(h)
		PopScaleformMovieFunction()
		PushScaleformMovieFunction(sf,"SET_MAX_WIDTH")
		PushScaleformMovieFunctionParameterInt(1)
		PopScaleformMovieFunction()
		
		for i,btn in pairs(buttons) do
			PushScaleformMovieFunction(sf,"SET_DATA_SLOT")
			PushScaleformMovieFunctionParameterInt(i-1)
			PushScaleformMovieFunctionParameterString(btn[1])
			PushScaleformMovieFunctionParameterString(btn[2])
			PopScaleformMovieFunction()
			
		end
		if layout ~= 1 then
			PushScaleformMovieFunction(sf,"SET_PADDING")
			PushScaleformMovieFunctionParameterInt(10)
			PopScaleformMovieFunction()
		end
		PushScaleformMovieFunction(sf,"DRAW_INSTRUCTIONAL_BUTTONS")
		PushScaleformMovieFunctionParameterInt(layout)
		PopScaleformMovieFunction()
	end)
end

--Draw the scaleform
function DrawIbuttons()
	if HasScaleformMovieLoaded(Ibuttons) then
		DrawScaleformMovie(Ibuttons, 0.5, 0.5, 1.0, 1.0, 255, 255, 255, 255)
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if inside then
			SetLocalPlayerVisibleLocally(1)
		end
		if LSCMenu:isVisible() then
			DrawIbuttons()--Draw the scaleform if menu is visible
			if IsDisabledControlJustPressed(1,0,true) or IsControlJustPressed(1,0,true) then -- V
				if cam and IsCamActive(cam) then --If the script cam is active then we can change back to gameplay cam
					SetCamCoord(cam,GetGameplayCamCoords())
					SetCamRot(cam, GetGameplayCamRot(2), 2)
					RenderScriptCams( 1, 1, 0, 0, 0)
					RenderScriptCams( 0, 1, 1000, 0, 0)
					SetCamActive(gameplaycam, true)
					EnableGameplayCam(true)
					SetCamActive(cam, false)
					SetIbuttons({
							{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_back, 0),"Back"},
							{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_select, 0),"Select"},
							{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_up, 0),"Up"},
							{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_down, 0),"Down"},
							{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_left, 0),"Left"},
							{GetControlInstructionalButton(1,LSCMenu.config.controls.menu_right, 0),"Right"}
					 },0)
				end
			end
		end
	end
end)








-- https://runtime.fivem.net/doc/natives/?_0x29439776AAA00A62
local vehicleClassWhitelist = {0, 1, 2, 3, 4, 5, 6, 7, 9}

local handleMods = {
	{"fInitialDragCoeff", 90.22},
	{"fDriveInertia", .31},
	{"fSteeringLock", 22},
	{"fTractionCurveMax", -1.1},
	{"fTractionCurveMin", -.4},
	{"fTractionCurveLateral", 2.5},
	{"fLowSpeedTractionLossMult", -.57}
}

local ped, vehicle
local driftMode = false

local function DrawNotif(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

local function PrintDebugInfo(mode)
	ped = GetPlayerPed(-1)
	local vehicle = GetVehiclePedIsIn(ped, false)
	--print(mode)
	for index, value in ipairs(handleMods) do
		--print(GetVehicleHandlingFloat(vehicle, "CHandlingData", value[1]))
	end
end

local function IsVehicleClassWhitelisted(vehicleClass)
	for index, value in ipairs(vehicleClassWhitelist) do
		if value == vehicleClass then
			return true
		end
	end

	return false
end