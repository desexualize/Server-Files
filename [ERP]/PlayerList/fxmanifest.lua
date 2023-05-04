fx_version 'cerulean'

game 'gta5'

lua54 'yes'
use_fxv2_oal 'yes'

description 'Player List'

version '1.0.0'

client_scripts {
    'config.lua',
    'client.lua'
}

server_scripts{
    "@vrp/lib/utils.lua",
    'server.lua'
}

ui_page 'html/ui.html'

files {
    'html/ui.html',
    'html/fonts/*.ttf',
    'html/css/*.css',
    'html/img/*.png',
    'html/js/*.js'
} 