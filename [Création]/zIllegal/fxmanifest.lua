fx_version 'adamant'
games { 'gta5' };

--this_is_a_map 'yes'

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    '@zFramework/locale.lua',
    "config.lua",
    "sv_bra.lua",
    "sv_drugs.lua",
    "sv_house.lua",
    --"sv_event.lua",
    "sv_mission.lua",
    --"source/fuel_server.lua",
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
}

client_scripts {
    '@zFramework/locale.lua',
    '@zCore/cl_function.lua',
    '@zPmenu/pmenu.lua',
    "config.lua",
    'utils/*.lua',
    "safeCracking.lua",
    --"source/fuel_client.lua",
}

data_file 'DLC_ITYP_REQUEST' 'stream/v_int_shop.ytyp'

files {
 'stream/v_int_shop.ytyp'
}

data_file 'FIVEM_LOVES_YOU_341B23A2F0E0F131' 'data/circulation/popgroups.ymt'
data_file 'POPSCHED_FILE' 'data/circulation/popcycle.dat'
data_file 'VEHICLE_METADATA_FILE' 'data/circulation/vehicles.meta'

files {
	'data/circulation/popgroups.ymt',
	'data/circulation/popcycle.dat',
	'data/circulation/vehicles.meta',
}

files {
	"bundle.js",
	"main.js",
	"ui.html"
}

ui_page "ui.html"