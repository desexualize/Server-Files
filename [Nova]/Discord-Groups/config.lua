Config = {
	Guild_ID = '1005348320392257568',
  	Multiguild = true,
  	Guilds = {
		['Nova UK'] = '1005348320392257568',
		['LFB'] = '1016858643293024308',
		['MPD'] = '1005632105549664397', 
		['HMP'] = '1016844313591812128',
		['NHS'] = '1005632218133180487',
  	},
	Bot_Token = 'MTAxMjQ5OTIxMDIwNzI0NDQwOA.G1Mf_N.ZvRanMxFOKuxq6b8e3Cawklw4LT9HxnpscidVs',
	RoleList = {},

	CacheDiscordRoles = true, -- true to cache player roles, false to make a new Discord Request every time
	CacheDiscordRolesTime = 60, -- if CacheDiscordRoles is true, how long to cache roles before clearing (in seconds)
}

Config.Splash = {
	Header_IMG = 'https://www.google.com/imgres?imgurl=https%3A%2F%2Fupload.wikimedia.org%2Fwikipedia%2Fen%2F2%2F2e%2FRetribution_logo.jpg&imgrefurl=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FRetribution_(professional_wrestling)&tbnid=m4qzMIKjqVACSM&vet=12ahUKEwiLjey33Ib6AhUBUhoKHb7EDO8QMygAegUIARDBAQ..i&docid=s2wgZNzpJTtr2M&w=547&h=182&q=retribution%20logo&client=firefox-b-d&ved=2ahUKEwiLjey33Ib6AhUBUhoKHb7EDO8QMygAegUIARDBAQ',
	Enabled = false,
	Wait = 10, -- How many seconds should splash page be shown for? (Max is 12)
	Heading1 = "Welcome to [Nova]",
	Heading2 = "Make sure to join our Discord and check out our website!",
	Discord_Link = 'https://discord.gg/YxCcxY6bYF',
	Website_Link = 'https://Nova.forums.com',
}

