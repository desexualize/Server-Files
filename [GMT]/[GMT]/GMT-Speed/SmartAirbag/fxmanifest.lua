fx_version 'bodacious'

games { 'gta5' }

author 'London Studios'
description 'Adds airbags to vehicles'
version '1.0.0'
lua54 'yes'

shared_script 'config.lua'

files {
    'stream/prop_car_airbag.ytyp', 
}

data_file 'DLC_ITYP_REQUEST' 'stream/prop_car_airbag.ytyp'

client_scripts {
	'cl_utils.lua',
	'cl_airbags.lua',
}

escrow_ignore {
	'stream/**',
	'config.lua',
	'cl_utils.lua',
}

-- Join the London Studios Discord server here: https://discord.gg/htyaZNaG