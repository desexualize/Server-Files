fx_version 'cerulean'
games { 'gta5' }

client_scripts {
    '@vrp/client/Tunnel.lua',
    '@vrp/client/Proxy.lua',
    "@vrp/lib/utils.lua",
    'client/*.lua'
}

server_scripts {
    'serverutils.lua',
    'modules/*.lua'
}

files {
    'nui/*',
    'nui/assets/*'
}

ui_page 'nui/inventory.html'











