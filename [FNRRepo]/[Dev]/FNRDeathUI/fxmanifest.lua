fx_version 'bodacious'
games { 'gta5' }

description "RP module/framework"

ui_page "ui/index.html"

-- client scripts
client_scripts{
    "@vrp/lib/utils.lua",
    "client/*.lua",
}

-- client files
files{
    "ui/*.ttf",
    "ui/*.woff",
    "ui/*.woff2",
    "ui/*.css",
    "ui/*.png",
    "ui/main.js",
    "ui/index.html",
    "images/*.png"
}

