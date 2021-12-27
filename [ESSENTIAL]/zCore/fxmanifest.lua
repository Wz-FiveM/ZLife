fx_version 'adamant'
game 'gta5'

dependency 'essentialmode'

server_scripts {
	'@async/async.lua',
	'@mysql-async/lib/MySQL.lua',
	'@zFramework/locale.lua',
	'locales/fr.lua',
	'config.lua',
	'sv_license.lua',
	'sv_datastore.lua',
	'sv_addoninv.lua',
	'sv_addonaccount.lua',
	'classes/*.lua',
	--'sv_society.lua',
	'sv_maxplayer.lua',
	'sv_admin.lua',
	'sv_facture.lua',
}

client_scripts {
	'@zFramework/locale.lua',
	'locales/fr.lua',
	'config.lua',
	'cl_billing.lua',
	--'cl_society.lua',
	'cl_maxplayer.lua',
	'cl_admin.lua',
	'cl_function.lua',
	'cl_facture.lua',
}
server_scripts {
	'@async/async.lua',
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'FiveMBanSql/config.lua',
	'FiveMBanSql/server/function.lua',
	'FiveMBanSql/server/main.lua',
}

client_scripts {
  'FiveMBanSql/client.lua'
}

data_file 'CARCOLS_FILE' 'data/nice/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'data/nice/vehicles.meta'
data_file 'HANDLING_FILE' 'data/nice/handling.meta'
data_file 'VEHICLE_VARIATION_FILE' 'data/nice/carvariations.meta'


files {
	'data/nice/carcols.meta',
	'data/nice/vehicles.meta',
	'data/nice/carvariations.meta',
	'data/nice/handling.meta',

	-- Cloth stuff
	"data/data/first_person.meta",
	"data/data/first_person_alternates.meta",
	"data/data/first_person.meta",
	"data/data/pedalternatevariations.meta",
	"data/data/mpvinewood_overlays.xml",
	"data/data/overlayinfo.xml"
}


files {
}

data_file "ALTERNATE_VARIATIONS_FILE" "data/data/pedalternatevariations.meta"
data_file "PED_FIRST_PERSON_ALTERNATE_DATA" "data/data/first_person_alternates.meta"
data_file "PED_FIRST_PERSON_ASSET_DATA" "data/data/first_person.meta"
data_file "PED_OVERLAY_FILE" "data/data/mpVinewood_overlays.xml"


files {
	'data/new_overlays.xml',
	'data/shop_tattoo.meta'
}

data_file 'PED_OVERLAY_FILE' 'data/new_overlays.xml'
data_file 'TATTOO_SHOP_DLC_FILE' 'data/shop_tattoo.meta'

client_scripts {
	'@zFramework/locale.lua',
	'@zCore/cl_function.lua',
	'@zPmenu/pmenu.lua',
	--"@NativeUI/NativeUI.lua",
	"NativeUI.lua",
	'locales/fr.lua',
	'config.lua',
	--'cl_accessories.lua',
	'cl_clothes.lua',
	'cl_tatoo.lua',
	'list_tatoo.lua',
	--'cl_cardealer.lua',
	--'utils_cardealer.lua',
	'cl_skin.lua',
	'cl_skinchanger.lua',
	'cl_identity.lua',
	
}

server_scripts {
	'@zFramework/locale.lua',
	'@mysql-async/lib/MySQL.lua',
	'locales/fr.lua',
	'config.lua',
	'sv_tatoo.lua',
	'sv_accessories.lua',
	'sv_clothes.lua',
	--'sv_cardealer.lua',
	'sv_skin.lua',
	'sv_identity.lua',
}