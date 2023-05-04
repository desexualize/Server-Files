
description "vRP MySQL async - Modified Version"
dependency "ghmattimysql"
-- server scripts
server_scripts{ 
  "@BW/lib/utils.lua",
  "MySQL.lua"
}

