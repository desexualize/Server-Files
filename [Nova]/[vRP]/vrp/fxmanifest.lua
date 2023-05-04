fx_version "cerulean"
game "gta5"

description "RP module/framework"

dependencies {
	"oxmysql",
	"vrp_mysql",
}

ui_page "gui/index.html"

shared_scripts {
  	"sharedcfg/*.lua"
}

-- RageUI
client_scripts {
	"rageui/RMenu.lua",
	"rageui/menu/RageUI.lua",
	"rageui/menu/Menu.lua",
	"rageui/menu/MenuController.lua",
	"rageui/components/*.lua",
	"rageui/menu/elements/*.lua",
	"rageui/menu/items/*.lua",
	"rageui/menu/panels/*.lua",
	"rageui/menu/windows/*.lua"
}

-- server scripts
server_scripts {
	'modules/data_tables.lua',
	"lib/utils.lua",
	"lib/Housingutils.lua",
	"base.lua",
	"modules/gui.lua",
	"modules/group.lua",
	"modules/admin.lua",
	"modules/survival.lua",
	"modules/player_state.lua",
	"modules/map.lua",
	"modules/money.lua",
	"modules/inventory.lua",
	"modules/sv_drone",
	"modules/identity.lua",
	"modules/business.lua",
	"modules/item_transformer.lua",
	"modules/emotes.lua",
	"modules/police.lua",
	-- "modules/home.lua",
	-- "modules/home_components.lua",
	"modules/mission.lua",
	"modules/aptitude.lua",
	-- basic implementations
	-- "modules/basic_phone.lua",
	"modules/basic_atm.lua",
	"modules/basic_market.lua",
	--"modules/basic_gunshop.lua",
	"modules/basic_garage.lua",
	"modules/basic_items.lua",
	"modules/basic_skinshop.lua",
	"modules/cloakroom.lua",
	"modules/paycheck.lua",
	"modules/LsCustoms.lua",
	"modules/server_commands.lua",
	"modules/warningsystem.lua",
	-- "modules/sv_phone.lua",
	"modules/sv_tebex.lua",
	"modules/sv_dealership.lua",
	"modules/sv_armour.lua",
	"modules/sv_moneydrop.lua",
	"modules/sv_housing.lua",
	"modules/sv_*.lua",
	-- "modules/hotkeys.lua",
}

-- client scripts
client_scripts {
	"lib/cl_mouse.lua",
	"lib/cl_thread.lua",
	"lib/cl_cache.lua",
	"lib/utils.lua",
	"lib/Housingutils.lua",
	"utils/*",
	'cfg/item/*.lua',
	"cfg/cfg_homes.lua",
	"cfg/*.lua",
	'@Nova-Cars/garages.lua',
	"client/Tunnel.lua",
	"client/Proxy.lua",
	"client/base.lua",
	"client/iplloader.lua",
	"client/gui.lua",
	"client/player_state.lua",
	"client/survival.lua",
	"client/map.lua",
	"client/identity.lua",
	"client/basic_garage.lua",
	"client/lockcar-client.lua",
	"client/admin.lua",
	"client/enumerators.lua",
	"client/inventory.lua",
	"client/clothing.lua",
	"client/atms.lua",
	"client/cl_drone",
	"client/garages.lua",
	"client/adminmenu.lua",
	"client/LsCustomsMenu.lua",
	"client/LsCustoms.lua",
	"client/warningsystem.lua",
	"client/lootbags.lua",
	"client/No-clip.lua",
	"client/Instructional_Buttons.lua",
	-- "client/cl_phone.lua",
	"client/cl_dealership.lua",
	"client/cl_moneydrop.lua",
	"client/cl_housing.lua",
	"client/cl_*.lua",
	-- "hotkeys/hotkeys.lua",
}

shared_scripts {
	-- Dutymenu Shared Files
	'factions/dutymenu/cfg_dutymenu.lua',

	-- LFB Shared Files

	-- NHS Shared Files

	-- HMP Shared Files

	-- MPD Shared Files
	'factions/mpd/cfg_mpd.lua',
}

client_scripts {
	-- Dutymenu Client Files
	'factions/dutymenu/cl_dutymenu.lua',

	-- Traffic Menu Client Files
	'factions/trafficmenu/cl_trafficmenu.lua',

	-- Callsigns Client Files
	'factions/callsigns/cl_callsigns.lua',

	-- LFB Client Files
	'factions/lfb/cl_lfb.lua',

	-- NHS Client Files
	'factions/nhs/cl_nhs.lua',

	-- MPD Client Files
	'factions/mpd/cl_police.lua',
	'factions/mpd/cl_policemenu.lua',
	'factions/mpd/cl_policearmoury.lua',
	
	-- HMP Client Files
	'factions/hmp/cl_hmp.lua',
}

server_scripts {
	-- Dutymenu Server Files
	'factions/dutymenu/sv_forceclock.lua',
	'factions/dutymenu/sv_dutymenu.lua',

	-- Faction Hour Files
	'factions/factionhours/cfg_factionhours.lua',
	'factions/factionhours/sv_factionhours.lua',

	-- Traffic Menu Files
	'factions/trafficmenu/sv_trafficmenu.lua',

	-- Callsigns Server Files
	'factions/callsigns/sv_callsigns.lua',

	-- LFB Server Files

	-- NHS Server Files

	-- HMP Server Files

	-- MPD Server Files
	'factions/mpd/sv_policemenu.lua',
	'factions/mpd/sv_policearmoury.lua',
	--'factions/mpd/sv_police.lua', -- Default VRP Shit
	--'factions/mpd/sv_police2.lua', -- Default VRP Shit
}

-- client files
files {
	"cfg/client.lua",
	"lib/HousingTunnel.lua",
	"gui/index.html",
	"gui/design.css",
	"gui/main.js",
	"gui/Menu.js",
	"gui/ProgressBar.js",
	"gui/WPrompt.js",
	"gui/RequestManager.js",
	"gui/AnnounceManager.js",
	"gui/Div.js",
	"gui/dynamic_classes.js",
	"gui/fonts/Pdown.woff",
	"gui/fonts/GTA.woff",
	'@Nova-Core/stream/vehicle.ytd',
}