fx_version 'adamant'
games { 'gta5' };

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    '@zFramework/locale.lua',
    'locales/fr.lua',
    "server/*.lua",
    "config.lua",
}

client_scripts {
	'@zFramework/locale.lua',
	'@zCore/cl_function.lua',
    'locales/fr.lua',
	"client/*.lua",
    "config.lua",
}