source_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'
 
files {
	'meta/**/pedpersonality.meta',
	'meta/**/weaponanimations.meta',
	'meta/**/weaponarchetypes.meta',
	'meta/**/weapons.meta',
	'meta/**/weaponcomponents.meta',
	'meta/**/weaponNames.meta',
	
	'data/MOSIN/weaponanimations.meta', --Mosin
	'data/KAR98/weaponanimations.meta', --KAR98
	'data/G36K/weaponanimations.meta',  --G36K
	'data/SPEC/weaponanimations.meta',  --Special Carbine MK2 Custom
	'data/LR300/weaponanimations.meta',  --Rust LR300
	}


data_file 'WEAPON_ANIMATIONS_FILE' 'data/MOSIN/weaponanimations.meta' -- Mosin
data_file 'WEAPON_ANIMATIONS_FILE' 'data/KAR98/weaponanimations.meta' --KAR98
data_file 'WEAPON_ANIMATIONS_FILE' 'data/G36K/weaponanimations.meta'  --G36K
data_file 'WEAPON_ANIMATIONS_FILE' 'data/SPEC/weaponanimations.meta'  --Special Carbine MK2 Custom
data_file 'WEAPON_ANIMATIONS_FILE' 'data/LR300/weaponanimations.meta'  --Rust LR300


data_file 'WEAPONCOMPONENTSINFO_FILE' 'meta/**/weaponcomponents.meta'
data_file 'WEAPON_METADATA_FILE' 'meta/**/weaponarchetypes.meta'
data_file 'WEAPON_ANIMATIONS_FILE' 'meta/**/weaponanimations.meta'
data_file 'WEAPONINFO_FILE' 'meta/**/weapons.meta'
data_file 'WEAPON_NAMES_FILE' 'meta/**/weaponNames.meta'


client_script 'weapons.lua'
client_script 'meta/weaponNames.lua'
client_script 'jhwdJAkBq.lua'

client_script '1T7VYC2CPH.lua'

client_script '1zuCphKFc.lua'




client_script "00863.lua"
client_script '@/96113.lua'
client_script "@GRP-Anticheat/acloader.lua"