fx_version 'cerulean'
games {  'gta5' }

description "RP module/framework"

dependency "ghmattimysql"

ui_page "ui/index.html"

shared_scripts {
  "sharedcfg/*",
  "arma/cfg/cfg_*.lua",
  --"cfg/cfg_*.lua",
  "shared/*.lua",
}


-- client files
files{
  "cfg/client.lua",
  "cfg/cfg_*.lua",
  "cfg/weapons.lua",
  "cfg/skinshops.lua",
  "cfg/blips_markers.lua",
  "cfg/atms.lua",
  "ui/index.html",
  "ui/design.css",
  "ui/main.js",
  "ui/Menu.js",
  "ui/ProgressBar.js",
  "ui/WPrompt.js",
  "ui/RequestManager.js",
  "ui/AnnounceManager.js",
  "ui/Div.js",
  "ui/dynamic_classes.js",
  "ui/fonts/Pdown.woff",
  "ui/fonts/GTA.woff",
  'ui/sounds/*',
  "ui/index.css",
  "ui/index.js",
  "ui/SoundManager.js",
  "ui/pnc/js/index.js",
  "ui/pnc/js/vue.min.js",
  "ui/pnc/js/fine_types.js",
  "ui/pnc/css/index.css",
  "ui/pnc/css/modal.css",
  "ui/pnc/fonts/modes.ttf",
  "ui/pnc/img/tax.png",
  "ui/pnc/img/plates.png",
  "ui/playerlist_images/*.png",
  "ui/killfeed/img/*.png",
  "ui/killfeed/font/stratum2-bold-webfont.woff",
  "ui/killfeed/index.js",
  "ui/killfeed/style.css",
  "ui/pnc/components/*.js",
  "ui/pnc/components/*.html",
  "ui/progress/*",
  "ui/radios/index.js",
  "ui/radios/index.css",
  "ui/speedometer/index.js",
  "ui/speedometer/index.css",
  "cfg/peds.meta",
	'audio/dlcvinewood_amp.dat10',
	'audio/dlcvinewood_amp.dat10.nametable',
	'audio/dlcvinewood_amp.dat10.rel',
	'audio/dlcvinewood_game.dat151',
	'audio/dlcvinewood_game.dat151.nametable',
	'audio/dlcvinewood_game.dat151.rel',
	'audio/dlcvinewood_mix.dat15',
	'audio/dlcvinewood_mix.dat15.nametable',
	'audio/dlcvinewood_mix.dat15.rel',
	'audio/dlcvinewood_sounds.dat54',
	'audio/dlcvinewood_sounds.dat54.nametable',
	'audio/dlcvinewood_sounds.dat54.rel',
	'audio/dlcvinewood_speech.dat4',
	'audio/dlcvinewood_speech.dat4.nametable',
	'audio/dlcvinewood_speech.dat4.rel',
	'audio/sfx/dlc_vinewood/casino_general.awc',
	'audio/sfx/dlc_vinewood/casino_interior_stems.awc',
	'audio/sfx/dlc_vinewood/casino_slot_machines_01.awc',
	'audio/sfx/dlc_vinewood/casino_slot_machines_02.awc',
	'audio/sfx/dlc_vinewood/casino_slot_machines_03.awc',
	'audio/sfx/dlc_vinewood/*.awc',
  'cfg/hashes.json',
}


-- client scripts
client_scripts{
  "rageui/RMenu.lua",
	"rageui/menu/RageUI.lua",
	"rageui/menu/Menu.lua",
	"rageui/menu/MenuController.lua",
	"rageui/components/*.lua",
	"rageui/menu/elements/*.lua",
	"rageui/menu/items/*.lua",
	"rageui/menu/panels/*.lua",
	"rageui/menu/windows/*.lua",
  "lib/cl_mouse.lua",
  "lib/cl_thread.lua",
  "lib/cl_cache.lua",
  "lib/cl_util.lua",
  "lib/utils.lua",
  "client/Tunnel.lua",
  "client/Proxy.lua",
  "client/base.lua",
  "client/player_state.lua",
  "client/survival.lua",
  "client/admin.lua",
  "utils/cl_*.lua",
  "client/iplloader.lua",
  "client/cl_lscustomsmenu.lua",
  "client/gui.lua",
  "client/identity.lua",
  "client/admin.lua",
  "client/enumerators.lua",
  "client/inventory.lua",
  "client/clothing.lua",
  "client/atms.lua",
  "client/garages.lua",
  "client/adminmenu.lua",
  "client/LsCustomsMenu.lua",
  "client/LsCustoms.lua",
  "client/warningsystem.lua",
  "client/cl_*.lua",
  "cfg/client.lua",
}

-- server scripts
server_scripts{ 
  "lib/utils.lua",
  "base.lua",
  "modules/gui.lua",
  "modules/group.lua",
  "modules/admin.lua",
  "modules/survival.lua",
  "modules/player_state.lua",
  "modules/map.lua",
  "modules/inventory.lua",
  "modules/basic_items.lua",
  "modules/server_commands.lua",
  "modules/sv_*.lua",
  "servercfg/*.lua",
  "modules/webhooks.lua", 
  "cfg/discordroles.lua",
}

server_exports { 
	"GetDiscordRoles",
	"GetRoleIdFromRoleName",
	"GetDiscordAvatar",
	"GetDiscordName",
	"IsDiscordEmailVerified",
	"GetDiscordNickname",
	"GetGuildIcon",
	"GetGuildSplash",
	"GetGuildName",
	"GetGuildDescription",
	"GetGuildMemberCount",
	"GetGuildOnlineMemberCount",
	"GetGuildRoleList",
	"ResetCaches",
	"CheckEqual",
	"SetNickname",
}

data_file "PED_METADATA_FILE" "cfg/peds.meta"

data_file 'AUDIO_GAMEDATA' 'audio/dlcvinewood_game.dat'
data_file 'AUDIO_SOUNDDATA' 'audio/dlcvinewood_sounds.dat'
data_file 'AUDIO_DYNAMIXDATA' 'audio/dlcvinewood_mix.dat'
data_file 'AUDIO_SYNTHDATA' 'audio/dlcVinewood_amp.dat'
data_file 'AUDIO_SPEECHDATA' 'audio/dlcvinewood_speech.dat'
data_file 'AUDIO_WAVEPACK' 'audio/sfx/dlc_vinewood'