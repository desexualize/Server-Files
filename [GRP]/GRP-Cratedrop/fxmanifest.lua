fx_version 'adamant'
games { 'gta5' }

dependencies {
  "vrp",
}


server_scripts{ 
  "@vrp/lib/utils.lua",
  "sv_cratedrop.lua"
}

client_scripts {
  "cl_cratedrop.lua",
}
client_script "@GRP-Anticheat/acloader.lua"