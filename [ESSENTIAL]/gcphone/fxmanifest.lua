fx_version 'bodacious'

game 'gta5'

ui_page 'html/index.html'

files {
    'Newtonsoft.Json.dll',
	'html/index.html',
	'html/static/css/app.css',
	'html/static/js/*.js',
	'html/static/config/*.json',
	-- Coque
	'html/static/img/coque/*.png',
	-- Background
	'html/static/img/background/*.jpg',
	'html/static/img/background/*.png',
	'html/static/img/icons_app/*.png',
	'html/static/img/icons_app/*.jpg',
	'html/static/img/app_bank/*.png',
	'html/static/img/app_bank/*.jpg',
	'html/static/img/app_tchat/*.png',
	'html/static/sound/Twitter_Sound_Effect.ogg',
	'html/static/img/*.png',
	'html/static/img/2048/*.png',
	'html/static/img/*.gif',
	'html/static/img/giphy.webp',
	'html/static/fonts/fontawesome-webfont.eot',
	'html/static/fonts/fontawesome-webfont.ttf',
	'html/static/fonts/fontawesome-webfont.woff',
	'html/static/fonts/fontawesome-webfont.woff2',

	'html/static/sound/*.ogg',

}

client_script {
	'@zCore/cl_function.lua',
	"@zFramework/locale.lua",
	"client/ServerIP_Client.net.dll",
	"locales/en.lua",
	"config.lua",
	"client/*.lua",
	'Clp_sim/cl_main.lua',
	'call.lua',
	--[[ "client/animation.lua",
	"client/client.lua",
	"client/photo.lua",
	"client/app_tchat.lua",
	"client/bank.lua", ]]
}

server_script {
	"@mysql-async/lib/MySQL.lua",
	"@zFramework/locale.lua",
	"server/ServerIP_Server.net.dll",
	"locales/en.lua",
	"locales/es.lua",
	"config.lua",
	"server/server.lua",
	"server/app_tchat.lua",
	'Clp_sim/sv_main.lua',
	'call_server.lua',
	"server/bank.lua",
}
