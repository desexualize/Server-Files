



fx_version 'bodacious'
game 'gta5'

dependencies {
	'vrp'
}

ui_page "ui/index.html"

files {
	"ui/index.html",
	"ui/assets/chips.png",
	"ui/assets/hunger.png",
	"ui/assets/thirst.png",
	"ui/fonts/fonts/Circular-Bold.ttf",
	"ui/fonts/fonts/Circular-Bold.ttf",
	"ui/fonts/fonts/Circular-Regular.ttf",
	"ui/script.js",
	"ui/style.css",
	"ui/debounce.min.js"
}

client_scripts {
    "cl_casinochipui.lua",
}

server_scripts {
    "@vrp/lib/utils.lua",
    "server.lua",
}

