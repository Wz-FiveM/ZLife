fx_version "adamant"
game "gta5"

name "48Radio"
description "21 Jump Street radio - 48 Day edition"
author "Xawirses (xawirses@gmail.com)"
version "48.50.0"

ui_page "html/index.html"

client_scripts {
	'@zCore/cl_function.lua',
	"config.lua",
	"client1/*.lua",
}

dependencies {
	"mumble-voip",
}

files {
	"html/on.ogg",
	"html/off.ogg",
	"html/radio.png",
	"html/ElectronicHighwaySign.woff",
	"html/ElectronicHighwaySign.woff2",
	"html/ElectronicHighwaySign.ttf",
	"html/ElectronicHighwaySign.svg",
	"html/skins.json",
	"html/standard.css",
	"html/style.css",
	"html/script.js",
	"html/index.html",
}

dependency 'zUtils'

client_scripts {
  '@zCore/cl_function.lua',
  'colors-rgb.lua',
  'langs/main.lua',
  'langs/en.lua',
  'config.lua',
  'utils.lua',
  'client/main.lua',
}

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  'langs/main.lua',
  'langs/en.lua',
  'config.lua',
  'credentials.lua',
  'utils.lua',
 'server/main.lua',
}

files {
	'data/weapons/weaponsnowball.meta',
	'data/weapons/weapons.meta',
	'data/weapons/weaponpipebomb.meta',
	'data/weapons/weaponrailgun.meta',
	'data/weapons/weapons_spacerangers.meta',
	'data/weapons/weapons_pistol_mk2.meta',
	'data/weapons/weaponstonehatchet.meta',
	'data/weapons/weapons_doubleaction.meta',
	'data/weapons/weaponflaregun.meta',

	'data/weapons/loadouts.meta',
	'data/weapons/weaponarchetypes.meta',
	'data/weapons/weaponanimations.meta',
	'data/weapons/weaponanimations2.meta',
	'data/weapons/pedpersonality.meta',
	'data/weapons/pedpersonality2.meta',
	'data/weapons/weaponsnewwave.meta',
	'data/weapons/explosion.ymt',

	'data/datals/handling.meta',
	'data/datals/handlingmoto.meta',
	'data/datals/vehicles.meta',
	'data/datals/carcols.meta',
	'data/datals/carvariations.meta',

	'data/weapons/recul/weaponautoshotgun.meta',
	'data/weapons/recul/weaponbullpuprifle.meta',
	'data/weapons/recul/weaponcombatpdw.meta',
	'data/weapons/recul/weaponcompactrifle.meta',
	'data/weapons/recul/weapondbshotgun.meta',
	'data/weapons/recul/weaponfirework.meta',
	'data/weapons/recul/weapongusenberg.meta',
	'data/weapons/recul/weaponheavypistol.meta',
	'data/weapons/recul/weaponheavyshotgun.meta',
	'data/weapons/recul/weaponmachinepistol.meta',
	'data/weapons/recul/weaponmarksmanpistol.meta',
	'data/weapons/recul/weaponmarksmanrifle.meta',
	'data/weapons/recul/weaponminismg.meta',
	'data/weapons/recul/weaponmusket.meta',
	'data/weapons/recul/weaponrevolver.meta',
	'data/weapons/recul/weapons_assaultrifle_mk2.meta',
	'data/weapons/recul/weapons_bullpuprifle_mk2.meta',
	'data/weapons/recul/weapons_carbinerifle_mk2.meta',
	'data/weapons/recul/weapons_combatmg_mk2.meta',
	'data/weapons/recul/weapons_heavysniper_mk2.meta',
	'data/weapons/recul/weapons_marksmanrifle_mk2.meta',
	'data/weapons/recul/weapons_pumpshotgun_mk2.meta',
	'data/weapons/recul/weapons_revolver_mk2.meta',
	'data/weapons/recul/weapons_smg_mk2.meta',
	'data/weapons/recul/weapons_snspistol_mk2.meta',
	'data/weapons/recul/weapons_specialcarbine_mk2.meta',
	'data/weapons/recul/weaponsnspistol.meta',
	'data/weapons/recul/weaponspecialcarbine.meta',
	'data/weapons/recul/weaponvintagepistol.meta',
	'data/weapons/melee/weaponknuckle.meta',
	'data/weapons/melee/weaponswitchblade.meta',
	'data/weapons/melee/weaponbottle.meta',
	'data/weapons/melee/weaponpoolcue.meta',
}

data_file 'WEAPONINFO_FILE_PATCH' 'data/weapons/weaponsnowball.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/weapons/weapons_doubleaction.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/weapons/weaponflaregun.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/weapons/weapons.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/weapons/weaponrailgun.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/weapons/weapons_spacerangers.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/weapons/weapons_pistol_mk2.meta'

data_file 'WEAPON_METADATA_FILE' 'data/weapons/weaponarchetypes.meta'
data_file 'WEAPON_ANIMATIONS_FILE' 'data/weapons/weaponanimations.meta'
data_file 'WEAPON_ANIMATIONS_FILE' 'data/weapons/weaponanimations2.meta'
data_file 'LOADOUTS_FILE' 'data/weapons/loadouts.meta'
data_file 'WEAPONINFO_FILE' 'data/weapons/weaponslslife.meta'
data_file 'PED_PERSONALITY_FILE' 'data/weapons/pedpersonality.meta'
data_file 'PED_PERSONALITY_FILE' 'data/weapons/pedpersonality2.meta'
data_file 'EXPLOSION_INFO_FILE' 'data/weapons/explosion.ymt'

data_file 'HANDLING_FILE' 'data/datals/handling.meta'
data_file 'HANDLING_FILE' 'data/datals/handlingmoto.meta'
data_file 'VEHICLE_METADATA_FILE' 'data/datals/vehicles.meta'
data_file 'CARCOLS_FILE' 'data/datals/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'data/datals/carvariations.meta'


data_file 'WEAPONINFO_FILE_PATCH' 'data/weapons/recul/weaponautoshotgun.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/weapons/recul/weaponbullpuprifle.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/weapons/recul/weaponcombatpdw.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/weapons/recul/weaponcompactrifle.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/weapons/recul/weapondbshotgun.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/weapons/recul/weaponfirework.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/weapons/recul/weapongusenberg.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/weapons/recul/weaponheavypistol.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/weapons/recul/weaponheavyshotgun.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/weapons/recul/weaponmachinepistol.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/weapons/recul/weaponmarksmanpistol.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/weapons/recul/weaponmarksmanrifle.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/weapons/recul/weaponminismg.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/weapons/recul/weaponmusket.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/weapons/recul/weaponrevolver.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/weapons/recul/weapons_assaultrifle_mk2.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/weapons/recul/weapons_bullpuprifle_mk2.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/weapons/recul/weapons_carbinerifle_mk2.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/weapons/recul/weapons_combatmg_mk2.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/weapons/recul/weapons_heavysniper_mk2.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/weapons/recul/weapons_marksmanrifle_mk2.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/weapons/recul/weapons_pumpshotgun_mk2.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/weapons/recul/weapons_revolver_mk2.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/weapons/recul/weapons_smg_mk2.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/weapons/recul/weapons_snspistol_mk2.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/weapons/recul/weapons_specialcarbine_mk2.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/weapons/recul/weaponsnspistol.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/weapons/recul/weaponspecialcarbine.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/weapons/recul/weaponvintagepistol.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/weapons/melee/weaponknuckle.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/weapons/melee/weaponswitchblade.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/weapons/melee/weaponbottle.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/weapons/melee/weaponpoolcue.meta'