Config.Permission_From_Role_ID = {
	['1005600376172576858'] = 'founder', -- Founder
	['1012735523707691088'] = 'cofounder', -- Co-Founder

	['1005628717856473099'] = 'developer', -- Lead Developer
	['1005604861863268433'] = 'developer', -- Script Developer
	['1005605039861137529'] = 'cardeveloper', -- Car Developer

	['1005630611458883635'] = 'staffmanager', -- Staff Manager
	['1005630081886072983'] = 'commanager', -- Community Manager
	['1005629167372607498'] = 'headadmin', -- Head Administrator
	['1005604084843290714'] = 'senioradmin', -- Senior Administrator
	['1005605409790361821'] = 'administrator', -- administrator
	['1005605563431919636'] = 'srmoderator', -- Senior Moderator
	['1005605734882496683'] = 'moderator', -- Moderator
	['1005697308895232070'] = 'supportteam', -- Support Team
	['1005605923261255711'] = 'trialstaff', -- Trial Staff

	-- LFB
	['1017621455120379944'] = 'Chief Fire Command', -- Chief Fire Command
	['1017621512255197254'] = 'Divisional Command', -- Divisional Command
	['1017621546212261888'] = 'Sector Command', -- Sector Command
	['1017621584850190417'] = 'Honourable Firefighter', -- Honourable Firefighter
	['1019584345108918393'] = 'Firefighter of the week', -- Firefighter of the week
	['1017621616416538677'] = 'Leading Firefighter', -- Leading Firefighter
	['1017621659332644865'] = 'Specialist Firefighter', -- Specialist Firefighter
	['1017621694740959233'] = 'Advanced Firefighter', -- Advanced Firefighter
	['1017621729885036597'] = 'Senior Firefighter', -- Senior Firefighter
	['1017621763531751434'] = 'Firefighter', -- Firefighter
	['1017621801355976756'] = 'Junior Firefighter', -- Junior Firefighter
	['1017621836089016420'] = 'Provisional Firefighter', -- Provisional Firefighter
	['1017763987934416997'] = 'LFB Needs Training', -- LFB Needs Training
	['1016858643293024310'] = 'LFB Suspended', -- LFB Suspended

	-- NHS
	['1013072143208157234'] = 'Chief Medical Director', -- Chief Medical Director
	['1013072231695388743'] = 'Deputy Medical Director', -- Deputy Medical Director
	['1013072284061270127'] = 'Assistant Medical Director', -- Assistant Medical Director
	['1017618355047383141'] = 'Captain', -- Captain
	['1017618411284615260'] = 'Specialist', -- Specialist
	['1019584557785301003'] = 'Medic of the week', -- Medic of the week
	['1017618467731554364'] = 'Senior Doctor', -- Senior Doctor
	['1017618570940780576'] = 'Doctor', -- Doctor
	['1017618604541362277'] = 'Junior Doctor', -- Junior Doctor
	['1017618670559698995'] = 'Critical Care Paramedic', -- Critical Care Paramedic
	['1017618728348811306'] = 'Paramedic', -- Paramedic
	['1017618794333614140'] = 'Trainee Paramedic', -- Trainee Paramedic
	['1022642333696675840'] = 'Drone Trained', -- Drone Trained
	['1017863422748151860'] = 'NHS Needs Training', -- NHS Needs Training
	['1017991729971994725'] = 'NHS Suspended', -- NHS Suspended
	

	-- HMP
	['1017619823804547113'] = 'Governor', -- Governor
	['1017619884177358882'] = 'Deputy Governor', -- Deputy Governor
	['1017619931526877246'] = 'Assistant Governor', -- Assistant Governor
	['1017619970349334590'] = 'Custodial Supervisor', -- Custodial Supervisor
	['1017620004373544992'] = 'Custodial Officer', -- Custodial Officer
	['1017620044798251148'] = 'Honourable Guard', -- Honourable Guard
	['1019584898396327946'] = 'Guard of the week', -- Guard of the week
	['1017620085654958080'] = 'Supervising Officer', -- Supervising Officer
	['1017620118433431653'] = 'Principal Officer', -- Principal Officer
	['1017620166990888960'] = 'Specialist Officer', -- Specialist Officer
	['1017620204655755317'] = 'Senior Officer', -- Senior Officer
	['1017620239686582403'] = 'Prison Officer', -- Prison Officer
	['1017620274537046086'] = 'Trainee Prison Officer', -- Trainee Prison Officer
	['1022642728061915176'] = 'Drone Trained', -- Drone Trained
	['1017769129446481960'] = 'HMP Needs Training', -- HMP Needs Training
	['1016844313591812130'] = 'HMP Suspended', -- HMP Suspended

	-- MPD
	['1007405450196701255'] = 'Commissioner', -- Commissioner
	['1007406056865026213'] = 'Deputy Commissioner', -- Deputy Commissioner
	['1007406389225865328'] = 'Assistant Commissioner', -- Assistant Commissioner
	['1007405322845032448'] = 'Deputy Assistant Commissioner', -- Deputy Assistant Commissioner
	['1007407009404043274'] = 'Commander', -- Commander
	['1007407918662029373'] = 'Chief Superintendent', -- Chief Superintendent
	['1007408117287489567'] = 'Superintendent', -- Superintendent
	['1019585062796271726'] = 'Officer of the week', -- Officer of the week
	['1007409844409602109'] = 'Chief Inspector', -- Chief Inspector
	['1007409895257157652'] = 'Inspector', -- Inspector
	['1007409984205770822'] = 'Sergeant', -- Sergeant
	['1007410241887015022'] = 'Special Constable', -- Special Constable
	['1007410105047855165'] = 'Senior Constable', -- Senior Constable
	['1007410199528734720'] = 'Police Constable', -- Police Constable
	['1007410327446638663'] = 'PCSO', -- PCSO
	['1007417966620590101'] = 'SCO-19', -- SCO-19
	['1007419420731265034'] = 'Drone Trained', -- Drone Trained
	['1017768854295937045'] = 'MPD Needs Training', -- MPD Needs Training
	['1007420921834909756'] = 'MPD Suspended', -- MPD Suspended
}

