fx_version "adamant"
game "gta5"

name "mumble-voip"
description "A tokovoip replacement that uses fivems mumble voip"
author "Frazzle (frazzle9999@gmail.com)"
version "1.1"

ui_page "ui/index.html"

files {
	"ui/index.html",
	"ui/mic_click_on.ogg",
	"ui/mic_click_off.ogg",
	'ui/css/app.css',
	'ui/scripts/app.js'
}

client_scripts {
	'@zCore/cl_function.lua',
	'@zFramework/locale.lua',
	'locales/fr.lua',
	'client/classes/status.lua',
	"client/*.lua",
	"config.lua",
}

server_scripts {
	'@zFramework/locale.lua',
	'@mysql-async/lib/MySQL.lua',
	'locales/fr.lua',
	"server.lua",
	'server/sv_status.lua',
	'server/main.lua'
}

provide "tokovoip_script"