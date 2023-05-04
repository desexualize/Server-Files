
fx_version 'cerulean'
games {  'gta5' }

description "AQUA MySQL async - Modified Version"
dependency "ghmattimysql"
-- server scripts
server_scripts{ 
  "@AQUA/lib/utils.lua",
  "MySQL.lua"
}

