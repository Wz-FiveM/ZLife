fx_version 'adamant'
games { 'gta5' };

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@zFramework/locale.lua',
	'@zFramework/locales/fr.lua',
	'locales/fr.lua',
	'config.lua',
	'server/*.lua',
	'persistent_sv/main.lua',
}

client_scripts {
	'@zFramework/locale.lua',
	'@zFramework/locales/fr.lua',
	'@zCore/cl_function.lua',
	'@zPmenu/pmenu.lua',
	'locales/fr.lua',
	'config.lua',
	'client/*.lua',
	'persistent_cl/*.lua',
	--[[ 'persistent_cl/_utils.lua',
	'persistent_cl/main.lua', ]]
}

ui_page "html/warrants_list.html"

files {
    'html/css/images/ui-bg_glass_55_fbf9ee_1x400.png',
	'html/css/images/ui-bg_glass_65_ffffff_1x400.png',
	'html/css/images/ui-bg_glass_75_dadada_1x400.png',
	'html/css/images/ui-bg_glass_75_e6e6e6_1x400.png',
	'html/css/images/ui-bg_glass_95_fef1ec_1x400.png',
	'html/css/images/ui-bg_highlight-soft_75_cccccc_1x100.png',
	'html/css/images/ui-icons_2e83ff_256x240.png',
	'html/css/images/ui-icons_222222_256x240.png',
	'html/css/images/ui-icons_454545_256x240.png',
	'html/css/images/ui-icons_888888_256x240.png',
	'html/css/images/ui-icons_cd0a0a_256x240.png',
	'html/css/jquery-ui.css',
	'html/js/jquery-ui.min.js',
	'html/script.js',
	'html/js/angular.min.js',
	"html/warrants_list.html",
	"html/bootstrap/css/bootstrap.css",
	"html/bootstrap/css/bootstrap.min.css",
	"html/bootstrap/fonts/glyphicons-halflings-regular.eot",
	"html/bootstrap/fonts/glyphicons-halflings-regular.svg",
	"html/bootstrap/fonts/glyphicons-halflings-regular.ttf",
	"html/bootstrap/fonts/glyphicons-halflings-regular.woff",
	"html/bootstrap/fonts/glyphicons-halflings-regular.woff2",
	"html/bootstrap/js/bootstrap.js",
	"html/bootstrap/js/bootstrap.min.js",
	"html/css/local.css",
	"html/js/jquery-1.10.2.min.js",
	"html/js/shieldui-all.min.js",
	'html/font-awesome/css/font-awesome.min.css',
	'html/font-awesome/css/font-awesome.css',
	'html/font-awesome/fonts/FontAwesome.otf',
	'html/font-awesome/fonts/fontawesome-webfont.eot',
	'html/font-awesome/fonts/fontawesome-webfont.svg',
	'html/font-awesome/fonts/fontawesome-webfont.ttf',
	'html/font-awesome/fonts/fontawesome-webfont.woff',
	'html/font-awesome/fonts/fontawesome-webfont.woff2'
}

server_scripts {
	'@async/async.lua',
	'@mysql-async/lib/MySQL.lua',
	'@zFramework/locale.lua',
	'locales/fr.lua',
	'config.lua',
	'sv_garagevole.lua',
	'sv_jobs.lua'
	-- 'serverp/sv_garage.lua',
	-- 'serverp/sv_property.lua',
	-- 'serverp/sv_instance.lua',
}
client_scripts {
	'@zFramework/locale.lua',
	'locales/fr.lua',
	'config.lua',
	-- 'clientp/*.lua',
}
client_scripts {
    "src/RMenu.lua",
    "src/menu/RageUI.lua",
    "src/menu/Menu.lua",
    "src/menu/MenuController.lua",
    "src/components/*.lua",
    "src/menu/elements/*.lua",
    "src/menu/items/*.lua",
    "src/menu/panels/*.lua",
    "src/menu/panels/*.lua",
    "src/menu/windows/*.lua",
    "cl_garagevole.lua",
}
client_scripts {
	"@zCore/cl_function.lua",
	"venteOccase/NativeUI.lua",
	"venteOccase/configVente.lua",
	"venteOccase/client/*.lua",
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	"venteOccase/configVente.lua",
	"venteOccase/server/main.lua"
}

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

data_file 'CARCOLS_FILE' 'data/nice/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'data/nice/vehicles.meta'
data_file 'HANDLING_FILE' 'data/nice/handling.meta'
data_file 'VEHICLE_VARIATION_FILE' 'data/nice/carvariations.meta'

data_file "ALTERNATE_VARIATIONS_FILE" "data/data/pedalternatevariations.meta"
data_file "PED_FIRST_PERSON_ALTERNATE_DATA" "data/data/first_person_alternates.meta"
data_file "PED_FIRST_PERSON_ASSET_DATA" "data/data/first_person.meta"
data_file "PED_OVERLAY_FILE" "data/data/mpVinewood_overlays.xml"

files {
	'data/vehicles.meta',
	'data/carcols.meta',
	'data/carvariations.meta',
}

data_file 'VEHICLE_METADATA_FILE' 'data/vehicles.meta'
data_file 'CARCOLS_FILE' 'data/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'data/carvariations.meta'

client_script 'data/vehicle_names.lua'