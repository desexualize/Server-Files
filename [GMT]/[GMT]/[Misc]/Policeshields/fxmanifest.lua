shared_script '@FiveEye/FiveEye.lua'

fx_version 'bodacious'
games { 'gta5' }

author 'London Studios'
description 'A resource providing four police shields'
version '1.0.0'

files {
    'stream/shield_props.ytyp',
}

client_scripts {
    'config_policeshields.lua',
    'cl_policeshields.lua',
}

server_scripts {
    'config_policeshields.lua',
    'sv_policeshields.lua',
}

data_file 'DLC_ITYP_REQUEST' 'stream/shield_props.ytyp'