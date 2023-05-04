fx_version 'cerulean'
game 'gta5'

dependencies {
	"vrp",
	'rprogress',
}

server_scripts{ 
	"@vrp/lib/utils.lua",
	"sv_cratedrop.lua",
}

client_script 'cl_cratedrop.lua'