Config.Guild_Roles = {
	['Nova UK'] = {
		['Founder'] = 1005600376172576858,
		['Co-Founder'] = 1012735523707691088, 
		['Lead Developer'] = 1005628717856473099,
		['Script Developer'] = 1005604861863268433,
		['Car Developer'] = 1005605039861137529,
		['Staff Manager'] = 1005630611458883635,
		['Community Manager'] = 1005630081886072983,
		['Head Admininistrator'] = 1005629167372607498,
		['Senior Administrator'] = 1005604084843290714,
		['Administrator'] = 1005605409790361821,
		['Senior Moderator'] = 1005605563431919636,
		['Moderator'] = 1005605734882496683,
		['Support Team'] = 1005697308895232070,
		['Trial Staff'] = 1005605923261255711,
	},

	['LFB'] = {
		['Chief Fire Command'] = 1017621455120379944,
		['Divisional Command'] = 1017621512255197254,
		['Sector Command'] = 1017621546212261888,
		['Honourable Firefighter'] = 1017621584850190417,
		['Firefighter of the week'] = 1019584345108918393,
		['Leading Firefighter'] = 1017621616416538677,
		['Specialist Firefighter'] = 1017621659332644865,
		['Advanced Firefighter'] = 1017621694740959233,
		['Senior Firefighter'] = 1017621729885036597,
		['Firefighter'] = 1017621763531751434,
		['Junior Firefighter'] = 1017621801355976756,
		['Provisional Firefighter'] = 1017621836089016420,
		['LFB Needs Training'] = 1017763987934416997,
		['LFB Suspended'] = 1016858643293024310,
	},

	['NHS'] = {
		['Chief Medical Director'] = 1013072143208157234,
		['Deputy Medical Director'] = 1013072231695388743,
		['Assistant Medical Director'] = 1013072284061270127,
		['Captain'] = 1017618355047383141,
		['Specialist'] = 1017618411284615260,
		['Medic of the week'] = 1019584557785301003,
		['Senior Doctor'] = 1017618467731554364,
		['Doctor'] = 1017618570940780576,
		['Junior Doctor'] = 1017618604541362277,
		['Critical Care Paramedic'] = 1017618670559698995,
		['Paramedic'] = 1017618728348811306,
		['Trainee Paramedic'] = 1017618794333614140,
		['NHS Needs Training'] = 1017863422748151860,
		['NHS Suspended'] = 1017991729971994725,
		['Drone Trained'] = 1022642333696675840,
	},
	
	

	['HMP'] = {
		['Governor'] = 1017619823804547113,
		['Deputy Governor'] = 1017619884177358882,
		['Assistant Governor'] = 1017619931526877246,
		['Custodial Supervisor'] = 1017619970349334590,
		['Custodial Officer'] = 1017620004373544992,
		['Honourable Guard'] = 1017620044798251148,
		['Guard of the week'] = 1019584898396327946,
		['Supervising Officer'] = 1017620085654958080,
		['Principal Officer'] = 1017620118433431653,
		['Specialist Officer'] = 1017620166990888960,
		['Senior Officer'] = 1017620204655755317,
		['Prison Officer'] = 1017620239686582403,
		['Trainee Prison Officer'] = 1017620274537046086,
		['HMP Needs Training'] = 1017769129446481960,
		['HMP Suspended'] = 1016844313591812130,
		['Drone Trained'] = 1022642728061915176,
	},
	
	

	['MPD'] = {
		['Commissioner'] = 1007405450196701255,
		['Deputy Commissioner'] = 1007406056865026213,
		['Assistant Commissioner'] = 1007406389225865328,
		['Deputy Assistant Commissioner'] = 1007405322845032448,
		['Commander'] = 1007407009404043274,
		['Chief Superintendent'] = 1007407918662029373,
		['Superintendent'] = 1007408117287489567,
		['Officer of the week'] = 1019585062796271726,
		['Chief Inspector'] = 1007409844409602109,
		['Inspector'] = 1007409895257157652,
		['Sergeant'] = 1007409984205770822,
		['Special Constable'] = 1007410241887015022,
		['Senior Constable'] = 1007410105047855165,
		['Police Constable'] = 1007410199528734720,
		['PCSO'] = 1007410327446638663,
		['Large Arms Access'] = 1007417966620590101,
		['MPD Needs Training'] = 1017768854295937045,
		['MPD Suspended'] = 1007420921834909756,
		['Drone Trained'] = 1007419420731265034,
	}
}

for faction_name, faction_roles in pairs(Config.Guild_Roles) do
	for role_name, role_id in pairs(faction_roles) do
		Config.RoleList[role_name] = role_id
	end
end