fx_version 'bodacious'
games { 'gta5' }

author 'London Studios'
description 'A resource providing a realistic speed warning radar system'
version '1.0.0'
lua54 'yes'

client_scripts{
    'config.lua',
    'cl_utils.lua',
    'cl_speedwarning.lua',
}

escrow_ignore {
    'stream/**',
    'config.lua',
    'cl_utils.lua',
}

files {
    'stream/prop_speed_radar.ytyp',
}

data_file 'DLC_ITYP_REQUEST' 'stream/prop_speed_radar.ytyp'