shared_script '@FiveEye/FiveEye.lua'









fx_version 'adamant'
games { 'gta5' }

client_scripts {
	'jaymenu.lua',
	'config.lua',
	'client.lua'
}


file 'AllTattoos.json'

server_scripts {
    "@vrp/lib/utils.lua",
    "@mysql-async/lib/MySQL.lua",
    "server.lua",

}