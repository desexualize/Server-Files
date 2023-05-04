fx_version "bodacious"
games { "gta5" }

lua54 "yes"
is_cfxv2 "yes"
use_fxv2_oal "yes"

files {
	"dlc_xsirens/xsirens_one.awc",
	"dlc_xvehicles/*.awc",
	"dlc_alarm/alarmpack_one.awc",
	"data/xsirens_sounds.dat54.nametable",
	"data/xsirens_sounds.dat54.rel",
	"data/xvehicles_sounds.dat54.nametable",
	"data/xvehicles_sounds.dat54.rel",
	"data/xvehicles_game.dat151.nametable",
	"data/xvehicles_game.dat151.rel",
	"data/dlcalarm_sounds.dat54.nametable",
	"data/dlcalarm_sounds.dat54.rel",
	"dlc_security/siren_one.awc",
	"data/dlcsecurity_sounds.dat54.nametable",
	"data/dlcsecurity_sounds.dat54.rel",
	"data/dlc_armaheist_sounds.dat54.rel",
	"dlc_armaheist/glass_break.awc",
	"dlc_elsaudio/elsaudio_one.awc",
    "data/elsaudio_sounds.dat54.rel",
    "data/elsaudio_sounds.dat54.nametable",
	"dlc_halloween/halloween.awc",
    "data/halloween_sounds.dat54.rel",
    "data/halloween_sounds.dat54.nametable",
}

data_file "AUDIO_WAVEPACK" "dlc_xsirens"
data_file "AUDIO_SOUNDDATA" "data/xsirens_sounds.dat"
data_file "AUDIO_WAVEPACK" "dlc_xvehicles"
data_file "AUDIO_SOUNDDATA" "data/xvehicles_sounds.dat"
data_file "AUDIO_GAMEDATA" "data/xvehicles_game.dat"
data_file "AUDIO_WAVEPACK" "dlc_alarm"
data_file "AUDIO_SOUNDDATA" "data/dlcalarm_sounds.dat"
data_file "AUDIO_WAVEPACK" "dlc_security"
data_file "AUDIO_WAVEPACK"  "dlc_armaheist"
data_file "AUDIO_SOUNDDATA" "data/dlc_armaheist_sounds.dat"
data_file "AUDIO_WAVEPACK" "dlc_elsaudio"
data_file "AUDIO_SOUNDDATA" "data/elsaudio_sounds.dat"
data_file "AUDIO_WAVEPACK" "dlc_halloween"
data_file "AUDIO_SOUNDDATA" "data/halloween_sounds.dat"

files { "config.json", "patterns/*.json", "xmls/vcfs.json", "xmls/vcf/*.xml" }
client_scripts { "shared/events.lua", "client/*.lua" }
server_scripts { "shared/events.lua", "server/*.lua" }
