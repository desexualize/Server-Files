

fx_version 'cerulean'
games { 'gta5' }



dependencies {
  "RageUI",
}

shared_scripts {
  '@AQUAPmc/import.lua',
  "cfg/*.lua",
  "cfg/drugs/*.lua"
}

client_scripts {
    "@RageUI/src/RMenu.lua",
    "@RageUI/src/menu/RageUI.lua",
    "@RageUI/src/menu/Menu.lua",
    "@RageUI/src/menu/MenuController.lua",
    "@RageUI/src/components/Audio.lua",
    "@RageUI/src/components/Rectangle.lua",
    "@RageUI/src/components/Screen.lua",
    "@RageUI/src/components/Sprite.lua",
    "@RageUI/src/components/Text.lua",
    "@RageUI/src/components/Visual.lua",
    "@RageUI/src/menu/elements/ItemsBadge.lua",
    "@RageUI/src/menu/elements/ItemsColour.lua",
    "@RageUI/src/menu/elements/PanelColour.lua",
    "@RageUI/src/menu/items/UIButton.lua",
    "@RageUI/src/menu/items/UICheckBox.lua",
    "@RageUI/src/menu/items/UIList.lua",
    "@RageUI/src/menu/items/UIProgress.lua",
    "@RageUI/src/menu/items/UISeparator.lua",
    "@RageUI/src/menu/items/UISlider.lua",
    "@RageUI/src/menu/items/UISliderHeritage.lua",
    "@RageUI/src/menu/items/UISliderProgress.lua",
    "@RageUI/src/menu/panels/UIColourPanel.lua",
    "@RageUI/src/menu/panels/UIGridPanel.lua",
    "@RageUI/src/menu/panels/UIGridPanelHorizontal.lua",
    "@RageUI/src/menu/panels/UIPercentagePanel.lua",
    "@RageUI/src/menu/panels/UIStatisticsPanel.lua",
    "@RageUI/src/menu/windows/UIHeritage.lua",
    "@AQUA/client/Tunnel.lua",
    "@AQUA/client/Proxy.lua",
    "@AQUA/lib/utils.lua",
    "client/*.lua",
    "client/drugs/*.lua",
}

server_scripts {
    "@AQUA/lib/utils.lua",
    "@mysql-async/lib/MySQL.lua",
    "modules/*.lua",
    "modules/drugs/*.lua",
    "modules/Flashbang.Server.net.dll",
}

ui_page {
  "ui/index.html",
}

files {
	"ui/index.html",
	"ui/assets/clignotant-droite.svg",
	"ui/assets/clignotant-gauche.svg",
	"ui/assets/feu-position.svg",
	"ui/assets/feu-route.svg",
	"ui/assets/fuel.svg",
	"ui/fonts/fonts/Roboto-Bold.ttf",
	"ui/fonts/fonts/Roboto-Regular.ttf",
	"ui/script.js",
	"ui/style.css",
	"ui/debounce.min.js",
  'html/js/app.js', 
  'html/css/style.css',
  'js/*.js',
  'html/*.html',
  'hssounds/*',
  "peds.meta",
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
  	"stream/**/*.ytyp",
  'audio/sfx/dlc_vinewood/casino_interior_stems.awc',
  'audio/sfx/dlc_vinewood/casino_slot_machines_01.awc',
  'audio/sfx/dlc_vinewood/casino_slot_machines_02.awc',
  'audio/sfx/dlc_vinewood/casino_slot_machines_03.awc',
  'audio/sfx/dlc_vinewood/*.awc',
}

exports {
  'DoShortHudText',
  'DoHudText',
  'DoLongHudText',
  'DoCustomHudText',
  'PersistentHudText',
  'GetFuel',
  'SetFuel',
}

data_file "PED_METADATA_FILE" "peds.meta"

data_file 'AUDIO_GAMEDATA' 'audio/dlcvinewood_game.dat'
data_file 'AUDIO_SOUNDDATA' 'audio/dlcvinewood_sounds.dat'
data_file 'AUDIO_DYNAMIXDATA' 'audio/dlcvinewood_mix.dat'
data_file 'AUDIO_SYNTHDATA' 'audio/dlcVinewood_amp.dat'
data_file 'AUDIO_SPEECHDATA' 'audio/dlcvinewood_speech.dat'
data_file 'AUDIO_WAVEPACK' 'audio/sfx/dlc_vinewood'
data_file 'WEAPONINFO_FILE_PATCH' 'weaponrevolver.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weaponcompactlauncher.meta'
data_file "PED_METADATA_FILE" "peds.meta"
data_file 'CARCOLS_FILE' 'data/carcols.meta'
data_file 'DLC_ITYP_REQUEST' 'stream/**/*.ytyp'
data_file "AUDIO_WAVEPACK" "dlc_hitmarkers"
data_file "AUDIO_SOUNDDATA" "data/audio/hitmarkers_sounds.dat"
data_file "CARCOLS_GEN9_FILE" "data/carcols_gen9.meta"
data_file "CARMODCOLS_GEN9_FILE" "data/carmodcols_gen9.meta"
data_file "DLC_POP_GROUPS" "data/popgroups.ymt"

data_file 'DLC_ITYP_REQUEST' 'stream/clamp.ytyp'


