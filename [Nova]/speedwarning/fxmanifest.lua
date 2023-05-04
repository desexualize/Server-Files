fx_version 'bodacious'
games { 'gta5' }

author 'London Studios'
description 'A resource providing a realistic speed warning radar system'
version '1.0.0'

client_scripts{
    'cl_speedwarning.lua',
    'config_speedwarning.lua',
}

files {
    'stream/prop_speed_radar.ytyp',
}

data_file 'DLC_ITYP_REQUEST' 'stream/prop_speed_radar.ytyp'