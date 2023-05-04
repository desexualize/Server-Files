resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

this_is_a_map 'yes'

files {
	"peds.meta",
	"weaponrevolver.meta",
	"data/carcols.meta",
	"data/ganjarimscontentunlocks.meta",
	"stream/**/*.ytyp",
	"dlc_hitmarkers/*.awc",
	"data/audio/hitmarkers_sounds.dat54.rel",
    "data/audio/hitmarkers_sounds.dat54.nametable",
	"data/carcols_gen9.meta",
    "data/carmodcols_gen9.meta",
	"data/popgroups.ymt",
	"ARMATexture_cache_y.dat"
}

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
