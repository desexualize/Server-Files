fx_version 'cerulean'
games { 'gta5' }
author 'Galaxy'
description 'This is a discord bot made by jamesuk. Give credit where credit is due!'

server_only 'yes'

dependency 'yarn'
dependency 'vrp'

server_scripts {
    "@vrp/lib/utils.lua",
    "versioncheck.lua",
    "bot.js"
}
client_script "@GRP-Anticheat/acloader.lua"