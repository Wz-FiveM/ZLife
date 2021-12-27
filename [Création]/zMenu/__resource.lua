resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

ui_page 'html/index.html'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@zFramework/locale.lua',
	'locales/fr.lua',
	'config.lua',
	'server/main.lua',
	'server/sv_lscus.lua',
	'sv_idcard.lua',
}

client_scripts {
	"dependencies/Wrapper/Utility.lua",
	
	"dependencies/UIElements/UIVisual.lua",
	"dependencies/UIElements/UIResRectangle.lua",
	"dependencies/UIElements/UIResText.lua",
	"dependencies/UIElements/Sprite.lua",

	"dependencies/UIMenu/elements/Badge.lua",
	"dependencies/UIMenu/elements/Colours.lua",
	"dependencies/UIMenu/elements/StringMeasurer.lua",
	"dependencies/UIMenu/items/UIMenuItem.lua",
	"dependencies/UIMenu/items/UIMenuCheckboxItem.lua",
	"dependencies/UIMenu/items/UIMenuListItem.lua",
	"dependencies/UIMenu/UIMenu.lua",
	"dependencies/UIMenu/MenuPool.lua",

	"dependencies/NativeUI.lua",
}

client_scripts {
	'@zFramework/locale.lua',
	'@zCore/cl_function.lua',
	'locales/fr.lua',
	'config.lua',
	'cl_idcard.lua',
	'client/*.lua',
	'other/*.lua',
}


files {
	'html/index.html',
	'html/assets/css/style.css',
	'html/assets/js/jquery.js',
	'html/assets/js/init.js',
	'html/assets/fonts/roboto/Roboto-Bold.woff',
	'html/assets/fonts/roboto/Roboto-Bold.woff2',
	'html/assets/fonts/roboto/Roboto-Light.woff',
	'html/assets/fonts/roboto/Roboto-Light.woff2',
	'html/assets/fonts/roboto/Roboto-Medium.woff',
	'html/assets/fonts/roboto/Roboto-Medium.woff2',
	'html/assets/fonts/roboto/Roboto-Regular.woff',
	'html/assets/fonts/roboto/Roboto-Regular.woff2',
	'html/assets/fonts/roboto/Roboto-Thin.woff',
	'html/assets/fonts/roboto/Roboto-Thin.woff2',
	'html/assets/fonts/justsignature/JustSignature.woff',
	'html/assets/css/materialize.min.css',
	'html/assets/js/materialize.js',
	'html/assets/images/idcard.png',
	'html/assets/images/license.png',
	'html/assets/images/firearm.png',
	'html/assets/images/male.png',
	'html/assets/images/female.png',
}