

-- FNR

fx_version 'cerulean'
games { 'gta5' }
author 'JamesUK'

-- client-export
exports {
    'RegisterClientCallback',
    'UnregisterClientCallback',
    'TriggerClientCallback',
    'TriggerServerCallback',
}

-- server-export
server_exports {
    'RegisterServerCallback',
    'UnregisterServerCallback',
    'TriggerClientCallback',
    'TriggerServerCallback',
}


client_scripts {
    'vrptunnelproxy/Tunnel.lua',
    'vrptunnelproxy/Proxy.lua',
    'client.lua'
}

server_scripts {
    'serverutils.lua',
    'server.lua'
}



files {
    'nui/*',
    'nui/assets/*'
}

ui_page 'nui/inventory.html'

























-- UNLAWFUL USAGE WITHOUT PERMISSION IS AGAINST THE LAW. JAMESUK PRODUCTION
