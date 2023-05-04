fx_version 'bodacious'
games { 'gta5' }

author 'London Studios'
description 'A resource providing a water monitor for firefighters'
version '1.0.0'

files {
    'stream/watermonitor.ytyp',
}

client_scripts {
    'config_watermonitor.lua',
    'cl_watermonitor.lua',
}

server_scripts {
    'config_watermonitor.lua',
    'sv_watermonitor.lua',
}

data_file 'DLC_ITYP_REQUEST' 'stream/watermonitor.ytyp'