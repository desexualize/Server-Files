fx_version "adamant"
game "gta5"

ui_page "ui/ui.html"

shared_scripts {
    '@AQUAPmc/import.lua',
}

files {
    "ui/*"
}

client_scripts {
    "client/*.lua"
}

server_scripts {
    "svconfig.lua",
    "server/*"
}
