fx_version 'adamant'
game 'gta5'

ui_page "ui/index.html"
client_scripts {
    "cl_*.lua",
}

server_scripts {
    "@vrp/lib/utils.lua",
    "sv_*.lua",
}

files {
	"ui/index.html",
	"ui/assets/bank.png",
	"ui/assets/cash.png",
	"ui/fonts/fonts/Circular-Bold.ttf",
	"ui/fonts/fonts/Circular-Bold.ttf",
	"ui/fonts/fonts/Circular-Regular.ttf",
	"ui/script.js",
	"ui/style.css",
	"ui/debounce.min.js",
}
